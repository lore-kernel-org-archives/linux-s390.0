Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57D9315785;
	Mon, 13 Jul 2026 15:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783955351; cv=none; b=ohM/eIo8btmSqUaujxvtK4t89e71TmVoBFAbhp8h3SOIL79GFY1b2WMbV6vEZmqXJxj/MRuPy4/B4VF68sp7PJmfgyk4zKxWSVy8Ig5hX+6Ljrfzmy7L0/IM4doRLvOZXAUFrgg5GAkWMeiup593HKbRgw+V3x3kIzLqtFNjwxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783955351; c=relaxed/simple;
	bh=N5HNbMhs9mN7KnF87bKihseEFH5113y9+4X4RC4ir8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwoUnm9hCOv7VZVbN/wIxqfbC2EWUTzyYVzSzFjboN62t39Cle0e0OiI8xDos55EjSrLyWZB6Lpp9ku6dJZmy4vfLaH7zVF0Hkoxh/2y52I/wqe4/RSzgq3ORZyFukAFFyFtRZ5zj1/6cTFbdhpL6oSIVRkE2vl3+X6pavAoVbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H35+rtAV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H35+rtAV"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DCDJDo2437940;
	Mon, 13 Jul 2026 15:09:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=y3ElO2XeOERHWnLkU
	YCYp1KsBQgU77pEk6k+kV/88wE=; b=H35+rtAVHln7e+zDHhb3tldEuByhV0onk
	/FTsEfr2Vw90iodk8xUBNXsLkP4y30YTr+Buz/FMGTrFDxYwiUS2ozonNQuH1Qsv
	e1YjVZwrPC1PHZzzWDFF0789Z+wqE2A4SmwwEK7JwV5ff5mUP4juCXjp0Lr0V9xY
	sN9lrcfLPvLLj8dqRtfe8qz6U0qr4eALa+2rCoQIkzweNRarkeGxVJ+MRqjyrxIF
	mGbU/dzTHa76PItnItwRFkG4IaMujUtWby3+NczSbo3ClwV2hvfsrlmZwnJYaGDw
	P9J9tdzc9ZtIR3dd0h6K3mam8fg4ooxIPCNS3QC++5J6mLNTIbpsg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbepx9ah7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 15:09:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DF4x4v016931;
	Mon, 13 Jul 2026 15:09:05 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cg610r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 15:09:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DF8xxV52625738
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 15:08:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90B9B20043;
	Mon, 13 Jul 2026 15:08:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C637920040;
	Mon, 13 Jul 2026 15:08:58 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.87.153.197])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 15:08:58 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v2 1/7] KVM: s390: Fix unlikely NULL gmap dereference
Date: Mon, 13 Jul 2026 17:08:51 +0200
Message-ID: <20260713150857.269954-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713150857.269954-1-imbrenda@linux.ibm.com>
References: <20260713150857.269954-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cP-Q-t-SwB4YIUSebqxwgS7hBDCBP0mR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE1MyBTYWx0ZWRfX1cIws3gTjnBr
 efHVVqSX4K05xvj7zwX9v5Aze4w05w+cP93krNCF1nwfk6YcxmDuOTit1lIx3ILx3DtlaJc7vwW
 Rw9nREGeqIQXiOjmEhYwPpW5rkZkf3w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE1MyBTYWx0ZWRfX3vFFZ/c5nAUy
 kHWZ8Occ9YBKsOQF7d/sFgPwQ2FOyDTQUNd/cxFtxrzxat/Lrl5QB72DGGm5KOna1E+U2CWyKw+
 //V/3VwKxH+JloZO626kxWMdYc0V/93RquBQDLIDnNJW+xwT8g4vvws3cbBceNSGBiSGT4WA72G
 PH6bh2teNVibXkmfJHbVkwgu84ZrZsoka+OabeJUwiPtSSoYbqkvm/Od5XMSq39osy43DCiUWsd
 7jArt9Px0Oyx+luyLVZ5FJ2UnfT8U6So6YWQsWQTR1AqdkurN5ZPf19Cnp0SS5VpSvIYi2fh+ja
 smQTjgxfQRzaz+TwOqQATrZ8Hg/LcLAkY28bJW4SK4YqVScfmewflDgp6tee5YJr6ZRPDCMANFV
 O+mNp6n0brsGBA5CsrSKZaftczqTZGpYW/CJpj1JG0HwlqlJ3/vD6MeHoeeTQY5hbDoZOExibp5
 toV4lBQqyVCW4F0arZQ==
X-Authority-Analysis: v=2.4 cv=XbS5Co55 c=1 sm=1 tr=0 ts=6a54ff92 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=-aBWQn_vEbd_VLME6SsA:9
X-Proofpoint-ORIG-GUID: cP-Q-t-SwB4YIUSebqxwgS7hBDCBP0mR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130153

When creating a new vCPU, kvm_vm_ioctl_create_vcpu() will call
kvm_arch_vcpu_postcreate() after the file descriptor for the new vCPU
has been created. The new file descriptor has not been returned yet,
but a malicious userspace program could try to guess it.

If a malicious userspace program manages to start the newly created vCPU
before kvm_arch_vcpu_postcreate() is called, __vcpu_run() will try to
dereference vcpu->arch.gmap and trigger a NULL pointer dereference.

Fix this by moving the initialization of vcpu->arch.gmap into
kvm_arch_vcpu_create(), which is called before the file descriptor for
the vCPU is created.

Fixes: dafd032a15f8 ("KVM: s390: move vcpu specific initalization to a later point")
Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 1 +
 arch/s390/kvm/kvm-s390.c         | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index eaa34c5bd3c1..edf75b6ad20c 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -440,6 +440,7 @@ struct kvm_vcpu_arch {
 	bool skey_enabled;
 	/* Indicator if the access registers have been loaded from guest */
 	bool acrs_loaded;
+	bool initialized;
 	struct kvm_s390_pv_vcpu pv;
 	union diag318_info diag318_info;
 	struct kvm_s390_mmu_cache *mc;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 23c817595e28..374dae6dae81 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3611,6 +3611,8 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 	if (test_kvm_facility(vcpu->kvm, 74) || vcpu->kvm->arch.user_instr0 ||
 	    vcpu->kvm->arch.user_operexec)
 		vcpu->arch.sie_block->ictl |= ICTL_OPEREXC;
+
+	WRITE_ONCE(vcpu->arch.initialized, true);
 }
 
 static bool kvm_has_pckmo_subfunc(struct kvm *kvm, unsigned long nr)
@@ -5037,6 +5039,9 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 	    kvm_run->kvm_dirty_regs & ~KVM_SYNC_S390_VALID_FIELDS)
 		return -EINVAL;
 
+	if (!vcpu->arch.initialized)
+		return -EINVAL;
+
 	vcpu_load(vcpu);
 
 	if (guestdbg_exit_pending(vcpu)) {
-- 
2.55.0

