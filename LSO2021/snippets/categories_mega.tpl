{extends file="{$parent_template_path}/snippets/categories_mega.tpl"}

    {block name='snippets-categories-mega-categories'}
    {if $Einstellungen.template.megamenu.show_categories !== 'N'
        && ($Einstellungen.global.global_sichtbarkeit != 3 || \JTL\Session\Frontend::getCustomer()->getID() > 0)}
        {get_category_array categoryId=0 assign='categories'}
        {if !empty($categories)}
            {if !isset($activeParents)
            && ($nSeitenTyp === $smarty.const.PAGE_ARTIKEL || $nSeitenTyp === $smarty.const.PAGE_ARTIKELLISTE)}
                {get_category_parents categoryId=$activeId assign='activeParents'}
            {/if}
            {block name='snippets-categories-mega-categories-inner'}
            {foreach $categories as $category}
                {if isset($activeParents) && is_array($activeParents) && isset($activeParents[$i])}
                    {assign var=activeParent value=$activeParents[$i]}
                {/if}
                {if $category->isOrphaned() === false}
                    {if $category->hasChildren()}
                        {block name='snippets-categories-mega-category-child'}
                            <li class="nav-item nav-scrollbar-item dropdown dropdown-full
                                {if $Einstellungen.template.megamenu.show_categories === 'mobile'} d-lg-none
                                {elseif $Einstellungen.template.megamenu.show_categories === 'desktop'} d-none d-lg-inline-block {/if}
                                {if $category->getID() === $activeId
                            || ((isset($activeParent)
                                && isset($activeParent->kKategorie))
                                && $activeParent->kKategorie == $category->getID())} active{/if}">
                                {link href=$category->getURL() title=$category->getName()|@seofy class="nav-link dropdown-toggle" target="_self"}
                                    <span class="nav-mobile-heading">{$category->getShortName()}</span>
                                {/link}
                                <div class="dropdown-menu">
                                    <div class="dropdown-body">
                                        {container class="subcategory-wrapper"}
                                            {row class="lg-row-lg nav"}
                                                {col lg=4 xl=3 class="nav-item-lg-m nav-item dropdown d-lg-none"}
                                                    {link href=$category->getURL() rel="nofollow"}
                                                        <strong class="nav-mobile-heading">{lang key='menuShow' printf=$category->getShortName()}</strong>
                                                    {/link}
                                                {/col}
                                                {block name='snippets-categories-mega-sub-categories'}
                                                    {if $category->hasChildren()}
                                                        {if !empty($category->getChildren())}
                                                            {assign var=sub_categories value=$category->getChildren()}
                                                        {else}
                                                            {get_category_array categoryId=$category->getID() assign='sub_categories'}
                                                        {/if}
                                                        {foreach $sub_categories as $sub}
                                                            {col lg=4 xl=3 class="nav-item-lg-m nav-item {if $sub->hasChildren()}dropdown{/if}"}
                                                                {block name='snippets-categories-mega-category-child-body-include-categories-mega-recursive'}
                                                                    {include file='snippets/categories_mega_recursive.tpl' mainCategory=$sub firstChild=true subCategory=$i + 1}
                                                                {/block}
                                                            {/col}
                                                        {/foreach}
                                                    {/if}
                                                {/block}
                                            {/row}
                                        {/container}
                                    </div>
                                </div>
                            </li>
                        {/block}
                    {else}
                        {block name='snippets-categories-mega-category-no-child'}
                        {* WSC Kategorien ohne Kinder START *}
                            {navitem href=$category->getURL() title=$category->getName()|@seofy
                                class="nav-scrollbar-item {if $Einstellungen.template.megamenu.show_categories === 'mobile'} d-lg-none
                                    {elseif $Einstellungen.template.megamenu.show_categories === 'desktop'} d-none d-lg-inline-block {/if}
                                    {if $category->getID() === $activeId}active{/if}"}
                                <span class="text-truncate d-block">{$category->getShortName()}</span>
                            {/navitem}
                        {* WSC Kategorien ohne Kinder ENDE *}
                        {/block}
                    {/if}
                {/if}
            {/foreach}
            {/block}
        {/if}
    {/if}
    {/block}{* /megamenu-categories*}
