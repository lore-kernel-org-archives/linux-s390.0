Return-Path: <SRS0=UIqJ=SO=vger.kernel.org=kvm-owner@kernel.org>
Date: Fri, 12 Apr 2019 17:30:17 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC PATCH 04/12] s390/cio: introduce cio DMA pool
In-Reply-To: <alpine.LFD.2.21.1904121343040.1771@schleppi>
References: <20190404231622.52531-1-pasic@linux.ibm.com>
        <20190404231622.52531-5-pasic@linux.ibm.com>
        <alpine.LFD.2.21.1904111955520.2283@schleppi>
        <20190412132010.3c74cb63@oc2783563651>
        <alpine.LFD.2.21.1904121343040.1771@schleppi>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190412173017.04b768bb@oc2783563651>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Sebastian Ott <sebott@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 12 Apr 2019 14:12:31 +0200 (CEST)
Sebastian Ott <sebott@linux.ibm.com> wrote:

> On Fri, 12 Apr 2019, Halil Pasic wrote:
> > On Thu, 11 Apr 2019 20:25:01 +0200 (CEST)
> > Sebastian Ott <sebott@linux.ibm.com> wrote:
> > > I don't think we should use this global DMA pool. I guess it's OK for
> > > stuff like airq (where we don't have a struct device at hand) but for
> > > CCW we should use the device we have. Yes, this way we waste some memory
> > > but all dma memory a device uses should fit in a page - so the wastage
> > > is not too much.

Regarding the wastage. Let us do the math together in search for an
upper (wastage) limit.

#define __MAX_CSSID 0
#define __MAX_SUBCHANNEL 65535
#define __MAX_SSID 3 

that is a maximum of
2^16 devices per subchannel set x 2^2 subchannel sets * 2^0 css
== 2^18 devices at most.

With your a page per device we have max 2^30 = 2^18 + 2^12 bytes.

That is exactly 1GB. And because some of the stuff needs to be
31 bit addressable all of that 1GB would have to be under 2GB. 

Currently we need at least 224 bytes per device that is ~ 6%
of a PAGE_SIZE.

> > > 
> > 
> > Is what you envision an own gen_pool on for each subchannel (e.g. a
> > struct io_subchannel member)?
> 
> Either that or if that's too much overhead simply map a page and create
> a struct containing the few dma areas for that device.

In virtio-ccw we do dynamic allocations of DMA memory. And we could
theoretically do the same elsewhere. So I don't think a struct with
a few dma areas would do (assumed I understood you correctly, which
isn't very likely).

> 
> > I'm struggling with understanding the expected benefits of a
> > per-subchannel pool/allocator. Can you please tell me what benefits do
> > you expect (over the current approach)?
> 
> Logically DMA is a capability of a device and the whole DMA API is build
> around devices. 

I agree the whole DMA API is built around devices. IMHO DMA is indeed on
one hand a capability of a device, but it is also a capability of a
machine (system).

Normally (PCI) limitations can come either from the device side (e.g.
device supports only 32 bit addressing) or from the machine/bus side.

In our case however all ccw devices have the same
limitations/requirements. E.g. if you want to do a SSCH your ORB and
your CCWs will have to have to be 31 bit addressable (physical). Your
data can be above 2G if MIDA is available and used. None of this depends
on the device we are talking to, but dictated by the properties of
the architecture and the machine. Another important thing to notice is
that for CCW IO isolation is done very differently than for PCI. 

> Working around that just feels wrong.

Then the airq iv->vector should be a per-device thing as well, or?

> For practical
> matters: DMA debugging will complain about misuse of a specific device or
> driver.
> 

Do you mean CONFIG_DMA_API_DEBUG and CONFIG_DMA_API_DEBUG_SG? I've been
running with those and did not see any complaints. Maybe we should
clarify this one offline...

> > I understand you idea is to keep the CIO global pool for stuff that can
> > not be tied to a single device (i.e. ariq). So the per device stuff would
> > also mean more code. Would you be OK with postponing this alleged
> > enhancement (i.e. implement it as a patch on top of this series)?
> 
> I don't like it but it's just in-kernel usage which we can change at any
> time. So if it helps you to do it that way, why not..
> 

Right. There should be no external interface implications to changing
this AFAICT. I prefer seeing this matter as not substantial for what I'm
trying to accomplish with this series.

Regards,
Halil
