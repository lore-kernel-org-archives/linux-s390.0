Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53980 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727753AbfGEGVn (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 5 Jul 2019 02:21:43 -0400
From: Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 1/1] vfio-ccw: Fix the conversion of Format-0 CCWs to Format-1
Date: Fri,  5 Jul 2019 08:21:32 +0200
Message-Id: <20190705062132.20755-2-cohuck@redhat.com>
In-Reply-To: <20190705062132.20755-1-cohuck@redhat.com>
References: <20190705062132.20755-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>

From: Eric Farman <farman@linux.ibm.com>

When processing Format-0 CCWs, we use the "len" variable as the
number of CCWs to convert to Format-1.  But that variable
contains zero here, and is not a meaningful CCW count until
ccwchain_calc_length() returns.  Since that routine requires and
expects Format-1 CCWs to identify the chaining behavior, the
format conversion must be done first.

Convert the 2KB we copied even if it's more than we need.

Fixes: 7f8e89a8f2fd ("vfio-ccw: Factor out the ccw0-to-ccw1 transition")
Reported-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20190702180928.18113-1-farman@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index a7b9dfd5b464..1d4c893ead23 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -431,7 +431,7 @@ static int ccwchain_handle_ccw(u32 cda, struct channel_program *cp)
 
 	/* Convert any Format-0 CCWs to Format-1 */
 	if (!cp->orb.cmd.fmt)
-		convert_ccw0_to_ccw1(cp->guest_cp, len);
+		convert_ccw0_to_ccw1(cp->guest_cp, CCWCHAIN_LEN_MAX);
 
 	/* Count the CCWs in the current chain */
 	len = ccwchain_calc_length(cda, cp);
-- 
2.20.1
