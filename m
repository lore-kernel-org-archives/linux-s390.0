Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424154503FA;
	Thu, 30 Jul 2026 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428847; cv=none; b=p0LNs0/m9nKpjc1pRH5CAVE6QMdfGKgRL4nR2RnHhuhJle5j2F4RAHya5kM83vl24tuCBLnxWnIG95o8rXkK/BUva4aKp/h2KaclnHq5BLyEWihJWrqDgHGj30z07E2Ew428sIAGS++Vtl8EpKXNrPrwaebSHLhHhzzqLujeAIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428847; c=relaxed/simple;
	bh=A0i25W7MlkvjzeQs5wtngaZo62H/Gv/6M9BbUBUH4h4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ig7a9OIs/F9S+9V5hnwhiS0o5vEuaCMat0KAKc64+FJNhL7hp4Z3F+kLkqnhGyhTZpD30/rFj2poIjGV985T1bX1SOI3tjWNhtF2ymF2qbVUghxWw5S3f7QCCed95tuTl7611m8cgH8lilYlmxqeyIXjS7AD1Yu/HIgEURKF7FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RNQjn+f2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RNQjn+f2"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UFlv5g3353688;
	Thu, 30 Jul 2026 16:27:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=syx1RmfvDe3NQRynO
	3NqRemsSeiyDeWgBlgoLuLrFdc=; b=RNQjn+f2F0h6ZTfcyj2Pwn2No4T8b8VU0
	76yyrohPNJIsUQTRiYLG71Keu33K32F+ZHudI1cyv4GuONHByxIqVG3gR7+OzLjU
	jLf4QRA7X6ke68EuYUTHluRa+7l5hxxS9YtLUYYjNCvKSSXVmkK9I/716ete5dXI
	MVaPZz9rwb8FXcWg2j0mv1U/oCqnL//IzOPdK6m5EJiYvFRGRscKbqCbranUW+OJ
	9y4INZPtHwytET4Zorih1YL7GpQc5rDZ5+LtzE9Jaifg47yHdFXzC222s0IBxXM+
	kxsMxJwkkDtF00XMl6y2e1hPV2u0fg8GDlplE2qp59IRe6g6lhAFw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyjfvkp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 16:27:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UGQLjG001533;
	Thu, 30 Jul 2026 16:27:21 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fkc55v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 16:27:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UGRFI835127784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 16:27:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4941F20040;
	Thu, 30 Jul 2026 16:27:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C5022004E;
	Thu, 30 Jul 2026 16:27:15 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 16:27:15 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v6 02/14] KVM: s390: Fix kvm_s390_vcpu_unsetup_cmma()
Date: Thu, 30 Jul 2026 18:27:02 +0200
Message-ID: <20260730162714.133327-3-imbrenda@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyMyBTYWx0ZWRfX5bs20NKSTSaB
 yCMkk3ic0ehl6dXpMorduPpX2VKJ6XE5TE4vg59DS0/SM6xHsy/E42y3Qi4vT8U2bKh6xOaaCMj
 67LKnChhoseSH+d4LnfFtYpwDa0/cgc=
X-Proofpoint-GUID: yUEeiQZKy699Be6ghAql_W2KEK9tAmnl
X-Proofpoint-ORIG-GUID: yUEeiQZKy699Be6ghAql_W2KEK9tAmnl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyMyBTYWx0ZWRfX2IMgbWZsyO2K
 CMHSs5hrnIArHXPqe+MwjTSnhSACdfCTLCT1oP5Wo21WUQLSQtfSIUb+o4f3k4+QmKvW2g5/JjQ
 25F6Y7SemRS5I1aBsyoggDkdNPhOjiQapiV0/nuZVYu5LSth996dy84EBGXNExJG5tJhUA5X88y
 QQMkoM2pPXcwd8hu7r9I6OncXIm/+AaimXJf9seKapxcScYoLWEGED8ORwufd5MytWX5PTBUiqf
 V7FwazbGJVXrWVt20//uEgMH3SUaRfnHYnRMFH52mylWhZNa7wl9zZIxQPu3L7ZZoC7s7L3KlJI
 zD8JJ4KoPraeAnZ4+qPDxjuylw1F81MWIdee9hLCNSyrLBDmM9LgYV8d5z2i7rpyVhfci0ft1zu
 7KXMmwToecglR8qOQOdwK71Y9Wm9dv051fEYFLHs8bdMflm29OeOSqd6MV9POsDj/IEf0jnNdbh
 dqNc/nfryeFxMSnn95A==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6b7b6a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=UbkePC3kHMpujdsGQX8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300123

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
index f86b4b0b356f..9ec5833a0973 100644
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

