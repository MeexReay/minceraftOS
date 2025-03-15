package ru.themixray.mixin.client;

import net.minecraft.client.MinecraftClient;
import org.spongepowered.asm.mixin.Mixin;
import org.spongepowered.asm.mixin.injection.At;
import org.spongepowered.asm.mixin.injection.Inject;
import org.spongepowered.asm.mixin.injection.callback.CallbackInfo;

import java.io.IOException;

@Mixin(MinecraftClient.class)
public class ClientMixin {
	@Inject(at = @At("HEAD"), method = "scheduleStop")
	private void init(CallbackInfo info) {
		Runtime rt = Runtime.getRuntime();
        try {
            Process pr = rt.exec("sudo poweroff");
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}