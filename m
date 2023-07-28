Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E41C001DE
	for <linux-s390@archiver.kernel.org>; Fri, 28 Jul 2023 08:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbjG1Iqc (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 28 Jul 2023 04:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbjG1IqG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 28 Jul 2023 04:46:06 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF843585
        for <linux-s390@vger.kernel.org>; Fri, 28 Jul 2023 01:45:09 -0700 (PDT)
Received: from dggpemm500018.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RC1MT49zSzNmdG;
        Fri, 28 Jul 2023 16:41:41 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500018.china.huawei.com (7.185.36.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 16:45:05 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 16:45:04 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-s390@vger.kernel.org>
CC:     <hca@linux.ibm.com>, <gor@linux.ibm.com>, <agordeev@linux.ibm.com>,
        <borntraeger@linux.ibm.com>, <svens@linux.ibm.com>,
        <anastasia.eskova@ibm.com>, <oberpar@linux.ibm.com>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next] s390/cert_store: fix error return code in fill_cs_keyring()
Date:   Fri, 28 Jul 2023 16:42:28 +0800
Message-ID: <20230728084228.3186083-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The 'rc' will be re-assigned to 0 after calling get_vcssb(), it
needs be set to error code if create_cs_keyring() fails.

Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 arch/s390/kernel/cert_store.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/cert_store.c b/arch/s390/kernel/cert_store.c
index 1cbeb9ce0eb1..38ad11c2be12 100644
--- a/arch/s390/kernel/cert_store.c
+++ b/arch/s390/kernel/cert_store.c
@@ -703,8 +703,10 @@ static int fill_cs_keyring(void)
 		goto cleanup_keys;
 
 	cs_keyring = create_cs_keyring();
-	if (!cs_keyring)
+	if (!cs_keyring) {
+		rc = -ENOMEM;
 		goto cleanup_keys;
+	}
 
 	rc = add_certificates_to_keyring(vcssb, cs_keyring);
 	if (rc)
-- 
2.25.1

