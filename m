Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22907 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729627AbgHYKEv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 Aug 2020 06:04:51 -0400
Date: Tue, 25 Aug 2020 12:04:32 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v10 01/16] s390/vfio-ap: add version vfio_ap module
Message-ID: <20200825120432.13a1b444.cohuck@redhat.com>
In-Reply-To: <20200821195616.13554-2-akrowiak@linux.ibm.com>
References: <20200821195616.13554-1-akrowiak@linux.ibm.com>
        <20200821195616.13554-2-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com

On Fri, 21 Aug 2020 15:56:01 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> Let's set a version for the vfio_ap module so that automated regression
> tests can determine whether dynamic configuration tests can be run or
> not.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_drv.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> index be2520cc010b..f4ceb380dd61 100644
> --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -17,10 +17,12 @@
>  
>  #define VFIO_AP_ROOT_NAME "vfio_ap"
>  #define VFIO_AP_DEV_NAME "matrix"
> +#define VFIO_AP_MODULE_VERSION "1.2.0"
>  
>  MODULE_AUTHOR("IBM Corporation");
>  MODULE_DESCRIPTION("VFIO AP device driver, Copyright IBM Corp. 2018");
>  MODULE_LICENSE("GPL v2");
> +MODULE_VERSION(VFIO_AP_MODULE_VERSION);
>  
>  static struct ap_driver vfio_ap_drv;
>  

Setting a version manually has some drawbacks:
- tools wanting to check for capabilities need to keep track which
  versions support which features
- you need to remember to actually bump the version when adding a new,
  visible feature
(- selective downstream backports may get into a pickle, but that's
arguably not your problem)

Is there no way for a tool to figure out whether this is supported?
E.g., via existence of a sysfs file, or via a known error that will
occur. If not, it's maybe better to expose known capabilities via a
generic interface.
