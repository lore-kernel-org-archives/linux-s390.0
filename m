Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1324490822.5916.109.camel@gandalf.stny.rr.com>
Subject: Re: oprofile patch broke s390 build in tip/perf/core
From: Steven Rostedt <rostedt@goodmis.org>
Date: Wed, 21 Dec 2011 13:07:02 -0500
In-Reply-To: <20111221175326.GM16765@erda.amd.com>
References: <1324488646.5916.107.camel@gandalf.stny.rr.com>
	 <20111221175326.GM16765@erda.amd.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Robert Richter <robert.richter@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2011-12-21 at 18:53 +0100, Robert Richter wrote:

> > The break is this:
> > 
> >   LD      .tmp_vmlinux1
> > arch/s390/oprofile/built-in.o: In function `oprofile_arch_exit':
> > (.text+0x3f52): undefined reference to `oprofile_timer_exit'
> > make[1]: *** [.tmp_vmlinux1] Error 1
> > make: *** [sub-make] Error 2
> 
> A fix is already in tip/perf/core:
> 
>  f8c8520 oprofile: Fix oprofile_timer_exit() breakage

Huh, I thought I did a recent pull from tip. But it came in with my pull
today.


Thanks,

-- Steve
