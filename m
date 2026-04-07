Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25D53B7773;
	Tue,  7 Apr 2026 13:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775568306; cv=none; b=RDg7xU0rUSVnb4KE7Y8Xi00Z6WFugE0cWPmJ8VFE7Q0aAnqjPuATplaqdpQaJLDhBdhMFOtCScQOCyGU+LowIlB5AbWwGmAzOIVD+xFi6Ba31uozmWoUG2GE832z84WqdylIbXJ3SoDxczk5PpAGkzafojxzoYf4qYpB0aDA9sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775568306; c=relaxed/simple;
	bh=m4FqDPseXDGM6dBihqc9ldz6B3kp5D91Y2h5l4NZBY4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=d3QCQDcC9d1J9V/AcrS4y9Gw6Z9OmibB0xld0pkxaDcTWO0z3bjsvwYipZV0K8bufyDbmASqnwoTBnscS71yUzSZZBP9i3izi2TMlcbNGeL9IjtzCS3miRzohpEiy51HHuDcOplL15YXHD0jj9kvDHyCFjFu3hFfJAwUR66NNYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qcouDLMp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qcouDLMp"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LnDLL2594684;
	Tue, 7 Apr 2026 13:24:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=5wGjoFUFgA8QutERY6Ui4UVpunBj
	gnp8KWmPJRuc/bo=; b=qcouDLMpW64H0m4HmW/qKORsXlXRZ4G8hyGgvuQCqKwu
	MUKfZSJOYjtZ//drIH7XjG7+mvABgY2RPbeV8mSLIEnhftubgWf+2s9O9atNVig5
	YRd7p2PNsHKbvh4CneZMOEgWAS/WWGDCmGWZdpQSUJOK2Ebn5Y/BAAfHjeRfnF9d
	15+5Kuo0pDCaTOXTOStX3rLzQOEBDRVZG8rQj7ESezc7bRXI/9CZ+AbGVrjappPU
	EEHwr1I+Ib4oBFLpUyspFEwv2gjTq+sdo1U2oSq7x+CbxQkSz2H8OmNWbL9y/yx4
	gNLOXPms3OLtfWtp/dgZu4PVpHqEJb9LPYQkDF9OFg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2e37mf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 13:24:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637BSJQs026646;
	Tue, 7 Apr 2026 13:24:56 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg7u9y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 13:24:56 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637DOTa729295218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 13:24:29 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3197E58060;
	Tue,  7 Apr 2026 13:24:54 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47B8B5803F;
	Tue,  7 Apr 2026 13:24:51 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 13:24:51 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH v8 0/2] PCI: s390: Expose the UID as an arch specific PCI
 slot attribute
Date: Tue, 07 Apr 2026 15:24:44 +0200
Message-Id: <20260407-uid_slot-v8-0-15ae4409d2ce@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJwF1WkC/23Q22oDIRAG4FcJXtcwHkbXXvU9Sinqjo2Q7JbdZ
 EkJ++51Qw8SvBFG/P5/8MZmmjLN7Hl3YxMtec7jUIbuacfiwQ8fxHNfZiZBIjip+CX37/NxPHN
 SiC4mjF4BK88/J0r5eo96fSvzIc/ncfq6Jy9iu22ELIILrizK6G1MnVcvxzxcrvscTvs4nrbcH
 6QfEDhPoJPuItoHtLUv8q9RAHQVlgVTkjKWw1otWlhVWGCFVcFaq851DqMIoYX1P5bCVlgXvP0
 ZBXTBG9fC+IsNaBAVxm1tq0CZaHVIpoVNjWWFDQfeI3nwQvd9aDbbGtdr24IJIVlnjZCaHvG6r
 t+ArArLRwIAAA==
X-Change-ID: 20250923-uid_slot-e3559cf5ca30
To: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lukas Wunner <lukas@wunner.de>, Shuah Khan <skhan@linuxfoundation.org>
Cc: Farhan Ali <alifm@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-s390@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1464;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=m4FqDPseXDGM6dBihqc9ldz6B3kp5D91Y2h5l4NZBY4=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGDKvsi4IzJlepeJ+9N05zsLyvkcHw7qelXyWsjtz6l1D/
 KErrw64dpSyMIhxMciKKbIs6nL2W1cwxXRPUH8HzBxWJpAhDFycAjARzdOMDIeWnHhsbmH2+VIW
 Q//rG0b39u4xuZa29IhIuWzA+sZzf0IZ/jv41ddz8TrLH5z7++2a6dEsyt3/2WZ/983UrzpqJ/V
 oDhsA
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: VRHWFqJtJ3OH1933SDmFMitzz0H_syEU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEyNSBTYWx0ZWRfX/GscMEf13mE+
 HzMy26cqUN2Dc9xsXpirmScr3ydMk/pvMLxuQtxofMm2aPou2EXj6pgu9dVa1T6rY7doN0LrY0w
 T414zlbCdPlQKPpyLlIRBTrvVl9mQSCFldFn3N5k9aKLON3gBxRa1/bLF0Fh/y6IGq1nvdjLH6G
 TW/eXbhJKeS70McxaBZW9U4Vm1zX69RnbIlmf4utCT0HJe6uNXLC3lajYJGjTMjGxhL3UYhMqrA
 HYPtE1jtEiygYRV8FUPfWgq+BDr64Cn9W1aRNAzL00cet8U6Q55xM3URtmAhCAvfHngHo3YJhDr
 ezsIjh2nsb1x9bAycWNPHv5+RQuxxlCjYITSZhR6rXEvOiJv4taP/5jg0145aP+uMU3R18xsElf
 KWdoZUtPLBP1+TtWyqLpVpeGqCZqcIOc8rkUymG2xOjUgi3bjdcZPfnatGSCg/dcHeb0Wg5e2d9
 3+D3wL2CpZTxbb5dXzQ==
X-Authority-Analysis: v=2.4 cv=Cfw4Irrl c=1 sm=1 tr=0 ts=69d505a9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=jVLf_0g3wJiVkyeFp14A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: MPwr6SlP2reP_7b4Q8ZuTJhVLBtnSnYP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070125

Hi all,

Add a mechanism for architecture specific attributes on
PCI slots in order to add the user-defined ID (UID) as an s390 specific
PCI slot attribute. First though improve some issues with the s390 specific
documentation of PCI sysfs attributes noticed during development. 

Also note, I considered adding the UID as a generic slot index attribute
analogous to the PCI device index attribute (SMBIOS index / s390 UID)
but decided against it as this seems rather s390 specific and having
it named UID makes things easier for users and aligns with the existing
separate uid device attribute.

Thanks,
Niklas

v7->v8:
- Fix wrong uid_is_unique on firmware file, it's actually "uid_checking"
  (Gerd)
- Link to v7: https://lore.kernel.org/r/20260407-uid_slot-v7-0-e50f7976124e@linux.ibm.com

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
---

---

---
Niklas Schnelle (2):
      docs: s390/pci: Improve and update PCI documentation
      PCI: s390: Expose the UID as an arch specific PCI slot attribute

 Documentation/arch/s390/pci.rst | 151 +++++++++++++++++++++++++++-------------
 arch/s390/include/asm/pci.h     |   4 ++
 arch/s390/pci/pci_sysfs.c       |  20 ++++++
 drivers/pci/slot.c              |  13 +++-
 4 files changed, 140 insertions(+), 48 deletions(-)
---
base-commit: 591cd656a1bf5ea94a222af5ef2ee76df029c1d2
change-id: 20250923-uid_slot-e3559cf5ca30

Best regards,
-- 
Niklas Schnelle

