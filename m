Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECDB432E95;
	Fri, 31 Jul 2026 13:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785502923; cv=none; b=a/sRmauHzS1xaE8UyAhBpmRq8tlN9QRrvfQVV97t+e6gAxMtg8wkcC2LtRg0HRxj+6VGQRdaARCnS6q26W3u1ALqWR1EZPgfGoKq8qI1I+/nM5cRHFUdmZ43s1EwUPUvUjU0zNt56lMh6KhwsBqoaAzlVgYylFujR5EAWa/uSpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785502923; c=relaxed/simple;
	bh=yB18Tdk/yJv2D1uTlZXxVFQX7lyhikE6fAymjrfZIUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDbub4sF81ih4Q7aazityRV9/RfRin76AqcOx2JTOPpZ67tw4CrfcvVfs1c+b15jbqFx9KljgRJW0aDpLab+Vf6+b6OGvbJxbnklHo0+2p5WE39lqJTqxwd3+n7ATfvl7nfalZpF1OA016Sh2mIQZMWX9P5+sQdiPxTWeGdpTks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nHxaRaHa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nHxaRaHa"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBlbYj4072617;
	Fri, 31 Jul 2026 13:02:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+ovgPGLArufZdBlLu
	6efjoPl7/x/t4jxjAnDkdUcJ+o=; b=nHxaRaHarTvuJeyywR8ENnCyDHVTXw1S8
	cIONLNTH704DJSrgXh7DIVoDzaVqaUoduA2jO+cusAYgryTM+D4G5FT0gBGA/pZa
	FHCp2yNvK3W0mZEHLd7sjmi7OhSh443NgDoGVI2ZcnXdVfPZCjLSARIX6YRexwY/
	tmm34+uAwvUc2HDDKVocqzYu2QWIjrB6JoyDZ/HddVmV55Iv+dYOW4jfWNker4iE
	4JQauaecZTj1zvUgfWLfCh/20D4nc6TyYbm+obuZZNO5Bjs7e6/dmlFqtv5o/jrv
	MU8ekwCpcVFXM+bklUgILNexXea+G99wc5GVN9PriZA/RkNaKkXTQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycw1e6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:02:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VCuLZf023579;
	Fri, 31 Jul 2026 13:01:59 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5yfp81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:01:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VD1q6f38732052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 13:01:52 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C940820043;
	Fri, 31 Jul 2026 13:01:52 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0427D20040;
	Fri, 31 Jul 2026 13:01:52 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.4.62])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 13:01:51 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v7 13/14] KVM: s390: Fix cleanup in kvm_s390_pv_create_cpu()
Date: Fri, 31 Jul 2026 15:01:37 +0200
Message-ID: <20260731130138.173983-14-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731130138.173983-1-imbrenda@linux.ibm.com>
References: <20260731130138.173983-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6AQ2ebyc04UobjU9iMdL8JFu27dmzR3l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX/ZSlMlT3jT8z
 PZHukKA/0xeLXgyowWmkeEO+hdS5TvdpjYM2Q+fAF9yOcadZzLfi2DIWdXh2IfPrcfEVMIcZ1IG
 z6Eb8PMTlsngTy8Vcmar8xrQiV+6r1sss+TbI0ox5p1aW9VCVNm3PW+CtLKw0bgC1FLEUrATPLb
 kdW7voZUOuK1pqUkx/m18+zyfHGxQlJXooVjCDjfGMlqmH8uHn5//2tqyBH5voEfMgCUmXzG9vg
 jA7qfrLLrQRC9XFJ02oJAyPb2OyYG6WEg2Pn6mNVtDmuDzq22oKP2XBv8anM22etglhNAWF/26B
 gXBFhdQ6kZPO45KVJHbC5JTBUxdGwnK3kRFeX6cJPX5qPPYZ9RDjQ+tt4yQFB4lBEHDb05on4Md
 nC8sG+HZM8x5jGuBG0E1MRY0WRXWV+mS37p1BqG3cWR30myklkk3vDlhGk1k4CAvA1sgDs4cbI6
 8IUVxsHMYLGTGnVQOBQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX4Q4DqWMIyWvP
 jgv1o1YGWzD6GIqFH4dSHEwcSq57rIYDa2M/FqNTiO2jGlfY4XSgyw/lFvuyi7zwC4NO9GhtINJ
 Po9QT+hcxZDuKzGv78j4QumOixM2S70=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6c9cc8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=h-RzbZz0cncsEQf3j_AA:9
X-Proofpoint-GUID: 6AQ2ebyc04UobjU9iMdL8JFu27dmzR3l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310096

If creating a protected vCPU in kvm_s390_pv_create_cpu() fails,
kvm_s390_pv_destroy_cpu() was called, which checks whether the vCPU has
a PV handle and exits doing nothing otherwise. At that point, due to
not having created the protected vCPU, the PV handle will not be set,
and kvm_s390_pv_destroy_cpu() will do nothing, thus leaking the
allocated memory.

Fix by factoring out the code to free and reset a PV vCPU; call it from
kvm_s390_pv_destroy_cpu() and kvm_s390_pv_create_cpu().

Opportunistically fix the return value of kvm_s390_pv_destroy_cpu() in
case of errors: return -EIO instead if EIO.

Fixes: d4074324b07a ("KVM: s390: pv: avoid double free of sida page")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/pv.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
index dc204b521052..b02e0159d3cd 100644
--- a/arch/s390/kvm/pv.c
+++ b/arch/s390/kvm/pv.c
@@ -244,6 +244,24 @@ static void kvm_s390_clear_pv_state(struct kvm *kvm)
 	kvm->arch.pv.stor_var = NULL;
 }
 
+static void kvm_s390_pv_dispose_cpu(struct kvm_vcpu *vcpu, bool free_stor_base)
+{
+	if (free_stor_base)
+		free_pages(vcpu->arch.pv.stor_base, get_order(uv_info.guest_cpu_stor_len));
+	free_page((unsigned long)sida_addr(vcpu->arch.sie_block));
+	vcpu->arch.sie_block->pv_handle_cpu = 0;
+	vcpu->arch.sie_block->pv_handle_config = 0;
+	memset(&vcpu->arch.pv, 0, sizeof(vcpu->arch.pv));
+	vcpu->arch.sie_block->sdf = 0;
+	/*
+	 * The sidad field (for sdf == 2) is now the gbea field (for sdf == 0).
+	 * Use the reset value of gbea to avoid leaking the kernel pointer of
+	 * the just freed sida.
+	 */
+	vcpu->arch.sie_block->gbea = 1;
+	kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
+}
+
 int kvm_s390_pv_destroy_cpu(struct kvm_vcpu *vcpu, u16 *rc, u16 *rrc)
 {
 	int cc;
@@ -258,24 +276,9 @@ int kvm_s390_pv_destroy_cpu(struct kvm_vcpu *vcpu, u16 *rc, u16 *rrc)
 	WARN_ONCE(cc, "protvirt destroy cpu failed rc %x rrc %x", *rc, *rrc);
 
 	/* Intended memory leak for something that should never happen. */
-	if (!cc)
-		free_pages(vcpu->arch.pv.stor_base,
-			   get_order(uv_info.guest_cpu_stor_len));
-
-	free_page((unsigned long)sida_addr(vcpu->arch.sie_block));
-	vcpu->arch.sie_block->pv_handle_cpu = 0;
-	vcpu->arch.sie_block->pv_handle_config = 0;
-	memset(&vcpu->arch.pv, 0, sizeof(vcpu->arch.pv));
-	vcpu->arch.sie_block->sdf = 0;
-	/*
-	 * The sidad field (for sdf == 2) is now the gbea field (for sdf == 0).
-	 * Use the reset value of gbea to avoid leaking the kernel pointer of
-	 * the just freed sida.
-	 */
-	vcpu->arch.sie_block->gbea = 1;
-	kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
+	kvm_s390_pv_dispose_cpu(vcpu, !cc);
 
-	return cc ? EIO : 0;
+	return cc ? -EIO : 0;
 }
 
 int kvm_s390_pv_create_cpu(struct kvm_vcpu *vcpu, u16 *rc, u16 *rrc)
@@ -319,9 +322,7 @@ int kvm_s390_pv_create_cpu(struct kvm_vcpu *vcpu, u16 *rc, u16 *rrc)
 		     uvcb.header.rrc);
 
 	if (cc) {
-		u16 dummy;
-
-		kvm_s390_pv_destroy_cpu(vcpu, &dummy, &dummy);
+		kvm_s390_pv_dispose_cpu(vcpu, true);
 		return -EIO;
 	}
 
-- 
2.55.0

