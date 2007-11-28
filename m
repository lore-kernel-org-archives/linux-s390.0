Return-Path: <linux-kernel-owner+w=401wt.eu-S1760240AbXK1LDb@vger.kernel.org>
Subject: Re: [s390] build failure
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <200711281127.30051.elendil@planet.nl>
References: <200711281127.30051.elendil@planet.nl>
Content-Type: text/plain
Date: Wed, 28 Nov 2007 12:03:18 +0100
Message-Id: <1196247798.15829.4.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Frans Pop <elendil@planet.nl>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2007-11-28 at 11:27 +0100, Frans Pop wrote:
> $ git describe
> v2.6.24-rc3-342-g8c27eba
> 
> arch/s390/kernel/built-in.o: In function `cleanup_io_leave_insn':
> diag.c:(.text+0xc29a): undefined reference to `preempt_schedule_irq'
> make[2]: *** [.tmp_vmlinux1] Error 1

This is fixes by a patch from Christian:
      [S390] Fix compile error on 31bit without preemption

You can get the latest s390 patches by pulling from
	git://git390.osdl.marist.edu/pub/scm/linux-2.6.git fixes

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
