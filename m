From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v4 03/16] vfio: ccw: define device_api strings
Date: Tue, 21 Mar 2017 12:47:54 -0600
Message-ID: <20170321124754.3f278901@t450s.home>
References: <20170317031743.40128-1-bjsdjshi@linux.vnet.ibm.com>
        <20170317031743.40128-4-bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170317031743.40128-4-bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Fri, 17 Mar 2017 04:17:30 +0100
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> Define vfio-ccw device API strings. CCW vendor driver using mediated
> device framework should use this string for device_api attribute.
> 
> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> ---
>  include/uapi/linux/vfio.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 519eff3..6183789 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -212,6 +212,7 @@ struct vfio_device_info {
>  #define VFIO_DEVICE_API_PCI_STRING		"vfio-pci"
>  #define VFIO_DEVICE_API_PLATFORM_STRING		"vfio-platform"
>  #define VFIO_DEVICE_API_AMBA_STRING		"vfio-amba"
> +#define VFIO_DEVICE_API_CCW_STRING		"vfio-ccw"
>  
>  /**
>   * VFIO_DEVICE_GET_REGION_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 8,


Acked-by: Alex Williamson <alex.williamson@redhat.com>
