Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C055433557D;
	Mon, 16 Mar 2026 18:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773684267; cv=none; b=DAWDk1DxBI0MrAbyq+Kqq8BGR66fsIQwuCIgz4XUJCi0LKEH1vIr/TQs9nci8iU5lzgmF7ERh4HHwym7PXsk/Zq7xG0JutQExoegWUQhpEcejRqhg37+C24oXicn3m845tMppiMylUhjwGVCG6+z0OMNnl8pQsPeowl13urvKWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773684267; c=relaxed/simple;
	bh=vxVgK9rcWZNnbNKA9Qfr8ThYE4e133+aupiLK+8J/b8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCeEVqizI9Gmb/sxfYRLV3IfTDVMV/GZlG3xTqT1q5OqMBpETxhYzuZjBlathEf/O87hhinjHGJZhugJUWTP6HKzTaXoxhkiadsdA4/TyacUqhQUl6GTUNWxi8mSvGlCSyfliVOjfTI3FOSTe8akDOXJa8cUWlqRk9A7Lpkt5PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qifprK9V; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qifprK9V"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GH88aP1189655;
	Mon, 16 Mar 2026 18:04:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WygUL7R51yahb3leX
	RoQq/fgVHoQsIo8YAykS6rTX8I=; b=qifprK9Vi7JJnq+w5GZ/SZ0CMp4w+yKnR
	3tawrFzTYSurPGUxUcc15mplREkRpUjtMkTNBQYvcOwtzjFQTI2qd/A/XjN5bg7M
	8RL2ROAMi+bG9nYe2gxVhh/JHAPlEHbENwOZt4g38Q++r4wX6NqzDZ+ucy3JEMeG
	CX2Pqb3CKUsRfcOpqb9OWGxPzN9bkKh1AkfsM0e09qFaQLX1ll95R5LAT3DX+xkT
	guP1uCSVgft4o95HJXhDBWRh85/ByIN/S90FOE1BOZ7I4Qu31V/e7M066Iu4WIiF
	LjW4h+wUb4h7g1u/5thXRHfjPHPPN3MeMJc+QrD0wSDmT7oExVrQA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cx7vfbehr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 18:04:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62GGEghX032397;
	Mon, 16 Mar 2026 18:04:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwm7jnp12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 18:04:24 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62GI4K0a22085912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 18:04:20 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FA2720040;
	Mon, 16 Mar 2026 18:04:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8020E20043;
	Mon, 16 Mar 2026 18:04:20 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Mar 2026 18:04:20 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        borntraeger@linux.ibm.com, akrowiak@linux.ibm.com
Subject: [RFC 02/10] KVM: s390: Consolidate lpswe variants
Date: Mon, 16 Mar 2026 16:23:49 +0000
Message-ID: <20260316180310.17765-3-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260316180310.17765-1-frankja@linux.ibm.com>
References: <20260316180310.17765-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pmjANDls09WhlZUMEG5wz15QreS4IebF
X-Authority-Analysis: v=2.4 cv=KajfcAYD c=1 sm=1 tr=0 ts=69b84629 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=cp5bzOeppHKWTYgkqKwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEzOSBTYWx0ZWRfX9zRjIzbicHEs
 Lfx0WweHA+msi8GqZT8F036BVvnM+X4xj3b6tD6zM80E8RzM9XPz6PQFDdOaRHNOMXcw+gXIBUR
 a8m/xRGC4JmxSh/YWFiENnYojLH0tjozv2AZoRokcJUdHBe2ROiHwYyhKBsk6Tw7uJhrCeJjBW0
 PA3YRYHosE/5BkF5oGv5UZfIUf6qbxlxIHncqQ5RLjNRpLB6DEO1jnE82EG/Ju5uhZFEBry3E4p
 +GVh3OUEXeve2VlnNj16yERDvs+sqxfAfBK9L5Rm9SzI5NTna5XddYVfMlCn4LYTd0NYA4HiI95
 cnWpyEVRGrkDpYRaTxyKFasxAFM12h/ZXvCJ3KHdzw8OoctY5rUk9IXtNvGcz+X6iYjXA1kZviw
 MAR7ms8ZUWj3ApZIaD83KCkFwcudFBMotat00OdeoZ/zOyr4bkI9IlAHTEgzRwxR/6NrnGtqbK8
 XE6kQR/CX0w5OyM8Wpg==
X-Proofpoint-GUID: pmjANDls09WhlZUMEG5wz15QreS4IebF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160139

LPSWE and LPSWEY currently only differ in instruction format but not
in functionality.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/kvm/priv.c | 46 ++++++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index a3250ad83a8e..a90fc0b4fd96 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -740,11 +740,28 @@ int kvm_s390_handle_lpsw(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-static int handle_lpswe(struct kvm_vcpu *vcpu)
+static int _handle_lpswe_y(struct kvm_vcpu *vcpu, u64 addr, u8 ar)
 {
 	psw_t new_psw;
-	u64 addr;
 	int rc;
+
+	if (addr & 7)
+		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
+
+	rc = read_guest(vcpu, addr, ar, &new_psw, sizeof(new_psw));
+	if (rc)
+		return kvm_s390_inject_prog_cond(vcpu, rc);
+
+	vcpu->arch.sie_block->gpsw = new_psw;
+	if (!is_valid_psw(&vcpu->arch.sie_block->gpsw))
+		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
+
+	return 0;
+}
+
+static int handle_lpswe(struct kvm_vcpu *vcpu)
+{
+	u64 addr;
 	u8 ar;
 
 	vcpu->stat.instruction_lpswe++;
@@ -753,22 +770,12 @@ static int handle_lpswe(struct kvm_vcpu *vcpu)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 
 	addr = kvm_s390_get_base_disp_s(vcpu, &ar);
-	if (addr & 7)
-		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
-	rc = read_guest(vcpu, addr, ar, &new_psw, sizeof(new_psw));
-	if (rc)
-		return kvm_s390_inject_prog_cond(vcpu, rc);
-	vcpu->arch.sie_block->gpsw = new_psw;
-	if (!is_valid_psw(&vcpu->arch.sie_block->gpsw))
-		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
-	return 0;
+	return _handle_lpswe_y(vcpu, addr, ar);
 }
 
 static int handle_lpswey(struct kvm_vcpu *vcpu)
 {
-	psw_t new_psw;
 	u64 addr;
-	int rc;
 	u8 ar;
 
 	vcpu->stat.instruction_lpswey++;
@@ -780,18 +787,7 @@ static int handle_lpswey(struct kvm_vcpu *vcpu)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 
 	addr = kvm_s390_get_base_disp_siy(vcpu, &ar);
-	if (addr & 7)
-		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
-
-	rc = read_guest(vcpu, addr, ar, &new_psw, sizeof(new_psw));
-	if (rc)
-		return kvm_s390_inject_prog_cond(vcpu, rc);
-
-	vcpu->arch.sie_block->gpsw = new_psw;
-	if (!is_valid_psw(&vcpu->arch.sie_block->gpsw))
-		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
-
-	return 0;
+	return _handle_lpswe_y(vcpu, addr, ar);
 }
 
 static int handle_stidp(struct kvm_vcpu *vcpu)
-- 
2.51.0

