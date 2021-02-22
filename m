Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA06C4332D
	for <linux-s390@archiver.kernel.org>; Mon, 22 Feb 2021 15:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CA5064EEC
	for <linux-s390@archiver.kernel.org>; Mon, 22 Feb 2021 15:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbhBVPPO (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 22 Feb 2021 10:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbhBVPO1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 22 Feb 2021 10:14:27 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4746EC061224;
        Mon, 22 Feb 2021 07:12:58 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id i9so3927063wml.5;
        Mon, 22 Feb 2021 07:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x89BexqXo3Pbh3lJ7Z3KsfvIYs1RyNkeULZlTFZ42+U=;
        b=eFetgx/wQhK3HZ2gWlP04SHuML29p37v+tAFLedoJXj9GkZFBC/hupx34Gp6IhDGrE
         +07FYvjDqIGmymb825+gtZPd+MCkrhBe7yfvasFOdWBH3MP0soii3st4v4Rbt7YdNej9
         UTT4FS8vqX+AkkbPmTrO8blnZrh1Qig1NIXl1iqgxFg9guKAa66TCQ9oCVQNzyj76UQC
         i5TIiYQoNHpnluAMOPEn4xuLmlemsKwaGUEROA9LQN5OUnIbA3RJgpga8G+TAiUQTv9Z
         +0ABoKr1oOu6/txw6FcOaR67h0RIYSFyvOGxG6Yrmx+bMEdom+zC7HXCnaP8admDuyx8
         1MuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x89BexqXo3Pbh3lJ7Z3KsfvIYs1RyNkeULZlTFZ42+U=;
        b=Uz+LoyBgrQdPZTQtPxcMCxfR6i4H6UfBBddjh1Y0XWZmKcXrAXkaXwBOMLJbktWUIA
         V7mBQgVYMu3EcEqOE+wDBJtBSbAt71XrSZ3QFGCiwIxqMf/UG7gEFKAH9mltRwaG6ktO
         K4S03M6X7SXVFhuVnUVSlHpHZfneQQkZ4pxyHJO5R/e/ZGlLr/hq6JGUz2eAe4SQe4DV
         SSW8CRCJ/LLtHj6xisMTIGusYikUPiI5UZUGDXB9tpNk4Ks11bcZ1YaOj7en3UcEVsHF
         MW7nkf/F6OfYapIg/CJREhtXckE8SMhWQePL3VOFD+N+or/qRNl8mEKkdvnOTe7Ban3+
         1jeQ==
X-Gm-Message-State: AOAM530+3amiY4xHJZdKMpsOeQbm89Gmuq3HZGm1x8bigVGMc5fW8U4w
        N+avQbm1HOC+ptcbcWkA6M9lF1DdPVnD7E8/NDQ=
X-Google-Smtp-Source: ABdhPJyyLj7nPo4kA6f6+G83yp5TJSPhh3+lb/y0vT/f7lNvvrjPJjDSCO/PqGqFpOrjePvhXxy5eQ==
X-Received: by 2002:a1c:2e04:: with SMTP id u4mr20581364wmu.79.1614006776742;
        Mon, 22 Feb 2021 07:12:56 -0800 (PST)
Received: from debby (176-141-241-253.abo.bbox.fr. [176.141.241.253])
        by smtp.gmail.com with ESMTPSA id 7sm17129948wmi.27.2021.02.22.07.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 07:12:56 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Kees Cook <keescook@chromium.org>,
        kernel-hardening@lists.openwall.com,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Romain Perier <romain.perier@gmail.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/20] s390/hmcdrv: Manual replacement of the deprecated strlcpy() with return values
Date:   Mon, 22 Feb 2021 16:12:23 +0100
Message-Id: <20210222151231.22572-13-romain.perier@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210222151231.22572-1-romain.perier@gmail.com>
References: <20210222151231.22572-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The strlcpy() reads the entire source buffer first, it is dangerous if
the source buffer lenght is unbounded or possibility non NULL-terminated.
It can lead to linear read overflows, crashes, etc...

As recommended in the deprecated interfaces [1], it should be replaced
by strscpy.

This commit replaces all calls to strlcpy that handle the return values
by the corresponding strscpy calls with new handling of the return
values (as it is quite different between the two functions).

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 drivers/s390/char/diag_ftp.c |    4 ++--
 drivers/s390/char/sclp_ftp.c |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/char/diag_ftp.c b/drivers/s390/char/diag_ftp.c
index 6bf1058de873..c198dfcc85be 100644
--- a/drivers/s390/char/diag_ftp.c
+++ b/drivers/s390/char/diag_ftp.c
@@ -158,8 +158,8 @@ ssize_t diag_ftp_cmd(const struct hmcdrv_ftp_cmdspec *ftp, size_t *fsize)
 		goto out;
 	}
 
-	len = strlcpy(ldfpl->fident, ftp->fname, sizeof(ldfpl->fident));
-	if (len >= HMCDRV_FTP_FIDENT_MAX) {
+	len = strscpy(ldfpl->fident, ftp->fname, sizeof(ldfpl->fident));
+	if (len == -E2BIG) {
 		len = -EINVAL;
 		goto out_free;
 	}
diff --git a/drivers/s390/char/sclp_ftp.c b/drivers/s390/char/sclp_ftp.c
index dfdd6c8fd17e..525156926592 100644
--- a/drivers/s390/char/sclp_ftp.c
+++ b/drivers/s390/char/sclp_ftp.c
@@ -87,7 +87,7 @@ static int sclp_ftp_et7(const struct hmcdrv_ftp_cmdspec *ftp)
 	struct completion completion;
 	struct sclp_diag_sccb *sccb;
 	struct sclp_req *req;
-	size_t len;
+	ssize_t len;
 	int rc;
 
 	req = kzalloc(sizeof(*req), GFP_KERNEL);
@@ -114,9 +114,9 @@ static int sclp_ftp_et7(const struct hmcdrv_ftp_cmdspec *ftp)
 	sccb->evbuf.mdd.ftp.length = ftp->len;
 	sccb->evbuf.mdd.ftp.bufaddr = virt_to_phys(ftp->buf);
 
-	len = strlcpy(sccb->evbuf.mdd.ftp.fident, ftp->fname,
+	len = strscpy(sccb->evbuf.mdd.ftp.fident, ftp->fname,
 		      HMCDRV_FTP_FIDENT_MAX);
-	if (len >= HMCDRV_FTP_FIDENT_MAX) {
+	if (len == -E2BIG) {
 		rc = -EINVAL;
 		goto out_free;
 	}

