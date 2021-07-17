<?php

/**
 * @file plugins/themes/medienpaed_hs/medienpaed_hsThemePlugin.inc.php
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class medienpaed_hsThemePlugin
 * @ingroup plugins_themes_medienpaed_hs
 *
 * @brief medienpaed_hs theme
 */

import('lib.pkp.classes.plugins.ThemePlugin');
class medienpaed_hsThemePlugin extends ThemePlugin {

	/**
	 * Load the custom styles for our theme
	 * @return null
	 */
	public function init() {

		// Add theme options
		$this->addOption('baseColour', 'colour', array(
			'label' => 'plugins.themes.medienpaed_hs.option.colour.label',
			'description' => 'plugins.themes.medienpaed_hs.option.colour.description',
			'default' => '#29335c',
		));

		// Update colour based on theme option
		$additionalLessVariables = [];
		if ($this->getOption('baseColour') !== '#29335c') {
			$additionalLessVariables[] = '@primary:' . $this->getOption('baseColour') . ';';
			$additionalLessVariables[] = '
				@primary-light: desaturate(lighten(@primary, 41%), 15%);
				@primary-text: darken(@primary, 15%);
				@primary-link: darken(@primary, 50%);
			';
		}

		// Update contrast colour based on primary colour
		if ($this->isColourDark($this->getOption('baseColour'))) {
			$additionalLessVariables[] = '
				@contrast: rgba(255, 255, 255, 0.85);
				@primary-text: lighten(@primary, 15%);
				@primary-link: lighten(@primary, 50%);
			';
		}

		// Load dependencies from CDN
		if (Config::getVar('general', 'enable_cdn')) {
			$this->addStyle(
				'fonts',
				'https://fonts.googleapis.com/css?family=Roboto+Slab:200,200i,400,400i|Open+Sans:300,300i,400,400i,700,700i',
				array('baseUrl' => '')
			);
			$this->addStyle(
				'bootstrap',
				'https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css',
				array('baseUrl' => '')
			);
			$this->addStyle(
				'fontawesome',
				'https://use.fontawesome.com/releases/v5.6.1/css/all.css',
				array('baseUrl' => '')
			);
			$this->addScript(
				'jquery',
				'https://code.jquery.com/jquery-3.5.1.min.js',
				array('baseUrl' => '')
			);
			$this->addScript(
				'popper',
				'https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js',
				array('baseUrl' => '')
			);
			$this->addScript(
				'bootstrap',
				'https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js',
				array('baseUrl' => '')
			);

		// Load local copies of dependencies if CDNs are not allowed
		} else {
			$this->addStyle('bootstrap', 'libs/bootstrap.min.css');
			$this->addScript('jquery', 'libs/jquery.min.js');
			$this->addScript('popper', 'libs/popper.min.js');
			$this->addScript('bootstrap', 'libs/bootstrap.min.js');
		}

		// Load theme stylesheet and script
		$this->addStyle('stylesheet', 'styles/index.less');
		$this->modifyStyle('stylesheet', array('addLessVariables' => join($additionalLessVariables)));
		$this->addScript('main', 'js/main.js');

		// Styles for HTML galleys
		$this->addStyle('htmlGalley', 'templates/plugins/generic/htmlArticleGalley/css/default.css', array('contexts' => 'htmlGalley'));
                $this->addStyle('htmlFont', 'https://fonts.googleapis.com/css?family=PT+Serif&display=swap', array('baseUrl' => '', 'contexts' => 'htmlGalley'));

		// Styles for right to left scripts
		$locale = AppLocale::getLocale();
		$localeDirection = AppLocale::getLocaleDirection($locale);
		if ($localeDirection === "rtl") {
			$this->addStyle('rtl', 'styles/rtl.less');
		}

		// Add JQuery UI and tag-it libraries for registration page (reviewer's interests)
		$this->addScript("jquery-ui", "libs/jquery-ui.min.js");
		$this->addScript("tag-it", "libs/tag-it.min.js");

		// Add navigation menu areas for this theme
		$this->addMenuArea(array('primary', 'user'));

		// Get extra data for templates
		HookRegistry::register ('TemplateManager::display', array($this, 'loadTemplateData'));
	}

	/**
	 * Get the display name of this theme
	 * @return string
	 */
	public function getDisplayName() {
			return __('plugins.themes.medienpaed_hs.name');
	}

	/**
	 * Get the description of this plugin
	 * @return string
	 */
	public function getDescription() {
			return __('plugins.themes.medienpaed_hs.description');
	}

	/**
	 * Load custom data for templates
	 *
	 * @param string $hookName
	 * @param array $args [
	 *		@option TemplateManager
	 *		@option string Template file requested
	 *		@option string
	 *		@option string
	 *		@option string output HTML
	 * ]
	 */
	public function loadTemplateData($hookName, $args) {
		$templateMgr = $args[0];
		$request = Application::get()->getRequest();
		$context = $request->getContext();

		if (!defined('SESSION_DISABLE_INIT')) {

			// Get possible locales
			if ($context) {
				$locales = $context->getSupportedLocaleNames();
			} else {
				$locales = $request->getSite()->getSupportedLocaleNames();
			}

			// Load login form
			$loginUrl = $request->url(null, 'login', 'signIn');
			if (Config::getVar('security', 'force_login_ssl')) {
				$loginUrl = PKPString::regexp_replace('/^http:/', 'https:', $loginUrl);
			}

			$orcidImage = $this->getPluginPath() . '/templates/images/orcid.png';
			$phzhImage = $this->getPluginPath() . '/templates/images/Logo_PHZH.svg';
			$oaImage = $this->getPluginPath() . '/templates/images/Platinum_Open_Access.svg';
			$dgfeImage = $this->getPluginPath() . '/templates/images/Logo_Sektion_Medienpaedagogik_light.svg';
			$crossrefImage = $this->getPluginPath() . '/templates/images/member-badge-member.svg';
			$medienpaedSM = $this->getPluginPath() . '/templates/images/pageHeaderLogoImage_de_DE.svg';
			$missingCover = $this->getPluginPath() . '/templates/images/missing-cover.jpg';
									
			$templateMgr->assign(array(
				'languageToggleLocales' => $locales,
				'loginUrl' => $loginUrl,
				'brandImage' => 'templates/images/ojs_brand_white.png',
				'orcidImage' => $orcidImage,
				'phzhImage' => $phzhImage,
				'oaImage' => $oaImage,
				'dgfeImage' => $dgfeImage,
				'crossrefImage' => $crossrefImage,
				'medienpaedSM' => $medienpaedSM,
				'missingCover' => $missingCover,
				
			));
		}
	}
}
