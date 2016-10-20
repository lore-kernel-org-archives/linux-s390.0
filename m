From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v5 9/9] Documentation: virtual: kvm: Support vcpu preempted check
Date: Thu, 20 Oct 2016 17:27:54 -0400
Message-ID: <1476998874-2089-10-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1476998874-2089-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476998874-2089-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org, xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, mingo@redhat.com, peterz@infradead.org, paulmck@linux.vnet.ibm.com, will.deacon@arm.com, kernellwp@gmail.com, jgross@suse.com, pbonzini@redhat.com, bsingharora@gmail.com, boqun.feng@gmail.com, borntraeger@de.ibm.com, rkrcmar@redhat.com, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Commit ("x86, kvm: support vcpu preempted check") add one field "__u8
preempted" into struct kvm_steal_time. This field tells if one vcpu is
running or not.

It is zero if 1) some old KVM deos not support this filed. 2) the vcpu is
preempted. Other values means the vcpu has been preempted.

Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 Documentation/virtual/kvm/msr.txt | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/virtual/kvm/msr.txt b/Documentation/virtual/kvm/msr.txt
index 2a71c8f..3376f13 100644
--- a/Documentation/virtual/kvm/msr.txt
+++ b/Documentation/virtual/kvm/msr.txt
@@ -208,7 +208,8 @@ MSR_KVM_STEAL_TIME: 0x4b564d03
 		__u64 steal;
 		__u32 version;
 		__u32 flags;
-		__u32 pad[12];
+		__u8  preempted;
+		__u32 pad[11];
 	}
 
 	whose data will be filled in by the hypervisor periodically. Only one
@@ -232,6 +233,11 @@ MSR_KVM_STEAL_TIME: 0x4b564d03
 		nanoseconds. Time during which the vcpu is idle, will not be
 		reported as steal time.
 
+		preempted: indicate the VCPU who owns this struct is running or
+		not. Non-zero values mean the VCPU has been preempted. Zero
+		means the VCPU is not preempted. NOTE, it is always zero if the
+		the hypervisor doesn't support this field.
+
 MSR_KVM_EOI_EN: 0x4b564d04
 	data: Bit 0 is 1 when PV end of interrupt is enabled on the vcpu; 0
 	when disabled.  Bit 1 is reserved and must be zero.  When PV end of
-- 
2.4.11
