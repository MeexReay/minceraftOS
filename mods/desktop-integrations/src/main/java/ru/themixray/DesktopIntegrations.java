package ru.themixray;

import net.fabricmc.api.ModInitializer;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.*;
import java.net.URL;
import java.util.Properties;
import java.util.Scanner;
import java.util.stream.Collectors;

public class DesktopIntegrations implements ModInitializer {
	public static final String MOD_ID = "desktop-integrations";

	// This logger is used to write text to the console and the log file.
	// It is considered best practice to use your mod id as the logger's name.
	// That way, it's clear which mod wrote info, warnings, and errors.
	public static final Logger LOGGER = LoggerFactory.getLogger(MOD_ID);

	@Override
	public void onInitialize() {
		LOGGER.info("Desktop Integrations "+getVersion()+" loaded!");
	}

	public static String getVersion() {
        try {
            return getResourceFileAsString("/version");
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

	static String getResourceFileAsString(String fileName) throws IOException {
		try (InputStream is = DesktopIntegrations.class.getResourceAsStream(fileName)) {
			if (is == null) return null;
			try (InputStreamReader isr = new InputStreamReader(is); BufferedReader reader = new BufferedReader(isr)) {
				return reader.lines().collect(Collectors.joining(System.lineSeparator()));
			}
		}
	}
}