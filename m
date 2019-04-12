Return-Path: <SRS0=UIqJ=SO=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [RFC PATCH 00/12] s390: virtio: support protected virtualization
References: <20190404231622.52531-1-pasic@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <ec7dd523-6277-7753-eb18-83d0896d8706@redhat.com>
Date: Fri, 12 Apr 2019 15:47:50 +0200
MIME-Version: 1.0
In-Reply-To: <20190404231622.52531-1-pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>
Cc: virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 05.04.19 01:16, Halil Pasic wrote:
> Enhanced virtualization protection technology may require the use of
> bounce buffers for I/O. While support for this was built into the virtio
> core,  virtio-ccw wasn't changed accordingly.

Can you elaborate some more about the general approach (Enhanced
virtualization protection technology, ultravisor, concept, issues, how
to squeeze it into QEMU/KVM/kernel) etc =

For my taste, this cover letter misses some important context :)

> 
> Thus what needs to be done to bring virtio-ccw up to speed with respect
> to this is:
> * use some 'new' common virtio stuff
> * make sure that virtio-ccw specific stuff uses shared memory when
>   talking to the hypervisor (except communication blocks like ORB, these
>   are handled by the hypervisor)
> * make sure the DMA API does what is necessary to talk through shared
>   memory if we are a protected virtualization guest.
> * make sure the common IO layer plays along as well (airqs, sense).
> 
> The series is structured in incremental fashion: some of the changes are
> overridden by following patches. The main reason why is that this is how I
> developed. But I think it ain't bad for the didactic and we are a bit more
> flexible with regards to throwing out some of the stuff in the end.
> 
> Important notes:
> 
> * This is an early (WIP) RFC that does not add any function to the
>   kernel at his stage, as the ultravisor interactions are left out.
>   The purpose is getting some early feedback ASAP.
> 
> * In future these patches will depend on some code interacting with the
>   ultravisor (WIP by Vasily and Janosch).
> 
> * The s390 names are by no means final, and are not properly explained. Should
>   not hamper understanding too much. If it does please ask.
> 
> * The existing naming in the common infrastructure (kernel internal
>   interfaces) is pretty much based on the AMD SEV terminology. Thus the
>   names aren't always perfect. There might be merit to changing these
>   names to more abstract ones. I did not put much thought into that at
>   the current stage.
> 
> 
> Testing:
> 
> Please use iommu_platform=on for any virtio devices you are going
> to test this code with (so virtio actually uses the DMA API).
> 
> Looking forward to your review or any other type of input.
> 
> Halil Pasic (12):
>   virtio/s390: use vring_create_virtqueue
>   virtio/s390: DMA support for virtio-ccw
>   s390/mm: force swiotlb for protected virtualization
>   s390/cio: introduce cio DMA pool
>   s390/cio: add protected virtualization support to cio
>   s390/airq: use DMA memory for adapter interrupts
>   virtio/s390: use DMA memory for ccw I/O
>   virtio/s390: add indirection to indicators access
>   virtio/s390: use DMA memory for notifiers
>   virtio/s390: consolidate DMA allocations
>   virtio/s390: use the cio DMA pool
>   virtio/s390:  make airq summary indicators DMA
> 
>  arch/s390/Kconfig                   |   5 +
>  arch/s390/include/asm/Kbuild        |   1 -
>  arch/s390/include/asm/airq.h        |   2 +
>  arch/s390/include/asm/cio.h         |   4 +
>  arch/s390/include/asm/dma-mapping.h |  13 ++
>  arch/s390/include/asm/mem_encrypt.h |  18 +++
>  arch/s390/mm/init.c                 |  44 +++++
>  drivers/s390/cio/airq.c             |  18 ++-
>  drivers/s390/cio/ccwreq.c           |   8 +-
>  drivers/s390/cio/css.c              |  63 ++++++++
>  drivers/s390/cio/device.c           |  46 ++++--
>  drivers/s390/cio/device_fsm.c       |  40 ++---
>  drivers/s390/cio/device_id.c        |  18 +--
>  drivers/s390/cio/device_ops.c       |   4 +-
>  drivers/s390/cio/device_pgid.c      |  20 +--
>  drivers/s390/cio/device_status.c    |  24 +--
>  drivers/s390/cio/io_sch.h           |  19 ++-
>  drivers/s390/virtio/virtio_ccw.c    | 310 ++++++++++++++++++++----------------
>  18 files changed, 444 insertions(+), 213 deletions(-)
>  create mode 100644 arch/s390/include/asm/dma-mapping.h
>  create mode 100644 arch/s390/include/asm/mem_encrypt.h
> 


-- 

Thanks,

David / dhildenb
