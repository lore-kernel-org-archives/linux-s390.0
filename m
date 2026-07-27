Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A6D41CB57;
	Mon, 27 Jul 2026 15:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785164597; cv=none; b=YGdo+vMlZ3r5kScQQUGmI+WiP8t7cCPeM+4lOZsgVGOJLVwZYJ/20yCueIW91VN5TH6ZNfrnihOf/bDskMyE/6NCg5m6RBf9sQyQYel6/kGRGc6Aj10KctCwkhjujf5WcwhUqREZL69miQLIb+QZQEnfmeVblNOmWM0QjpbWkrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785164597; c=relaxed/simple;
	bh=s5MG2J7VUGq5Isuh/rZFQjBoloJQfNyqyxq7uCmWHsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B3Z8yHLxA5tyDF5cLDSRIq9qtwHyVABJJ3WBk1pzazywE7jmlUxqtW4XpvS1wSP6FbF5isOz6LYQdLEDqdPTjd59UW1t1p5NuQFqs0Bf2aAEaQvr/iV2KYpZyl/Zr/DBWnrG+TXW8icsBXbnR8ZO1GodR84ulWE6/TdNgT4O1fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D52q0JXs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D52q0JXs"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDme6v2406272;
	Mon, 27 Jul 2026 15:03:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KDWf0ztmU+ubEyGHx
	xsiUF9N4B5gznn6z/2UcGrCBLc=; b=D52q0JXszErWgEo1wylng69YxsB8JIy/N
	j5M1LRIGva4IIn9kkUKzdy4FBjGsEV/BmpbMPRt/VcaXpjRWqkwVbTG/qFSTnGC5
	iln8LYf1B8zSCP0tnwTsSrvyUMWvWGwIGBOaAiQsIOON83WHMpx3PLP9BMLnJSQA
	wYkFRhFQ7qVNy7Ai/pTNscUna1xNPY0pH7yRfPZMwfDy7QoFtcKDnxkG1LawIS6T
	YNRsKCRXbCY3QV0B+frGyt8gk/BauNBc4L4THzk2AfadG5gTQo6jHIGiZ04cJ1e4
	G0Nz6drwKUeNw699g0SHLcAfP6YJg1sypXOvoxm6mLaf6x8sOHvWw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xgn1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 15:03:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66REuPIZ007504;
	Mon, 27 Jul 2026 15:03:11 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5xwjb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 15:03:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RF35tu10223874
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 15:03:05 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 341D0200F4;
	Mon, 27 Jul 2026 15:03:05 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F575200F9;
	Mon, 27 Jul 2026 15:03:04 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.1.146])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 15:03:04 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v3 09/10] KVM: s390: Fix ordering when adding to SCA
Date: Mon, 27 Jul 2026 17:02:53 +0200
Message-ID: <20260727150254.236021-10-imbrenda@linux.ibm.com>
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
X-Proofpoint-GUID: tpzrEJBn7uZqdGAPFvDi0NVGbcg0_iQY
X-Proofpoint-ORIG-GUID: tpzrEJBn7uZqdGAPFvDi0NVGbcg0_iQY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0MCBTYWx0ZWRfX6tRGQynodyzD
 8Gtd5I5ffxXG61JFSqlf/qVN8litZmSsfs3YplTKvQ1Nnkm+kkjxWWdSft4DCQ7A4tn9DqtfK22
 JKTaQdUKAFu4NtwgQ+SVlzrxSDqDBbs=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a677330 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=ENZFvArl5UWzb2BATEMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0MCBTYWx0ZWRfX3UGZx7Z4AtRQ
 QKI75cr5V/ogg917vIU0Zg+fyFLvH4wn2Osq1LYLNpZtR6MiyRV23fIGlWnXYzvt0IRUB+c4dME
 VnEDrXxLO73K6Z4ZePHDWmGkR36h4QIy6WRI37VYcnmEAhfoQGHRET6JArtctAMyEuX0SyzcRus
 9yooksAuPeC/D3VPDmXxQkU4KQxu2lMTcehCBjowMrmRNRh7eyfkDZaQaNqQnzxIKfUFdFe0TX3
 VYExENVnzy9/4P8QrA70UZT3eCtqRMgU7cmicqRmcJohTFFbczeBVlAp1f2BTx3TiapJAH6ni1q
 aQbzVzEmjKwWOEV+mEPOXxw9DYMzb7TyPtl7ejNmHjF+6/i/lPQievMvDV5ns/rmkmc2WnYFiPA
 9aSWQyZl7/tz55FaFMk6FKbxVbJ/cLnZhbtLx9t4IGBzmh0YkKIzMV+pmugQ7hu6WTJj6ZaGi+A
 4Bh92HduLikZVOoh6Fw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270140

When adding a new vCPU to the SCA area, the validity bit in the MCN was
set before the pointer to the state description, potentially allowing
for a race.

Fix by setting the pointer before setting the bit.

Fixes: 14542a0a54c5 ("KVM: S390: Remove sca_lock")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 8afb88a2b73d..85dcd40b2fa1 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3481,8 +3481,8 @@ static void sca_add_vcpu(struct kvm_vcpu *vcpu)
 	if (!kvm_s390_use_sca_entries())
 		return;
 
+	WRITE_ONCE(sca->cpu[vcpu->vcpu_id].sda, virt_to_phys(vcpu->arch.sie_block));
 	set_bit_inv(vcpu->vcpu_id, (unsigned long *)sca->mcn);
-	sca->cpu[vcpu->vcpu_id].sda = virt_to_phys(vcpu->arch.sie_block);
 }
 
 static int sca_can_add_vcpu(struct kvm *kvm, unsigned int id)
-- 
2.55.0

