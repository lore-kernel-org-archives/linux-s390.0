From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 0/2] vdso support for s390
Date: Wed, 15 Oct 2008 19:45:06 +0200
Message-ID: <20081015174506.107691579@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Greetings,
the two patches in this series add a vdso to s390 for three system calls:
1) gettimeofday
2) clock_getres for CLOCK_REALTIME and CLOCK_MONOTONIC
3) clock_gettime for CLOCK_REALTIME and CLOCK_MONOTONIC
The vdso code for gettimeofday is about 4-5 times faster than the system
call. Similar results for clock_gettime.

The first of the two patches changes the arch_setup_additional_pages
function. The second argument is unused and can be removed. For the
s390 vdso I want to know if the elf executable is dynamically linked
or not. Only if an interpreter is used the vdso is mapped. This adds
a second argument to arch_setup_additional_pages again but with a
different semantic.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
