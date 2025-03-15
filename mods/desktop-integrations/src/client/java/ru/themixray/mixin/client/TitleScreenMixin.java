package ru.themixray.mixin.client;

import net.minecraft.SharedConstants;
import net.minecraft.client.MinecraftClient;
import net.minecraft.client.gui.*;
import net.minecraft.client.gui.screen.Screen;
import net.minecraft.client.gui.screen.SplashTextRenderer;
import net.minecraft.client.gui.screen.TitleScreen;
import net.minecraft.client.gui.screen.multiplayer.MultiplayerScreen;
import net.minecraft.client.gui.screen.multiplayer.MultiplayerWarningScreen;
import net.minecraft.client.gui.screen.option.OptionsScreen;
import net.minecraft.client.gui.screen.world.SelectWorldScreen;
import net.minecraft.client.gui.tooltip.Tooltip;
import net.minecraft.client.gui.widget.ButtonWidget;
import net.minecraft.client.realms.gui.screen.RealmsMainScreen;
import net.minecraft.client.resource.language.I18n;
import net.minecraft.text.Text;
import net.minecraft.util.Util;
import net.minecraft.util.math.MathHelper;
import org.jetbrains.annotations.Nullable;
import org.spongepowered.asm.mixin.Final;
import org.spongepowered.asm.mixin.Mixin;
import org.spongepowered.asm.mixin.Shadow;
import org.spongepowered.asm.mixin.injection.At;
import org.spongepowered.asm.mixin.injection.Inject;
import org.spongepowered.asm.mixin.injection.callback.CallbackInfo;
import org.spongepowered.asm.mixin.injection.callback.CallbackInfoReturnable;
import ru.themixray.DesktopIntegrations;

import java.io.IOException;
import java.lang.reflect.Field;

@Mixin(TitleScreen.class)
public abstract class TitleScreenMixin extends Screen {
    @Shadow protected abstract void setWidgetAlpha(float alpha);

    @Shadow protected abstract boolean isRealmsNotificationsGuiDisplayed();

    @Shadow private long backgroundFadeStart;

    @Shadow private boolean doBackgroundFade;

    @Shadow private float backgroundAlpha;

    @Shadow @Final private LogoDrawer logoDrawer;

    @Shadow private @Nullable SplashTextRenderer splashText;

    protected TitleScreenMixin(Text title) {
        super(title);
    }

    @Inject(at = @At("TAIL"), method = "init")
    private void init(CallbackInfo ci) {
        ButtonWidget last = (ButtonWidget) children().get(children().size()-4);
        this.addDrawableChild(
                ButtonWidget.builder(Text.translatable("menu.reboot"), button -> {

                            Runtime rt = Runtime.getRuntime();
                            try {
                                Process pr = rt.exec("sudo reboot");
                            } catch (IOException e) {
                                throw new RuntimeException(e);
                            }
                })
                        .dimensions(last.getX(), last.getY(), last.getWidth(), last.getHeight())
                        .build()
        );
        remove(last);
    }

    @Inject(at = @At("TAIL"), method = "addNormalWidgets")
    private void addNormalWidgets(int y, int spacingY, CallbackInfoReturnable<Integer> cir) {
        ButtonWidget last = (ButtonWidget) children().getLast();
        this.addDrawableChild(
                ButtonWidget.builder(Text.translatable("menu.options"), button -> this.client.setScreen(new OptionsScreen(this, this.client.options)))
                        .dimensions(last.getX(), last.getY(), last.getWidth(), last.getHeight())
                        .build()
        );
        remove(last);
    }

    @Inject(at = @At("TAIL"), method = "render")
    public void render(DrawContext context, int mouseX, int mouseY, float delta, CallbackInfo ci) throws NoSuchFieldException, IllegalAccessException {
        if (this.backgroundFadeStart == 0L && this.doBackgroundFade) {
            this.backgroundFadeStart = Util.getMeasuringTimeMs();
        }

        float f = 1.0F;
        if (this.doBackgroundFade) {
            float g = (float)(Util.getMeasuringTimeMs() - this.backgroundFadeStart) / 2000.0F;
            if (g > 1.0F) {
                this.doBackgroundFade = false;
                this.backgroundAlpha = 1.0F;
            } else {
                g = MathHelper.clamp(g, 0.0F, 1.0F);
                f = MathHelper.clampedMap(g, 0.5F, 1.0F, 0.0F, 1.0F);
                this.backgroundAlpha = MathHelper.clampedMap(g, 0.0F, 0.5F, 0.0F, 1.0F);
            }

            this.setWidgetAlpha(f);
        }

        this.renderPanoramaBackground(context, delta);
        int i = MathHelper.ceil(f * 255.0F) << 24;
        if ((i & -67108864) != 0) {
            super.render(context, mouseX, mouseY, delta);
            this.logoDrawer.draw(context, this.width, f);
            if (this.splashText != null && !this.client.options.getHideSplashTexts().getValue()) {
                this.splashText.render(context, this.width, this.textRenderer, i);
            }

            context.drawTextWithShadow(this.textRenderer, "minceraftOS "+ DesktopIntegrations.getVersion(), 2, this.height - 10, 16777215 | i);
        }
    }
}