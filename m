Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5C938B7A1;
	Wed, 24 Jun 2026 11:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782299983; cv=none; b=cQY62jC3p7o/5KozH0w3BmgnA+U4Sg+HqKXnp3Oc/W341BnrFTMPyaObewz102yB6C9fL2xHmzWrTQF5pH9bDSqH9rAYztJNpaTzeTgWX+189CyZ+IBAmiRzVr06lXNw0F5bGTZWBNDzfmVhhVnkqitkIWnKXilpuypqoWvliOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782299983; c=relaxed/simple;
	bh=gjvViECmvDV7rDib4LeU8vnRGVG6bQ9atvxTKH7keog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AuVzfCSYPsKvNcxCcmzMdHyZUX/cxUChakePHYmXvn6k9lMcmWmJYBpyksTMgsrQX1xTwp89eA97OLWlgCBCmiprBdy17XuFl38VhridE517wlbSvn/rP0KUsTP9S6qxAlC5YZYmQI9a0IThbNaekp/MMj7r5WeLbbNr54LMY0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L04cQ61j; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L04cQ61j"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OAmZpd550603;
	Wed, 24 Jun 2026 11:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cytNb16zavyEKtpnk
	P9cjUY6QWJjzEAoNMsVNMLF12g=; b=L04cQ61jHyJ8WWyt+vVypSzFmh1tTpUkx
	lUVQarXy+wnWRPar1OcwwD0WF4UnQtqJ/Y2cRC/j5hqQQK92FSQLoIVoAy3+CJXR
	xIDpuDMssvees0FSj7BzcnlumJ9CLckLlxDHH5Cti5xwkOI8A964YSse5oW400ur
	X9T+LcS46pYpmD8dHGyPKdnaY1/V5CFwcDC5vzer5shqckSKMM2yZGhfEKRWvOjX
	nZALyn7hlA+5XKdUMs517EVg9UkC2pmfqvVvlFv4ReQ3DYjsfp/NRm0pqzK+QsU1
	Zot5U6BUn5/oOoBt2klkqFSLV0uSGdi/75u2XlRm2UKMXIfHcCcPA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewh9gkna4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 11:19:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65OB4qIf001601;
	Wed, 24 Jun 2026 11:19:37 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex66k88ay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 11:19:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65OBJVOc26149322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 11:19:31 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5B9F20043;
	Wed, 24 Jun 2026 11:19:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD64A2004B;
	Wed, 24 Jun 2026 11:19:30 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jun 2026 11:19:30 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 08/12] KVM: s390: Fix handle_{sske,pfmf} under memory pressure
Date: Wed, 24 Jun 2026 13:19:24 +0200
Message-ID: <20260624111928.144283-9-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624111928.144283-1-imbrenda@linux.ibm.com>
References: <20260624111928.144283-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=c62bhx9l c=1 sm=1 tr=0 ts=6a3bbd49 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=tAqH__8HQhgemv6Xi3YA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA5NCBTYWx0ZWRfXxsBgQoGeb7Z5
 Pzy0G9V3AhNuyWPjuKwZKriO8ZYziLav7JPmWdmeTNkB7EpORLmLyigEQC8IyNwb61VcMJpJi/a
 kVXMTIwXYOASf05NrX0q8EFMkz/cLu7rrAoMI8NAe9O2bbPPlU0MxpMVpUu/e2MMc5yFjzwPZQj
 yMNx1AotvdK84L359jt+JLdZUOu851jQGohajGPgijJAndpvhCu83IuplNTA+ez3SeaAeY7sEaH
 X36usOD2Un4ZHgErAXSequiQzl9mr8slJQVoutXyP5TPoWmmq/p/P6GA6nYRYjRXmGSzoTswa7F
 0aYDShqB8IT4Y+1Bb24a0HziWSyLKe65DGK4vgu6XVEWJEssCex/lkQkpsugPwz1xuBfCEZfs9b
 k7osqsNvM3tQA4T+HI3cg/e/1ROv+A==
X-Proofpoint-GUID: vEw4jWUEOf8y6kapXxxBtQsVQOBons57
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA5NCBTYWx0ZWRfX1XcJHgXv0w+8
 GFAAHFEIoV1m03laRerNQ8BYpO8ThUdCQZaxe+WHyYbPnniX6wkH1BRbo+BnUbnAdBhRIib3JZi
 egzuIjylbvsI6BwwOCYfNF4dKC3O3uY=
X-Proofpoint-ORIG-GUID: vEw4jWUEOf8y6kapXxxBtQsVQOBons57
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606240094

Under heavy memory pressure, handle_sske() and handle_pfmf() might
cause an endless loop if the mmu cache runs empty, the atomic
allocations fail, and the top-up function also fails. While quite
unlikely, that scenario is not impossible.

Fix the issue by not ignoring the return value of
kvm_s390_mmu_cache_topup(), and appropriately returning an error code
in case of failure.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260623153331.233784-6-imbrenda@linux.ibm.com>
---
 arch/s390/kvm/priv.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 447ec7ed423d..9bc6fd02ff77 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -366,7 +366,9 @@ static int handle_sske(struct kvm_vcpu *vcpu)
 		if (rc > 1)
 			return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 		if (rc == -ENOMEM) {
-			kvm_s390_mmu_cache_topup(vcpu->arch.mc);
+			rc = kvm_s390_mmu_cache_topup(vcpu->arch.mc);
+			if (rc)
+				return rc;
 			continue;
 		}
 		if (rc < 0)
@@ -1122,7 +1124,9 @@ static int handle_pfmf(struct kvm_vcpu *vcpu)
 			if (rc > 1)
 				return kvm_s390_inject_program_int(vcpu, rc);
 			if (rc == -ENOMEM) {
-				kvm_s390_mmu_cache_topup(vcpu->arch.mc);
+				rc = kvm_s390_mmu_cache_topup(vcpu->arch.mc);
+				if (rc)
+					return rc;
 				continue;
 			}
 			if (rc < 0)
-- 
2.54.0

