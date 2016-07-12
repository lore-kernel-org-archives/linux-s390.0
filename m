Return-Path: <jgross@suse.com>
Subject: Re: [PATCH v2 0/4] implement vcpu preempted check
References: <1467124991-13164-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20160706065255.GH30909@twins.programming.kicks-ass.net>
 <5783B6D7.7020903@hpe.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <57846F02.7000306@suse.com>
Date: Tue, 12 Jul 2016 06:16:02 +0200
MIME-Version: 1.0
In-Reply-To: <5783B6D7.7020903@hpe.com>
Content-Type: text/plain; charset=windows-1252
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Waiman Long <waiman.long@hpe.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-s390@vger.kernel.org, dave@stgolabs.net, benh@kernel.crashing.org, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, boqun.feng@gmail.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, pbonzini@redhat.com, paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

On 11/07/16 17:10, Waiman Long wrote:
> On 07/06/2016 02:52 AM, Peter Zijlstra wrote:
>> On Tue, Jun 28, 2016 at 10:43:07AM -0400, Pan Xinhui wrote:
>>> change fomr v1:
>>>     a simplier definition of default vcpu_is_preempted
>>>     skip mahcine type check on ppc, and add config. remove dedicated
>>> macro.
>>>     add one patch to drop overload of rwsem_spin_on_owner and
>>> mutex_spin_on_owner.
>>>     add more comments
>>>     thanks boqun and Peter's suggestion.
>>>
>>> This patch set aims to fix lock holder preemption issues.
>>>
>>> test-case:
>>> perf record -a perf bench sched messaging -g 400 -p&&  perf report
>>>
>>> 18.09%  sched-messaging  [kernel.vmlinux]  [k] osq_lock
>>> 12.28%  sched-messaging  [kernel.vmlinux]  [k] rwsem_spin_on_owner
>>>   5.27%  sched-messaging  [kernel.vmlinux]  [k] mutex_unlock
>>>   3.89%  sched-messaging  [kernel.vmlinux]  [k] wait_consider_task
>>>   3.64%  sched-messaging  [kernel.vmlinux]  [k] _raw_write_lock_irq
>>>   3.41%  sched-messaging  [kernel.vmlinux]  [k] mutex_spin_on_owner.is
>>>   2.49%  sched-messaging  [kernel.vmlinux]  [k] system_call
>>>
>>> We introduce interface bool vcpu_is_preempted(int cpu) and use it in
>>> some spin
>>> loops of osq_lock, rwsem_spin_on_owner and mutex_spin_on_owner.
>>> These spin_on_onwer variant also cause rcu stall before we apply this
>>> patch set
>>>
>> Paolo, could you help out with an (x86) KVM interface for this?
>>
>> Waiman, could you see if you can utilize this to get rid of the
>> SPIN_THRESHOLD in qspinlock_paravirt?
> 
> That API is certainly useful to make the paravirt spinlock perform
> better. However, I am not sure if we can completely get rid of the
> SPIN_THRESHOLD at this point. It is not just the kvm, the xen code need
> to be modified as well.

This should be rather easy. The relevant information is included in the
runstate data mapped into kernel memory. I can provide a patch for Xen
if needed.


Juergen
