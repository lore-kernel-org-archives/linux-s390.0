Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5111277C96;
	Mon, 16 Mar 2026 18:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773684266; cv=none; b=PY+RsyGQnv+0SGY34j+n+VH7FSn3m3Tt7BSIlMezh8uF8mAFM/bIt3zBaqTHO+QyDL1TzDPY4KPNje+cFSVnMJsqzWmQDJRTxJwXaKjaE7ckS1OhUQIfq3YzS8OYjfQNQdiod+GZGfavVdGiUbq41xwvBCDJk90khm0dl/6UpuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773684266; c=relaxed/simple;
	bh=paFM6m/hdp8cVIXvIU2fEELdEihCo+X19ehDGSfw/0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=laTbf7XgeopGG6NBQyNHIrYs3ZThninVqMhE+umhu+3gheTdhEaAsRarFSwpQQWvPz8yCg2VUJcWIvFWsF4wN3mM48FrkzUjr9hStm7C5XndLUc14634U/9Ij518SGvbamWInwmOnert19OR+epDADCVBisX8R5wTheMoTykCKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kzP+Cd6N; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kzP+Cd6N"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GEx58K935245;
	Mon, 16 Mar 2026 18:04:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=E6r7xERgNUNXQRkPo
	K9aTVS8jPqeQmpQyj1f4BOVhS0=; b=kzP+Cd6N+TjhDLLSUeHNdqBscyT1yPAyY
	q7FewKs4JpL9wwvQara0jpEybs8DjwzdxGylFsRZlQvTqDL035VbKJWmf6eLC++s
	p0XMIqkw+pb5QJqSYAxaE5nQCjr1keA3sn2VAfC5cz2lwn43lUemIIF9lUFNFwf0
	HgZ5VGgXIcftFI8LE2fJgy4mOv308L0voilvsiW9AwRSrovcVRG2C7aYx6cbITBI
	esUpjooRw6AH+mp7NtwrFnmsoHN4jzZ9QMcfpKoYPY2xp2zgStBkEeqfbP4roO7j
	q5006JEe273A4a3jF9OKMUv3HsGGV7wV3L6t3+LpQnCPATkaoMH9A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvy64h7gc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 18:04:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62GGEghW032397;
	Mon, 16 Mar 2026 18:04:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwm7jnp11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 18:04:23 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62GI4KKS22085910
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 18:04:20 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A3D820040;
	Mon, 16 Mar 2026 18:04:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 50D422004B;
	Mon, 16 Mar 2026 18:04:20 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Mar 2026 18:04:20 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        borntraeger@linux.ibm.com, akrowiak@linux.ibm.com
Subject: [RFC 01/10] KVM: s390: diag258: Pass absolute address to kvm_is_gpa_in_memslot()
Date: Mon, 16 Mar 2026 16:23:48 +0000
Message-ID: <20260316180310.17765-2-frankja@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: P5QM0TNeadGEoCjxOlgYV91tiS6-yPEP
X-Proofpoint-GUID: P5QM0TNeadGEoCjxOlgYV91tiS6-yPEP
X-Authority-Analysis: v=2.4 cv=KYnfcAYD c=1 sm=1 tr=0 ts=69b84628 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=aYs9lplfhmajBf97zl8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEzOSBTYWx0ZWRfX/rA5qn4G+XLe
 2KjAQ/HddgPpHaLcPjjU0qJp0IGaEN64pK0EGmhp0mFqMIarAzKyGfU8bk1dR/f4P9HSTEwg/CA
 jxPwlQ1PdgJMlSzUviZG4uMZGkXF7OEcTFt499EzfKDuFBhqnvdjbf4edTuPQFa2XfICuJvJzkk
 E11dydRpMHrvR9S/QK+zgVDZ++3zxM48Ka0Q0IT2WNeQLXHZRV/j6NO7/BdzmDMuvI7lUqAGdiQ
 aXoq32lpPiou9m7dCMcXj092okE4nVRmeAzKpoEdFr8mvVJ//yV5gmEvngkvm6oaKGB7qrrZLUk
 Ss91c0u0u46AbCR7IKYqwZyxEHEotXLTJq4QfmY0VOpL75MjV8xYhCel8aA4UmJi8AqHp2twUB1
 bB2a5De/KNob6br7sfDIIuHKF8Kh2Fbcuogb4xl9sv0IPATFeS0SJHUbjpZ/f2YhqBJCYFxM8Rs
 JzyDEyc/NLKRelAN+/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160139

The token address is a real address and as such we need to translate
it before it's a true gpa.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Fixes: 3c038e6be0e29 ("KVM: async_pf: Async page fault support on s390")
---
 arch/s390/kvm/diag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index d89d1c381522..51ba4dcc3905 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -122,7 +122,7 @@ static int __diag_page_ref_service(struct kvm_vcpu *vcpu)
 		    parm.token_addr & 7 || parm.zarch != 0x8000000000000000ULL)
 			return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
-		if (!kvm_is_gpa_in_memslot(vcpu->kvm, parm.token_addr))
+		if (!kvm_is_gpa_in_memslot(vcpu->kvm, kvm_s390_real_to_abs(vcpu, parm.token_addr)))
 			return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 
 		vcpu->arch.pfault_token = parm.token_addr;
-- 
2.51.0

