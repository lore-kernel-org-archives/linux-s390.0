Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6580 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405960AbgBNQYn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 14 Feb 2020 11:24:43 -0500
Subject: Re: [RFC PATCH v2 7/9] vfio-ccw: Wire up the CRW irq and CRW region
References: <20200206213825.11444-1-farman@linux.ibm.com>
 <20200206213825.11444-8-farman@linux.ibm.com>
 <20200214143400.175c9e5e.cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Message-ID: <75bb9119-8692-c18e-1e7b-c7598d8ef25a@linux.ibm.com>
Date: Fri, 14 Feb 2020 11:24:39 -0500
MIME-Version: 1.0
In-Reply-To: <20200214143400.175c9e5e.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org



On 2/14/20 8:34 AM, Cornelia Huck wrote:
> On Thu,  6 Feb 2020 22:38:23 +0100
> Eric Farman <farman@linux.ibm.com> wrote:
> 
>> From: Farhan Ali <alifm@linux.ibm.com>
>>
>> Use an IRQ to notify userspace that there is a CRW
>> pending in the region, related to path-availability
>> changes on the passthrough subchannel.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>> ---
>>
>> Notes:
>>     v1->v2:
>>      - Remove extraneous 0x0 in crw.rsid assignment [CH]
>>      - Refactor the building/queueing of a crw into its own routine [EF]
>>     
>>     v0->v1: [EF]
>>      - Place the non-refactoring changes from the previous patch here
>>      - Clean up checkpatch (whitespace) errors
>>      - s/chp_crw/crw/
>>      - Move acquire/release of io_mutex in vfio_ccw_crw_region_read()
>>        into patch that introduces that region
>>      - Remove duplicate include from vfio_ccw_drv.c
>>      - Reorder include in vfio_ccw_private.h
>>
>>  drivers/s390/cio/vfio_ccw_chp.c     |  5 ++
>>  drivers/s390/cio/vfio_ccw_drv.c     | 73 +++++++++++++++++++++++++++++
>>  drivers/s390/cio/vfio_ccw_ops.c     |  4 ++
>>  drivers/s390/cio/vfio_ccw_private.h |  9 ++++
>>  include/uapi/linux/vfio.h           |  1 +
>>  5 files changed, 92 insertions(+)
>>
> (...)
>> +static void vfio_ccw_alloc_crw(struct vfio_ccw_private *private,
>> +			       struct chp_link *link,
>> +			       unsigned int erc)
>> +{
>> +	struct vfio_ccw_crw *vc_crw;
>> +	struct crw *crw;
>> +
>> +	/*
>> +	 * If unable to allocate a CRW, just drop the event and
>> +	 * carry on.  The guest will either see a later one or
>> +	 * learn when it issues its own store subchannel.
>> +	 */
>> +	vc_crw = kzalloc(sizeof(*vc_crw), GFP_ATOMIC);
>> +	if (!vc_crw)
>> +		return;
>> +
>> +	/*
>> +	 * Build in the first CRW space, but don't chain anything
>> +	 * into the second one even though the space exists.
>> +	 */
>> +	crw = &vc_crw->crw[0];
>> +
>> +	/*
>> +	 * Presume every CRW we handle is reported by a channel-path.
>> +	 * Maybe not future-proof, but good for what we're doing now.
> 
> You could pass in a source indication, maybe? Presumably, at least one
> of the callers further up the chain knows...

The "chain" is the vfio_ccw_chp_event() function called off the
.chp_event callback, and then to this point.  So I don't think there's
much we can get back from our callchain, other than the CHP_xxxLINE
event that got us here.

> 
>> +	 *
>> +	 * FIXME Sort of a lie, since we're converting a CRW
>> +	 * reported by a channel-path into one issued to each
>> +	 * subchannel, but still saying it's coming from the path.
> 
> It's still channel-path related, though :)
> 
> The important point is probably is that userspace needs to be aware
> that the same channel-path related event is reported on all affected
> subchannels, and they therefore need some appropriate handling on their
> side.

This is true.  And the fact that the RSC and RSID fields will be in
agreement is helpful.  But yes, the fact that userspace should expect
the possibility of more than one CRW per channel path is the thing I'm
still not enjoying.  Mostly because of the race between queueing
additional ones, and unqueuing them on the other side.  So probably not
much that can be done here but awareness.

> 
>> +	 */
>> +	crw->rsc = CRW_RSC_CPATH;
>> +	crw->rsid = (link->chpid.cssid << 8) | link->chpid.id;
>> +	crw->erc = erc;
>> +
>> +	list_add_tail(&vc_crw->next, &private->crw);
>> +	queue_work(vfio_ccw_work_q, &private->crw_work);
>> +}
>> +
>>  static int vfio_ccw_chp_event(struct subchannel *sch,
>>  			      struct chp_link *link, int event)
>>  {
> (...)
> 
