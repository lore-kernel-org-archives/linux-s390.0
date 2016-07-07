Return-Path: <peterz@infradead.org>
Date: Thu, 7 Jul 2016 13:21:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 0/4] implement vcpu preempted check
Message-ID: <20160707112121.GJ30927@twins.programming.kicks-ass.net>
References: <1467124991-13164-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20160706065255.GH30909@twins.programming.kicks-ass.net>
 <14a24854-9787-e4a1-c9a8-76eba4e97301@redhat.com>
 <CANRm+CwXLsNrC59g6tZk=U+T0Scn_O=b60NPESJXU6uaP7-AsA@mail.gmail.com>
 <8e8edf1b-b64b-3c44-b580-b9271663844c@redhat.com>
 <CANRm+Cz1Ncxm7g0ophT+ijUmqnmTq9VwCZau3wMS56Vkm2+7fQ@mail.gmail.com>
 <20160707094215.GT30921@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160707094215.GT30921@twins.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, mpe@ellerman.id.au, boqun.feng@gmail.com, will.deacon@arm.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Waiman Long <waiman.long@hpe.com>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, benh@kernel.crashing.org, schwidefsky@de.ibm.com, Paul McKenney <paulmck@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, kvm <kvm@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jul 07, 2016 at 11:42:15AM +0200, Peter Zijlstra wrote:
> +static void update_steal_time_preempt(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_steal_time *st;
> +
> +	if (!(vcpu->arch.st.msr_val & KVM_MSR_ENABLED))
> +		return;
> +
> +	if (unlikely(kvm_read_guest_cached(vcpu->kvm, &vcpu->arch.st.stime,
> +		&vcpu->arch.st.steal, sizeof(struct kvm_steal_time))))
> +		return;
> +
> +	st = &vcpu->arch.st.steal;
> +
> +	st->pad[KVM_ST_PAD_PREEMPT] = 1; /* we've stopped running */

So maybe have this be:

	... = kvm_vcpu_running();

That avoids marking the vcpu preempted when we do hlt and such.

> +	kvm_write_guest_cached(vcpu->kvm, &vcpu->arch.st.stime,
> +		st, sizeof(struct kvm_steal_time));
> +}
