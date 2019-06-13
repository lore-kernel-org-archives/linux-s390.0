Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55216 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730895AbfFMI3m (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 13 Jun 2019 04:29:42 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5D8MG3O144270
        for <linux-s390@vger.kernel.org>; Thu, 13 Jun 2019 04:29:41 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t3jddspdt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 13 Jun 2019 04:29:40 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <mimu@linux.ibm.com>;
        Thu, 13 Jun 2019 09:29:38 +0100
Reply-To: mimu@linux.ibm.com
Subject: Re: [PATCH v5 6/8] virtio/s390: add indirection to indicators access
References: <20190612111236.99538-1-pasic@linux.ibm.com>
 <20190612111236.99538-7-pasic@linux.ibm.com>
From: Michael Mueller <mimu@linux.ibm.com>
Date: Thu, 13 Jun 2019 10:29:32 +0200
MIME-Version: 1.0
In-Reply-To: <20190612111236.99538-7-pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <caea5a6e-f174-7019-ce73-e9b52e20d50a@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Sebastian Ott <sebott@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, "Jason J. Herne" <jjherne@linux.ibm.com>



On 12.06.19 13:12, Halil Pasic wrote:
> This will come in handy soon when we pull out the indicators from
> virtio_ccw_device to a memory area that is shared with the hypervisor
> (in particular for protected virtualization guests).
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   drivers/s390/virtio/virtio_ccw.c | 40 ++++++++++++++++++++------------
>   1 file changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index 1da7430f94c8..e96a8cc56ec2 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -68,6 +68,16 @@ struct virtio_ccw_device {
>   	void *airq_info;
>   };
>   
> +static inline unsigned long *indicators(struct virtio_ccw_device *vcdev)
> +{
> +	return &vcdev->indicators;
> +}
> +
> +static inline unsigned long *indicators2(struct virtio_ccw_device *vcdev)
> +{
> +	return &vcdev->indicators2;
> +}
> +
>   struct vq_info_block_legacy {
>   	__u64 queue;
>   	__u32 align;
> @@ -338,17 +348,17 @@ static void virtio_ccw_drop_indicator(struct virtio_ccw_device *vcdev,
>   		ccw->cda = (__u32)(unsigned long) thinint_area;
>   	} else {
>   		/* payload is the address of the indicators */
> -		indicatorp = kmalloc(sizeof(&vcdev->indicators),
> +		indicatorp = kmalloc(sizeof(indicators(vcdev)),
>   				     GFP_DMA | GFP_KERNEL);
>   		if (!indicatorp)
>   			return;
>   		*indicatorp = 0;
>   		ccw->cmd_code = CCW_CMD_SET_IND;
> -		ccw->count = sizeof(&vcdev->indicators);
> +		ccw->count = sizeof(indicators(vcdev));
>   		ccw->cda = (__u32)(unsigned long) indicatorp;
>   	}
>   	/* Deregister indicators from host. */
> -	vcdev->indicators = 0;
> +	*indicators(vcdev) = 0;
>   	ccw->flags = 0;
>   	ret = ccw_io_helper(vcdev, ccw,
>   			    vcdev->is_thinint ?
> @@ -657,10 +667,10 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>   	 * We need a data area under 2G to communicate. Our payload is
>   	 * the address of the indicators.
>   	*/
> -	indicatorp = kmalloc(sizeof(&vcdev->indicators), GFP_DMA | GFP_KERNEL);
> +	indicatorp = kmalloc(sizeof(indicators(vcdev)), GFP_DMA | GFP_KERNEL);
>   	if (!indicatorp)
>   		goto out;
> -	*indicatorp = (unsigned long) &vcdev->indicators;
> +	*indicatorp = (unsigned long) indicators(vcdev);
>   	if (vcdev->is_thinint) {
>   		ret = virtio_ccw_register_adapter_ind(vcdev, vqs, nvqs, ccw);
>   		if (ret)
> @@ -669,21 +679,21 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>   	}
>   	if (!vcdev->is_thinint) {
>   		/* Register queue indicators with host. */
> -		vcdev->indicators = 0;
> +		*indicators(vcdev) = 0;
>   		ccw->cmd_code = CCW_CMD_SET_IND;
>   		ccw->flags = 0;
> -		ccw->count = sizeof(&vcdev->indicators);
> +		ccw->count = sizeof(indicators(vcdev));
>   		ccw->cda = (__u32)(unsigned long) indicatorp;
>   		ret = ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_SET_IND);
>   		if (ret)
>   			goto out;
>   	}
>   	/* Register indicators2 with host for config changes */
> -	*indicatorp = (unsigned long) &vcdev->indicators2;
> -	vcdev->indicators2 = 0;
> +	*indicatorp = (unsigned long) indicators2(vcdev);
> +	*indicators2(vcdev) = 0;
>   	ccw->cmd_code = CCW_CMD_SET_CONF_IND;
>   	ccw->flags = 0;
> -	ccw->count = sizeof(&vcdev->indicators2);
> +	ccw->count = sizeof(indicators2(vcdev));
>   	ccw->cda = (__u32)(unsigned long) indicatorp;
>   	ret = ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_SET_CONF_IND);
>   	if (ret)
> @@ -1093,17 +1103,17 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
>   			vcdev->err = -EIO;
>   	}
>   	virtio_ccw_check_activity(vcdev, activity);
> -	for_each_set_bit(i, &vcdev->indicators,
> -			 sizeof(vcdev->indicators) * BITS_PER_BYTE) {
> +	for_each_set_bit(i, indicators(vcdev),
> +			 sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
>   		/* The bit clear must happen before the vring kick. */
> -		clear_bit(i, &vcdev->indicators);
> +		clear_bit(i, indicators(vcdev));
>   		barrier();
>   		vq = virtio_ccw_vq_by_ind(vcdev, i);
>   		vring_interrupt(0, vq);
>   	}
> -	if (test_bit(0, &vcdev->indicators2)) {
> +	if (test_bit(0, indicators2(vcdev))) {
>   		virtio_config_changed(&vcdev->vdev);
> -		clear_bit(0, &vcdev->indicators2);
> +		clear_bit(0, indicators2(vcdev));
>   	}
>   }
>   
> 

Reviewed-by: Michael Mueller <mimu@linux.ibm.com>

Michael
