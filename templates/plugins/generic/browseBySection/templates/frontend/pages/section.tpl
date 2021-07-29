{**
 * templates/plugins/generic/browseBySection/templates/frontend/pages/section.tpl
 *
 * Copyright (c) 2018 Simon Fraser University
 * Copyright (c) 2018 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display the reader-facing section page.
 *
 * @uses $section Section
 * @uses $sectionPath string The URL path for this section
 * @uses $sectionDescription string
 * @uses $articles array List of Submission objects
 * @uses $issues array List of Issue objects the $articles are published in
 * @uses $currentlyShowingStart int 20 in `20-30 of 100 results`
 * @uses $currentlyShowingEnd int 30 in `20-30 of 100 results`
 * @uses $countMax int 100 in `20-30 of 100 results`
 * @uses $currentlyShowingPage int 2 in `2 of 10 pages`
 * @uses $countMaxPage int 10 in `2 of 10 pages`.
 *}

{include file="frontend/components/header.tpl" pageTitleTranslated=$section->getLocalizedTitle()}

<div class="container page-section page_section_{$sectionPath|escape}">
	<div class="page-header">
		<h1 class="page_title">{$section->getLocalizedTitle()|escape}</h1>
	</div>
	<div class="row justify-content-md-center">
		{if $sectionDescription}
			<div class="col-lg-9">
				<div class="section-description">{$sectionDescription}</div>
			</div>
		{/if}
		
		
		<div class="col-12">
			<div class="page-content">
			
			{if $articleGroups|@count}
            {foreach from=$articleGroups item=group} 
            {if $group.key}
                <div class="cmp_article_header" id="browse_by_section_group_{$group.key|escape}">
                {$group.key|escape}
                </div>
            {/if}
		
			{foreach from=$group.articles item=article}
				<div>
					{* TODO remove section=null workaround. article_summary.tpl expects a specific section array. See issue_toc.tpl. *}
					{include file="frontend/objects/article_summary.tpl" section=null showDatePublished=true hideGalleys=false}
				</div>
			{/foreach}
		
		{/foreach}
			
		{else}
                <div class="alert alert-danger">
					{translate key="plugins.generic.browseBySection.emptySection"}
				</div>
				
        {/if}
			</div>
		</div>
	</div>
</div>

{include file="frontend/components/footer.tpl"}
