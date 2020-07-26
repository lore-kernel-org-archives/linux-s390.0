Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8674 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726072AbgGZSez (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sun, 26 Jul 2020 14:34:55 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 1/2] s390/ism: indicate correct error reason in ism_alloc_dmb()
Date: Sun, 26 Jul 2020 20:34:27 +0200
Message-Id: <20200726183428.3284-2-kgraul@linux.ibm.com>
In-Reply-To: <20200726183428.3284-1-kgraul@linux.ibm.com>
References: <20200726183428.3284-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

When the ism driver allocates a new dmb in ism_alloc_dmb() it must
first check for and reserve a slot in the sba bitmap. When
find_next_zero_bit() finds no free slot then the return code is -ENOMEM.
This code conflicts with the error when the alloc() fails later in the
code. As a result of that the caller can not differentiate
between out-of-memory conditions and sba-bitmap-full conditions.
Fix that by using the return code -ENOSPC when the sba slot
reservation failed.

Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 drivers/s390/net/ism_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index c7fade836d83..5fbe9eae84d1 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -231,7 +231,7 @@ static int ism_alloc_dmb(struct ism_dev *ism, struct smcd_dmb *dmb)
 		bit = find_next_zero_bit(ism->sba_bitmap, ISM_NR_DMBS,
 					 ISM_DMB_BIT_OFFSET);
 		if (bit == ISM_NR_DMBS)
-			return -ENOMEM;
+			return -ENOSPC;
 
 		dmb->sba_idx = bit;
 	}
-- 
2.17.1
