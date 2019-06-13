Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34798 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387749AbfFMQCx (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 13 Jun 2019 12:02:53 -0400
Date: Thu, 13 Jun 2019 18:02:49 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 6/9] vfio-ccw: Adjust the first IDAW outside of the
 nested loops
Message-ID: <20190613180249.1f26258d.cohuck@redhat.com>
In-Reply-To: <20190606202831.44135-7-farman@linux.ibm.com>
References: <20190606202831.44135-1-farman@linux.ibm.com>
        <20190606202831.44135-7-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Thu,  6 Jun 2019 22:28:28 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> Now that pfn_array_table[] is always an array of 1, it seems silly to
> check for the very first entry in an array in the middle of two nested
> loops, since we know it'll only ever happen once.
> 
> Let's move this outside the loops to simplify things, even though
> the "k" variable is still necessary.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_cp.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> index 86a0e76ef2b5..ab9f8f0d1b44 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -201,11 +201,12 @@ static inline void pfn_array_table_idal_create_words(
>  		pa = pat->pat_pa + i;
>  		for (j = 0; j < pa->pa_nr; j++) {
>  			idaws[k] = pa->pa_pfn[j] << PAGE_SHIFT;
> -			if (k == 0)
> -				idaws[k] += pa->pa_iova & (PAGE_SIZE - 1);
>  			k++;
>  		}
>  	}
> +
> +	/* Adjust the first IDAW, since it may not start on a page boundary */
> +	idaws[0] += pat->pat_pa->pa_iova & (PAGE_SIZE - 1);
>  }
>  
>  

Also +1 to adding a nice explaining comment :)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
