Return-Path: <SRS0=l3iw=TE=vger.kernel.org=kvm-owner@kernel.org>
Date: Sat, 4 May 2019 15:58:12 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 00/10] s390: virtio: support protected virtualization
In-Reply-To: <20190503115511.17a1f6d1.cohuck@redhat.com>
References: <20190426183245.37939-1-pasic@linux.ibm.com>
        <20190503115511.17a1f6d1.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190504155812.1f7e55c0.pasic@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 3 May 2019 11:55:11 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Fri, 26 Apr 2019 20:32:35 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > Enhanced virtualization protection technology may require the use of
> > bounce buffers for I/O. While support for this was built into the virtio
> > core, virtio-ccw wasn't changed accordingly.
> > 
> > Some background on technology (not part of this series) and the
> > terminology used.
> > 
> > * Protected Virtualization (PV):
> > 
> > Protected Virtualization guarantees, that non-shared memory of a  guest
> > that operates in PV mode private to that guest. I.e. any attempts by the
> > hypervisor or other guests to access it will result in an exception. If
> > supported by the environment (machine, KVM, guest VM) a guest can decide
> > to change into PV mode by doing the appropriate ultravisor calls. Unlike
> > some other enhanced virtualization protection technology, 
> 
> I think that sentence misses its second part?
>

I wanted to kill the whole sentence, but killed only a part of
it. :( Sorry. If any, the sentence had only significance for judging how
well inherited some names fit.
  
> > 
> > * Ultravisor:
> > 
> > A hardware/firmware entity that manages PV guests, and polices access to
> > their memory. A PV guest prospect needs to interact with the ultravisor,
> > to enter PV mode, and potentially to share pages (for I/O which should
> > be encrypted by the guest). A guest interacts with the ultravisor via so
> > called ultravisor calls. A hypervisor needs to interact with the
> > ultravisor to facilitate interpretation, emulation and swapping. A
> > hypervisor  interacts with the ultravisor via ultravisor calls and via
> > the SIE state description. Generally the ultravisor sanitizes hypervisor
> > inputs so that the guest can not be corrupted (except for denial of
> > service.
> > 
> > 
> > What needs to be done
> > =====================
> > 
> > Thus what needs to be done to bring virtio-ccw up to speed with respect
> > to protected virtualization is:
> > * use some 'new' common virtio stuff
> 
> Doing this makes sense regardless of the protected virtualization use
> case, and I think we should go ahead and merge those patches for 5.2.
> 

I agree.

> > * make sure that virtio-ccw specific stuff uses shared memory when
> >   talking to the hypervisor (except control/communication blocks like ORB,
> >   these are handled by the ultravisor)
> 
> TBH, I'm still a bit hazy on what needs to use shared memory and what
> doesn't.
> 

It is all in the code :). To have complete and definitive answers here
we would need some sort of public UV architecture.

> > * make sure the DMA API does what is necessary to talk through shared
> >   memory if we are a protected virtualization guest.
> > * make sure the common IO layer plays along as well (airqs, sense).
> > 
> > 
> > Important notes
> > ================
> > 
> > * This patch set is based on Martins features branch
> >  (git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git branch
> >  'features').
> > 
> > * Documentation is still very sketchy. I'm committed to improving this,
> >   but I'm currently hampered by some dependencies currently.  
> 
> I understand, but I think this really needs more doc; also for people
> who want to understand the code in the future.
> 
> Unfortunately lack of doc also hampers others in reviewing this :/
>

I'm not sure how much can we do on the doc front. Without a complete
architecture, one basically needs to trust the guys with access to the
architecture.

Many thanks for your feedback. Regards,
Halil

[..]
