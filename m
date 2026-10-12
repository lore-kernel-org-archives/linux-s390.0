Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C724C488D8D;
	Mon, 12 Oct 2026 14:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791814935; cv=none; b=Ah1yB8VpfI0tjiN92QUaTFH0PddQQ5+BgPydnSSe98Wk6sCIVAYD0l/l1giTXpnWB85LmHqhh3IHXASjdGeD52wWHIlwXkj94xWRWnDWBrFIV5lCeKC+k6kUiezhcS2FiW5n2a9nK3kEh8C8EjBWwYKyiz2EHDQhaha+rFq+Ltw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791814935; c=relaxed/simple;
	bh=JoqrmNeABnn31QnE9zJgIazKzg+uzkE3NvbM67uaMJ8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=U17Vjw5SsgWpOBu/UDL3vl1z41W/UJBkxvZfiDvLJ/SA/e0U24SnccOWNhJNNb5hkyktD9dw8paBzWKPCxrn6uqBadQDTQprFfFpB6AsL3X7sQVpG6RjEPHtQKwyJdDgmZvwjESRhG2ebw4O2yT4nskGkLW9aa6N94I0SS7JAqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WS3OC05s; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WS3OC05s"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCEE0d3209697;
	Mon, 12 Oct 2026 14:22:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=eFa+XD8VIJCS0lMBNDIBLvGZ2Ddh
	37GmTwzv2TdBOz0=; b=WS3OC05sjHLS8WEHBS6tER/7PGn7GFGNgKmr74tznvMN
	320/N28RUEndsTas5kBimdUc5GSKqyALQ5+5ua6AsZGFD3prES+BpdgMRLG4Z/Xa
	7quUCfTGnUd3W9z74KKEBCCnHGgUbXJEHokeW9DXt4/E/pP/TopD33er8FBxntK7
	A7uqZW3sysc/BBOZY8VCL99bts1M58TBZJzn0NPqWuZmeg7noJ+1wY7w0DTP6vkE
	5YZhZRFE6pJZ0ccNqyoGUQqcqsGELJTPp0ukE+BZCXzyqCSQODL7cRl/nmmHlUkP
	4xkHRI94RSI16wE6FyKuXS9LjIJ6Xh2DYFDOufuTAg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv090sk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:22:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC55la1238606;
	Mon, 12 Oct 2026 14:22:05 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h7yppnp6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:22:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CEM2R349086860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 14:22:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 108B620043;
	Mon, 12 Oct 2026 14:22:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D0C4520040;
	Mon, 12 Oct 2026 14:22:01 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 14:22:01 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Subject: [PATCH v2 0/3] s390/pci: Updates to PCI insn tracing
Date: Mon, 12 Oct 2026 16:21:48 +0200
Message-Id: <20261012-rpcit_trcfh_upstream-v2-0-1812db73dfa5@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNWwqDMBBFtyLz3UgSQW2/ug8RSeKkDtQHkygWc
 e9N3UA/z4F77gEBmTDAIzuAcaNA85RA3zJwg5leKKhPDFrqUklZCV4cxS6y80O3LiEymlEUWHp
 TFb33ykKaLoye9ivbtIkHCnHmz/WyqZ/9E9yUkKI2ulK18/Yu7fNN07rnZMfczSO053l+AdGDz
 K+8AAAA
X-Change-ID: 20261007-rpcit_trcfh_upstream-3e6fa73dff1b
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX7C/U3RVHnHzl
 mVbpGoC063G7wPBhmh6TNYuY8eNbkzm7b3+wz8otg/i2FW0yLVsSMMibYB69RsKBr8WZ4JhjV8C
 bjZS9VRrNtaTLBwnCEDnGyXz9VRBrM/qIR0hFvYlq9VzhtEDxKnMLZiv+06Z8lnu/Tfs6yoXemF
 sUqty2/E2OceYWmBqDHBfyUcYgH+u/ndCU1MF3Rva0QG6siMWZV87T7crXswe+5w5U3eLHyd4Bh
 2UwwaTTUQRxr12/LAAvfhYbjjqc6Ky7E7gMTTWo9DyCsE7TsXUV8Qq1nWe9hnAXDHi3pnneuMEb
 DYNoq84gnI61WOavaQs61wnQcSgqbutvJAC6snLgX4p0xmahTwYTKZm52jnxNSpDD0Q6KIZCAPS
 Q5JPQPvj4snQ9UXppYhQxdm/KS/fuAel3nb5hrCDu/raJ2E83OODq2AuDfVqT6+6c8Ae+yW6FWo
 io3qiWjEZ82i9WS5oSw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX+CDJ5ofEyNMT
 wLLZUiuGsK7QsLNburaAbsE6EkXe0u2o4Bv5PftJxPh/UJd7mp/0PCxumXzYLAKEfAIZ+4B9ySM
 1gd3TUbySF2wB5uQ0LbtVz6+zypQL7Y=
X-Proofpoint-ORIG-GUID: k-08AosCLcGPOIIerYh0tDQBydaPQ6Fc
X-Authority-Analysis: v=2.4 cv=a6KlZkSF c=1 sm=1 tr=0 ts=6acced0e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=xIqyEUT4ZkeEuoJ0Q4YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: k-08AosCLcGPOIIerYh0tDQBydaPQ6Fc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120056

While debugging some issues, I found that insn traces for RPCIT are
lacking an indication for which PCI function translation tables needed
to be synchronized with hypervisors and/or firmware and that the 64bit
address fields are traced at odd addresses. While looking into how to
address this, I found another small oddity in that the code leading to
the RPCIT instruction was expanding the 32bit function handle to a 64bit
value for the inline assembly way too high in the call-chain.
    
So I started this small series to address these three issues:
1/3 - Insert padding into the insn trace at natural boundaries
2/3 - Pass function handle in 32bit variables as long as possible
3/3 - Introduce a RPCIT variant of insn trace - adding function handle
    
With this series applied (+ a test patch to trace RPCIT even in CC0
situations) an entry in /sys/kernel/debug/s390dbf/pci_error/hex_ascii
looks like the following (removed time-stamp and ASCII transcription,
replaced instruction address with "<IA>"):

 2 - 0001 <IA>  52 00 00 00 00 00 00 00 85 00 32 2e 00 00 00 00
                ^  ^  ^                 <--------->
                |  |  Status              function handle
                |  Condition Code
                "encoded" insn

 2 - 0001 <IA>  00 00 00 01 ff 04 90 00 00 00 00 00 00 00 10 00
                                        <--------------------->
                <--------------------->       IOVA range
                      start IOVA

I hope you'll find this useful,
Gerd

Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---
Changes in v2:
- 1/3 and 3/3: Replace unnamed bitfields with named dummy members for
  padding (address Sashiko findings)
- Link to v1: https://lore.kernel.org/r/20261007-rpcit_trcfh_upstream-v1-0-8a2718cfb90b@linux.ibm.com

---
Gerd Bayer (3):
      s390/pci: Adjust alignment in insn trace
      s390/pci: Use 32-bit fh outside of inline asm
      s390/pci: Add function handle to RPCIT insn trace

 arch/s390/include/asm/pci_insn.h |  2 +-
 arch/s390/pci/pci_insn.c         | 42 +++++++++++++++++++++++++++++++++-------
 drivers/iommu/s390-iommu.c       |  8 +++-----
 3 files changed, 39 insertions(+), 13 deletions(-)
---
base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
change-id: 20261007-rpcit_trcfh_upstream-3e6fa73dff1b

Best regards,
-- 
Gerd Bayer <gbayer@linux.ibm.com>

