Return-Path: <SRS0=iFEE=UC=vger.kernel.org=kvm-owner@kernel.org>
From: Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 7/7] s390/cio: Remove vfio-ccw checks of command codes
Date: Mon,  3 Jun 2019 12:50:38 +0200
Message-Id: <20190603105038.11788-8-cohuck@redhat.com>
In-Reply-To: <20190603105038.11788-1-cohuck@redhat.com>
References: <20190603105038.11788-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

From: Eric Farman <farman@linux.ibm.com>

If the CCW being processed is a No-Operation, then by definition no
data is being transferred.  Let's fold those checks into the normal
CCW processors, rather than skipping out early.

Likewise, if the CCW being processed is a "test" (a category defined
here as an opcode that contains zero in the lowest four bits) then no
special processing is necessary as far as vfio-ccw is concerned.
These command codes have not been valid since the S/370 days, meaning
they are invalid in the same way as one that ends in an eight [1] or
an otherwise valid command code that is undefined for the device type
in question.  Considering that, let's just process "test" CCWs like
any other CCW, and send everything to the hardware.

[1] POPS states that a x08 is a TIC CCW, and that having any high-order
bits enabled is invalid for format-1 CCWs.  For format-0 CCWs, the
high-order bits are ignored.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
Message-Id: <20190516161403.79053-4-farman@linux.ibm.com>
Acked-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index c77c9b4cd2a8..f73cfcfdd032 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -295,8 +295,6 @@ static long copy_ccw_from_iova(struct channel_program *cp,
 #define ccw_is_read_backward(_ccw) (((_ccw)->cmd_code & 0x0F) == 0x0C)
 #define ccw_is_sense(_ccw) (((_ccw)->cmd_code & 0x0F) == CCW_CMD_BASIC_SENSE)
 
-#define ccw_is_test(_ccw) (((_ccw)->cmd_code & 0x0F) == 0)
-
 #define ccw_is_noop(_ccw) ((_ccw)->cmd_code == CCW_CMD_NOOP)
 
 #define ccw_is_tic(_ccw) ((_ccw)->cmd_code == CCW_CMD_TIC)
@@ -320,6 +318,10 @@ static inline int ccw_does_data_transfer(struct ccw1 *ccw)
 	if (ccw->count == 0)
 		return 0;
 
+	/* If the command is a NOP, then no data will be transferred */
+	if (ccw_is_noop(ccw))
+		return 0;
+
 	/* If the skip flag is off, then data will be transferred */
 	if (!ccw_is_skip(ccw))
 		return 1;
@@ -404,7 +406,7 @@ static void ccwchain_cda_free(struct ccwchain *chain, int idx)
 {
 	struct ccw1 *ccw = chain->ch_ccw + idx;
 
-	if (ccw_is_test(ccw) || ccw_is_noop(ccw) || ccw_is_tic(ccw))
+	if (ccw_is_tic(ccw))
 		return;
 
 	kfree((void *)(u64)ccw->cda);
@@ -730,9 +732,6 @@ static int ccwchain_fetch_one(struct ccwchain *chain,
 {
 	struct ccw1 *ccw = chain->ch_ccw + idx;
 
-	if (ccw_is_test(ccw) || ccw_is_noop(ccw))
-		return 0;
-
 	if (ccw_is_tic(ccw))
 		return ccwchain_fetch_tic(chain, idx, cp);
 
-- 
2.20.1
