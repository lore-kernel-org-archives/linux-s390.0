From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v4 00/16] basic vfio-ccw infrastructure
Date: Tue, 28 Mar 2017 10:39:40 +0200
Message-ID: <ad83f499-cc12-688e-f455-50a28c1f2ea0@de.ibm.com>
References: <20170317031743.40128-1-bjsdjshi@linux.vnet.ibm.com>
 <20170328102016.4926f21d.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170328102016.4926f21d.cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>Alex Williamson <alex.williamson@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On 03/28/2017 10:20 AM, Cornelia Huck wrote:
> On Fri, 17 Mar 2017 04:17:27 +0100
> Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> 
>> Dong Jia Shi (16):
>>   s390: cio: introduce cio_cancel_halt_clear
>>   s390: cio: export more interfaces
>>   vfio: ccw: define device_api strings
>>   vfio: ccw: basic implementation for vfio_ccw driver
>>   vfio: ccw: introduce channel program interfaces
>>   vfio: ccw: register vfio_ccw to the mediated device framework
>>   vfio: ccw: introduce ccw_io_region
>>   vfio: ccw: handle ccw command request
>>   vfio: ccw: realize VFIO_DEVICE_GET_REGION_INFO ioctl
>>   vfio: ccw: realize VFIO_DEVICE_RESET ioctl
>>   vfio: ccw: realize VFIO_DEVICE_G(S)ET_IRQ_INFO ioctls
>>   vfio: ccw: return I/O results asynchronously
>>   vfio: ccw: introduce a finite state machine
>>   docs: add documentation for vfio-ccw
>>   vfio: ccw: introduce support for ccw0
>>   MAINTAINERS: Add vfio-ccw maintainers
>>
>>  Documentation/s390/00-INDEX         |   2 +
>>  Documentation/s390/vfio-ccw.txt     | 303 +++++++++++++
>>  MAINTAINERS                         |  10 +
>>  arch/s390/Kconfig                   |  10 +
>>  arch/s390/include/asm/cio.h         |  18 +
>>  arch/s390/include/asm/isc.h         |   1 +
>>  drivers/iommu/Kconfig               |   8 +
>>  drivers/s390/cio/Makefile           |   3 +
>>  drivers/s390/cio/cio.c              |  69 +++
>>  drivers/s390/cio/cio.h              |   1 +
>>  drivers/s390/cio/device_fsm.c       |  54 +--
>>  drivers/s390/cio/vfio_ccw_cp.c      | 842 ++++++++++++++++++++++++++++++++++++
>>  drivers/s390/cio/vfio_ccw_cp.h      |  42 ++
>>  drivers/s390/cio/vfio_ccw_drv.c     | 308 +++++++++++++
>>  drivers/s390/cio/vfio_ccw_fsm.c     | 207 +++++++++
>>  drivers/s390/cio/vfio_ccw_ops.c     | 447 +++++++++++++++++++
>>  drivers/s390/cio/vfio_ccw_private.h |  96 ++++
>>  include/uapi/linux/vfio.h           |  18 +
>>  include/uapi/linux/vfio_ccw.h       |  24 +
>>  19 files changed, 2417 insertions(+), 46 deletions(-)
>>  create mode 100644 Documentation/s390/vfio-ccw.txt
>>  create mode 100644 drivers/s390/cio/vfio_ccw_cp.c
>>  create mode 100644 drivers/s390/cio/vfio_ccw_cp.h
>>  create mode 100644 drivers/s390/cio/vfio_ccw_drv.c
>>  create mode 100644 drivers/s390/cio/vfio_ccw_fsm.c
>>  create mode 100644 drivers/s390/cio/vfio_ccw_ops.c
>>  create mode 100644 drivers/s390/cio/vfio_ccw_private.h
>>  create mode 100644 include/uapi/linux/vfio_ccw.h
>>
> 
> Patch set looks good to me, and I think we should target it for the
> next merge window (the interface looks fine, and we can iron out any
> other things later.)
> 
> Question: Which tree should this go through? Vfio or kvm/s390?

Reading todays MAINTAINERS file this would go via Martins tree, after the last
patch it will be separate. I can certainly carry that via the kvms390 tree,
but Alex is certainly the final maintainer. 
So what about having a new repository under 
https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/
e.g. vfio.git that will then queue the patches for Alex to take?
