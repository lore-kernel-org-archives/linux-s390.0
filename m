Return-Path: <linux-kernel-owner+w=401wt.eu-S1755561AbYCLWNT@vger.kernel.org>
Subject: Re: [patch 10/10] System z large page support.
From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Reply-To: gerald.schaefer@de.ibm.com
In-Reply-To: <1205344332.9828.92.camel@nimitz.home.sr71.net>
References: <20080312173155.703966894@de.ibm.com>
	 <20080312173218.404592017@de.ibm.com>
	 <1205344332.9828.92.camel@nimitz.home.sr71.net>
Content-Type: text/plain
Date: Wed, 12 Mar 2008 23:14:31 +0100
Message-Id: <1205360071.5237.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2008-03-12 at 10:52 -0700, Dave Hansen wrote:
> > 
> > +pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
> > +{
> > +       pgd_t *pgdp;
> > +       pud_t *pudp;
> > +       pmd_t *pmdp = NULL;
> > +
> > +       pgdp = pgd_offset(mm, addr);
> > +       pudp = pud_alloc(mm, pgdp, addr);
> > +       if (pudp)
> > +               pmdp = pmd_alloc(mm, pudp, addr);
> > +       return (pte_t *) pmdp;
> > +}
> 
> That looks pretty generic.  Why can't you share with the version we
> already have?

What version do you mean? Every architecture with hugetlbfs support has
its own huge_pte_alloc() function in arch/<arch>/mm/hugetlbfs.c, and
they are all doing slightly different things.

--
Gerald Schaefer
