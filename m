From: Michael Mueller <mimu@linux.ibm.com>
Date: Fri, 30 Nov 2018 14:32:05 +0000
Subject: [PATCH v4 00/10] KVM: s390: make use of the GIB
Message-Id: <20181130143215.69496-1-mimu@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The Guest Information Area (GIB) and its mechanics is part of
the AIV facility. It provides hardware support to process
Adapter Interruptions (AI) for pagable storage mode guests. 

Whenever a guest cannot process an AI because none of its
vcpus is running in SIE context, a GIB alert interruption is
sent to and handled by the host program to dispatch a vcpu of
the respective guest.

Eventually, the AI is handled by the guest.

v3->v4:
  The central change of v4 is that the metric "vcpus_in_sie"
  has been dropped. A least agressive IAM restore strategy
  is being followed now. The consequence is that potentially
  more GAL interruptions are to be handled by the host program.
  The assuption as made that as soon the first vcpu is trying
  to go into wait state, this could be the last vcpu being
  open for I/O interruptions. Thus, to not loose the initiative
  to deliver I/O interruptions as soon as possible, the IAM
  is restored. Adding better heuristics can be done in future.

  I expect this to be the last version of the series.
 
  patch 01/12: Kernel msg now printed when FLIC fails
               to register during arch inititialization.
  patch 03/12: Commit message slightly changed with the
  	       hint that gib initialization is called
	       by last patch of this serias.
  patch 09/12: IAM now restored during kvm_s390_handle_wait()
  patch 10/12: gib destroy case now handled upon unsuccessful
  	       arch inititialization.

All other patches are unchanged.

v2->v3:
  patch 01/12: Fixes a resource dealocation issue upon
  	       unsuccessful exit from kvm_arch_init().
	       It is relevant for patch 11/12 as well. 
  patch 08/12: The function process_gib_alert_list() has
               been rewritten to reduce the number of GAL
	       interruptions on the host for many guest
	       scenarios.
  patch 10/12: The IAM is now never cleared before SIE entry.
               It will be cleared by millicode as soon the
	       first guest interruption is made pending and
	       not directly processed in SIE. The IAM gets
	       restored as soon a vm is idle, i.e. no vcpu
	       of that guest is in SIE context anymore.
  patch 11/12: now integrates with new patch 01/12
  patch 12/12: This patch is just experimental and shall not
               be part of the final series.

The first patch of series v2: "leave AIs in IPM of GISA
during vcpu_pre_run()" has been dropped.

All other patches are unchanged.

v1->v2:
  patch 01/12: New patch. Tt can go also standalone without the
  	       rest of the GIB series presented here but is a
	       requirement 
  patch 03/12: kvm_s390_gib_init() now has a return code
  patch 06/12: unlink_gib_alert_list() now uses cmpxchg() instead
    	       of atomic_xchg()
  patch 08/12: New patch. Foctors out __find_vcpu_for_floating_irq()
  patch 09/12: process_gib_alert_list() has been simplified
               the GISA clear/destroy cases have been removed
  patch 11/12: kvm_s390_gisa_clear/destroy() now clear the IAM
               and process the alert list directly
	       The IAM now gets restored in vcpu_post_run() only if
	       the GISA is not in alert list
  patch 12/12: during kvm_arch_init() now the return code of
    	       kvm_s390_gib_init() is honored.

All other patches are unchanged.

Michael Mueller (10):
  KVM: s390: unregister debug feature on failing arch init
  s390/cio: add function chsc_sgib()
  KVM: s390: add the GIB and its related life-cyle functions
  KVM: s390: factor out nullify_gisa()
  KVM: s390: add kvm reference to struct sie_page2
  KVM: s390: factor out __find_vcpu_for_floating_irq()
  KVM: s390: add function process_gib_alert_list()
  KVM: s390: add functions to (un)register GISC with GISA
  KVM: s390: add and wire function gib_alert_irq_handler()
  KVM: s390: start using the GIB

 Documentation/kmsg/s390/kvm      |  24 +++++
 arch/s390/include/asm/cio.h      |   1 +
 arch/s390/include/asm/irq.h      |   1 +
 arch/s390/include/asm/isc.h      |   1 +
 arch/s390/include/asm/kvm_host.h |  19 +++-
 arch/s390/kernel/irq.c           |   1 +
 arch/s390/kvm/interrupt.c        | 214 +++++++++++++++++++++++++++++++++++++--
 arch/s390/kvm/kvm-s390.c         |  27 ++++-
 arch/s390/kvm/kvm-s390.h         |   7 ++
 drivers/s390/cio/chsc.c          |  37 +++++++
 drivers/s390/cio/chsc.h          |   1 +
 11 files changed, 318 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/kmsg/s390/kvm

-- 
2.13.4
