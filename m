Return-Path: <SRS0=A7Pw=TP=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [PATCH v2 4/7] s390/cio: Initialize the host addresses in
 pfn_array
References: <20190514234248.36203-1-farman@linux.ibm.com>
 <20190514234248.36203-5-farman@linux.ibm.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Wed, 15 May 2019 12:25:58 -0400
MIME-Version: 1.0
In-Reply-To: <20190514234248.36203-5-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <205a6fee-f751-bab3-e26c-8a37027fdfa1@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 05/14/2019 07:42 PM, Eric Farman wrote:
> Let's initialize the host address to something that is invalid,
> rather than letting it default to zero.  This just makes it easier
> to notice when a pin operation has failed or been skipped.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>   drivers/s390/cio/vfio_ccw_cp.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> index 60aa784717c5..0a97978d1d28 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -91,8 +91,11 @@ static int pfn_array_alloc(struct pfn_array *pa, u64 iova, unsigned int len)
>   	pa->pa_pfn = pa->pa_iova_pfn + pa->pa_nr;
>   
>   	pa->pa_iova_pfn[0] = pa->pa_iova >> PAGE_SHIFT;
> -	for (i = 1; i < pa->pa_nr; i++)
> +	pa->pa_pfn[0] = -1ULL;
> +	for (i = 1; i < pa->pa_nr; i++) {
>   		pa->pa_iova_pfn[i] = pa->pa_iova_pfn[i - 1] + 1;
> +		pa->pa_pfn[i] = -1ULL;
> +	}
>   
>   	return 0;
>   }
> 

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
