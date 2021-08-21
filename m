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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E24C4338F
	for <linux-s390@archiver.kernel.org>; Sat, 21 Aug 2021 03:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9D1061184
	for <linux-s390@archiver.kernel.org>; Sat, 21 Aug 2021 03:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhHUDyq (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 20 Aug 2021 23:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhHUDyq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 20 Aug 2021 23:54:46 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75009C061575;
        Fri, 20 Aug 2021 20:54:07 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id t66so13096990qkb.0;
        Fri, 20 Aug 2021 20:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gPVMfJmF5apelHRJsHy850+Wr5DdBmlIDaqFUXSeNXo=;
        b=Yc0Wk8KKOSVZezqoSGs9GlVp/OUlVXPEDqWGxea9T/DaFFD3QYTjJb7HxabEJjxyjn
         H+MlOz1JGtO/hl8iqnDLpr9Y3oprEf0CIMLKE+WPmKhx1qACS58pXM43SyMGLSISexX0
         Qzo4hAphyRJDgVRBlQ9DG4PC6jGDtwKkySpximippebGr7W9NEfx47J9xuOi1GS3nMFe
         NESdaXbS6W/yEjwGDbBeffZOgZO8/F7lYZbYU9/nyHTvEjwHuMH5BR1zjIe9I10DZsZM
         QrPfQ3Y5jgSufYLmspK9PpRZxHnjkJUx9UaRl8Y5cTP9i5JWSRE7cZaU7CkY4cJbYWa9
         kduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gPVMfJmF5apelHRJsHy850+Wr5DdBmlIDaqFUXSeNXo=;
        b=rKwz5rwJF0wn8gksZjpdo3LOICpKBjTtuiZT4SRCTXQNtM7iuuC0hfwrd6j/4uXnro
         yQwE1WdpteE4xrfO7YnkP+/qhUcyleSOCj2DOdwmhmuftljpirBWdaZnKolCcFwBfHtB
         PL0vKzmm9Ui8g01sxat25/HjAuL7Jv/JvhHiZRf+Ek/Bo4UXWl73ug/K+82NWZwlUXd9
         cecWp8jm92kprFhzgUEAiUBuNmzbNUkU6om+8RrQDt+3UdYyLbbv4oQNIuF1l8GR7FHH
         SncI40Yd+rQNUU9AhXSDnFEL4u3XMBBXMZnTgA2qm7eezJn7Acd3Vran7kBxS7NO/8wt
         +3hA==
X-Gm-Message-State: AOAM530lBFsMcwouPoNmIbee4s+kSlJSGU58UlA330Y7v5xuRCy3T5F+
        S5e0KkzxyJ69Spt7ILLBks5CQS38ctxunQ==
X-Google-Smtp-Source: ABdhPJzELzGQ5lFGx2Z0651S47KN8nX/2N7WNCSjGrZPJQKp/SPBKIstJVI76apx3J/7L+fTaLkGQQ==
X-Received: by 2002:a37:a592:: with SMTP id o140mr12060620qke.220.1629518046730;
        Fri, 20 Aug 2021 20:54:06 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id f12sm3434230qtj.40.2021.08.20.20.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 20:54:06 -0700 (PDT)
From:   CGEL <cgel.zte@gmail.com>
X-Google-Original-From: CGEL <jing.yangyang@zte.com.cn>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        jing yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] s390:raw3270: Convert sysfs sprintf/snprintf family to sysfs_emit
Date:   Fri, 20 Aug 2021 20:53:58 -0700
Message-Id: <20210821035358.28350-1-jing.yangyang@zte.com.cn>
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


