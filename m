From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v4 0/5] implement vcpu preempted check
Date: Wed, 19 Oct 2016 08:47:09 +0200
Message-ID: <e3fd1bd3-c57d-f0b0-68c4-ecd450d1ad32@de.ibm.com>
References: <1476872416-42752-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1476872416-42752-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
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
To: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org, xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org
Cc: kernellwp@gmail.com, jgross@suse.com, peterz@infradead.org, benh@kernel.crashing.org, will.deacon@arm.com, mingo@redhat.com, paulus@samba.org, mpe@ellerman.id.au, pbonzini@redhat.com, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com
List-ID: <linux-s390.vger.kernel.org>

On 10/19/2016 12:20 PM, Pan Xinhui wrote:
> change from v3:
> 	add x86 vcpu preempted check patch

If you want you could add the s390 patch that I provided for your last version.
I also gave my Acked-by for all previous patches.



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
