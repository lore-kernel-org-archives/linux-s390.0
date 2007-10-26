Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [patch 2/6] CONFIG_HIGHPTE vs. sub-page page tables.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <1193345221.7018.18.camel@pasglop>
References: <20071025181520.880272069@de.ibm.com>
	 <20071025181901.212545095@de.ibm.com>  <1193345221.7018.18.camel@pasglop>
Content-Type: text/plain
Date: Fri, 26 Oct 2007 09:42:58 +0200
Message-Id: <1193384578.31831.6.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: benh@kernel.crashing.org
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>


On Fri, 2007-10-26 at 06:47 +1000, Benjamin Herrenschmidt wrote:
> > Solution: The only solution I found to this dilemma is a new typedef:
> > a pgtable_t. For s390 pgtable_t will be a (pte *) - to be introduced
> > with a later patch. For everybody else it will be a (struct page *).
> > The additional problem with the initialization of the ptl lock and the
> > NR_PAGETABLE accounting is solved with a constructor pgtable_page_ctor
> > and a destructor pgtable_page_dtor. The page table allocation and free
> > functions need to call these two whenever a page table page is allocated
> > or freed. pmd_populate will get a pgtable_t instead of a struct page
> > pointer. To get the pgtable_t back from a pmd entry that has been
> > installed with pmd_populate a new function pmd_pgtable is added. It
> > replaces the pmd_page call in free_pte_range and apply_to_pte_range.
>
> Interesting. That means I don't need to have a PTE page to be a struct
> page anymore ? I can have good use for that on powerpc as well... 

That would be good news. I'm curious, can you elaborate on what the use
case is?

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
