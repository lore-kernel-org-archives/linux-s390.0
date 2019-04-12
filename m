Return-Path: <SRS0=UIqJ=SO=vger.kernel.org=kvm-owner@kernel.org>
Date: Fri, 12 Apr 2019 14:12:31 +0200 (CEST)
From: Sebastian Ott <sebott@linux.ibm.com>
Subject: Re: [RFC PATCH 04/12] s390/cio: introduce cio DMA pool
In-Reply-To: <20190412132010.3c74cb63@oc2783563651>
References: <20190404231622.52531-1-pasic@linux.ibm.com> <20190404231622.52531-5-pasic@linux.ibm.com> <alpine.LFD.2.21.1904111955520.2283@schleppi> <20190412132010.3c74cb63@oc2783563651>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <alpine.LFD.2.21.1904121343040.1771@schleppi>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 12 Apr 2019, Halil Pasic wrote:
> On Thu, 11 Apr 2019 20:25:01 +0200 (CEST)
> Sebastian Ott <sebott@linux.ibm.com> wrote:
> > I don't think we should use this global DMA pool. I guess it's OK for
> > stuff like airq (where we don't have a struct device at hand) but for
> > CCW we should use the device we have. Yes, this way we waste some memory
> > but all dma memory a device uses should fit in a page - so the wastage
> > is not too much.
> > 
> 
> Is what you envision an own gen_pool on for each subchannel (e.g. a
> struct io_subchannel member)?

Either that or if that's too much overhead simply map a page and create
a struct containing the few dma areas for that device.

> I'm struggling with understanding the expected benefits of a
> per-subchannel pool/allocator. Can you please tell me what benefits do
> you expect (over the current approach)?

Logically DMA is a capability of a device and the whole DMA API is build
around devices. Working around that just feels wrong. For practical
matters: DMA debugging will complain about misuse of a specific device or
driver.

> I understand you idea is to keep the CIO global pool for stuff that can
> not be tied to a single device (i.e. ariq). So the per device stuff would
> also mean more code. Would you be OK with postponing this alleged
> enhancement (i.e. implement it as a patch on top of this series)?

I don't like it but it's just in-kernel usage which we can change at any
time. So if it helps you to do it that way, why not..
