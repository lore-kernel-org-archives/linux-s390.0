Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A41C433DB
	for <linux-s390@archiver.kernel.org>; Mon, 22 Mar 2021 02:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A61961930
	for <linux-s390@archiver.kernel.org>; Mon, 22 Mar 2021 02:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhCVCkI (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 21 Mar 2021 22:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhCVCjo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 21 Mar 2021 22:39:44 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E4FC061574;
        Sun, 21 Mar 2021 19:39:44 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id a11so11339216qto.2;
        Sun, 21 Mar 2021 19:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zrGbWW5ihzie1YOtZ70z+RLlEehxlrDgp3vUW4wEyPk=;
        b=aeXv2i7HQiAF48R8uFxYvWESW5PT1T6dIV/sv0C2qaGHYWS1y0p9Fz4wPQXo11rGqp
         zg84h1NSkT92rKq/MMoRBpNiZ03BbU0d2BGHfaxQc+KnHgyy+2zDgsfdy6evmSoaKqzE
         Xfqkhg+TFNHfKttrQrHk6OtIloif32CwE+90+MlkPFBvtMm4rAVqRTQZaJ/qZ6YNIfcI
         WpamscgHZG2pBAxbYEG/V0XpXhbQN9JKNy8vdbZyreP/lIXy+T1cq2ZFb5XLweVmxvmo
         15BYqsXGVFXdpzo96n0/2cYKiBhDJ/LLv2h0rl620V3YdTPpLWkT5tho6HE61j+UC4mt
         w1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zrGbWW5ihzie1YOtZ70z+RLlEehxlrDgp3vUW4wEyPk=;
        b=ZRv0r2kwP3hLpNyzlkgnjzQIV0wfjn/wBDz6M1UxrueE3AyGu8hvwiGrGEedP3Zjxa
         KPQTwqjlQhQrmuMMZUzLxKH+QL9ijOMH+OYgxSVJG8lLUgxtfpX8pvWuerkeWvqI0Bl8
         TFRpoiWmWwFQnxsIDiv0PadBWA2zVmlJ8xw5XD1p58lPsvooWpvYjGP7x9db4U6cX8HN
         djqGbSbmK9YSnyu3ur7JeriSr1eptHgb6gwiQSUUNcUoOhIyNZgClGHSlP+Yaa2KiO+j
         ZFp1dQdjyt8THchfGbVXQMetAfHXnnBUGqiFB4I/oKONbOdCrgQvSFPMBp2bG1YCYzm2
         L8ZA==
X-Gm-Message-State: AOAM530DCJ/sxVtDO7eY0hzSRRbFLi6UOjZigHxUtcfzwzRDQV/+6Urq
        epvmrX9V70JhtFdB+7YS45A=
X-Google-Smtp-Source: ABdhPJx0Z6yE+Vhatg987uyoZj8KYbflUMK5hBlSWOBY6MxkHyLpW6B1GVBImSm+oKRu4CczHdi3Aw==
X-Received: by 2002:a05:622a:3cf:: with SMTP id k15mr7633811qtx.282.1616380783476;
        Sun, 21 Mar 2021 19:39:43 -0700 (PDT)
Received: from localhost.localdomain ([156.146.54.190])
        by smtp.gmail.com with ESMTPSA id j3sm9934506qki.84.2021.03.21.19.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 19:39:43 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     sth@linux.ibm.com, hoeppner@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] s390: dasd: Mundane spelling fixes
Date:   Mon, 22 Mar 2021 08:09:30 +0530
Message-Id: <20210322023930.376358-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


s/Subssystem/Subsystem/ ......two different places
s/reportet/reported/
s/managemnet/management/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/s390/block/dasd_eckd.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.h b/drivers/s390/block/dasd_eckd.h
index ca24a78a256e..73651211789f 100644
--- a/drivers/s390/block/dasd_eckd.h
+++ b/drivers/s390/block/dasd_eckd.h
@@ -52,7 +52,7 @@
 #define DASD_ECKD_CCW_RCD		 0xFA
 #define DASD_ECKD_CCW_DSO		 0xF7

-/* Define Subssystem Function / Orders */
+/* Define Subsystem Function / Orders */
 #define DSO_ORDER_RAS			 0x81

 /*
@@ -110,7 +110,7 @@
 #define DASD_ECKD_PG_GROUPED		 0x10

 /*
- * Size that is reportet for large volumes in the old 16-bit no_cyl field
+ * Size that is reported for large volumes in the old 16-bit no_cyl field
  */
 #define LV_COMPAT_CYL 0xFFFE

@@ -555,7 +555,7 @@ struct dasd_dso_ras_ext_range {
 } __packed;

 /*
- * Define Subsytem Operation - Release Allocated Space
+ * Define Subsystem Operation - Release Allocated Space
  */
 struct dasd_dso_ras_data {
 	__u8 order;
@@ -676,7 +676,7 @@ struct dasd_eckd_private {
 	struct dasd_ext_pool_sum eps;
 	u32 real_cyl;

-	/* alias managemnet */
+	/* alias management */
 	struct dasd_uid uid;
 	struct alias_pav_group *pavgroup;
 	struct alias_lcu *lcu;
--
2.31.0

