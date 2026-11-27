Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791867;
	b=BWpyy7mB2GFNwla2N3XiJ8xEPbm2QE8YHSPVdpn68vC70fB0diqoW0BB40UZHNhsA+7o
	 LbOKf5b5W9oU1kdr3baWwS3nLsXtxzg9HFj+1YVc3w2NXb0JU9bsM9McBiwJGPqtJsH0h
	 jAT1TAuH705ho8T/LlW20YvmxsH5CnoJT4V1YcwMSNjllAAkUqA5J1QZNF4hPLpg8AY/4
	 FXvAx82chmipPCLyeyG4aLEIT2UI/meEZWiF00AjIdemqiW+okHHSSstMrwSjtGeG3soU
	 dZlI1OjkAkvrGLaLGm1mvr8orHSJfC+9xLpjnF6kOTAndCSAMk507FQK4BA6a00u8kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791867;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=qcRu0UZntQESzj+psftC3vgwYdnKECf70+9qC9fWNkQ=;
	b=tb1+DfyPqBIFACKBIpcDqCLpFMigkMYI1t2NtBOE/Zhc6p+YDDZy+3mNnTINAI449HjL
	 eGTj8+BHcFLMQ+aN38bz7cAGpNUYpOQ4sbZGNgQM8ffnvzVbqk3ebspOLEVQqzCbRbRVq
	 +Ms4CTWz85KqMJFXECPwSF62KnibND8MZYLPFKZRJCyXr9IuKcxidCs5GOps2wvVprgKi
	 WrvjaLFY4gk7xDWo7ogPeT/m1xR1V8jtAri1czqr3oNpT+QAHYDliSloyZRfIWEcF5uLP
	 CWNBzSqkpvONpw3ka7guGRtPZqFQjXFwEk8vpc6Zs5nI8Uk2VSVfgTevgmva6mBD8Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=X5TsOBg6;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3161F606A324;
	Fri, 27 Nov 2026 15:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3161F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=X5TsOBg6
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4XR23419261;
	Fri, 27 Nov 2026 15:04:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qcRu0UZntQESzj+ps
	ftC3vgwYdnKECf70+9qC9fWNkQ=; b=X5TsOBg6B8x9vi2J8NPQhK5mg27H2qvPe
	qhuhXSAE1Q64NL7aY/rDb7J+KTGuuJEHfE4RNXlfVZrDGDoHYr/B1KCSyLO1o4A4
	S93znwjVFDPnWVcbrQEDYgTGCNjqrPZGPagN98pbsTYLPo5eq671E8Xkda6PeDTI
	M5CfH8m6Eiv58qiIHSXm8VuLE8XODu2uN0mGJxXf/lhSi+N7tOyjhzndSLl0FAOH
	LiualVmTjJKCZuna3RZPpcR6brtItpyAQTrkjF2/dwX7+j8c+diGE2UtIM1qvS2B
	ggkSRK1/kkpe0MLkyQCdF4DljEI276SMpMaP0nvmtOVX8QvZ4Ww7Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fapd60-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 15:04:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4HrZ861613;
	Fri, 27 Nov 2026 15:04:20 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j6mjg4h2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 15:04:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ARF4FbT43254240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Nov 2026 15:04:15 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 052A220065;
	Fri, 27 Nov 2026 15:04:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FE5D20040;
	Fri, 27 Nov 2026 15:04:14 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.43.64])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Nov 2026 15:04:13 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com, seiden@linux.ibm.com
Subject: [PATCH v1 02/12] KVM: s390: Fix potential leak in kvm_s390_get_io_int()
Date: Fri, 27 Nov 2026 16:04:01 +0100
Message-ID: <20261127150411.221072-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127150411.221072-1-imbrenda@linux.ibm.com>
References: <20261127150411.221072-1-imbrenda@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1OCBTYWx0ZWRfX/BaTiubVLMq/
 rcl6df5LJXIr9x2oVRKynvFCR91FO/gdHjwfvxjaN2k46JpFdSp9r+qT+MG1D7RVT3rmXB2S4XT
 zO2XRTcQvL97xL1Io/WseFyWai2pdkkOD6qS+2Iyuqve09a1MjKf37LiZVV3notuCviZADCGy50
 7pkPh0UvH3XGy0ScF0NDGO7Z7w7L996NyNZPT3T221fCQMnPxNJba11HA5Hanxz97BwHWLmOqcz
 ulvCjSEvpG9PYb3FCuE/5MNxkbGHHJYmptAoWqgynZZVfnp9P5hs4D9zJbuDYfqLiRYd++oRExc
 VR9ZHPHH4A2ZVDe3wrIAj/h00UzT1xuloG3jha44wAK6NF0KTMVS6baPwOQJxhN7+qCJDNXCVQo
 Bt6isf/52AEtcdH1DaWttHvAUhtEvouXFdEyqdUH6lzS9ehz7ckXtsA7EAggOBXCxYuP30BIrde
 7QpeYgDzUnO+Q0txtmg==
X-Proofpoint-ORIG-GUID: 3dqEz_BvJw8E7ivXWE9mzlEo3BgLxk7k
X-Authority-Analysis: v=2.4 cv=U6QHnuru c=1 sm=1 tr=0 ts=6b099bf5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=uSsWUpmC0EzC7tkxtUgA:9
X-Proofpoint-GUID: 3dqEz_BvJw8E7ivXWE9mzlEo3BgLxk7k
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1OCBTYWx0ZWRfX1o1wAuyJESvW
 WLNhLwF0Al92Xm7S2ps0wphoe+oukHTDsi4vO+pcGWlcNRNHhNrNbR4tfixJahwY0xPiE5LKXvS
 A5ejT5bGKXdSA0NyehQtSWdKklKitKw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611270058

In case all of the following apply at the same time:

* a higher priority GISA interrupt is pending
* a lower priority classic interrupt is also pending
* the pending interrupt queue is full

then kvm_s390_reinject_io_int() will fail, the classic interrupt is
dropped and its memory is leaked.

Fix by checking whether the reinjection of the interrupt succeeded, and
free it if not. The interrupt is still dropped, but no leak occurs.

This is not expected to happen during normal guest operation, due to
the large maximum size of the pending interrupt queue.

Fixes: 4b35f65e67ee ("KVM: s390: make kvm_s390_get_io_int() aware of GISA")
Cc: stable@vger.kernel.org
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/s390/interrupt.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/s390/interrupt.c b/arch/s390/kvm/s390/interrupt.c
index 31a6074feffc..33672f093322 100644
--- a/arch/s390/kvm/s390/interrupt.c
+++ b/arch/s390/kvm/s390/interrupt.c
@@ -1775,8 +1775,17 @@ struct kvm_s390_interrupt_info *kvm_s390_get_io_int(struct kvm *kvm,
 	if (tmp_inti) {
 		tmp_inti->type = KVM_S390_INT_IO(1, 0, 0, 0);
 		tmp_inti->io.io_int_word = isc_to_int_word(isc);
-		if (inti)
-			kvm_s390_reinject_io_int(kvm, inti);
+		if (inti) {
+			/*
+			 * The maximum number of pending interrupts is so
+			 * high that this is impossible in practice during
+			 * normal guest operation.
+			 * Drop the interrupt if the limit was somehow
+			 * reached anyway, and free it, to avoid a leak.
+			 */
+			if (kvm_s390_reinject_io_int(kvm, inti))
+				kfree(inti);
+		}
 		inti = tmp_inti;
 	} else
 		gisa_set_ipm_gisc(gi->origin, isc);
-- 
2.56.1

