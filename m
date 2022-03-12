Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43D0C433F5
	for <linux-s390@archiver.kernel.org>; Sat, 12 Mar 2022 13:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbiCLNbN (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 12 Mar 2022 08:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbiCLNar (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 12 Mar 2022 08:30:47 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90725188A0F
        for <linux-s390@vger.kernel.org>; Sat, 12 Mar 2022 05:29:35 -0800 (PST)
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DB29E3F79D
        for <linux-s390@vger.kernel.org>; Sat, 12 Mar 2022 13:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647091773;
        bh=7mUFbCJbIndj6M7s/RjbSIBZAkFNvJ9seQGSdX0sCHc=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=LideUy4HU692ieL3kT/cVKz2WzgKIPJ1pc5Jn8vKH0EStlrWxrYUBlPAYUdio5Rr7
         CZE5DIvNIERInenYj3lcux63N3/s/WDX7K0Kx215heuKB5aTzSh9qpqeE93KBJ0MoG
         pAKqh01ei02bx9fxaadkxTj7wl9ZDK8hvH61YcbnLXeAi5OhCjPaFLHKZWyGQPyVB+
         vsPAogRXcOnYItzXTWdElC9BH9DJRj+JtvzsKL2PLGEWRp64uZeWYIFW2wM9FHE0ng
         AlbZRyjks9puU8s1EXAWL+Qr4B5FKoxtp/2Zwwq/+Xrk0RXmoqXXVa8/ha2+hXr9m7
         EObj433qCXSmg==
Received: by mail-lj1-f198.google.com with SMTP id v5-20020a2ea605000000b00246322afc8cso4634734ljp.4
        for <linux-s390@vger.kernel.org>; Sat, 12 Mar 2022 05:29:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7mUFbCJbIndj6M7s/RjbSIBZAkFNvJ9seQGSdX0sCHc=;
        b=0VR9mmECxVVtA2NsumdYI3kZGOwgUlvDWMZd990D+cIWh5QE0+mQuBXPLH7kwKnUUk
         IvAsP3MkIZtIlESL1+N/hcY1ujX5wifFKZxObvGOP5eGCuCUpYA6jZ/gEf8VOmWDcZIu
         CBbUknkXFwFJ0lFB7Qyml7pZHEGKozO2EfOo+vIe3P6oO/fkBK5kjC8sBARP7Dy3gpFj
         UIYXjzRuAoH1xjIVs/7PJ6kqTplT7q9oYFRbYdjENKbt87FxxA++U49P4eoVF+VWjZuR
         5wHkNAc0sUVBiZlCUe/5QaqWwMj3haUDQtGRC+hHYvjX0jIkn+ArGFmclCUDTRc6XHfp
         Qbuw==
X-Gm-Message-State: AOAM533NG/3QuIjxzut6mvBr/2AHgsJ93Jj9t+e8s7eL1QRhF8Z3ww5v
        zgm5H5IH4SD4wqoJJtb+nRdKXBhs3JAG8ZGX8s3/4BOrNmAm+luQ+4XY2mzj7DDW9idEWKtz4op
        2GTPadXIopIeUXL4w2j41Vhjj8ADFmNIqbOz2hHU=
X-Received: by 2002:a5d:5512:0:b0:1ef:5f08:29fb with SMTP id b18-20020a5d5512000000b001ef5f0829fbmr10682392wrv.653.1647091762093;
        Sat, 12 Mar 2022 05:29:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwL9N8cHHsfR6QUZ51LIW64l7WzEaKnb3KtvzXdONbhu6n0rj400RLdEGB8nEbZlW8twybECA==
X-Received: by 2002:a5d:5512:0:b0:1ef:5f08:29fb with SMTP id b18-20020a5d5512000000b001ef5f0829fbmr10682372wrv.653.1647091761844;
        Sat, 12 Mar 2022 05:29:21 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id p22-20020a1c5456000000b00389e7e62800sm5751550wmi.8.2022.03.12.05.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 05:29:21 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v4 05/11] PCI: Use driver_set_override() instead of open-coding
Date:   Sat, 12 Mar 2022 14:28:50 +0100
Message-Id: <20220312132856.65163-6-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220312132856.65163-1-krzysztof.kozlowski@canonical.com>
References: <20220312132856.65163-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Use a helper to set driver_override to reduce amount of duplicated code.
Make the driver_override field const char, because it is not modified by
the core and it matches other subsystems.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci-sysfs.c | 28 ++++------------------------
 include/linux/pci.h     |  6 +++++-
 2 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 602f0fb0b007..5c42965c32c2 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -567,31 +567,11 @@ static ssize_t driver_override_store(struct device *dev,
 				     const char *buf, size_t count)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	char *driver_override, *old, *cp;
-
-	/* We need to keep extra room for a newline */
-	if (count >= (PAGE_SIZE - 1))
-		return -EINVAL;
-
-	driver_override = kstrndup(buf, count, GFP_KERNEL);
-	if (!driver_override)
-		return -ENOMEM;
-
-	cp = strchr(driver_override, '\n');
-	if (cp)
-		*cp = '\0';
-
-	device_lock(dev);
-	old = pdev->driver_override;
-	if (strlen(driver_override)) {
-		pdev->driver_override = driver_override;
-	} else {
-		kfree(driver_override);
-		pdev->driver_override = NULL;
-	}
-	device_unlock(dev);
+	int ret;
 
-	kfree(old);
+	ret = driver_set_override(dev, &pdev->driver_override, buf, count);
+	if (ret)
+		return ret;
 
 	return count;
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 60d423d8f0c4..415491fb85f4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -516,7 +516,11 @@ struct pci_dev {
 	u16		acs_cap;	/* ACS Capability offset */
 	phys_addr_t	rom;		/* Physical address if not from BAR */
 	size_t		romlen;		/* Length if not from BAR */
-	char		*driver_override; /* Driver name to force a match */
+	/*
+	 * Driver name to force a match.  Do not set directly, because core
+	 * frees it.  Use driver_set_override() to set or clear it.
+	 */
+	const char	*driver_override;
 
 	unsigned long	priv_flags;	/* Private flags for the PCI driver */
 
-- 
2.32.0

