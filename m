Return-Path: <linux-kernel-owner+w=401wt.eu-S1759497AbXEYGDD@vger.kernel.org>
Date: Fri, 25 May 2007 08:02:51 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: 2.6.22-rc1-mm1 - s390 vs. md
Message-ID: <20070525080251.1bca37ee@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <0C7297FA1D2D244A9C7F6959C0BF1E5201E703A5@azsmsx413.amr.corp.intel.com>
References: <20070523104639.6bc0650e@gondolin.boeblingen.de.ibm.com>
	<0C7297FA1D2D244A9C7F6959C0BF1E5201E703A5@azsmsx413.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Cc: schwidefsky@de.ibm.com, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, NeilBrown <neilb@suse.de>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 24 May 2007 15:11:08 -0700,
"Williams, Dan J" <dan.j.williams@intel.com> wrote:


> --- a/async_tx/async_memcpy.c
> +++ b/async_tx/async_memcpy.c
> @@ -56,6 +56,7 @@ async_memcpy(struct page *dest, struct page *src,
> unsigned int dest_offset,
>  		int_en) : NULL;
>  
>  	if (tx) { /* run the memcpy asynchronously */
> +		#ifdef CONFIG_HAS_DMA
>  		dma_addr_t dma_addr;
>  		enum dma_data_direction dir;

Can you factor out the async stuff into a function so you can use the
#ifdefs to define different functions rather than put them in the middle
of a complex function?

(Maybe you should rather use #ifdef CONFIG_DMA_ENGINE, since the async
part is not needed for !DMA_ENGINE either.)
