Return-Path: <SRS0=oVSW=SZ=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [PATCH v3 1/1] vfio-ccw: Prevent quiesce function going into an
 infinite loop
References: <cover.1555449329.git.alifm@linux.ibm.com>
 <4d5a4b98ab1b41ac6131b5c36de18b76c5d66898.1555449329.git.alifm@linux.ibm.com>
 <20190417110348.28efc8e3.cohuck@redhat.com>
 <b7daaf7d-72e9-7e59-890c-620a4733b93d@linux.ibm.com>
 <20190417171311.3478402b@oc2783563651>
 <f457d63a-69b9-43da-c425-5c34fb0d9dd4@linux.ibm.com>
 <20190419221251.5b4aa9c8.pasic@linux.ibm.com>
 <8bd8ec0b-8b0c-3e74-1b14-7fad7470679e@linux.ibm.com>
 <20190423194251.093304c7.pasic@linux.ibm.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Tue, 23 Apr 2019 15:41:34 -0400
MIME-Version: 1.0
In-Reply-To: <20190423194251.093304c7.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <a2618478-4b98-a2c2-5f14-a91b193ebf53@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, pmorel@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>



On 04/23/2019 01:42 PM, Halil Pasic wrote:
> One thing I'm confused about is, that we don't seem to prevent
> new I/O being submitted. That is we could still loop indefinitely
> if we get new IO after the 'kill I/O on the subchannel' is done but
> before the msch() with the disable is issued.

So the quiesce function will be called in the remove, release functions 
and also in the mdev reset callback via an ioctl VFIO_DEVICE_RESET.

Now the release function is invoked in cases when we hot unplug the 
device or the guest is gone (or anything that will close the vfio mdev 
file descriptor, I believe). In such scenarios it's really the userspace 
which is asking to release the device. Similar for remove, where the 
user has to explicitly write to the remove file for the mdev to invoke 
it. Under normal conditions no sane userspace should be doing 
release/remove while there are still on going I/Os :)

Me and Conny had some discussion on this in v1 of this patch:
https://marc.info/?l=kvm&m=155437117823248&w=2

> 
> The 'flush all I/O' parts in the commit message and in the code make
> this even more confusing.

Maybe...if it's too confusing it could be fixed, but IMHO I don't think 
it's a dealbreaker. If anyone else thinks otherwise, I can go ahead and 
change it.

> 
> Another thing that I don't quite understand is injecting interrupts
> into QEMU for stuff that is actually not guest initiated.

As mentioned above under normal conditions we shouldn't be doing 
quiesce. But wouldn't those interrupts just be unsolicited interrupts 
for the guest?

> 
> Furthermore I find how cio_cancel_halt_clear() quite confusing. We
> usually return EBUSY to say that the function was suppressed because,
> well, the resource is busy. For cio_cancel_halt_clear() EBUSY means:
> * either a xsch() was effectively suppressed because status pending
> * or an hsch() or csch() was actually successfully executed, and the
> client code is supposed to wait for the assync clear/halt function
> to complete. This gets even more confusing when one reads:
> 
> /**
>   * cio_cancel_halt_clear - Cancel running I/O by performing cancel, halt
>   * and clear ordinally if subchannel is valid.
>   * @sch: subchannel on which to perform the cancel_halt_clear operation
>   * @iretry: the number of the times remained to retry the next operation
>   *
>   * This should be called repeatedly since halt/clear are asynchronous
> 
> This is simply not true. Because halt/clear is async, we may not know
> if we managed to accomplish canceling the running I/O. But the next
> call of this function won't detect and say 'yep it worked, we are good
> now' and return 0. This is the responsibility of the caller.
> 
> If it were like that, the current code would have been fine!
>             
>   * operations. We do one try with cio_cancel, three tries with cio_halt,
>   * 255 tries with cio_clear. The caller should initialize @iretry with
>   * the value 255 for its first call to this, and keep using the same
>   * @iretry in the subsequent calls until it gets a non -EBUSY return.
>   *
>   * Returns 0 if device now idle, -ENODEV for device not operational,
>   * -EBUSY if an interrupt is expected (either from halt/clear or from a
>   * status pending), and -EIO if out of retries.
>   */
> int cio_cancel_halt_clear(struct subchannel *sch, int *iretry
> 
> TL;DR:
> 
> I welcome  this batch (with an r-b) but I would like the commit message
> and the comment changed so that the misleading 'flush all I/O in the
> workqueue'.
> 
> I think 'vfio-ccw: fix cio_cancel_halt_clear() usage' would reflect the
> content of this patch better, because reasoning about the upper limit,
> and what happens if this upper limit is hit is not what this patch is
> about. It is about a client code bug that rendered iretry ineffective.
> 

I politely disagree with the change in subject line. I think the current 
subject line describe what we are trying to prevent with this patch. But 
again if anyone else feels otherwise, I will go ahead and change :)

Thanks
Farhan


> Regards,
> Halil
> 
> 
