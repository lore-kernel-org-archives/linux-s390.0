Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39466 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730633AbfIELD5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 Sep 2019 07:03:57 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x85AvD0Z100465
        for <linux-s390@vger.kernel.org>; Thu, 5 Sep 2019 07:03:55 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2utx8r79c9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 05 Sep 2019 07:03:55 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Thu, 5 Sep 2019 12:03:53 +0100
Date: Thu, 5 Sep 2019 13:03:46 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2] s390: vfio-ap: remove unnecessary calls to disable
 queue interrupts
In-Reply-To: <206538dc-c86b-6509-78ba-7228d2eb75c9@linux.ibm.com>
References: <1566236929-18995-1-git-send-email-akrowiak@linux.ibm.com>
        <20190830180250.79804f76.pasic@linux.ibm.com>
        <f3e8d65e-bad4-c639-c53e-57585b90986d@de.ibm.com>
        <206538dc-c86b-6509-78ba-7228d2eb75c9@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Message-Id: <20190905130346.20db4692.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, freude@de.ibm.com, cohuck@redhat.com, pasic@linux.vnet.ibm.com, frankja@linux.ibm.com, jjherne@linux.ibm.com

On Wed, 4 Sep 2019 11:05:24 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 9/4/19 3:35 AM, Christian Borntraeger wrote:
> > Halil,
> > 
> > can you also send this patch as a separate mail. This also requires a much better
> > patch description about the why and it certainly should also have an agreement from
> > Anthony.
> > 
> > On 30.08.19 18:02, Halil Pasic wrote:
> >> From: Halil Pasic <pasic@linux.ibm.com>
> >> Date: Fri, 30 Aug 2019 17:39:47 +0200
> >> Subject: [PATCH 2/2] s390: vfio-ap: don't wait after AQIC interpretation
> >>
> >> Waiting for the asynchronous part of AQIC to complete as a part
> >> AQIC implementation is unnecessary and silly.
> >>
> >> Let's get rid of vfio_ap_wait_for_irqclear().
> >>
> >> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> >> ---
> >>   drivers/s390/crypto/vfio_ap_ops.c | 50 ++-------------------------------------
> >>   1 file changed, 2 insertions(+), 48 deletions(-)
> >>
> >> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> >> index dd07ebf..8d098f0 100644
> >> --- a/drivers/s390/crypto/vfio_ap_ops.c
> >> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> >> @@ -68,47 +68,6 @@ static struct vfio_ap_queue *vfio_ap_get_queue(
> >>   }
> >>   
> >>   /**
> >> - * vfio_ap_wait_for_irqclear
> >> - * @apqn: The AP Queue number
> >> - *
> >> - * Checks the IRQ bit for the status of this APQN using ap_tapq.
> >> - * Returns if the ap_tapq function succeeded and the bit is clear.
> >> - * Returns if ap_tapq function failed with invalid, deconfigured or
> >> - * checkstopped AP.
> >> - * Otherwise retries up to 5 times after waiting 20ms.
> >> - *
> >> - */
> >> -static void vfio_ap_wait_for_irqclear(int apqn)
> >> -{
> >> -	struct ap_queue_status status;
> >> -	int retry = 5;
> >> -
> >> -	do {
> >> -		status = ap_tapq(apqn, NULL);
> >> -		switch (status.response_code) {
> >> -		case AP_RESPONSE_NORMAL:
> >> -		case AP_RESPONSE_RESET_IN_PROGRESS:
> >> -			if (!status.irq_enabled)
> >> -				return;
> >> -			/* Fall through */
> >> -		case AP_RESPONSE_BUSY:
> >> -			msleep(20);
> >> -			break;
> >> -		case AP_RESPONSE_Q_NOT_AVAIL:
> >> -		case AP_RESPONSE_DECONFIGURED:
> >> -		case AP_RESPONSE_CHECKSTOPPED:
> >> -		default:
> >> -			WARN_ONCE(1, "%s: tapq rc %02x: %04x\n", __func__,
> >> -				  status.response_code, apqn);
> >> -			return;
> >> -		}
> >> -	} while (--retry);
> >> -
> >> -	WARN_ONCE(1, "%s: tapq rc %02x: %04x could not clear IR bit\n",
> >> -		  __func__, status.response_code, apqn);
> >> -}
> >> -
> >> -/**
> >>    * vfio_ap_free_aqic_resources
> >>    * @q: The vfio_ap_queue
> >>    *
> >> @@ -133,14 +92,10 @@ static void vfio_ap_free_aqic_resources(struct vfio_ap_queue *q)
> >>    * @q: The vfio_ap_queue
> >>    *
> >>    * Uses ap_aqic to disable the interruption and in case of success, reset
> >> - * in progress or IRQ disable command already proceeded: calls
> >> - * vfio_ap_wait_for_irqclear() to check for the IRQ bit to be clear
> >> - * and calls vfio_ap_free_aqic_resources() to free the resources associated
> >> + * in progress or IRQ disable command already proceeded :calls
> >> + * vfio_ap_free_aqic_resources() to free the resources associated
> >>    * with the AP interrupt handling.
> >>    *
> >> - * In the case the AP is busy, or a reset is in progress,
> >> - * retries after 20ms, up to 5 times.
> >> - *
> >>    * Returns if ap_aqic function failed with invalid, deconfigured or
> >>    * checkstopped AP.
> >>    */
> >> @@ -155,7 +110,6 @@ struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q)
> >>   		switch (status.response_code) {
> >>   		case AP_RESPONSE_OTHERWISE_CHANGED:
> >>   		case AP_RESPONSE_NORMAL:
> >> -			vfio_ap_wait_for_irqclear(q->apqn);
> 
> I am not sure why you consider the wait unnecessary and silly. 

Because the async function associated with AQIC is not supposed/required
to finish during the execution of AQIC. But yes, there is a problem with
this patch.

> Notice
> the response code AP_RESPONSE_OTHERWISE_CHANGED above which means that
> the AP queue is already disabled for interrupts or the enablement
> process has not yet completed.

IMHO we should finish the interpretation of AQIC with response code
AP_RESPONSE_OTHERWISE_CHANGED without any wait. It's up to the guest
to respond to this condition in whatever way it likes, and not up to
us to stall the vcpu.

> Shouldn't we wait for the IRQ to clear
> in this case? I do agree that there is no need to wait if the
> response code is 0.

And the problem with this patch of mine is that we may not call 
vfio_ap_free_aqic_resources(q) before the interrupts are really disabled. The
nib needs to remain pinned until the interrupts are really disabled for
the queue. Please notice that this is the case for response code 0 as
well.

So if we don't want to do error handling and retry and wait
for the guest, we would need to do the cleanup async -- or don't do
any cleanup on AQIC with disable.

Honestly I'm not sure any more what is the smallest evil. Opinions?

Regards,
Halil

> 
> >>   			goto end_free;
> >>   		case AP_RESPONSE_RESET_IN_PROGRESS:
> >>   		case AP_RESPONSE_BUSY:
> >> -- 2.5.5
> > 
> 
