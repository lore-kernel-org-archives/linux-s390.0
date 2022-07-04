Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA46CCA47C
	for <linux-s390@archiver.kernel.org>; Mon,  4 Jul 2022 01:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbiGDBxQ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 3 Jul 2022 21:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbiGDBxD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 3 Jul 2022 21:53:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 491D462E6
        for <linux-s390@vger.kernel.org>; Sun,  3 Jul 2022 18:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656899577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sd8cjBSOdeaVjyH4f3lxl+0xYw15nzSjwpJw6bzSgLk=;
        b=LvJTmYNgCDsW7BIAISbXmbCfcii4AcKyXZLNndt3pa5qq/CFKcPlIMOVTS7W8VPnbny7TM
        /VLwyEY2Ef7IcpLhLG14iPyQJy0AN1y4NVoG0K7s2nHgFfIZYriSsBHhh24t2joKK7bsMe
        ZRaqeuvH4+ewCf6kZMU+IPZ2oWj1DX0=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-279-sGTha2-MMBGjExlxgw_ULw-1; Sun, 03 Jul 2022 21:52:55 -0400
X-MC-Unique: sGTha2-MMBGjExlxgw_ULw-1
Received: by mail-pf1-f198.google.com with SMTP id 5-20020a620605000000b00527ca01f8a3so2017708pfg.19
        for <linux-s390@vger.kernel.org>; Sun, 03 Jul 2022 18:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sd8cjBSOdeaVjyH4f3lxl+0xYw15nzSjwpJw6bzSgLk=;
        b=EKB3S+t9joblTD4dGVJ66ccgGM19rPCjcw1kfjw77o8ezm2NXPmRcj5BMy36eHK0L2
         jLxD7eUs6cFlhGXfewpm7xJPHNn9APqHVWWHXP0aRmsQvdj2Ltx4tc4giUn8Nxl1J1Yd
         bTAr3rB0BQzhON40Pb4U8UqDRfj83PezOcMFloxrCKeInnIF/Xs6BhyS8uUIsDl6rMk4
         WCZD+vcSLfEXCoI0qHARfTXiu1WN0OZWFI99IjkWkGYZI/etSp24QH9psXyKZrVxVB3T
         7Mxcdu2uFplbL8biJTkfgrUWtT7bniyCOx5GKJ8VHynNhCeAYS2yhm3OLgE/8F6PD/fg
         sXTQ==
X-Gm-Message-State: AJIora+KXno197CsnXBT/onIdMEqufO5R6qDUoCu3DzEAAgySWTMBAdB
        gbwMrzG0p+NRmqOQA2sj9bliO6Acva76TVCrBZlnJMO7arNMiev1GqtAEIJopZfHC1E9r304xXG
        fpfwzlcRrdNaZxr8Di+DEiQ==
X-Received: by 2002:a17:90a:1485:b0:1ec:788e:a053 with SMTP id k5-20020a17090a148500b001ec788ea053mr31016122pja.16.1656899573983;
        Sun, 03 Jul 2022 18:52:53 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u8Sm73HYl29mcEbEmk3Z6a37A8y2OdP5f3idLICxDPGrBoxyTSHxhDRsHAFrxMwDkh5wCuzQ==
X-Received: by 2002:a17:90a:1485:b0:1ec:788e:a053 with SMTP id k5-20020a17090a148500b001ec788ea053mr31016116pja.16.1656899573776;
        Sun, 03 Jul 2022 18:52:53 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p2-20020a1709027ec200b00168f08d0d12sm16841927plb.89.2022.07.03.18.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 18:52:53 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org,
        Michal Suchanek <msuchanek@suse.de>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Chun-Yi Lee <jlee@suse.com>, stable@vger.kernel.org,
        Philipp Rudo <prudo@linux.ibm.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-s390@vger.kernel.org (open list:S390),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 4/4] kexec, KEYS, s390: Make use of built-in and secondary keyring for signature verification
Date:   Mon,  4 Jul 2022 09:52:01 +0800
Message-Id: <20220704015201.59744-5-coxu@redhat.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220704015201.59744-1-coxu@redhat.com>
References: <20220704015201.59744-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Michal Suchanek <msuchanek@suse.de>

commit e23a8020ce4e ("s390/kexec_file: Signature verification prototype")
adds support for KEXEC_SIG verification with keys from platform keyring
but the built-in keys and secondary keyring are not used.

Add support for the built-in keys and secondary keyring as x86 does.

Fixes: e23a8020ce4e ("s390/kexec_file: Signature verification prototype")
Cc: stable@vger.kernel.org
Cc: Philipp Rudo <prudo@linux.ibm.com>
Cc: kexec@lists.infradead.org
Cc: keyrings@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
Acked-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/s390/kernel/machine_kexec_file.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index 8f43575a4dd3..fc6d5f58debe 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -31,6 +31,7 @@ int s390_verify_sig(const char *kernel, unsigned long kernel_len)
 	const unsigned long marker_len = sizeof(MODULE_SIG_STRING) - 1;
 	struct module_signature *ms;
 	unsigned long sig_len;
+	int ret;
 
 	/* Skip signature verification when not secure IPLed. */
 	if (!ipl_secure_flag)
@@ -65,11 +66,18 @@ int s390_verify_sig(const char *kernel, unsigned long kernel_len)
 		return -EBADMSG;
 	}
 
-	return verify_pkcs7_signature(kernel, kernel_len,
-				      kernel + kernel_len, sig_len,
-				      VERIFY_USE_PLATFORM_KEYRING,
-				      VERIFYING_MODULE_SIGNATURE,
-				      NULL, NULL);
+	ret = verify_pkcs7_signature(kernel, kernel_len,
+				     kernel + kernel_len, sig_len,
+				     VERIFY_USE_SECONDARY_KEYRING,
+				     VERIFYING_MODULE_SIGNATURE,
+				     NULL, NULL);
+	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING))
+		ret = verify_pkcs7_signature(kernel, kernel_len,
+					     kernel + kernel_len, sig_len,
+					     VERIFY_USE_PLATFORM_KEYRING,
+					     VERIFYING_MODULE_SIGNATURE,
+					     NULL, NULL);
+	return ret;
 }
 #endif /* CONFIG_KEXEC_SIG */
 
-- 
2.35.3

