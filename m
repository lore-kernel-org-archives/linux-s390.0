Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8225C001DE
	for <linux-s390@archiver.kernel.org>; Wed, 16 Aug 2023 02:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240909AbjHPCDF (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 15 Aug 2023 22:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241223AbjHPCDC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 15 Aug 2023 22:03:02 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D41110EC
        for <linux-s390@vger.kernel.org>; Tue, 15 Aug 2023 19:03:01 -0700 (PDT)
Received: from dggpeml500003.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RQWXc1dtzzNmlB;
        Wed, 16 Aug 2023 09:59:28 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 16 Aug
 2023 10:02:59 +0800
From:   Yu Liao <liaoyu15@huawei.com>
To:     <hca@linux.ibm.com>, <gor@linux.ibm.com>, <agordeev@linux.ibm.com>
CC:     <liaoyu15@huawei.com>, <liwei391@huawei.com>,
        <borntraeger@linux.ibm.com>, <svens@linux.ibm.com>,
        <linux-s390@vger.kernel.org>
Subject: [PATCH -next] s390/cpum_cf: use struct_size() helper
Date:   Wed, 16 Aug 2023 09:59:33 +0800
Message-ID: <20230816015933.2999694-1-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version,
in order to avoid any potential type mistakes or integer overflows that,
in the worst scenario, could lead to heap overflows.

Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
 arch/s390/kernel/perf_cpum_cf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index 850c11ea631a..e10c7b887f51 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -1507,7 +1507,7 @@ static size_t cfset_cpuset_read(struct s390_ctrset_setdata *p, int ctrset,
 	size_t need = 0;
 	int rc = -1;
 
-	need = sizeof(*p) + sizeof(u64) * ctrset_size;
+	need = struct_size(p, cv, ctrset_size);
 	if (need <= room) {
 		p->set = cpumf_ctr_ctl[ctrset];
 		p->no_cnts = ctrset_size;
-- 
2.25.1

