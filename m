From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 2/2] KVM: s390: diagnoses are instructions as well
Date: Wed, 24 Jan 2018 12:32:35 +0100
Message-ID: <20180124113235.31485-3-borntraeger@de.ibm.com>
References: <20180124113235.31485-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180124113235.31485-1-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

make the diagnose counters also appear as instruction counters.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 3abe177..1f30087 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -132,12 +132,12 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ "instruction_sigp_cpu_reset", VCPU_STAT(instruction_sigp_cpu_reset) },
 	{ "instruction_sigp_init_cpu_reset", VCPU_STAT(instruction_sigp_init_cpu_reset) },
 	{ "instruction_sigp_unknown", VCPU_STAT(instruction_sigp_unknown) },
-	{ "diagnose_10", VCPU_STAT(diagnose_10) },
-	{ "diagnose_44", VCPU_STAT(diagnose_44) },
-	{ "diagnose_9c", VCPU_STAT(diagnose_9c) },
-	{ "diagnose_258", VCPU_STAT(diagnose_258) },
-	{ "diagnose_308", VCPU_STAT(diagnose_308) },
-	{ "diagnose_500", VCPU_STAT(diagnose_500) },
+	{ "instruction_diag_10", VCPU_STAT(diagnose_10) },
+	{ "instruction_diag_44", VCPU_STAT(diagnose_44) },
+	{ "instruction_diag_9c", VCPU_STAT(diagnose_9c) },
+	{ "instruction_diag_258", VCPU_STAT(diagnose_258) },
+	{ "instruction_diag_308", VCPU_STAT(diagnose_308) },
+	{ "instruction_diag_500", VCPU_STAT(diagnose_500) },
 	{ NULL }
 };
 
-- 
2.9.4
