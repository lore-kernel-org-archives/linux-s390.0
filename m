Return-Path: <SRS0=MvP8=SN=vger.kernel.org=kvm-owner@kernel.org>
Date: Thu, 11 Apr 2019 20:25:01 +0200 (CEST)
From: Sebastian Ott <sebott@linux.ibm.com>
Subject: Re: [RFC PATCH 04/12] s390/cio: introduce cio DMA pool
In-Reply-To: <20190404231622.52531-5-pasic@linux.ibm.com>
References: <20190404231622.52531-1-pasic@linux.ibm.com> <20190404231622.52531-5-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <alpine.LFD.2.21.1904111955520.2283@schleppi>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 5 Apr 2019, Halil Pasic wrote:
> To support protected virtualization cio will need to make sure the
> memory used for communication with the hypervisor is DMA memory.
> 
> Let us introduce a DMA pool to cio that will help us in allocating
> deallocating those chunks of memory.
> 
> We use a gen_pool backed with DMA pages to avoid each allocation
> effectively wasting a page, as we typically allocate much less
> than PAGE_SIZE.

I don't think we should use this global DMA pool. I guess it's OK for
stuff like airq (where we don't have a struct device at hand) but for
CCW we should use the device we have. Yes, this way we waste some memory
but all dma memory a device uses should fit in a page - so the wastage
is not too much.

Sebastian
