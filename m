Return-Path: <owner-linux-mm@kvack.org>
Subject: Re: [v3 0/9] parallelized "struct page" zeroing
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
Date: Wed, 17 May 2017 09:50:57 +1000
In-Reply-To: <20170512.133742.2144484253675877904.davem@davemloft.net>
References: <65b8a658-76d1-0617-ece8-ff7a3c1c4046@oracle.com>
	 <20170512.125708.475573831936972365.davem@davemloft.net>
	 <6da8d4a6-3332-8331-c329-b05efd88a70d@oracle.com>
	 <20170512.133742.2144484253675877904.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <1494978657.21847.74.camel@au1.ibm.com>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: David Miller <davem@davemloft.net>, pasha.tatashin@oracle.com
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, mhocko@kernel.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 2017-05-12 at 13:37 -0400, David Miller wrote:
> > Right now it is larger, but what I suggested is to add a new optimized
> > routine just for this case, which would do STBI for 64-bytes but
> > without membar (do membar at the end of memmap_init_zone() and
> > deferred_init_memmap()
> > 
> > #define struct_page_clear(page)A A A A A A A A A A A A A A A A A A A A A A A A A A A A A A A A  \
> > A A A A A A A A  __asm__ __volatile__(A A A A A A A A A A A A A A A A A A A A A A A A A A A A A A A A A A  \
> > A A A A A A A A  "stxaA A  %%g0, [%0]%2\n"A A A A A A A A A A A A A A A A A A A A A A A A A A A A A A A A  \
> > A A A A A A A A  "stxaA A  %%xg0, [%0 + %1]%2\n"A A A A A A A A A A A A A A A A A A A A A A A A A A  \
> > A A A A A A A A  : /* No output */A A A A A A A A A A A A A A A A A A A A A A A A A A A A A A A A A A A A A A  \
> > A A A A A A A A  : "r" (page), "r" (0x20), "i"(ASI_BLK_INIT_QUAD_LDD_P))
> > 
> > And insert it into __init_single_page() instead of memset()
> > 
> > The final result is 4.01s/T which is even faster compared to current
> > 4.97s/T
> 
> Ok, indeed, that would work.

On ppc64, that might not. We have a dcbz instruction that clears an
entire cache line at once. That's what we use for memset's and page
clearing. However, 64 bytes is half a cache line on modern processors
so we can't use it with that semantic and would have to fallback to the
slower stores.

Cheers,
Ben.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
