From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [BUILD-FAILURE] next-20091013 - s390x build breaks at mm/fault
 with !CONFIG_S390_EXEC_PROTECT
Date: Tue, 13 Oct 2009 12:33:35 +0200
Message-ID: <20091013123335.6d6820b3@mschwide.boeblingen.de.ibm.com>
References: <20091013162312.8b93998b.sfr@canb.auug.org.au>
	<20091013100648.GA7542@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20091013100648.GA7542@linux.vnet.ibm.com>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 13 Oct 2009 15:36:48 +0530
Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> wrote:

> 	next-20091013 randconfig build breaks on s390, with
> CONFIG_S390_EXEC_PROTECT=y
> 
> arch/s390/mm/fault.c: In function 'signal_return':
> arch/s390/mm/fault.c:221: error: implicit declaration of function 'is_compat_task'
> make[1]: *** [arch/s390/mm/fault.o] Error 1
> 
> is_compat_task is defined at asm/compat.h, including the 
> header, helps

I'll merge that info "[PATCH] fault handler performance optimization" if you
don't mind.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
