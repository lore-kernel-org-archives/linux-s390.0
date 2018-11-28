From: Farhan Ali <alifm@linux.ibm.com>
Subject: Re: [PATCH 3/3] vfio-ccw: add handling for asnyc
 channel instructions
Date: Wed, 28 Nov 2018 09:31:51 -0500
Message-ID: <25021742-a7a8-a90c-a2a3-eb8a78bf1fb0@linux.ibm.com>
References: <20181122165432.4437-1-cohuck@redhat.com>
	<20181122165432.4437-4-cohuck@redhat.com>
	<b5066f7a-7024-ac3e-a91d-938fd845e1d9@linux.ibm.com>
	<20181128100249.72d4299a.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
In-Reply-To: <20181128100249.72d4299a.cohuck@redhat.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org
List-ID: <linux-s390.vger.kernel.org>



On 11/28/2018 04:02 AM, Cornelia Huck wrote:
> On Tue, 27 Nov 2018 14:09:49 -0500
> Farhan Ali <alifm@linux.ibm.com> wrote:
> 
>> On 11/22/2018 11:54 AM, Cornelia Huck wrote:
>>> Add a region to the vfio-ccw device that can be used to submit
>>> asynchronous I/O instructions. ssch continues to be handled by the
>>> existing I/O region; the new region handles hsch and csch.
>>>
>>> Interrupt status continues to be reported through the same channels
>>> as for ssch.
>>>
>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>> ---
>>>    drivers/s390/cio/Makefile           |   3 +-
>>>    drivers/s390/cio/vfio_ccw_async.c   |  88 ++++++++++++++++
>>>    drivers/s390/cio/vfio_ccw_drv.c     |  48 ++++++---
>>>    drivers/s390/cio/vfio_ccw_fsm.c     | 158 +++++++++++++++++++++++++++-
>>>    drivers/s390/cio/vfio_ccw_ops.c     |  13 ++-
>>>    drivers/s390/cio/vfio_ccw_private.h |   6 ++
>>>    include/uapi/linux/vfio.h           |   4 +
>>>    include/uapi/linux/vfio_ccw.h       |  12 +++
>>>    8 files changed, 313 insertions(+), 19 deletions(-)
>>>    create mode 100644 drivers/s390/cio/vfio_ccw_async.c
>>>
> 
>>> @@ -76,7 +79,8 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
>>>    	private = container_of(work, struct vfio_ccw_private, io_work);
>>>    	irb = &private->irb;
>>>    
>>> -	if (scsw_is_solicited(&irb->scsw)) {
>>> +	if (scsw_is_solicited(&irb->scsw) &&
>>> +	    (scsw_fctl(&irb->scsw) & SCSW_FCTL_START_FUNC)) {
>>>    		cp_update_scsw(&private->cp, &irb->scsw);
>>>    		cp_free(&private->cp);
>>>    	}
>>
>> I am a little confused about this. Why do we need to update the scsw.cpa
>> if we have the start function function control bit set? Is it an
>> optimization?
> 
> No, it's not an optimization. This is the work function that is
> scheduled if we get an interrupt for the device. Previously, we only
> got an interrupt if either the device presented us an unsolicited
> status or if we got an interrupt as a response to the channel program
> we submitted. Now, we can get an interrupt for halt/clear subchannel as
> well, and in that case, we don't necessarily have a cp.
> 
> [Thinking some more about it, we need to verify if the start function
> actually remains set if we try to terminate a running channel program
> with halt/clear. A clear might scrub too much. If that's the case, we
> also need to free the cp if the start function is not set.]
> 
> 

According to PoPs (Chapter 16: I/O interruptions, under function control):

The start-function indication is also cleared at
the subchannel during the execution of CLEAR SUB-
CHANNEL.

So maybe we do need to free the cp.
