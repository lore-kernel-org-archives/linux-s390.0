Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 15 Apr 2013 07:48:14 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: arch/s390/lib/uaccess_pt.c: Missing breaks: ?
Message-ID: <20130415054814.GA4207@osiris>
References: <1365919574.1878.13.camel@joe-AO722>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1365919574.1878.13.camel@joe-AO722>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Sat, Apr 13, 2013 at 11:06:14PM -0700, Joe Perches wrote:
> Hello Heiko.
> 
> Commit ea81531d ("s390/uaccess: fix page table walk")
> added this code.  It looks like it should have break;
> for each case.

Hi Joe,

no, the fallthrough is on purpose for each case statement.

> static unsigned long follow_table(struct mm_struct *mm,
> 				  unsigned long address, int write)
> {
> 	unsigned long *table = (unsigned long *)__pa(mm->pgd);
> 
> 	switch (mm->context.asce_bits & _ASCE_TYPE_MASK) {
> 	case _ASCE_TYPE_REGION1:
> 		table = table + ((address >> 53) & 0x7ff);
> 		if (unlikely(*table & _REGION_ENTRY_INV))
> 			return -0x39UL;
> 		table = (unsigned long *)(*table & _REGION_ENTRY_ORIGIN);
> 	case _ASCE_TYPE_REGION2:
