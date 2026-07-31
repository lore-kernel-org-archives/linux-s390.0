Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570EF426405;
	Fri, 31 Jul 2026 13:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785502913; cv=none; b=GDxX3K1Vc7kysVrbtoTgjbEo99+Pfe2OqUXidREm9npELp783h2wMYJo+b9qZ8bPiGpJpQ4m2HuFzBY4lXkl26Eg47Z11UIIvokEmee5shwY3BPAn69me1T3Ch3eNUek2rwELxagCcjWo1+TeUiJYquL4sN4GMesv3mPpJGPaUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785502913; c=relaxed/simple;
	bh=PFR1XFwLxC/X4367EBT5xBpNjMhUspJXsUabptoEkM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+k6NJGD6A7cZgCJ0xcdAX6Apq9xYqqp0+r/bqe0pRQxEfklNxgdpgViHj5ibwdmJTy1Cb4VRRldSPLvuD4JHtoTKwKkzAKhAUyzLhwp2MLU+GvQhuBhhnFkJlr2elKLT57FE9Sg5JvbYssde0JIbpMgK4Jc4dAo2bN4tLyCovs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XIK4frd9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XIK4frd9"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBmQIS1732323;
	Fri, 31 Jul 2026 13:01:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=n9+ojDvm4NA40kUmQ
	i2tKXfo/PA1HooW9l+BffZSvho=; b=XIK4frd9oMTk1z3AjY2o7rGthanKTjj2s
	6eMQp9Ia+vEsDxX88BtFIECBW97z/u6SHkEljD10RrkMU8PgD3w6EhduDszP9TmB
	jxsT2fd8zKF73JiK3U1PmdrVnJqSak2Vjq32EJnJ+UhDA35W3zdHBSb/OgWSLTqn
	/mkE3xnBbm1FP38/R/Nco/1TIptOtVUjER2IbBGQx8LXmn8NDrZbB73rc3ZP8iHs
	JMLolJu1HN9n4eAOHWw4NAoBlol0nyYcUstrVAvPwBba3i7w2z9NtE+uWIMWVIm/
	rJGKRJNNHz50dqFk4HbalMvCYbp6DvrJExdzIsYrs/teHwKlNU39g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7w3fe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:01:50 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VCuP15021771;
	Fri, 31 Jul 2026 13:01:49 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uwg2uu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:01:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VD1gao11272566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 13:01:42 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81AFD20040;
	Fri, 31 Jul 2026 13:01:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AAD0920043;
	Fri, 31 Jul 2026 13:01:41 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.4.62])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 13:01:41 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v7 03/14] KVM: s390: Fix kvm_s390_vcpu_unsetup_cmma()
Date: Fri, 31 Jul 2026 15:01:27 +0200
Message-ID: <20260731130138.173983-4-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731130138.173983-1-imbrenda@linux.ibm.com>
References: <20260731130138.173983-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4awQ3g_y2QBUzVlpF5kAH6OFt23IGww7
X-Proofpoint-ORIG-GUID: 4awQ3g_y2QBUzVlpF5kAH6OFt23IGww7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX96Gq/1E7y+/2
 N5tejVXMUD8xJ5N/xh2JBUUcZSAYxyizkxlhCFuzu2UQyBrmRb2ZlvA292n1OasfZtm0NxRc12m
 soT6fA7YFgjSmpAdZxx1G5WfQYKOawTHVW5YlvkpbXcq6j6hWVwi3K7N79ATsXaSA51i9nsT5Pa
 D25dDCdWnL5Cwj0NDil4tao292MVK10da8UiWxIgSUH4UboKV6Mt9xo+JIAnWsyaFA4xlp5Wby6
 ajqDn3ef6qbhV5biGihc6gjZuUGBV79mBjojXjwG54PKHl4EQwd6kQBQp73Txx192DP7vW3suhx
 mGMstWLbpz5iPosw9GnnN0WKbvZBv7CbKHS9nMAG1L1na77RDRvsAf56LziwX/0fxqSeOgjhh4t
 WeZJav/MaOUQ9jed9zibyEFkdmLRuwfpTIaZsolV9dSu75PxVifYwgXG7aHnWYYl7Skc/6nsAyr
 mLoZV75W5pWaOZNT97A==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6c9cbe cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=UbkePC3kHMpujdsGQX8A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX+KHg7ba1VbBG
 0fTuSBy3BW4dD7Q1ZQMrgpCcBs3wjeetQayFvQ0zNiD/hIMh8o++Sve6WD2QpjyKbXUUL/v0aC4
 1iBC9ocP+XNYhmvuoEjDI/49B1Il970=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310096

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
index 1b3290a5ad1a..9be27db0a21e 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3678,7 +3678,8 @@ static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu)
 
 void kvm_s390_vcpu_unsetup_cmma(struct kvm_vcpu *vcpu)
 {
-	free_page((unsigned long)phys_to_virt(vcpu->arch.sie_block->cbrlo));
+	if (vcpu->arch.sie_block->cbrlo)
+		free_page((unsigned long)phys_to_virt(vcpu->arch.sie_block->cbrlo));
 	vcpu->arch.sie_block->cbrlo = 0;
 }
 
-- 
2.55.0

