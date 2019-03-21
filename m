From: Eric Farman <farman@linux.ibm.com>
Subject: Re: [PATCH v3 1/2] vfio-ccw: new capability chain
 support
Date: Thu, 21 Mar 2019 16:19:49 -0400
Message-ID: <3b64f9a4-b4fe-da1c-5e63-687bf864dbcc@linux.ibm.com>
References: <20190301093949.27955-1-cohuck@redhat.com>
	<20190301093949.27955-2-cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
In-Reply-To: <20190301093949.27955-2-cohuck@redhat.com>
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
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 3/1/19 4:39 AM, Cornelia Huck wrote:
> To be replaced with a real linux-headers update.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

This looks straightforward.

Reviewed-by: Eric Farman <farman@linux.ibm.com>

> ---
>   linux-headers/linux/vfio.h     |  4 ++++
>   linux-headers/linux/vfio_ccw.h | 12 ++++++++++++
>   2 files changed, 16 insertions(+)
> 
> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
> index 12a7b1dc53c8..24f505199f83 100644
> --- a/linux-headers/linux/vfio.h
> +++ b/linux-headers/linux/vfio.h
> @@ -353,6 +353,10 @@ struct vfio_region_gfx_edid {
>   #define VFIO_DEVICE_GFX_LINK_STATE_DOWN  2
>   };
>   
> +#define VFIO_REGION_TYPE_CCW			(2)
> +/* ccw sub-types */
> +#define VFIO_REGION_SUBTYPE_CCW_ASYNC_CMD	(1)
> +
>   /*
>    * 10de vendor sub-type
>    *
> diff --git a/linux-headers/linux/vfio_ccw.h b/linux-headers/linux/vfio_ccw.h
> index 5bf96c3812d2..fcc3e69ef526 100644
> --- a/linux-headers/linux/vfio_ccw.h
> +++ b/linux-headers/linux/vfio_ccw.h
> @@ -12,6 +12,7 @@
>   
>   #include <linux/types.h>
>   
> +/* used for START SUBCHANNEL, always present */
>   struct ccw_io_region {
>   #define ORB_AREA_SIZE 12
>   	__u8	orb_area[ORB_AREA_SIZE];
> @@ -22,4 +23,15 @@ struct ccw_io_region {
>   	__u32	ret_code;
>   } __attribute__((packed));
>   
> +/*
> + * used for processing commands that trigger asynchronous actions
> + * Note: this is controlled by a capability
> + */
> +#define VFIO_CCW_ASYNC_CMD_HSCH (1 << 0)
> +#define VFIO_CCW_ASYNC_CMD_CSCH (1 << 1)
> +struct ccw_cmd_region {
> +	__u32 command;
> +	__u32 ret_code;
> +} __attribute__((packed));
> +
>   #endif
> 
