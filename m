Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41448 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727884AbfH3QDC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 30 Aug 2019 12:03:02 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7UG0iFM065701
        for <linux-s390@vger.kernel.org>; Fri, 30 Aug 2019 12:03:01 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uq5uf2mpg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 30 Aug 2019 12:03:00 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Fri, 30 Aug 2019 17:02:59 +0100
Date: Fri, 30 Aug 2019 18:02:50 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2] s390: vfio-ap: remove unnecessary calls to disable
 queue interrupts
In-Reply-To: <1566236929-18995-1-git-send-email-akrowiak@linux.ibm.com>
References: <1566236929-18995-1-git-send-email-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Message-Id: <20190830180250.79804f76.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, freude@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, pasic@linux.vnet.ibm.com, frankja@linux.ibm.com, jjherne@linux.ibm.com

On Mon, 19 Aug 2019 13:48:49 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> When an AP queue is reset (zeroized), interrupts are disabled. The queue
> reset function currently tries to disable interrupts unnecessarily. This patch
> removes the unnecessary calls to disable interrupts after queue reset.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 0604b49a4d32..e3bcb430e214 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -1114,18 +1114,19 @@ static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
>  	return NOTIFY_OK;
>  }
>  
> -static void vfio_ap_irq_disable_apqn(int apqn)
> +static struct vfio_ap_queue *vfio_ap_find_qdev(int apqn)
>  {
>  	struct device *dev;
> -	struct vfio_ap_queue *q;
> +	struct vfio_ap_queue *q = NULL;
>  
>  	dev = driver_find_device(&matrix_dev->vfio_ap_drv->driver, NULL,
>  				 &apqn, match_apqn);
>  	if (dev) {
>  		q = dev_get_drvdata(dev);
> -		vfio_ap_irq_disable(q);
>  		put_device(dev);
>  	}
> +
> +	return q;
>  }
>  
>  int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
> @@ -1164,6 +1165,7 @@ static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
>  	int rc = 0;
>  	unsigned long apid, apqi;
>  	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> +	struct vfio_ap_queue *q;
>  
>  	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm,
>  			     matrix_mdev->matrix.apm_max + 1) {
> @@ -1177,7 +1179,18 @@ static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
>  			 */
>  			if (ret)
>  				rc = ret;
> -			vfio_ap_irq_disable_apqn(AP_MKQID(apid, apqi));
> +
> +			/*
> +			 * Resetting a queue disables interrupts as a side
> +			 * effect, so there is no need to disable interrupts
> +			 * here. Note that an error on reset indicates the
> +			 * queue is inaccessible, so an attempt to disable
> +			 * interrupts would fail and is therefore unnecessary.
> +			 * Just free up the resources used by IRQ processing.
> +			 */

I have some concerns about this patch. One thing we must ensure is that
the machine does not poke freed memory (NIB, GISA). With the current
design that means we must ensure that there won't be any interruption
conditions indicated (and interrupts made pending) after this point.

I'm not entirely convinced this is ensured after your change. The
relevant bits of the  documentation are particularly hard to figure out.
I could use some clarifications for sure.

This hunk removes the wait implemented by vfio_ap_wait_for_irqclear()
along with the hopefully overkill AQIC.

Let me name some of the scenarios I'm concerned about, along with the
code that is currently supposed to handle these.


int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,              
                             unsigned int retry)                                
{                                                                               
        struct ap_queue_status status;                                          
        int retry2 = 2;                                                         
        int apqn = AP_MKQID(apid, apqi);                                        
                                                                                
        do {                                                                    
                status = ap_zapq(apqn);                                         
                switch (status.response_code) {                                 
                case AP_RESPONSE_NORMAL:                                        
                        while (!status.queue_empty && retry2--) {               
                                msleep(20);                                     
                                status = ap_tapq(apqn, NULL);                   
                        }                                                       
                        WARN_ON_ONCE(retry <= 0);                              
                        return 0;                                               
                case AP_RESPONSE_RESET_IN_PROGRESS:                             
                case AP_RESPONSE_BUSY:                                          
                        msleep(20);                                             
                        break;                                                  
                default:                                                        
                        /* things are really broken, give up */                 
                        return -EIO;                                            
                }                                                               
        } while (retry--);                                                      
                                                                                
        return -EBUSY; 

Scenario 1) 

ap_zapq() returns status.response_code == AP_RESPONSE_RESET_IN_PROGRESS,
because for example G2 did a ZAPQ before us.

The current logic retries ap_zapq() once after 20 msec. I have no idea
if that is sufficient under all circumstances. If we get a
AP_RESPONSE_RESET_IN_PROGRESS again, we return with -EBUSY and do nothing
about it if the whole process was triggered by vfio_ap_mdev_release().
Not even a warning.

Please notice that this was almost fine before IRQ support, because the
queue will get reset ASAP, and ...

Scenario 2)

It takes longer than 40 msec for the reset to complete. I don't know if
this is a possibility, but before your patch we used to wait of 1 sec.

I guess the we need the timeouts because do this with matrix_dev->lock
held. I'm not sure it's a good idea long term.

Scenario 3)

ap_zapq() returns status.response_code == AP_RESPONSE_DECONFIGURED. In
this case we would give up right away. Again so that we don't even know
we hit this case. There ain't much I can think about we could do here.

I hope we are guaranteed to  not get any bits set at this point, but I could
use some help.

                                  *

The good thing is I'm pretty sure that we are safe (i.e. no bits will be
poked by the hardware) after seeing the queue empty after we issued a
reset request.

So my concerns basically boil down to are the cumulative timeouts big enough
so we never time out (including are timeouts really the way to go)?

We should probably take any discussion about from which point on is it safe
to assume that NIB and GISA won't be poked by HW offline as the guys
without documentation can't contribute.


Two issues not directly related to your patch. I formulated those as two
follow up patches on top of yours .please take a look at them.

-------------------------------8<------------------------------------------
From: Halil Pasic <pasic@linux.ibm.com>
Date: Fri, 30 Aug 2019 16:03:42 +0200
Subject: [PATCH 1/2] s390: vfio-ap: fix warning reset not completed

The intention seems to be to warn once when we don't wait enough for the
reset to complete. Let's use the right retry counter to accomplish that
semantic.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index e3bcb43..dd07ebf 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1144,7 +1144,7 @@ int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
 				msleep(20);
 				status = ap_tapq(apqn, NULL);
 			}
-			WARN_ON_ONCE(retry <= 0);
+			WARN_ON_ONCE(retry2 <= 0);
 			return 0;
 		case AP_RESPONSE_RESET_IN_PROGRESS:
 		case AP_RESPONSE_BUSY:
-- 
2.5.5

-------------------------------8<----------------------------------------
From: Halil Pasic <pasic@linux.ibm.com>
Date: Fri, 30 Aug 2019 17:39:47 +0200
Subject: [PATCH 2/2] s390: vfio-ap: don't wait after AQIC interpretation

Waiting for the asynchronous part of AQIC to complete as a part
AQIC implementation is unnecessary and silly.

Let's get rid of vfio_ap_wait_for_irqclear().

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 50 ++-------------------------------------
 1 file changed, 2 insertions(+), 48 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index dd07ebf..8d098f0 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -68,47 +68,6 @@ static struct vfio_ap_queue *vfio_ap_get_queue(
 }
 
 /**
- * vfio_ap_wait_for_irqclear
- * @apqn: The AP Queue number
- *
- * Checks the IRQ bit for the status of this APQN using ap_tapq.
- * Returns if the ap_tapq function succeeded and the bit is clear.
- * Returns if ap_tapq function failed with invalid, deconfigured or
- * checkstopped AP.
- * Otherwise retries up to 5 times after waiting 20ms.
- *
- */
-static void vfio_ap_wait_for_irqclear(int apqn)
-{
-	struct ap_queue_status status;
-	int retry = 5;
-
-	do {
-		status = ap_tapq(apqn, NULL);
-		switch (status.response_code) {
-		case AP_RESPONSE_NORMAL:
-		case AP_RESPONSE_RESET_IN_PROGRESS:
-			if (!status.irq_enabled)
-				return;
-			/* Fall through */
-		case AP_RESPONSE_BUSY:
-			msleep(20);
-			break;
-		case AP_RESPONSE_Q_NOT_AVAIL:
-		case AP_RESPONSE_DECONFIGURED:
-		case AP_RESPONSE_CHECKSTOPPED:
-		default:
-			WARN_ONCE(1, "%s: tapq rc %02x: %04x\n", __func__,
-				  status.response_code, apqn);
-			return;
-		}
-	} while (--retry);
-
-	WARN_ONCE(1, "%s: tapq rc %02x: %04x could not clear IR bit\n",
-		  __func__, status.response_code, apqn);
-}
-
-/**
  * vfio_ap_free_aqic_resources
  * @q: The vfio_ap_queue
  *
@@ -133,14 +92,10 @@ static void vfio_ap_free_aqic_resources(struct vfio_ap_queue *q)
  * @q: The vfio_ap_queue
  *
  * Uses ap_aqic to disable the interruption and in case of success, reset
- * in progress or IRQ disable command already proceeded: calls
- * vfio_ap_wait_for_irqclear() to check for the IRQ bit to be clear
- * and calls vfio_ap_free_aqic_resources() to free the resources associated
+ * in progress or IRQ disable command already proceeded :calls
+ * vfio_ap_free_aqic_resources() to free the resources associated
  * with the AP interrupt handling.
  *
- * In the case the AP is busy, or a reset is in progress,
- * retries after 20ms, up to 5 times.
- *
  * Returns if ap_aqic function failed with invalid, deconfigured or
  * checkstopped AP.
  */
@@ -155,7 +110,6 @@ struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q)
 		switch (status.response_code) {
 		case AP_RESPONSE_OTHERWISE_CHANGED:
 		case AP_RESPONSE_NORMAL:
-			vfio_ap_wait_for_irqclear(q->apqn);
 			goto end_free;
 		case AP_RESPONSE_RESET_IN_PROGRESS:
 		case AP_RESPONSE_BUSY:
-- 
2.5.5
