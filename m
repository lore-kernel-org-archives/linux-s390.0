Return-Path: <linux-kernel-owner+w=401wt.eu-S1752332AbYCLRwZ@vger.kernel.org>
Subject: Re: [patch 10/10] System z large page support.
From: Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <20080312173218.404592017@de.ibm.com>
References: <20080312173155.703966894@de.ibm.com>
	 <20080312173218.404592017@de.ibm.com>
Content-Type: text/plain
Date: Wed, 12 Mar 2008 10:52:12 -0700
Message-Id: <1205344332.9828.92.camel@nimitz.home.sr71.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Gerald Schaefer <geraldsc@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>


On Wed, 2008-03-12 at 18:32 +0100, Martin Schwidefsky wrote:
> 
> +pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
> +{
> +       pgd_t *pgdp;
> +       pud_t *pudp;
> +       pmd_t *pmdp = NULL;
> +
> +       pgdp = pgd_offset(mm, addr);
> +       pudp = pud_alloc(mm, pgdp, addr);
> +       if (pudp)
> +               pmdp = pmd_alloc(mm, pudp, addr);
> +       return (pte_t *) pmdp;
> +}

That looks pretty generic.  Why can't you share with the version we
already have?

-- Dave
