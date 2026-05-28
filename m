Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777C32FE591;
	Thu, 28 May 2026 11:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779968858; cv=none; b=PDqLgN3PWdVjMwIesPk7WA9Oud+avUDeUsnA17Ppr5qhcaPRZZDYzW4GkhVDkJmvK4rLDuDyMbxSiXql4wL+VkUf0Tb2NmAgLo6X/G7Qimu//bCd67o1HdzC65bqsvdircFc/29dI9ZuyxMJqNEKt1rpdGzRhoi2+16AezDVE/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779968858; c=relaxed/simple;
	bh=TA19f/y+xYkIMPOziRqykOvXcPvgaeEOtK5SLEvFYY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2LLyEwrz6bcYS8CnDgdtqM7yKQWXwaIHjH4JptrgSJIDeeXobxK7jitlmcL8PjkskCdzFw3islsUvHYXr4weyhi/G4R1V24sm6mw54cbu0osfUx4MdtswB5UT0go0C58wyTCOuQFFGVqIRxyINqFIqq2lb31PNtOKo0f+CTjSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CApc8Sfv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CApc8Sfv"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RL7EpG3427730;
	Thu, 28 May 2026 11:47:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9cZdFG36hpHKqsXo9
	r26skXAs7oGLrh9lGr45S/uobs=; b=CApc8SfvVymPau0J5xtttNakIyoVslVPO
	FgR0qRnJsCYeSsF1myp0lI3kg/UfVIhNwASz1Qg6gjhpGXxo+cy5bbC3foUR+Vui
	r52z7jiNDmOTFOBYxLb6NhIKiG5xl4dh53B6KxJMvNBlfuXFGUnN5IsTfgMX5bHM
	0X+PmQBH+8D4f8cnWKTH+JG+PPC5M3OcNRP2uiPplldL3I97F/zKQrrLdRWW2nAQ
	CKmSvm/hYjgZ4SdkXvg6+a/+Tw2M2ZLaCpj3cq/oZ3z0FeSUf6FV+R/0A5Vug+rc
	dwNRHhw/Hn9P56MdrVzuKPdb+fqHAy8QnkJPj4ndVgcWkCIYncQNw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884jsyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 11:47:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64SBd7d5030830;
	Thu, 28 May 2026 11:47:34 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrb7wd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 11:47:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64SBlTKb51118570
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 May 2026 11:47:29 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4707720040;
	Thu, 28 May 2026 11:47:29 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 17BEA20043;
	Thu, 28 May 2026 11:47:29 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 May 2026 11:47:29 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v1 4/7] KVM: s390: Fix fault-in code
Date: Thu, 28 May 2026 13:47:24 +0200
Message-ID: <20260528114727.142178-5-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528114727.142178-1-imbrenda@linux.ibm.com>
References: <20260528114727.142178-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=L4MtheT8 c=1 sm=1 tr=0 ts=6a182b57 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=p5SjDoQbJD9XZwj20uYA:9
X-Proofpoint-ORIG-GUID: gOjCw9x0yXmXcl4XwywLXYDuH4fVJ3sh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDExNyBTYWx0ZWRfX2EMJmR6LWJef
 f3ptVy8XoXlwEtg/uuODKt+P9wd+bGWWv5znYeuuOT7lD0wRJVcS9RWFYPEgIOTh8rcKGdI+D+7
 88MaylgRpEqj/uDgInW/pBIrd2LmdkNzAA31+ljaPqI/uPpKV3xHLGpZGs9rmNUcLjyPRpLyP9h
 88MgrlFVl5pPh2Hocx4Z89ugq95/+O22zf3sNyrsN+cIiCTJt5UIbtWypCQjDjPNKAmkAM/1sG4
 USbXtyQRGjJdrTR5EIhEpQodabdi/uhlDU/ZoGh1z0rSuwVyrGWQTISgFN7wENSPpkmr+JNd7xc
 TFye2vsQqxqAmv3bmN2nieRhRyCZuya+CID4WCO5FBQDnNrJQtGPVCApAyndb83/E530HlqdWiz
 QWFYC9LVZEMhzS1L1aLroUSB5/TMxZloPwIm9o2TQsa9DIQUt0ShnYYSxcAyeTI+UYilipjMngr
 pTGiHcwlMXYDHqx0QWg==
X-Proofpoint-GUID: gOjCw9x0yXmXcl4XwywLXYDuH4fVJ3sh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280117

Fix the fault-in code so that it does not return success if a
concurrent unmap event invalidated the fault-in process between the
best-effort lockless check and the proper check with lock.

The new behaviour is to retry, like the best-effort lockless check
already did.

This prevents the fault-in handler from returning success without
having actually faulted in the requested page.

Fixes: e907ae530133 ("KVM: s390: Add helper functions for fault handling")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/faultin.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kvm/faultin.c b/arch/s390/kvm/faultin.c
index ddf0ca71f374..3047dfdc8be4 100644
--- a/arch/s390/kvm/faultin.c
+++ b/arch/s390/kvm/faultin.c
@@ -36,7 +36,7 @@ int kvm_s390_faultin_gfn(struct kvm_vcpu *vcpu, struct kvm *kvm, struct guest_fa
 	struct kvm_s390_mmu_cache *mc = NULL;
 	struct kvm_memory_slot *slot;
 	unsigned long inv_seq;
-	int foll, rc = 0;
+	int foll, rc = -EAGAIN;
 
 	foll = f->write_attempt ? FOLL_WRITE : 0;
 	foll |= f->attempt_pfault ? FOLL_NOWAIT : 0;
@@ -53,7 +53,7 @@ int kvm_s390_faultin_gfn(struct kvm_vcpu *vcpu, struct kvm *kvm, struct guest_fa
 			return 0;
 	}
 
-	while (1) {
+	while (rc == -EAGAIN) {
 		f->valid = false;
 		inv_seq = kvm->mmu_invalidate_seq;
 		/* Pairs with the smp_wmb() in kvm_mmu_invalidate_end(). */
@@ -110,20 +110,19 @@ int kvm_s390_faultin_gfn(struct kvm_vcpu *vcpu, struct kvm *kvm, struct guest_fa
 			if (!mmu_invalidate_retry_gfn(kvm, inv_seq, f->gfn)) {
 				f->valid = true;
 				rc = gmap_link(mc, kvm->arch.gmap, f, slot);
-				kvm_release_faultin_page(kvm, f->page, !!rc, f->write_attempt);
-				f->page = NULL;
 			}
+			kvm_release_faultin_page(kvm, f->page, !!rc, f->write_attempt);
 		}
-		kvm_release_faultin_page(kvm, f->page, true, false);
 
 		if (rc == -ENOMEM) {
 			rc = kvm_s390_mmu_cache_topup(mc);
 			if (rc)
 				return rc;
-		} else if (rc != -EAGAIN) {
-			return rc;
+			rc = -EAGAIN;
 		}
 	}
+
+	return rc;
 }
 
 int kvm_s390_get_guest_page(struct kvm *kvm, struct guest_fault *f, gfn_t gfn, bool w)
-- 
2.54.0

