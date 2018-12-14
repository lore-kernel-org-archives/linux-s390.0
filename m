From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v3 6/6] vfio: ccw: serialize the write system calls
Date: Fri, 14 Dec 2018 15:08:07 +0100
Message-ID: <62caa2ce-9830-ff6f-def3-495c3a040dac@linux.ibm.com>
References: <1543408867-16465-1-git-send-email-pmorel@linux.ibm.com>
 <1543408867-16465-7-git-send-email-pmorel@linux.ibm.com>
 <20181213163953.5b534e6b.cohuck@redhat.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181213163953.5b534e6b.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: pasic@linux.vnet.ibm.com, farman@linux.ibm.com, alifm@linux.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 13/12/2018 16:39, Cornelia Huck wrote:
> On Wed, 28 Nov 2018 13:41:07 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> When the user program is QEMU we rely on the QEMU lock to serialize
>> the calls to the driver.
>>
>> In the general case we need to make sure that two data transfer are
>> not started at the same time.
>> It would in the current implementation resul in a overwriting of the
>> IO region.
>>
>> We also need to make sure a clear or a halt started after a data
>> transfer do not win the race agains the data transfer.
>> Which would result in the data transfer being started after the
>> halt/clear.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   drivers/s390/cio/vfio_ccw_ops.c | 17 +++++++++++++----
>>   1 file changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
>> index eb5b49d..b316966 100644
>> --- a/drivers/s390/cio/vfio_ccw_ops.c
>> +++ b/drivers/s390/cio/vfio_ccw_ops.c
>> @@ -267,22 +267,31 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
>>   {
>>   	unsigned int index = VFIO_CCW_OFFSET_TO_INDEX(*ppos);
>>   	struct vfio_ccw_private *private;
>> +	static atomic_t serialize  = ATOMIC_INIT(0);
>> +	int ret = -EINVAL;
>> +
>> +	if (!atomic_add_unless(&serialize, 1, 1))
>> +		return -EBUSY;
> 
> I think that hammer is far too big: This serializes _all_ write
> operations across _all_ devices.

Right, much too much.
This should go inside the device.
(Don't know what I was thinking of).


> 
> There are various cases of simultaneous writes that may happen
> (assuming any userspace; QEMU locking will prevent some of them from
> happening):
> 
> - One thread does a write for one mdev, another thread does a write for
>    another mdev. For example, if two vcpus issue an I/O instruction on
>    two different devices. This should be fine.
> - One thread does a write for one mdev, another thread does a write for
>    the same mdev. Maybe a guest has confused/no locking and is trying to
>    do ssch on the same device from different vcpus. There, we want to
>    exclude simultaneous writes; the desired outcome may be that one ssch
>    gets forwarded to the hardware, and the second one either gets
>    forwarded after processing for the first one has finished, or
>    userspace gets an error immediately (hopefully resulting in a
>    appropriate condition code for that second ssch in any case). Both
>    handing the second ssch to the hardware or signaling device busy
>    immediately are probably sane in that case.

should be.

> - If those writes for the same device involve hsch/csch, things get
>    more complicated. First, we have two different regions, and allowing
>    simultaneous writes to the I/O region and to the async region should
>    not really be a problem, so I don't think fencing should be done in
>    the generic write handler. Second, the semantics for device busy are
>    different: a hsch immediately after a ssch should not give device
>    busy, and csch cannot return device busy at all.

The lock should be done in the device and only for SSCH.
We did not have CSCH or HSCH at the moment I sent the patch.

It is clear that CSCH or HSCH should not be blocked.

> 
> I don't think we'll be able to get around some kind of "let's retry
> sending this" logic for hsch/csch; maybe we should already do that for
> ssch. (Like the -EINVAL logic I described in the other thread.)
> 
> 

As I wrote in the cover letter this (stupid) patch is decoupled from the 
series.
I made the mistake to attach it here but I hope you will consider the 
rest of the serie which I think is much more important.

The handling of a lock / busy waiting here should wait for your serie on 
HSCH/CSCH anyway.

Regards,
Pierre




-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
