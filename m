Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0191839CCFD;
	Tue, 28 Jul 2026 17:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258451; cv=none; b=sKFjGhD7IKoxHmQ6/PKGlq4mRHvYmMBdM4jTWjYzXEAPvd2zol45ch6GHf+GhdZ8LYYsPb8WwdopxRIpP8cI04Sy2H9HCVRnB3UgK4zg2NpMeS6hHGlr0zPI55vATP+dI820Bnc3SerY2GzV8cS2RMV0WD2E6XaoSvNBDXWD8cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258451; c=relaxed/simple;
	bh=ZpO9GF8EBc+wKmh3yvu2/3z+Xy2CduIVfdSTEDNsQVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eKVawxm0shM3AT2Xw8Hu/M3uhXjFyhRnNwWTU0rmEMn03BuNA9Ku/VaAYeBbo+//+D25UIO+SnHPnPRi2ELzWjoi8ZOniVKCL6Trin2MsWgQ1iZkt4BPOo+elryx1bdte+PjMu/vsVI2C4XR9T4CJsYUpB3Eqww4JWDrLIwVqas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EVzjX06l; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EVzjX06l"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SElswm1491494;
	Tue, 28 Jul 2026 17:07:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rjMV+nlWznL1+7Xhs
	00xs6LtJDdEUsPulaGMUrs6Hi0=; b=EVzjX06lwrmCOONBo0ur5NBZNy/dy8EVu
	fvUSYypBqohQA0w/Vx0VGgL3RiWkBt3+BINBuQYTwscQyxFzdtRnhPcgaA5a4jyp
	5bH2iUcUIWfNqN+FUbJ6xAy03RC9fFQUaBsT7OYKR9MBoC+5dEqSFhvQs41Oa8Tg
	O6HFcCgs3deq4UHPfa276h8VMLAlsVC9CWr6oPB/zd5dC1Wyyl9GMrHJUbrU1LVB
	aSCN+Pr8BPoDP1QBlgQk/JnFwwKbXr/0yTUc9My02EypzqTToqPOuh9L9YNd+a3c
	XbQDUnnfph3XlGSUPieDcD2qFmZVzmzIKSB8yP1N7RkQvm3YxU15w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xphs2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 17:07:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SGuEYF029475;
	Tue, 28 Jul 2026 17:07:27 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhav9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 17:07:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66SH7Lq335455270
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 17:07:21 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFA9E20049;
	Tue, 28 Jul 2026 17:07:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04C012004B;
	Tue, 28 Jul 2026 17:07:20 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.73.241])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jul 2026 17:07:19 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v4 12/13] KVM: s390: Fix kvm_s390_vcpu_unsetup_cmma()
Date: Tue, 28 Jul 2026 19:07:07 +0200
Message-ID: <20260728170708.294400-13-imbrenda@linux.ibm.com>
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
X-Proofpoint-GUID: ScbRg55iy2iKBfqCmjA-JsSmpbPH3HJ7
X-Proofpoint-ORIG-GUID: ScbRg55iy2iKBfqCmjA-JsSmpbPH3HJ7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDE0OSBTYWx0ZWRfX75mhqOkIxR32
 dd8c3Lao9jAy//c8b3ciCGpJvAXVFKjVQ9Cqd6dI9HkS10e925NrDTHHz9Zz2u+ZNeSfa94HTSC
 5I6lshhzyCJ5al4n6ZkmyqurhOFYVCU=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a68e1d0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=UbkePC3kHMpujdsGQX8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDE0OSBTYWx0ZWRfX2NQJWIID0R53
 Mx4RH/f2g3JSnfeR0t/vMrF4twzsLpBZ9Q375JN+3/q/0Codw/ytSvag/Yy0KG7jwu2kVOWXGJm
 FXXYQ022mTaCB9axBCDmveE0VWt4DPn9hL4q4YTGSbUiw4s87O0EgfVzr+mJFs4DCRcUIjkbKu+
 4FhT6viezWm+pxF1dMPRQRgXjwiekgosYiS/o0ouHbUhgTHXE090eC3/MUXKBJM+Cnl7RUNa0xN
 JLHsdDBXYOmMdoSqs590x+SMul5+vSmGIFir5CzixUHesl8+V9Jry8dqC29lHhbM1RweejFZK3H
 Nhk+Nl6zvf8Sl2XAmARzJUPxUi8ORpNKB2AjTnBWfLkObjp9KpFOfgD3YXhsYPCrFU/G9Ek7iDr
 Cjy+c3lhTnvCarTUNXTNwPYWq0tM6lFB5hLmQUGu0gzHIRiu67/D7iV/ozQWz1gYWqFBt+vJGeZ
 x5CwGfMPyF1Vx4kel1w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280149

In some cases kvm_s390_vcpu_unsetup_cmma() can be called with a 0
cbrlo; in such cases, if running with V != R, free_page() will attempt
to free physical page 0.

Fix by freeing cbrlo only if it's non-zero.

Fixes: b31605c12f4e ("KVM: s390: make cmma usage conditionally")
Fixes: 29b40f105ec8 ("KVM: s390: protvirt: Add initial vm and cpu lifecycle handling")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index b151d25a4a4c..84c6f77e9fc9 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3677,7 +3677,8 @@ static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu)
 
 void kvm_s390_vcpu_unsetup_cmma(struct kvm_vcpu *vcpu)
 {
-	free_page((unsigned long)phys_to_virt(vcpu->arch.sie_block->cbrlo));
+	if (vcpu->arch.sie_block->cbrlo)
+		free_page((unsigned long)phys_to_virt(vcpu->arch.sie_block->cbrlo));
 	vcpu->arch.sie_block->cbrlo = 0;
 }
 
-- 
2.55.0

