<svg version="1.1"
	 id="cover_canvas" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:svg="http://www.w3.org/2000/svg"
	 xmlns="http://www.w3.org/2000/svg" viewBox="0 0 595.3 841">

    {include file="images/waves_clean.svg"}

	<text id="issueNumber{$issue->getVolume()}" class="issueNumber" x="42" y="290">{$issue->getVolume()}</text>
    
    <foreignObject x="0" y="0" width="595.3" height="841">
        <div id="hrsg_title" xmlns="http://www.w3.org/1999/xhtml">
            <div class="st6">{$issue->getLocalizedTitle()}</div>
            <div class="st9">{$issue->getLocalizedDescription()|strip_tags:false}</div>
        </div>
    </foreignObject>
    
    <image x="179" y="236" width="400" href="{$publicFilesDir}/{$displayPageHeaderLogo.uploadName|escape:"url"}">

</svg>	 
    
    <script type="text/javascript">
        var colorpick = colors_default1[{$issue->getVolume()}];
        
        var dark_top{$issue->getVolume()} = document.getElementById("dark_top{$issue->getVolume()}");
        var dark_bottom{$issue->getVolume()} = document.getElementById("dark_bottom{$issue->getVolume()}");
        
        var mid_bottom{$issue->getVolume()} = document.getElementById("mid_bottom{$issue->getVolume()}");
        var mid_top{$issue->getVolume()} = document.getElementById("mid_top{$issue->getVolume()}");
        
        var dark_bottom_mid{$issue->getVolume()} = document.getElementById("dark_bottom_mid{$issue->getVolume()}");
        
        var foregr_bottom{$issue->getVolume()} = document.getElementById("foregr_bottom{$issue->getVolume()}");
        
        var issueNumber{$issue->getVolume()} = document.getElementById("issueNumber{$issue->getVolume()}");
        
        dark_top{$issue->getVolume()}.style.setProperty("fill", "rgb(" + colorpick[3] + ")", ""); 
        foregr_bottom{$issue->getVolume()}.style.setProperty("fill", "rgb(" + colorpick[3] + ")", "");

        mid_top{$issue->getVolume()}.style.setProperty("fill", "rgb(" + colorpick[2] + ")", ""); 
        
        dark_bottom_mid{$issue->getVolume()}.style.setProperty("fill", "rgb(" + colorpick[1] + ")", ""); 
        dark_bottom{$issue->getVolume()}.style.setProperty("fill", "rgb(" + colorpick[1] + ")", "");

        mid_bottom{$issue->getVolume()}.style.setProperty("fill", "rgb(" + colorpick[0] + ")", "");         
        issueNumber{$issue->getVolume()}.style.setProperty("fill", "rgb(" + colorpick[0] + ")", "");
        
        </script>
