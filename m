From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v7 00/15] KVM: s390: make use of the GIB
Date: Wed, 6 Feb 2019 18:09:51 +0100
Message-ID: <bfedd077-c91d-a54d-cb00-5a290ab9b453@de.ibm.com>
References: <20190131085247.13826-1-mimu@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190131085247.13826-1-mimu@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.ibm.com>, KVM Mailing List <kvm@vger.kernel.org>
Cc: Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Series Applied and queued.
see https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git/log/?h=next


On 31.01.2019 09:52, Michael Mueller wrote:
> The Guest Information Area (GIB) and its mechanics is part of
> the AIV facility. It provides hardware support to process
> Adapter Interruptions (AI) for pagable storage mode guests. 
> 
> Whenever a guest cannot process an AI because none of its
> vcpus is running in SIE context, a GIB alert interruption is
> sent to and handled by the host program to dispatch a vcpu of
> the respective guest.
> 
> Eventually, the AI is handled by the guest.
> 
> v6->v7:
>   patches 1/15 to 7/15
>      prepare the existing Interruption and GISA code for
>      the introduction of the GIB code. (kept from v6)
>   patches 8/15 to 10/15
>      kept from v6.
>   patch 11/15
>      kvm_s390_gisc_register() now uses a single conditional
>      branch to extend IAM restore value and to set the IAM
>      in GISA. 
>   patch 12/15
>      kvm_s390_clear_gisa() now refactored in its own patch.
>   patch 13/15
>      I'm keeping the 50 usec timer expiration as the statistic
>      data shows a single timer restart only.
>        gisa_get_ipm_or_restore_iam() now called when entering
>      kvm_s390_handle_wait(). That saves some of the timer
>      restarts.
>        Some modifications in kvm_s390_gisa_destroy()
>   patch 14/15
>      kept from v6.
>   patch 15/15
>      additional test on non NULL gisa origin in pending_irqs()
> 
> v5->v6:
>   Futher significant change was introduced with this version
>   now:
> 
>   a) During the alert list processing now a hrtimer is
>      started to kick an idle vcpu with open I/O interrupt
>      mask. It then is restarted to monitor the interruption
>      consumption and when the IPM is clean (no relevant
>      ISCs pending anymore) atomically restores the IAM
>      and don't restarts or if new ISCs arrive kick other
>      idle vcpus.
> 
>   patches 1/13 to 7/13:
>      prepare the existing Interruption and GISA code for
>      the introduction of the GIB code.
>   patches 8/13 to 10/13:
>      kept from v5.
>   patch 11/13:
>      Some comments added.
>   patch 12/13:
>      Significatly changed due to the hrtimer control.
>   patch 13/13:
>      Basically kept from v5 except for a slight reordering
>      that shortens the patch.
> 
> v4->v5:
>   Between these two versions some significant change was
>   introduced:
> 
>   a) During IPM look-up, the IAM gets atomically restored
>      if the IPM is clean. (The main strategy is: As soon no
>      airqs are pending anymore, get prepared for new ones
>      arriving).
> 
>   b) Kick a set of vcpus in WAIT state, that will be able
>      to handle all ISCs in IPM if possible. The main loop
>      that processes the GIB alert list is unchanged.
> 
>   patches 1/15 to 6/15:
>      prepare the existing Interruption and GISA code for
>      the introduction of the GIB code.
>   patches 7/15 to 9/15:
>      kept from v4. 
>   patch 10/15:
>      restores the IAM in get_ipm() when clean on request
>      with additional parameter irq_flags
>   patch 12/15:
>      modifies kvm_s390_deliver_pending_interrupts() such
>      that the IAM is not restored during the deliverable_irqs()
>      test as we are about to enter the SIE. Restoring the
>      IAM would trigger the alert mechanism unnecessarily
>      on SIE entry.
>   patch 13/15:
>      process_gib_alert_list() now triggers a minimal set
>      of idle vcpus capable the handle all pending ISCs.
>   patch 14/15:
>      the wiring is logical similar to v4 but uses different
>      routines
>   patch 15/15: 
>      kept from v4. 
> 
> v3->v4:
>   The central change of v4 is that the metric "vcpus_in_sie"
>   has been dropped. A least agressive IAM restore strategy
>   is being followed now. The consequence is that potentially
>   more GAL interruptions are to be handled by the host program.
>   The assuption as made that as soon the first vcpu is trying
>   to go into wait state, this could be the last vcpu being
>   open for I/O interruptions. Thus, to not loose the initiative
>   to deliver I/O interruptions as soon as possible, the IAM
>   is restored. Adding better heuristics can be done in future.
> 
>   I expect this to be the last version of the series.
>  
>   patch 01/12: Kernel msg now printed when FLIC fails
>                to register during arch inititialization.
>   patch 03/12: Commit message slightly changed with the
>   	       hint that gib initialization is called
> 	       by last patch of this serias.
>   patch 09/12: IAM now restored during kvm_s390_handle_wait()
>   patch 10/12: gib destroy case now handled upon unsuccessful
>   	       arch inititialization.
> 
> All other patches are unchanged.
> 
> v2->v3:
>   patch 01/12: Fixes a resource dealocation issue upon
>   	       unsuccessful exit from kvm_arch_init().
> 	       It is relevant for patch 11/12 as well. 
>   patch 08/12: The function process_gib_alert_list() has
>                been rewritten to reduce the number of GAL
> 	       interruptions on the host for many guest
> 	       scenarios.
>   patch 10/12: The IAM is now never cleared before SIE entry.
>                It will be cleared by millicode as soon the
> 	       first guest interruption is made pending and
> 	       not directly processed in SIE. The IAM gets
> 	       restored as soon a vm is idle, i.e. no vcpu
> 	       of that guest is in SIE context anymore.
>   patch 11/12: now integrates with new patch 01/12
>   patch 12/12: This patch is just experimental and shall not
>                be part of the final series.
> 
> The first patch of series v2: "leave AIs in IPM of GISA
> during vcpu_pre_run()" has been dropped.
> 
> All other patches are unchanged.
> 
> v1->v2:
>   patch 01/12: New patch. Tt can go also standalone without the
>   	       rest of the GIB series presented here but is a
> 	       requirement 
>   patch 03/12: kvm_s390_gib_init() now has a return code
>   patch 06/12: unlink_gib_alert_list() now uses cmpxchg() instead
>     	       of atomic_xchg()
>   patch 08/12: New patch. Foctors out __find_vcpu_for_floating_irq()
>   patch 09/12: process_gib_alert_list() has been simplified
>                the GISA clear/destroy cases have been removed
>   patch 11/12: kvm_s390_gisa_clear/destroy() now clear the IAM
>                and process the alert list directly
> 	       The IAM now gets restored in vcpu_post_run() only if
> 	       the GISA is not in alert list
>   patch 12/12: during kvm_arch_init() now the return code of
>     	       kvm_s390_gib_init() is honored.
> 
> All other patches are unchanged.
> 
> Michael Mueller (15):
>   KVM: s390: drop obsolete else path
>   KVM: s390: make bitmap declaration consistent
>   KVM: s390: move bitmap idle_mask into arch struct top level
>   KVM: s390: coding style kvm_s390_gisa_init/clear()
>   KVM: s390: use pending_irqs_no_gisa() where appropriate
>   KVM: s390: remove kvm_s390_ from gisa static inline functions
>   KVM: s390: introduce struct kvm_s390_gisa_interrupt
>   s390/cio: add function chsc_sgib()
>   KVM: s390: add the GIB and its related life-cyle functions
>   KVM: s390: add kvm reference to struct sie_page2
>   KVM: s390: add functions to (un)register GISC with GISA
>   KVM: s390: kvm_s390_gisa_clear() now clears the IPM only
>   KVM: s390: add gib_alert_irq_handler()
>   KVM: s390: start using the GIB
>   KVM: s390: fix possible null pointer dereference in pending_irqs()
> 
>  arch/s390/include/asm/cio.h      |   1 +
>  arch/s390/include/asm/irq.h      |   1 +
>  arch/s390/include/asm/isc.h      |   1 +
>  arch/s390/include/asm/kvm_host.h |  36 +++-
>  arch/s390/kernel/irq.c           |   1 +
>  arch/s390/kvm/interrupt.c        | 431 +++++++++++++++++++++++++++++++++++----
>  arch/s390/kvm/kvm-s390.c         |  13 +-
>  arch/s390/kvm/kvm-s390.h         |   4 +-
>  drivers/s390/cio/chsc.c          |  37 ++++
>  drivers/s390/cio/chsc.h          |   1 +
>  10 files changed, 480 insertions(+), 46 deletions(-)
> 
