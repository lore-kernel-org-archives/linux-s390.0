Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2685548EBEE;
	Mon, 12 Oct 2026 14:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791814936; cv=none; b=I8F5c07UslN8K+7yI2yHsZjiYYzPLiaju3xab8XaUm62w72vjh4uakg6ZvBKOIkG3vOvXy4VgfpkKkksmodUPRVWWSHVRlxYrkX3BbraevhSPtCYUHMd9Oqu3HYmpjI+yPigm0PE+lKsGxTRMy+KKMd7Ypp1C5W6ucBoJOncYVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791814936; c=relaxed/simple;
	bh=//6DzEGwaaaDvO6HsLFzXRJFsSQGHveSISHA3SvobjA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ci3lxzKOSumdUPW+tPNNsIRBx03KAJiadVAdExDBqD17ib9zoEYI/17wSTRqZ0Kx0M+KpyDBe2wiHxPzmARil5e4cmpWedXI9+gGGqQz00CVJe+QUWAiknx7Q8+NCmI3Ni8oGs2rwdfco7RQhDeZPvqLk5lGSBw/6N+m5Ks1l1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Gxz4G0ER; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Gxz4G0ER"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCE8c42640427;
	Mon, 12 Oct 2026 14:22:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Kp0dKn
	oKHIVDPObnuNhB5RsSYY9QQREqwD5OUz2Cj0s=; b=Gxz4G0ER0Hk8gSreF2NzFV
	QX9WIQ7vadwmuX9X3s/qoLN83zpa5IsvwmjrC1yt6v9svaHNak+2qYU8mSYJzGZv
	ozs4bd/8qBbaNsrFuOwgh+CekJsNTlm7mW646rjcPCx6I/nj03pK8w9ORN2yvFix
	aflKUl+g5D+BLebZw6YVvct0OsZIgpHrqGdPqDPsIHR/ZMYKi6XTK1J4YMDIyp7g
	08DLiVuwU7dLXjlFmT0uCXEOUPv8HK+gsvSWtLv2hj+3yg9oLfRlzfmBUcn9xPK5
	txJ7TfT6AgfZVch3ZepBVNbl4gzG1Yw/OMu7LOG9kqiHpIyQVDDwb1DNkB7V1FVg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwh9aye-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:22:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC50911287103;
	Mon, 12 Oct 2026 14:22:06 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h816gwf50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:22:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CEM2Gq49086862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 14:22:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45CF420040;
	Mon, 12 Oct 2026 14:22:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 140F62004B;
	Mon, 12 Oct 2026 14:22:02 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 14:22:02 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Mon, 12 Oct 2026 16:21:49 +0200
Subject: [PATCH v2 1/3] s390/pci: Adjust alignment in insn trace
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-rpcit_trcfh_upstream-v2-1-1812db73dfa5@linux.ibm.com>
References: <20261012-rpcit_trcfh_upstream-v2-0-1812db73dfa5@linux.ibm.com>
In-Reply-To: <20261012-rpcit_trcfh_upstream-v2-0-1812db73dfa5@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfXzf/c/u8AnKyO
 mep+SSxZFiejHeciwnnucDDP+nERBYT6yYyhue/L4YUfkbMImKGgdc5KzJ79et/L4wm7BCTjv3X
 un0dSWcxpr+WSBm2bOlmnvq5+3FpwT4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX+8iZ7pZoV4HC
 qEFCyfeEDZ/qzuPiwqukyRxHGdvPEIC9pWgLjkXyPo4OgxwW5hkqsg6JRVPozaAARZnCvlKCt72
 ssn+Ofovdg0RhATdCaSrZdZ7mfggzlDRXQJxAyEpAV8+db/TYhWiwcEQiIWrr6n+OIS4s1F6rQj
 +xSN9ufqTmnnmK2pThHr+b8cIfAKXd9g7F049f9yudk9TW5M7ry3ZrBX95WQOmExsjFhEsUEBYI
 jiGEf/0TP8t9UARloBfFha38KchJ7YiY2IvSKiuCEzya1E+J9AQ7TZXSNqyNUb4rFtMPtg+HwEq
 bI+E8ZjJtQcZ58QDyf1CDYjER2dUt295/f2PsnQH4H1/KJsk3tfiUCQ2RHTr54tJub6qWgyU8QQ
 5xgi0AArHGsI29tKjR+yxgqTFz2Yvm6ADiyn3HJzqsSmt62GkAoj3VSOuEoVcjBUhyPlHGzXClo
 48Kw2SEZb8ceXE3B/qQ==
X-Proofpoint-GUID: KZtf8oXs7DJJvQluifOC89ahWZnxhLSf
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6acced0f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=Dtsizi7wGu1GIzxuX8kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: KZtf8oXs7DJJvQluifOC89ahWZnxhLSf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120056

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
 arch/s390/pci/pci_insn.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/s390/pci/pci_insn.c b/arch/s390/pci/pci_insn.c
index 35ceb1bea1c6..1089b539aeb6 100644
--- a/arch/s390/pci/pci_insn.c
+++ b/arch/s390/pci/pci_insn.c
@@ -18,11 +18,13 @@
 #include <asm/asm.h>
 
 #define ZPCI_INSN_BUSY_DELAY	1	/* 1 microsecond */
+#define ZPCI_ERR_INSN_DATA_SIZE 32
 
 struct zpci_err_insn_data {
 	u8 insn;
 	u8 cc;
 	u8 status;
+	u8 pad0[5];
 	union {
 		struct {
 			u64 req;
@@ -33,7 +35,10 @@ struct zpci_err_insn_data {
 			u64 len;
 		};
 	};
-} __packed;
+	u64 pad1;
+};
+
+static_assert(sizeof(struct zpci_err_insn_data) <= ZPCI_ERR_INSN_DATA_SIZE);
 
 static inline void zpci_err_insn_req(int lvl, u8 insn, u8 cc, u8 status,
 				     u64 req, u64 offset)

-- 
2.53.0

