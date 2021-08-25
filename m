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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD61C4338F
	for <linux-s390@archiver.kernel.org>; Wed, 25 Aug 2021 06:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FCE9610E5
	for <linux-s390@archiver.kernel.org>; Wed, 25 Aug 2021 06:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238956AbhHYGqT (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 25 Aug 2021 02:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239085AbhHYGqR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 25 Aug 2021 02:46:17 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDE5C061757;
        Tue, 24 Aug 2021 23:45:31 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id 22so26004613qkg.2;
        Tue, 24 Aug 2021 23:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gPVMfJmF5apelHRJsHy850+Wr5DdBmlIDaqFUXSeNXo=;
        b=RYfjZT+pPeLG/c6H+4FuVfXOD8rE5zIrlBwgxKiY3KLG8/O/bhxpPtsa38f6/Xm5cX
         hH9gpHpJWJgXpOHpNDFkttMfb7Wma3tsgEhe1ZY7JT12btulwFOtMhY2f29ampKsLDVx
         FZ3lOcqh5LXmx0qpdS4eZSsruFoNw2JQO4sktAeaVK8hxd9uMNrrpT+KCqojI0GHDRO8
         L92No8jMYeGNeH2z9h0FyTrctB+HKd5wpCJexxOp/pcc4jek6cMd9bDglsIEpffr5iXo
         zp+kxV62H4hbgBeapIdYjlJFEBLbzreiNJR4xx/AaqJYLsolKMDaDAIhi2sgfL1FBVLe
         MIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gPVMfJmF5apelHRJsHy850+Wr5DdBmlIDaqFUXSeNXo=;
        b=j/RpFnurqp1VmQnSurX8+VCYD1FrlLcLkMO3yM8867J9PHc3kXpwJ++h8BLQED+OG7
         enbfCPi0aTKiNqVZdSIXrUe++JPQpmVQuTnB9AmA82uKyRkSUIlvN73wXbQHru6RJMzI
         RvGg+wK+XKY5JoK9xgEDT21x1sewBijvCDo0kcrQbg52TQCAiWtFreF8VzTz4AEbaeZ3
         VhKmOBkPqCz4Ob1jfV4JlLkI566ekmKXaPibnz9e0DY+ri5M8lpiv64N+bMSptcXMcWx
         0tprvvWkWP3z5foefgBtFzdpMYmGEfTUJj+/3AnsLQc1ijy8MEAQmyxF4Iu3Ht6SJIC5
         89rg==
X-Gm-Message-State: AOAM532xRSnC8csbELk/nqTz3MlSM8YqbeQ3x+ZgxZr7WRjkL1HjruEb
        I9BpJmW9z4RAkDmYrIcoT5U=
X-Google-Smtp-Source: ABdhPJx6r2y0Qz2o9dTE8QuwbDQ9c8mqvBudP4+JQ74RMeYZSmD0MwH8+K/5/Ztr6ZY9w3mRDrS0OA==
X-Received: by 2002:a05:620a:95e:: with SMTP id w30mr28881016qkw.157.1629873930774;
        Tue, 24 Aug 2021 23:45:30 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id w185sm12663265qkd.30.2021.08.24.23.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 23:45:30 -0700 (PDT)
From:   CGEL <cgel.zte@gmail.com>
X-Google-Original-From: CGEL <deng.changcheng@zte.com.cn>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        jing yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] s390:raw3270: Convert sysfs sprintf/snprintf family to sysfs_emit
Date:   Tue, 24 Aug 2021 23:45:23 -0700
Message-Id: <20210825064523.70563-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: jing yangyang <jing.yangyang@zte.com.cn>

Fix the following coccicheck warning:
./drivers/s390/char/raw3270.c:1066:8-16: WARNING: use scnprintf or sprintf
./drivers/s390/char/raw3270.c:1050:8-16: WARNING:use scnprintf or sprintf
./drivers/s390/char/raw3270.c:1058:8-16: WARNING:use scnprintf or sprintf

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: jing yangyang <jing.yangyang@zte.com.cn>
---
 drivers/s390/char/raw3270.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/char/raw3270.c b/drivers/s390/char/raw3270.c
index 646ec79..be8529f 100644
--- a/drivers/s390/char/raw3270.c
+++ b/drivers/s390/char/raw3270.c
@@ -1047,7 +1047,7 @@ struct raw3270_view *
 static ssize_t
 raw3270_model_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%i\n",
+	return sysfs_emit(buf, "%i\n",
 			((struct raw3270 *) dev_get_drvdata(dev))->model);
 }
 static DEVICE_ATTR(model, 0444, raw3270_model_show, NULL);
@@ -1055,7 +1055,7 @@ struct raw3270_view *
 static ssize_t
 raw3270_rows_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%i\n",
+	return sysfs_emit(buf, "%i\n",
 			((struct raw3270 *) dev_get_drvdata(dev))->rows);
 }
 static DEVICE_ATTR(rows, 0444, raw3270_rows_show, NULL);
@@ -1063,7 +1063,7 @@ struct raw3270_view *
 static ssize_t
 raw3270_columns_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%i\n",
+	return sysfs_emit(buf, "%i\n",
 			((struct raw3270 *) dev_get_drvdata(dev))->cols);
 }
 static DEVICE_ATTR(columns, 0444, raw3270_columns_show, NULL);
-- 
1.8.3.1


