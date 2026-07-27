Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D9A3033D6;
	Mon, 27 Jul 2026 09:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146249; cv=none; b=OADGp2xmT0Y3DxanBtIvz+T+Pm5alfOEllcF8DtBKASJm02L6GJv9JLhelVtnU97maaYv+imwlG4gZdpHtgdwhHAj9zGQoiyARQsEeaBVMSqG0lsFFkIPWs+Rr85sKgaTDf3M5spPo121ufP5fe8SNiRlbgKN+9R+HPfK7S7iqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146249; c=relaxed/simple;
	bh=ymPrEs1qcMs/rFt9Bxi/+vFAeoXBsP5S+NBOYzRJcq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fr0lkO27xThcfPpcrTbwIhrR+pD5RbK5Ux2LHQzaxEvWjsTA0wl6H1liFEwfxCt/asL+fhUZdGQRlYZZ6SETLOqcWOfwPL0eV1iyh7N7khlZIgSL2PTdsln2YtsblH0hcXlZsjBJpves90RspSV28KLo/UwuSlKpyY0R73o+lpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DsQNteox; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DsQNteox"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R9UgJV1742782;
	Mon, 27 Jul 2026 09:57:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=sjHWvJpkXU6ksGoFni32sJzqoSZDSVMFV++GUZw22
	p4=; b=DsQNteoxPIWelGwT6bemV/cvHHlGLZKojQO8Dl2zld2O54HJxYcgcNELi
	7DM8srPoI+zEwF//MzgSCzFJmPJEHQIpz231MPyHpVixUXl/8SxMbdQOYVAypDOh
	O0gTcrA368wIKt9wf5Lai9ItRR+vgkfpoOgn0MIr+md6sdfev+Dm7iMfKQtMsbRj
	Af15bEABU0c4xy+2NKkD65ynU6Fw3o5Zuvb7MjK5hEe7Jn/BhIa0Tcc88cikZliH
	+s/UDl282SRizzDV7DnfCuKfdtmkZ4dUTtIcpBc+RFrUoIQppP6xp8XroluumyI1
	juBvL8t46HZxB1yhEcsV+fjCSBdXw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyhxyh5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 09:57:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66R9uGn4001123;
	Mon, 27 Jul 2026 09:57:25 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fjvum9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 09:57:25 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66R9vNt831064732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 09:57:23 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACE1E5805C;
	Mon, 27 Jul 2026 09:57:23 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58E4D58051;
	Mon, 27 Jul 2026 09:57:21 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 09:57:21 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Jaehoon Kim <jhkim@linux.ibm.com>,
        Douglas Freimuth <freimuth@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>
Subject: [GIT PULL 0/7] KVM: s390: Fixes for 7.2
Date: Mon, 27 Jul 2026 11:57:13 +0200
Message-ID: <20260727095720.9150-1-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA5NiBTYWx0ZWRfX043RXqfgnGww
 r3FtAGg+2W+4uTeqp2CltH2b/F/HMdCj79Q8oyCoRkmyfXoxrx4Jc/FQIe818mta9yf4DDLRIge
 got8bYT9FBlFPd/iF4F4NyP+EVSsL0k=
X-Proofpoint-GUID: Jy9RM7k8-X-qPgwr1RmHqnXA-oJm5ERX
X-Proofpoint-ORIG-GUID: Jy9RM7k8-X-qPgwr1RmHqnXA-oJm5ERX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA5NiBTYWx0ZWRfX7mqQVBZ5Bf8P
 txFUt8OmqJfqg1TKWtHb6AjFoPoDAnSgnGKNllNGcFHY7XOg02kLqzVgzCvCC+rFX78kFrKXCEU
 3ixv5efxK+Shgx4Otuksa5s2jNx8N6P4MIfbydB3Kf3GU1D99eNvN9HrHJWMFPLFXx7ClQSZC3X
 K1iHHitG0GWldG9LuCmprRSZVjSA9pE1jBMRUppj6nlgc10RQtmyAU3CzDMPjwrpaJzPsCKEtjC
 bHXfWqpjhSLdBcIJZc2nYIcli33N2Eg8CkNxJB/Ovt24YlLJ5+OFSDvXUySY9tpXARPEoPvJNY+
 v06s0kMFrr4KK9YQBeLHacbA4Z9FpnzD2Sa9VptmQ2+uFj0QoMvAWdaY4eRfmuR/Z5QMclm0/A1
 EfVkWJEqAbqAF6TyVlR1gYjewAFz15iGNoMwLO9UOl+rYLqGqLWuP6fVFv1vImM5cenc1G46Z+D
 YVgSiZ8IHiEORQ+9mug==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a672b85 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=_NmZE6AsOWs4FgYXpaAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270096

Paolo,

some more fixes triggered by AI bug reports or testing.
Mostly for PCI support.
This also has a regression fix that we introduced in 7.2-rc1

The following changes since commit 3e3aa6da87d30a0064a17b836685cd43c90a3572:

  KVM: s390: pci: Fix handling of AIF enable without AISB (2026-07-09 16:23:10 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-7.2-2

for you to fetch changes up to 9972befc3e34ff8b6847198c84f11bfc312dde40:

  KVM: s390: Fall back to short-term pinning in MAP ioctl (2026-07-27 09:23:53 +0200)


All fixes had no new sashiko findings, just pre-existing issues or
finding that are being fixed by other patches of the series.

We have some more fixes pending for gmap and vfio-ccw that still need
testing or sashiko fixups, but we should process these fixes now.


----------------------------------------------------------------
KVM: s390: Fixes for 7.2

- several fixes for PCI passthru in s390 kvm
- fix a 7.2-rc regression in the adapter interrupt mapping code

----------------------------------------------------------------
Farhan Ali (6):
      KVM: s390: pci: Reject adapter interrupt forwarding if already enabled
      KVM: s390: pci: Fix memory accounting for pinned/unpinned pages
      KVM: s390: pci: Fix missing error codes and memory unaccounting
      KVM: s390: pci: Fix NULL dereference on AIBV allocation failure
      KVM: s390: pci: Fix resource leak on IRQ registration failure
      KVM: s390: pci: Validate AIBV and AISB before pinning guest pages

Jaehoon Kim (1):
      KVM: s390: Fall back to short-term pinning in MAP ioctl

 Documentation/virt/kvm/devices/s390_flic.rst |  15 +++-
 arch/s390/include/asm/kvm_host.h             |   5 ++
 arch/s390/kvm/interrupt.c                    |  56 ++++++++++----
 arch/s390/kvm/pci.c                          | 107 +++++++++++++++++++++------
 arch/s390/kvm/pci.h                          |   2 +
 5 files changed, 148 insertions(+), 37 deletions(-)
