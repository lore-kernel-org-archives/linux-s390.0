Return-Path: <SRS0=OpZk=S2=vger.kernel.org=kvm-owner@kernel.org>
Date: Wed, 24 Apr 2019 12:21:10 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v3 1/1] vfio-ccw: Prevent quiesce function going into an
 infinite loop
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
Message-Id: <20190424122110.78d9b1f8.pasic@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, pmorel@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Tue, 23 Apr 2019 15:41:34 -0400
Farhan Ali <alifm@linux.ibm.com> wrote:

> 
> 
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

So you say userspace has to take care of it. Is this documented
somewhere? Does QEMU actually take care of it?

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
> 

I responded to Connie. No it is not a dealbreaker. But I prefer not
disseminating false information.

[..]

Regarding the rest of the points from her, I responded to Connie's
follow up as well.

Cheers,
Halil
