From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v7 06/11] x86, paravirt: Add interface to support kvm/xen
	vcpu preempted check
Date: Wed, 16 Nov 2016 12:43:13 +0100
Message-ID: <20161116114313.GS3142@twins.programming.kicks-ass.net>
References: <1478077718-37424-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<1478077718-37424-7-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<20161115154706.GF11311@worktop.programming.kicks-ass.net>
	<a6026a0c-9ad8-5025-c616-eb33f96e91ce@linux.vnet.ibm.com>
	<20161116102355.GP3142@twins.programming.kicks-ass.net>
	<f8b9d1be-98a2-4d99-1ae1-c31c6fe13903@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <f8b9d1be-98a2-4d99-1ae1-c31c6fe13903@de.ibm.com>
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
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: kvm@vger.kernel.org, rkrcmar@redhat.com, benh@kernel.crashing.org, will.deacon@arm.com, virtualization@lists.linux-foundation.org, paulus@samba.org, kernellwp@gmail.com, linux-s390@vger.kernel.org, dave@stgolabs.net, mpe@ellerman.id.au, x86@kernel.org, mingo@redhat.com, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, xen-devel@lists.xenproject.org, paulmck@linux.vnet.ibm.com, Pan Xinhui <xinhui@linux.vnet.ibm.com>, konrad.wilk@oracle.com, boqun.feng@gmail.com, jgross@suse.com, linux-kernel@vger.kernel.org, David.Laight@ACULAB.COM, xen-devel-request@lists.xenproject.org, pbonzini@redhat.com, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Nov 16, 2016 at 12:29:44PM +0100, Christian Borntraeger wrote:
> On 11/16/2016 11:23 AM, Peter Zijlstra wrote:
> > On Wed, Nov 16, 2016 at 12:19:09PM +0800, Pan Xinhui wrote:
> >> Hi, Peter.
> >> 	I think we can avoid a function call in a simpler way. How about below
> >>
> >> static inline bool vcpu_is_preempted(int cpu)
> >> {
> >> 	/* only set in pv case*/
> >> 	if (pv_lock_ops.vcpu_is_preempted)
> >> 		return pv_lock_ops.vcpu_is_preempted(cpu);
> >> 	return false;
> >> }
> > 
> > That is still more expensive. It needs to do an actual load and makes it
> > hard to predict the branch, you'd have to actually wait for the load to
> > complete etc.
> 
> Out of curiosity, why is that hard to predict?
> On s390 the branch prediction runs asynchronously ahead of the downstream
> pipeline (e.g. search for "IBM z Systems Processor Optimization Primer" page 11).
> given enough capacity, I would assume that modern x86 processors would do the same
> and be able to predict this is as soon as it becomes hot (and otherwise you would
>  not notice the branch miss anyway). Is x86 behaving differently here?

Not sure how exactly it works, but it seems to me that an immediate
assignment to the value you're going to compare would leave very little
doubt.

Then again, maybe cores aren't that smart and only look at the
hysterical btb for prediction.

> > Also, it generates more code.
> > 
> > Paravirt muck should strive to be as cheap as possible when ran on
> > native hardware.
> 
> As I am interested in this series from the s390 point of view, this is 
> the only thing that block this series?

Ingo was rewriting the changelog, other than that, no, I can do this on
top. Just spotted this because Ingo and me talked it over.

> Is there a chance to add a static key around the paravirt ops somehow?

More code generation still, replacing the call with an immediate
assignment to the return register is the shortest possible option I
think.
