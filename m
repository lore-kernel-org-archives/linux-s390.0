Return-Path: <owner-linux-mm@kvack.org>
Date: Mon, 6 Jul 2015 10:05:24 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 0/4] s390/mm: Fixup hugepage sw-emulated code removal
Message-ID: <20150706100524.3698c9f8@mschwide>
In-Reply-To: <1435927569-41132-1-git-send-email-dingel@linux.vnet.ibm.com>
References: <1435927569-41132-1-git-send-email-dingel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: Dominik Dingel <dingel@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-mm@kvack.org, Gerald Schaefer <gerald.schaefer@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri,  3 Jul 2015 14:46:05 +0200
Dominik Dingel <dingel@linux.vnet.ibm.com> wrote:

> Heiko noticed that the current check for hugepage support on s390 is a little bit to
> harsh as systems which do not support will crash.
> The reason is that pageblock_order can now get negative when we set HPAGE_SHIFT to 0.
> To avoid all this and to avoid opening another can of worms with enabling 
> HUGETLB_PAGE_SIZE_VARIABLE I think it would be best to simply allow architectures to
> define their own hugepages_supported().
> 
> Thanks
>     Dominik
> 
> Dominik Dingel (4):
>   Revert "s390/mm: change HPAGE_SHIFT type to int"
>   Revert "s390/mm: make hugepages_supported a boot time decision"
>   mm: hugetlb: allow hugepages_supported to be architecture specific
>   s390/hugetlb: add hugepages_supported define
> 
>  arch/s390/include/asm/hugetlb.h |  1 +
>  arch/s390/include/asm/page.h    |  8 ++++----
>  arch/s390/kernel/setup.c        |  2 --
>  arch/s390/mm/pgtable.c          |  2 --
>  include/linux/hugetlb.h         | 17 ++++++++---------
>  5 files changed, 13 insertions(+), 17 deletions(-)
 
To have an architecture override for hugepages_supported is imho the
cleaner approach compared to the HPAGE_SHIFT tricks. I would have
preferred to use a __weak function but the #ifndef solution is fine
with me as well.

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
