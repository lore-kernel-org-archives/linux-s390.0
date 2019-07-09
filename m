Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60850 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbfGIKI1 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 9 Jul 2019 06:08:27 -0400
Date: Tue, 9 Jul 2019 12:08:22 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC v2 3/5] vfio-ccw: Set pa_nr to 0 if memory allocation
 fails for pa_iova_pfn
Message-ID: <20190709120822.34a17f9b.cohuck@redhat.com>
In-Reply-To: <452bf0756d8b0efdb9fd1e1aa5d8c0e6a7f31c03.1562616169.git.alifm@linux.ibm.com>
References: <cover.1562616169.git.alifm@linux.ibm.com>
        <452bf0756d8b0efdb9fd1e1aa5d8c0e6a7f31c03.1562616169.git.alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: farman@linux.ibm.com, pasic@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Mon,  8 Jul 2019 16:10:36 -0400
Farhan Ali <alifm@linux.ibm.com> wrote:

> So we don't call try to call vfio_unpin_pages() incorrectly.
> 
> Fixes: 0a19e61e6d4c ("vfio: ccw: introduce channel program interfaces")

So that was there since the beginning :)

> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> Reviewed-by: Eric Farman <farman@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_cp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> index 31a04a5..1b93863 100644
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

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
