Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490383B0AD6;
	Tue, 11 Aug 2026 15:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462672; cv=none; b=DayfE0mLYJGlPrxBcndO+POafSZjaYoawp63cm+eyGNuKRWH4v4oJauY4Gfu8+dB0l3nJuX4DolWLagYb5E66x5bPUFnjN4YbCL8Ht0Wf4uoOTXyMsta26GYbtVRdbIfpb9PT7/+Z6JrMK+aM5lT7xAI9G4zjudfqkgsIPU50H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462672; c=relaxed/simple;
	bh=6i9bR6LxT/EwJpH5Ch0OnJrdrUsbjsrLT4zfZ31efSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LfJwJvd3e2MH93DUGtQcO93cXTMTiQx7/BhOdoMTbSFX8ZEjD2zX9zRnLAoypFpUpfn5SttME5w+NH11QVtJ8XWncJe1KesQSg7tLRZ7/cvMA5eu6tIbLpBdHArE00gylTon1sq8pOB23kq6JVtAxcDAG10o1m8q+xMqIveuUek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BctHBEqc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BctHBEqc"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDX6HB3634503;
	Tue, 11 Aug 2026 15:37:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=d2IpKARu4Lwe4wuPR
	Pa4AazU4qvkOIuLM2TrLvwsOJw=; b=BctHBEqcEq/BPLDuYacWhq9TLrwT08jBq
	yyIMfKE6sygEUaoEFIz3lS3FC7Lz+45E1uul3CJ4jNdX3OjdY4eJ9idDqoaMQYKU
	oLqwcVUUSTwWwKFvjbHa5l7s7MxQn7iOfbvfjSu+7+3yt8AwH/llblvYEgTg9bL5
	MXvoh4v/qm+hUcPqbYOsnO+iGzJJTrllX57RwkGI0n1UP8Yn3HpK+JwTPZkfYqZd
	bfTecV+ea6QMCVcVLXcMLOWFl0eHi/jkxgztjTiWrdopY2BEvx2tH3dd61mfMIfQ
	g+PQPrr7WYLSZQx52GTkzr+MNhV4a/XsJiqr8n36utmk4qLrToCfQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23pdqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 15:37:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BFQFNC025183;
	Tue, 11 Aug 2026 15:37:47 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq1pn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 15:37:47 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BFbkmb14090964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 15:37:46 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B07258063;
	Tue, 11 Aug 2026 15:37:46 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EA775804B;
	Tue, 11 Aug 2026 15:37:44 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 15:37:44 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: KVM <kvm@vger.kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH 2/4] KVM: s390: vsie: zero stale crypto bits
Date: Tue, 11 Aug 2026 17:37:36 +0200
Message-ID: <20260811153738.206885-3-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811153738.206885-1-borntraeger@linux.ibm.com>
References: <20260811153738.206885-1-borntraeger@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7b41cc cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Fyo0vC6UC5SsdFAQcwQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEzMCBTYWx0ZWRfX/SZig5FPh7yn
 Yx5fcWUXrWjDgm/ClaPB4Ryh2tJQ5qkBO3i6ThdDISHGMcTs1bJa+UTKfS7iaBEv2UJ8xWJEzfn
 B3Os0zHpKMigsLzMgJjqvgiq12wl2JItXtEKVH673mpN8QCC167Q8l+uHaMGBustY8jjGorsNvU
 R5QmV8pLWiDMB/F0hF8zZNUG+xVZoJKTx8oO9xPdNc59u0vFYUmpIEKPb9GBKCTDoVZz1sm9d06
 QflbIPalorz54Kzv/KvbRSD0ajJAZXzx6B6qPBY5JL7isImJLl6NFCCcMViiEi5Z5V7mYpTIrna
 NJrbT5bTKmfqv0MMCNnvK1TgdMsMUcFELdaDQqL45mvfT77/0/hiAwCKemjlYALAvYsNzx/fYYE
 H6vqkajXBIDd6rnjLqkGarVE3Wk1RLuIrSWLmCQsyKlHtaU1cBQTtZXkmrvu3KVSm6/7Wxou2Bo
 ZgGxFA2laZ9AAYOQhmg==
X-Proofpoint-ORIG-GUID: 42FJS5hHtS8ixqamOlFAqOFwolkfuO91
X-Proofpoint-GUID: 42FJS5hHtS8ixqamOlFAqOFwolkfuO91
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEzMCBTYWx0ZWRfXziL1/XIx4VvN
 iRbNlQt6HK13UqQiwmHfyc2HQOIRo/j6wwCSJLXErB+T2F/w87C4oo9NwmX24K6kBfTni8u6gVX
 ITWn4FWTP4eeKip6JE4V7eCJ3fcqFF0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110130

When shadowing crypto access bits from a format0 apcb (crycb 0 or 1),
the bits 64..255 are unchanged from whatever is in the vsie page in the
crycb and thus in the apcb. This gives a nested guest potential access
to a device no longer available. Zero out the remaining bits.

Fixes: 6b79de4b056e ("KVM: s390: vsie: allow guest FORMAT-1 CRYCB on host FORMAT-2")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index f546239d8ff8..7971947d2fe5 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -172,6 +172,7 @@ static int setup_apcb10(struct kvm_vcpu *vcpu, struct kvm_s390_apcb1 *apcb_s,
 			    sizeof(struct kvm_s390_apcb0)))
 		return -EFAULT;
 
+	memset(apcb_s, 0, sizeof(*apcb_s));
 	apcb_s->apm[0] = apcb_h->apm[0] & tmp.apm[0];
 	apcb_s->aqm[0] = apcb_h->aqm[0] & tmp.aqm[0] & 0xffff000000000000UL;
 	apcb_s->adm[0] = apcb_h->adm[0] & tmp.adm[0] & 0xffff000000000000UL;
-- 
2.53.0

