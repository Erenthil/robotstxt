window.jahia.i18n.loadNamespaces('robotstxt');

window.jahia.uiExtender.registry.add('adminRoute', 'robotstxt', {
    targets: ['administration-sites:100'],
    isSelectable: true,
    label: 'robotstxt:label.robotstxt',
    requireModuleInstalledOnSite: 'robotstxt',
    iframeUrl: window.contextJsParameters.contextPath + '/cms/edit/default/$lang/sites/$site-key.robotsTxtManager.html?redirect=false&hideMenu=true&fullscreen'
});
