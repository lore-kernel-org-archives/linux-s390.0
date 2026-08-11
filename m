Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18FC3C1090;
	Tue, 11 Aug 2026 15:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786463816; cv=none; b=KLAy2mqmDw1eWcefKDvPxQTxh6+kJrtGf3Qf7CXavgcO2vh4DVKJYo6RjmnVlcDXnZc/EtnCRsPcYgJxGNCOOgpuKOsHJNJfaAf7+J7aF3yeI/d0rhKKETIyxY8Ia9DMe+V6qmB2UaS87hjTsqzkiyr0yoshlPRmxhKJP1Yo9oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786463816; c=relaxed/simple;
	bh=ZUGF4+g/Xm6hc0IkCpxtAibniLoi0vrTojyBXJBdpL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h0p6TyvO/G0di1eHGBZnDONzi8EHRt+kACZ6ZypHzrSdfLX857EXEkihZSDerwVSuX5dZF799j/ZsUIcvCzO1qhK5FEInRAx57xNdcOjW33+4mzu0UkAu2QsJxcIFY+/R/CfxNfHJAo32ZIC/uYCs6dxvEeFse3UIWnUqwoi1dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LnmdKqaZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LnmdKqaZ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDWt9j3633608;
	Tue, 11 Aug 2026 15:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=YeeKpF/ql5pXFRpLK
	Ln6/Fbz33lsnx5mGRrTHWkvgQg=; b=LnmdKqaZgtSXOM3lMVokcGmvzA/A4Yvkt
	QggQBxRDrjNvFMT0QKr9iCuzNfYnDwDUo1v4/6vGKC08DoAr0yGQu7MbhfOh2pEk
	ryF+M5OBd3myCZqEZekpsNxMdCWhESrNHGFLTWLhvfcokWVUhWyypcO1I1HH2OqJ
	JAIgqsJtUx2DtV+COyoGBIRa9nmICEhHaM/Mx8RyI1OgQTIvRLUtMRLyI9Kib4KF
	QA01zp0vyr3rIDY/RLNFyagiJootTzvNU3TPDrTAWg931FYMuHc5ZNLn0lEGYLZB
	ADWAE2nIr1PW1BQsdw845oQvgxvYotqF3UZGDgn00OHbq5YYPZCdQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23pgg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 15:56:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BFuGxo016135;
	Tue, 11 Aug 2026 15:56:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy1d83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 15:56:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BFuiBk40436164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 15:56:44 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 112D620040;
	Tue, 11 Aug 2026 15:56:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D40472004D;
	Tue, 11 Aug 2026 15:56:43 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 15:56:43 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v1 09/11] KVM: s390: Fix kvm_s390_clear_pv_state()
Date: Tue, 11 Aug 2026 17:56:39 +0200
Message-ID: <20260811155641.219777-10-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811155641.219777-1-imbrenda@linux.ibm.com>
References: <20260811155641.219777-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7b4642 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=72NMtMyVgwmTuVVq4s8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEzMCBTYWx0ZWRfX5TqgQAftr3Wa
 X7EmfXAwL7VVkjNbuuwy29RpE9gwCeUNaj36Bq6b8oW2l9weDMTx/VP2TzwLpnJ4QsCT8OMziEz
 /SjhvyfzkzZZ57cr1R/GdmZBhwUnwQG/jdUAVT30YcOekUUFvL3NC6a1kbud8mHXKnBl0Axacge
 w6wGyv+r6dnyi0ybt63IBgNnSAncvfIAkLhG7a357aZyL1FW6qhtc/30lNgd5Vee6x+Ntw2jZ/7
 p6dBRix8TDfQ6gSrlUYS3fS6tA7Ia/az88SLY9eFBWZydinLOSVvQ5XpGc1fZYc03tGrrZ/1KK5
 K5D6TCdBYcXNu1rLuif61St/rVviQF1HeBHyhdPYdlKlg/QdeC2sr8ybMuq8Mn8tQuEpR8AiTlf
 y6VVoUP81N4+vhtdl5TLvxgvDaasGcIIvXdAB3ToLpJQoJPxcNGjzMUN6vce8a9DuLvtfit4qh5
 XxCQE/Wu59a4aBhIOLQ==
X-Proofpoint-ORIG-GUID: 3TTgCdbLe_W3l-Gs4nFAzDlfHrXvO9f6
X-Proofpoint-GUID: 3TTgCdbLe_W3l-Gs4nFAzDlfHrXvO9f6
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEzMCBTYWx0ZWRfX6imvnuJxyxkV
 W4WUEFs5HC9S9FcqcdJ1bgZoz2WQOcCJCig8oAooFBXJgSAUQFMeSAVSzGDogW+J+S+0v5CaHVr
 xezsIVIoQ7w4kMcUjp+hW25AmzCk1QI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110130

kvm_s390_clear_pv_state() needs to also clear the dumping flag, to
allow the protected VM to be started again (as non-protected, with all
protected state safely destroyed) after a forced reboot while a
protected dump was ongoing and not completed.

Fixes: e40df9efd68a ("KVM: s390: pv: clear the state without memset")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/pv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
index b02e0159d3cd..98a9a57f71b9 100644
--- a/arch/s390/kvm/pv.c
+++ b/arch/s390/kvm/pv.c
@@ -242,6 +242,10 @@ static void kvm_s390_clear_pv_state(struct kvm *kvm)
 	kvm->arch.pv.guest_len = 0;
 	kvm->arch.pv.stor_base = 0;
 	kvm->arch.pv.stor_var = NULL;
+	if (kvm->arch.pv.dumping) {
+		kvm_s390_vcpu_unblock_all(kvm);
+		kvm->arch.pv.dumping = false;
+	}
 }
 
 static void kvm_s390_pv_dispose_cpu(struct kvm_vcpu *vcpu, bool free_stor_base)
-- 
2.55.0

