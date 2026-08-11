Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69F14457BE;
	Tue, 11 Aug 2026 13:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786455427; cv=none; b=SL/ZhtAvfBIhnq/Sa1QtgIBoYe7pQ4xBrgr8GppMVyMchExLOS65n08OEqvKbC8cV8zB/zE0VoxyfLhDeEfdTizbi105Cfftk7LRulFgG/alYZJqfB8078yNlLUg9KBtvW0OWipF/GXyngs/VQwDTYNSSYFAVp/YQEpyGOnCw4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786455427; c=relaxed/simple;
	bh=31YL75zx+TozzXJZNTdMOkHVUoy5KeS8lLFpPxmXoZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f3xbZeWqgnPQCIPPnO3PYxbTydUNfZ+7oMRpcGTwnwmkKJMnKo7wNj5kfzKdcgjDYHH/T0jvhTGAXeH3avv7IjLAJVDa1vlhxe8vzv5Cb1BQzyDryizc22qVvvsWZKKxqygLKU5npFuM+ieiXctJGE45rO56NKO25gr4zUMJbZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fvQLcWLJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fvQLcWLJ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDXRTs570326;
	Tue, 11 Aug 2026 13:36:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Wtb7UQ
	lK8jz0Vnp9ab7cxrJsZ2rILrrtININVF0Lkwc=; b=fvQLcWLJOQK1QDHfXW4JbO
	IIHGJZxJNUiSHKR8zexp2BGeahZ6fkd515FF/i4UuUawRb2PqPn9eKYnSit+q66y
	1Lsw7L8Xe4XPkkJULiGPlzcAej1peQwuPPKJIl/5FfCJpsEBBzSi/u0bOgxgi0AI
	aDXtJBMMBhCFpwbXhJvkq2w8TJGHYLt5tKxtI9dFQwmyzujDh6oMLBrLz868JXmw
	z/m9omYv1qBOGoj/oxM1F889EqIwdtblFLzqGb6331arWZrFUnHeARlh7mtv9TSN
	PKyqmbIu8KpuuVxCpihqkIHUDw1+dTPqoa6XYE4u5/KHJgU2OzfaioQrwUxmqThA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnw4fs1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:36:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BDQEAJ008254;
	Tue, 11 Aug 2026 13:36:38 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq185q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:36:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BDaYsD35914014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 13:36:34 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87F972004B;
	Tue, 11 Aug 2026 13:36:34 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E68B420043;
	Tue, 11 Aug 2026 13:36:33 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.69.228])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 13:36:33 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Tue, 11 Aug 2026 15:36:24 +0200
Subject: [PATCH v3 09/20] KVM: s390: vsie: Replace radix_tree with xarray
 addr_to_page
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-vsie-sigpi-v3-9-45aa1ab07c7c@linux.ibm.com>
References: <20260811-vsie-sigpi-v3-0-45aa1ab07c7c@linux.ibm.com>
In-Reply-To: <20260811-vsie-sigpi-v3-0-45aa1ab07c7c@linux.ibm.com>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Nico Boehr <nrb@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4133;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=31YL75zx+TozzXJZNTdMOkHVUoy5KeS8lLFpPxmXoZo=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFnVqlFbbui/9/h0cpNjOOP89gnx+9cf+rHIZY4Ex+cPR
 zs+lz/x7ihlYRDjYpAVU2SpFrfOq+prXTrnoOU1mDmsTCBDGLg4BWAibgwM/3T/v7RWtWXNEZ8X
 pMapWGPama3pk7tzdbJ1p+syhpgJhxn+mTu9neHrYef4ZtOqX4G7HSz7J9gGdMy1WrDT7Gv44r+
 vmAA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7b2567 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=F8FVqei25e47uhyEDlAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Ja9cu1yLqI-EipBGqklDiRhShFa-ERE1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDExMyBTYWx0ZWRfXxxWXS75dmAEO
 LN82FQU0qJjZMl6q7K+H5XfuaDubrb1zEu+y/Z7fOljv1xwmgvxi6OCNLaRPdbCTUl9jdPhnCtg
 yTodghRvQ313MJVzWse7xtgLXmF3Sv9EuIuxRFgPdXNi7SOSPqKY4/IZcayGaI7XXxYe5slWPeK
 pMviDV5odR7n3NgihzRyHVFQ3aE48c0jf7b2NziVtzW4HXwtLQk0Kb6Lr+gu+Czgu5gkSSu6k61
 w1KGLZrGFqSdGdfudIau9tIJt3/NgwXbPWBEW1wgdkSPcssQOw35FmYapTgROlrUMLsacHNs6kX
 0+scPdrkvn84cSwejJk15/726AMZP+t/jRzEkUNM7HctESXkGCJUKKXkVO3//aWVfqhxeb+Hhdb
 U2BTZSsrxbv/uCbhDDOyx4CP6H9Cvggjall0KfT4H/mBFRMr31jUCu7DxwH4ouXn2kRQvSzP/oH
 QdFbKS4Azv7DA7ZSSzg==
X-Proofpoint-ORIG-GUID: Ja9cu1yLqI-EipBGqklDiRhShFa-ERE1
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDExMyBTYWx0ZWRfX+hB7TPM3Yo94
 2MGOOv80rAxSR+6KnFtt0sVPQP3Fwjk1/V5C6i0nBm9qQ2ANj204zODY2H4GgdWaaOhNHOamGjy
 HVaZgyOGvH+CC/oRhdMlT5/9pCaq+8o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110113

The underlying implementation of radix_tree is xarray since v4.20.
Changing to the xarray API directly relaxes some of the locking
obligations and provides more symmetry with the next vsie changes in
the series.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  2 +-
 arch/s390/kvm/vsie.c             | 40 ++++++++++++++++------------------------
 2 files changed, 17 insertions(+), 25 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 872a9df4372c..1a1df3ff44fa 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -624,7 +624,7 @@ struct vsie_page;
 
 struct kvm_s390_vsie {
 	struct mutex mutex;
-	struct radix_tree_root addr_to_page;
+	struct xarray addr_to_page;
 	int page_count;
 	int next;
 	struct vsie_page *pages[KVM_MAX_VCPUS];
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 20e5fcbe382c..6bde6a3ee850 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -56,8 +56,7 @@ struct vsie_page {
 	gpa_t sdnx_gpa;				/* 0x0250 */
 	/*
 	 * guest address of the original SCB. Remains set for free vsie
-	 * pages, so we can properly look them up in our addr_to_page
-	 * radix tree.
+	 * pages, so we can properly look them up in our addr_to_page map.
 	 */
 	gpa_t scb_gpa;				/* 0x0258 */
 	/* the shadow gmap in use by the vsie_page */
@@ -1532,19 +1531,15 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
 	struct vsie_page *vsie_page;
 	int nr_vcpus;
 
-	rcu_read_lock();
-	vsie_page = radix_tree_lookup(&kvm->arch.vsie.addr_to_page, addr >> SCB_ALIGNMENT_SHIFT);
-	rcu_read_unlock();
-	if (vsie_page) {
-		if (try_get_vsie_page(vsie_page)) {
-			if (vsie_page->scb_gpa == addr)
-				return vsie_page;
-			/*
-			 * We raced with someone reusing + putting this vsie
-			 * page before we grabbed it.
-			 */
-			put_vsie_page(vsie_page);
-		}
+	vsie_page = xa_load(&kvm->arch.vsie.addr_to_page, addr >> SCB_ALIGNMENT_SHIFT);
+	if (vsie_page && try_get_vsie_page(vsie_page)) {
+		if (vsie_page->scb_gpa == addr)
+			return vsie_page;
+		/*
+		 * We raced with someone reusing + putting this vsie
+		 * page before we grabbed it.
+		 */
+		put_vsie_page(vsie_page);
 	}
 
 	/*
@@ -1573,15 +1568,15 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
 			kvm->arch.vsie.next %= nr_vcpus;
 		}
 		if (vsie_page->scb_gpa != ULONG_MAX)
-			radix_tree_delete(&kvm->arch.vsie.addr_to_page,
-					  vsie_page->scb_gpa >> SCB_ALIGNMENT_SHIFT);
+			xa_erase(&kvm->arch.vsie.addr_to_page,
+				 vsie_page->scb_gpa >> SCB_ALIGNMENT_SHIFT);
 		/* Mark it as invalid until it resides in the tree. */
 		vsie_page->scb_gpa = ULONG_MAX;
 	}
 
 	/* Double use of the same address or allocation failure. */
-	if (radix_tree_insert(&kvm->arch.vsie.addr_to_page, addr >> SCB_ALIGNMENT_SHIFT,
-			      vsie_page)) {
+	if (xa_insert(&kvm->arch.vsie.addr_to_page, addr >> SCB_ALIGNMENT_SHIFT, vsie_page,
+		      GFP_KERNEL_ACCOUNT)) {
 		put_vsie_page(vsie_page);
 		mutex_unlock(&kvm->arch.vsie.mutex);
 		return NULL;
@@ -1660,7 +1655,7 @@ int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
 void kvm_s390_vsie_init(struct kvm *kvm)
 {
 	mutex_init(&kvm->arch.vsie.mutex);
-	INIT_RADIX_TREE(&kvm->arch.vsie.addr_to_page, GFP_KERNEL_ACCOUNT);
+	xa_init_flags(&kvm->arch.vsie.addr_to_page, XA_FLAGS_ACCOUNT);
 }
 
 /* Destroy the vsie data structures. To be called when a vm is destroyed. */
@@ -1676,12 +1671,9 @@ void kvm_s390_vsie_destroy(struct kvm *kvm)
 			if (vsie_page->gmap_cache.gmap)
 				release_gmap_shadow(vsie_page);
 		kvm->arch.vsie.pages[i] = NULL;
-		/* free the radix tree entry */
-		if (vsie_page->scb_gpa != ULONG_MAX)
-			radix_tree_delete(&kvm->arch.vsie.addr_to_page,
-					  vsie_page->scb_gpa >> SCB_ALIGNMENT_SHIFT);
 		free_vsie_page(vsie_page);
 	}
+	xa_destroy(&kvm->arch.vsie.addr_to_page);
 	kvm->arch.vsie.page_count = 0;
 	mutex_unlock(&kvm->arch.vsie.mutex);
 }

-- 
2.55.0

