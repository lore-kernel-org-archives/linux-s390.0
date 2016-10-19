From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v4 0/5] implement vcpu preempted check
Date: Wed, 19 Oct 2016 17:58:46 +0200
Message-ID: <a801cd40-1019-01e2-1013-f04363fc7f31@suse.com>
References: <1476872416-42752-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------0DA18E86B982FAA044921A6E"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1476872416-42752-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, mingo@redhat.com, peterz@infradead.org, paulmck@linux.vnet.ibm.com, will.deacon@arm.com, kernellwp@gmail.com, pbonzini@redhat.com, bsingharora@gmail.com, boqun.feng@gmail.com, borntraeger@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

This is a multi-part message in MIME format.
--------------0DA18E86B982FAA044921A6E
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

On 19/10/16 12:20, Pan Xinhui wrote:
> change from v3:
> 	add x86 vcpu preempted check patch
> change from v2:
> 	no code change, fix typos, update some comments
> change from v1:
> 	a simplier definition of default vcpu_is_preempted
> 	skip mahcine type check on ppc, and add config. remove dedicated macro.
> 	add one patch to drop overload of rwsem_spin_on_owner and mutex_spin_on_owner. 
> 	add more comments
> 	thanks boqun and Peter's suggestion.
> 
> This patch set aims to fix lock holder preemption issues.
> 
> test-case:
> perf record -a perf bench sched messaging -g 400 -p && perf report
> 
> 18.09%  sched-messaging  [kernel.vmlinux]  [k] osq_lock
> 12.28%  sched-messaging  [kernel.vmlinux]  [k] rwsem_spin_on_owner
>  5.27%  sched-messaging  [kernel.vmlinux]  [k] mutex_unlock
>  3.89%  sched-messaging  [kernel.vmlinux]  [k] wait_consider_task
>  3.64%  sched-messaging  [kernel.vmlinux]  [k] _raw_write_lock_irq
>  3.41%  sched-messaging  [kernel.vmlinux]  [k] mutex_spin_on_owner.is
>  2.49%  sched-messaging  [kernel.vmlinux]  [k] system_call
> 
> We introduce interface bool vcpu_is_preempted(int cpu) and use it in some spin
> loops of osq_lock, rwsem_spin_on_owner and mutex_spin_on_owner.
> These spin_on_onwer variant also cause rcu stall before we apply this patch set
> 
> We also have observed some performace improvements.
> 
> PPC test result:
> 
> 1 copy - 0.94%
> 2 copy - 7.17%
> 4 copy - 11.9%
> 8 copy -  3.04%
> 16 copy - 15.11%
> 
> details below:
> Without patch:
> 
> 1 copy - File Write 4096 bufsize 8000 maxblocks      2188223.0 KBps  (30.0 s, 1 samples)
> 2 copy - File Write 4096 bufsize 8000 maxblocks      1804433.0 KBps  (30.0 s, 1 samples)
> 4 copy - File Write 4096 bufsize 8000 maxblocks      1237257.0 KBps  (30.0 s, 1 samples)
> 8 copy - File Write 4096 bufsize 8000 maxblocks      1032658.0 KBps  (30.0 s, 1 samples)
> 16 copy - File Write 4096 bufsize 8000 maxblocks       768000.0 KBps  (30.1 s, 1 samples)
> 
> With patch: 
> 
> 1 copy - File Write 4096 bufsize 8000 maxblocks      2209189.0 KBps  (30.0 s, 1 samples)
> 2 copy - File Write 4096 bufsize 8000 maxblocks      1943816.0 KBps  (30.0 s, 1 samples)
> 4 copy - File Write 4096 bufsize 8000 maxblocks      1405591.0 KBps  (30.0 s, 1 samples)
> 8 copy - File Write 4096 bufsize 8000 maxblocks      1065080.0 KBps  (30.0 s, 1 samples)
> 16 copy - File Write 4096 bufsize 8000 maxblocks       904762.0 KBps  (30.0 s, 1 samples)
> 
> X86 test result:
> 	test-case			after-patch	  before-patch
> Execl Throughput                       |    18307.9 lps  |    11701.6 lps 
> File Copy 1024 bufsize 2000 maxblocks  |  1352407.3 KBps |   790418.9 KBps
> File Copy 256 bufsize 500 maxblocks    |   367555.6 KBps |   222867.7 KBps
> File Copy 4096 bufsize 8000 maxblocks  |  3675649.7 KBps |  1780614.4 KBps
> Pipe Throughput                        | 11872208.7 lps  | 11855628.9 lps 
> Pipe-based Context Switching           |  1495126.5 lps  |  1490533.9 lps 
> Process Creation                       |    29881.2 lps  |    28572.8 lps 
> Shell Scripts (1 concurrent)           |    23224.3 lpm  |    22607.4 lpm 
> Shell Scripts (8 concurrent)           |     3531.4 lpm  |     3211.9 lpm 
> System Call Overhead                   | 10385653.0 lps  | 10419979.0 lps 
> 
> Pan Xinhui (5):
>   kernel/sched: introduce vcpu preempted check interface
>   locking/osq: Drop the overload of osq_lock()
>   kernel/locking: Drop the overload of {mutex,rwsem}_spin_on_owner
>   powerpc/spinlock: support vcpu preempted check
>   x86, kvm: support vcpu preempted check

The attached patch adds Xen support for x86. Please tell me whether you
want to add this patch to your series or if I should post it when your
series has been accepted.

You can add my

Tested-by: Juergen Gross <jgross@suse.com>

for patches 1-3 and 5 (paravirt parts only).


Juergen

> 
>  arch/powerpc/include/asm/spinlock.h   |  8 ++++++++
>  arch/x86/include/asm/paravirt_types.h |  6 ++++++
>  arch/x86/include/asm/spinlock.h       |  8 ++++++++
>  arch/x86/include/uapi/asm/kvm_para.h  |  3 ++-
>  arch/x86/kernel/kvm.c                 | 11 +++++++++++
>  arch/x86/kernel/paravirt.c            | 11 +++++++++++
>  arch/x86/kvm/x86.c                    | 12 ++++++++++++
>  include/linux/sched.h                 | 12 ++++++++++++
>  kernel/locking/mutex.c                | 15 +++++++++++++--
>  kernel/locking/osq_lock.c             | 10 +++++++++-
>  kernel/locking/rwsem-xadd.c           | 16 +++++++++++++---
>  11 files changed, 105 insertions(+), 7 deletions(-)
> 


--------------0DA18E86B982FAA044921A6E
Content-Type: text/x-patch;
 name="0001-x86-xen-support-vcpu-preempted-check.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-x86-xen-support-vcpu-preempted-check.patch"

From c79b86d00a812d6207ef788d453e2d0289ef22a0 Mon Sep 17 00:00:00 2001
From: Juergen Gross <jgross@suse.com>
Date: Wed, 19 Oct 2016 15:30:59 +0200
Subject: [PATCH] x86, xen: support vcpu preempted check

Support the vcpu_is_preempted() functionality under Xen. This will
enhance lock performance on overcommitted hosts (more runnable vcpus
than physical cpus in the system) as doing busy waits for preempted
vcpus will hurt system performance far worse than early yielding.

A quick test (4 vcpus on 1 physical cpu doing a parallel build job
with "make -j 8") reduced system time by about 5% with this patch.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/spinlock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
index 3d6e006..1d53b1b 100644
--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -114,7 +114,6 @@ void xen_uninit_lock_cpu(int cpu)
 	per_cpu(irq_name, cpu) = NULL;
 }
 
-
 /*
  * Our init of PV spinlocks is split in two init functions due to us
  * using paravirt patching and jump labels patching and having to do
@@ -137,6 +136,8 @@ void __init xen_init_spinlocks(void)
 	pv_lock_ops.queued_spin_unlock = PV_CALLEE_SAVE(__pv_queued_spin_unlock);
 	pv_lock_ops.wait = xen_qlock_wait;
 	pv_lock_ops.kick = xen_qlock_kick;
+
+	pv_vcpu_ops.vcpu_is_preempted = xen_vcpu_stolen;
 }
 
 /*
-- 
2.6.6


--------------0DA18E86B982FAA044921A6E--
