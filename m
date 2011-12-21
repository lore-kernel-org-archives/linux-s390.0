Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1324488646.5916.107.camel@gandalf.stny.rr.com>
Subject: oprofile patch broke s390 build in tip/perf/core
From: Steven Rostedt <rostedt@goodmis.org>
Date: Wed, 21 Dec 2011 12:30:46 -0500
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Robert Richter <robert.richter@amd.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi,

In doing my tests last night before sending out my patch series this
morning, I found that s390 build didn't work, but it wasn't due to my
patches. I removed all my patches and built with latest mainline (which
builds fine), and then merged the current tip/perf/core. The result
didn't build.

I kicked off a ktest git bisect with last night's Linus tree as good,
and with the merged in tip/perf/core as bad. It ended up with this patch
that broke the build (which looks like a likely suspect).


The break is this:

  LD      .tmp_vmlinux1
arch/s390/oprofile/built-in.o: In function `oprofile_arch_exit':
(.text+0x3f52): undefined reference to `oprofile_timer_exit'
make[1]: *** [.tmp_vmlinux1] Error 1
make: *** [sub-make] Error 2

The patch the bisect found that breaks the build is this:

commit 75c43a20b220f885c39ffa7cdbbb1191e257a9a9
Author: Robert Richter <robert.richter@amd.com>
Date:   Fri Oct 14 15:46:10 2011 +0200

    oprofile: Remove exit function for timer mode
    
    Remove exit functions by moving init/exit code to oprofile's setup/
    shutdown functions. Doing so the oprofile module exit code will be
    easier and less error-prone.
    
    Signed-off-by: Robert Richter <robert.richter@amd.com>


-- Steve
