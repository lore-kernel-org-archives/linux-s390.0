Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611DBC4332F
	for <linux-s390@archiver.kernel.org>; Fri, 23 Dec 2022 02:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235814AbiLWCp2 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 22 Dec 2022 21:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235788AbiLWCp1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 22 Dec 2022 21:45:27 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3CD1F636;
        Thu, 22 Dec 2022 18:45:26 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NdWkY0ZPNz4xVnH;
        Fri, 23 Dec 2022 10:45:25 +0800 (CST)
Received: from szxlzmapp06.zte.com.cn ([10.5.230.252])
        by mse-fl2.zte.com.cn with SMTP id 2BN2jKLi054716;
        Fri, 23 Dec 2022 10:45:20 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp02[null])
        by mapi (Zmail) with MAPI id mid14;
        Fri, 23 Dec 2022 10:45:21 +0800 (CST)
Date:   Fri, 23 Dec 2022 10:45:21 +0800 (CST)
X-Zmail-TransId: 2b0463a5164112d9a219
X-Mailer: Zmail v1.0
Message-ID: <202212231045217042473@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <freude@linux.ibm.com>
Cc:     <hca@linux.ibm.com>, <gor@linux.ibm.com>, <agordeev@linux.ibm.com>,
        <borntraeger@linux.ibm.com>, <svens@linux.ibm.com>,
        <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xu.panda@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHMzOTAvemNyeXB0OiB1c2Ugc3Ryc2NweSgpIHRvIGluc3RlYWQgb2Ygc3RybmNweSgp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2BN2jKLi054716
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63A51645.001 by FangMail milter!
X-FangMail-Envelope: 1671763525/4NdWkY0ZPNz4xVnH/63A51645.001/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63A51645.001/4NdWkY0ZPNz4xVnH
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Xu Panda <xu.panda@zte.com.cn>

The implementation of strscpy() is more robust and safer.
That's now the recommended way to copy NUL-terminated strings.

Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
Signed-off-by: Yang Yang <yang.yang29@zte.com>
---
 drivers/s390/crypto/zcrypt_api.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index 4bf36e53fe3e..6fe05bb82c77 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -347,8 +347,7 @@ static ssize_t zcdn_create_store(struct class *class,
 	int rc;
 	char name[ZCDN_MAX_NAME];

-	strncpy(name, skip_spaces(buf), sizeof(name));
-	name[sizeof(name) - 1] = '\0';
+	strscpy(name, skip_spaces(buf), sizeof(name));

 	rc = zcdn_create(strim(name));

@@ -365,8 +364,7 @@ static ssize_t zcdn_destroy_store(struct class *class,
 	int rc;
 	char name[ZCDN_MAX_NAME];

-	strncpy(name, skip_spaces(buf), sizeof(name));
-	name[sizeof(name) - 1] = '\0';
+	strscpy(name, skip_spaces(buf), sizeof(name));

 	rc = zcdn_destroy(strim(name));

-- 
2.15.2
