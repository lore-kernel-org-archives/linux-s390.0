Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4954 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727041AbfJJLF0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Oct 2019 07:05:26 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9AACevg041909
        for <linux-s390@vger.kernel.org>; Thu, 10 Oct 2019 07:05:24 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vj2pmsj4y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 10 Oct 2019 07:05:24 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Thu, 10 Oct 2019 12:05:22 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v2 1/2] KVM: s390: count invalid yields
Date: Thu, 10 Oct 2019 13:05:17 +0200
In-Reply-To: <20191010110518.129256-1-borntraeger@de.ibm.com>
References: <20191010110518.129256-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20191010110518.129256-2-borntraeger@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>

To analyze some performance issues with lock contention and scheduling
it is nice to know when diag9c did not result in any action or when
no action was tried.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
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
index 4a3bc40ca1a4..d9e6bf3d54f0 100644
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
