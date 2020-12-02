Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14350 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725933AbgLBJbs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 2 Dec 2020 04:31:48 -0500
Subject: Re: [PATCH] s390: cio: fix use-after-free in
 ccw_device_destroy_console
References: <20201201063150.82128-1-miaoqinglang@huawei.com>
From: Vineeth Vijayan <vneethv@linux.vnet.ibm.com>
Message-ID: <5081f172-32e6-dda5-4937-4d5c70e7f660@linux.vnet.ibm.com>
Date: Wed, 2 Dec 2020 10:30:52 +0100
MIME-Version: 1.0
In-Reply-To: <20201201063150.82128-1-miaoqinglang@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-ID: <linux-s390.vger.kernel.org>
To: Qinglang Miao <miaoqinglang@huawei.com>, Cornelia Huck <cohuck@redhat.com>, Vineeth Vijayan <vneethv@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

Thank you.With a very minor modification in the commit-message,

Reviewed-by: Vineeth Vijayan <vneethv@linux.ibm.com>

I will push this and Vasliy/Heiko will take this up for the next 
s390-tree upstream-release.


On 12/1/20 7:31 AM, Qinglang Miao wrote:
> put_device calls release function which do kfree() inside.
> So following use of sch&cdev would cause use-after-free bugs.
>
> Fix these by simply adjusting the position of put_device.

Modified the commit-message as below. Just for the clarification.

--

Use of sch->dev reference after the put_device() call could trigger
the use-after-free bugs.

Fix this by simply adjusting the position of put_device.
--
>
> Fixes: 37db8985b211 ("s390/cio: add basic protected virtualization support")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Suggested-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>   This patch is indeed a v2 of older one. Considering that the
>   patch's name has changed, I think a normal prefix 'PATCH' is
>   better.
>
>   drivers/s390/cio/device.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
> index b29fe8d50..33280ca18 100644
> --- a/drivers/s390/cio/device.c
> +++ b/drivers/s390/cio/device.c
> @@ -1664,10 +1664,10 @@ void __init ccw_device_destroy_console(struct ccw_device *cdev)
>   	struct io_subchannel_private *io_priv = to_io_private(sch);
>   
>   	set_io_private(sch, NULL);
> -	put_device(&sch->dev);
> -	put_device(&cdev->dev);
>   	dma_free_coherent(&sch->dev, sizeof(*io_priv->dma_area),
>   			  io_priv->dma_area, io_priv->dma_area_dma);
> +	put_device(&sch->dev);
> +	put_device(&cdev->dev);
>   	kfree(io_priv);
>   }
>   
