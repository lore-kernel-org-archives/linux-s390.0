Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746393C98B5;
	Thu,  4 Jun 2026 06:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780555467; cv=none; b=geeQtn1T0BEXeWK11+Orq7Kz6vZHqZfBTS4YqzuLUqXLuBkY8+5PbUmEt/S9twdZzuzTwec4zuV2mvafIcbhDNXbZUgSBJLBjGArqKcSct1YK+pX0riN051nOrp4pAOrWcKI81+W4V71ZxNkp5bDXRdxCKY+RUGWqytK60xae7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780555467; c=relaxed/simple;
	bh=yBMstDezzrlR+D2lnergApWsc+ZdIXr2Xo3Q1wb6mS0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bnUiuIbFa1IwJchpUxhUXHgNwqlYDi1kA6vYyGOl1TO7XK8omenyW26yTYWlPTl78qCDzjx6y+n7K+OIqLsa7t2h5X+xVNNq2o/HHXyElYIcDMT5kEXEvdkn0WZ+xIqgDYawlK4vWt9/dkWg9BZwqN+aT6MmiqENAMCo5dQRSdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M5LnWWdG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M5LnWWdG"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653GxmmJ103884;
	Thu, 4 Jun 2026 06:44:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=zrCIQunoZ+c/i35w5VtcQeAsfJNvEQcnRv+93mI7wkE=; b=M5LnWWdG
	MYR5U7RDN3WJFsQGJDzuCaECFmy5RN0pCRHET62C6FKgzsooMrC9D56+ZMtAKRKP
	xTFUev5cU5vLwy+xtfvN39EoAOoT2Noo0eFpJCM1NclGj7crfmQHh/V7x9yE5Cxs
	iP2LECOEq/9bRtT28xxZhL/lKislR5sASCduo0vv/6SYJcjyolPSa13e/+a0njxl
	9Pw95W5ifOlH1MuDqh3oeOI4rUcLoEEpQaeHf7bERwRg/8uHkWdDisFJ5EFvbSB0
	5Q6oetotZKsNFTTh9JGJgqxyjcPWeL+KiH3QtBwH/l6N51RJVq3iJRq+KUc3uMFw
	LPRA4Vi/fhIFww==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpaedyu4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 06:44:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6546d5xF011331;
	Thu, 4 Jun 2026 06:44:22 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egakw3yy7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 06:44:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6546iIUp60031354
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jun 2026 06:44:18 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15E3C20043;
	Thu,  4 Jun 2026 06:44:18 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED98C20040;
	Thu,  4 Jun 2026 06:44:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  4 Jun 2026 06:44:17 +0000 (GMT)
Date: Thu, 4 Jun 2026 08:44:16 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 7.1-rc7
Message-ID: <20260604064416.1461269A9a-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Zt3d7d7G c=1 sm=1 tr=0 ts=6a211ec6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=UFhfJ5FeD3VIgVq7kfgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: bH_NRieXH8ndb5o1lv4JV3rlg2_OhiBc
X-Proofpoint-ORIG-GUID: bH_NRieXH8ndb5o1lv4JV3rlg2_OhiBc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA2MiBTYWx0ZWRfX2v7MAURIxQdH
 jKP1o33sZ445sSPkyKsS9rvtblphFs5bk4O/0jNUjYUmhC9rhu4kl7eJgjbdG4vn+9w/v9zZh5P
 od/NiOphp7r2mYZoOYMsKaoDSNNt3FJDj7ytSmPhsbzB/KKS/kuMLTPbIPNqozgWLfw/Spl5t9h
 sh/SJXClWD7tX7bJRVcSkNLR/IqJovGsm89ihsktXGliKqSd11XiT2ut3pq8qh9pBIKoVMATMl+
 U45zrX2a3AKBhn5/U/xa6RbQ30T4MxtL58S+hO0BLb2bHakZb8/Ss5ZV6YXGV6p31YMJV2a5bFP
 jxMER/7KY4q80Jv3z7CRcXiKp20iugvNCtfOI4MOtuzeb2usfoWVrs/zGN9z+izHz3UTQCKvk+O
 2LB4P5DQTHi9dPogwMrOcZ1vmqtQw7DTHI/sIcIFqyYnePi2brlFOt50A1w+nfBrj0MwAQcFJ0a
 z08XAdRqV60d3h5raxw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040062

Hi Linus,

please pull s390 updates for 7.1-rc7.

Thanks,
Alexander Gordeev

The following changes since commit 540f4a4f6ef806a28e794001bb4beac4840a6090:

  s390/topology: Use zero-based numbering for containing entities (2026-05-20 09:39:24 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.1-4

for you to fetch changes up to 7c6535c37dbc03c1c35926b7420d66fb122b513a:

  s390: Implement _THIS_IP_ using inline asm (2026-05-30 11:33:32 +0200)

----------------------------------------------------------------
s390 updates for 7.1-rc7

- Enable IOMMUFD and VFIO cdev such that PCI pass-through
  to QEMU/KVM can optionally utilize native IOMMUFD

- With HAVE_ARCH_BUG_FORMAT enabled the BUG infrastructure
  might misinterpret flags or fault. Fix this by moving the
  "format" field emission into __BUG_ENTRY()

- The generic version of _THIS_IP_ is known to be brittle
  and may break with current and future GCC and Clang
  optimizations. Fix it by overriding _THIS_IP_

----------------------------------------------------------------
Jan Polensky (1):
      s390/bug: Always emit format word in __BUG_ENTRY

Marco Elver (1):
      s390: Implement _THIS_IP_ using inline asm

Niklas Schnelle (1):
      s390/configs: Enable IOMMUFD and VFIO cdev in defconfigs

 arch/s390/configs/debug_defconfig |  4 ++++
 arch/s390/configs/defconfig       |  4 ++++
 arch/s390/include/asm/bug.h       | 12 ++++++------
 arch/s390/include/asm/linkage.h   |  2 ++
 4 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index c28f9a7d0bd8..730c90b4a876 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -56,6 +56,10 @@ CONFIG_EXPOLINE_AUTO=y
 CONFIG_CHSC_SCH=y
 CONFIG_VFIO_CCW=m
 CONFIG_VFIO_AP=m
+CONFIG_VFIO_DEVICE_CDEV=y
+CONFIG_IOMMUFD_DRIVER=y
+CONFIG_IOMMUFD_DRIVER_CORE=y
+CONFIG_IOMMUFD=y
 CONFIG_CMM=m
 CONFIG_APPLDATA_BASE=y
 CONFIG_S390_HYPFS_FS=y
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index d89c988f33ea..dd5fc1426c88 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -54,6 +54,10 @@ CONFIG_EXPOLINE_AUTO=y
 CONFIG_CHSC_SCH=y
 CONFIG_VFIO_CCW=m
 CONFIG_VFIO_AP=m
+CONFIG_VFIO_DEVICE_CDEV=y
+CONFIG_IOMMUFD_DRIVER=y
+CONFIG_IOMMUFD_DRIVER_CORE=y
+CONFIG_IOMMUFD=y
 CONFIG_CMM=m
 CONFIG_APPLDATA_BASE=y
 CONFIG_S390_HYPFS_FS=y
diff --git a/arch/s390/include/asm/bug.h b/arch/s390/include/asm/bug.h
index 59017fd3d935..50a270edb020 100644
--- a/arch/s390/include/asm/bug.h
+++ b/arch/s390/include/asm/bug.h
@@ -12,12 +12,11 @@
 #if defined(CONFIG_BUG) && defined(CONFIG_CC_HAS_ASM_IMMEDIATE_STRINGS)
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
-#define __BUG_ENTRY_VERBOSE(format, file, line)				\
-	"	.long	" format " - .	# bug_entry::format\n"		\
+#define __BUG_ENTRY_VERBOSE(file, line)					\
 	"	.long	" file " - .	# bug_entry::file\n"		\
 	"	.short	" line "	# bug_entry::line\n"
 #else
-#define __BUG_ENTRY_VERBOSE(format, file, line)
+#define __BUG_ENTRY_VERBOSE(file, line)
 #endif
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE_DETAILED
@@ -28,9 +27,10 @@
 
 #define __BUG_ENTRY(format, file, line, flags, size)			\
 		"	.section __bug_table,\"aw\"\n"			\
-		"1:	.long	0b - .	# bug_entry::bug_addr\n"	\
-		__BUG_ENTRY_VERBOSE(format, file, line)			\
-		"	.short	"flags"	# bug_entry::flags\n"		\
+		"1:	.long	0b - .		# bug_entry::bug_addr\n"\
+		"	.long	" format " - .	# bug_entry::format\n"	\
+		__BUG_ENTRY_VERBOSE(file, line)				\
+		"	.short	"flags"		# bug_entry::flags\n"	\
 		"	.org	1b+"size"\n"				\
 		"	.previous"
 
diff --git a/arch/s390/include/asm/linkage.h b/arch/s390/include/asm/linkage.h
index df3fb7d8227b..1b3ac553a642 100644
--- a/arch/s390/include/asm/linkage.h
+++ b/arch/s390/include/asm/linkage.h
@@ -7,4 +7,6 @@
 #define __ALIGN .balign CONFIG_FUNCTION_ALIGNMENT, 0x07
 #define __ALIGN_STR __stringify(__ALIGN)
 
+#define _THIS_IP_ ({ unsigned long __ip; asm volatile("larl %0, ." : "=d" (__ip)); __ip; })
+
 #endif
