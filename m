Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D42E35AC0A;
	Mon, 13 Apr 2026 10:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776077276; cv=none; b=k1dYHXE7IP5b/vHpKVvm29GrQsJibHDdkA43aGwivQsMXo0fpEkQwNt1Klpl7+ZxLIKCk/yK4QfP+DTxQ8VckFDcQnBYNOKr/3lsXrvNK1y1Hmc+SQxYaP6yRUGGytE5rpZWRFp/GXLExujvN69Snk6/Ta6dVgaQ7U42TfhcCHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776077276; c=relaxed/simple;
	bh=V4kF6u8mTceDBTg1VlNhRylWA2MfK+86VNJBpgLKMUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uxpub6QWyBPUDqEDlNvMxn7ylZY70VZ43UXbFR8565GLiei+H4qc7I1/aJ7bzWE06rLFVfQe8yYMdXbir8UsL0qerUNudV2sV2UELOPga1sGiHLIm6TUH1FJpeDK146I/mkQqauWpLmy8tyyobQFDAV4EFUEA9oXlzSNJnDRgOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=asfuSm7k; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="asfuSm7k"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63D9jM271843133;
	Mon, 13 Apr 2026 10:47:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Ewu1Fb/RsnIclqRSH
	M2V1qyga2G5cU7o7VpVZnsGCjE=; b=asfuSm7krVrFxdqGQnV2XO7H2qlRjRpNq
	t5DFumikggG0+u0mNfCH2qgPnC+gnxtEWGxz7PWVwUk6DaJHq+ZHQMkOuu6VuyF6
	tn6K5aJ0y9ubwWoMX8nLFS4MGZdPLtMaLqhUr2EJtTwJ0clmQ+wYLRjR3uQpHQbT
	9h1A9OIDh2LJoALHmhKTNFIsVIdyiTwklc1aeYVR2CPjQpeRbVHiFHmSsupTlPz7
	fxgiNyPrIDzEx7Hsp8/U2/4J55TKN1SQbrGF9ALBLVixutSLJwODwbZ9/g+MLxhm
	n7tEMHv6Rmq0lCYDvky+vtpHcTONihZ1/oPSfFxcnImXilOocAIFA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfdyqq6rb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 10:47:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63DA9peZ025841;
	Mon, 13 Apr 2026 10:47:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg3b1chju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 10:47:49 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63DAlkSN51314996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Apr 2026 10:47:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42C042004B;
	Mon, 13 Apr 2026 10:47:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C7AE920040;
	Mon, 13 Apr 2026 10:47:45 +0000 (GMT)
Received: from li-9fd7f64c-3205-11b2-a85c-df942b00d78d.ibm.com.com (unknown [9.111.7.85])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Apr 2026 10:47:45 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, frankja@linux.ibm.com, david@kernel.org,
        borntraeger@linux.ibm.com, cohuck@redhat.com,
        linux-s390@vger.kernel.org, imbrenda@linux.ibm.com
Subject: [GIT PULL 02/12] KVM: s390: Fix lpsw/e breaking event handling
Date: Mon, 13 Apr 2026 12:46:30 +0200
Message-ID: <20260413104721.203024-3-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413104721.203024-1-frankja@linux.ibm.com>
References: <20260413104721.203024-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ErTiaycA c=1 sm=1 tr=0 ts=69dcc9d6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=DrbGolfmOjewO6_yJogA:9
X-Proofpoint-ORIG-GUID: LldjIlVwbZgfGWc6Fip64TER9xUx3FAU
X-Proofpoint-GUID: LldjIlVwbZgfGWc6Fip64TER9xUx3FAU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDEwNiBTYWx0ZWRfX7SaXF/jKHR3G
 wYzX7dWGUqYnomb074C+361AwWwDeCaVXp4UnxznL4/01/tQ7VBDD53kfOFUBIZdqvhPU3+Nlu/
 +xNP57DYn9HzgWLlm0i99fKPbJzEX5vWfGSHkvGY3ygpBqyZI3PgIeLoL7JUEANSWx1RjFR+xgd
 /LjIW/aznE41ALubub/QlUfj69sSGYdDxFOWgy+9+/GlVp3RZclg2ONQ2Q04s4SyDHOTaEEhewk
 abc9+dLz55dizlgLeARhR9PLMOHSY6te33xlV2DxpdM9kH6dteZJpb2VqKjrOdEC/bKzwgygOoR
 6sFYW4NGz2o0ruht0jbjUU6wt8DfcxSOKIP67BgOxqdSSnuIpkYvDvn867RfFuV/RnpHjJfF5Pt
 14/73O+Du3bqiFOEEDgzJnUdOaDC3BxwasfQQgTTAadYieevxu9m6kdWtLCSfsHRse2idevdHbT
 KUhJ3zR9kAgq8j4qoog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604130106

LPSW and LPSWE need to set the gbea on completion but currently don't.
Time to fix this up.

LPSWEY was designed to not set the bear.

Fixes: 48a3e950f4cee ("KVM: s390: Add support for machine checks.")
Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/kvm/priv.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index a3250ad83a8e..cc0553da14cb 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -714,12 +714,13 @@ int kvm_s390_handle_lpsw(struct kvm_vcpu *vcpu)
 {
 	psw_t *gpsw = &vcpu->arch.sie_block->gpsw;
 	psw32_t new_psw;
-	u64 addr;
+	u64 addr, iaddr;
 	int rc;
 	u8 ar;
 
 	vcpu->stat.instruction_lpsw++;
 
+	iaddr = gpsw->addr - kvm_s390_get_ilen(vcpu);
 	if (gpsw->mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 
@@ -737,18 +738,20 @@ int kvm_s390_handle_lpsw(struct kvm_vcpu *vcpu)
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
 
+	iaddr = vcpu->arch.sie_block->gpsw.addr - kvm_s390_get_ilen(vcpu);
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 
@@ -761,6 +764,7 @@ static int handle_lpswe(struct kvm_vcpu *vcpu)
 	vcpu->arch.sie_block->gpsw = new_psw;
 	if (!is_valid_psw(&vcpu->arch.sie_block->gpsw))
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
+	vcpu->arch.sie_block->gbea = iaddr;
 	return 0;
 }
 
-- 
2.53.0

