Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AB23E00A3;
	Wed, 19 Aug 2026 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787129475; cv=none; b=qX6p1wiNmZAmgJop2HU9fA5tcbzgTDFuex9RrbTcDUHnH8vuQz/13ZbiK640172BwkqrjDvp67Psn/3Tgxlse/hf6sUKOA2vx3Ey7Tq7CQ9GooJWB8kxZowkEsIMpge/a8QRaxCG0p5XTV7/qSUZwwtBXzQvPuBA+0u5Qr6v2SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787129475; c=relaxed/simple;
	bh=aJ6pmYa2zILLkOeAGufe0tdPCgl08f+LYT0tlCMOLwo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cLDE7zh+dwaI0GXzgZvVXOFNafFOAmwvYWVmPC+UUCOdYjn5dtJP7ovzcf6M+Gb1F/U+EmgkXO4gbutuzDqPQKxTdeaiqLCLdXjt499a7kqWGafF+c9BNQbEZXtATveOHND2RDR5ermk7/ZtJOOowt6Obk477iLD6yJZJb6axEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ph/tMHer; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ph/tMHer"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67J6WBrR1544898;
	Wed, 19 Aug 2026 08:51:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=2TGvNgyrtzK7UXc0FNGHaEtOmkmA
	/eNpfu4EF54Xoqg=; b=ph/tMHer0Hps5aj04w+8wRCcjkud6vG/ly8RTYS58SS0
	s2X+2Lq6KApNqk+OTsHnQ4ZbegbcXY2pdlVqJOnT5NN/6kvECPkwLzTQdoWAaVaz
	DPrgIuoBBhi9RkUK1J33odPGi1sMyPhzoLacFDQYJbOWgDT/+FtFggCQu+RfdxF/
	KH7zaL6LVnp3BdY0qdhACCCosGq/V6rsxmKcsFmX7vWToLImJUljyQGpZbSGEKb8
	aCwG//uQun2IhO/v9uOsKAXnHU5LyIIl9fBDC+ZuyjAXYguYsU0OFNbPzNaN4FA/
	ck2X9YUTgzE8ZLHd2lErg1oGt1NLPBrFQ9uM4Y6k1A==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu22jvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 08:51:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67J8fQNM028228;
	Wed, 19 Aug 2026 08:51:12 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xh802a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 08:51:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67J8p8vh46006570
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 08:51:08 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B68E2004B;
	Wed, 19 Aug 2026 08:51:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D980620040;
	Wed, 19 Aug 2026 08:51:07 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 08:51:07 +0000 (GMT)
From: Tobias Schumacher <ts@linux.ibm.com>
Subject: [PATCH 0/7] s390/pci: Fix multiple bugs in IRQ domain migration
Date: Wed, 19 Aug 2026 10:50:53 +0200
Message-Id: <20260819-s390_irq_domain_fixes-v1-0-826ff27b6e97@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3LTQqAIBBA4avErBM0+79KhFhONYusHIhAunvS8
 uPxIjAGQoY+ixDwJqbDJ6g8g3mzfkVBLhkKWdSyVa1g3UlD4TLu2C15s9CDLKxrykkrXc6VgvS
 eAf+Q1mF83w9VL+IRZwAAAA==
X-Change-ID: 20260818-s390_irq_domain_fixes-ad74b3134c51
To: Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tobias Schumacher <ts@linux.ibm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AdqB2XXG c=1 sm=1 tr=0 ts=6a856e80 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=3HiOTyqIYLVXQrBT1psA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: WyPUQaEM5JZnjQPckS3lGfsZGaN1SjDR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA2MyBTYWx0ZWRfX9wyAp44URMvE
 VDAuexBl8jqQoDoc7QRlaXe13rHIOhJZ0+pE4IxUdHasnZtzrCugI3/klezmtujEW26ypaTaPoK
 HtenLEbMQkIjsaAluXJY8Eonvn1kGLacE9w9ml3TtU5+lMbTZE0fg9xL1u1fQPydcA54EFtK0KA
 kyOpjWb0Js9MTYbVCOJxA9L5blDQjkqFabj3xH3Q/4mqH1bKgEb4fsPCmQUvDbMnSKZmexU3lEY
 YvMINxPE3872jJvqh6IeMkg8cS3C2u5mSoIqjsatDMEExvbnjD25SvvHN4mAsF6z+e1hWEjjJ9G
 lWR0GU+j3NwtD0ID2P40slZFSqWdlqUCKFvHuc1jV+JKPrTJMaXUL8Oiah0tgbu75+xoYjzcfUk
 ml5cpY25DzfoiVzOxpfEmiPR3ucqyCkQjoLWatigXx+n9GK5PQcebYfjVGyQ0Irq4YPmDzcNmV1
 C1jtaLwDiFipzarcOag==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA2MyBTYWx0ZWRfX9g4nTcgJyX29
 RUJJGtUVUQr+HPWvTuKbQDlqp+MZE7LFPyMDMuODQx6HJzkQlA8VvKPAQ3joAURb8iHTg4Or8Zt
 Ev6a+0M0qJvc8dbAOmeso3xh5kQxB+0=
X-Proofpoint-ORIG-GUID: WyPUQaEM5JZnjQPckS3lGfsZGaN1SjDR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190063

Commit f770950a4709 ("s390/pci: Migrate s390 IRQ logic to IRQ
domain API") introduced several bugs in error handling and cleanup
paths. This series fixes these issues:

1. Null pointer dereference and double-free in MSI cleanup
2. Use-after-free race in floating interrupt cleanup
3. Resource leak in MSI setup error path
4. Wrong number of IRQs freed in directed-mode teardown
5. Missing NULL checks in zpci_msi_clear_airq()
6. Resource leak in zpci_directed_irq_init() error path
7. Inefficient MSI affinity flag initialization

Patches 1-6 fix critical bugs that can cause crashes, memory
corruption, or resource exhaustion. Patch 7 is a cleanup that moves
flag initialization to a more appropriate location.

Tobias Schumacher (7):
  s390/pci: fix null pointer dereference and double-free in zpci MSI cleanup
  s390/pci: fix use-after-free race in zpci floating interrupt cleanup
  s390/pci: fix resource leak in zpci MSI setup
  s390/pci: fix MSI directed-mode teardown IRQ bit count
  s390/pci: add NULL check in zpci_msi_clear_airq()
  s390/pci: add error cleanup in zpci_directed_irq_init
  s390/pci: move MSI affinity flag initialization to boot time

Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
---
Tobias Schumacher (7):
      s390/pci: fix double-free in zpci MSI cleanup
      s390/pci: fix use-after-free race in zpci floating interrupt cleanup
      s390/pci: fix resource leak in zpci MSI setup
      s390/pci: fix MSI directed-mode teardown IRQ bit count
      s390/pci: add NULL check in zpci_msi_clear_airq()
      s390/pci: add error cleanup in zpci_directed_irq_init
      s390/pci: move MSI affinity flag initialization to boot time

 arch/s390/pci/pci_irq.c | 59 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 46 insertions(+), 13 deletions(-)
---
base-commit: ff35cca8fb33b213bb41a20d7ed27ecf0fc3152a
change-id: 20260818-s390_irq_domain_fixes-ad74b3134c51

Best regards,
-- 
Tobias Schumacher <ts@linux.ibm.com>

