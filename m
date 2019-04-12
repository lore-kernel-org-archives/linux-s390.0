Return-Path: <SRS0=UIqJ=SO=vger.kernel.org=kvm-owner@kernel.org>
Date: Fri, 12 Apr 2019 13:20:10 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC PATCH 04/12] s390/cio: introduce cio DMA pool
In-Reply-To: <alpine.LFD.2.21.1904111955520.2283@schleppi>
References: <20190404231622.52531-1-pasic@linux.ibm.com>
        <20190404231622.52531-5-pasic@linux.ibm.com>
        <alpine.LFD.2.21.1904111955520.2283@schleppi>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190412132010.3c74cb63@oc2783563651>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Sebastian Ott <sebott@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 11 Apr 2019 20:25:01 +0200 (CEST)
Sebastian Ott <sebott@linux.ibm.com> wrote:

> On Fri, 5 Apr 2019, Halil Pasic wrote:
> > To support protected virtualization cio will need to make sure the
> > memory used for communication with the hypervisor is DMA memory.
> > 
> > Let us introduce a DMA pool to cio that will help us in allocating
> > deallocating those chunks of memory.
> > 
> > We use a gen_pool backed with DMA pages to avoid each allocation
> > effectively wasting a page, as we typically allocate much less
> > than PAGE_SIZE.
> 
> I don't think we should use this global DMA pool. I guess it's OK for
> stuff like airq (where we don't have a struct device at hand) but for
> CCW we should use the device we have. Yes, this way we waste some memory
> but all dma memory a device uses should fit in a page - so the wastage
> is not too much.
> 

Is what you envision an own gen_pool on for each subchannel (e.g. a
struct io_subchannel member)?

I'm struggling with understanding the expected benefits of a
per-subchannel pool/allocator. Can you please tell me what benefits do
you expect (over the current approach)?

I understand you idea is to keep the CIO global pool for stuff that can
not be tied to a single device (i.e. ariq). So the per device stuff would
also mean more code. Would you be OK with postponing this alleged
enhancement (i.e. implement it as a patch on top of this series)?

Regards,
Halil
