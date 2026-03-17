Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44753C3BEE;
	Tue, 17 Mar 2026 13:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773752707; cv=none; b=LO2afUG3AWHiG/MP0IlbTNM7Vj/kRTACBwuCaV3FvlFKq2PujmmOIZqa1T/otR+HHa2QWjMu3ONHpTJtw2KTuIo48RmZ/LRDB1pa3sMEonicDduhxXoyDKsZB7j3K5qlN7yii25VkbJB2QkLhy5jvXah9x/ZveET44aUcybxoXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773752707; c=relaxed/simple;
	bh=zB+en8d7Twj8Oo3VQyvxIH7nyp7dgKQnQTa5CDS3W4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fi77CBM+HeG6laN74O3zebxWpUfEk4gdyNqnf2PzPFwSGM0lU09dcCqD8faIKv3gBEQ3zgwjwXIBKIznBnj55C5QBpwC5d/FLfSRPe8LwhQIv6l/A3lreWEEX6wsQvOa0OvgeocaGujJkYz0QG5BI3qhIoAFQIYBDe1Sry0deBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M2Bw4ljC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M2Bw4ljC"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H1TToC3905720;
	Tue, 17 Mar 2026 13:05:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hAFn1V1m9GjB5sWtM
	tIqap8/fKQP+5U9a2r6gAIlh5M=; b=M2Bw4ljC4QfvfPSCRAO4B1D/ZIzS1SvMd
	TH+Q31tWbKnveleVguKWoMFh3rV7MqmTwFi4PKmy9UUjAQ7QaMteyBTA+jlGmLiZ
	h3/oDMHVkgnrdolebxebvcbm2CXm0/w/m44rv+KKPxSpRoTTh3twrhkh4G2UlOuM
	+pYXSTnVBuqPMmyNfjTXdLS4etol9Lj9vRiJKZ1mB1IKkOlBfK6DwYKFlxon5q5T
	Si5e9kpC1QWYkyjzyRvUSzO+ESOoaE2BPVZ4q7gOYU6+G2QCWCSusFteqa9xFLbu
	gSmiP1yajMBr1FsaUp9eHEUIaGjTL2n4LxN5xArysKzmFkfrhUi2A==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybs4thu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 13:05:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62HBZ3Ye028765;
	Tue, 17 Mar 2026 13:05:04 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwkgk97bf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 13:05:04 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62HD50Ei33292694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 13:05:00 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD22E2004D;
	Tue, 17 Mar 2026 13:05:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF8D52004B;
	Tue, 17 Mar 2026 13:05:00 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Mar 2026 13:05:00 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        borntraeger@linux.ibm.com, akrowiak@linux.ibm.com
Subject: [PATCH] KVM: s390: Fix lpsw/e breaking event handling
Date: Tue, 17 Mar 2026 13:03:54 +0000
Message-ID: <20260317130440.103576-2-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <bc995033-1850-43f8-b04d-66f78ede157d@linux.ibm.com>
References: <bc995033-1850-43f8-b04d-66f78ede157d@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69b95182 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=DrbGolfmOjewO6_yJogA:9
X-Proofpoint-ORIG-GUID: imjryZ3sWh4h8NZOpz2lyAxm4DCRinN3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDExMiBTYWx0ZWRfX/7XMsbv0w9tb
 8wjUGeMHdrx4UzNThcUDBxAwyM/v+BEgzKk5TRIVvBb9nb8gsNkocFY2HvWJFwG8MmJ7T3IjPJe
 P2fFjGNo46tQaM2EddHQ6m4pReTUtOXpqeXV9kZBNzzswgFxaBTAxneLBI/2esCEcFTMM0sGEaB
 ueizd/svXs4q/o9KgelZZTajccZKgdxWkQ42Yom0JrfLJ57VNcwYCldgc1l77Jrl6IYxG27R3r5
 StVSoLAF2NXKaoqk4Ts6oFEcgfvnyNpr+xJW0W30DZ15B4bK3WJttKAHFpA/Cp4c9yL+MlcZ42g
 w644cq4pfuB9iK+3q16iFU96Vh76FdHwrUD1LLSvFvx8zbn+UCtU8YnPfrbGDsB0bJ8ruLWVlFU
 DGO8r/LYEgOcAFGGWTEPw2Fh4NdHuByCRPldPQCjGbGeo6dWYOUV+u477E4bXU6mjjP71jZZ4qf
 XFr34YjO/kDNwDSTNHA==
X-Proofpoint-GUID: imjryZ3sWh4h8NZOpz2lyAxm4DCRinN3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170112

LPSW and LPSWE need to set the gbea on completion but currently don't.
Time to fix this up.

LPSWEY was designed to not set the bear.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Fixes: 48a3e950f4cee ("KVM: s390: Add support for machine checks.")
Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/priv.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 3e764e6440d8..9d28b3fdba5b 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -710,12 +710,13 @@ int kvm_s390_handle_lpsw(struct kvm_vcpu *vcpu)
 {
 	psw_t *gpsw = &vcpu->arch.sie_block->gpsw;
 	psw32_t new_psw;
-	u64 addr;
+	u64 addr, iaddr;
 	int rc;
 	u8 ar;
 
 	vcpu->stat.instruction_lpsw++;
 
+	iaddr = gpsw->addr;
 	if (gpsw->mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 
@@ -733,18 +734,20 @@ int kvm_s390_handle_lpsw(struct kvm_vcpu *vcpu)
 	gpsw->addr = new_psw.addr & ~PSW32_ADDR_AMODE;
 	if (!is_valid_psw(gpsw))
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
+	vcpu->arch.sie_block->gbea = iaddr;
 	return 0;
 }
 
 static int handle_lpswe(struct kvm_vcpu *vcpu)
 {
 	psw_t new_psw;
-	u64 addr;
+	u64 addr, iaddr;
 	int rc;
 	u8 ar;
 
 	vcpu->stat.instruction_lpswe++;
 
+	iaddr = vcpu->arch.sie_block->gpsw.addr;
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 
@@ -757,6 +760,7 @@ static int handle_lpswe(struct kvm_vcpu *vcpu)
 	vcpu->arch.sie_block->gpsw = new_psw;
 	if (!is_valid_psw(&vcpu->arch.sie_block->gpsw))
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
+	vcpu->arch.sie_block->gbea = iaddr;
 	return 0;
 }
 
-- 
2.51.0

