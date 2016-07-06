Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Date: Wed, 06 Jul 2016 18:18:27 +0800
From: xinhui <xinhui.pan@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/4] powerpc/spinlock: support vcpu preempted check
References: <1467124991-13164-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1467124991-13164-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <CANRm+CxQMSrg69p2Xey829Mz4Au9YCai+4JD17i9urdbj0VgkQ@mail.gmail.com>
 <577C8FE3.3010208@linux.vnet.ibm.com>
 <CANRm+CySutzEYQuCaeqyLKKVPPcFDFT94UsNaYWo8fU43VsSig@mail.gmail.com>
 <20160706075814.GF30921@twins.programming.kicks-ass.net>
 <CANRm+Cz5-XGDTNkZ_RcoX+gxF_+JDpUB6OB+ECOQcScuaeKfGA@mail.gmail.com>
In-Reply-To: <CANRm+Cz5-XGDTNkZ_RcoX+gxF_+JDpUB6OB+ECOQcScuaeKfGA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Message-Id: <577CDAF3.4030401@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Wanpeng Li <kernellwp@gmail.com>, Peter Zijlstra <peterz@infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org, linux-s390 <linux-s390@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, mpe@ellerman.id.au, Paul Mackerras <paulus@samba.org>, benh@kernel.crashing.org, Paul McKenney <paulmck@linux.vnet.ibm.com>, Waiman Long <waiman.long@hpe.com>, will.deacon@arm.com, boqun.feng@gmail.com, Davidlohr Bueso <dave@stgolabs.net>, schwidefsky@de.ibm.com, Paolo Bonzini <pbonzini@redhat.com>, kvm <kvm@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>
Content-Transfer-Encoding: 8bit


On 2016年07月06日 16:32, Wanpeng Li wrote:
> 2016-07-06 15:58 GMT+08:00 Peter Zijlstra <peterz@infradead.org>:
>> On Wed, Jul 06, 2016 at 02:46:34PM +0800, Wanpeng Li wrote:
>>>> SO it's easy for ppc to implement such interface. Note that yield_count is
>>>> set by powerVM/KVM.
>>>> and only pSeries can run a guest for now. :)
>>>>
>>>> I also review x86 related code, looks like we need add one hyer-call to get
>>>> such vcpu preemption info?
>>>
>>> There is no such stuff to record lock holder in x86 kvm, maybe we
>>> don't need to depend on PLE handler algorithm to guess it if we can
>>> know lock holder vCPU directly.
>>
>> x86/kvm has vcpu->preempted to indicate if a vcpu is currently preempted
>> or not. I'm just not sure if that is visible to the guest or how to make
>> it so.
>
> Yeah, I miss it. I can be the volunteer to do it if there is any idea,
> ping Paolo. :)
>
glad to know that. :)


> Regards,
> Wanpeng Li
>
