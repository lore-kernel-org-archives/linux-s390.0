Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372BEC433FE
	for <linux-s390@archiver.kernel.org>; Fri, 20 May 2022 11:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348823AbiETL5Y (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 20 May 2022 07:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348816AbiETL5V (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 20 May 2022 07:57:21 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503783E5C0
        for <linux-s390@vger.kernel.org>; Fri, 20 May 2022 04:57:20 -0700 (PDT)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AE881402F1
        for <linux-s390@vger.kernel.org>; Fri, 20 May 2022 11:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653047837;
        bh=1CO8KzxClB5nlE/5DYEJ5RBOK51FcaAi8ttXMoNqVVY=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=hBsFYs7VgS3c1aMbarErTHFXPo7TDiCKoNBE/vGylYUfpKCga+z9159ovgUjkY9kA
         mge7/rUxA0bzuDQ0xZ2+JHFlKUznekqv5GZreRI4DdwhHoabT4t1J/0EdH8zpINbsz
         oLSRya7QUXKO7rdkOxaHG5I5QgEqOnYJq+QNgoNOwH32OdkFGkcXnP33iAm+b1/5CU
         4IEifUK8X8mII18gqdZdscNNGLbo0thqy2Kk68h6Nhu5n8xNHUvmJxu1XkQyBI0PDh
         /KGqIeR74E59DyAHnfqItGfgnido8E3rQvRaDx6PyFGCpLIVKelWIox3geVS5U44gT
         6Yj9MemLTd2XQ==
Received: by mail-ed1-f72.google.com with SMTP id o10-20020aa7c7ca000000b0042a4f08405fso5509790eds.22
        for <linux-s390@vger.kernel.org>; Fri, 20 May 2022 04:57:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1CO8KzxClB5nlE/5DYEJ5RBOK51FcaAi8ttXMoNqVVY=;
        b=TkVN+f4B6bcO8uBdBTRM9hNh4YdzDeX3d0f3UzCd9NhAl+ZTlMa5/GmrnmTOGJcphQ
         zq0hVMk2+08IjKDfS6GeQJT0Ojy4ygV19yglNXxGIB5pq6qqSciLG2eqgzH5SLmabjug
         AS1B9sHgLm+YCe0AlrcdMJCfuCPM4pZXKhd41oBjH9SwicQvJq+vcx/R9AeQk8PlYO9p
         7rZ1GtU+Q7yL9Oz9TT9cnq1ZYpdNPLrCdl7nMxlt4wXNVjLsadvtthG3101PmB3Eh7K0
         gl3YvdTf97HXOFy0ug0hUTvuqG0Iy61tGmr28t4Bs0MF2ujG3BZcaoblpTw003xk3B9F
         MQmw==
X-Gm-Message-State: AOAM533TbwgNzlcGVP5zor5tQKBq0VPGiC8GuJ+95lvj1ZCTYMX5RgW/
        siDANq41qx0ilR9yTmx3mcoF+d8s5Nl2t4vs63ODaJooJnR0T33+sipggRXVmHy11Y786HKKp78
        JoBUAgjfSFfEMjJyM61x6bA06lkpqe6uIAyTCSKU=
X-Received: by 2002:a17:906:7944:b0:6da:b834:2f3e with SMTP id l4-20020a170906794400b006dab8342f3emr8565553ejo.353.1653047832856;
        Fri, 20 May 2022 04:57:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNIMcgPyCKVvSGFnNFVuiIKgdy04+FaNv8RjMQgn24l3JbCESZH8P4C2v/HyUvoXEtNMzZ+w==
X-Received: by 2002:a17:906:7944:b0:6da:b834:2f3e with SMTP id l4-20020a170906794400b006dab8342f3emr8565535ejo.353.1653047832656;
        Fri, 20 May 2022 04:57:12 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id ze16-20020a170906ef9000b006fe88802203sm2946451ejb.46.2022.05.20.04.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 04:57:12 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH 1/2] s390: Kconfig: Fix indentation and add comments
Date:   Fri, 20 May 2022 13:57:07 +0200
Message-Id: <20220520115708.147841-2-juergh@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220520115708.147841-1-juergh@canonical.com>
References: <20220520115708.147841-1-juergh@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The convention for indentation seems to be a single tab. Help text is
further indented by an additional two whitespaces. Fix the lines that
violate these rules.

While add it, add trailing comments to endmenu statements for better
readability.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 arch/s390/Kconfig | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index e084c72104f8..ae871569dcd6 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -607,7 +607,7 @@ config RANDOMIZE_BASE
 	  as a security feature that deters exploit attempts relying on
 	  knowledge of the location of kernel internals.
 
-endmenu
+endmenu # "Processor type and features"
 
 menu "Memory setup"
 
@@ -655,7 +655,7 @@ config STACK_GUARD
 	  The minimum size for the stack guard should be 256 for 31 bit and
 	  512 for 64 bit.
 
-endmenu
+endmenu # "Memory setup"
 
 menu "I/O subsystem"
 
@@ -736,13 +736,13 @@ config VFIO_AP
 	depends on S390_AP_IOMMU && VFIO_MDEV && KVM
 	depends on ZCRYPT
 	help
-		This driver grants access to Adjunct Processor (AP) devices
-		via the VFIO mediated device interface.
+	  This driver grants access to Adjunct Processor (AP) devices
+	  via the VFIO mediated device interface.
 
-		To compile this driver as a module, choose M here: the module
-		will be called vfio_ap.
+	  To compile this driver as a module, choose M here: the module
+	  will be called vfio_ap.
 
-endmenu
+endmenu # "I/O subsystem"
 
 menu "Dump support"
 
@@ -758,7 +758,7 @@ config CRASH_DUMP
 	  This option also enables s390 zfcpdump.
 	  See also <file:Documentation/s390/zfcpdump.rst>
 
-endmenu
+endmenu # "Dump support"
 
 config CCW
 	def_bool y
@@ -902,7 +902,7 @@ config S390_GUEST
 	  Select this option if you want to run the kernel as a guest under
 	  the KVM hypervisor.
 
-endmenu
+endmenu # "Virtualization"
 
 config S390_MODULES_SANITY_TEST_HELPERS
 	def_bool n
@@ -945,4 +945,4 @@ config S390_MODULES_SANITY_TEST
 	  kernel developers working on architecture code.
 
 	  Say N if you are unsure.
-endmenu
+endmenu # "Selftests"
-- 
2.32.0

