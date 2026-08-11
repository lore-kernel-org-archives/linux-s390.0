Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BFE3BB9F5;
	Tue, 11 Aug 2026 15:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786463813; cv=none; b=Y4EQLLw3Z1Fl3KAEpYgI8JMakIOUmgbnk5ksHdZTzbDrN+dqRt5XYosVfJ/sE1M0I32KQzMhgGw8glk8RDO6Jl8Ie2nQYlAa1eqBdc6/2FQvpbIdp6xmSVn3Ztgmr/ix3nEb1MBxoBwhwFB4FjuSwllvWoaH4vbqAahb1YRs9LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786463813; c=relaxed/simple;
	bh=x4LU99P+yBdvmaebEK0fA015TQWPLyInHOVflRY022o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E7w2n7hmluYEcPMglsktTX9zYxGb9GF1H0P3w4w8K3SXvcLapP4+VGJ++SBnqpufe0CubYQQPVAxTMP/jWlwyQKYDwI46CcHRlbW5I6q1cm9qmGoDi326qFSMs97Jky7NFTtTEnEpMCOCwmZGEh942WPKogZ+fCJqsmWccDt2Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nCLG2jOn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nCLG2jOn"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDWQXQ2864443;
	Tue, 11 Aug 2026 15:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zdvRwvXsjk+ewm4fx
	SBjyBIqNunf0I0CgNv2zaISG18=; b=nCLG2jOnAz8f76A6w4Zs6PmT2UViwhjI+
	0F/TIplUWXe0IwTT870e3gvdA7+ZcljXARYAUZNSSPdoul9JBbI/SwK4z55M2X4n
	cY+wV1utA2MImCw9XhwmNeKY++7SbT7PfETOzAxc2UTsNOFkGsWiB4+nAUJ0FVTF
	sGrVRBBxX3yuqxpg7DWlLus4+bTUEMJakNHHwrCfQ58/mXX9EqbGOe6ljJ7Vsns6
	dDh23/AqxbwwsB9WECdAJY1k/bVVavyRibBxeygO727kZ8MYgw/tXIdkZOdlpv1E
	M5qXf2/X5nclQnOBSjjus4Kn5LlHk0LWTI0RyVlziab1d/JJs1irA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvjywsjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 15:56:50 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BFuJm6032683;
	Tue, 11 Aug 2026 15:56:49 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjsmpv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 15:56:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BFugg230606006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 15:56:43 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C754F20040;
	Tue, 11 Aug 2026 15:56:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A09F2004B;
	Tue, 11 Aug 2026 15:56:42 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 15:56:42 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v1 02/11] KVM: s390: Use srcu in kvm_arch_vcpu_unlocked_ioctl()
Date: Tue, 11 Aug 2026 17:56:32 +0200
Message-ID: <20260811155641.219777-3-imbrenda@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEzMCBTYWx0ZWRfX35N3SWEJsNqN
 D3INnqzXJVARpnEnDMnTQcR6/zzNLr/eXjfm5FpbwTJSd9zZYhIpksZOylGhtsCWNLcVTv4jm5X
 PCLX+et9/lVnlbR4wN2McagyT5TNIkcUTjZ48ZsLKcmAe14VmhfLy0ZRgilcm07VIrGILa+rsRT
 Mu9rcuz/vZ5mRp/MA/Uv5+QY9q11pzZxQ0NHAtJFMoVpfYEQmxT55KQlkCcuQZbkHq/nBwnXuEf
 9brNQ130bgMicuUC0myKq7xGFsTx4+vCvEPVUAqLeYLJdRERu+ZgIBcrPX0zGkYOzPlI0oDc/s9
 S0FXItDUQGUwi29rxk0knOrfkpABvUG7YKuU4dOZ35jvwSq0NajDPwkJaO7dW73+zaPO5L8TiF7
 9ZeqIkbvTA6bT8EIkjuXnr9X9OG/3BSovm4Aec5JLNEdFGr0KOKOi7n3rfmDiYLALfiCCkKthkf
 VKMpUSOpuuoRz3XSTqg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEzMCBTYWx0ZWRfX80trbEoq7br5
 xSCdcj+MPPzQTGMpcF5ny50H7emyDwH9T3kXZI41eK9TTbG6BwIa0MPluypysMWgzZblHVEtWoA
 jWgAfTU3h4LjDo4uw24Ypgu7DqlUgH8=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7b4642 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=qtdt0r206yBj_IGTItsA:9
X-Proofpoint-GUID: I019y_3BofoeuFI_AdX-ovyQE2_X94_b
X-Proofpoint-ORIG-GUID: I019y_3BofoeuFI_AdX-ovyQE2_X94_b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110130

kvm_arch_vcpu_unlocked_ioctl() is called without further locks held, but
kvm_s390_inject_vcpu(), which is called from there, needs either the
kvm->srcu or the slots lock.

Fix by taking the kvm->srcu in kvm_arch_vcpu_unlocked_ioctl().

Fixes: ba5c1e9b6cee ("KVM: s390: interrupt subsystem, cpu timer, waitpsw")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 518a69c55e85..02c5428ba239 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -5444,6 +5444,8 @@ long kvm_arch_vcpu_unlocked_ioctl(struct file *filp, unsigned int ioctl,
 	void __user *argp = (void __user *)arg;
 	int rc;
 
+	guard(srcu)(&vcpu->kvm->srcu);
+
 	switch (ioctl) {
 	case KVM_S390_IRQ: {
 		struct kvm_s390_irq s390irq;
-- 
2.55.0

