Return-Path: <linux-kernel-owner+w=401wt.eu-S1759348AbXEWIqw@vger.kernel.org>
Date: Wed, 23 May 2007 10:46:39 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: 2.6.22-rc1-mm1 - s390 vs. md
Message-ID: <20070523104639.6bc0650e@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <1179907539.17849.16.camel@localhost>
References: <0C7297FA1D2D244A9C7F6959C0BF1E5201E39968@azsmsx413.amr.corp.intel.com>
	<1179907539.17849.16.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com
Cc: "Williams, Dan J" <dan.j.williams@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, NeilBrown <neilb@suse.de>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 23 May 2007 10:05:39 +0200,
Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:

> We are trying to get rid of dma-mapping.h, see the last change to the
> file with commit 411f0f3edc141a582190d3605cadd1d993abb6df. I don't think
> we should reintroduce dma related definition but split the async_tx in a
> way that allows to compile it on an architecture with CONFIG_NO_DMA=y
> (yes I know that is harder that to just add the dma stubs).
> You've said that there is a software implementation if there is no dma
> engine present. This software implementation should be independent of
> dma-mapping.h. Without having looked at the code, isn't it possible to
> isolate that software implementation into its own C file? That would be
> the only one that gets compiled for s390.

Taking a quick look at the async_*.c stuff, the functions in question
basically seem to be of the form

check_if_we_can_do_it_async();
if (async_ok) {
	/* do async stuff */
	/* that's where the dma mapping creeps in */
} else {
	/* do it sync */
	/* seems fine for us */
}

So you should be able to factor out (say) async_memset_{sync,async}()
and put it into async_memset_{sync,async}.c. async_memset() would then
be

async_memset()
{
#if CONFIG_HAS_DMA
	if (check_if_we_can_do_at_async())
		async_memset_async();
#endif
	return async_memset_sync();
}

Kconfig could then do

config ASYNC_MEMSET
	default m
	tristate "async_memset support"
	select ASYNC_MEMSET_ASYNC if HAS_DMA

config ASYNC_MEMSET_ASYNC
	depends on HAS_DMA
	tristate "async_memset async via dma support"

Thoughts?
