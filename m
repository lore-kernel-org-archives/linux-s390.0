From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v6 08/11] x86, kvm/x86.c: support vcpu preempted check
Date: Fri, 28 Oct 2016 04:11:24 -0400
Message-ID: <1477642287-24104-9-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1477642287-24104-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1477642287-24104-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org, xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, mingo@redhat.com, peterz@infradead.org, paulmck@linux.vnet.ibm.com, will.deacon@arm.com, kernellwp@gmail.com, jgross@suse.com, pbonzini@redhat.com, bsingharora@gmail.com, boqun.feng@gmail.com, borntraeger@de.ibm.com, rkrcmar@redhat.com, David.Laight@ACULAB.COM, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Support the vcpu_is_preempted() functionality under KVM. This will
enhance lock performance on overcommitted hosts (more runnable vcpus
than physical cpus in the system) as doing busy waits for preempted
vcpus will hurt system performance far worse than early yielding.

Use one field of struct kvm_steal_time ::preempted to indicate that if
one vcpu is running or not.

Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 arch/x86/include/uapi/asm/kvm_para.h |  4 +++-
 arch/x86/kvm/x86.c                   | 16 ++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
index 94dc8ca..1421a65 100644
--- a/arch/x86/include/uapi/asm/kvm_para.h
+++ b/arch/x86/include/uapi/asm/kvm_para.h
@@ -45,7 +45,9 @@ struct kvm_steal_time {
 	__u64 steal;
 	__u32 version;
 	__u32 flags;
-	__u32 pad[12];
+	__u8  preempted;
+	__u8  u8_pad[3];
+	__u32 pad[11];
 };
 
 #define KVM_STEAL_ALIGNMENT_BITS 5
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e375235..f06e115 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2057,6 +2057,8 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
 		&vcpu->arch.st.steal, sizeof(struct kvm_steal_time))))
 		return;
 
+	vcpu->arch.st.steal.preempted = 0;
+
 	if (vcpu->arch.st.steal.version & 1)
 		vcpu->arch.st.steal.version += 1;  /* first time write, random junk */
 
@@ -2810,8 +2812,22 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	kvm_make_request(KVM_REQ_STEAL_UPDATE, vcpu);
 }
 
+static void kvm_steal_time_set_preempted(struct kvm_vcpu *vcpu)
+{
+	if (!(vcpu->arch.st.msr_val & KVM_MSR_ENABLED))
+		return;
+
+	vcpu->arch.st.steal.preempted = 1;
+
+	kvm_write_guest_offset_cached(vcpu->kvm, &vcpu->arch.st.stime,
+			&vcpu->arch.st.steal.preempted,
+			offsetof(struct kvm_steal_time, preempted),
+			sizeof(vcpu->arch.st.steal.preempted));
+}
+
 void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 {
+	kvm_steal_time_set_preempted(vcpu);
 	kvm_x86_ops->vcpu_put(vcpu);
 	kvm_put_guest_fpu(vcpu);
 	vcpu->arch.last_host_tsc = rdtsc();
-- 
2.4.11
