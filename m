Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C242C433F5
	for <linux-s390@archiver.kernel.org>; Thu, 14 Apr 2022 01:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239491AbiDNBrF (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 13 Apr 2022 21:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239505AbiDNBq6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 13 Apr 2022 21:46:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8DF90DEA1
        for <linux-s390@vger.kernel.org>; Wed, 13 Apr 2022 18:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649900671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jXalVENl364WLU242Jde+1X/Q2QKLGjlQWD5km644gM=;
        b=UDSbAfYHEPKZHz6oeIWo84NFBZMbjAxjptfJCidczgSgs2EOPpV7Nk2w7vedrMkvcMtXis
        CfLXp0R+tH7sxmn1l9HiGeIjSfoDDd34cgYA/J9aOmWKHppJr95lMItE354vDIX7msDQpg
        r3UrUqHWswXreoWIA8jwAfxRQilaDdU=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-98-9FLAYmXDML-9NSlUY671pw-1; Wed, 13 Apr 2022 21:44:28 -0400
X-MC-Unique: 9FLAYmXDML-9NSlUY671pw-1
Received: by mail-pl1-f199.google.com with SMTP id f12-20020a170902ce8c00b0015874d582e8so1991727plg.7
        for <linux-s390@vger.kernel.org>; Wed, 13 Apr 2022 18:44:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jXalVENl364WLU242Jde+1X/Q2QKLGjlQWD5km644gM=;
        b=1tyFmSLsZz2FWRzE3Kj9ZZhpS/vBs5Dqe1qMxtwNUCzE15UnUAEpQc76CfblbkydHT
         ddrzuiqN/gZt2brjfn9O6ldnLhCN54wvgKQyHoqmYO4Q6q3jkbM/ct782GJIQVw0RH/6
         pwtee9o9PsZ6F94Y4/WwgBC+2+5lyC+FSF/v/tlOuhrZAZXfMeUC8JAixOz2LA2aUDyE
         NPoYTnwHZIyPf9B6Bwoy5ZZj9Na5KMgVksTgKOWJqQr3NX0Rm1BvYqhNpckV/mq1GVxG
         cJenK4riijAiGnRfx2UEP6Z6ao99bOKwmKQm4LssKdgmGy8FXk0uKiiWn8zwQPqRsbri
         jH+A==
X-Gm-Message-State: AOAM530zzzsmiwkrU7M5NHBbOxOlKhrDlpbc0719A9cPX4Pjb7g2KnqP
        0Rf/GJet9ocYk2tquaECeO5yfrSrIXPxCcKpZjnGvnmlWo8lTBZLIJdNiWHZTdMsDXseZDl/IDD
        HJX7QnR/WSkw0EWI8bE1boA==
X-Received: by 2002:a17:90a:1d0e:b0:1cb:50ec:27f with SMTP id c14-20020a17090a1d0e00b001cb50ec027fmr1691257pjd.195.1649900667467;
        Wed, 13 Apr 2022 18:44:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7lvJcRtRvT6UTIGdqLIQ5fotL6BdwS5zyMoazeF5Hq+0VgXvKq4yRZVC76yYSbM5z2e4jXA==
X-Received: by 2002:a17:90a:1d0e:b0:1cb:50ec:27f with SMTP id c14-20020a17090a1d0e00b001cb50ec027fmr1691236pjd.195.1649900667213;
        Wed, 13 Apr 2022 18:44:27 -0700 (PDT)
Received: from localhost ([240e:3a1:31c:360:52fc:c968:cb41:efbc])
        by smtp.gmail.com with ESMTPSA id k25-20020aa790d9000000b00508232aecedsm332618pfk.67.2022.04.13.18.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 18:44:26 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Michal Suchanek <msuchanek@suse.de>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Mimi Zohar <zohar@linux.ibm.com>, Chun-Yi Lee <jlee@suse.com>,
        Philipp Rudo <prudo@linux.ibm.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, stable@kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-s390@vger.kernel.org (open list:S390),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 4/4] kexec, KEYS, s390: Make use of built-in and secondary keyring for signature verification
Date:   Thu, 14 Apr 2022 09:43:44 +0800
Message-Id: <20220414014344.228523-5-coxu@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220414014344.228523-1-coxu@redhat.com>
References: <20220414014344.228523-1-coxu@redhat.com>
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
Cc: Philipp Rudo <prudo@linux.ibm.com>
Cc: kexec@lists.infradead.org
Cc: keyrings@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: stable@kernel.org
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
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
2.34.1

