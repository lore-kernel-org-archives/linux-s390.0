Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50224 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbfFUOe3 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 21 Jun 2019 10:34:29 -0400
From: Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 14/14] vfio-ccw: Remove copy_ccw_from_iova()
Date: Fri, 21 Jun 2019 16:33:55 +0200
Message-Id: <20190621143355.29175-15-cohuck@redhat.com>
In-Reply-To: <20190621143355.29175-1-cohuck@redhat.com>
References: <20190621143355.29175-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>

From: Eric Farman <farman@linux.ibm.com>

Just to keep things tidy.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
Message-Id: <20190618202352.39702-6-farman@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 9a8bf06281e0..9cddc1288059 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -228,17 +228,6 @@ static long copy_from_iova(struct device *mdev,
 	return l;
 }
 
-static long copy_ccw_from_iova(struct channel_program *cp,
-			       struct ccw1 *to, u64 iova,
-			       unsigned long len)
-{
-	int ret;
-
-	ret = copy_from_iova(cp->mdev, to, iova, len * sizeof(struct ccw1));
-
-	return ret;
-}
-
 /*
  * Helpers to operate ccwchain.
  */
@@ -435,7 +424,8 @@ static int ccwchain_handle_ccw(u32 cda, struct channel_program *cp)
 	int len;
 
 	/* Copy 2K (the most we support today) of possible CCWs */
-	len = copy_ccw_from_iova(cp, cp->guest_cp, cda, CCWCHAIN_LEN_MAX);
+	len = copy_from_iova(cp->mdev, cp->guest_cp, cda,
+			     CCWCHAIN_LEN_MAX * sizeof(struct ccw1));
 	if (len)
 		return len;
 
-- 
2.20.1
