Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31A345041E;
	Thu, 30 Jul 2026 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428848; cv=none; b=q/ODLyw0I1pGjhesZkBLsR7zvOe20Vo2ZYE89ZQOX/cR2orOUE2xMCGHnJ3Qf9krCv6qy/xBoVo1FY5tj9tNjOjjzm4SjEsnC64tEm/vV4+ba3fi8zvM/UPcpa5S8aTDqBY5fh6kzV6aw5UXjo2i2xZLMXNnEcmPgjnbJmbzbQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428848; c=relaxed/simple;
	bh=Ib+nBkv0ZzIyG4VmBxiV+daUm3coGkUWfyxgLt0yj/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hIAcFvwvPNU1cCsUwBlYc+QN2wOnEbjfoRDU6oFj1xvV0OybGQK/XFhbU8hp+jqa5WfgDl1LrIarONr0jUQFIkcHr8s5inkDiaZq5gf4M8IiHSkOlTCuH/8dbG7ALOV+ofULAqu0aLNh0BfmVXkmkC5mNYL+EK6/MjwY6BUoofc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RUa/ZP+j; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RUa/ZP+j"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UFmEMn3481472;
	Thu, 30 Jul 2026 16:27:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Sp9iV6HLaHbp+hxRx
	yoocEfKqoPcwenUwBJ18bVw44I=; b=RUa/ZP+jP/sxI79JauNaV1ouej7mTOMJo
	QwUD2Hv6kwABZbgSxBNKC8SdGs02boltzi5PX5WWUKkZMuULR9KccsiRUWRylt3y
	YxQjXHZ+ON0umknNXk7x99aB41sYYYkiKXY3Bvb5Y9fVEzoEqNX5TU3bcYmxJ0B9
	rL5DldkCI+1Q+9Ngh1pQYfkamtmvhMdWdKmtBT0DpiO2s9Ei3Fjp8KO+audiAwK2
	KqNRoBRqrRYCwpD04rsqss2TGLY2q0eXj7BbOsEpY0syWKQnk/ACPEcXqMBJ/x5Y
	f/1zz3IK6ldHtZQwTkxM6Cvr4zwgAAAA4usiiIepIlOEbQIV9vD4Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwd7w1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 16:27:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UGQQXU001562;
	Thu, 30 Jul 2026 16:27:23 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fkc55y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 16:27:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UGRGGK30343770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 16:27:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDF5420040;
	Thu, 30 Jul 2026 16:27:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B13A02004E;
	Thu, 30 Jul 2026 16:27:16 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 16:27:16 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v6 11/14] KVM: s390: Fix ordering when adding to SCA
Date: Thu, 30 Jul 2026 18:27:11 +0200
Message-ID: <20260730162714.133327-12-imbrenda@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: r5aI1u3D3BQX-OIsPhSB2lJzYrAAxFUo
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyMyBTYWx0ZWRfX8DMPFp144Gfg
 GBAkxyWNGIEbh42S/3FrsZR4+lMF3ikh6aM2oVhi/H9c1Gj8qVFeBen53NMTTVnLg4iUdX+Bg0g
 rQVzdX44P5oWpzw8X0pd+WDHWLEsmqw=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a6b7b6b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=DpaZzcUc-R7GdRs0254A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyMyBTYWx0ZWRfX2JnSSCo8ftvc
 qEGZCv+5PgR8VgqUuB/XJYViqsIqtBff0tFRIQkWefw62goF4D/xCM14ETqD0fCcir/bwOlaG15
 9P+khmGhB4Q6eo7809MmrKxbLepiiTUlDGPIUuaxBQ4kqz1BBGxAejpiX8SHHSE/vJVaevsBVYW
 gGS+HxBc076I+XKZNEvYk1HlNjb0X/nBca13yPPKxDRCSK4tLf31+HpH6Xde0jfXV4dKqSAdybf
 Ce+xrq+1dUoEiz67e69DEYPngOtASh42jJJpAECyYyIPfuDmpFovVmPLoVBZC6hUU2GFJULDsSk
 axhspQpdQ6nqKcmFWhXhLQ8AyUm1MI1kE+306Gu2TwLs1uvEOOKQGr067OPd+lH3U6PBjE5V3/Z
 FCfLH9XCvBrVjTeJEHodD65MpEP2wiHeeP6Y2/dPT3MHXnPUfSOjzNPaK1cMR02LQqOzDRVDxXz
 z2MdRp8kAxsG0EIym1Q==
X-Proofpoint-GUID: r5aI1u3D3BQX-OIsPhSB2lJzYrAAxFUo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300123

When adding a new vCPU to the SCA area, the validity bit in the MCN was
set before the pointer to the state description, potentially allowing
for a race.

Fix by setting the pointer before setting the bit.

Fixes: 14542a0a54c5 ("KVM: S390: Remove sca_lock")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 7395d7863670..ba600c948887 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3484,8 +3484,8 @@ static void sca_add_vcpu(struct kvm_vcpu *vcpu)
 	if (!kvm_s390_use_sca_entries())
 		return;
 
+	WRITE_ONCE(sca->cpu[vcpu->vcpu_id].sda, virt_to_phys(vcpu->arch.sie_block));
 	set_bit_inv(vcpu->vcpu_id, (unsigned long *)sca->mcn);
-	sca->cpu[vcpu->vcpu_id].sda = virt_to_phys(vcpu->arch.sie_block);
 }
 
 static int sca_can_add_vcpu(struct kvm *kvm, unsigned int id)
-- 
2.55.0

