Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775763AAF4B;
	Wed, 29 Jul 2026 15:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338990; cv=none; b=X1bIhYR4x5YSLKF4Hsf62dNeo5Pxyhm9NSzw+EoW3GqdtbAfG1t8lnZjhJ8vE0bL18NUbTjOJ1cAmX5RisgYgC9Lz8ikhczcusSSSQr/2ZQ3UkFjCing43niphlFvdE8SYYv4ahu7t3orK/vxD+0SgbYFO3rnQiamu56eduuxSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338990; c=relaxed/simple;
	bh=n9hiqWykKl/GtKLSLhlFw0N0tZkcrcqOy0OHRBUp37M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aocr879g5zxb0UCswresgdsuFq1YBCEH8PzrWopVj906k5E3dYeegnLYX7rDBUB3XHdDKDScZE950aQFqUkZEWz424sVevG+syUGGxxI1O6MkcNpzZKr2ElVDeWNdHdhgrV3N84eG8tM+SSgkqDSgrq6mBOrnXay41f9JWc/R1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bXxPTv3z; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bXxPTv3z"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TFHYUX355794;
	Wed, 29 Jul 2026 15:29:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=mpHgaFdGTfbXF70e4
	mcmMNG9ajz50URSueP0qU+Bq4I=; b=bXxPTv3zBlXIojJJfaEDQBwCot65W6R2I
	e9zthN69F+bfTna4g1znLfKGvq+GizGu/idj7FjRhUbPYuD7/Ks13Y6v10z/ne8v
	Gzk9QN3v9yKWqSASd8gAXt30/nU5fkzzs45kAc5uuc1ixtmO9BXwpNLtfZ1JfP5I
	50z8IUtNgBEsODn97GOuJ3cMA4N8OsgnbaaaXRt0ciDyoS69e45jYqS4IcM/IpLr
	KFkZJqSZBsU/qlwPkjRrgoQhLWyGevOijLojPuacNVLa+ZQ16fnnprdxwAKBXkt1
	QIzR6IKwrAWA8QRqptcWOFCmweVuY4FoGZoiFGCAzpzUB8rgtDR3Q==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7kdft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 15:29:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TFQGcm030580;
	Wed, 29 Jul 2026 15:29:45 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5y70gc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 15:29:45 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TFTdJu45875704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 15:29:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 977DA20043;
	Wed, 29 Jul 2026 15:29:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73BB52004B;
	Wed, 29 Jul 2026 15:29:39 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 15:29:39 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v5 06/13] KVM: s390: Fix race in __do_essa()
Date: Wed, 29 Jul 2026 17:29:31 +0200
Message-ID: <20260729152938.782383-7-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729152938.782383-1-imbrenda@linux.ibm.com>
References: <20260729152938.782383-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RpT1Uh9U2wJ6RA6P3dr1l2OkC3df5SxT
X-Proofpoint-ORIG-GUID: RpT1Uh9U2wJ6RA6P3dr1l2OkC3df5SxT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfXyJmMU5X411Zi
 XUU3n8Vufz0QEFgps/Ss2lXW9fpTrhkstM3tDj2tyKyxSC/G8kj8W6nZqL70hJ5eagw6WpYfhMX
 D32kAnTbq5tysF+tdRvJZPGBy5pJgPpkoQCiTtZ85MhibsxOcLDPep5x7ZnRf9ejMTYP9H/LMNO
 JUqM5tbw7xk/3zzGwekR/4bLv3UN47ef0eJhTnkbwvHruxFvQaaGzGOSezEK0LPR8EFWyrRYK/E
 UXqjwpznj+W/rS8AGh5uXb4Wbspx9JpKtYbqqk8keqPV5rCAOKy6zDGIZ9JXJpoCBSaJekvzyzs
 VYM70qe5uYHBTZSkm8LG97zpNV/0lGum/9T1l0ngsPtlQDpOet7zDcUnXqVUgwHFhu1j7GyCQtg
 oeyzJFbmfb5Kv1RAlRSjTIcJwO30vk2C9BvCK6k5HnQUxZUHcJFtoG6qyqKeeULbgPVmd9d5cCO
 tNzHxS2s3PAR/YG5QXg==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6a1c6a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=vVGDtJNaOgRaVfleRDgA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfX902PGjmSkBEg
 G/LyKXq2agXJPWzu4X31pL7MGd7IOmFJa7I6v/eaLZo1FRX/XkmW3SpJN9EyMTuuZQ9Gqs6Q9Fm
 ANiXgDAciXWVpcnosAKGLqchnA92AP8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290123

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
index 39626649901d..80036b8a1f31 100644
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
@@ -2998,9 +2999,8 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
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
@@ -3014,9 +3014,9 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
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

