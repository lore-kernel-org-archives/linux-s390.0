Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4672 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726152AbgKDVUg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 4 Nov 2020 16:20:36 -0500
Subject: Re: [PATCH v11 08/14] s390/vfio-ap: hot plug/unplug queues on
 bind/unbind of queue device
References: <20201022171209.19494-1-akrowiak@linux.ibm.com>
 <20201022171209.19494-9-akrowiak@linux.ibm.com>
 <20201028145725.1a81c5cf.pasic@linux.ibm.com>
 <055284df-87d8-507a-d7d7-05a73459322d@linux.ibm.com>
 <20201104135218.666bf0f5.pasic@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <eb27fc27-e236-7b16-9d8c-814bba816934@linux.ibm.com>
Date: Wed, 4 Nov 2020 16:20:26 -0500
MIME-Version: 1.0
In-Reply-To: <20201104135218.666bf0f5.pasic@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com



On 11/4/20 7:52 AM, Halil Pasic wrote:
> On Tue, 3 Nov 2020 17:49:21 -0500
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>>>>    
>>>> +void vfio_ap_mdev_hot_unplug_queue(struct vfio_ap_queue *q)
>>>> +{
>>>> +	unsigned long apid = AP_QID_CARD(q->apqn);
>>>> +
>>>> +	if ((q->matrix_mdev == NULL) || !vfio_ap_mdev_has_crycb(q->matrix_mdev))
>>>> +		return;
>>>> +
>>>> +	/*
>>>> +	 * If the APID is assigned to the guest, then let's
>>>> +	 * go ahead and unplug the adapter since the
>>>> +	 * architecture does not provide a means to unplug
>>>> +	 * an individual queue.
>>>> +	 */
>>>> +	if (test_bit_inv(apid, q->matrix_mdev->shadow_apcb.apm)) {
>>>> +		clear_bit_inv(apid, q->matrix_mdev->shadow_apcb.apm);
>>> Shouldn't we check aqm as well? I mean it may be clear at this point
>>> bacause of info->aqm. If the bit is clear, we don't have to remove
>>> the apm bit.
>> The rule we agreed upon is that if a queue is removed, we unplug
>> the card because we can't unplug an individual queue, so this code
>> is consistent with the stated rule.
> All I'm asking for is to verify that the queue is actually plugged. The
> queue is actually plugged iff
> test_bit_inv(apid, q->matrix_mdev->shadow_apcb.apm) && test_bit_inv(apqi,
> q->matrix_mdev->shadow_apcb.aqm).
>
> There is no point in unplugging the whole card, if the queue removed is
> unplugged in the first place.

No problem, I can make that change.

>
>> Typically, a queue is unplugged
>> because the adapter has been deconfigured or is broken which means
>> that all queues for that adapter will be removed in succession. On the
>> other hand, that situation would be handled when the last queue is
>> removed if we check the AQM, so I'm not adverse to making that
>> check if you insist.
> I don't agree. Let's detail your scenario. We have a nicely
> operating card which is as a whole passed trough to our guest. It
> goes broken, and the ap bus decides to deconstruct the queues.
> Already the first queue removed would unplug the the card, because
> both the apm and the aqm bits are set at this point. Subsequent removals
> then see that the apm bit is removed. Actually IMHO everything works
> like without the extra check on aqm (in this scenario).
>
> Would make reasoning about the code much easier to me, so sorry I do
> insist.

As you said, it works as-is in the scenario you pointed out:)
Whether it makes it any easier to understand the code is in
the eyes of the beholder (for example, I disagree),
but I'm willing to make the change, it's not a big deal.

>
>> Of course, if the queue is manually unbound from
>> the vfio driver, what you are asking for makes sense I suppose. I'll have
>> to think about this one some more, but feel free to respond to this.
> I'm not sure the situation where the queues ->mdev_matrix pointer is set
> but the apqi is not in the shadow_apcb can actually happen (races not
> considered).

Of course it can, for example:

1. No queues bound to vfio driver

2. APQN 04.0004 assigned to matrix mdev

3. Guest started:
     a. No bits set in shadow_apcb because no queues are bound to vfio

4. queue device 04.0004 is bound to the driver
     a. q->matrix_mdev is set because 04.0004 is assigned to matrix mdev
     b. apqi 0004 is not in shadow_apcb (see 3a.)


> But I'm sure the code is suggesting it can, because
> vfio_ap_mdev_filter_guest_matrix() has a third parameter called filter_apid,
> which governs whether the apm or the aqm bit should be removed. And
> vfio_ap_mdev_filter_guest_matrix() does get called with filter_apid=false in
> assign_domain_store() and I don't see subsequent unlink operations that would
> severe q->mdev_matrix.

I think you may be conflating two different things. The q in q->matrix_mdev
represents a queue device bound to the driver. The link to matrix_mdev
indicates the APQN of the queue device is assigned to the matrix_mdev.
When a new domain is assigned to matrix_mdev, we know that
all APQNS currently assigned to the shadow_apcb  are bound to the vfio 
driver
because of previous filtering, so we are only concerned with those APQNs
with the APQI of the new domain being assigned.

1. Queues bound to vfio_ap:
     04.0004
     04.0047
2. APQNs assigned to matrix_mdev:
     04.0004
     04.0047
3. shadow_apcb:
     04.0004
     04.0047
4. Assign domain 0054 to matrix_mdev
5. APQI 0054 gets filtered because 04.0054 not bound to vfio_ap
6. no change to shadow_apcb:
     04.0004
     04.0047

Or:

1. Queues bound to vfio_ap:
     04.0004
     04.0047
     04.0054
2. APQNs assigned to matrix_mdev:
     04.0004
     04.0047
3. shadow_apcb:
     04.0004
     04.0047
4. Assign domain 0054 to matrix_mdev
5. APQNs assigned to matrix_mdev
     04.0004
     04.0047
     04.0054
5. APQI 0054 does not get filtered because 04.0054 is bound to vfio_ap
6. shadow_apcb after filtering:
     04.0004
     04.0047
     04.0054

I'm not sure why you are bringing up unlinking in the context of assigning
a new domain. Unlinking only occurs when an APID or APQI is unassigned.

>
> Another case where the aqm may get filtered in
> vfio_ap_mdev_filter_guest_matrix() is the info->aqm bit not set, as I've
> mentioned in my previous mail. If that can not happen, we should turn
> that into an assert.

In an earlier email of yours, you brought up the scenario whereby
a queue is probed not because of a change in the QCI info,
but because an unbound queue is bound; for instance manually.
I made a change to account for that so consider the following
scenario:

1. APQI 0004 removed from info->aqm
2. AP bus notifies vfio_ap that AP configuration has changed
3. vfio_ap removes APQI 0004 from shadow_apcb
4. Userspace binds queue 04.0004 to vfio_ap
5. Filtering code filters 0004 because it has been removed
     from info->aqm
6. AP bus notifies vfio_ap scan is over

>
> Actually if you are convinced that apqi bit is always set in the
> q->matrix_mdev->shadow_apcb.aqm, I would agree to turning that into an
> assertion instead of condition. Then if not completely convinced, I
> could at least try to trigger the assert :).
>
> Regards,
> Halil
