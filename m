Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793983808;
	b=KHUGWlSNivrMoDRQegHfGEjH01Do/9UBG8HUqEGcyTgawpfOzQCO6mb9ff1rSd4ADl6f
	 UfltK0TbIpaouzDz9XxEEKR0FaOEkqNgixPDI4CNvUQYUgmJEa74O+t4+yNSyqe6rYm3p
	 th/pxPB6reirRVOvsxZzb7sJ9NGgbXeyblIhdY8baXlHyQ2FoRAMtrehIiT0v887gSuEx
	 FDHkRloMJ3lr/49xUuFFH3d3ejgvx6IQh0mP3diEPF0EtGs8CK+Q4FlAov2ov7cyXQwcH
	 OS1Xh0fnr/OFGGZbczM9IJCaBzrIaDnjET9bmutK+xBX3bp42ITKjANFAaJGlty4wow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793983808;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=paQjkQrQQW94ZvW+h44oeqzgRXsZAX5n4GZxeDDAzG8=;
	b=YxJKxrCyrmIcErC/tRCg7Plm5Vcs6qgRK46GfryFRjn1i3Mj6SyG4KMbDGKk3xim/U2S
	 gepYGbiHORuw0lVICUQzkcgAiCSGxwm6Il+QOHe0IkJD4wXjHNh9UIFhCbcsqWb8lWHOj
	 FX/UvidseSbl/iW1puDKEPrWevOFDGHzEGsa1C8sjynabO6XV/4JEiZQlzkJ/zUx5MgJi
	 +9ZoV3Sg8QUnh0pH6NYfEE57y69DwjcYBhLUcpJOHNCt7/ZJin83IrUZUdlDRF92aYULm
	 yVD2aU1/Hohlj7HGmJADO1VwI7BZQS49fECIbg0clifyw6S3J7T/cQruvxlxS1IcTOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VLEDx9tW;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9583E606A32C;
	Fri,  6 Nov 2026 16:50:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9583E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VLEDx9tW
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FEEBV1544346;
	Fri, 6 Nov 2026 16:50:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=paQjkQrQQW94ZvW+h44oeqzgRXsZAX5n4GZxeDDAz
	G8=; b=VLEDx9tWLU8viSUJmF8D/QufAYyCym0U/o76mC1Lf8yCQzJl6mqpHlFm/
	XuL26IJ+qfgfEnDsN5nZuc2Y7OaoAUx21bxySRdmQJ83fvJt/kMqvbLESw3uMgFg
	xJ82hCMQGkEPMbr/H1uDOCg+0LJw0/IiFFJ7TQlILt/RgSckPctsk2vcKcbJ1Xmj
	tSVJRMX3/bDYD81Zvguto8Ka6C1L4WU7UPVS8TM+kmOFJE/NfBvFx5LGpV8i3Hjj
	SmrBoDO0TXSuOdR4qz8i9uYnKJ4ys7/81WqgF+iNu8vwENgr2+lCO9BCXeqkJDXn
	iGYLJk1+vcrizHcbhResm0zPLOFbQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rbwvqj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:50:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F4s2m3476003;
	Fri, 6 Nov 2026 16:50:03 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hrmret5n8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:50:03 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6Go2vM27656942
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 16:50:02 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B5875805C;
	Fri,  6 Nov 2026 16:50:02 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A581558051;
	Fri,  6 Nov 2026 16:49:59 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 16:49:59 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Steffen Eiden <seiden@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>, Marc Zyngier <maz@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [GIT PULL 0/6]  KVM: s390: Fixes for 7.4
Date: Fri,  6 Nov 2026 17:49:52 +0100
Message-ID: <20261106164958.431978-1-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -bGH9AYsbcw1H0kTaAyL9FdiNB3UsDAL
X-Proofpoint-GUID: -bGH9AYsbcw1H0kTaAyL9FdiNB3UsDAL
X-Authority-Analysis: v=2.4 cv=MqLHeGae c=1 sm=1 tr=0 ts=6aee053b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=c92rfblmAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=m3AxwWjehh6Nn5NoYwgA:9 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2NiBTYWx0ZWRfX6teWx3Qc8HTy
 yo1d8ghUT5MT2/nGDzzNrnZ51IHg1j6YxfcE2zsXnYlJPU97hZNL7cQJow3XxJg8EA+QAtqujxF
 nrDSZWPkn9lYHZEmiKFUHAZfOr6Yfbk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2NiBTYWx0ZWRfX+SQLbjWWKw6/
 YSBcVHKYOEKVSHSxgE2jgqrBALJg8z7y8w0zUyXd3OVpqSq4nKRSBVKzm2iKuHid3cPjRmnHAZk
 HraPdCs5aoHzMn94nq8qPUwMcPWR1lNMCxXGCnQWPyvM9hPhvYXIpCI0P9sKDw/v88/rPyIsO4+
 Rr6k9GCCGa4crifHBJdrKKh/vM4IOEbZq6KmUkQ5GuXNrQrPaoiE0TJR2pngWr5+fdpv10+37uR
 6iTBAupEH5Zs8DpvDvMhfvV38TUJ/EuGSBtk3NeLylz0rOXjb8ybcNbJ5towuV6eHPSLC6UJ/OD
 etjZWsPWLsCKfTBdZnJKxGIxJ6rDSCAeG5b/HuewAu8HpL1cOkBurccLY2eGK79qWF7oI/a5Phw
 2+R4ASiZV9vJ4aJTaTSk76ISz/EABiHrN44ZBv7/4b+GjleMxIcLOKTYMpEfEGn29yhNBmiQi6q
 rIgNZnnMyg8BfNvmIwA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060066

Paolo,

first bunch of fixes. Some more are pending for the next round
but I have not fully processed those. Those will come next week
depending on how KVM forum works.


The following changes since commit 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4:

  Linux 7.4-rc1 (2026-11-01 13:26:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-7.4-1

for you to fetch changes up to 62aef2c04e0e69a9b88affa74ff699ce5c4e8652:

  selftests: drivers/s390x: Select uvdevice tests using the target architecture (2026-11-05 16:40:22 +0100)

----------------------------------------------------------------
KVM: s390: Fixes

- Fixes for the arm layer
	- sashiko: https://sashiko.dev/#/patchset/20261103-s390_arm64_kvm_fixups-v1-0-21c36fedd878%40linux.ibm.com
- Fix ESSA instruction handling in migration mode
	- sashiko: https://sashiko.dev/#/patchset/20261015104822.77062-1-ggala%40linux.ibm.com
- Fix crypto instruction no-hook handling
	- https://sashiko.dev/#/patchset/20261020082534.481867-1-ggala%40linux.ibm.com
- Fix selftest for uvdevice

----------------------------------------------------------------
Andreas Grapentin (2):
      KVM: s390: arm64: Declare enum vcpu_sysreg
      KVM: s390: arm64: Fix kvm_arm64 module naming consistency

Gautam Gala (2):
      KVM: s390: fix ESSA addressing exception injection in migration mode
      KVM: s390: pqap: fix AP status written to wrong half of GR1

Sasha Levin (1):
      selftests: drivers/s390x: Select uvdevice tests using the target architecture

Steffen Eiden (1):
      KVM: s390: arm64: Turn vcpu->arch.pause into a counter

 arch/s390/include/asm/kvm_host_arm64.h                |  8 ++++----
 arch/s390/kvm/arm64/Makefile                          | 12 ++++++------
 arch/s390/kvm/gmap/dat.c                              |  5 ++++-
 arch/s390/kvm/s390/priv.c                             |  8 +++++---
 .../testing/selftests/drivers/s390x/uvdevice/Makefile | 19 ++++++-------------
 5 files changed, 25 insertions(+), 27 deletions(-)
