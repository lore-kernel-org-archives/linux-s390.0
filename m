Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6C73DF000;
	Mon,  4 May 2026 15:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777908041; cv=none; b=uZg2MWSaf+ZcJ9u3VJEArpl3xzL1miglF2YmqwPgVYZRUzAHbjlJAzjLQtCF3rVmAKoN5vsmrFij9Cl69xQoEvk2Wa3xh+Y/n6sKB9oRYyZH3MFO0jF7PSMLjwybn3k/5kiTke95qQkAJHYTunIbLACNZk7MIZgo/c2l9VF8CXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777908041; c=relaxed/simple;
	bh=VW9MbggZaTnhPi6UE2dTfTjui1YE48HTiFjW1+HjGnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ccBUUwL2UJP8FLLfUIKepL9TecXerSzfzsDWZPvNkBtsKbKnmNYt3k9i88gAfdDqUlcOTfQ/1P+3b8X/cWThVdeqTU6K4DxHt43VFzgptyFagAeeUdYE2H0X6DPcjEB82aH3D/+3UAxASUJoZxujfHbnbDL+IjvQWMFjuUlIefo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D/cWJzVB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D/cWJzVB"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644887oN1494000;
	Mon, 4 May 2026 15:20:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=H5qt8yY/bScOiqGmG9UXWl3Wj8l0rGlgXkWYLweyz
	ps=; b=D/cWJzVB9q7krhy0WOihnH9UEJb+7BZ7gI8BQkf927I6tb6cWgdHOZbI7
	1r8KQLUuYYljJWYL2soQzsTlxs50FOJEXl2AmavVv8XcTRUC0/SoCKC6WyJAhL4a
	BIv7CXinl4rpgBok1whA3J4mHcTtDtj5eCBStR4rJT44DQBD93e3PsdlhrAzK4yw
	DBiZGuwXuTmwzrR/WKAmh8b0VUNtDkuAnGCzr4VgMb40izQDKhn1fCPhx+T9XTzn
	7fUd06W3SViryYfMXwdQ2Lcd7CEihbdINvG4/ZSsadjoxqhE1ifpWRIxHeot9K6w
	muyVCOijw+3aOtlqop2zjbeNJAcdg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w67g2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 15:20:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 644EsTCo008945;
	Mon, 4 May 2026 15:20:36 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuyvwt4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 15:20:36 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 644FKZad30802600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 May 2026 15:20:35 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C0A25805A;
	Mon,  4 May 2026 15:20:35 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4063358054;
	Mon,  4 May 2026 15:20:32 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 May 2026 15:20:32 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
        Junrui Luo <moonafterrain@outlook.com>,
        Yuhao Jiang <danisjiang@gmail.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [GIT PULL 0/2] KVM: s390: pci: fix array indexing for master
Date: Mon,  4 May 2026 17:20:24 +0200
Message-ID: <20260504152026.587578-1-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69f8b945 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=USlA6pr8Nzz675HqiGAA:9
X-Proofpoint-ORIG-GUID: oC7enURaRBHrrrUj_GRzFuiBRmeLoY3o
X-Proofpoint-GUID: JqFRZWTfHrNXqCHxv8k4Eohn_dqDfuHp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE1MiBTYWx0ZWRfXyC5xAHsP1tdu
 T4MUrmNrARyhkaKAvD3nQFT662DE4hZs5au/hJuixJUPuSMNlgt9wb7V7PtUHIgwyas+mW42q7Q
 FDzGdojqf3ICMunirrsA843K0JyK1ZhU+e3rhuF+s+bY1lX76hIcUU3n463CgTPNCjquboLsHKd
 oGtLbwqTDmAdxVgaTUD2Elefe1em0fFYgoyz5/1PAgfA5lpZz4st5hF8M9eWPsDLWLoD4MRkOPF
 ta6OEdNb0v2lLMylIEIznJwG8H4D7mc5kmC5v+7snESGpSKMl2Ejdtj17AKjJfp6STyNOi87vV9
 nQDeFirpRRaAlMlhlv6fKb6/kJI5Krj805xVqub3xkw9R6WvI07um0WsDWFI4DzpILLEGlY7MAJ
 uXKtGIXB3uSMazFMimypTDb9EWwslmy4CYAPMoqQz8pP3rPlMnvznhX5uy6jZ38cAT1MsnKefN6
 QnC5J4ZOPPREMqtqRvQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040152

Paolo,

The following changes since commit 028ef9c96e96197026887c0f092424679298aae8:

  Linux 7.0 (2026-04-12 13:48:06 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-7.1-1

for you to fetch changes up to 0cfe660559e857d7c00ab86c73e4510ce069086f:

  KVM: s390: pci: Fix aisb calculation (2026-04-27 11:14:45 +0200)

----------------------------------------------------------------
KVM: s390: pci: fix array indexing

For large amounts of PCI devices its possible to overrun the arrays as
the index was miscalculated in 2 places.

----------------------------------------------------------------
Junrui Luo (1):
      KVM: s390: pci: fix GAIT table indexing due to double-scaling pointer arithmetic

Matthew Rosato (1):
      KVM: s390: pci: Fix aisb calculation

 arch/s390/kvm/interrupt.c |  3 +--
 arch/s390/kvm/pci.c       | 10 ++++------
 2 files changed, 5 insertions(+), 8 deletions(-)
