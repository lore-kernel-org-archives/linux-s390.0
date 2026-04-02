Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27F23F0774;
	Thu,  2 Apr 2026 15:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775142111; cv=none; b=hLkUH8ukbGrVil/rY1s/r7QmkHSy1kWfdG/PCSpv36PWsqZmlbho37sjUFzVmXaDrm+lAKO8Okh9859ZFXB+0JnhBnRx9jcypFPGdYHqSQgldbM67cpC4IFSp38tP0gK4EeePoTECwITZtfixbXBp2Xx/+ys2RuEtqE+Ppa6S8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775142111; c=relaxed/simple;
	bh=+2RNcKa9c5cVVfKFP9p9PuNCdqI6GHvT0fNn+HlrPHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uAjkIEjdmMzzUL4aF3U6RrMgivASo85mX/tL7hmXVn6jEDJhqfrCyIatU+CmF0kUo34LACZduBPGbj2NUrLz/rHhpbTwRVhqcR9aqBOBij0E3t451fYce2R+I5roOpyE/su0xw5z06xH31uqmljmgB8EBjK/zWn0IMzVVRU33Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OROjiAM9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OROjiAM9"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632Ekwax015098;
	Thu, 2 Apr 2026 15:01:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Hu6tMlzUyfApP8h97
	EEP58C3mVtaSLFaUfmOv/wQqUI=; b=OROjiAM9G/S0Z3K8Hked7mYBkP3vx817I
	qemtH33Wn/Qtl6Mv1VP9+V6JXiTUtUwuzA4NoRuYLH8AcoZWhivjJWyb9zKjUbsH
	52PJh9bq2L4onlSGwNXjZiczAnM5fC9tSlCs/SK/iEtGpwGpcC6QKZVQ9zdhaO30
	hoJe7Jv4p+IRyoDkypN/3Vjs6YCvvpTv4jkzDLLzXBORwwRPRWP15f8VjsfOeSWH
	1QJmytxuvKPy6jf3EaosxRI1DmcAjxKmeYMy+8ut/257yGPFB9tjYbQCW2SBK8gf
	u/KLHotX1YoDNcLqJg0Ao7SmxGY+gmoxmI7ttyOVlIFJeIHdayqgw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66q3d8tx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 15:01:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 632CnkXn031552;
	Thu, 2 Apr 2026 15:01:47 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhk29s6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 15:01:47 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 632F1fUW48628008
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 15:01:41 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC66620043;
	Thu,  2 Apr 2026 15:01:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3B2C20040;
	Thu,  2 Apr 2026 15:01:40 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.87.129.177])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 15:01:40 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, nrb@linux.ibm.com, seiden@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com, david@kernel.org
Subject: [PATCH v3 6/6] KVM: s390: ucontrol: Fix memslot handling
Date: Thu,  2 Apr 2026 17:01:35 +0200
Message-ID: <20260402150135.196943-7-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402150135.196943-1-imbrenda@linux.ibm.com>
References: <20260402150135.196943-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6YGHs4HexZsaR15p-Gk9_r1C7rTYtYkQ
X-Authority-Analysis: v=2.4 cv=frzRpV4f c=1 sm=1 tr=0 ts=69ce84dc cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=-V98bmycwAGgclNV9YMA:9
X-Proofpoint-ORIG-GUID: 6YGHs4HexZsaR15p-Gk9_r1C7rTYtYkQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDEzMyBTYWx0ZWRfX64yRn6gGzc3v
 RDhSM7MCmxpq+j2TFD8j31HI4wuguFY46BZ4RGZTrkqVaPpHcpfGOl2xBB5MHEKNUViOf0fPtUT
 lB3okhIYNw3NnEKhVq2xgGSCU8aPmAiyuoSAe4DaF3bUGmi9Es1cqVvEEHURmw1Gji8NG7wN8q3
 6lqnfkVGsJPPb62LO++mLmlZoxXvlquzetY6JbMeEre0cRcVQwXmyTdr0sK7m+b1ySdm16gT9iM
 etYKurounGtwzXw3I5yVZh8GLCeZw6dWLzGpxlSbtkW+TF85b59dCnUUBy/8sz1Rr3oC5X4YfXj
 dOySwoGs9+Qe6Jtd7wKrE5XBfPzLAu5Y8vFj8rcuAJglIZBao7k3bWdcjOb98wBHEhTykgo9HIF
 Kr62rguiPz9+LVTk7n1wuRgfi6kJLkeJFUcxjbALxwVLLQNeTgMlQyEAqLBTBhdjuWNT90MEnt6
 fQgkkJuk6iQGoJvTsaQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_02,2026-04-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020133

Fix memslots handling for UCONTROL guests. Attempts to delete user
memslots will fail, as they should, without the risk of a NULL pointer
dereference.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index be2a721e2574..435c3a1b74f8 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -5636,7 +5636,7 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 				   struct kvm_memory_slot *new,
 				   enum kvm_mr_change change)
 {
-	if (kvm_is_ucontrol(kvm) && new->id < KVM_USER_MEM_SLOTS)
+	if (kvm_is_ucontrol(kvm) && new && new->id < KVM_USER_MEM_SLOTS)
 		return -EINVAL;
 
 	/* When we are protected, we should not change the memory slots */
-- 
2.53.0

