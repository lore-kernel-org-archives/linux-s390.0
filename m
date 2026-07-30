Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C929E38B133;
	Thu, 30 Jul 2026 16:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428847; cv=none; b=D1ysM5Vsp2dNkE9qliEydHGwHtvT3+TL2DBwNxdDokgBDft15WES3IYHvKzPFifYjxAP//SXCus9SdS0BixCOcJ4xZWU5mvetIbAvLZ/1YQl3B0G58tvuNvPcGeIIvX0/zKqaKULUg2yKvOJBDj1HAW1VMuTsNsqaYc1nRZCqT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428847; c=relaxed/simple;
	bh=UX0J+8NWNoUeQjimlvrotXYZvH60p5wmUlP6qznpzy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=shwCogwqWyCvH6wO5CDU2WwKgNOHl27AVqKdDCj4IwltgCAP2CjABYUpyH3XL0afZsKnq3BUN/OHbVGV0NzWMUxTYjpDQqMKkTJw/H38Q9pHVUgH9EEUhR6ygyedkMcYrz6aIBm5ZdiLvNs4kQrxq5NaupqF4iPK2TLtgn3pX3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tkvjYXJv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tkvjYXJv"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UFm2gT3354184;
	Thu, 30 Jul 2026 16:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=SOL2ihsdwgztw7W/L
	NtakmRxjzYVmF7eWgw9blb865w=; b=tkvjYXJvL79/pytLeBUvWmgHfRTf/As1D
	/JKAuTWRIoyRvuoqAl9ySOW6e9imqzkv33c0gFn62fOkoO5XrMh+ZuelJHR2Y7a9
	RxO/mWuSHFraBwQrdHMs8MK50YKH5Zf8Ee+MXfBd5qqJpw0316B5aXi1ju4I/SZn
	sftMdoj9qU1zIDtDhvsLmIFTaHgfYSME0AoLuqxplpbYllm3ZfwUwRuMX0HUE+ND
	bazGHIe1rnGQQB8zBykOT8/7bg95vllh1aoyn5/4s4EEDtL0A9C+gCNtnnVfz90a
	ueTSUjvrRufsRKlQegQRLF+NpPb95xf9lBxM56rOdhL6mDITGh5xw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyjfvks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 16:27:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UGQJFU010787;
	Thu, 30 Jul 2026 16:27:22 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhm1vk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 16:27:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UGRGEJ20120272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 16:27:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEEDB2004B;
	Thu, 30 Jul 2026 16:27:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CAAFB20043;
	Thu, 30 Jul 2026 16:27:15 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 16:27:15 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v6 06/14] KVM: s390: Fix race in __do_essa()
Date: Thu, 30 Jul 2026 18:27:06 +0200
Message-ID: <20260730162714.133327-7-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730162714.133327-1-imbrenda@linux.ibm.com>
References: <20260730162714.133327-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyMyBTYWx0ZWRfX9MGShhIdsCEn
 yXST98qnLaonpyYMiGK/W+MpdVE/SDkLLpP4hArOQR5XktjxrRkCwTAPaEDf/nVUZJKBy9WJXzA
 3ZE7NNLixGG5TK8r9lZwRJ8gwh5BvlA=
X-Proofpoint-GUID: 9hiolngRPalOXRT7bhYVKcFvuhG1dXts
X-Proofpoint-ORIG-GUID: 9hiolngRPalOXRT7bhYVKcFvuhG1dXts
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyMyBTYWx0ZWRfX8a929fkyspFC
 OBQkqF7CXxtB29JE33bNazQLLUUqacVwMeRWjvO1AETS91KqlxO85V0c6QU4pDr9ooNhFgZMKjt
 3sgrDPRnb/OYGzxuNljHrZ7dHV9ug27qKP5TYGbzuxEyJ+obxXDFTr428RonubTKBomTuK/QEb5
 hj1dj2/U1w4cmCHTepiyGpPC+Sc3FpP0lLJnGm7rK0Z8lP+5M2m6y0Pgs1T2DDgqD0/E6vxo3Os
 QEXaOYBiGHzXeDF0B6qDIw/pHNLXgFjHcfY0h50jJuTkGGoETEBq9FUsDckLuG5/bwzpq0IKbgi
 EqA9+bLsb9yI1MXdjzLw7zb4wQylRqGhGCrN4Div5AXKrDxsSoI4SN1POCPKNB/4K4mVKv0w0db
 IFd3HHsoSxNZG4LlasDyH/PZwYwSJQ8Bve7B1OCwie/rQPPOeerrbEUIZsEwA2tlXdECS2gDOSk
 5+/9yps9FJpxQmGfNBg==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6b7b6a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=vVGDtJNaOgRaVfleRDgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300123

An unlikely race between __do_essa() and kvm_s390_vm_start_migration(),
kvm_s390_vm_stop_migration(), or dat_get_cmma() was possible.

Fix by locking kvm->slots_arch_lock. Since this is not a hot path, the
overhead of an additional mutex is negligible.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 20 ++++++++++----------
 arch/s390/kvm/priv.c     |  5 +++--
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index de3cb6111bd4..24c3bfcd5db2 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1219,8 +1219,8 @@ static void kvm_s390_sync_request_broadcast(struct kvm *kvm, int req)
 
 /*
  * Must be called with kvm->srcu held to avoid races on memslots, and with
- * kvm->slots_lock to avoid races with ourselves, kvm_s390_vm_stop_migration(),
- * and kvm_s390_get_cmma_bits().
+ * kvm->slots_arch_lock to avoid races with ourselves,
+ * kvm_s390_vm_stop_migration(), and kvm_s390_get_cmma_bits().
  */
 static int kvm_s390_vm_start_migration(struct kvm *kvm)
 {
@@ -1265,7 +1265,7 @@ static int kvm_s390_vm_start_migration(struct kvm *kvm)
 }
 
 /*
- * Must be called with kvm->slots_lock to avoid races with ourselves,
+ * Must be called with kvm->slots_arch_lock to avoid races with ourselves,
  * kvm_s390_vm_start_migration() and kvm_s390_get_cmma_bits().
  */
 static int kvm_s390_vm_stop_migration(struct kvm *kvm)
@@ -1300,7 +1300,9 @@ static int kvm_s390_vm_set_migration(struct kvm *kvm,
 {
 	int res = -ENXIO;
 
-	mutex_lock(&kvm->slots_lock);
+	guard(srcu)(&kvm->srcu);
+	guard(mutex)(&kvm->slots_arch_lock);
+
 	switch (attr->attr) {
 	case KVM_S390_VM_MIGRATION_START:
 		res = kvm_s390_vm_start_migration(kvm);
@@ -1311,7 +1313,6 @@ static int kvm_s390_vm_set_migration(struct kvm *kvm,
 	default:
 		break;
 	}
-	mutex_unlock(&kvm->slots_lock);
 
 	return res;
 }
@@ -3001,9 +3002,8 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		r = -EFAULT;
 		if (copy_from_user(&args, argp, sizeof(args)))
 			break;
-		mutex_lock(&kvm->slots_lock);
-		r = kvm_s390_get_cmma_bits(kvm, &args);
-		mutex_unlock(&kvm->slots_lock);
+		scoped_guard(mutex, &kvm->slots_arch_lock)
+			r = kvm_s390_get_cmma_bits(kvm, &args);
 		if (!r) {
 			r = copy_to_user(argp, &args, sizeof(args));
 			if (r)
@@ -3017,9 +3017,9 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		r = -EFAULT;
 		if (copy_from_user(&args, argp, sizeof(args)))
 			break;
-		mutex_lock(&kvm->slots_lock);
+		mutex_lock(&kvm->slots_arch_lock);
 		r = kvm_s390_set_cmma_bits(kvm, &args);
-		mutex_unlock(&kvm->slots_lock);
+		mutex_unlock(&kvm->slots_arch_lock);
 		break;
 	}
 	case KVM_S390_PV_COMMAND: {
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index ea5a99537346..b1ba24c346ef 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -1261,8 +1261,9 @@ static int handle_essa(struct kvm_vcpu *vcpu)
 		/* Retry the ESSA instruction */
 		kvm_s390_retry_instr(vcpu);
 	} else {
-		scoped_guard(read_lock, &vcpu->kvm->mmu_lock)
-			i = __do_essa(vcpu, orc);
+		scoped_guard(mutex, &vcpu->kvm->slots_arch_lock)
+			scoped_guard(read_lock, &vcpu->kvm->mmu_lock)
+				i = __do_essa(vcpu, orc);
 		if (i < 0)
 			return i;
 		/* Account for the possible extra cbrl entry */
-- 
2.55.0

