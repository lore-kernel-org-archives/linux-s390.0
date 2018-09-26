From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v11 04/26] s390: vfio-ap: base implementation of VFIO AP
 device driver
Date: Wed, 26 Sep 2018 15:10:19 +0200
Message-ID: <20180926151019.1c97475f.cohuck@redhat.com>
References: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
        <20180925231641.4954-5-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180925231641.4954-5-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 25 Sep 2018 19:16:19 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> From: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> Introduces a new AP device driver. This device driver
> is built on the VFIO mediated device framework. The framework
> provides sysfs interfaces that facilitate passthrough
> access by guests to devices installed on the linux host.
> 
> The VFIO AP device driver will serve two purposes:
> 
> 1. Provide the interfaces to reserve AP devices for exclusive
>    use by KVM guests. This is accomplished by unbinding the
>    devices to be reserved for guest usage from the zcrypt
>    device driver and binding them to the VFIO AP device driver.
> 
> 2. Implements the functions, callbacks and sysfs attribute
>    interfaces required to create one or more VFIO mediated
>    devices each of which will be used to configure the AP
>    matrix for a guest and serve as a file descriptor
>    for facilitating communication between QEMU and the
>    VFIO AP device driver.
> 
> When the VFIO AP device driver is initialized:
> 
> * It registers with the AP bus for control of type 10 (CEX4
>   and newer) AP queue devices. This limitation was imposed
>   due to:
> 
>   1. A desire to keep the code as simple as possible;
> 
>   2. Some older models are no longer supported by the kernel
>      and others are getting close to end of service.
> 
>   3. A lack of older systems on which to test older devices.
> 
>   The probe and remove callbacks will be provided to support
>   the binding/unbinding of AP queue devices to/from the VFIO
>   AP device driver.
> 
> * Creates a matrix device, /sys/devices/vfio_ap/matrix,
>   to serve as the parent of the mediated devices created, one
>   for each guest, and to hold the APQNs of the AP devices bound to
>   the VFIO AP device driver.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> Tested-by: Michael Mueller <mimu@linux.ibm.com>
> Tested-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  MAINTAINERS                           |  10 ++
>  arch/s390/Kconfig                     |  11 ++
>  drivers/iommu/Kconfig                 |   8 ++
>  drivers/s390/crypto/Makefile          |   4 +
>  drivers/s390/crypto/vfio_ap_drv.c     | 138 ++++++++++++++++++++++++++
>  drivers/s390/crypto/vfio_ap_private.h |  34 +++++++
>  6 files changed, 205 insertions(+)
>  create mode 100644 drivers/s390/crypto/vfio_ap_drv.c
>  create mode 100644 drivers/s390/crypto/vfio_ap_private.h

This already got my R-b for v10... here it is again:

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
