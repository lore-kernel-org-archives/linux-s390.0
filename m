Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Subject: [PATCH v13 00/18] Early boot time stamps
Date: Wed, 11 Jul 2018 20:04:01 -0400
Message-Id: <20180712000419.5165-1-pasha.tatashin@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, pasha.tatashin@oracle.com, boris.ostrovsky@oracle.com, jgross@suse.com
List-ID: <linux-s390.vger.kernel.org>

changelog
---------
v13 - v12
	- Addressed comments from Thomas Gleixner.
	- Addressed comments from Peter Zijlstra.
	- Added a patch from Borislav Petkov 
	- Added a new patch: sched: use static key for sched_clock_running
	- Added xen pv fixes, so clock is initialized when other
	  hypervisors initialize their clocks.
	Note: I am including kvm/x86: remove kvm memblock dependency, which
	is part of this series:
	http://lkml.kernel.org/r/20180706161307.733337643@linutronix.de
	Because without this patch it is not possible to test this series on
	KVM.

v12 - v11
	- split time: replace read_boot_clock64() with
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

Borislav Petkov (1):
  x86/CPU: Call detect_nopl() only on the BSP

Pavel Tatashin (17):
  x86: text_poke() may access uninitialized struct pages
  x86: initialize static branching early
  x86/tsc: redefine notsc to behave as tsc=unstable
  kvm/x86: remove kvm memblock dependency
  x86/xen/time: initialize pv xen time in init_hypervisor_platform
  x86/xen/time: output xen sched_clock time from 0
  s390/time: add read_persistent_wall_and_boot_offset()
  time: replace read_boot_clock64() with
    read_persistent_wall_and_boot_offset()
  time: default boot time offset to local_clock()
  s390/time: remove read_boot_clock64()
  ARM/time: remove read_boot_clock64()
  x86/tsc: calibrate tsc only once
  x86/tsc: initialize cyc2ns when tsc freq. is determined
  x86/tsc: use tsc early
  sched: move sched clock initialization and merge with generic clock
  sched: early boot clock
  sched: use static key for sched_clock_running

 .../admin-guide/kernel-parameters.txt         |   2 -
 Documentation/x86/x86_64/boot-options.txt     |   4 +-
 arch/arm/include/asm/mach/time.h              |   3 +-
 arch/arm/kernel/time.c                        |  15 +-
 arch/arm/plat-omap/counter_32k.c              |   2 +-
 arch/s390/kernel/time.c                       |  15 +-
 arch/x86/include/asm/kvm_para.h               |   2 +-
 arch/x86/include/asm/text-patching.h          |   1 +
 arch/x86/include/asm/tsc.h                    |   2 +-
 arch/x86/kernel/alternative.c                 |   7 +
 arch/x86/kernel/cpu/amd.c                     |  13 +-
 arch/x86/kernel/cpu/common.c                  |  40 ++--
 arch/x86/kernel/jump_label.c                  |  11 +-
 arch/x86/kernel/kvm.c                         |   1 +
 arch/x86/kernel/kvmclock.c                    |  66 +------
 arch/x86/kernel/setup.c                       |  11 +-
 arch/x86/kernel/tsc.c                         | 187 +++++++++---------
 arch/x86/xen/enlighten_pv.c                   |  51 +++--
 arch/x86/xen/mmu_pv.c                         |   6 +-
 arch/x86/xen/suspend_pv.c                     |   5 +-
 arch/x86/xen/time.c                           |  24 +--
 arch/x86/xen/xen-ops.h                        |   6 +-
 drivers/clocksource/tegra20_timer.c           |   2 +-
 include/linux/sched_clock.h                   |   5 +-
 include/linux/timekeeping.h                   |   3 +-
 init/main.c                                   |   4 +-
 kernel/sched/clock.c                          |  48 +++--
 kernel/sched/core.c                           |   1 -
 kernel/sched/debug.c                          |   2 -
 kernel/time/sched_clock.c                     |   2 +-
 kernel/time/timekeeping.c                     |  62 +++---
 31 files changed, 288 insertions(+), 315 deletions(-)

-- 
2.18.0
