Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Subject: [PATCH v12 00/11] Early boot time stamps for x86
Date: Thu, 21 Jun 2018 17:25:07 -0400
Message-Id: <20180621212518.19914-1-pasha.tatashin@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

changelog
---------
v12 - v11
	- splitted time: replace read_boot_clock64() with
	  read_persistent_wall_and_boot_offset() into four patches
	- Added two patches one fixes an existing bug with text_poke()
	  another one enables static branches early. Note, because I found
	  and fixed the text_poke() bug, enabling static branching became
	  super easy, as no changes to jump_label* is needed.
	- Modified x86/tsc: use tsc early to use static branches early, and
	  thus native_sched_clock() is not changed at all.
v11 - v10
	- Addressed all the comments from Thomas Gleixner.
	- I added one more patch:
	  "x86/tsc: prepare for early sched_clock" which fixes a problem
	  that I discovered while testing. I am not particularly happy with
	  the fix, as it adds a new argument that is used only in one
	  place, but if you have a suggestion for a different approach on
	  how to address this problem please let me know.

v10 - v9
	- Added another patch to this series that removes dependency
	  between KVM clock, and memblock allocator. The benefit is that
	  all clocks can now be initialized even earlier.
v9 - v8
	- Addressed more comments from Dou Liyang

v8 - v7
	- Addressed comments from Dou Liyang:
	- Moved tsc_early_init() and tsc_early_fini() to be all inside
	  tsc.c, and changed them to be static.
	- Removed warning when notsc parameter is used.
	- Merged with:
	  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git

v7 - v6
	- Removed tsc_disabled flag, now notsc is equivalent of
	  tsc=unstable
	- Simplified changes to sched/clock.c, by removing the
	  sched_clock_early() and friends as requested by Peter Zijlstra.
	  We know always use sched_clock()
	- Modified x86 sched_clock() to return either early boot time or
	  regular.
	- Added another example why ealry boot time is important

v5 - v6
	- Added a new patch:
		time: sync read_boot_clock64() with persistent clock
	  Which fixes missing __init macro, and enabled time discrepancy
	  fix that was noted by Thomas Gleixner
	- Split "x86/time: read_boot_clock64() implementation" into a
	  separate patch

v4 - v5
	- Fix compiler warnings on systems with stable clocks.

v3 - v4
	- Fixed tsc_early_fini() call to be in the 2nd patch as reported
	  by Dou Liyang
	- Improved comment before __use_sched_clock_early to explain why
	  we need both booleans.
	- Simplified valid_clock logic in read_boot_clock64().

v2 - v3
	- Addressed comment from Thomas Gleixner
	- Timestamps are available a little later in boot but still much
	  earlier than in mainline. This significantly simplified this
	  work.

v1 - v2
	In patch "x86/tsc: tsc early":
	- added tsc_adjusted_early()
	- fixed 32-bit compile error use do_div()

The early boot time stamps were discussed recently in these threads:
http://lkml.kernel.org/r/1527672059-6225-1-git-send-email-feng.tang@intel.com
http://lkml.kernel.org/r/1527672059-6225-2-git-send-email-feng.tang@intel.com

I updated my series to the latest mainline and sending it again.

Peter mentioned he did not like patch 6,7, and we can discuss for a better
way to do that, but I think patches 1-5 can be accepted separetly, since
they already enable early timestamps on platforms where sched_clock() is
available early. Such as KVM.

Adding early boot time stamps support for x86 machines.
SPARC patches for early boot time stamps are already integrated into
mainline linux.

Sample output
-------------
Before:
https://paste.ubuntu.com/26133428/

After:
https://paste.ubuntu.com/26133523/

For exaples how early time stamps are used, see this work:
Example 1:
https://lwn.net/Articles/734374/
- Without early boot time stamps we would not know about the extra time
  that is spent zeroing struct pages early in boot even when deferred
  page initialization.

Example 2:
https://patchwork.kernel.org/patch/10021247/
- If early boot timestamps were available, the engineer who introduced
  this bug would have noticed the extra time that is spent early in boot.
Pavel Tatashin (7):
  x86/tsc: remove tsc_disabled flag
  time: sync read_boot_clock64() with persistent clock
  x86/time: read_boot_clock64() implementation
  sched: early boot clock
  kvm/x86: remove kvm memblock dependency
  x86/paravirt: add active_sched_clock to pv_time_ops
  x86/tsc: use tsc early

Example 3:
http://lkml.kernel.org/r/20180615155733.1175-1-pasha.tatashin@oracle.com
- Needed early time stamps to show improvement

Pavel Tatashin (11):
  x86: text_poke() may access uninitialized struct pages
  x86: initialize static branching early
  x86/tsc: redefine notsc to behave as tsc=unstable
  kvm/x86: remove kvm memblock dependency
  s390/time: add read_persistent_wall_and_boot_offset()
  time: replace read_boot_clock64() with
    read_persistent_wall_and_boot_offset()
  s390/time: remove read_boot_clock64()
  ARM/time: remove read_boot_clock64()
  x86/tsc: prepare for early sched_clock
  sched: early boot clock
  x86/tsc: use tsc early

 .../admin-guide/kernel-parameters.txt         |  2 -
 Documentation/x86/x86_64/boot-options.txt     |  4 +-
 arch/arm/kernel/time.c                        | 12 +---
 arch/s390/kernel/time.c                       | 15 +++--
 arch/x86/include/asm/text-patching.h          |  1 +
 arch/x86/kernel/alternative.c                 | 10 ++-
 arch/x86/kernel/cpu/amd.c                     | 13 ++--
 arch/x86/kernel/cpu/common.c                  | 38 ++++++-----
 arch/x86/kernel/kvm.c                         |  1 +
 arch/x86/kernel/kvmclock.c                    | 64 +++---------------
 arch/x86/kernel/setup.c                       | 11 ++--
 arch/x86/kernel/tsc.c                         | 65 ++++++++++---------
 include/linux/timekeeping.h                   |  3 +-
 kernel/sched/clock.c                          | 10 ++-
 kernel/time/timekeeping.c                     | 61 ++++++++---------
 15 files changed, 140 insertions(+), 170 deletions(-)

-- 
2.17.1
