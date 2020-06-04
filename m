Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25563 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725601AbgFDL13 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 4 Jun 2020 07:27:29 -0400
Date: Thu, 4 Jun 2020 13:27:21 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] vfio-ccw: make vfio_ccw_regops variables declarations
 static
Message-ID: <20200604132721.63b11800.cohuck@redhat.com>
In-Reply-To: <patch.git-a34be7aede18.your-ad-here.call-01591269421-ext-5655@work.hours>
References: <20200603112716.332801-1-cohuck@redhat.com>
        <patch.git-a34be7aede18.your-ad-here.call-01591269421-ext-5655@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Thu, 4 Jun 2020 13:20:45 +0200
Vasily Gorbik <gor@linux.ibm.com> wrote:

> Fixes the following sparse warnings:
> drivers/s390/cio/vfio_ccw_chp.c:62:30: warning: symbol 'vfio_ccw_schib_region_ops' was not declared. Should it be static?
> drivers/s390/cio/vfio_ccw_chp.c:117:30: warning: symbol 'vfio_ccw_crw_region_ops' was not declared. Should it be static?
> 
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_chp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_chp.c
> index 876f6ade51cc..a646fc81c872 100644
> --- a/drivers/s390/cio/vfio_ccw_chp.c
> +++ b/drivers/s390/cio/vfio_ccw_chp.c
> @@ -59,7 +59,7 @@ static void vfio_ccw_schib_region_release(struct vfio_ccw_private *private,
>  
>  }
>  
> -const struct vfio_ccw_regops vfio_ccw_schib_region_ops = {
> +static const struct vfio_ccw_regops vfio_ccw_schib_region_ops = {
>  	.read = vfio_ccw_schib_region_read,
>  	.write = vfio_ccw_schib_region_write,
>  	.release = vfio_ccw_schib_region_release,
> @@ -131,7 +131,7 @@ static void vfio_ccw_crw_region_release(struct vfio_ccw_private *private,
>  
>  }
>  
> -const struct vfio_ccw_regops vfio_ccw_crw_region_ops = {
> +static const struct vfio_ccw_regops vfio_ccw_crw_region_ops = {
>  	.read = vfio_ccw_crw_region_read,
>  	.write = vfio_ccw_crw_region_write,
>  	.release = vfio_ccw_crw_region_release,

Oops.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Feel free to merge this directly.
