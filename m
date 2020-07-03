Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:51259 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgGCC0a (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 2 Jul 2020 22:26:30 -0400
From: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH] vfio-ccw: Fix a build error due to missing include of linux/slab.h
Date: Thu,  2 Jul 2020 19:26:28 -0700
Message-Id: <20200703022628.6036-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>, Vineeth Vijayan <vneethv@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Sean Christopherson <sean.j.christopherson@intel.com>

Include linux/slab.h to fix a build error due to kfree() being undefined.

Fixes: 3f02cb2fd9d2d ("vfio-ccw: Wire up the CRW irq and CRW region")
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---

Encountered this when cross-compiling with a pretty minimal config, didn't
bother digging into why the error only showed up in my environment.

 drivers/s390/cio/vfio_ccw_chp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_chp.c
index a646fc81c872..13b26a1c7988 100644
--- a/drivers/s390/cio/vfio_ccw_chp.c
+++ b/drivers/s390/cio/vfio_ccw_chp.c
@@ -8,6 +8,7 @@
  *            Eric Farman <farman@linux.ibm.com>
  */
 
+#include <linux/slab.h>
 #include <linux/vfio.h>
 #include "vfio_ccw_private.h"
 
-- 
2.26.0
