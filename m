Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2669C41D235;
	Mon, 27 Jul 2026 15:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785164590; cv=none; b=njF7mMhj+kr8caaPN4kHVFctb8XlTqz90Lh47cUc6UYrG0f5bs+2mPg0oTCpP/ni6btyRki3VJ2qJN1jxUVoKmelAFJIEx7IGiolPNqsl4f6AUVuB/u4RHSlmAeNPhHEb5YKyc/FTknqx59tBqjJyZ2LfOQyqF8bAGNdh/rgM6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785164590; c=relaxed/simple;
	bh=feRX9vMyL62JD2t+FpZgBnUcumR+V2LhobnLlHOqSg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UiYGsZPwrjTE2QZ1SQkPtj9pVOJ4RWtgE5eKKmRZ9PiCKlgwlEozrb0FRt7PVJ6eu7J7RvN9jRfvfHCTC+zda40Cd/MzVJagAWsDKzHJzlbnMwuYzlogz+98lUGrfdH5Y+xEhpdmNQDM3i07vA7pn7bGdOFf2sNtxd9dX0tznoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B8eqz2ik; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B8eqz2ik"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDmlT6512072;
	Mon, 27 Jul 2026 15:03:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5e942uOpUVCpH/HnO
	mTLGrCQD8HBgyWCJMhxbv5cXaQ=; b=B8eqz2ik7Fa4ZwPuCaxe0d/qhEbuSZrrF
	fpWkPlZ7eZ2Gy7qwOFKxoK/5BVE2+/eiZxRtuB5IH6gQf7uXqMBbP9mU41LVTiAe
	FlxwD2QbYceZVOAicKFcXLgRpdp1yeaPird7yvDejLfXn/yUOT7NwUQv9PKgNIAj
	L39bM4pjPsnvTSU9HcSHKS98bT2AOTsLGNnBxbhr3GRLSWKnkSaFlGKR2WhyLOoD
	+V9MF5fqvb33bLpRbWXrKTw1u7buOqFNki1xf+3DLBSZToHAcKEYOYFf5/IR2MJD
	4KyBYest/Fyzp8HG7nSGYNNXFdXi4OKbMLTB8TtgeVnx9Rt3pDvtA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyc8mbc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 15:03:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66REuKOl015961;
	Mon, 27 Jul 2026 15:03:04 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pg5mj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 15:03:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RF2wSn49414626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 15:02:58 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C0E6200F6;
	Mon, 27 Jul 2026 15:02:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F087200F4;
	Mon, 27 Jul 2026 15:02:57 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.1.146])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 15:02:57 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v3 03/10] KVM: s390: Fix race in __do_essa()
Date: Mon, 27 Jul 2026 17:02:47 +0200
Message-ID: <20260727150254.236021-4-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727150254.236021-1-imbrenda@linux.ibm.com>
References: <20260727150254.236021-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: edm_E6-F49I8q2SLbzfJH_WK5xipbgsx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0MCBTYWx0ZWRfX7YmUNcAJZ1vr
 yN3k0QDu1M9OCMzk44KhqDLXpePQmIJ4sDpD1UL9uYrhayhOMgNUGrd2ANU+HqsqLANNtAMWVn4
 UrbsITv16sY5BsWs/Yo7Z1TDFh15K6JJCTOPXeIjRQAh/tg1gdokNbhGPNDzfx5oHh9lUuAHJZa
 QGegJ2ljEw6hYR3y9AezH4baTWwKQ+gAPzzn39nQo5VdQNfVvCSenG3fwS/3xHmQZ/DzR52c2ZD
 pkXJ/tRd9zbS2OmMpYDgyn0V4EAGNg17Dw0VuroY50y3XyfrN4Ow4c5MrXEN6b99V0LAISpAm7l
 W0duZTvRL8r38dZUXnlnflHAiKSRnbsodPdRg+e9HgDV9xv8cwt9/cmsX8zVtBvWox2WG1dpy9F
 Ny1GgZs3rJQN34yd7JXrtnJBdKooniN6y/56xZ4IFvZiEcrGSu7rJBColu1Hrc8dUICCinmMb05
 sM6KajqzIDyMMIppwSQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0MCBTYWx0ZWRfX7iM6Vw5hetA1
 AIVGzhd8rg+gQyuKiLYQyJdNipJNRjAfFpY8JSxqm8SjTValmKIZ3nN0HgEwbnNPjBkRkW6E/L8
 fOIvRYctlTu4+jy3wAoomXxxKpF3r+4=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a677329 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=Ucc7pKXXu02aIaGplMgA:9
X-Proofpoint-GUID: edm_E6-F49I8q2SLbzfJH_WK5xipbgsx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270140

An unlikely race between __do_essa() and kvm_s390_vm_start_migration(),
kvm_s390_vm_stop_migration(), or dat_get_cmma() was possible.

Fix by locking kvm->slots_lock. Since this is not a hot path, the
overhead of an additional mutex is negligible.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 14 +++++++-------
 arch/s390/kvm/priv.c     |  5 +++--
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index efd4042d195b..879fdc42cb71 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
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

