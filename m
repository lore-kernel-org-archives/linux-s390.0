Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E283836826E;
	Mon,  3 Aug 2026 16:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773380; cv=none; b=ab58shaPTLQeeagpPS98Ad0JilE+BcHDVViOVbetdA6KLJnLN40+PnuYo1+y46AAbg9tN7rc8Dpz2BQIIv9DSvObvdVFztVeujuin7tejcD3IuoPAIrUkmqyHfNim/XzSX4jUDSTNKquY20l67xslD0aZt/2Sx93UQrFA+lJTec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773380; c=relaxed/simple;
	bh=1VruCf5rrm2sEUgbQSDAnyGBMcGq92Qh9uDSnJp/RNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OWvTCs4c2G6GkqLHUeVOBGLNECXyFRIbQvR7T4PU2ADQyKNhGTRUcDyhe78n44tSbctAMzvVr+xx3V+rMQM+nscEqq8Opl/4xMe2n4FWU/uDsVSNQwk9xdH/SX9EdwvIlT2rudT9VdVH4W3YE1ZOGD+GQ8yoXMu9v/Q0X0Bmu9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KsPQY+kv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KsPQY+kv"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EHlCd2341253;
	Mon, 3 Aug 2026 16:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=947BOM/qXK2zY5Rtj
	zZaI4jCzptaxy9UP9tP1iziUZA=; b=KsPQY+kv9ha8AUuvG/3hkGh25FMFViPMG
	crscQaxT436uggy39wgqVtw4ab9C86wFJ3PBzC9ijLv72aWIwYAF2OAuqDSaLG3R
	c1s5Z8kctycSLuITZ/c/IKJD3/Lm6dVkH/Ehz056vOhIUnAEYDXECxlHDyU9K6mx
	fHpX6dAmXDewXTQHHTHGohhR1oiHNzY+2Lp1eblMHqKS/InPhY+1j59I4VtCm41O
	ErT/llg13p4JVnBB3CX2i7h7KtRnXDYOeWH/8mEHbxdF4tqVS6LHeHOGcAuRoEH7
	cS+DKTAmGSEFzNAFDwJeqmWYNNOjCGZRPDDe9+1xaMMbJOXIqHYMw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8euhbf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:09:33 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673FuGrg025465;
	Mon, 3 Aug 2026 16:09:33 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtydwx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:09:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673G9RDM50004260
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 16:09:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2733320043;
	Mon,  3 Aug 2026 16:09:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C7112005A;
	Mon,  3 Aug 2026 16:09:27 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 16:09:27 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 17/23] KVM: s390: Fix race in __do_essa()
Date: Mon,  3 Aug 2026 18:09:18 +0200
Message-ID: <20260803160924.236807-18-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803160924.236807-1-imbrenda@linux.ibm.com>
References: <20260803160924.236807-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ycA17m6qqZRNplC2UTJj6PMEUJGMOSe-
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfXxdNe9TOQT6dI
 2F1hIZtfof12naxyJ/6WTvjflAjb6ZYXe3I8TgpSaDqf909I+DqsdFBoTEX6VVZSAWBcoN5Rnyd
 8xVifqLk4yUU6EENA/kdPIXqFg5vln0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX7zl5csBb7QKJ
 xRDHtbfZ2YZXbDXLr3/2TTZZiPOMW6IwkblY6ssNTcGXg938jhPIUWz/9wkTW7wjmkQo9KQolr9
 rJqbK40MryacMc3f/y9sXJEoJiOxYce9026xFoBDlZThYdsyKN32pbX07aqJkvfssW9gtADJObX
 MqKObSsH67oh8sMGXxoVi6dhzsLF7986MLqN4Frdo/Vfv7wz1dIxrVLYdnb37mYKzIFXPRhnWAS
 39C3igwn6LW0LrSK8CJBuTTKtIv/dxaUIIUuDMgC5nAL1rgibwoWiWzVUZ1/6ThCtmzmxe3ae0w
 hd0ff7xy71Wxhmj4hs+iSskE/8GGhO0z0s7p7D2trTyCMksWTrwM1rmRhUYsCCqMRQ4BAiKDHuT
 SAvm2z3WcZRrqCl20K3I321rFmxnl2IkCzzbeQK9w/DnON2FrBS57i0KYEpJEnsrZg0ssWj2GNN
 ub8hDdDVOlUiUv6FG1Q==
X-Proofpoint-GUID: ycA17m6qqZRNplC2UTJj6PMEUJGMOSe-
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a70bd3d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=vVGDtJNaOgRaVfleRDgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030141

An unlikely race between __do_essa() and kvm_s390_vm_start_migration(),
kvm_s390_vm_stop_migration(), or dat_get_cmma() was possible.

Fix by locking kvm->slots_arch_lock. Since this is not a hot path, the
overhead of an additional mutex is negligible.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260803124040.126471-8-imbrenda@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 20 ++++++++++----------
 arch/s390/kvm/priv.c     |  5 +++--
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index e162efaa35b8..e5c5e9f61cb2 100644
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

