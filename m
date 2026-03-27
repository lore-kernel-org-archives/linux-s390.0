Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D53C322B83;
	Fri, 27 Mar 2026 15:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774625047; cv=none; b=ogT2mR+Os6Gxk9m3PZYOiKRr1Ko3wXJEjBYv7qV5IloD8olMllYTlRmPAmhj0fwhDXsHB8Y06Dx1jDMSvnslLaKw5tcg4wbtT93KB/GU3OpmVTpDYL8a5t51FQvKbXYf+2NsYQCFSC9cZ4LNJC5eJAunwmp3c5dMpa0IZecToo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774625047; c=relaxed/simple;
	bh=YSEnGAad5Sjy/5HpFNcfWUzb6QHAY/Y9coWbyh3Jy0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M0dz1Kb1qFohGTJEAq10nJgs9kmYZjl78WpsR81xeqtSWfPNA/AIe9syCSr8CZoWC+XGygqNl75oZU8zdf6Qpx4baEDfSIehclCJD621o7vds3n6zLnmPOUaWdQf+xQl/7QP1Di4EbNH0vhr16ET5dxWEfLREpxFwZzZUb+X+EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qwnX+PvQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qwnX+PvQ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62RDZw4r3820072;
	Fri, 27 Mar 2026 15:24:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Opgm+WUSzAItA//xZEjRyvGc4iUWY73VcEFpJq8Sv
	SA=; b=qwnX+PvQJ0viJPu1u25F1e3WIP9nAKJ2l7qXhxfEkvo/dvYvYKqCqWO0E
	NsMmf9OEpLGi8rcOxnRyK5/Zee9//Q4WWmgrWP2DBeD/clM3TcVqLgwGweHYXJBp
	CMmm2Nt5zI/xOTJvFMDb1mam6giA5Ki5+oec4MjMdOAKJ9YpXVxlxEFyb6E5I2mQ
	5dcSCQsa2QpUzHFU11HkgKFgahqSQUe1JTSap65zsC1dj5weLsxHUUf10XfD//Y6
	SXTIBcIBeA8IwDT4bhUAxPYlTjgCKxOmBoNk+fCiWgVAB1j3CuEIngj1eb2OSnN0
	7EOXaaiZ1vP+q7wsFdBQt1yA/0kNg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktv9n8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 15:24:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62RB0tSD026685;
	Fri, 27 Mar 2026 15:24:03 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275m7wsk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 15:24:03 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62RFNvJQ9109986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Mar 2026 15:23:57 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD3DD2004D;
	Fri, 27 Mar 2026 15:23:57 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DD5020043;
	Fri, 27 Mar 2026 15:23:57 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.84.176])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Mar 2026 15:23:57 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 00/10] KVM: s390: More memory management fixes for 7.0
Date: Fri, 27 Mar 2026 16:23:46 +0100
Message-ID: <20260327152356.250625-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: f5C1Hkf-wcRbiUR4UUPsYd0Ze6Tj4Tqz
X-Authority-Analysis: v=2.4 cv=aMr9aL9m c=1 sm=1 tr=0 ts=69c6a114 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=ymAMLRC48C9fG9WTL0QA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEwNSBTYWx0ZWRfX5PwLGL9wyTIU
 zsCfTQ+/BAlOBp92cz0ft8yFz6Vpbam3K5P6B46JfKdTU51T37Xe6DJ4KPcfxucxDGokamdonUb
 vC29FmvFkr8/OE+XOIReYI1mZLJMTZb3n4wwdCLZE+XpTGfiOR+i2yGyql50bS+HYmvpiXXYTs9
 nNNSG0MTXvQ6Agpb88YzI9sq7l9sO5nlGFkOb64WkL0DLl3HN8V8HGE4iH6qQa6u30pqvqXM500
 yJzk2+nMG/Z4X5X+ZEOcqmLCTWLlolRIlcCEicFvq7FB4yrjFLBECrwksnsE/iW4Ent/SOp9e/X
 Y28H/R3JEDuGvpesiruHPOd+nh/iRGTZZsMlHu2v7mYCzdt3PgcoKHch7XJ/JkDXelczscVX8BV
 fEYD6JRScNCLydz4qEUlypFIwsynQlm6AIgjzUoa1I8fxlaMUvBUrPjKETrVJrkeNrouihd0Cmf
 lBhz/C7CFNID/S4/HNA==
X-Proofpoint-GUID: f5C1Hkf-wcRbiUR4UUPsYd0Ze6Tj4Tqz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270105

Ciao Paolo,

here are a few more important fixes for the new gmap code.
These are (hopefully) the last fixes for this release cycle

please pull :)


The following changes since commit 0138af2472dfdef0d56fc4697416eaa0ff2589bd:

  Merge tag 'erofs-for-7.0-rc6-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs (2026-03-25 18:41:35 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/kvm-s390-master-7.0-2

for you to fetch changes up to 0a28e06575b3f3b30c1e99fc08fa0907956f35a4:

  KVM: s390: Fix KVM_S390_VCPU_FAULT ioctl (2026-03-26 16:12:38 +0100)

----------------------------------------------------------------
KVM: s390: More memory management fixes

Lots of small and not-so-small fixes for the newly rewritten gmap,
mostly affecting the handling of nested guests.

----------------------------------------------------------------
Claudio Imbrenda (10):
      KVM: s390: vsie: Fix dat_split_ste()
      KVM: s390: Remove non-atomic dat_crstep_xchg()
      KVM: s390: vsie: Fix check for pre-existing shadow mapping
      KVM: s390: Fix gmap_link()
      KVM: s390: Correctly handle guest mappings without struct page
      KVM: s390: vsie: Fix nested guest memory shadowing
      KVM: s390: vsie: Fix refcount overflow for shadow gmaps
      KVM: s390: vsie: Fix unshadowing while shadowing
      KVM: s390: vsie: Fix guest page tables protection
      KVM: s390: Fix KVM_S390_VCPU_FAULT ioctl

 arch/s390/kvm/dat.c      | 100 +++++------------------------
 arch/s390/kvm/dat.h      |  23 +++----
 arch/s390/kvm/gaccess.c  |  71 +++++++++++++++------
 arch/s390/kvm/gmap.c     | 160 +++++++++++++++++++++++++++++++++--------------
 arch/s390/kvm/gmap.h     |  33 ++++++----
 arch/s390/kvm/kvm-s390.c |  18 +++++-
 arch/s390/kvm/vsie.c     |   4 +-
 7 files changed, 231 insertions(+), 178 deletions(-)
