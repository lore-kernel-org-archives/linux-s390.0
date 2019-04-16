Return-Path: <SRS0=PCIz=SS=vger.kernel.org=kvm-owner@kernel.org>
Date: Tue, 16 Apr 2019 14:50:14 +0200 (CEST)
From: Sebastian Ott <sebott@linux.ibm.com>
Subject: Re: [RFC PATCH 04/12] s390/cio: introduce cio DMA pool
In-Reply-To: <20190412173017.04b768bb@oc2783563651>
References: <20190404231622.52531-1-pasic@linux.ibm.com> <20190404231622.52531-5-pasic@linux.ibm.com> <alpine.LFD.2.21.1904111955520.2283@schleppi> <20190412132010.3c74cb63@oc2783563651> <alpine.LFD.2.21.1904121343040.1771@schleppi>
 <20190412173017.04b768bb@oc2783563651>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <alpine.LFD.2.21.1904161436400.2054@schleppi>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 12 Apr 2019, Halil Pasic wrote:
> On Fri, 12 Apr 2019 14:12:31 +0200 (CEST)
> Sebastian Ott <sebott@linux.ibm.com> wrote:
> > On Fri, 12 Apr 2019, Halil Pasic wrote:
> > > On Thu, 11 Apr 2019 20:25:01 +0200 (CEST)
> > > Sebastian Ott <sebott@linux.ibm.com> wrote:
> > > > I don't think we should use this global DMA pool. I guess it's OK for
> > > > stuff like airq (where we don't have a struct device at hand) but for
> > > > CCW we should use the device we have. Yes, this way we waste some memory
> > > > but all dma memory a device uses should fit in a page - so the wastage
> > > > is not too much.
> 
> Regarding the wastage. Let us do the math together in search for an
> upper (wastage) limit.
[...]
> Currently we need at least 224 bytes per device that is ~ 6%
> of a PAGE_SIZE.

Yes, we basically waste the whole page. I'm ok with that if the benefit is
to play nice with the kernel APIs.

> > For practical
> > matters: DMA debugging will complain about misuse of a specific device or
> > driver.
> > 
> 
> Do you mean CONFIG_DMA_API_DEBUG and CONFIG_DMA_API_DEBUG_SG? I've been
> running with those and did not see any complaints. Maybe we should
> clarify this one offline...

I didn't mean to imply that there are bugs already - just that when used
as intended the DMA_DEBUG_API can complain about stuff like "your device
is gone but you have still DMA memory set up for it" which will not work
if you don't use the correct device...

Sebastian
