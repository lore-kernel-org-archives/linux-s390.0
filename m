Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from szxga07-in.huawei.com ([45.249.212.35]:60638 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726636AbgEHOHC (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 8 May 2020 10:07:02 -0400
From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] s390/cio: Remove unused inline functionidset_sch_get_first
Date: Fri, 8 May 2020 22:06:43 +0800
Message-ID: <20200508140643.30540-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: vneethv@linux.ibm.com, oberpar@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, gustavo@embeddedor.com, yuehaibing@huawei.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

commit 8ebd51a705c5 ("s390/cio: idset.c: remove some unused functions")
left behind this, remove it

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/s390/cio/idset.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/s390/cio/idset.c b/drivers/s390/cio/idset.c
index 77d0ea7b381b..45f9c0736be4 100644
--- a/drivers/s390/cio/idset.c
+++ b/drivers/s390/cio/idset.c
@@ -59,18 +59,6 @@ static inline int idset_contains(struct idset *set, int ssid, int id)
 	return test_bit(ssid * set->num_id + id, set->bitmap);
 }
 
-static inline int idset_get_first(struct idset *set, int *ssid, int *id)
-{
-	int bitnum;
-
-	bitnum = find_first_bit(set->bitmap, set->num_ssid * set->num_id);
-	if (bitnum >= set->num_ssid * set->num_id)
-		return 0;
-	*ssid = bitnum / set->num_id;
-	*id = bitnum % set->num_id;
-	return 1;
-}
-
 struct idset *idset_sch_new(void)
 {
 	return idset_new(max_ssid + 1, __MAX_SUBCHANNEL + 1);
-- 
2.17.1
