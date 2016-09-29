From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 0/4] implement vcpu preempted check
Date: Thu, 29 Sep 2016 12:31:33 +0200
Message-ID: <20160929103133.GW5016@twins.programming.kicks-ass.net>
References: <1469101514-49475-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<20160929101040.GV5016@twins.programming.kicks-ass.net>
	<166f3bad-f700-4624-6c1c-996f90ad609c@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <166f3bad-f700-4624-6c1c-996f90ad609c@de.ibm.com>
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
Cc: kernellwp@gmail.com, linux-s390@vger.kernel.org, benh@kernel.crashing.org, jgross@suse.com, kvm@vger.kernel.org, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, will.deacon@arm.com, linux-kernel@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, virtualization@lists.linux-foundation.org, mingo@redhat.com, paulus@samba.org, mpe@ellerman.id.au, xen-devel-request@lists.xenproject.org, pbonzini@redhat.com, paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Sep 29, 2016 at 12:23:19PM +0200, Christian Borntraeger wrote:
> On 09/29/2016 12:10 PM, Peter Zijlstra wrote:
> > On Thu, Jul 21, 2016 at 07:45:10AM -0400, Pan Xinhui wrote:
> >> change from v2:
> >> 	no code change, fix typos, update some comments
> >>
> >> change from v1:
> >> 	a simplier definition of default vcpu_is_preempted
> >> 	skip mahcine type check on ppc, and add config. remove dedicated macro.
> >> 	add one patch to drop overload of rwsem_spin_on_owner and mutex_spin_on_owner. 
> >> 	add more comments
> >> 	thanks boqun and Peter's suggestion.
> >>
> >> This patch set aims to fix lock holder preemption issues.
> > 
> > So I really like the concept, but I would also really like to see
> > support for more hypervisors included before we can move forward with
> > this.
> > 
> > Please consider s390 and (x86/arm) KVM. Once we have a few, more can
> > follow later, but I think its important to not only have PPC support for
> > this.
> 
> Actually the s390 preemted check via sigp sense running  is available for
> all hypervisors (z/VM, LPAR and KVM) which implies everywhere as you can no
> longer buy s390 systems without LPAR.
> 
> As Heiko already pointed out we could simply use a small inline function
> that calls cpu_is_preempted from arch/s390/lib/spinlock (or smp_vcpu_scheduled from smp.c)

Sure, and I had vague memories of Heiko's email. This patch set however
completely fails to do that trivial hooking up.
