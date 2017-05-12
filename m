Return-Path: <owner-linux-mm@kvack.org>
Date: Fri, 12 May 2017 13:37:42 -0400 (EDT)
Message-Id: <20170512.133742.2144484253675877904.davem@davemloft.net>
Subject: Re: [v3 0/9] parallelized "struct page" zeroing
From: David Miller <davem@davemloft.net>
In-Reply-To: <6da8d4a6-3332-8331-c329-b05efd88a70d@oracle.com>
References: <65b8a658-76d1-0617-ece8-ff7a3c1c4046@oracle.com>
	<20170512.125708.475573831936972365.davem@davemloft.net>
	<6da8d4a6-3332-8331-c329-b05efd88a70d@oracle.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: pasha.tatashin@oracle.com
Cc: mhocko@kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Fri, 12 May 2017 13:24:52 -0400

> Right now it is larger, but what I suggested is to add a new optimized
> routine just for this case, which would do STBI for 64-bytes but
> without membar (do membar at the end of memmap_init_zone() and
> deferred_init_memmap()
> 
> #define struct_page_clear(page)                                 \
>         __asm__ __volatile__(                                   \
>         "stxa   %%g0, [%0]%2\n"                                 \
>         "stxa   %%xg0, [%0 + %1]%2\n"                           \
>         : /* No output */                                       \
>         : "r" (page), "r" (0x20), "i"(ASI_BLK_INIT_QUAD_LDD_P))
> 
> And insert it into __init_single_page() instead of memset()
> 
> The final result is 4.01s/T which is even faster compared to current
> 4.97s/T

Ok, indeed, that would work.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
