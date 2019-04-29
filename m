Return-Path: <SRS0=+MMY=S7=vger.kernel.org=kvm-owner@kernel.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 10/12] KVM: s390: provide kvm_arch_no_poll function
Date: Mon, 29 Apr 2019 11:10:00 +0200
In-Reply-To: <20190429091002.71164-1-borntraeger@de.ibm.com>
References: <20190429091002.71164-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190429091002.71164-11-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

We do track the current steal time of the host CPUs. Let us use
this value to disable halt polling if the steal time goes beyond
a configured value.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  1 +
 arch/s390/kvm/Kconfig            |  1 +
 arch/s390/kvm/kvm-s390.c         | 17 +++++++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index e224246ff93c..bdbc81b5bc91 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -313,6 +313,7 @@ struct kvm_vcpu_stat {
 	u64 halt_successful_poll;
 	u64 halt_attempted_poll;
 	u64 halt_poll_invalid;
+	u64 halt_no_poll_steal;
 	u64 halt_wakeup;
 	u64 instruction_lctl;
 	u64 instruction_lctlg;
diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
index 767453faacfc..e987e73738b5 100644
--- a/arch/s390/kvm/Kconfig
+++ b/arch/s390/kvm/Kconfig
@@ -31,6 +31,7 @@ config KVM
 	select HAVE_KVM_IRQFD
 	select HAVE_KVM_IRQ_ROUTING
 	select HAVE_KVM_INVALID_WAKEUPS
+	select HAVE_KVM_NO_POLL
 	select SRCU
 	select KVM_VFIO
 	---help---
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index eb68ada1334b..ed280a4fea07 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -75,6 +75,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ "halt_successful_poll", VCPU_STAT(halt_successful_poll) },
 	{ "halt_attempted_poll", VCPU_STAT(halt_attempted_poll) },
 	{ "halt_poll_invalid", VCPU_STAT(halt_poll_invalid) },
+	{ "halt_no_poll_steal", VCPU_STAT(halt_no_poll_steal) },
 	{ "halt_wakeup", VCPU_STAT(halt_wakeup) },
 	{ "instruction_lctlg", VCPU_STAT(instruction_lctlg) },
 	{ "instruction_lctl", VCPU_STAT(instruction_lctl) },
@@ -177,6 +178,11 @@ static int hpage;
 module_param(hpage, int, 0444);
 MODULE_PARM_DESC(hpage, "1m huge page backing support");
 
+/* maximum percentage of steal time for polling.  >100 is treated like 100 */
+static u8 halt_poll_max_steal = 10;
+module_param(halt_poll_max_steal, byte, 0644);
+MODULE_PARM_DESC(hpage, "Maximum percentage of steal time to allow polling");
+
 /*
  * For now we handle at most 16 double words as this is what the s390 base
  * kernel handles and stores in the prefix page. If we ever need to go beyond
@@ -3166,6 +3172,17 @@ static void kvm_gmap_notifier(struct gmap *gmap, unsigned long start,
 	}
 }
 
+bool kvm_arch_no_poll(struct kvm_vcpu *vcpu)
+{
+	/* do not poll with more than halt_poll_max_steal percent of steal time */
+	if (S390_lowcore.avg_steal_timer * 100 / (TICK_USEC << 12) >=
+	    halt_poll_max_steal) {
+		vcpu->stat.halt_no_poll_steal++;
+		return true;
+	}
+	return false;
+}
+
 int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
 {
 	/* kvm common code refers to this, but never calls it */
-- 
2.19.1
