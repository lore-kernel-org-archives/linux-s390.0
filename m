Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13EEC433F5
	for <linux-s390@archiver.kernel.org>; Tue,  5 Oct 2021 07:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A479860F59
	for <linux-s390@archiver.kernel.org>; Tue,  5 Oct 2021 07:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbhJEH21 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 5 Oct 2021 03:28:27 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3913 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbhJEH21 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Oct 2021 03:28:27 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HNpwm3rRXz67XcG;
        Tue,  5 Oct 2021 15:23:52 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 5 Oct 2021 09:26:35 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <hca@linux.ibm.com>, <gor@linux.ibm.com>, <borntraeger@de.ibm.com>
CC:     <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH] s390: Fix strrchr() implementation
Date:   Tue, 5 Oct 2021 09:26:21 +0200
Message-ID: <20211005072621.53500-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Access the string at len - 1 instead of len.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 arch/s390/lib/string.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/s390/lib/string.c b/arch/s390/lib/string.c
index cfcdf76d6a95..162a391788ad 100644
--- a/arch/s390/lib/string.c
+++ b/arch/s390/lib/string.c
@@ -261,12 +261,12 @@ char *strrchr(const char *s, int c)
 {
        size_t len = __strend(s) - s;
 
-       if (len)
-	       do {
-		       if (s[len] == (char) c)
-			       return (char *) s + len;
-	       } while (--len > 0);
-       return NULL;
+	if (len)
+		do {
+			if (s[len - 1] == (char) c)
+				return (char *) s + len - 1;
+		} while (--len > 0);
+	return NULL;
 }
 EXPORT_SYMBOL(strrchr);
 #endif
-- 
2.32.0

