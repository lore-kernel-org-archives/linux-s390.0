Return-Path: <kernellwp@gmail.com>
MIME-Version: 1.0
In-Reply-To: <8e8edf1b-b64b-3c44-b580-b9271663844c@redhat.com>
References: <1467124991-13164-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20160706065255.GH30909@twins.programming.kicks-ass.net>
 <14a24854-9787-e4a1-c9a8-76eba4e97301@redhat.com>
 <CANRm+CwXLsNrC59g6tZk=U+T0Scn_O=b60NPESJXU6uaP7-AsA@mail.gmail.com>
 <8e8edf1b-b64b-3c44-b580-b9271663844c@redhat.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Wed, 6 Jul 2016 21:03:01 +0800
Message-ID: <CANRm+Cyu0T=gWbZQT5WzdknYQWspRmC2wTt6_KLS4tP9QVuWUA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] implement vcpu preempted check
Content-Type: text/plain; charset=UTF-8
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, mpe@ellerman.id.au, boqun.feng@gmail.com, will.deacon@arm.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Waiman Long <waiman.long@hpe.com>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, benh@kernel.crashing.org, schwidefsky@de.ibm.com, Paul McKenney <paulmck@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, kvm <kvm@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

2016-07-06 20:28 GMT+08:00 Paolo Bonzini <pbonzini@redhat.com>:
>
>
> On 06/07/2016 14:08, Wanpeng Li wrote:
>> 2016-07-06 18:44 GMT+08:00 Paolo Bonzini <pbonzini@redhat.com>:
>>>
>>>
>>> On 06/07/2016 08:52, Peter Zijlstra wrote:
>>>> On Tue, Jun 28, 2016 at 10:43:07AM -0400, Pan Xinhui wrote:
>>>>> change fomr v1:
>>>>>      a simplier definition of default vcpu_is_preempted
>>>>>      skip mahcine type check on ppc, and add config. remove dedicated macro.
>>>>>      add one patch to drop overload of rwsem_spin_on_owner and mutex_spin_on_owner.
>>>>>      add more comments
>>>>>      thanks boqun and Peter's suggestion.
>>>>>
>>>>> This patch set aims to fix lock holder preemption issues.
>>>>>
>>>>> test-case:
>>>>> perf record -a perf bench sched messaging -g 400 -p && perf report
>>>>>
>>>>> 18.09%  sched-messaging  [kernel.vmlinux]  [k] osq_lock
>>>>> 12.28%  sched-messaging  [kernel.vmlinux]  [k] rwsem_spin_on_owner
>>>>>  5.27%  sched-messaging  [kernel.vmlinux]  [k] mutex_unlock
>>>>>  3.89%  sched-messaging  [kernel.vmlinux]  [k] wait_consider_task
>>>>>  3.64%  sched-messaging  [kernel.vmlinux]  [k] _raw_write_lock_irq
>>>>>  3.41%  sched-messaging  [kernel.vmlinux]  [k] mutex_spin_on_owner.is
>>>>>  2.49%  sched-messaging  [kernel.vmlinux]  [k] system_call
>>>>>
>>>>> We introduce interface bool vcpu_is_preempted(int cpu) and use it in some spin
>>>>> loops of osq_lock, rwsem_spin_on_owner and mutex_spin_on_owner.
>>>>> These spin_on_onwer variant also cause rcu stall before we apply this patch set
>>>>
>>>> Paolo, could you help out with an (x86) KVM interface for this?
>>>
>>> If it's just for spin loops, you can check if the version field in the
>>> steal time structure has changed.
>>
>> Steal time will not be updated until ahead of next vmentry except
>> wrmsr MSR_KVM_STEAL_TIME. So it can't represent it is preempted
>> currently, right?
>
> Hmm, you're right.  We can use bit 0 of struct kvm_steal_time's flags to
> indicate that pad[0] is a "VCPU preempted" field; if pad[0] is 1, the
> VCPU has been scheduled out since the last time the guest reset the bit.
>  The guest can use an xchg to test-and-clear it.  The bit can be
> accessed at any time, independent of the version field.

I will try to implement it tomorrow, thanks for your proposal. :)

Regards,
Wanpeng Li
