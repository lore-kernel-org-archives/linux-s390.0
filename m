Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC4EC433F5
	for <linux-s390@archiver.kernel.org>; Wed, 25 May 2022 12:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239932AbiEYMCN (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 25 May 2022 08:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243014AbiEYMCJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 25 May 2022 08:02:09 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739A2218F
        for <linux-s390@vger.kernel.org>; Wed, 25 May 2022 05:02:08 -0700 (PDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 45ED83F21C
        for <linux-s390@vger.kernel.org>; Wed, 25 May 2022 12:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653480126;
        bh=NBsh7HLtz477jQnNDrBziTrv34OGyGgoiBBMRY6NAL0=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=J1iAkFXhiVNchKj1f+PeigCv0OXs8HYALcv0QtW3rhfGoz9siX1qatHPfHkGsg/xl
         H7wi32aW6LOzmpDIUtBwpxP+w/W4pT7fhYI9Fw7yJ8BQhI4VvJ3Utbwzb2uZSEHC/8
         fR9eDykUSwo06D+ZGzdMtnNJIeCTW+IdGasw0iwQ3hEs6BoNLc4RaA93zatImedxxJ
         DNY0YRnVSJPdLmOSCdybcNgXqqbnAMp7MgY//4JQ3bhIWYZYWqYY3+fbqX8brtWbdV
         syW+afAAzVOklHWE0k6RXNfe+xaLzAcdoFBbWSnbr5oKqbIesS9By+kTfE9aT/Qn69
         COT69mGzzV/ig==
Received: by mail-ed1-f71.google.com with SMTP id l17-20020a056402029100b0042bcb0c15e4so907726edv.10
        for <linux-s390@vger.kernel.org>; Wed, 25 May 2022 05:02:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NBsh7HLtz477jQnNDrBziTrv34OGyGgoiBBMRY6NAL0=;
        b=XtKSD+KXWX2V881jGF2kpD2H5KlDfFT3uFkK/WlQ+Qv6M7/cUsQm6z8rrqQso4wsXG
         Zb/fw0yqjEnYmA0SsFcrTHsAZSwIfyUuNN72a8oT/fozWg/5BC61EeAMi+TS2mdKz2Vx
         v1TZ5RftTEgHLqxfOIpTUyMlGgUjoyzuxWB1kq37M19A+q7yHBEDbwtgckLgzcb0gk2L
         FolaZrkUabb/K77P8CkSZACH3yvl+f8DkjYLYOQpcbZO8gT55iQ/FocC2MQMXLkih2Da
         yXGv1i+ZW5A5r+pulgWV+3nmTlQFoGzRrMT0kKF2YLu3QMvs0nNbbgeaWbJIdeohCaTl
         /NRw==
X-Gm-Message-State: AOAM533jNLqhP502kBRO7OQi/XNLQvNn5etUuTfIfSveLDol1N0vFdwU
        Ji/jAqf7cO8/O7NdI5OYVFi32+57+3lEUNLoNxZpbHwHh1RMsH6gWK2fxby0WTUz6cjrQQ+8pwS
        fnnhb61gSmCvavESgn/nckasGdRwrxyXpV4BpV/Y=
X-Received: by 2002:a17:907:168d:b0:6fe:e7b7:e52 with SMTP id hc13-20020a170907168d00b006fee7b70e52mr12642947ejc.330.1653480123563;
        Wed, 25 May 2022 05:02:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpvixsysiEX+Ix2v/02GfvLL2dSaTMPsnBQpmjhjxCD60aAsLOQcfH+i2i6OLjU0n30H0Dpw==
X-Received: by 2002:a17:907:168d:b0:6fe:e7b7:e52 with SMTP id hc13-20020a170907168d00b006fee7b70e52mr12642928ejc.330.1653480123364;
        Wed, 25 May 2022 05:02:03 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id hh15-20020a170906a94f00b006fec41b21e1sm4257609ejb.171.2022.05.25.05.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 05:02:02 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH 2/2 v2] s390: Kconfig.debug: Fix indentation
Date:   Wed, 25 May 2022 14:01:51 +0200
Message-Id: <20220525120151.39594-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <Yo35NdfKlGwu5Trd@osiris>
References: <Yo35NdfKlGwu5Trd@osiris>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The convention for indentation seems to be a single tab. Help text is
further indented by an additional two whitespaces. Fix the lines that
violate these rules.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
v2:
 Change author and sob email addresses to match sender email address.

---
 arch/s390/Kconfig.debug | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/s390/Kconfig.debug b/arch/s390/Kconfig.debug
index e94a2a7f6bf4..c4300ea4abf8 100644
--- a/arch/s390/Kconfig.debug
+++ b/arch/s390/Kconfig.debug
@@ -14,9 +14,9 @@ config DEBUG_ENTRY
 	  If unsure, say N.
 
 config CIO_INJECT
-       bool "CIO Inject interfaces"
-       depends on DEBUG_KERNEL && DEBUG_FS
-       help
-	This option provides a debugging facility to inject certain artificial events
-	and instruction responses to the CIO layer of Linux kernel. The newly created
-	debugfs user-interfaces will be at /sys/kernel/debug/s390/cio/*
+	bool "CIO Inject interfaces"
+	depends on DEBUG_KERNEL && DEBUG_FS
+	help
+	  This option provides a debugging facility to inject certain artificial events
+	  and instruction responses to the CIO layer of Linux kernel. The newly created
+	  debugfs user-interfaces will be at /sys/kernel/debug/s390/cio/*
-- 
2.32.0

