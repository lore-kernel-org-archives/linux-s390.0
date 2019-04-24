Return-Path: <SRS0=OpZk=S2=vger.kernel.org=kvm-owner@kernel.org>
Date: Wed, 24 Apr 2019 09:09:15 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 1/1] vfio-ccw: Prevent quiesce function going into an
 infinite loop
Message-ID: <20190424090915.4a5ab1d9.cohuck@redhat.com>
In-Reply-To: <a2618478-4b98-a2c2-5f14-a91b193ebf53@linux.ibm.com>
References: <cover.1555449329.git.alifm@linux.ibm.com>
        <4d5a4b98ab1b41ac6131b5c36de18b76c5d66898.1555449329.git.alifm@linux.ibm.com>
        <20190417110348.28efc8e3.cohuck@redhat.com>
        <b7daaf7d-72e9-7e59-890c-620a4733b93d@linux.ibm.com>
        <20190417171311.3478402b@oc2783563651>
        <f457d63a-69b9-43da-c425-5c34fb0d9dd4@linux.ibm.com>
        <20190419221251.5b4aa9c8.pasic@linux.ibm.com>
        <8bd8ec0b-8b0c-3e74-1b14-7fad7470679e@linux.ibm.com>
        <20190423194251.093304c7.pasic@linux.ibm.com>
        <a2618478-4b98-a2c2-5f14-a91b193ebf53@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, pmorel@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Tue, 23 Apr 2019 15:41:34 -0400
Farhan Ali <alifm@linux.ibm.com> wrote:

> On 04/23/2019 01:42 PM, Halil Pasic wrote:
> > One thing I'm confused about is, that we don't seem to prevent
> > new I/O being submitted. That is we could still loop indefinitely
> > if we get new IO after the 'kill I/O on the subchannel' is done but
> > before the msch() with the disable is issued.  
> 
> So the quiesce function will be called in the remove, release functions 
> and also in the mdev reset callback via an ioctl VFIO_DEVICE_RESET.
> 
> Now the release function is invoked in cases when we hot unplug the 
> device or the guest is gone (or anything that will close the vfio mdev 
> file descriptor, I believe). In such scenarios it's really the userspace 
> which is asking to release the device. Similar for remove, where the 
> user has to explicitly write to the remove file for the mdev to invoke 
> it. Under normal conditions no sane userspace should be doing 
> release/remove while there are still on going I/Os :)
> 
> Me and Conny had some discussion on this in v1 of this patch:
> https://marc.info/?l=kvm&m=155437117823248&w=2
> 
> > 
> > The 'flush all I/O' parts in the commit message and in the code make
> > this even more confusing.  
> 
> Maybe...if it's too confusing it could be fixed, but IMHO I don't think 
> it's a dealbreaker. If anyone else thinks otherwise, I can go ahead and 
> change it.

I think it's fine -- I wasn't confused.

> 
> > 
> > Another thing that I don't quite understand is injecting interrupts
> > into QEMU for stuff that is actually not guest initiated.  
> 
> As mentioned above under normal conditions we shouldn't be doing 
> quiesce. But wouldn't those interrupts just be unsolicited interrupts 
> for the guest?

Yes, you simply cannot keep an enabled subchannel from getting status
pending with unsolicited status.

> 
> > 
> > Furthermore I find how cio_cancel_halt_clear() quite confusing. We

Well, that's a problem (if any) with the common I/O layer and beyond
the scope of this patch.

> > TL;DR:
> > 
> > I welcome  this batch (with an r-b) but I would like the commit message

So, what does this sentence mean? Confused.

> > and the comment changed so that the misleading 'flush all I/O in the
> > workqueue'.
> > 
> > I think 'vfio-ccw: fix cio_cancel_halt_clear() usage' would reflect the
> > content of this patch better, because reasoning about the upper limit,
> > and what happens if this upper limit is hit is not what this patch is
> > about. It is about a client code bug that rendered iretry ineffective.
> >   
> 
> I politely disagree with the change in subject line. I think the current 
> subject line describe what we are trying to prevent with this patch. But 
> again if anyone else feels otherwise, I will go ahead and change :)

No, I agree that the subject line is completely fine.
