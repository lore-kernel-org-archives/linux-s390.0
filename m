Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53154 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbfG2JQn (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 29 Jul 2019 05:16:43 -0400
Date: Mon, 29 Jul 2019 11:16:40 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] vfio-ccw: make vfio_ccw_async_region_ops static
Message-ID: <20190729111640.4c03169c.cohuck@redhat.com>
In-Reply-To: <patch.git-1c8e853871be.your-ad-here.call-01564389487-ext-4282@work.hours>
References: <patch.git-1c8e853871be.your-ad-here.call-01564389487-ext-4282@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>

On Mon, 29 Jul 2019 10:38:52 +0200
Vasily Gorbik <gor@linux.ibm.com> wrote:

> Since vfio_ccw_async_region_ops is not exported and has no reason to be
> globally visible make it static to avoid the following sparse warning:
> drivers/s390/cio/vfio_ccw_async.c:73:30: warning: symbol 'vfio_ccw_async_region_ops' was not declared. Should it be static?

Fixes: d5afd5d135c8 ("vfio-ccw: add handling for async channel instructions")
> 
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_async.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_async.c b/drivers/s390/cio/vfio_ccw_async.c
> index 8c1d2357ef5b..7a838e3d7c0f 100644
> --- a/drivers/s390/cio/vfio_ccw_async.c
> +++ b/drivers/s390/cio/vfio_ccw_async.c
> @@ -70,7 +70,7 @@ static void vfio_ccw_async_region_release(struct vfio_ccw_private *private,
>  
>  }
>  
> -const struct vfio_ccw_regops vfio_ccw_async_region_ops = {
> +static const struct vfio_ccw_regops vfio_ccw_async_region_ops = {
>  	.read = vfio_ccw_async_region_read,
>  	.write = vfio_ccw_async_region_write,
>  	.release = vfio_ccw_async_region_release,

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Should I queue this and send a pull request (currently, there's nothing
else pending), or do you want to apply this directly?
