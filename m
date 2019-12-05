Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41084 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730237AbfLEUpl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 Dec 2019 15:45:41 -0500
From: Eric Farman <farman@linux.ibm.com>
Subject: Re: [RFC PATCH v1 08/10] vfio-ccw: Wire up the CRW irq and CRW region
References: <20191115025620.19593-1-farman@linux.ibm.com>
 <20191115025620.19593-9-farman@linux.ibm.com>
 <20191119195236.35189d5b.cohuck@redhat.com>
Message-ID: <02d98858-ddac-df7e-96a6-7c61335d3cee@linux.ibm.com>
Date: Thu, 5 Dec 2019 15:43:55 -0500
MIME-Version: 1.0
In-Reply-To: <20191119195236.35189d5b.cohuck@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>



On 11/19/19 1:52 PM, Cornelia Huck wrote:
> On Fri, 15 Nov 2019 03:56:18 +0100
> Eric Farman <farman@linux.ibm.com> wrote:
> 
>> From: Farhan Ali <alifm@linux.ibm.com>
>>
>> Use an IRQ to notify userspace that there is a CRW
>> pending in the region, related to path-availability
>> changes on the passthrough subchannel.
> 
> Thinking a bit more about this, it feels a bit odd that a crw for a
> chpid ends up on one subchannel. What happens if we have multiple
> subchannels passed through by vfio-ccw that use that same chpid?

Yeah...  It doesn't end up on one subchannel, it ends up on every
affected subchannel, based on the loops in (for example)
chsc_chp_offline().  This means that "let's configure off a CHPID to the
LPAR" translates one channel-path CRW into N channel-path CRWs (one each
sent to N subchannels).  It would make more sense if we just presented
one channel-path CRW to the guest, but I'm having difficulty seeing how
we could wire this up.  What we do here is use the channel-path event
handler in vfio-ccw also create a channel-path CRW to be presented to
the guest, even though it's processing something at the subchannel level.

The actual CRW handlers are in the base cio code, and we only get into
vfio-ccw when processing the individual subchannels.  Do we need to make
a device (or something?) at the guest level for the chpids that exist?
Or do something to say "hey we got this from a subchannel, put it on a
global queue if it's unique, or throw it away if it's a duplicate we
haven't processed yet" ?  Thoughts?

> 
>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>> ---
>>
>> Notes:
>>     v0->v1: [EF]
>>      - Place the non-refactoring changes from the previous patch here
>>      - Clean up checkpatch (whitespace) errors
>>      - s/chp_crw/crw/
>>      - Move acquire/release of io_mutex in vfio_ccw_crw_region_read()
>>        into patch that introduces that region
>>      - Remove duplicate include from vfio_ccw_drv.c
>>      - Reorder include in vfio_ccw_private.h
>>
>>  drivers/s390/cio/vfio_ccw_drv.c     | 27 +++++++++++++++++++++++++++
>>  drivers/s390/cio/vfio_ccw_ops.c     |  4 ++++
>>  drivers/s390/cio/vfio_ccw_private.h |  4 ++++
>>  include/uapi/linux/vfio.h           |  1 +
>>  4 files changed, 36 insertions(+)
>>
>> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
>> index d1b9020d037b..ab20c32e5319 100644
>> --- a/drivers/s390/cio/vfio_ccw_drv.c
>> +++ b/drivers/s390/cio/vfio_ccw_drv.c
>> @@ -108,6 +108,22 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
>>  		eventfd_signal(private->io_trigger, 1);
>>  }
>>  
>> +static void vfio_ccw_crw_todo(struct work_struct *work)
>> +{
>> +	struct vfio_ccw_private *private;
>> +	struct crw *crw;
>> +
>> +	private = container_of(work, struct vfio_ccw_private, crw_work);
>> +	crw = &private->crw;
>> +
>> +	mutex_lock(&private->io_mutex);
>> +	memcpy(&private->crw_region->crw0, crw, sizeof(*crw));
> 
> This looks a bit inflexible. Should we want to support subchannel crws
> in the future, we'd need to copy two crws.
> 
> Maybe keep two crws (they're not that large, anyway) in the private
> structure and copy the second one iff the first one has the chaining
> bit on?

That's a good idea.

> 
>> +	mutex_unlock(&private->io_mutex);
>> +
>> +	if (private->crw_trigger)
>> +		eventfd_signal(private->crw_trigger, 1);
>> +}
>> +
>>  /*
>>   * Css driver callbacks
>>   */
>> @@ -187,6 +203,7 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
>>  		goto out_free;
>>  
>>  	INIT_WORK(&private->io_work, vfio_ccw_sch_io_todo);
>> +	INIT_WORK(&private->crw_work, vfio_ccw_crw_todo);
>>  	atomic_set(&private->avail, 1);
>>  	private->state = VFIO_CCW_STATE_STANDBY;
>>  
>> @@ -303,6 +320,11 @@ static int vfio_ccw_chp_event(struct subchannel *sch,
>>  	case CHP_OFFLINE:
>>  		/* Path is gone */
>>  		cio_cancel_halt_clear(sch, &retry);
>> +		private->crw.rsc = CRW_RSC_CPATH;
>> +		private->crw.rsid = 0x0 | (link->chpid.cssid << 8) |
> 
> What's the leading '0x0' for?

Um, yeah.  It's SUPER important.  :)

> 
>> +				    link->chpid.id;
>> +		private->crw.erc = CRW_ERC_PERRN;
>> +		queue_work(vfio_ccw_work_q, &private->crw_work);
>>  		break;
>>  	case CHP_VARY_ON:
>>  		/* Path logically turned on */
>> @@ -312,6 +334,11 @@ static int vfio_ccw_chp_event(struct subchannel *sch,
>>  	case CHP_ONLINE:
>>  		/* Path became available */
>>  		sch->lpm |= mask & sch->opm;
>> +		private->crw.rsc = CRW_RSC_CPATH;
>> +		private->crw.rsid = 0x0 | (link->chpid.cssid << 8) |
>> +				    link->chpid.id;
>> +		private->crw.erc = CRW_ERC_INIT;
>> +		queue_work(vfio_ccw_work_q, &private->crw_work);
> 
> Isn't that racy? Imagine you get one notification for a chpid and queue
> it. Then, you get another notification for another chpid and queue it
> as well. Depending on when userspace reads, it gets different chpids.
> Moreover, a crw may be lost... or am I missing something obvious?

Nope, you're right on.  If I start thrashing config on/off chpids on the
host, I eventually fall down with all sorts of weirdness.

> 
> Maybe you need a real queue for the generated crws?

I guess this is what I'm wrestling with...  We don't have a queue for
guest-wide work items, as it's currently broken apart by subchannel.  Is
adding one at the vfio-ccw level right?  Feels odd to me, since multiple
guests could use devices connected via vfio-ccw, which may or may share
common chpids.

I have a rough hack that serializes things a bit, while still keeping
the CRW duplication at the subchannel level.  Things improve
considerably, but it still seems odd to me.  I'll keep working on that
unless anyone has any better ideas.

> 
>>  		break;
>>  	}
>>  
> 
