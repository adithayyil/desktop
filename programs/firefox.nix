{ config, lib, pkgs, ... }:

{
  programs.firefox = {
    enable = true;

    preferences = {
      # Anti-fingerprinting
      "privacy.resistFingerprinting" = true;
      "privacy.fingerprintingProtection" = true;

      # Tracking Protection
      "privacy.trackingprotection.enabled" = true;
      "privacy.trackingprotection.fingerprinting.enabled" = true;
      "privacy.trackingprotection.cryptomining.enabled" = true;
      "privacy.trackingprotection.socialtracking.enabled" = true;
      "privacy.trackingprotection.emailtracking.enabled" = true;

      # Do Not Track
      "privacy.donottrackheader.enabled" = true;

      # Disable WebRTC leak
      "media.peerconnection.enabled" = false;

      # Disable geolocation
      "geo.enabled" = false;

      # Disable camera/mic without prompt
      "media.navigator.enabled" = false;

      # Telemetry
      "toolkit.telemetry.enabled" = false;
      "toolkit.telemetry.unified" = false;
      "toolkit.telemetry.archive.enabled" = false;
      "datareporting.healthreport.uploadEnabled" = false;
      "datareporting.policy.dataSubmissionEnabled" = false;

      # Disable Prefetching/Preloading
      "network.dns.disablePrefetch" = true;
      "network.prefetch-next" = false;
      "network.http.speculative-parallel-limit" = 0;

      # Disable Autofill
      "extensions.formautofill.addresses.enabled" = false;
      "extensions.formautofill.creditCards.enabled" = false;

      # Firefox Home Content
      "browser.newtabpage.activity-stream.showWeather" = false;
      "browser.newtabpage.activity-stream.feeds.topsites" = false;
      "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
      "browser.newtabpage.activity-stream.section.highlights.includeVisited" = false;
      "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = false;
      "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = false;
      "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;

      # Ctrl+Tab cycles through tabs in recently used order
      "browser.ctrlTab.sortByRecentlyUsed" = true;

      # Enable DRM
      "media.eme.enabled" = true;
    };

    policies = {
      # Telemetry & Data Collection
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisableFeedbackCommands = true;

      # Mozilla Services
      DisableFirefoxAccounts = true;
      DisablePocket = true;
      DisableFirefoxScreenshots = true;

      # Tracking Protection
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
      };

      # Form & Password Privacy
      DisableFormHistory = true;
      DisablePasswordReveal = true;
      OfferToSaveLogins = false;
      PasswordManagerEnabled = false;

      # Downloads
      DefaultDownloadDirectory = "\${home}/dls";
      PromptForDownloadLocation = true;

      ExtensionSettings = {
        "*".installation_mode = "blocked";

        # uBlock
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };

        # Bitwarden
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4567044/bitwarden_password_manager-2025.8.2.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };

        # SponsorBlock
        "sponsorBlocker@ajay.app" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4608179/sponsorblock-6.1.0.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };
      };
    };
  };
}
