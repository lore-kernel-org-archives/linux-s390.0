Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDE43EF650;
	Mon, 27 Jul 2026 09:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146061; cv=none; b=oi4jDCdQ/rd2GTDRysqE+EhWqnzAHsTr0Q+wJ1H+n9Ey6L6x+Q/IZqNAvC6sy8YJ9af+bI2wh/EnjltGKjxnPva6K3D+YhIXKuq96EQzdYFG27ypMK1ym4H2LL1ms0p1zaDrVa5ewsKzMbnPeh8rWyNvl9UMScQlvxzVayzfd8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146061; c=relaxed/simple;
	bh=70hka3mRMi1I3N1R+mXxU3jLbnTvik5yIwxZTt0gLLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sQyasvlCbq5Proaw1bx2pcPhKByxmnzF8ApvWvAoMxV05+hhBiHKt7WkitqxT2o47Z0nq7mXv3Ncd4E4oDFbXKMA/wZy7RdnEtrtzuiF3uS1nHrtAbkpfHArk9KmRA0HIqjHI3yHy+HNvWwDoOmLlbfT6e/E/0IaclUq49BJsnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oWT96vIl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oWT96vIl"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R9Uc5k4154296;
	Mon, 27 Jul 2026 09:54:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=qcA4SBAVWL7eknTizSaMZVJT6B8G52Ntmj3Ny2lyj
	MY=; b=oWT96vIlwMepqlfqQLarXfAPYi+etviRcI+bZkvbyHyCYpCn/L+sOQ9cw
	W1J1riYGl+YF8T79FL4hgjkkbYsJQp8syRFauRHbnwWeQie9Nkl5/SbIJIhQflmO
	oAlwfpioPq+W3OW+gliOOC+K6JPbtbdvmYpJWr9mf4vo/XEJEzZjOnIMOYSSJReC
	RAXmPg/2jrBDDW0+9xZxepLZq/zuS1IvFr2USjHfwoTPXWz2yZ4xBBAc4ik3gFbO
	OtPeKze5pWdGlwnavc1grJDkDE0yX/Vkq8Ege7jQKbhrfF3oT009GFpAzsqOYcoz
	elCAwowAAPkJZHxR/5CBCCikDwDZw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyc7b2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 09:54:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66R9fJFW016776;
	Mon, 27 Jul 2026 09:54:04 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fjvu9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 09:54:04 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66R9s3kn17367650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 09:54:03 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63E0358065;
	Mon, 27 Jul 2026 09:54:03 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2013158051;
	Mon, 27 Jul 2026 09:54:00 +0000 (GMT)
Received: from li-d98989cc-2c66-11b2-a85c-93ab83b7dd53.ehn-de.ibm.com (unknown [9.224.77.173])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 09:53:59 +0000 (GMT)
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Jaehoon Kim <jhkim@linux.ibm.com>,
        Douglas Freimuth <freimuth@linux.ibm.com>
Subject: [GIT PULL 0/5] KVM: s390: Fixes for 7.2
Date: Mon, 27 Jul 2026 11:53:54 +0200
Message-ID: <20260727095359.107671-1-borntraeger@de.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EBV_SOlC79ccKAoccEpA060mmW-JTfnM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA5NiBTYWx0ZWRfX4mOXgw+Zv/tA
 jmyuoFvEzLDQI4EBPA/yzMvy3Vtoo3VMl6JyK9o2rajLvLwjCuDsLpWSsjESA6odjzDCsw5xxBS
 VIwGM83hYeXTa1JI3Im/S3Lu0fw2Pq/pSRYlzlfdgVU07viFAGbEEUR6goRYiboF+xDRIiFhMBP
 gBfEBwlJYCRHttEBx/SgQNC/dq8BNBgxobczIOmB483kECq24HrQWM3XD4G0zxpH60Tqyzrh9dz
 NDPjtQr8ojAlOEj08E7ZRW/ldNK+rNcaDfz2U6hHyGiBoM2/z6+GM8oqN2SmPTbYI7VUTwYC0uq
 JZcH6XTWWPiNLbiBZe3QyWaWDovahQU+/ypUOYtrUEtEvON+zlKCZXHAvwWWs4qB73PGAFoB4e8
 1feY5de+qtcM06K4RAf/dWG6NtZCnSdQYsXDWvdMCoEKfwB/VG0RCPXXHYahkKOrVXg1Pt0yAla
 TvN38mpzIHEuXDPObaQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA5NiBTYWx0ZWRfX9V/E+eopYXqN
 amFXG9K5jO0rbq+0Ozd6V46HZ+ymu+mtGULxoOgMAG/Inpq8bOA01oja2lwnHfioBryUOjXVNCi
 etFgvgkGH39MU0pldIR2yjS1vP6amlk=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a672abd cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=n2cOJxejGmWVGDEj5nwA:9
X-Proofpoint-GUID: EBV_SOlC79ccKAoccEpA060mmW-JTfnM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270096

From: Christian Borntraeger <borntraeger@linux.ibm.com>

Paolo,

please pull the following changes since commit 8cdeaa50eae8dad34885515f62559ee83e7e8dda:

  Linux 7.2-rc2 (2026-07-05 14:44:06 -1000)

from the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-7.2-1

for you to fetch changes up to 3e3aa6da87d30a0064a17b836685cd43c90a3572:

  KVM: s390: pci: Fix handling of AIF enable without AISB (2026-07-09 16:23:10 +0200)

----------------------------------------------------------------
KVM: s390: Fixes for 7.2

- more gmap KVM memory management fixes
- PCI passthru fixes

----------------------------------------------------------------
Claudio Imbrenda (3):
      KVM: s390: vsie: Avoid potential deadlock with real spaces
      KVM: s390: Fix dat_crste_walk_range() early return
      KVM: s390: Improve kvm_s390_vm_stop_migration()

Haoxiang Li (1):
      KVM: s390: pci: Fix GISC refcount leak on AIF enable failure

Matthew Rosato (1):
      KVM: s390: pci: Fix handling of AIF enable without AISB

 arch/s390/kvm/dat.c      |  2 ++
 arch/s390/kvm/gmap.c     |  7 ++++++-
 arch/s390/kvm/kvm-s390.c |  6 ++++--
 arch/s390/kvm/pci.c      | 12 +++++++++---
 4 files changed, 21 insertions(+), 6 deletions(-)
