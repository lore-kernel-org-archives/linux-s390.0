From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v7 06/11] x86, paravirt: Add interface to support kvm/xen
	vcpu preempted check
Date: Wed, 16 Nov 2016 11:23:55 +0100
Message-ID: <20161116102355.GP3142@twins.programming.kicks-ass.net>
References: <1478077718-37424-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<1478077718-37424-7-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<20161115154706.GF11311@worktop.programming.kicks-ass.net>
	<a6026a0c-9ad8-5025-c616-eb33f96e91ce@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <a6026a0c-9ad8-5025-c616-eb33f96e91ce@linux.vnet.ibm.com>
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
To: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, rkrcmar@redhat.com, benh@kernel.crashing.org, will.deacon@arm.com, virtualization@lists.linux-foundation.org, paulus@samba.org, kernellwp@gmail.com, linux-s390@vger.kernel.org, dave@stgolabs.net, mpe@ellerman.id.au, x86@kernel.org, mingo@redhat.com, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, xen-devel@lists.xenproject.org, paulmck@linux.vnet.ibm.com, konrad.wilk@oracle.com, boqun.feng@gmail.com, jgross@suse.com, linux-kernel@vger.kernel.org, David.Laight@ACULAB.COM, xen-devel-request@lists.xenproject.org, pbonzini@redhat.com, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Nov 16, 2016 at 12:19:09PM +0800, Pan Xinhui wrote:
> Hi, Peter.
> 	I think we can avoid a function call in a simpler way. How about below
> 
> static inline bool vcpu_is_preempted(int cpu)
> {
> 	/* only set in pv case*/
> 	if (pv_lock_ops.vcpu_is_preempted)
> 		return pv_lock_ops.vcpu_is_preempted(cpu);
> 	return false;
> }

That is still more expensive. It needs to do an actual load and makes it
hard to predict the branch, you'd have to actually wait for the load to
complete etc.

Also, it generates more code.

Paravirt muck should strive to be as cheap as possible when ran on
native hardware.
