From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v7 06/11] x86, paravirt: Add interface to support kvm/xen
 vcpu preempted check
Date: Wed, 16 Nov 2016 12:29:44 +0100
Message-ID: <f8b9d1be-98a2-4d99-1ae1-c31c6fe13903@de.ibm.com>
References: <1478077718-37424-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1478077718-37424-7-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20161115154706.GF11311@worktop.programming.kicks-ass.net>
 <a6026a0c-9ad8-5025-c616-eb33f96e91ce@linux.vnet.ibm.com>
 <20161116102355.GP3142@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161116102355.GP3142@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Pan Xinhui <xinhui@linux.vnet.ibm.com>
Cc: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org, xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, mingo@redhat.com, paulmck@linux.vnet.ibm.com, will.deacon@arm.com, kernellwp@gmail.com, jgross@suse.com, pbonzini@redhat.com, bsingharora@gmail.com, boqun.feng@gmail.com, rkrcmar@redhat.com, David.Laight@ACULAB.COM, dave@stgolabs.net, konrad.wilk@oracle.com
List-ID: <linux-s390.vger.kernel.org>

On 11/16/2016 11:23 AM, Peter Zijlstra wrote:
> On Wed, Nov 16, 2016 at 12:19:09PM +0800, Pan Xinhui wrote:
>> Hi, Peter.
>> 	I think we can avoid a function call in a simpler way. How about below
>>
>> static inline bool vcpu_is_preempted(int cpu)
>> {
>> 	/* only set in pv case*/
>> 	if (pv_lock_ops.vcpu_is_preempted)
>> 		return pv_lock_ops.vcpu_is_preempted(cpu);
>> 	return false;
>> }
> 
> That is still more expensive. It needs to do an actual load and makes it
> hard to predict the branch, you'd have to actually wait for the load to
> complete etc.

Out of curiosity, why is that hard to predict?
On s390 the branch prediction runs asynchronously ahead of the downstream
pipeline (e.g. search for "IBM z Systems Processor Optimization Primer" page 11).
given enough capacity, I would assume that modern x86 processors would do the same
and be able to predict this is as soon as it becomes hot (and otherwise you would
 not notice the branch miss anyway). Is x86 behaving differently here?

> Also, it generates more code.
> 
> Paravirt muck should strive to be as cheap as possible when ran on
> native hardware.

As I am interested in this series from the s390 point of view, this is 
the only thing that block this series?

Is there a chance to add a static key around the paravirt ops somehow?
