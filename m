From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v3 0/4] implement vcpu preempted check
Date: Wed, 5 Oct 2016 13:00:51 +0200
Message-ID: <847f7377-61d3-835e-458b-aa9f4f5fcf8c@de.ibm.com>
References: <1469101514-49475-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1469101514-49475-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
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
Cc: kernellwp@gmail.com, jgross@suse.com, peterz@infradead.org, benh@kernel.crashing.org, will.deacon@arm.com, mingo@redhat.com, paulus@samba.org, mpe@ellerman.id.au, pbonzini@redhat.com, paulmck@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 07/21/2016 01:45 PM, Pan Xinhui wrote:
> change from v2:
> 	no code change, fix typos, update some comments
> 
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
> before patch:
> 18.09%  sched-messaging  [kernel.vmlinux]  [k] osq_lock
> 12.28%  sched-messaging  [kernel.vmlinux]  [k] rwsem_spin_on_owner
>  5.27%  sched-messaging  [kernel.vmlinux]  [k] mutex_unlock
>  3.89%  sched-messaging  [kernel.vmlinux]  [k] wait_consider_task
>  3.64%  sched-messaging  [kernel.vmlinux]  [k] _raw_write_lock_irq
>  3.41%  sched-messaging  [kernel.vmlinux]  [k] mutex_spin_on_owner.is
>  2.49%  sched-messaging  [kernel.vmlinux]  [k] system_call
> 
> after patch:
>  9.99%  sched-messaging  [kernel.vmlinux]  [k] mutex_unlock
>  5.28%  sched-messaging  [unknown]         [H] 0xc0000000000768e0
>  4.27%  sched-messaging  [kernel.vmlinux]  [k] __copy_tofrom_user_power7
>  3.77%  sched-messaging  [kernel.vmlinux]  [k] copypage_power7
>  3.24%  sched-messaging  [kernel.vmlinux]  [k] _raw_write_lock_irq
>  3.02%  sched-messaging  [kernel.vmlinux]  [k] system_call
>  2.69%  sched-messaging  [kernel.vmlinux]  [k] wait_consider_task
> 
> We introduce interface bool vcpu_is_preempted(int cpu) and use it in some spin
> loops of osq_lock, rwsem_spin_on_owner and mutex_spin_on_owner.
> These spin_on_onwer variant also cause rcu stall before we apply this patch set
> 
> Pan Xinhui (4):
>   kernel/sched: introduce vcpu preempted check interface
>   powerpc/spinlock: support vcpu preempted check
>   locking/osq: Drop the overhead of osq_lock()
>   kernel/locking: Drop the overhead of {mutex,rwsem}_spin_on_owner
> 
>  arch/powerpc/include/asm/spinlock.h | 18 ++++++++++++++++++
>  include/linux/sched.h               | 12 ++++++++++++
>  kernel/locking/mutex.c              | 15 +++++++++++++--
>  kernel/locking/osq_lock.c           | 10 +++++++++-
>  kernel/locking/rwsem-xadd.c         | 16 +++++++++++++---
>  5 files changed, 65 insertions(+), 6 deletions(-)
> 

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
for the full series. With my patch on top this really improves
some benchmarks for overcommitted KVM guests.
