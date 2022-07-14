Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B077C433EF
	for <linux-s390@archiver.kernel.org>; Thu, 14 Jul 2022 13:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239867AbiGNNl3 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 14 Jul 2022 09:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239869AbiGNNlW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 14 Jul 2022 09:41:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5214F61130
        for <linux-s390@vger.kernel.org>; Thu, 14 Jul 2022 06:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657806080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sd8cjBSOdeaVjyH4f3lxl+0xYw15nzSjwpJw6bzSgLk=;
        b=ZLDVWnto/mdrs/Notqm+NYT9OzYBBXFiZDqMf8B5iUUsbohdqBpjWGZbRAUu4oOfAENE32
        ss8QkrOPpHeGylfPASD7XLTSUwNlusLZy1bvZsitS+ZupAdwQ3qRGLKjT0dJR5tb1T3Nw7
        f0WJPmPDfWsWqgp/zVsQrkXvUCmsptg=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-224-mDVVJUcNO9S4iWZEv8MZBA-1; Thu, 14 Jul 2022 09:41:12 -0400
X-MC-Unique: mDVVJUcNO9S4iWZEv8MZBA-1
Received: by mail-pl1-f198.google.com with SMTP id i17-20020a170902c95100b0016c449584a9so238157pla.1
        for <linux-s390@vger.kernel.org>; Thu, 14 Jul 2022 06:41:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sd8cjBSOdeaVjyH4f3lxl+0xYw15nzSjwpJw6bzSgLk=;
        b=mdyVs5Net3JHr8FM4Q9FoNg77Mus/RHrG3AeyQFP0SVWjZIi4R9/aJrBTyhKpxI4XJ
         l0DW5FertuAQKtf5XZJeKU/Wb+m64MpwuFL6Bpti2ver2rYT2WSGoA1uedqIQXZ5PcXe
         EHjeuVhkjv0IYjO01OJhB54dr3Qo21bEIXAHpRLq9fhLkr3ZIDJhJ4PmGcYEj8LlOPOL
         pOLtYZeJhsp4CsCABOQAHUXCD6B+NykJmZzXUoKSF8gWTsGhr8qMKNFgNTwfq+haAlbV
         8QZ7ASoTM9uAZ5cD/tvf4deqoCSLn3YPV3+p2kfGF0RuaeU7wazAVRZN+ozpsZdfIIkU
         IEkA==
X-Gm-Message-State: AJIora/kPnNQ1NK7hg7zhXl04+gcCfHSqyc/TVJ+vMHqIL4tPqBHNdiu
        DstVY5wxltt3H4XWx7n6dhTPllgOW2DPcs8d5wbBo0mVuMpLM1pMCcnr9cIJVlikgSMzZZ+HHby
        lk52ytxXPGzQbENp1p98+XQ==
X-Received: by 2002:a17:90b:4b82:b0:1f0:196d:4204 with SMTP id lr2-20020a17090b4b8200b001f0196d4204mr16396530pjb.194.1657806070933;
        Thu, 14 Jul 2022 06:41:10 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v6W73kkND0lzdShUq0XCk7I59w6K6H/HhxbM9LJ4h4Bhv+gs6tfqbnzg5qbuZf1Ex6YUHUFA==
X-Received: by 2002:a17:90b:4b82:b0:1f0:196d:4204 with SMTP id lr2-20020a17090b4b8200b001f0196d4204mr16396483pjb.194.1657806070591;
        Thu, 14 Jul 2022 06:41:10 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id h10-20020aa79f4a000000b00528d880a32fsm1663006pfr.78.2022.07.14.06.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 06:41:10 -0700 (PDT)
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
Subject: [PATCH v10 4/4] kexec, KEYS, s390: Make use of built-in and secondary keyring for signature verification
Date:   Thu, 14 Jul 2022 21:40:27 +0800
Message-Id: <20220714134027.394370-5-coxu@redhat.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220714134027.394370-1-coxu@redhat.com>
References: <20220714134027.394370-1-coxu@redhat.com>
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

