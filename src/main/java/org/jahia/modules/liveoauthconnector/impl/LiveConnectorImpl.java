package org.jahia.modules.liveoauthconnector.impl;

import java.util.List;
import java.util.Map;
import org.jahia.modules.jahiaoauth.service.ConnectorService;
import org.jahia.security.license.LicenseCheckException;

public class LiveConnectorImpl implements ConnectorService {

    private String protectedResourceUrl;
    private String serviceName;
    private List<Map<String, Object>> availableProperties;

    public void onStart() throws LicenseCheckException {
//        if (!LicenseCheckerService.Stub.isAllowed("org.jahia.oauthLive")) {
//            throw new LicenseCheckException("Your DX license does not allow you to run Live OAuth Connector. please contact Jahia Solutions.");
//        }
    }

    @Override
    public String getProtectedResourceUrl() {
        return protectedResourceUrl;
    }

    @Override
    public List<Map<String, Object>> getAvailableProperties() {
        return availableProperties;
    }

    @Override
    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public void setProtectedResourceUrl(String protectedResourceUrl) {
        this.protectedResourceUrl = protectedResourceUrl;
    }

    public void setAvailableProperties(List<Map<String, Object>> availableProperties) {
        this.availableProperties = availableProperties;
    }
}
