Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48192 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729210AbfFGO3O (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 7 Jun 2019 10:29:14 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x57EML6Y132537
        for <linux-s390@vger.kernel.org>; Fri, 7 Jun 2019 10:29:12 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2syr5pw315-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 07 Jun 2019 10:29:12 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Fri, 7 Jun 2019 15:29:10 +0100
Date: Fri, 7 Jun 2019 16:29:03 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v9 3/4] s390: ap: implement PAPQ AQIC interception in
 kernel
In-Reply-To: <2ffee52b-5e7f-f52a-069f-0a43d6418341@linux.ibm.com>
References: <1558452877-27822-1-git-send-email-pmorel@linux.ibm.com>
        <1558452877-27822-4-git-send-email-pmorel@linux.ibm.com>
        <2ffee52b-5e7f-f52a-069f-0a43d6418341@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Message-Id: <20190607162903.22fd959f.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com, alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com

On Tue, 4 Jun 2019 15:38:51 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 5/21/19 11:34 AM, Pierre Morel wrote:
> > We register a AP PQAP instruction hook during the open
> > of the mediated device. And unregister it on release.

[..]

> > +/**
> > + * vfio_ap_wait_for_irqclear
> > + * @apqn: The AP Queue number
> > + *
> > + * Checks the IRQ bit for the status of this APQN using ap_tapq.
> > + * Returns if the ap_tapq function succedded and the bit is clear.
> 
> s/succedded/succeeded/
> 

I'm gonna fix this up when picking.

> > + * Returns if ap_tapq function failed with invalid, deconfigured or
> > + * checkstopped AP.
> > + * Otherwise retries up to 5 times after waiting 20ms.
> > + *
> > + */
> > +static void vfio_ap_wait_for_irqclear(int apqn)
> > +{
> > +	struct ap_queue_status status;
> > +	int retry = 5;
> > +
> > +	do {
> > +		status = ap_tapq(apqn, NULL);
> > +		switch (status.response_code) {
> > +		case AP_RESPONSE_NORMAL:
> > +		case AP_RESPONSE_RESET_IN_PROGRESS:
> > +			if (!status.irq_enabled)
> > +				return;
> > +			/* Fall through */
> > +		case AP_RESPONSE_BUSY:
> > +			msleep(20);
> > +			break;
> > +		case AP_RESPONSE_Q_NOT_AVAIL:
> > +		case AP_RESPONSE_DECONFIGURED:
> > +		case AP_RESPONSE_CHECKSTOPPED:
> > +		default:
> > +			WARN_ONCE(1, "%s: tapq rc %02x: %04x\n", __func__,
> > +				  status.response_code, apqn);
> > +			return;
> 
> Why not just break out of the loop and just use the WARN_ONCE
> outside of the loop?
> 

AFAIU the idea was to differentiate between got a strange response_code
and ran out of retires.

Actually I suspect that we are fine in case of AP_RESPONSE_Q_NOT_AVAIL,
 AP_RESPONSE_DECONFIGURED and AP_RESPONSE_CHECKSTOPPED in a sense that
what should be the post-condition of this function is guaranteed to be
reached. What do you think?

While I think that we can do better here, I see this as something that
should be done on top.

> > +		}
> > +	} while (--retry);
> > +
> > +	WARN_ONCE(1, "%s: tapq rc %02x: %04x could not clear IR bit\n",
> > +		  __func__, status.response_code, apqn);
> > +}
> > +
> > +/**
> > + * vfio_ap_free_aqic_resources
> > + * @q: The vfio_ap_queue
> > + *
> > + * Unregisters the ISC in the GIB when the saved ISC not invalid.
> > + * Unpin the guest's page holding the NIB when it exist.
> > + * Reset the saved_pfn and saved_isc to invalid values.
> > + * Clear the pointer to the matrix mediated device.
> > + *
> > + */

[..]

> > +struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q)
> > +{
> > +	struct ap_qirq_ctrl aqic_gisa = {};
> > +	struct ap_queue_status status;
> > +	int retries = 5;
> > +
> > +	do {
> > +		status = ap_aqic(q->apqn, aqic_gisa, NULL);
> > +		switch (status.response_code) {
> > +		case AP_RESPONSE_OTHERWISE_CHANGED:
> > +		case AP_RESPONSE_NORMAL:
> > +			vfio_ap_wait_for_irqclear(q->apqn);
> > +			goto end_free;
> > +		case AP_RESPONSE_RESET_IN_PROGRESS:
> > +		case AP_RESPONSE_BUSY:
> > +			msleep(20);
> > +			break;
> > +		case AP_RESPONSE_Q_NOT_AVAIL:
> > +		case AP_RESPONSE_DECONFIGURED:
> > +		case AP_RESPONSE_CHECKSTOPPED:
> > +		case AP_RESPONSE_INVALID_ADDRESS:
> > +		default:
> > +			/* All cases in default means AP not operational */
> > +			WARN_ONCE(1, "%s: ap_aqic status %d\n", __func__,
> > +				  status.response_code);
> > +			goto end_free;
> 
> Why not just break out of the loop instead of repeating the WARN_ONCE
> message?
> 

I suppose the reason is same as above. I'm not entirely happy with this
code myself. E.g. why do we do retries here -- shouldn't we just fail the
aqic by the guest?

[..]

> > +static int handle_pqap(struct kvm_vcpu *vcpu)
> > +{
> > +	uint64_t status;
> > +	uint16_t apqn;
> > +	struct vfio_ap_queue *q;
> > +	struct ap_queue_status qstatus = {
> > +			       .response_code = AP_RESPONSE_Q_NOT_AVAIL, };
> > +	struct ap_matrix_mdev *matrix_mdev;
> > +
> > +	/* If we do not use the AIV facility just go to userland */
> > +	if (!(vcpu->arch.sie_block->eca & ECA_AIV))
> > +		return -EOPNOTSUPP;
> > +
> > +	apqn = vcpu->run->s.regs.gprs[0] & 0xffff;
> > +	mutex_lock(&matrix_dev->lock);
> > +
> > +	if (!vcpu->kvm->arch.crypto.pqap_hook)
> 
> Wasn't this already checked in patch 2 prior to calling this
> function? In fact, doesn't the hook point to this function?
> 

Let us benevolently call this defensive programming. We are actually
in that callback AFAICT, so it sure was set a moment ago, and I guess
the client code still holds the kvm.lock so it is guaranteed to stay
so unless somebody is playing foul.

We can address this with a patch on top.

Regards,
Halil
