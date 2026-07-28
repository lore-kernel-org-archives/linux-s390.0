Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119E33A7591;
	Tue, 28 Jul 2026 17:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258452; cv=none; b=MCfaTK/YBttZuH16HVmyqSeHpMVHc+uAcNygWQhBlqvzM0JY/g+6FjreoARRz3M1wpxbY9OfOVMQ+fgStntHl1EhFePw2THoJaaMsrbDLvN8i1FqYwOxsVDWHCUsxdUy4Zsd/dwJOGP5Fp4gYbNoPEDl3kd0jQeeVRf7AW16Log=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258452; c=relaxed/simple;
	bh=1Jx+pFQRq+WMya0WUqxu5pBerJ4npV1P6wUVvXeOtWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sZJkacQn11FjLJqy9QeUzuQFrSkxSpiK46ACfCIgBGrMFXBgoe1DKeh4+IiZVHH1r0/1QcASJ4DpVSaXfvFbgQ9N48O+I1xYFXp7T5WarcThedfVetSrgAhAxNNCggX8Bmm682L340MwoO1QWgvAqgD4X6Gnvl+pGoA8VxjEtxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K/4hBuzT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K/4hBuzT"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SElhSv1380202;
	Tue, 28 Jul 2026 17:07:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=chtYFSGVRwTvuyjWP
	9mCkIJW3ZeJ7CnmseaEx0rjb4g=; b=K/4hBuzT6JFy9CxVggcLaX8F3Hqme3ySh
	MY3Upk59bjOFzgbwtCf5dfP7CPxIrDbz/GtWKMuGYAyWm/S/Zzs0D3uy94/o3/wv
	LWvHTTANngcsKSxyiaIxWXIM2yExMnxxivDontcGzMc/W2ZpQtEG/XqEDfhkANga
	dQoB/bpCVMwwJISXF7AhnxNTmWRA5xtUZ+32YpcnLHI/QIyRvTKl4rWQFOPq7cML
	ovrsdaeb3ybBC6jGBDCcp7hMNFoSYwiXGLSg8KZ+S4V5HIm8A84na/hR1mSkPckB
	74pH2PkrMX41/kUoSfLwW4haWgWrU4ClGNH31DvWSRfQD0K5szaeA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyj5wbw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 17:07:28 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SGuGBY031363;
	Tue, 28 Jul 2026 17:07:27 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fqb4hy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 17:07:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66SH7LSY28246388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 17:07:21 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA6E520040;
	Tue, 28 Jul 2026 17:07:21 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 112252004B;
	Tue, 28 Jul 2026 17:07:21 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.73.241])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jul 2026 17:07:20 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v4 13/13] KVM: s390: Fix sca_clear_ext_call() for UCONTROL
Date: Tue, 28 Jul 2026 19:07:08 +0200
Message-ID: <20260728170708.294400-14-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728170708.294400-1-imbrenda@linux.ibm.com>
References: <20260728170708.294400-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDE0OSBTYWx0ZWRfXzVU2ZMNwVGAv
 Pjf8hM7fiM4NqgGiPLJeaCNTmL7Jd1T3kkCO1jUUrG7953N7IRXr1UkBULL9/B5+R/QetCb5JXW
 MjW73FELfYs7tjTNZha1vgqRvsr9DVA=
X-Proofpoint-GUID: kxw8Dqh54v3XfVJUyOCJHUw5CZpFSgaX
X-Proofpoint-ORIG-GUID: kxw8Dqh54v3XfVJUyOCJHUw5CZpFSgaX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDE0OSBTYWx0ZWRfX9cEkCuu0mVk+
 20peyA+fiT3BJu8Abblkn5CrbwrbnSY72TaWpYnrwU9L99xAfyqOorIcjCGwj8mwnlKPc4FY5sy
 5X6SrFL50ZEJqlbJNNZ8cyhQ44nlvCHEFtLiYlaOnchZQkKk0LrkIAu47v3yn18+2bR30RplIRq
 gfucrLW21Bw6g4g1eX1T2Ev/PyRK4o4WCuRtgWlHMr1yRCCnzymw4UxqE/DSdVHzEEYqk3gETrE
 bxMLEqE7+qR2rqeWbjm+WB3kB60Ez4QGIWcoryjD9zCKYFNA+L69RuU7YIwlj91KeH4NsKhCzw2
 nmgjRUOGhkt7khQmiar9uznVeEEQOKnu1hRgsiDWnUd89LXoSEsO/NPw1dtl1EqZOHtO4EDYKnN
 nB82OCJ9M8BdZ+A6GP+mHq4v/AhluFuZMSKOvD0j0LRpjMNpMV0zXQWokiSYsHY0cjY6XjwvNAU
 RaJYKPawyoxiWO41Yyw==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a68e1d0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=ZGQRqD-6bfz83Kxo2BgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280149

When cleaning up a UCONTROL VM, sca_clear_ext_call() will touch memory
outside of the allocated ESCA block, and UCONTROL VMs don't even use
ESCA.

Fix by not touching ESCA for UCONTROL VMs.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: 7d43bafcff17 ("KVM: s390: Make provisions for ESCA utilization")
---
 arch/s390/kvm/interrupt.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 2acdff130fa6..8d146a0681dc 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -84,10 +84,13 @@ static int sca_inject_ext_call(struct kvm_vcpu *vcpu, int src_id)
 static void sca_clear_ext_call(struct kvm_vcpu *vcpu)
 {
 	struct esca_block *sca = vcpu->kvm->arch.sca;
-	union esca_sigp_ctrl *sigp_ctrl = &sca->cpu[vcpu->vcpu_id].sigp_ctrl;
+	union esca_sigp_ctrl *sigp_ctrl;
 
-	if (!kvm_s390_use_sca_entries() || !vcpu->arch.initialized)
+	if (!kvm_s390_use_sca_entries() || !vcpu->arch.initialized || kvm_is_ucontrol(vcpu->kvm))
 		return;
+
+	/* Initialize after the above check, to prevent going out of bounds */
+	sigp_ctrl = &sca->cpu[vcpu->vcpu_id].sigp_ctrl;
 	kvm_s390_clear_cpuflags(vcpu, CPUSTAT_ECALL_PEND);
 
 	WRITE_ONCE(sigp_ctrl->value, 0);
-- 
2.55.0

