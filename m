From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC 3/5] s390x/ap-matrix: Configure AP matrix for KVM guest
Date: Tue, 14 Nov 2017 16:07:23 +0100
Message-ID: <20171114160723.2548917c.cohuck@redhat.com>
References: <1509033294-4945-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1509033294-4945-4-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1509033294-4945-4-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, qemu-s390x@nongnu.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, qemu-devel@nongnu.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 26 Oct 2017 11:54:52 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> The VFIO AP matrix mediated device driver provides an ioctl interface
> to configure the APM, ADM and APM fields contained in the
> CRYCB referenced by the guest's SIE state description. The mask
> values are specified in the mediated AP matrix device's sysfs
> attribute files. Configuring a KVM guest's AP matrix grants direct
> access to the AP adapters, domains and control domains specified in
> the matrix configuration.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> ---
>  hw/vfio/ap-matrix.c        |   45 ++++++++++++++++++++++++++++++++++++++++++++
>  linux-headers/linux/vfio.h |    1 +
>  2 files changed, 46 insertions(+), 0 deletions(-)
> 
> diff --git a/hw/vfio/ap-matrix.c b/hw/vfio/ap-matrix.c
> index eeaa439..ce87c05 100644
> --- a/hw/vfio/ap-matrix.c
> +++ b/hw/vfio/ap-matrix.c
> @@ -85,6 +85,35 @@ static VFIOGroup *vfio_ap_matrix_get_group(VFIOAPMatrixDevice *vapmdev,
>      return vfio_get_group(groupid, &address_space_memory, errp);
>  }
>  
> +static int vfio_ap_matrix_configure(VFIOAPMatrixDevice *vapmdev,
> +                                    APMatrixMasks *masks, Error **errp)
> +{
> +    size_t i;
> +    struct vfio_ap_matrix_config config;
> +    int ret;
> +
> +    config.argsz = sizeof(config);
> +    config.flags = 0;
> +
> +    ret = ioctl(vapmdev->vdev.fd, VFIO_AP_MATRIX_CONFIGURE, &config);
> +    if (ret) {
> +        error_setg_errno(errp, ret,
> +                         "%s: Error configuring matrix for device %s",
> +                         TYPE_VFIO_AP_MATRIX_DEVICE, vapmdev->vdev.name);
> +        return -EFAULT;
> +    }
> +
> +    for (i = 0; i < VFIO_AP_MATRIX_MASK_INDICES; i++) {
> +        if (i < AP_MATRIX_MASK_INDICES) {
> +            masks->apm[i] = config.apm[i];
> +            masks->aqm[i] = config.aqm[i];
> +            masks->adm[i] = config.adm[i];
> +        }
> +    }
> +
> +    return 0;
> +}
> +
>  static void vfio_ap_matrix_realize(DeviceState *dev, Error **errp)
>  {
>      VFIODevice *vbasedev;
> @@ -92,8 +121,11 @@ static void vfio_ap_matrix_realize(DeviceState *dev, Error **errp)
>      APMatrixDevice *apmdev = DO_UPCAST(APMatrixDevice, parent_obj, dev);
>      S390APMatrixDevice *sapmdev = DO_UPCAST(S390APMatrixDevice, parent_obj,
>                                              apmdev);
> +    S390APMatrixDeviceClass *csapmdev =
> +            S390_AP_MATRIX_DEVICE_GET_CLASS(sapmdev);
>      VFIOAPMatrixDevice *vapmdev = DO_UPCAST(VFIOAPMatrixDevice, apmdev,
>                                              sapmdev);
> +    APMatrixMasks masks;
>      char *mdevid;
>      Error *local_err = NULL;
>  
> @@ -121,8 +153,21 @@ static void vfio_ap_matrix_realize(DeviceState *dev, Error **errp)
>          goto out_device_err;
>      }
>  
> +    if (csapmdev->realize) {
> +        if (vfio_ap_matrix_configure(vapmdev, &masks, &local_err)) {
> +            goto out_realize_err;
> +        }
> +
> +        csapmdev->realize(sapmdev, &masks, &local_err);

Ah, here's the place where you pass in the masks.

> +        if (local_err) {
> +            goto out_realize_err;
> +        }
> +    }
> +
>      return;
>  
> +out_realize_err:
> +    vfio_put_device(vapmdev);
>  out_device_err:
>      vfio_put_group(vfio_group);
>  out_err:
> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
> index 2d96c57..bf1e25d 100644
> --- a/linux-headers/linux/vfio.h
> +++ b/linux-headers/linux/vfio.h
> @@ -736,6 +736,7 @@ struct vfio_ap_matrix_config {
>  	__u64 aqm[VFIO_AP_MATRIX_MASK_INDICES];
>  	__u64 adm[VFIO_AP_MATRIX_MASK_INDICES];
>  };
> +

Unrelated change.

>  /* ***************************************************************** */
>  
>  #endif /* _UAPIVFIO_H */
