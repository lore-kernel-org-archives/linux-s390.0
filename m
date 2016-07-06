Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Date: Wed, 06 Jul 2016 18:05:58 +0800
From: xinhui <xinhui.pan@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/4] implement vcpu preempted check
References: <1467124991-13164-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20160706065255.GH30909@twins.programming.kicks-ass.net>
In-Reply-To: <20160706065255.GH30909@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Message-Id: <577CD806.8000008@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org, mingo@redhat.com, mpe@ellerman.id.au, paulus@samba.org, benh@kernel.crashing.org, paulmck@linux.vnet.ibm.com, waiman.long@hpe.com, will.deacon@arm.com, boqun.feng@gmail.com, dave@stgolabs.net, schwidefsky@de.ibm.com, pbonzini@redhat.com
List-ID: <linux-s390.vger.kernel.org>
Content-Transfer-Encoding: 8bit



On 2016年07月06日 14:52, Peter Zijlstra wrote:
> On Tue, Jun 28, 2016 at 10:43:07AM -0400, Pan Xinhui wrote:
>> change fomr v1:
>> 	a simplier definition of default vcpu_is_preempted
>> 	skip mahcine type check on ppc, and add config. remove dedicated macro.
>> 	add one patch to drop overload of rwsem_spin_on_owner and mutex_spin_on_owner.
>> 	add more comments
>> 	thanks boqun and Peter's suggestion.
>>
>> This patch set aims to fix lock holder preemption issues.
>>
>> test-case:
>> perf record -a perf bench sched messaging -g 400 -p && perf report
>>
>> 18.09%  sched-messaging  [kernel.vmlinux]  [k] osq_lock
>> 12.28%  sched-messaging  [kernel.vmlinux]  [k] rwsem_spin_on_owner
>>   5.27%  sched-messaging  [kernel.vmlinux]  [k] mutex_unlock
>>   3.89%  sched-messaging  [kernel.vmlinux]  [k] wait_consider_task
>>   3.64%  sched-messaging  [kernel.vmlinux]  [k] _raw_write_lock_irq
>>   3.41%  sched-messaging  [kernel.vmlinux]  [k] mutex_spin_on_owner.is
>>   2.49%  sched-messaging  [kernel.vmlinux]  [k] system_call
>>
>> We introduce interface bool vcpu_is_preempted(int cpu) and use it in some spin
>> loops of osq_lock, rwsem_spin_on_owner and mutex_spin_on_owner.
>> These spin_on_onwer variant also cause rcu stall before we apply this patch set
>>
>
> Paolo, could you help out with an (x86) KVM interface for this?
>
> Waiman, could you see if you can utilize this to get rid of the
> SPIN_THRESHOLD in qspinlock_paravirt?
>
hmm. maybe something like below. wait_node can go into pv_wait() earlier as soon as the prev cpu is preempted.
but for the wait_head, as qspinlock does not record the lock_holder correctly(thanks to lock stealing), vcpu preemption check might get wrong results.

Waiman, I have used one hash table to keep the lock holder in my ppc implementation patch. I think we could do something similar in generic code?

diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index 74c4a86..40560e8 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -312,7 +312,8 @@ pv_wait_early(struct pv_node *prev, int loop)
         if ((loop & PV_PREV_CHECK_MASK) != 0)
                 return false;
  
-       return READ_ONCE(prev->state) != vcpu_running;
+       return READ_ONCE(prev->state) != vcpu_running ||
+                               vcpu_is_preempted(prev->cpu);
  }
  
  /*
