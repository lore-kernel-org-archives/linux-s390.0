Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58921 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726129AbgGCJxI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Jul 2020 05:53:08 -0400
From: Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 1/1] vfio-ccw: Fix a build error due to missing include of linux/slab.h
Date: Fri,  3 Jul 2020 11:52:53 +0200
Message-Id: <20200703095253.620719-2-cohuck@redhat.com>
In-Reply-To: <20200703095253.620719-1-cohuck@redhat.com>
References: <20200703095253.620719-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Sean Christopherson <sean.j.christopherson@intel.com>, Cornelia Huck <cohuck@redhat.com>

From: Sean Christopherson <sean.j.christopherson@intel.com>

Include linux/slab.h to fix a build error due to kfree() being undefined.

Fixes: 3f02cb2fd9d2 ("vfio-ccw: Wire up the CRW irq and CRW region")
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Message-Id: <20200703022628.6036-1-sean.j.christopherson@intel.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
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
2.25.4
