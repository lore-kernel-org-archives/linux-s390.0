Return-Path: <linux-kernel-owner+w=401wt.eu-S1753905AbXLDMER@vger.kernel.org>
Subject: Re: [s390] build failure
In-reply-To: <1196247798.15829.4.camel@localhost>
References: <200711281127.30051.elendil@planet.nl> <1196247798.15829.4.camel@localhost>
Message-Id: <E1IzWVI-0002zO-Ff@faramir.fjphome.nl>
From: Frans Pop <elendil@planet.nl>
Date: Tue, 04 Dec 2007 13:03:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: elendil@planet.nl, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Martin Schwidefsky wrote:
> On Wed, 2007-11-28 at 11:27 +0100, Frans Pop wrote:
>> arch/s390/kernel/built-in.o: In function `cleanup_io_leave_insn':
>> diag.c:(.text+0xc29a): undefined reference to `preempt_schedule_irq'
>> make[2]: *** [.tmp_vmlinux1] Error 1
> 
> This is fixes by a patch from Christian:
>       [S390] Fix compile error on 31bit without preemption
> 
> You can get the latest s390 patches by pulling from
> git://git390.osdl.marist.edu/pub/scm/linux-2.6.git fixes
 
Any reason this has not been pushed into mainline yet? The fix missed -rc4
because of that...

Cheers,
FJP
