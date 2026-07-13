Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A2743B3DB;
	Mon, 13 Jul 2026 15:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783955354; cv=none; b=cEjxJY29JK5m3nmvIqFQsqTDADLBd7809P25syj6/czw8wnoFqjcRJ9klPwSjw29NtPyALk4k4RJCNKLI5cy6b2yesIMHUf+tVtQZagqsImSmOJqQywAZHRVX7Z0haq9lm/T9N3UKCliutDFTSAorzmEx1DHBUGRz1HggsDoImg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783955354; c=relaxed/simple;
	bh=yS6Scd623yrLxXIGI+hxMK2bMxPsOMm1OyhPbps2X6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KEwU0IxxSj/ZU2Fp2+y08NrwKfZvU6BGpF05jEeBl9eOrSGT4O7rMgTr8MeAl319O0RjVrRk3cjf25wXL5twqPbVFA+hQMP09S2NgaAaxKjMRb/yq4PcD5tRu0DvJiU5B8aNgyCTjXaVEI70oXUhSi8eSBNW27WmZskWQqS0tMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OSi1Zsm/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OSi1Zsm/"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DCD4DQ2370732;
	Mon, 13 Jul 2026 15:09:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wq0x68XiD0o8hxCbY
	1beN0GhivgmmIWiliafc1pnd/c=; b=OSi1Zsm/QwHBIsKpON4u8bGAkOTtQjeTW
	2b+5Zjvjflj3NkxQLdxkd2wfT5MVfbEoj5pSONVS9ODU9hgXcOitpXmv2uetDoa0
	moKihFejywL12x6p46oYrIBZ/XYODFGs/wK3rXRno1/LIi2Q0LRRsaU6CF3/2149
	LZ85S8zcMcDyLjuJuq9JEWHm5PtaihgVL1TgR6rTkEHBNwh1HS0shUV8gTmaWWr6
	sLpks7r58CwO734TdkvFmD/jox1d5eJzD5hez25A17+XBgW7I64nnefDSNZeRwU8
	X9uV2ZLfJb+LDyMu9i7IfYmuIWMX4Tlc53894FXVCZ7jcSZeCmT7A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbexwgxc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 15:09:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DF4vEQ016896;
	Mon, 13 Jul 2026 15:09:07 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cg610u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 15:09:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DF91ZB45023706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 15:09:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9069120043;
	Mon, 13 Jul 2026 15:09:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9CBD320040;
	Mon, 13 Jul 2026 15:09:00 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.87.153.197])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 15:09:00 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v2 3/7] KVM: s390: Fix race in __do_essa()
Date: Mon, 13 Jul 2026 17:08:53 +0200
Message-ID: <20260713150857.269954-4-imbrenda@linux.ibm.com>
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
X-Proofpoint-GUID: TO4sAh3WbSf6kSX7jyysdujzLHDVR3D-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE1MyBTYWx0ZWRfX7H0eQHzXzZqn
 sVxVujsqVur/AxQCZq1KDOy4jVsWOcaBxupHqoT9ditmphEmGEt2L4mOMtnbyMUvS8EmXCTjFub
 gT0aEJCf6VlrPkb3HE9kr1Vw+terFvhOE9TLsl7Iy3DnoWz2r47pDmWcw8ysMZNQT5Ho0Lfuxk1
 N+ghQAZWTQMDDF8sHIDAyrrpY1H7QHt8MTSUR+GrpjRw9nIkghd9TuyeaNarEOOWndOQfyHHcv6
 +Gj6K5ZUt8Ip4k9MxUF4THdxwtHVt1Fl4LUgF776N8aaRl9x9FROEpwIjjT8bnV7a8fl0qh5wzZ
 qs/R0ZjlLTx8uuU/csFBemImtkpBLgoAsB+iBKUiKM1k5U1UCFA73PCIPexJLOjIpBRzJVAa5/A
 80hocktG0pi3IJXTsPpLsYbx0tiOpsS5pcUwu1eu8a+YEAX08vCrMsNQbNNPUXvb52v9+oOTy4l
 VG0MGEGjSU7fTIdzGkw==
X-Authority-Analysis: v=2.4 cv=XJoAjwhE c=1 sm=1 tr=0 ts=6a54ff94 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=AI3xc-Vg5h5KuinStKkA:9
X-Proofpoint-ORIG-GUID: TO4sAh3WbSf6kSX7jyysdujzLHDVR3D-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE1MyBTYWx0ZWRfX8QjEh69uuF2O
 RCq++iUarQJNEw7UWOTd87oGBO6e4GTzihp7u0tAMSMu5rPgp9DgmQ1Jv3cgm7PrgH139O103Hi
 pZqtmt8YgKgxd7Un6dYwgZ3Yb/ZTrpI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130153

An unlikely race between __do_essa() and kvm_s390_vm_start_migration(),
kvm_s390_vm_stop_migration(), or dat_get_cmma() was possible.

Fix by locking kvm->slots_lock. Since this is not a hot path, the
overhead of an additional mutex is negligible.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 9 ++++-----
 arch/s390/kvm/priv.c     | 5 +++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 53691aaf6534..9e3b8b5c6aa6 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1298,7 +1298,8 @@ static int kvm_s390_vm_set_migration(struct kvm *kvm,
 {
 	int res = -ENXIO;
 
-	mutex_lock(&kvm->slots_lock);
+	guard(mutex)(&kvm->slots_arch_lock);
+
 	switch (attr->attr) {
 	case KVM_S390_VM_MIGRATION_START:
 		res = kvm_s390_vm_start_migration(kvm);
@@ -1309,7 +1310,6 @@ static int kvm_s390_vm_set_migration(struct kvm *kvm,
 	default:
 		break;
 	}
-	mutex_unlock(&kvm->slots_lock);
 
 	return res;
 }
@@ -2996,9 +2996,8 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
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
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index ad0ddc433a73..d4c91e416167 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -1260,8 +1260,9 @@ static int handle_essa(struct kvm_vcpu *vcpu)
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

