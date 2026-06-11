Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD6D32B109;
	Thu, 11 Jun 2026 15:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781193299; cv=none; b=ZliD4DK0+5a+jaG+dnYPdKzYqQfOeaE0/LOu5DvngsDNyIapXJRaSxE3085qKWqJm+xY4WWLrXYthvbQilU8Tw2xK2srtA0Dt3ip+SGvvkdz5/0wqIlRUTx9jELVRw5IPL7BKb+5SEcGPrd913aX9zRRYzzT3LCYjOKfg7l/DZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781193299; c=relaxed/simple;
	bh=Mq6nFhJPyjrc67PHpXk9Dl6vX3gsEgmGVNtPL2nA9FY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yk8h7dW0D+62a8VJxTvdGenEhMhETzUhB2if6JJ3GXxRvkln+Fc1k/WCkPjPvLZQnPvDa6hjXICsWBTri7XiDun0P0xBJiwozQWN1z4s5/FBHB4R21D/iEp/XBATPvn3LLLPlYZN2HuwFEILBUC0Ct1Cm1hI6RNnP/fYARQ0TTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hEOHGtEt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hEOHGtEt"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BBtBsZ677703;
	Thu, 11 Jun 2026 15:54:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hQ1Fqm
	2/fzJJ/sfAjwl2uIJKBr88BRDQ33gwivK8ojE=; b=hEOHGtEtWs2Fc5oR3mMNPx
	8RxXiA0HAw06G6qV/YLDhf2moBpR+xth3UNHgoyy765kQ1HOfLIBI3Nyr9htmIO+
	uSPnzbSF5m2XRMipNgbODOIjOUcw5BI4lNcRGoWY8+525ISHH4Bfw4yAX0gxlyY3
	Dv849oDjQZ3EXji+AymKFx1havq4c1rW5KvhDVBmTu7kuPFb9inNN9lOurEfyZZ8
	4PcCZoQGBplqzLaKS1MIRsHTpxmyfXWcxNVxnhUdocMcM/Poww4rjHsLpyUkQL3b
	q66vFYQueQGhkwLulIBYrq5LCOmmqT7pwUhRo12Ve10VUMuLSs4Tglc4pgmhLtvA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8amjab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 15:54:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65BFnfUG021021;
	Thu, 11 Jun 2026 15:54:55 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe09kuyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 15:54:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65BFsqW426673450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 15:54:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40D8E20043;
	Thu, 11 Jun 2026 15:54:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB63C20040;
	Thu, 11 Jun 2026 15:54:51 +0000 (GMT)
Received: from [192.168.88.52] (unknown [9.87.150.222])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jun 2026 15:54:51 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Thu, 11 Jun 2026 17:54:33 +0200
Subject: [PATCH v3 3/4] KVM: s390: vsie: Refactor handle_stfle
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-vsie-alter-stfle-fac-v3-3-b1a35efedaba@linux.ibm.com>
References: <20260611-vsie-alter-stfle-fac-v3-0-b1a35efedaba@linux.ibm.com>
In-Reply-To: <20260611-vsie-alter-stfle-fac-v3-0-b1a35efedaba@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>, kvm@vger.kernel.org,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4047;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=kv8LvXigEiKNEzIUmdnfEmexbf8Ni4wSjNqzaYeJyqQ=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFlatzzTpxrGLl7VkicWdT5ZeN7sZYr2Em3m377s/nNq1
 sUOky6PjlIWBjEuBlkxRZZqceu8qr7WpXMOWl6DmcPKBDKEgYtTACaycD3Df790v9MTvwVP71KW
 OC9YcLrmpNPq/YtPmt14ZPGiW+GW7nFGhueHNzOf6Ji6/e5yIwOx9VGvqlqkr5eUsOd8s27u+Gd
 kzgwA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DMBIR1mTqPPL3s8yhZ6LB0JV7XHE3nsR
X-Authority-Analysis: v=2.4 cv=TdKmcxQh c=1 sm=1 tr=0 ts=6a2ada50 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=QF4Ne7cRFios67fmdukA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE1NyBTYWx0ZWRfX8B3fKncBfsFN
 qRDV+HL0ktKcb6zy+2ZK/qpoP619RRx1U5Xf6yXhBSOjtO42WKSayjlAqUPe0AZVagC6UaSQI6g
 Baaomuuy4svTbzkyW5Fhq/ONEZtsOEoR+au3jQ7OD2iqb+jt30TYXHe+g5oWCqFZMckBIn5zTZ4
 MyPRPp5Pgmn2IEUdd02TPoP27BG6QlnqThn6FflicpjM8ZLKruXUZIUfjk7QPJH6ZzNtfcWAeUb
 uLTBmgpUYqCvcFr+hoN5aXK23WZTcuK357I5+JDh1RaI0M4bd1FYIUsm9Lm8khx7op7qXuankRd
 7NMpt9YxUIuHDZcOnGr9UCgztqNkNkbmkajGh6Et7dOUlXr1iALqVrE4DldIe+gy5N/li3HqRAH
 gaWlkPHL+cVQRN95ATLxfZOEmmuEQ4s4Gl4CJHDagc8r2WClOF6J80zjSDwIntfHCQLudgvLA8n
 5SgEHaGRr9llzUkNGmg==
X-Proofpoint-GUID: DMBIR1mTqPPL3s8yhZ6LB0JV7XHE3nsR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE1NyBTYWx0ZWRfXzk7btkyW+Ro9
 emWC3k22DKovb2GFsC4FlLYWJfEyksCIXC78/vi0CZjARJVeUOUh8oSpPagDrVWZTy/MraDPe7P
 abaRWrdu5a/AifmGtGnmrhfUanVK61k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_03,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110157

From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

Use switch case in anticipation of handling format-1 and format-2
facility list designations in the future.
As the alternate STFLE facilities are not enabled, only case 0 is
possible.
No functional change intended.

Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Co-developed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/include/uapi/asm/kvm.h |  1 +
 arch/s390/kvm/vsie.c             | 53 ++++++++++++++++++++++++++++------------
 2 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index 60345dd2cba2..4192769b5ce0 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -444,6 +444,7 @@ struct kvm_s390_vm_cpu_machine {
 #define KVM_S390_VM_CPU_FEAT_PFMFI	11
 #define KVM_S390_VM_CPU_FEAT_SIGPIF	12
 #define KVM_S390_VM_CPU_FEAT_KSS	13
+#define KVM_S390_VM_CPU_FEAT_ASTFLEIE2	14
 struct kvm_s390_vm_cpu_feat {
 	__u64 feat[16];
 };
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index e5a23f1c9749..c7dcdd460dd1 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -6,12 +6,15 @@
  *
  *    Author(s): David Hildenbrand <dahi@linux.vnet.ibm.com>
  */
+#include <linux/align.h>
 #include <linux/vmalloc.h>
 #include <linux/kvm_host.h>
 #include <linux/bug.h>
+#include <linux/compiler.h>
 #include <linux/list.h>
 #include <linux/bitmap.h>
 #include <linux/sched/signal.h>
+#include <linux/stddef.h>
 #include <linux/io.h>
 #include <linux/mman.h>
 
@@ -1000,6 +1003,23 @@ static void retry_vsie_icpt(struct vsie_page *vsie_page)
 	clear_vsie_icpt(vsie_page);
 }
 
+static int handle_stfle_0(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
+			  u32 fac_list_origin)
+{
+	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
+
+	/*
+	 * format-0 -> size of nested guest's facility list == guest's size
+	 * guest's size == host's size, since STFLE is interpretatively executed
+	 * using a format-0 for the guest, too.
+	 */
+	if (read_guest_real(vcpu, fac_list_origin, &vsie_page->fac,
+			    stfle_size() * sizeof(u64)))
+		return set_validity_icpt(scb_s, 0x1090U);
+	scb_s->fac = (u32)virt_to_phys(&vsie_page->fac);
+	return 0;
+}
+
 /*
  * Try to shadow + enable the guest 2 provided facility list.
  * Retry instruction execution if enabled for and provided by guest 2.
@@ -1009,29 +1029,30 @@ static void retry_vsie_icpt(struct vsie_page *vsie_page)
  */
 static int handle_stfle(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 {
-	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
-	__u32 fac = READ_ONCE(vsie_page->scb_o->fac);
+	bool has_astfleie2 = test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_ASTFLEIE2);
+	u32 fac = READ_ONCE(vsie_page->scb_o->fac);
+	int format_mask, format;
+	u32 origin;
+
+	BUILD_BUG_ON(!IS_ALIGNED(offsetof(struct vsie_page, fac), 8));
 
-	/*
-	 * Alternate-STFLE-Interpretive-Execution facilities are not supported
-	 * -> format-0 flcb
-	 */
 	if (fac && test_kvm_facility(vcpu->kvm, 7)) {
 		retry_vsie_icpt(vsie_page);
 		/*
 		 * The facility list origin (FLO) is in bits 1 - 28 of the FLD
 		 * so we need to mask here before reading.
 		 */
-		fac = fac & 0x7ffffff8U;
-		/*
-		 * format-0 -> size of nested guest's facility list == guest's size
-		 * guest's size == host's size, since STFLE is interpretatively executed
-		 * using a format-0 for the guest, too.
-		 */
-		if (read_guest_real(vcpu, fac, &vsie_page->fac,
-				    stfle_size() * sizeof(u64)))
-			return set_validity_icpt(scb_s, 0x1090U);
-		scb_s->fac = (u32)virt_to_phys(&vsie_page->fac);
+		origin = fac & 0x7ffffff8U;
+		format_mask = has_astfleie2 ? 3 : 0;
+		format = fac & format_mask;
+		switch (format) {
+		case 0:
+			return handle_stfle_0(vcpu, vsie_page, origin);
+		case 1:
+		case 2:
+		case 3:
+			unreachable();
+		}
 	}
 	return 0;
 }

-- 
2.54.0

