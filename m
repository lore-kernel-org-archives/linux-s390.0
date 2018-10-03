From: Farhan Ali <alifm@linux.ibm.com>
Subject: Re: [PULL 1/1] s390/cio: Fix how vfio-ccw checks pinned pages
Date: Wed, 3 Oct 2018 09:14:11 -0400
Message-ID: <6d126fd1-3c51-34d3-18cf-b24459c9af39@linux.ibm.com>
References: <20181002153748.13503-1-cohuck@redhat.com>
 <20181002153748.13503-2-cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181002153748.13503-2-cohuck@redhat.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 10/02/2018 11:37 AM, Cornelia Huck wrote:
> From: Eric Farman <farman@linux.ibm.com>
> 
> We have two nested loops to check the entries within the pfn_array_table
> arrays.  But we mistakenly use the outer array as an index in our check,
> and completely ignore the indexing performed by the inner loop.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> Message-Id: <20181002010235.42483-1-farman@linux.ibm.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   drivers/s390/cio/vfio_ccw_cp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> index dbe7c7ac9ac8..fd77e46eb3b2 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -163,7 +163,7 @@ static bool pfn_array_table_iova_pinned(struct pfn_array_table *pat,
> 
>   	for (i = 0; i < pat->pat_nr; i++, pa++)
>   		for (j = 0; j < pa->pa_nr; j++)
> -			if (pa->pa_iova_pfn[i] == iova_pfn)
> +			if (pa->pa_iova_pfn[j] == iova_pfn)
>   				return true;
> 
>   	return false;
> 

Me and Jason have been looking at this code recently and we think this 
is the right fix.

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
