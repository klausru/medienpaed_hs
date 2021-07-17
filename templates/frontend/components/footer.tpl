{**
 * templates/frontend/components/footer.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Common site frontend footer.
 *}
<footer class="site-footer">
	<div class="container site-footer-sidebar" role="complementary" aria-label="{translate|escape key="common.navigation.sidebar"}">
		<div class="row">
			{call_hook name="Templates::Common::Sidebar"}
		</div>
	</div>
	<div class="container site-footer-content">
		<div class="row">
			<div class="col-md align-self-center text-left">
				<a title="PH Zürich" href="http://www.phzh.ch" target="_blank" rel="noopener">
					<img class="footer-brand-image" src="{$baseUrl}/{$phzhImage}" alt="Logo PH Zürich" />
				</a>
			</div>
			<div class="col-md align-self-center text-center">
				<a title="Sektion Medienpädagogik der Deutschen Gesellschaft für Erziehungswissenschaft (DGfE)" href="http://www.dgfe.de/sektionen-kommissionen/sektion-12-medienpaedagogik.html" target="_blank" rel="noopener">
					<img class="footer-brand-image" src="{$baseUrl}/{$dgfeImage}" alt="Logo Sektion Medienpädagogik der Deutschen Gesellschaft für Erziehungswissenschaft (DGfE)" />
				</a>
			</div>
			<div class="col-md align-self-center text-center">
				<a title="MedienPädagogik - DOAJ" href="https://doaj.org/toc/1424-3636" target="_blank" rel="noopener">
					<img class="footer-brand-image" src="{$baseUrl}/{$oaImage}" alt="MedienPädagogik is Platinum Open Access" />
				</a>
			</div>
			<div class="col-md align-self-center text-center">
				<a title="We are Crossref Member" href="https://www.crossref.org" target="_blank" rel="noopener">
					<img class="footer-brand-image" src="{$baseUrl}/{$crossrefImage}" alt="Crossref Member Badge" /> 
				</a>
			</div>
			<div class="col-md align-self-center text-right">
				<a href="{url page="about" op="aboutThisPublishingSystem"}">
					<img class="footer-brand-image" alt="{translate key="about.aboutThisPublishingSystem"}" src="{$baseUrl}/{$brandImage}">
				</a>
			</div>
		</div>
		</div>
	</div>
</footer><!-- pkp_structure_footer_wrapper -->

{* Load author biography modals if they exist *}
{if !empty($smarty.capture.authorBiographyModals|trim)}
	{$smarty.capture.authorBiographyModals}
{/if}

{* Login modal *}
<div id="loginModal" class="modal fade" tabindex="-1" role="dialog">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-body">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				{include file="frontend/components/loginForm.tpl" formType = "loginModal"}
			</div>
		</div>
	</div>
</div>

{load_script context="frontend" scripts=$scripts}

{call_hook name="Templates::Common::Footer::PageFooter"}
</body>
</html>
