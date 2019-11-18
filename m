Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46670 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726575AbfKRIgM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 18 Nov 2019 03:36:12 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAI8W45G016326
        for <linux-s390@vger.kernel.org>; Mon, 18 Nov 2019 03:36:11 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wadmvaf3b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 18 Nov 2019 03:36:11 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 18 Nov 2019 08:36:08 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 4/5] KVM: s390: count invalid yields
Date: Mon, 18 Nov 2019 09:36:01 +0100
In-Reply-To: <20191118083602.15835-1-borntraeger@de.ibm.com>
References: <20191118083602.15835-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20191118083602.15835-5-borntraeger@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>

To analyze some performance issues with lock contention and scheduling
it is nice to know when diag9c did not result in any action or when
no action was tried.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 arch/s390/include/asm/kvm_host.h |  1 +
 arch/s390/kvm/diag.c             | 18 ++++++++++++++----
 arch/s390/kvm/kvm-s390.c         |  1 +
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index abe60268335d..02f4c21c57f6 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -392,6 +392,7 @@ struct kvm_vcpu_stat {
 	u64 diagnose_10;
 	u64 diagnose_44;
 	u64 diagnose_9c;
+	u64 diagnose_9c_ignored;
 	u64 diagnose_258;
 	u64 diagnose_308;
 	u64 diagnose_500;
diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index 45634b3d2e0a..609c55df3ce8 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -158,14 +158,24 @@ static int __diag_time_slice_end_directed(struct kvm_vcpu *vcpu)
 
 	tid = vcpu->run->s.regs.gprs[(vcpu->arch.sie_block->ipa & 0xf0) >> 4];
 	vcpu->stat.diagnose_9c++;
-	VCPU_EVENT(vcpu, 5, "diag time slice end directed to %d", tid);
 
+	/* yield to self */
 	if (tid == vcpu->vcpu_id)
-		return 0;
+		goto no_yield;
 
+	/* yield to invalid */
 	tcpu = kvm_get_vcpu_by_id(vcpu->kvm, tid);
-	if (tcpu)
-		kvm_vcpu_yield_to(tcpu);
+	if (!tcpu)
+		goto no_yield;
+
+	if (kvm_vcpu_yield_to(tcpu) <= 0)
+		goto no_yield;
+
+	VCPU_EVENT(vcpu, 5, "diag time slice end directed to %d: done", tid);
+	return 0;
+no_yield:
+	VCPU_EVENT(vcpu, 5, "diag time slice end directed to %d: ignored", tid);
+	vcpu->stat.diagnose_9c_ignored++;
 	return 0;
 }
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 40af442b2e15..3b5ebf48f802 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -155,6 +155,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ "instruction_diag_10", VCPU_STAT(diagnose_10) },
 	{ "instruction_diag_44", VCPU_STAT(diagnose_44) },
 	{ "instruction_diag_9c", VCPU_STAT(diagnose_9c) },
+	{ "diag_9c_ignored", VCPU_STAT(diagnose_9c_ignored) },
 	{ "instruction_diag_258", VCPU_STAT(diagnose_258) },
 	{ "instruction_diag_308", VCPU_STAT(diagnose_308) },
 	{ "instruction_diag_500", VCPU_STAT(diagnose_500) },
-- 
2.21.0
