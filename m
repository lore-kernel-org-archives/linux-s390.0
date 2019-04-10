Return-Path: <SRS0=rkwH=SM=vger.kernel.org=kvm-owner@kernel.org>
Date: Wed, 10 Apr 2019 17:57:50 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC PATCH 00/12] s390: virtio: support protected
 virtualization
In-Reply-To: <20190410112048.154c96fc.cohuck@redhat.com>
References: <20190404231622.52531-1-pasic@linux.ibm.com>
        <20190410112048.154c96fc.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Message-Id: <20190410175750.0ed0a454@oc2783563651>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 10 Apr 2019 11:20:48 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Fri,  5 Apr 2019 01:16:10 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > Enhanced virtualization protection technology may require the use of
> > bounce buffers for I/O. While support for this was built into the
> > virtio core,  virtio-ccw wasn't changed accordingly.
> > 
> > Thus what needs to be done to bring virtio-ccw up to speed with
> > respect to this is:
> > * use some 'new' common virtio stuff
> > * make sure that virtio-ccw specific stuff uses shared memory when
> >   talking to the hypervisor (except communication blocks like ORB,
> > these are handled by the hypervisor)
> > * make sure the DMA API does what is necessary to talk through shared
> >   memory if we are a protected virtualization guest.
> > * make sure the common IO layer plays along as well (airqs, sense).
> 
> It would be good to have a summary somewhere in the code (or
> Documentation/) as to what needs the dma treatment and what doesn't,
> for later reference. We don't want people to accidentally break things
> (especially if they cannot refer to architecture documentation - or
> will at least some of that be published?)
> 

I can put documentation on my TODO list. This cover letter was also
supposed to provide a bird's-eye view on what needs to be done.

> > 
> > The series is structured in incremental fashion: some of the changes
> > are overridden by following patches. The main reason why is that
> > this is how I developed. But I think it ain't bad for the didactic
> > and we are a bit more flexible with regards to throwing out some of
> > the stuff in the end.
> 
> FWIW, I think reshuffling the patches in the next iteration would ease
> review.
> 

Can you please tell me more about what is desired here? I mean, I made
some tentative proposals on squashing some patches together. I don't
remember any requests to reorder patches or split.

> > 
> > Important notes:
> > 
> > * This is an early (WIP) RFC that does not add any function to the
> >   kernel at his stage, as the ultravisor interactions are left out.
> >   The purpose is getting some early feedback ASAP.
> 
> I would like some comments from people who have experience with the dma
> api.
> 

I can only second that! 

From the Linux on Z folks Sebastian seems to be the most likely suspect.
I've briefly shown this series to him before posting here, and I asked
him to have another look today. Unfortunately he seems quite busy at the
moment, but he promised me that he will make some time for this
(soonish).

Getting some more feedback from Christoph Hellwig would be nice as well.

> > 
> > * In future these patches will depend on some code interacting with
> > the ultravisor (WIP by Vasily and Janosch).
> > 
> > * The s390 names are by no means final, and are not properly
> > explained. Should not hamper understanding too much. If it does
> > please ask.
> > 
> > * The existing naming in the common infrastructure (kernel internal
> >   interfaces) is pretty much based on the AMD SEV terminology. Thus
> > the names aren't always perfect. There might be merit to changing
> > these names to more abstract ones. I did not put much thought into
> > that at the current stage.
> 
> If we can find some generic names that work well for everyone,
> converting seems like a good idea. But following SEV is not that bad,
> either (you'll probably find more people who have heard about SEV than
> folks familiar with s390 ;)
> 

I agree. We should not swap out the names for worse ones for sure. :)

I think the names discussion can be postponed. I would like to get the
code right first.

> > 
> > 
> > Testing:
> > 
> > Please use iommu_platform=on for any virtio devices you are going
> > to test this code with (so virtio actually uses the DMA API).
> > 
> > Looking forward to your review or any other type of input.
> 
> I have now read through the whole series and commented in some places.
> But I'd really like to see comments from others as well.
>

Thank you so much for the quick review. Thanks to your quality review I will
have a bunch of things to change (for the better) for v1.

I intend to wait a bit for more feedback and also for the my dependencies
to get published. I hope to send out a functional v1 mid next week.

Thank you again!

Regards,
Halil
