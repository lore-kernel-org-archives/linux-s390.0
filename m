Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6DB74C14;
	Thu, 11 Jun 2026 15:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781193297; cv=none; b=G8oXivHxmxq7a1Iyp0gZG7BSwZv07zI6RVctWQLE7yqOb6Num+CbE3TP/79vEd6xjvngao0meT1yME8z6eJ1d5PbvaYhvMF421xTP0yczNYR92qKtr9oBjcaJTanBRDJhp83WuKkwtwMRw0YYzST4/3NefdonK94LPImBegp8es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781193297; c=relaxed/simple;
	bh=dHKRynQfCneGHN1b2orgyMbGe8U1QE7E4jJ+GPOrrKk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pNRXz7UV5UkLXruQs+GPAFzvzHt7ihB4IP5oAUQEfKdoj5ZJHk31qhCf6OszKcIGEVquAeTyMsjCjcAXt0c3zYdYYJnzWj8F5xpH0LP82u17DY2fCDI7lXHz40otv6hh4CEsaAYsaX4Od2dlj1p8gz+FLL2uVjW6XM3MT/xl/4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H7qB6JoX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H7qB6JoX"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BBV4Uo722342;
	Thu, 11 Jun 2026 15:54:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=nRNTI2RxU0RDA/sQd35Jz8tg2giE
	EwGOiXAp4Sf8qsE=; b=H7qB6JoXvZps0ijHVemJnro4YL9ovDWCF4Db2WwYgO60
	Zq8t+hmbQ0jwdHGsjZpxKKoKFJey0A1s2Sjqr+lsDmcO+iNrVHtAgueAuSvu3A75
	06t/8O5GJeIUTUu+CZsQdGWZDCnNTb72hKrMro4Ta3QdRm/UhpYJWpBhCOxnlom+
	M8yDGUcq/S5zVdht/eSuQ/Y4Yn40ilMQ4rJxfaSOQpAO93ZMdPgbGzYFJ69BXZ/q
	G4g/9zmiqTcpHKB9xvgiYkHfcuCNKa0vwuyi8vJOQTuk5mRThnDQ3cX3c52HGBjF
	woOIGjffIifZCGoFV2DlgiTBDSENuJZTUFvDfWNNEA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8dcprw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 15:54:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65BFo2nU018612;
	Thu, 11 Jun 2026 15:54:54 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eqe0a3v6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 15:54:54 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65BFsoOv61800784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 15:54:50 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64BC72004B;
	Thu, 11 Jun 2026 15:54:50 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D955A20040;
	Thu, 11 Jun 2026 15:54:49 +0000 (GMT)
Received: from [192.168.88.52] (unknown [9.87.150.222])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jun 2026 15:54:49 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Subject: [PATCH v3 0/4] KVM: s390: vsie: Implement ASTFLEIE facility 2
Date: Thu, 11 Jun 2026 17:54:30 +0200
Message-Id: <20260611-vsie-alter-stfle-fac-v3-0-b1a35efedaba@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XPzW7DIAwH8FeJOM9RcFEoPe09ph2AOKulfHRAU
 Kso717aXKapPf6N/bNZRaTAFMWpWkWgzJHnqYTDRyX82U4/BNyVLLDBtpFoIEcmsEOiADH1A0F
 vPbhDh0dn1FGqVpTRS6Cer0/267vkM8c0h9tzS5aP6g6ixNdgltBApzU60sqqzn4OPC3Xmt1Y+
 3kUDzTjHwjbNxAWyEhltPLOIPr/0LafG+h3KZ9P+83C2UhQ3kdOpyrruoHgdWne7gTdjlMxAQA
 A
X-Change-ID: 20260129-vsie-alter-stfle-fac-b3d28b948146
To: linux-s390@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>, kvm@vger.kernel.org,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1660;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=dHKRynQfCneGHN1b2orgyMbGe8U1QE7E4jJ+GPOrrKk=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFlatzz7Ykqsej6e2nH+451VHe/O5llf9/kSxhHKNfvm7
 GrznwZ7OkpZGMS4GGTFFFmqxa3zqvpal845aHkNZg4rE8gQBi5OAZjI1j2MDGveVXaGfb26UfPp
 vCszQlV0F2W4vj7yvLSs2KSs2TS/eAUjwze+T5bt6reE+R5qzREQbm+xS204E7xWy+XahXe7RDn
 tmQE=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE1NyBTYWx0ZWRfX3MueowV8+qM2
 EIiMpckcpKib+ip+9rYqJiLbIMqiBd9IWb2YLWMU1w/intF+KxOudCfjlju67Tey4hYb9w8CNpD
 Sn2P5DzICHfgWkSkVaOQOsYxSAOL6Yk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE1NyBTYWx0ZWRfXwaxl4K6VRRs4
 KET5dnGN2MEXOL2SjrKs8XWbgbR9oxds5LbHsradfx95tbrPVzi3ovT7jO5JNwK1QP2GrM29ala
 lLA85V/r1ByqBm9GaHQwCG5h5MmtPVIUdIZ3+fFJQcZjEE3ysmIwuAF8QL3h+cWM9pE/xdrU8d7
 q7HRF+jhI1RXgPSXpQIC8W4vwRSqHqRfVKH8sydeFTd22Vb5+KgfZqp2koHWOdMvzJVjaHtRmMP
 y4eee/i8l3NeSIZ4qHWFpxu+RcjBNHTf+Hf7spTjHM1DM8/CGvkgYG4J9q2dpkh/I+64+rc93TX
 ixG5JP9LO90J/wwLcosu9FTMKHXQqnETfVSmyESlDtvkX5jWqV9BGhspEXTyXhgAHBiSOB7lM2/
 RZCrUxO8iafTFlHAaj6tuSwzBJ/ffQBwGo+peSckZke9HMRBd0vFvlgAMX0G7vEqyAFjstqje+B
 kfhZWr1pJiOf8QAQ1Tg==
X-Proofpoint-ORIG-GUID: AJI9Czt80ZoUXJuZ67XRhFCi3Vt9HsNb
X-Authority-Analysis: v=2.4 cv=GIM41ONK c=1 sm=1 tr=0 ts=6a2ada4f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=JTEGq0UErLZmNMgf6yQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: AJI9Czt80ZoUXJuZ67XRhFCi3Vt9HsNb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_03,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110157

Add support for STFLE format 2 in VSIE guests.

The change requires qemu support to set the ASTFLEIE2 feature bit.
ASTFLEIE2 is available since IBM z16.
To function G1 has to run this KVM code and G1 and G2 have to run QEMU

Tests are implemented in kvm-unit-tests and sent as a series to that
list.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
The series was originally developed by Nina and only rebased and
slightly adjusted by me. It was not sent earlier since the accompanying
kvm-unit-tests and qemu changes were not ready.

---
Changes in v3:
- renamed struct kvm_s390_f2_flcb to kvm_s390_flcb2 as requested by
  Janosch
- rebased

Changes in v2:
- adjusted variable naming in handle_stfle()
- add some constants for readability
- add struct for format-2 facility list control block
- rebased to v7.0-rc1

---
Nina Schoetterl-Glausch (4):
      KVM: s390: Minor refactor of base/ext facility lists
      s390/sclp: Detect ASTFLEIE 2 facility
      KVM: s390: vsie: Refactor handle_stfle
      KVM: s390: vsie: Implement ASTFLEIE facility 2

 arch/s390/include/asm/kvm_host.h |  7 ++++
 arch/s390/include/asm/sclp.h     |  1 +
 arch/s390/include/uapi/asm/kvm.h |  1 +
 arch/s390/kvm/kvm-s390.c         | 46 ++++++++++------------
 arch/s390/kvm/vsie.c             | 85 +++++++++++++++++++++++++++++++---------
 drivers/s390/char/sclp_early.c   |  4 +-
 6 files changed, 99 insertions(+), 45 deletions(-)
---
base-commit: 0e5d0a0b5ca6ea4e391d6786266405c5871e0151
change-id: 20260129-vsie-alter-stfle-fac-b3d28b948146

Best regards,
-- 
Christoph Schlameuss <schlameuss@linux.ibm.com>

