Return-Path: <linux-kernel-owner+w=401wt.eu-S1755098AbZAIERt@vger.kernel.org>
Message-ID: <4966CFD9.4040602@sgi.com>
Date: Thu, 08 Jan 2009 20:17:29 -0800
From: Mike Travis <travis@sgi.com>
MIME-Version: 1.0
Subject: [PULL]: tip/cpus4096 updates
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>, oprofile-list@lists.sf.net, linux-net-drivers@solarflare.com, S390 <linux-s390@vger.kernel.org>, linux390@de.ibm.com, virtualization@lists.osdl.org
List-ID: <linux-s390.vger.kernel.org>

Hi Ingo,

Please pull a few more cpus4096 changes.  Most are fairly lightweight with the
biggest change being to use cpumask_var_t's for the domain and pending_mask
cpumask's in irq_desc.

It also deals with this cpu_evtchn_mask bss space bump:

    65536  +2031616   2097152 +3100%  cpu_evtchn_mask(.bss)

Everything merges into tip/master cleanly.

Thanks!
Mike

The following changes since commit 36c401a44abcc389a00f9cd14892c9cf9bf0780d:
  Ingo Molnar (1):
        [IA64] fix typo in cpumask_of_pcibus()

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/travis/linux-2.6-cpus4096-for-ingo.git master

Mike Travis (9):
      cpumask: update irq_desc to use cpumask_var_t
      cpumask: fix bug in use cpumask_var_t in irq_desc
      SGI UV cpumask: use static temp cpumask in flush_tlb
      x86: cleanup remaining cpumask_t code in mce_amd_64.c
      x86: cleanup remaining cpumask_t code in microcode_core.c
      x86: reduce stack usage in init_intel_cacheinfo
      cpumask: use cpumask_var_t in dcdbas.c
      cpumask: reduce stack usage in find_lowest_rq
      Xen: reduce memory required for cpu_evtchn_mask

Rusty Russell (5):
      cpumask: Use topology_core_cpumask()/topology_thread_cpumask()
      cpumask: convert misc driver functions
      cpumask: convert drivers/net/sfc
      cpumask: convert other misc kernel functions
      x86: change flush_tlb_others to take a const struct cpumask *. FIXME: REVIEW

 Documentation/cputopology.txt           |    6 +-
 arch/x86/include/asm/paravirt.h         |    8 ++-
 arch/x86/include/asm/tlbflush.h         |    8 ++--
 arch/x86/include/asm/uv/uv_bau.h        |    3 +-
 arch/x86/kernel/cpu/intel_cacheinfo.c   |   63 ++++++++++++++++-------
 arch/x86/kernel/cpu/mcheck/mce_amd_64.c |   21 +++++---
 arch/x86/kernel/io_apic.c               |   20 ++++----
 arch/x86/kernel/irq_32.c                |    2 +-
 arch/x86/kernel/irq_64.c                |    2 +-
 arch/x86/kernel/microcode_core.c        |   74 ++++++++++++++++----------
 arch/x86/kernel/tlb_32.c                |   67 ++++++++++--------------
 arch/x86/kernel/tlb_64.c                |   62 ++++++++++++----------
 arch/x86/kernel/tlb_uv.c                |   16 +++---
 arch/x86/xen/enlighten.c                |   31 ++++-------
 drivers/base/cpu.c                      |    2 +-
 drivers/base/topology.c                 |   33 ++++++------
 drivers/firmware/dcdbas.c               |   12 +++--
 drivers/misc/sgi-xp/xpc_main.c          |    2 +-
 drivers/net/sfc/efx.c                   |   17 ++++--
 drivers/oprofile/buffer_sync.c          |   22 +++++++--
 drivers/oprofile/buffer_sync.h          |    4 ++
 drivers/oprofile/oprof.c                |    9 +++-
 drivers/xen/events.c                    |   25 +++++++---
 drivers/xen/manage.c                    |    2 +-
 include/linux/irq.h                     |   86 +++++++++++++++++++++++++++++-
 include/linux/topology.h                |    6 ++
 kernel/irq/chip.c                       |    5 ++-
 kernel/irq/handle.c                     |   20 +++----
 kernel/irq/manage.c                     |   12 ++--
 kernel/irq/migration.c                  |   12 ++--
 kernel/irq/numa_migrate.c               |   19 ++++++-
 kernel/irq/proc.c                       |    4 +-
 kernel/sched_rt.c                       |   36 ++++++++-----
 lib/smp_processor_id.c                  |    2 +-
 net/iucv/iucv.c                         |   28 +++++++----
 35 files changed, 471 insertions(+), 270 deletions(-)
