Return-Path: <kernellwp@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CANRm+CyrPbOVpJ6-Wa=g6oXTU0vVfw-ciLgm-duZeVF6MBH=RA@mail.gmail.com>
References: <1467124991-13164-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20160706065255.GH30909@twins.programming.kicks-ass.net>
 <14a24854-9787-e4a1-c9a8-76eba4e97301@redhat.com>
 <CANRm+CwXLsNrC59g6tZk=U+T0Scn_O=b60NPESJXU6uaP7-AsA@mail.gmail.com>
 <8e8edf1b-b64b-3c44-b580-b9271663844c@redhat.com>
 <CANRm+Cz1Ncxm7g0ophT+ijUmqnmTq9VwCZau3wMS56Vkm2+7fQ@mail.gmail.com>
 <20160707094215.GT30921@twins.programming.kicks-ass.net>
 <CANRm+CyrPbOVpJ6-Wa=g6oXTU0vVfw-ciLgm-duZeVF6MBH=RA@mail.gmail.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Thu, 7 Jul 2016 18:27:26 +0800
Message-ID: <CANRm+CxKVqrFB-cRPEvmUamZ5Y8cOGe3pyc0LMJy0t9_jo+i0Q@mail.gmail.com>
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
To: Peter Zijlstra <peterz@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, mpe@ellerman.id.au, boqun.feng@gmail.com, will.deacon@arm.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Waiman Long <waiman.long@hpe.com>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, benh@kernel.crashing.org, schwidefsky@de.ibm.com, Paul McKenney <paulmck@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, kvm <kvm@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

2016-07-07 18:12 GMT+08:00 Wanpeng Li <kernellwp@gmail.com>:
> 2016-07-07 17:42 GMT+08:00 Peter Zijlstra <peterz@infradead.org>:
>> On Thu, Jul 07, 2016 at 04:48:05PM +0800, Wanpeng Li wrote:
>>> 2016-07-06 20:28 GMT+08:00 Paolo Bonzini <pbonzini@redhat.com>:
>>> > Hmm, you're right.  We can use bit 0 of struct kvm_steal_time's flags to
>>> > indicate that pad[0] is a "VCPU preempted" field; if pad[0] is 1, the
>>> > VCPU has been scheduled out since the last time the guest reset the bit.
>>> >  The guest can use an xchg to test-and-clear it.  The bit can be
>>> > accessed at any time, independent of the version field.
>>>
>>> If one vCPU is preempted, and guest check it several times before this
>>> vCPU is scheded in, then the first time we can get "vCPU is
>>> preempted", however, since the field is cleared, the second time we
>>> will get "vCPU is running".
>>>
>>> Do you mean we should call record_steal_time() in both kvm_sched_in()
>>> and kvm_sched_out() to record this field? Btw, if we should keep both
>>> vcpu->preempted and kvm_steal_time's "vCPU preempted" field present
>>> simultaneous?
>>
>> I suspect you want something like so; except this has holes in.
>>
>> We clear KVM_ST_PAD_PREEMPT before disabling preemption and we set it
>> after enabling it, this means that if we get preempted in between, the
>> vcpu is reported as running even though it very much is not.
>
> Paolo also point out this to me offline yesterday: "Please change
> pad[12] to "__u32 preempted; __u32 pad[11];" too, and remember to
> update Documentation/virtual/kvm/msr.txt!". Btw, do this in preemption
> notifier means that the vCPU is real preempted on host, however,
> depends on vmexit is different semantic I think.

In addition, I see xen's vcpu_runstate_info::state is updated during
schedule, so I think I can do this similarly through kvm preemption
notifier. IIUC, xen hypervisor has VCPUOP_get_runstate_info hypercall
implemention, so the desired interface can be implemented if they add
hypercall callsite in domU. I can add hypercall to kvm similarly.

Paolo, thoughts?

Regards,
Wanpeng Li
