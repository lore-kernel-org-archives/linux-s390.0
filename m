From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [BUILD-FAILURE] next-20091013 - s390x build breaks at mm/fault
	with !CONFIG_S390_EXEC_PROTECT
Date: Tue, 13 Oct 2009 16:27:20 +0530
Message-ID: <20091013105720.GB7542@linux.vnet.ibm.com>
References: <20091013162312.8b93998b.sfr@canb.auug.org.au> <20091013100648.GA7542@linux.vnet.ibm.com> <20091013123335.6d6820b3@mschwide.boeblingen.de.ibm.com>
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091013123335.6d6820b3@mschwide.boeblingen.de.ibm.com>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

* Martin Schwidefsky <schwidefsky@de.ibm.com> [2009-10-13 12:33:35]:

> On Tue, 13 Oct 2009 15:36:48 +0530
> Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> wrote:
> 
> > 	next-20091013 randconfig build breaks on s390, with
> > CONFIG_S390_EXEC_PROTECT=y
> > 
> > arch/s390/mm/fault.c: In function 'signal_return':
> > arch/s390/mm/fault.c:221: error: implicit declaration of function 'is_compat_task'
> > make[1]: *** [arch/s390/mm/fault.o] Error 1
> > 
> > is_compat_task is defined at asm/compat.h, including the 
> > header, helps
> 
> I'll merge that info "[PATCH] fault handler performance optimization" if you
> don't mind.

Please feel free to merge it.

> 
> -- 
> blue skies,
>    Martin.
> 
> "Reality continues to ruin my life." - Calvin.
> 
			
			Kamalesh
