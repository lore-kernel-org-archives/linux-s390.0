Return-Path: <peterz@infradead.org>
Date: Thu, 7 Jul 2016 11:42:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 0/4] implement vcpu preempted check
Message-ID: <20160707094215.GT30921@twins.programming.kicks-ass.net>
References: <1467124991-13164-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20160706065255.GH30909@twins.programming.kicks-ass.net>
 <14a24854-9787-e4a1-c9a8-76eba4e97301@redhat.com>
 <CANRm+CwXLsNrC59g6tZk=U+T0Scn_O=b60NPESJXU6uaP7-AsA@mail.gmail.com>
 <8e8edf1b-b64b-3c44-b580-b9271663844c@redhat.com>
 <CANRm+Cz1Ncxm7g0ophT+ijUmqnmTq9VwCZau3wMS56Vkm2+7fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CANRm+Cz1Ncxm7g0ophT+ijUmqnmTq9VwCZau3wMS56Vkm2+7fQ@mail.gmail.com>
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

On Thu, Jul 07, 2016 at 04:48:05PM +0800, Wanpeng Li wrote:
> 2016-07-06 20:28 GMT+08:00 Paolo Bonzini <pbonzini@redhat.com>:
> > Hmm, you're right.  We can use bit 0 of struct kvm_steal_time's flags to
> > indicate that pad[0] is a "VCPU preempted" field; if pad[0] is 1, the
> > VCPU has been scheduled out since the last time the guest reset the bit.
> >  The guest can use an xchg to test-and-clear it.  The bit can be
> > accessed at any time, independent of the version field.
> 
> If one vCPU is preempted, and guest check it several times before this
> vCPU is scheded in, then the first time we can get "vCPU is
> preempted", however, since the field is cleared, the second time we
> will get "vCPU is running".
> 
> Do you mean we should call record_steal_time() in both kvm_sched_in()
> and kvm_sched_out() to record this field? Btw, if we should keep both
> vcpu->preempted and kvm_steal_time's "vCPU preempted" field present
> simultaneous?

I suspect you want something like so; except this has holes in.

We clear KVM_ST_PAD_PREEMPT before disabling preemption and we set it
after enabling it, this means that if we get preempted in between, the
vcpu is reported as running even though it very much is not.

Fixing that requires much larger surgery.

---
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b2766723c951..117270df43b6 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1997,8 +1997,29 @@ static void kvmclock_reset(struct kvm_vcpu *vcpu)
 	vcpu->arch.pv_time_enabled = false;
 }
 
+static void update_steal_time_preempt(struct kvm_vcpu *vcpu)
+{
+	struct kvm_steal_time *st;
+
+	if (!(vcpu->arch.st.msr_val & KVM_MSR_ENABLED))
+		return;
+
+	if (unlikely(kvm_read_guest_cached(vcpu->kvm, &vcpu->arch.st.stime,
+		&vcpu->arch.st.steal, sizeof(struct kvm_steal_time))))
+		return;
+
+	st = &vcpu->arch.st.steal;
+
+	st->pad[KVM_ST_PAD_PREEMPT] = 1; /* we've stopped running */
+
+	kvm_write_guest_cached(vcpu->kvm, &vcpu->arch.st.stime,
+		st, sizeof(struct kvm_steal_time));
+}
+
 static void record_steal_time(struct kvm_vcpu *vcpu)
 {
+	struct kvm_steal_time *st;
+
 	if (!(vcpu->arch.st.msr_val & KVM_MSR_ENABLED))
 		return;
 
@@ -2006,29 +2027,34 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
 		&vcpu->arch.st.steal, sizeof(struct kvm_steal_time))))
 		return;
 
-	if (vcpu->arch.st.steal.version & 1)
-		vcpu->arch.st.steal.version += 1;  /* first time write, random junk */
+	st = &vcpu->arch.st.steal;
+
+	if (st->version & 1) {
+		st->flags = KVM_ST_FLAG_PREEMPT;
+		st->version += 1;  /* first time write, random junk */
+	}
 
-	vcpu->arch.st.steal.version += 1;
+	st->version += 1;
 
 	kvm_write_guest_cached(vcpu->kvm, &vcpu->arch.st.stime,
-		&vcpu->arch.st.steal, sizeof(struct kvm_steal_time));
+		st, sizeof(struct kvm_steal_time));
 
 	smp_wmb();
 
-	vcpu->arch.st.steal.steal += current->sched_info.run_delay -
+	st->steal += current->sched_info.run_delay -
 		vcpu->arch.st.last_steal;
 	vcpu->arch.st.last_steal = current->sched_info.run_delay;
+	st->pad[KVM_ST_PAD_PREEMPT] = 0; /* we're about to start running */
 
 	kvm_write_guest_cached(vcpu->kvm, &vcpu->arch.st.stime,
-		&vcpu->arch.st.steal, sizeof(struct kvm_steal_time));
+		st, sizeof(struct kvm_steal_time));
 
 	smp_wmb();
 
-	vcpu->arch.st.steal.version += 1;
+	st->version += 1;
 
 	kvm_write_guest_cached(vcpu->kvm, &vcpu->arch.st.stime,
-		&vcpu->arch.st.steal, sizeof(struct kvm_steal_time));
+		st, sizeof(struct kvm_steal_time));
 }
 
 int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
@@ -6693,6 +6719,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 
 	preempt_enable();
 
+	update_steal_time_preempt(vcpu);
+
 	vcpu->srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
 
 	/*
