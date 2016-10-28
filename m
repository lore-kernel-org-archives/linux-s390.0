From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] [PATCH v6 00/11] implement vcpu preempted check
Date: Fri, 28 Oct 2016 15:38:17 -0400
Message-ID: <20161028193817.GD2879@char.us.oracle.com>
References: <1477642287-24104-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1477642287-24104-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, rkrcmar@redhat.com, peterz@infradead.org, benh@kernel.crashing.org, will.deacon@arm.com, virtualization@lists.linux-foundation.org, paulus@samba.org, kernellwp@gmail.com, linux-s390@vger.kernel.org, xen-devel-request@lists.xenproject.org, x86@kernel.org, mingo@redhat.com, xen-devel@lists.xenproject.org, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, jgross@suse.com, linux-kernel@vger.kernel.org, David.Laight@ACULAB.COM, mpe@ellerman.id.au, pbonzini@redhat.com, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Oct 28, 2016 at 04:11:16AM -0400, Pan Xinhui wrote:
> change from v5:
> 	spilt x86/kvm patch into guest/host part.
> 	introduce kvm_write_guest_offset_cached.
> 	fix some typos.
> 	rebase patch onto 4.9.2
> change from v4:
> 	spilt x86 kvm vcpu preempted check into two patches.
> 	add documentation patch.
> 	add x86 vcpu preempted check patch under xen
> 	add s390 vcpu preempted check patch 
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

Do you have a git tree with these patches?

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
> We also have observed some performace improvements in uninx benchmark tests.
> 
> PPC test result:
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
> Christian Borntraeger (1):
>   s390/spinlock: Provide vcpu_is_preempted
> 
> Juergen Gross (1):
>   x86, xen: support vcpu preempted check
> 
> Pan Xinhui (9):
>   kernel/sched: introduce vcpu preempted check interface
>   locking/osq: Drop the overload of osq_lock()
>   kernel/locking: Drop the overload of {mutex,rwsem}_spin_on_owner
>   powerpc/spinlock: support vcpu preempted check
>   x86, paravirt: Add interface to support kvm/xen vcpu preempted check
>   KVM: Introduce kvm_write_guest_offset_cached
>   x86, kvm/x86.c: support vcpu preempted check
>   x86, kernel/kvm.c: support vcpu preempted check
>   Documentation: virtual: kvm: Support vcpu preempted check
> 
>  Documentation/virtual/kvm/msr.txt     |  9 ++++++++-
>  arch/powerpc/include/asm/spinlock.h   |  8 ++++++++
>  arch/s390/include/asm/spinlock.h      |  8 ++++++++
>  arch/s390/kernel/smp.c                |  9 +++++++--
>  arch/s390/lib/spinlock.c              | 25 ++++++++-----------------
>  arch/x86/include/asm/paravirt_types.h |  2 ++
>  arch/x86/include/asm/spinlock.h       |  8 ++++++++
>  arch/x86/include/uapi/asm/kvm_para.h  |  4 +++-
>  arch/x86/kernel/kvm.c                 | 12 ++++++++++++
>  arch/x86/kernel/paravirt-spinlocks.c  |  6 ++++++
>  arch/x86/kvm/x86.c                    | 16 ++++++++++++++++
>  arch/x86/xen/spinlock.c               |  3 ++-
>  include/linux/kvm_host.h              |  2 ++
>  include/linux/sched.h                 | 12 ++++++++++++
>  kernel/locking/mutex.c                | 15 +++++++++++++--
>  kernel/locking/osq_lock.c             | 10 +++++++++-
>  kernel/locking/rwsem-xadd.c           | 16 +++++++++++++---
>  virt/kvm/kvm_main.c                   | 20 ++++++++++++++------
>  18 files changed, 151 insertions(+), 34 deletions(-)
> 
> -- 
> 2.4.11
> 
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xen.org
> https://lists.xen.org/xen-devel
