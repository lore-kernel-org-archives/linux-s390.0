From: Farhan Ali <alifm@linux.ibm.com>
Subject: Re: [PATCH 1/3] vfio-ccw: add capabilities chain
Date: Tue, 27 Nov 2018 14:04:49 -0500
Message-ID: <a3a73709-e354-758a-a7f0-219eafd593ab@linux.ibm.com>
References: <20181122165432.4437-1-cohuck@redhat.com>
	<20181122165432.4437-2-cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
In-Reply-To: <20181122165432.4437-2-cohuck@redhat.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 11/22/2018 11:54 AM, Cornelia Huck wrote:
> diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
> index 078e46f9623d..a6f9f84526e2 100644
> --- a/drivers/s390/cio/vfio_ccw_private.h
> +++ b/drivers/s390/cio/vfio_ccw_private.h
> @@ -3,9 +3,11 @@
>    * Private stuff for vfio_ccw driver
>    *
>    * Copyright IBM Corp. 2017
> + * Copyright Red Hat, Inc. 2018
>    *
>    * Author(s): Dong Jia Shi<bjsdjshi@linux.vnet.ibm.com>
>    *            Xiao Feng Ren<renxiaof@linux.vnet.ibm.com>
> + *            Cornelia Huck<cohuck@redhat.com>
>    */
>   
>   #ifndef_VFIO_CCW_PRIVATE_H_
> @@ -19,6 +21,38 @@
>   #include "css.h"
>   #include "vfio_ccw_cp.h"
>   
> +#define VFIO_CCW_OFFSET_SHIFT   40
> +#define VFIO_CCW_OFFSET_TO_INDEX(off)	(off >> VFIO_CCW_OFFSET_SHIFT)
> +#define VFIO_CCW_INDEX_TO_OFFSET(index)	((u64)(index) << VFIO_CCW_OFFSET_SHIFT)
> +#define VFIO_CCW_OFFSET_MASK	(((u64)(1) << VFIO_CCW_OFFSET_SHIFT) - 1)
> +

Why is the offset shift 40? I know vfio-pci is also using the same 
offset shift, but I am curious about the reasoning behind why we are 
using this? :)
