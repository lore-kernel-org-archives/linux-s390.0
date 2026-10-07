Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D82472521;
	Wed,  7 Oct 2026 11:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791371284; cv=none; b=Kv/Og1c2QAJbI9EoTB3WmlLcWs36EzYZ8WU7a0d/fMNXxGWw3AJwhXKo3bYLGl6whtNYJH1gDDPZR3TVKF3QsbKR4mQuu6el4Aoh1g8XgDTaS891eVXOqpHNWZuJpdd3LqaCYi2l2yy5Ssuip+BcefGJdti0/rXd1wn59kjnjXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791371284; c=relaxed/simple;
	bh=GHtOQVGG5txbspVyOzHHT5PcP4xDvK40IoAhSm9pUIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VU1B3sL5Fv+3JMH1U0BDZLUHC03aBCCoh+UHnwbBiQpQP6svE3qCv2rMVkcxuyIQHx0BQ4bIzu7EFSYnQh3LZ/KDPg3yKFyar8iSjF8sP1AkSNYJvHXfTehjSnxnlmeEIyrjA9HjNnmxhgj5dxihzr2AaK7erNzTSoNT+6WrgWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WEwJjBDm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WEwJjBDm"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69785WPI1827799;
	Wed, 7 Oct 2026 11:07:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=a0H8Td
	NyofCg8GbO/MDyZ8hcV0Ll6KVRadrRCR4ZqSA=; b=WEwJjBDmG0k+XrqwwgmtxG
	+LGy6TenS1tdxa5pbJ5on2BzVcXTN0MqZx9H7R1kjGORKb0A/b9nm+pljpU2M3Br
	FUMEVaflrqYPeTVEfrs2KA45OPGieZBYgdvZbhpIJshCO5tDjznuiQuGdZ4qtAb2
	3pUjNlcNR0KKdzDYrZhcIiGfuFwG+QudqIxFZy9LNECDZpDUq05XWEbfOXI7bnBh
	6BvhgCoH2TDIwv0clPcFPfGZ0tWM8aUDCp6J0agMp6TU0Rl5drDyCwM02w1p3z3Z
	Okum1kcYie9rBNRogByLNAaY90pQV8d70VjBo1UdcC7/b2bR1VoPQWbLBBeDzbXA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2q4jvfrx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 11:07:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69782YvQ1562552;
	Wed, 7 Oct 2026 11:07:12 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3cdvxbvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 11:07:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697B765147776080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 11:07:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA2B920040;
	Wed,  7 Oct 2026 11:07:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D3532004E;
	Wed,  7 Oct 2026 11:07:06 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Oct 2026 11:07:06 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Wed, 07 Oct 2026 13:07:02 +0200
Subject: [PATCH 1/3] s390/pci: Adjust alignment in insn trace
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-rpcit_trcfh_upstream-v1-1-8a2718cfb90b@linux.ibm.com>
References: <20261007-rpcit_trcfh_upstream-v1-0-8a2718cfb90b@linux.ibm.com>
In-Reply-To: <20261007-rpcit_trcfh_upstream-v1-0-8a2718cfb90b@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Farhan Ali <alifm@linux.ibm.com>, Cam Miller <cam@linux.ibm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Gerd Bayer <gbayer@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3H0Vuy9bleZfNlQrKOlJoX2J0h8jHMtG
X-Proofpoint-GUID: 3H0Vuy9bleZfNlQrKOlJoX2J0h8jHMtG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0NCBTYWx0ZWRfX6rP4X6eSJDR4
 4EXNOyv0Kh66bT+aprF7g1zpesVVwbiL8yahPvblyTq0OlKM0GBwCRdbjF4JNcDMwop4SxU/3Ai
 gQM4Z4M3fqXJS8OeDSeiIwcunGVqp2M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0NCBTYWx0ZWRfX3BiIillaSlHv
 1R05kAtCi9rXEsWKXQa/DFvDYd+69KRUBDPWb5lu7sJolDweQlCsBo0Ekv8ON0aHIva1bWQv3Kk
 O+Kxed2VUUxzHT74618vnP8H6S47qo04ZrvCPlaTQ7PaXjZUkdlnjk84AVYC6D1aKoH8de6ygxq
 k33fUC2tB/nvjFYSWzldFdWYjXkHt9fvDBBF6seyfpXpfUgwxmS6AVrcokrYWeINTMFGh1I4K0k
 PQd/g3ApWbVeNNNAGe2HEXuqgdEbWNsnqeBZpvnG7VQ839upe93trz1RgstcMYAwcgqtC1XTZGd
 ZvOTcfj1kypUpx2KG9YcO8Q5KrTf7TrJ+R0cHvla6jOfa1U58BrEZNOHipuceppghaJH67pFqSb
 +wz7o705dc0yWlcMjGMhvWtAeNiSg6nHTSWIfFuDc/NCB1Hyfuk7kEFrEa2mRkTJKzitW5LTBTh
 5ZH/M/rIoNFotsk9KKQ==
X-Authority-Analysis: v=2.4 cv=eYeo7LEH c=1 sm=1 tr=0 ts=6ac627e0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=Dtsizi7wGu1GIzxuX8kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070044

Currently we have 64bit wide fields start at odd byte-offsets in the
insn traces for pci_error in the s390dbf debug area, which are hard to
decode in hex dumps. At the same time, trace entries are padded at the
end.

Drop the packed attribute on the struct definition to exploit the
compiler's natural alignment, introduce explicit padding before and
after the 64bit fields for humans, and add a static assertion to avoid
accidential overruns of 2 lines in the s390dbf trace.

Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
---
 arch/s390/pci/pci_insn.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/s390/pci/pci_insn.c b/arch/s390/pci/pci_insn.c
index 35ceb1bea1c6..2ba787e2304b 100644
--- a/arch/s390/pci/pci_insn.c
+++ b/arch/s390/pci/pci_insn.c
@@ -18,11 +18,14 @@
 #include <asm/asm.h>
 
 #define ZPCI_INSN_BUSY_DELAY	1	/* 1 microsecond */
+#define ZPCI_ERR_INSN_DATA_SIZE 32
 
 struct zpci_err_insn_data {
 	u8 insn;
 	u8 cc;
 	u8 status;
+	u8: 8;
+	u32: 32;
 	union {
 		struct {
 			u64 req;
@@ -33,7 +36,10 @@ struct zpci_err_insn_data {
 			u64 len;
 		};
 	};
-} __packed;
+	u64: 64;
+};
+
+static_assert(sizeof(struct zpci_err_insn_data) <= ZPCI_ERR_INSN_DATA_SIZE);
 
 static inline void zpci_err_insn_req(int lvl, u8 insn, u8 cc, u8 status,
 				     u64 req, u64 offset)

-- 
2.53.0

