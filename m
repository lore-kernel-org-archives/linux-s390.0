Return-Path: <SRS0=rkwH=SM=vger.kernel.org=kvm-owner@kernel.org>
Date: Wed, 10 Apr 2019 02:10:44 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC PATCH 05/12] s390/cio: add protected virtualization
 support to cio
In-Reply-To: <20190409195548.6dea6e40.cohuck@redhat.com>
References: <20190404231622.52531-1-pasic@linux.ibm.com>
        <20190404231622.52531-6-pasic@linux.ibm.com>
        <20190409195548.6dea6e40.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190410021044.4da3e847@oc2783563651>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 9 Apr 2019 19:55:48 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Fri,  5 Apr 2019 01:16:15 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > Virtio-ccw relies on cio mechanisms for bootstrapping the ccw device.
> 
> Well, a ccw device is, by definition, using cio mechanisms ;)

Right, this was supposed to explain to the non-virtio guys why do I
have to deal with this stuff in cio in a series that is about virtio. I
was chiefly alluding to the SENSE stuff.

> 
> Better say: "As virtio-ccw devices are channel devices, we need to use
> the dma area for any communication with the hypervisor."
> Or something like that.

Sure we can come up with a better commit message. Your sentence is
already better than mine ;).

> 
> > Thus we need to make sure any memory that is used for communication with
> > the hypervisor is shared.
> 
> In this context, does 'hypervisor' always mean 'QEMU/KVM'? If Other
> Hypervisors implement protected virtualization, we probably need to
> make sure that all common I/O layer control blocks are in the dma area
> (including e.g. QDIO), not just what virtio-ccw devices use.
> 

Hypervisor could theoretically be something different than QEMU/KVM. Yet,
as stated before, this series is about getting virtio-ccw working
(modulo the TODOs). 

[..]

> >  
> 
> So, this leaves some things I'm not sure about, especially as I do not
> know the architecture of this new feature.
> 
> - This applies only to asynchronously handled things, it seems? So
>   things like control blocks modified by stsch/msch/etc does not need
>   special treatment?

I had a feeble attempt at explaining this in the cover letter:

* make sure that virtio-ccw specific stuff uses shared memory when
  talking to the hypervisor (except communication blocks like ORB, these
  are handled by the hypervisor)

Unfortunately the last 'hypervisor' was supposed to be 'ultravisor'.

I.e. the ultravisor will take care of exposing the control blocks
to the hypervisor (and of changes as well).

> - What about channel measurements? Or are they not supported?

For virtio-ccw channel measurements are not very relevant. I think
it should work as it used to, but I will give it another look later.

> - What about CHSCs? Or would only asynchronous commands (which we
>   currently don't implement in QEMU) need special treatment?
> 

CHSC is special. AFAIR the code of Vasily and Janosch is handling
what needs to be handled. But I will double-check this as well.

Regards,
Halil
