Return-Path: <kernellwp@gmail.com>
MIME-Version: 1.0
In-Reply-To: <577C8FE3.3010208@linux.vnet.ibm.com>
References: <1467124991-13164-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1467124991-13164-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <CANRm+CxQMSrg69p2Xey829Mz4Au9YCai+4JD17i9urdbj0VgkQ@mail.gmail.com>
 <577C8FE3.3010208@linux.vnet.ibm.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Wed, 6 Jul 2016 14:46:34 +0800
Message-ID: <CANRm+CySutzEYQuCaeqyLKKVPPcFDFT94UsNaYWo8fU43VsSig@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] powerpc/spinlock: support vcpu preempted check
Content-Type: text/plain; charset=UTF-8
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org, linux-s390 <linux-s390@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, mpe@ellerman.id.au, Paul Mackerras <paulus@samba.org>, benh@kernel.crashing.org, Paul McKenney <paulmck@linux.vnet.ibm.com>, Waiman Long <waiman.long@hpe.com>, will.deacon@arm.com, boqun.feng@gmail.com, Davidlohr Bueso <dave@stgolabs.net>, schwidefsky@de.ibm.com, Paolo Bonzini <pbonzini@redhat.com>, kvm <kvm@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Cc Paolo, kvm ml
2016-07-06 12:58 GMT+08:00 xinhui <xinhui.pan@linux.vnet.ibm.com>:
> Hi, wanpeng
>
> On 2016=E5=B9=B407=E6=9C=8805=E6=97=A5 17:57, Wanpeng Li wrote:
>>
>> Hi Xinhui,
>> 2016-06-28 22:43 GMT+08:00 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>:
>>>
>>> This is to fix some lock holder preemption issues. Some other locks
>>> implementation do a spin loop before acquiring the lock itself. Current=
ly
>>> kernel has an interface of bool vcpu_is_preempted(int cpu). It take the
>>> cpu
>>> as parameter and return true if the cpu is preempted. Then kernel can
>>> break
>>> the spin loops upon on the retval of vcpu_is_preempted.
>>>
>>> As kernel has used this interface, So lets support it.
>>>
>>> Only pSeries need supoort it. And the fact is powerNV are built into sa=
me
>>> kernel image with pSeries. So we need return false if we are runnig as
>>> powerNV. The another fact is that lppaca->yiled_count keeps zero on
>>> powerNV. So we can just skip the machine type.
>>
>>
>> Lock holder vCPU preemption can be detected by hardware pSeries or
>> paravirt method?
>>
> There is one shard struct between kernel and powerVM/KVM. And we read the
> yield_count of this struct to detect if one vcpu is running or not.
> SO it's easy for ppc to implement such interface. Note that yield_count i=
s
> set by powerVM/KVM.
> and only pSeries can run a guest for now. :)
>
> I also review x86 related code, looks like we need add one hyer-call to g=
et
> such vcpu preemption info?

There is no such stuff to record lock holder in x86 kvm, maybe we
don't need to depend on PLE handler algorithm to guess it if we can
know lock holder vCPU directly.

Regards,
Wanpeng Li
