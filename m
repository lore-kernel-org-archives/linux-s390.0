Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75B8308F32;
	Wed, 16 Sep 2026 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789571672; cv=none; b=TiIsnMINGe0ZFV4M7uwXtNSptbDhv3gGFVCg62DzhIUY4qooEJS1UKXH+6nFkbxMBvxt5UXT4KJDatzNjlipEAVCm1HhoApu02xLZDJx2O0Bqf9qv2F8HLSaCfWtACXAAWGIOUfKR7QqUndtbZD6jsfnjWezUHct7OZWt7AJO3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789571672; c=relaxed/simple;
	bh=1p1ezVUBsMBCHSYxKoKl6T7Osj7Yd1vgZzdUMde5lXo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Q14Of20GRergfmGcuS3V/XK4nSsQ0Blki7fRCFeT4EV3qExgx2TbE7F7M90r3BloMIAOPK9YOmKDq4mWfidX5dxJwZb0EXAIlEHA/65q1T/ApdXy5uUpFLaBKqQY0AaH960SVfuxkCN1jJGDZd4MDsXMED1Lu16tUTNxtI3uz2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WcddZwEl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WcddZwEl"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GEVnoG4007111;
	Wed, 16 Sep 2026 15:14:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=fX/zLYi/lOqeZC2K4PzIX8OfWiaM
	5cfY5ikurnE0X1s=; b=WcddZwEl8X+QWO1XfW20S1pb9LbChv2AqBeAizOJqgrj
	Aiul4Rc6jBxArn8kz6jQ/tqy63wK6RznFCV4BQmeZyX1WLk+54GjeHtoHmxoEGmQ
	UuF5EoyYqrvOY35L7n7pfju5EGjPRLX0KQt62Lp4ZPjvwpQPom2uPbVmszxch1ta
	g7cPxmaVjnTuqA5fnWb6Kh4zHA4FFtb59ns2T3EJafxnhSfgSYQqgftOUvaEGjKZ
	OrPsMPNs5+8WhFvIHovgeko8n6whsPqey4fvuJ8Dc8M7iLbyrABeih5HkTIQbkdV
	QUZnd9fe61AgmR+V4EA9TCv1usK5iB2029hlX3evJw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx83wavs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 15:14:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68GEaBUX1571757;
	Wed, 16 Sep 2026 15:14:27 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gq03bxwqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 15:14:27 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68GFEQo030540294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 15:14:26 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3713F58053;
	Wed, 16 Sep 2026 15:14:26 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 099BD58043;
	Wed, 16 Sep 2026 15:14:23 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Sep 2026 15:14:22 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH v3 0/4] s390/pci: Fix some zpci_report_status() issues
Date: Wed, 16 Sep 2026 17:14:09 +0200
Message-Id: <20260916-fix_zpci_report_status_pdev_leak-v3-0-61a2f980e71d@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5XOQW7CMBAF0Ksgr2s044AdWPUeFbIce1JGhSSyg
 xVAuTsO6qJiRZd/pHn/30WiyJTEfnUXkTIn7rsSqo+V8EfXfZPkULJQoDTUaGTLk70Nnm2koY+
 jTaMbL8kOgbI9kfuR2CCgx5ZAoSjMEKn8PCu+DiUfOY19vD4bMy7Xf+AZJUrdNM5oo6qww88Td
 5dpzc157fvz0veL1W9iW6O3CtpNAF2/YMvarP4u3L2BKgkyOPAb54wH717ReZ4fNfj7vHYBAAA
 =
X-Change-ID: 20260817-fix_zpci_report_status_pdev_leak-1b101c1fe021
To: Gerd Bayer <gbayer@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        Tobias Schumacher <ts@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1792;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=1p1ezVUBsMBCHSYxKoKl6T7Osj7Yd1vgZzdUMde5lXo=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGLJWbfJuV7yQ+u7Dy0vOW3fbl977yHXJ/8FhjmRFm71Xy
 rb2RpZf7ShlYRDjYpAVU2RZ1OXst65giumeoP4OmDmsTCBDGLg4BWAi53oZ/tkefWu0TmyeW/h9
 IePvFfzFGZ7TUoy+rkm0OS5wwpHt1HKGP3xeDc2vb9x/k3mp/cwU/aKfdelNF/M4934J9I/2DdR
 ewg0A
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDIwNCBTYWx0ZWRfX63Lfm374coQ8
 LC5SB1lsJEEUADbNsAonKfyuWwL5/kuvmAz7OvoMif+DTBGhlgsTMOPrgGFzK8lKjPAXL8xkALO
 OT9u7oXRDmDccdOacRz9Y7Athtd7XIREZ+lcIqH3aI9RrMkhPsMWccTRf8ayEDTqp1HTaqTiwn3
 vMSLIAATv9KEddlOdYi7WTSoDESBXKyrbMYQo+TWl6UVnlaOcjnUQonZ9Z5RZ5/mTuvRhzmtFDV
 9GECNtTUUHfe/9iu6KNwdsZvKXLk0vRgSjEJZUBrQrqxwA8apx3Jwl7CAtpb6XFU3A4bHzhIijQ
 MhCbllUOAa4bRw7TfzgwqphQKj3YgK4eKOG68UrJft4vffihSeFRHHw0ES1RYcaJYuQJL1Tancy
 ZZ+Lgza+Dtt+SRRJmz/Sm3YBAgPP4d565lwUxyZJgiaSRrlubUazG5vjMLA9N8BqJqjV8RupHDt
 zKjQqzIWai3otYYPxLg==
X-Proofpoint-ORIG-GUID: 3y-K-BLgoi2br0XSDExaMMFGopur2XqR
X-Proofpoint-GUID: 3y-K-BLgoi2br0XSDExaMMFGopur2XqR
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDIwNCBTYWx0ZWRfX7yAQ50wfUxK9
 ONjvj+kMLiSp8uXNgbvbqb7Wh9EyVNReRUMkgUkAwm12yDDY/+0LmuCztxYNsLDnRB/RtviPgmv
 jhpDJf8iWHIZenGDWLxAVTXlxNx0AVE=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aaab254 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=OKVlucUIemUWJsn_snAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_02,2026-09-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160204

Hi All,

This series fixes four issues found in zpci_report_status().

* A missing pci_dev_put() (patch 1)
* Dropping the device lock too early (patch 2)
* Missing an error report when there is no associated pdev (patch 3)
* An inconsistent error report when skipping recovery on permanent
  failure (patch 4)

Thanks,
Niklas

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
Changes in v3:
- Change in approach, pass the pdev as a parameter
- Add a device lock assertion and extract a helper function for pdev
  specific status
- Also report the status if no pdev is associated
- Fix an inconsistent report when recovery is skipped due to permanent
  failure
- Link to v2: https://lore.kernel.org/r/20260819-fix_zpci_report_status_pdev_leak-v2-0-da0c4aa7c0ca@linux.ibm.com

Changes in v2:
- Added a second fix to address Sashiko's finding of having
  to hold the device lock during the call to zpci_report_status()
- Add R-bs from Matthew and Farhan
- Link to v1: https://lore.kernel.org/r/20260818-fix_zpci_report_status_pdev_leak-v1-1-576520f4d068@linux.ibm.com

---
Niklas Schnelle (4):
      s390/pci: Fix leak of struct pci_dev reference in zpci_report_status()
      s390/pci: Fix missing device lock in zpci_report_status()
      s390/pci: Report SCLP status on error events when no pdev is associated
      s390/pci: Don't report recovery success on skipped recovery

 arch/s390/pci/pci_event.c  |  7 +++++--
 arch/s390/pci/pci_report.c | 32 ++++++++++++++++++++------------
 arch/s390/pci/pci_report.h |  4 +++-
 3 files changed, 28 insertions(+), 15 deletions(-)
---
base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
change-id: 20260817-fix_zpci_report_status_pdev_leak-1b101c1fe021

Best regards,
-- 
Niklas Schnelle

