Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC542233721;
	Fri, 31 Oct 2025 17:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761930137; cv=none; b=BOcwEB/esh+th9l3ECDCKWf7yuX4YHB1pMjlyLJFrSlwm8gsA9RVH3LubVQEvQJT4VGdJJmoRdDYxEX8NbqQIuJ0sDbRd0s4KYYDOH4ygk0pmXh3y9nMfdFuExoUsV7QnnjWw2C1mP2puTdYs0VBmuylKsUa2x3E+8jo5rTy1gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761930137; c=relaxed/simple;
	bh=1kdjb4E/p9sd91GnUOyYedV9SyUsuRGhYLpFQpqvTMo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tMaQjjGAit2sCqIDSlktuJBEXvli6ecq4ZWclbGsVEToqR8wga3dy7MY2uEtEiy4ce6uDPjv7SI41mu4dI36fVAdaFrE2CAquQfdDpbmP2+n36I0OIsL2n5jdZu/sOPlyI17gcMW9SKJZG9jncDdN1hmMqfjRXBXynGacaemSBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HtamTVYq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HtamTVYq"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59VBfqdm004851;
	Fri, 31 Oct 2025 17:02:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=ylHql8zLkpNv+9v+wxTr/iWRgAu+BX2hfVbME6KKahA=; b=HtamTVYq
	s8rZH+FeL6PtRQmeBR8SYCXAVOn065L/xgTsT9kLza7frUc+tJYceQQyp6wV++Ac
	fPVIvfP5UKGozLPYIh00N0bEqfnL1+Tz76tM5Kf6mVcOR1r2G28i7Np76UNWYeY1
	6IhQ4t29geGrCzwuTi9D9n1MN9s1vUUBErGlihoUZ+mgdzdVek/AVN6GCBtKHBGs
	dG3zcUSWMUZ90wpvDOZR0+GegSGSvmyx+hVOVsitZeLoq0+aauSjTFP15won/bBu
	w4TGIzpaH1FZOo4qDCAiZcfMyvafzvLDNif5l40nUOLBkKec+/1nYgXsMEjYH5CT
	3oDIoinHPtxcug==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34a8y1bj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Oct 2025 17:02:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59VGMkM5019567;
	Fri, 31 Oct 2025 17:02:12 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a33xyf85f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Oct 2025 17:02:12 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59VH29LS29032826
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Oct 2025 17:02:09 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 321EE20040;
	Fri, 31 Oct 2025 17:02:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D040220043;
	Fri, 31 Oct 2025 17:02:08 +0000 (GMT)
Received: from osiris (unknown [9.111.9.126])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 31 Oct 2025 17:02:08 +0000 (GMT)
Date: Fri, 31 Oct 2025 18:02:07 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 fixes for 6.18-rc4
Message-ID: <20251031170207.14424A48-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=DYkaa/tW c=1 sm=1 tr=0 ts=6904eb95 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=NVEalAIATpgYVQfZjm4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: MD1Um72SiiIMEzIZECv29iOLT9__Siq7
X-Proofpoint-ORIG-GUID: MD1Um72SiiIMEzIZECv29iOLT9__Siq7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX10i+zoiUCz7F
 Q188ymDGbFWpXZRIC2BYX6OmR5YzPehfMZqa9QfHSTynEfT9a2Nq5gs42u8shSqNYfnMhY9rU42
 UHEKp9DS6HPKxhLjv9Xkgpzay+GNEYqyuWSPIsEvMyaiEQV7RVyFrFtkz43946yjbme1ezJmxOB
 WQGwlbkZkbqW5nXL6olR463/UoFSXt4BC2USAYMLwqlyBCX67ocZdFtXmxNSFOQcgX0zBlYQ3B4
 WL2tQZa5BDABPxKhdQFy9KFKHhTWB94eQjna32A0mx+CgEEoInma3Bmds0BMMlHpcZPDZ7dyewl
 RhzncdAhtZUDGRrCaL+yAcRN4+jrr+K6rVh5+cQhToWWQp8oxulKJHh2yGxo4LhrlP3IIJ2fuBt
 X07OxnRStVBBzUmqajHSReslbWIFTA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_05,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166

Hi Linus,

please pull some s390 fixes for 6.18-rc4.

Thanks,
Heiko

The following changes since commit 211ddde0823f1442e4ad052a2f30f050145ccada:

  Linux 6.18-rc2 (2025-10-19 15:19:16 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.18-3

for you to fetch changes up to 64e2f60f355e556337fcffe80b9bcff1b22c9c42:

  s390: Disable ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP (2025-10-30 16:59:28 +0100)

----------------------------------------------------------------
s390 fixes for 6.18-rc4

- Use correct locking in zPCI event code to avoid deadlock

- Get rid of irqs_registered flag in zpci_dev structure and restore IRQ
  unconditionally for zPCI devices. This fixes sit uations where the flag
  was not correctly updated

- Fix potential memory leak kernel page table dumper code

- Disable (revert) ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP for s390 again. The
  optimized hugetlb vmemmap code modifies kernel page tables in a way which
  does not work on s390 and leads to reproducible kernel crashes due to
  stale TLB entries. This needs to be addressed with some larger changes.
  For now simply disable the feature

- Update defconfigs

----------------------------------------------------------------
Farhan Ali (1):
      s390/pci: Restore IRQ unconditionally for the zPCI device

Gerd Bayer (1):
      s390/pci: Avoid deadlock between PCI error recovery and mlx5 crdump

Heiko Carstens (2):
      s390: Update defconfigs
      s390: Disable ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP

Miaoqian Lin (1):
      s390/mm: Fix memory leak in add_marker() when kvrealloc() fails

 arch/s390/Kconfig                    |  1 -
 arch/s390/configs/debug_defconfig    | 14 +++++++++-----
 arch/s390/configs/defconfig          | 14 +++++++++-----
 arch/s390/configs/zfcpdump_defconfig |  1 -
 arch/s390/include/asm/pci.h          |  1 -
 arch/s390/mm/dump_pagetables.c       | 19 +++++++------------
 arch/s390/pci/pci_event.c            |  4 ++--
 arch/s390/pci/pci_irq.c              |  9 +--------
 8 files changed, 28 insertions(+), 35 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index c4145672ca34..df22b10d9141 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -158,7 +158,6 @@ config S390
 	select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
 	select ARCH_WANT_KERNEL_PMD_MKWRITE
 	select ARCH_WANT_LD_ORPHAN_WARN
-	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
 	select ARCH_WANTS_THP_SWAP
 	select BUILDTIME_TABLE_SORT
 	select CLONE_BACKWARDS2
diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index b31c1df90257..8433f769f7e1 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -101,6 +101,7 @@ CONFIG_SLUB_STATS=y
 CONFIG_MEMORY_HOTPLUG=y
 CONFIG_MEMORY_HOTREMOVE=y
 CONFIG_KSM=y
+CONFIG_PERSISTENT_HUGE_ZERO_FOLIO=y
 CONFIG_TRANSPARENT_HUGEPAGE=y
 CONFIG_CMA_DEBUGFS=y
 CONFIG_CMA_SYSFS=y
@@ -123,12 +124,12 @@ CONFIG_TLS_DEVICE=y
 CONFIG_TLS_TOE=y
 CONFIG_XFRM_USER=m
 CONFIG_NET_KEY=m
-CONFIG_XDP_SOCKETS=y
-CONFIG_XDP_SOCKETS_DIAG=m
-CONFIG_DIBS=y
-CONFIG_DIBS_LO=y
 CONFIG_SMC=m
 CONFIG_SMC_DIAG=m
+CONFIG_DIBS=y
+CONFIG_DIBS_LO=y
+CONFIG_XDP_SOCKETS=y
+CONFIG_XDP_SOCKETS_DIAG=m
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
 CONFIG_IP_ADVANCED_ROUTER=y
@@ -472,6 +473,7 @@ CONFIG_SCSI_DH_EMC=m
 CONFIG_SCSI_DH_ALUA=m
 CONFIG_MD=y
 CONFIG_BLK_DEV_MD=y
+CONFIG_MD_LLBITMAP=y
 # CONFIG_MD_BITMAP_FILE is not set
 CONFIG_MD_LINEAR=m
 CONFIG_MD_CLUSTER=m
@@ -654,9 +656,12 @@ CONFIG_JFS_POSIX_ACL=y
 CONFIG_JFS_SECURITY=y
 CONFIG_JFS_STATISTICS=y
 CONFIG_XFS_FS=y
+CONFIG_XFS_SUPPORT_V4=y
+CONFIG_XFS_SUPPORT_ASCII_CI=y
 CONFIG_XFS_QUOTA=y
 CONFIG_XFS_POSIX_ACL=y
 CONFIG_XFS_RT=y
+# CONFIG_XFS_ONLINE_SCRUB is not set
 CONFIG_XFS_DEBUG=y
 CONFIG_GFS2_FS=m
 CONFIG_GFS2_FS_LOCKING_DLM=y
@@ -666,7 +671,6 @@ CONFIG_BTRFS_FS_POSIX_ACL=y
 CONFIG_BTRFS_DEBUG=y
 CONFIG_BTRFS_ASSERT=y
 CONFIG_NILFS2_FS=m
-CONFIG_FS_DAX=y
 CONFIG_EXPORTFS_BLOCK_OPS=y
 CONFIG_FS_ENCRYPTION=y
 CONFIG_FS_VERITY=y
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index 161dad7ef211..4414dabd04a6 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -94,6 +94,7 @@ CONFIG_SLAB_BUCKETS=y
 CONFIG_MEMORY_HOTPLUG=y
 CONFIG_MEMORY_HOTREMOVE=y
 CONFIG_KSM=y
+CONFIG_PERSISTENT_HUGE_ZERO_FOLIO=y
 CONFIG_TRANSPARENT_HUGEPAGE=y
 CONFIG_CMA_SYSFS=y
 CONFIG_CMA_AREAS=7
@@ -114,12 +115,12 @@ CONFIG_TLS_DEVICE=y
 CONFIG_TLS_TOE=y
 CONFIG_XFRM_USER=m
 CONFIG_NET_KEY=m
-CONFIG_XDP_SOCKETS=y
-CONFIG_XDP_SOCKETS_DIAG=m
-CONFIG_DIBS=y
-CONFIG_DIBS_LO=y
 CONFIG_SMC=m
 CONFIG_SMC_DIAG=m
+CONFIG_DIBS=y
+CONFIG_DIBS_LO=y
+CONFIG_XDP_SOCKETS=y
+CONFIG_XDP_SOCKETS_DIAG=m
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
 CONFIG_IP_ADVANCED_ROUTER=y
@@ -462,6 +463,7 @@ CONFIG_SCSI_DH_EMC=m
 CONFIG_SCSI_DH_ALUA=m
 CONFIG_MD=y
 CONFIG_BLK_DEV_MD=y
+CONFIG_MD_LLBITMAP=y
 # CONFIG_MD_BITMAP_FILE is not set
 CONFIG_MD_LINEAR=m
 CONFIG_MD_CLUSTER=m
@@ -644,16 +646,18 @@ CONFIG_JFS_POSIX_ACL=y
 CONFIG_JFS_SECURITY=y
 CONFIG_JFS_STATISTICS=y
 CONFIG_XFS_FS=y
+CONFIG_XFS_SUPPORT_V4=y
+CONFIG_XFS_SUPPORT_ASCII_CI=y
 CONFIG_XFS_QUOTA=y
 CONFIG_XFS_POSIX_ACL=y
 CONFIG_XFS_RT=y
+# CONFIG_XFS_ONLINE_SCRUB is not set
 CONFIG_GFS2_FS=m
 CONFIG_GFS2_FS_LOCKING_DLM=y
 CONFIG_OCFS2_FS=m
 CONFIG_BTRFS_FS=y
 CONFIG_BTRFS_FS_POSIX_ACL=y
 CONFIG_NILFS2_FS=m
-CONFIG_FS_DAX=y
 CONFIG_EXPORTFS_BLOCK_OPS=y
 CONFIG_FS_ENCRYPTION=y
 CONFIG_FS_VERITY=y
diff --git a/arch/s390/configs/zfcpdump_defconfig b/arch/s390/configs/zfcpdump_defconfig
index ed0b137353ad..b5478267d6a7 100644
--- a/arch/s390/configs/zfcpdump_defconfig
+++ b/arch/s390/configs/zfcpdump_defconfig
@@ -33,7 +33,6 @@ CONFIG_NET=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_SAFE=y
 CONFIG_BLK_DEV_RAM=y
-# CONFIG_DCSSBLK is not set
 # CONFIG_DASD is not set
 CONFIG_ENCLOSURE_SERVICES=y
 CONFIG_SCSI=y
diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 6890925d5587..a32f465ecf73 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -145,7 +145,6 @@ struct zpci_dev {
 	u8		has_resources	: 1;
 	u8		is_physfn	: 1;
 	u8		util_str_avail	: 1;
-	u8		irqs_registered	: 1;
 	u8		tid_avail	: 1;
 	u8		rtr_avail	: 1; /* Relaxed translation allowed */
 	unsigned int	devfn;		/* DEVFN part of the RID*/
diff --git a/arch/s390/mm/dump_pagetables.c b/arch/s390/mm/dump_pagetables.c
index 9af2aae0a515..528d7c70979f 100644
--- a/arch/s390/mm/dump_pagetables.c
+++ b/arch/s390/mm/dump_pagetables.c
@@ -291,16 +291,14 @@ static int ptdump_cmp(const void *a, const void *b)
 
 static int add_marker(unsigned long start, unsigned long end, const char *name)
 {
-	size_t oldsize, newsize;
+	struct addr_marker *new;
+	size_t newsize;
 
-	oldsize = markers_cnt * sizeof(*markers);
-	newsize = oldsize + 2 * sizeof(*markers);
-	if (!oldsize)
-		markers = kvmalloc(newsize, GFP_KERNEL);
-	else
-		markers = kvrealloc(markers, newsize, GFP_KERNEL);
-	if (!markers)
-		goto error;
+	newsize = (markers_cnt + 2) * sizeof(*markers);
+	new = kvrealloc(markers, newsize, GFP_KERNEL);
+	if (!new)
+		return -ENOMEM;
+	markers = new;
 	markers[markers_cnt].is_start = 1;
 	markers[markers_cnt].start_address = start;
 	markers[markers_cnt].size = end - start;
@@ -312,9 +310,6 @@ static int add_marker(unsigned long start, unsigned long end, const char *name)
 	markers[markers_cnt].name = name;
 	markers_cnt++;
 	return 0;
-error:
-	markers_cnt = 0;
-	return -ENOMEM;
 }
 
 static int pt_dump_init(void)
diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index b95376041501..27db1e72c623 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -188,7 +188,7 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
 	 * is unbound or probed and that userspace can't access its
 	 * configuration space while we perform recovery.
 	 */
-	pci_dev_lock(pdev);
+	device_lock(&pdev->dev);
 	if (pdev->error_state == pci_channel_io_perm_failure) {
 		ers_res = PCI_ERS_RESULT_DISCONNECT;
 		goto out_unlock;
@@ -257,7 +257,7 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
 		driver->err_handler->resume(pdev);
 	pci_uevent_ers(pdev, PCI_ERS_RESULT_RECOVERED);
 out_unlock:
-	pci_dev_unlock(pdev);
+	device_unlock(&pdev->dev);
 	zpci_report_status(zdev, "recovery", status_str);
 
 	return ers_res;
diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index 84482a921332..e73be96ce5fe 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -107,9 +107,6 @@ static int zpci_set_irq(struct zpci_dev *zdev)
 	else
 		rc = zpci_set_airq(zdev);
 
-	if (!rc)
-		zdev->irqs_registered = 1;
-
 	return rc;
 }
 
@@ -123,9 +120,6 @@ static int zpci_clear_irq(struct zpci_dev *zdev)
 	else
 		rc = zpci_clear_airq(zdev);
 
-	if (!rc)
-		zdev->irqs_registered = 0;
-
 	return rc;
 }
 
@@ -427,8 +421,7 @@ bool arch_restore_msi_irqs(struct pci_dev *pdev)
 {
 	struct zpci_dev *zdev = to_zpci(pdev);
 
-	if (!zdev->irqs_registered)
-		zpci_set_irq(zdev);
+	zpci_set_irq(zdev);
 	return true;
 }
 
