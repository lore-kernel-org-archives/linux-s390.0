From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 2/2] vfio/ccw: fix initialization of the Object
 DeviceState pointer in the common base-device
Date: Tue, 18 Jul 2017 10:37:30 +0200
Message-ID: <20170718103730.58f3d8cc@gondolin>
References: <20170718014926.44781-1-bjsdjshi@linux.vnet.ibm.com>
        <20170718014926.44781-3-bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170718014926.44781-3-bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, Alex Williamson <alex.williamson@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 18 Jul 2017 03:49:26 +0200
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> Commit 7da624e2 ("vfio: Test realized when using VFIOGroup.device_list
> iterator") introduced a pointer to the Object DeviceState in the VFIO
> common base-device and skiped non-realized devices as we iterate

s/skiped/skipped/

I'll fix this while applying.

> VFIOGroup.device_list. While it missed to initialize the pointer for
> the vfio-ccw case. Let's fix it.
> 
> Fixes: 7da624e2 ("vfio: Test realized when using VFIOGroup.device_list
>                   iterator")
> 
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> ---
>  hw/vfio/ccw.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 8d97b53e77..a8baadf57a 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -338,6 +338,7 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
>      vcdev->vdev.type = VFIO_DEVICE_TYPE_CCW;
>      vcdev->vdev.name = g_strdup_printf("%x.%x.%04x", cdev->hostid.cssid,
>                                         cdev->hostid.ssid, cdev->hostid.devid);
> +    vcdev->vdev.dev = dev;
>      QLIST_FOREACH(vbasedev, &group->device_list, next) {
>          if (strcmp(vbasedev->name, vcdev->vdev.name) == 0) {
>              error_setg(&err, "vfio: subchannel %s has already been attached",
