Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:22643 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbfFUOeI (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 21 Jun 2019 10:34:08 -0400
From: Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 03/14] s390/cio: Generalize the TIC handler
Date: Fri, 21 Jun 2019 16:33:44 +0200
Message-Id: <20190621143355.29175-4-cohuck@redhat.com>
In-Reply-To: <20190621143355.29175-1-cohuck@redhat.com>
References: <20190621143355.29175-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>

From: Eric Farman <farman@linux.ibm.com>

Refactor ccwchain_handle_tic() into a routine that handles a channel
program address (which itself is a CCW pointer), rather than a CCW pointer
that is only a TIC CCW.  This will make it easier to reuse this code for
other CCW commands.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20190606202831.44135-4-farman@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 628daf1a8f9a..52735cdb0270 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -497,13 +497,13 @@ static int tic_target_chain_exists(struct ccw1 *tic, struct channel_program *cp)
 static int ccwchain_loop_tic(struct ccwchain *chain,
 			     struct channel_program *cp);
 
-static int ccwchain_handle_tic(struct ccw1 *tic, struct channel_program *cp)
+static int ccwchain_handle_ccw(u32 cda, struct channel_program *cp)
 {
 	struct ccwchain *chain;
 	int len, ret;
 
 	/* Get chain length. */
-	len = ccwchain_calc_length(tic->cda, cp);
+	len = ccwchain_calc_length(cda, cp);
 	if (len < 0)
 		return len;
 
@@ -511,10 +511,10 @@ static int ccwchain_handle_tic(struct ccw1 *tic, struct channel_program *cp)
 	chain = ccwchain_alloc(cp, len);
 	if (!chain)
 		return -ENOMEM;
-	chain->ch_iova = tic->cda;
+	chain->ch_iova = cda;
 
 	/* Copy the new chain from user. */
-	ret = copy_ccw_from_iova(cp, chain->ch_ccw, tic->cda, len);
+	ret = copy_ccw_from_iova(cp, chain->ch_ccw, cda, len);
 	if (ret) {
 		ccwchain_free(chain);
 		return ret;
@@ -540,7 +540,8 @@ static int ccwchain_loop_tic(struct ccwchain *chain, struct channel_program *cp)
 		if (tic_target_chain_exists(tic, cp))
 			continue;
 
-		ret = ccwchain_handle_tic(tic, cp);
+		/* Build a ccwchain for the next segment */
+		ret = ccwchain_handle_ccw(tic->cda, cp);
 		if (ret)
 			return ret;
 	}
-- 
2.20.1
