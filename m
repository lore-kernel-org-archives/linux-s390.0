Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24493A6EF0;
	Mon, 13 Jul 2026 08:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783931419; cv=none; b=P7ypEHnGABUlV1a0Vk1OBdSP6XAK6AaaxiMyPhjcbkPmrTpE4Iijhc6bB9azlUd3uwbLjtdUjvavkK2xpocQUMy5DSS8yeRQK4tq+9uz3HSw7vV1JVFq2pyRKisMCdYQk1R4MrFOS6a6VMUXG3r76oZoN5uIw55NQmMzOreU1fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783931419; c=relaxed/simple;
	bh=70hka3mRMi1I3N1R+mXxU3jLbnTvik5yIwxZTt0gLLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YXkZz2aXm4feBC1GnLMdrmioMvhDNnTKef7PKMQAa3Izn+TIB1T9cFTjSCQLpuIIALvewsj0/uoo4BFlIOIw8zRB+FY8ZqM2kFbhcMdz8eSmltX1iVgxGKiJBzEaFS7W7/eW8W7qRsLVYW/ZjYX4uWfREIlLnR8TdZweCAhmDnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fnUmcm6/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fnUmcm6/"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6fwrD1727468;
	Mon, 13 Jul 2026 08:30:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=qcA4SBAVWL7eknTizSaMZVJT6B8G52Ntmj3Ny2lyj
	MY=; b=fnUmcm6/UNpQNr6ItPPvpgFxPHmPt0F4CvgdM2G+nZ/crvjHRc6if5xp7
	VGnuM9sAWchORs+PPOLbJ+YS3HBwoK0s8WDFwb8rCbQz4hXK6wcc5v3Wu5pO0GTH
	zz2NDNbr9EdqxbpUPpBDm5aSfC3C1m8xKquApHnmcpKNsDMuX2hjrs0XejbrMt/z
	tZpgueR0R/Ffc+erPjHVfZqss+CSRdP8fEQi1dZGePtZaUKtLW61Tmtbj7JEAB5J
	vggp/93227eF6r8wUhMJ7WkZvlIr+jG1XCp/54HcO2DJvo7jZ3sxhgJPcNjO27mR
	PQqSbhdf6RL8+aWQ6l0wDg8+pmwvg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbepx7kv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 08:30:13 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66D8Jb2g015388;
	Mon, 13 Jul 2026 08:30:12 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05pvyvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 08:30:12 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66D8UBa222938242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 08:30:12 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91E7858055;
	Mon, 13 Jul 2026 08:30:11 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D17C58063;
	Mon, 13 Jul 2026 08:30:08 +0000 (GMT)
Received: from li-d98989cc-2c66-11b2-a85c-93ab83b7dd53.ehn-de.ibm.com (unknown [9.224.77.173])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 08:30:08 +0000 (GMT)
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
        Sven Schnelle <svens@linux.ibm.com>
Subject: [GIT PULL 0/5] KVM: s390: Fixes for 7.2
Date: Mon, 13 Jul 2026 10:30:02 +0200
Message-ID: <20260713083007.65863-1-borntraeger@de.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ePubta9obAzXh2W6wqBrw_9dQ0zeH5kq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA4NCBTYWx0ZWRfXxhH0iqYh4HjK
 ZNMd5lLUanGn1hikPjF/oi5db04/tEamDiJXIjMNEQqHSS40ggflAE75f0puGEob5tgGCJBYxDu
 NTtc9HU42vgDvXBmiZLLCWCJZlGdWJc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA4NCBTYWx0ZWRfX9+Be4IBskAjc
 kHGO2GP9BoOkUsJAlmg6MZM1B4s9FNhSbf+STWWHj8pjfvDtMXZGJYxhxD8qS0km9dZl1EonuhB
 T2ppd9IYJF2XHpOcQXfGyEMq/9Wv2T1HeiDcBA4rdqQOIIaTOTPFj/JGjMWEcVUFMlS0X3cbRrY
 R5G2rD0icb7aEl/xN7SkE6rAbF1ELt9qJx1oG6EDCzIDLdMz/jWgnfED+Z/sH27NRwBZaUHDBdI
 ixH8u+62rQq1FOW/B64H3YN4HsJ+Z5QTqKkwFWesAEJnYPz6zuI8gbQlvRyRT73GJ7LOROBvuKU
 WAjo0uVz/xVfKMKrhUJltlVS/PN6VeQf1cHHVmdrfEizIJ1ER+gvxcOWmX5yGd6xZd2E0MOL7ZP
 KMRO/ez1uAhBIHlB1FVUXUq+PxO1CmMbFWcdEPuO80UwQi8HXcqM/wnieRGPlA3tUzvMI+JZI+x
 ZhY4ED0/KGskMJIsE7g==
X-Authority-Analysis: v=2.4 cv=XbS5Co55 c=1 sm=1 tr=0 ts=6a54a215 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=n2cOJxejGmWVGDEj5nwA:9
X-Proofpoint-ORIG-GUID: ePubta9obAzXh2W6wqBrw_9dQ0zeH5kq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130084

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
