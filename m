Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49687 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725861AbgLAKVT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 1 Dec 2020 05:21:19 -0500
Date: Tue, 1 Dec 2020 11:19:43 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] s390: cio: fix use-after-free in
 ccw_device_destroy_console
Message-ID: <20201201111943.626cb86f.cohuck@redhat.com>
In-Reply-To: <20201201063150.82128-1-miaoqinglang@huawei.com>
References: <20201201063150.82128-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Qinglang Miao <miaoqinglang@huawei.com>
Cc: Vineeth Vijayan <vneethv@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 1 Dec 2020 14:31:50 +0800
Qinglang Miao <miaoqinglang@huawei.com> wrote:

> put_device calls release function which do kfree() inside.
> So following use of sch&cdev would cause use-after-free bugs.
> 
> Fix these by simply adjusting the position of put_device.
> 
> Fixes: 37db8985b211 ("s390/cio: add basic protected virtualization support")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Suggested-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>  This patch is indeed a v2 of older one. Considering that the
>  patch's name has changed, I think a normal prefix 'PATCH' is
>  better.
> 
>  drivers/s390/cio/device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
