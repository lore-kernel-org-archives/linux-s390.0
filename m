Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46262 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfGBIpx (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 2 Jul 2019 04:45:53 -0400
Date: Tue, 2 Jul 2019 10:45:50 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC v1 3/4] vfio-ccw: Set pa_nr to 0 if memory allocation
 fails for pa_iova_pfn
Message-ID: <20190702104550.7d2e7563.cohuck@redhat.com>
In-Reply-To: <19d813c58e0c45df3f23d8b1033e00b5ac5c7779.1561997809.git.alifm@linux.ibm.com>
References: <cover.1561997809.git.alifm@linux.ibm.com>
        <19d813c58e0c45df3f23d8b1033e00b5ac5c7779.1561997809.git.alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: farman@linux.ibm.com, pasic@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Mon,  1 Jul 2019 12:23:45 -0400
Farhan Ali <alifm@linux.ibm.com> wrote:

> So we clean up correctly.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_cp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> index cab1be9..c5655de 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -72,8 +72,10 @@ static int pfn_array_alloc(struct pfn_array *pa, u64 iova, unsigned int len)
>  				  sizeof(*pa->pa_iova_pfn) +
>  				  sizeof(*pa->pa_pfn),
>  				  GFP_KERNEL);
> -	if (unlikely(!pa->pa_iova_pfn))
> +	if (unlikely(!pa->pa_iova_pfn)) {
> +		pa->pa_nr = 0;
>  		return -ENOMEM;
> +	}
>  	pa->pa_pfn = pa->pa_iova_pfn + pa->pa_nr;
>  
>  	pa->pa_iova_pfn[0] = pa->pa_iova >> PAGE_SHIFT;

This looks like an older error -- can you give a Fixes: tag? (Yeah, I
know I sound like a broken record wrt that tag... :)
