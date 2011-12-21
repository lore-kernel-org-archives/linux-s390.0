Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 21 Dec 2011 18:53:26 +0100
From: Robert Richter <robert.richter@amd.com>
Subject: Re: oprofile patch broke s390 build in tip/perf/core
Message-ID: <20111221175326.GM16765@erda.amd.com>
References: <1324488646.5916.107.camel@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1324488646.5916.107.camel@gandalf.stny.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 21.12.11 12:30:46, Steven Rostedt wrote:
> In doing my tests last night before sending out my patch series this
> morning, I found that s390 build didn't work, but it wasn't due to my
> patches. I removed all my patches and built with latest mainline (which
> builds fine), and then merged the current tip/perf/core. The result
> didn't build.
> 
> I kicked off a ktest git bisect with last night's Linus tree as good,
> and with the merged in tip/perf/core as bad. It ended up with this patch
> that broke the build (which looks like a likely suspect).
> 
> 
> The break is this:
> 
>   LD      .tmp_vmlinux1
> arch/s390/oprofile/built-in.o: In function `oprofile_arch_exit':
> (.text+0x3f52): undefined reference to `oprofile_timer_exit'
> make[1]: *** [.tmp_vmlinux1] Error 1
> make: *** [sub-make] Error 2

A fix is already in tip/perf/core:

 f8c8520 oprofile: Fix oprofile_timer_exit() breakage

-Robert

-- 
Advanced Micro Devices, Inc.
Operating System Research Center
