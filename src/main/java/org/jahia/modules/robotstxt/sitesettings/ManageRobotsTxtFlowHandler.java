package org.jahia.modules.robotstxt.sitesettings;

import java.io.Serializable;
import javax.jcr.RepositoryException;
import org.jahia.services.content.JCRNodeWrapper;
import org.jahia.services.content.decorator.JCRSiteNode;
import org.jahia.services.render.RenderContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.webflow.execution.RequestContext;

public class ManageRobotsTxtFlowHandler implements Serializable {

    private static final Logger LOGGER = LoggerFactory.getLogger(ManageRobotsTxtFlowHandler.class);
    private static final String ROBOTS_TXT = "robotstxt";
    private static final String ROBOTS_TXT_NODE_TYPE = "jnt:robotstxt";

    public JCRNodeWrapper getSiteRobotsTxt(RequestContext ctx) throws RepositoryException {
        final JCRSiteNode currentSite = getRenderContext(ctx).getSite();
        final JCRNodeWrapper robotsNode;
        if (currentSite.hasNode(ROBOTS_TXT)) {
            robotsNode = currentSite.getNode(ROBOTS_TXT);
        } else {
            robotsNode = currentSite.addNode(ROBOTS_TXT, ROBOTS_TXT_NODE_TYPE);
            currentSite.getSession().save();
        }
        return robotsNode;
    }

    private RenderContext getRenderContext(RequestContext ctx) {
        return (RenderContext) ctx.getExternalContext().getRequestMap().get("renderContext");
    }
}
