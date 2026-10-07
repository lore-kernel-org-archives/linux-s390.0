Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0645C469840;
	Wed,  7 Oct 2026 11:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791371280; cv=none; b=Zh6DrWW6PEiBPcFf3Ayr8lSCy6WLgUqs9+NTyN1Z6Q8oG4Y3CnsC+aO/vvf0rPAegcxGqe39A6s9x5VerdMLR5hruyftf/aGnZISHq40Zxi6gDQTnoKhJgqA8v+AmbX6uSYPYU2gHUXoA0emWxRypTjO+6itV9W2F17M7qsAT50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791371280; c=relaxed/simple;
	bh=LC1sbm6aIzFKWIvYJ5Pq7gsmG9bIkBDroGBXIvXe5DI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iQ07Kd9ewcggDPUcR8847EupefS4HSywUiJho7PfCLE4IvOmX42nNM2SFmghJ0L7257oPZD568xSNLS69vYjCcUZpXmhfr8+EUGT50qXEmFZ07tOpjKCeVpl0maecsWfDLBO1j8vvScmBcMg3RSh4ti5nQtSDSf3QcP0YDzwYjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FK1xmZ6C; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FK1xmZ6C"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69785TkU1949135;
	Wed, 7 Oct 2026 11:07:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=FW2Z3zHj6y08wOh+B9CYxoIef/P/
	YUVE4X3vE3UID60=; b=FK1xmZ6CdI3B+lOAxEIfxCBXIxWnS+/W2easCx/5Gvt5
	8LnFyYb6cMlJ4qa3juv1FPbUaaP2n5GeuiomY7yAd7OgYRkhnvJ/Dtw6Xzfg6Y36
	2SgzP+wlYiD1UEQMU1ymegDEOozNSog2TD5yLElW9SkHAFXU/+zj8Q1OfTW/78mZ
	3OqgcOY3VmYSzl4zHTHU5873RlNYTQU1FtNjITVwX07g/1LL3u/av484zfMJZ65E
	89oFXRvk/dsemM2FkbXBcCOsDX41OMaF9KmMyKNyUvPk1oFs/z/4L/93fEb7y1Ev
	3c/3wLLWcStyAK2YWDf36aHHMv1+CCFt5jlhU0Xzag==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2se5n0j6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 11:07:10 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6977lpcm1590533;
	Wed, 7 Oct 2026 11:07:10 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5a6dj59m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 11:07:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697B76NT47776076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 11:07:06 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 525E920043;
	Wed,  7 Oct 2026 11:07:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C68602004F;
	Wed,  7 Oct 2026 11:07:05 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Oct 2026 11:07:05 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Subject: [PATCH 0/3] s390/pci: Updates to PCI insn tracing
Date: Wed, 07 Oct 2026 13:07:01 +0200
Message-Id: <20261007-rpcit_trcfh_upstream-v1-0-8a2718cfb90b@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBM0IaGrRITZTM2iktEiiO6et
 HyL/x9IKIwJuuoBwYsTH3uBqSsIq98XVDwXQ6Ob1mjtlMTAecwSaB3PmLKg35TFlryzM5GZoKR
 RkPj+t/3wvh/8uz9AZgAAAA==
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0NCBTYWx0ZWRfX9xX+PfwG80FV
 e+Dcsy9h4/Svr7wJOdk9iC1jZufpw6xdLlQoFJwmsExgypanfIN7DsHs30kaScvNrTZsPGxpyB8
 fVIHm/WZ/pkmanJSAaqJoLQE98JLaNY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0NCBTYWx0ZWRfXw9+3g9FHKIkC
 21JMw9Xc50BEiaHoMZKTY0QO+uF0+udpLHZzanTUR69UlBJBx/6LzhR54kvt61i5R1WokOaxjhF
 sZ3ogX4Yf2BUazFV7f1xCS18UIwTkLcDeSXdF0VPm0emXAYPRPmWwgcEts221sOYi9I8W+SZw5R
 wR3fE+m3LuMKUL340ShtPU6MaO50zrWAZdgFWlCmQLnFmIjbfP5Jbiisu3S0FqLaPOA+wRRE58s
 Ex+C9nSKXhYsUo62UPJqNpey7K/ThquxtYwW2iDQlPTsdQ1GcglXp/wOqRqlIwNrtg2L+OMov5e
 mNA9927Q5c9nUK4BmsUvocete1hNrqtfRddj0/0zwpAiIA2chnLKZ6cvLE/uMy2zfPG7YuCqqpe
 kKsZGvX08FroC+8zAY6+THjs91pRQsj0dHJcv+7CXTkMoNUTEpKvrDm0SgykubkGfpcVmJG0y3o
 fUepveEWwRvgF06swPg==
X-Proofpoint-GUID: U984cgkh54MAL5ZQC8G1i1QKx7wNiUT3
X-Authority-Analysis: v=2.4 cv=UNRIjyfy c=1 sm=1 tr=0 ts=6ac627de cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=xIqyEUT4ZkeEuoJ0Q4YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: U984cgkh54MAL5ZQC8G1i1QKx7wNiUT3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1011 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070044

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
Gerd Bayer (3):
      s390/pci: Adjust alignment in insn trace
      s390/pci: Use 32-bit fh outside of inline asm
      s390/pci: Add function handle to RPCIT insn trace

 arch/s390/include/asm/pci_insn.h |  2 +-
 arch/s390/pci/pci_insn.c         | 43 +++++++++++++++++++++++++++++++++-------
 drivers/iommu/s390-iommu.c       |  8 +++-----
 3 files changed, 40 insertions(+), 13 deletions(-)
---
base-commit: 602042bf29f6efde39cfb5fdd9289bf4854bc0c5
change-id: 20261007-rpcit_trcfh_upstream-3e6fa73dff1b

Best regards,
-- 
Gerd Bayer <gbayer@linux.ibm.com>

