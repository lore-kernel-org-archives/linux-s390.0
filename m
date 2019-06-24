Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60380 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbfFXJHZ (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 24 Jun 2019 05:07:25 -0400
From: Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH] vfio-ccw: make convert_ccw0_to_ccw1 static
Date: Mon, 24 Jun 2019 11:07:21 +0200
Message-Id: <20190624090721.16241-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>

Reported by sparse.

Fixes: 7f8e89a8f2fd ("vfio-ccw: Factor out the ccw0-to-ccw1 transition")
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
On top of my vfio-ccw branch.

s390 arch maintainers: let me know if I should queue it and send
a pull request, or if you prefer to apply it directly.
---
 drivers/s390/cio/vfio_ccw_cp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 9cddc1288059..a7b9dfd5b464 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -161,7 +161,7 @@ static inline void pfn_array_idal_create_words(
 	idaws[0] += pa->pa_iova & (PAGE_SIZE - 1);
 }
 
-void convert_ccw0_to_ccw1(struct ccw1 *source, unsigned long len)
+static void convert_ccw0_to_ccw1(struct ccw1 *source, unsigned long len)
 {
 	struct ccw0 ccw0;
 	struct ccw1 *pccw1 = source;
-- 
2.20.1
