Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30431249F3
	for <linux-s390@vger.kernel.org>; Tue, 13 Feb 2024 10:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707821409; cv=none; b=SjM2cy9aUcyrYS7PhiOHSZD9PcjIkoK4kZ33bSAXHXKVVcisuy+mvorwe76tPczCmTZNqy5o5v7nY3wvszLsONDCarRyLPQsZBPrUWJLTI0+IaDMUPynWmJy5GnAEkt+7rXrWnskZD4HxX65cXFSz+I5NIrUfnD/2gzz9iiTw38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707821409; c=relaxed/simple;
	bh=kh1X9VLOOx8TUw5rB12UeF+sn8HFv4NL6p2z/Vb0SDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tQ43wCG6tbHDWSidkx1bN5iJtXLeAoqHJaC9ooY2TfgNOJ2w8YSOQhrcq6GqBvo0+LlsX8e4SkSeIBSQ3jSCmz/Xv7pu5i9k+pOuXNMLv9oqQLwRbAVx/CTH2x4xk1UlQIpH606KOJopu4k+Ru/cDbUrLJlx9P6CtykV7VyRHxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BdD1CdIo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BdD1CdIo"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41DAo1mF021512;
	Tue, 13 Feb 2024 10:50:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=Cw0X1pSf4dAHHeSBb1dZst3R7YtszMXsByUm+N+0A40=;
 b=BdD1CdIoSYDdd6Uuo/CdK+Xc/8AGsynzfu18ok+ESEHXf136XoYTiKnYFDB9vlNoDiMR
 Pp8ovfhIUv+eBMI0kiPWstX+MgOHFmkw3QYH3xr7nJwr6aJ2vLbwJ7YqPDlDsff8TB4X
 2N2eWXGlpigb3CrQBOqrzgRo+tS3vbhWBteH6lv39szNedEJzUbeZapD4KCdTgCvPTkT
 qofB+BESBj+eVP3w1tX9vNsEo416HHwkLgaeDGk7hSjdFykClAgS2CXpVhWDJzFGGbwv
 nsNpT3hWWJxvreFhnUVordgVUNbWwkPsKSPVfDJuf3k0e3LecsqtCO3j3D7DeJZN9E59 AA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w86s0gas1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 10:50:05 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41DAY5hq007065;
	Tue, 13 Feb 2024 10:50:05 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w86s0gan0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 10:50:01 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41D9eIEb009886;
	Tue, 13 Feb 2024 10:47:19 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6p62pb2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 10:47:19 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41DAlDBR54329610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 10:47:15 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9C7B2004E;
	Tue, 13 Feb 2024 10:47:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 854B120040;
	Tue, 13 Feb 2024 10:47:13 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Feb 2024 10:47:13 +0000 (GMT)
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: linux-s390@vger.kernel.org, jpoimboe@kernel.org, joe.lawrence@redhat.com
Cc: gor@linux.ibm.com, hca@linux.ibm.com, iii@linux.ibm.com,
        agordeev@linux.ibm.com, sumanthk@linux.ibm.com
Subject: [PATCH 0/4] s390: compile relocatable kernel with/without fPIE
Date: Tue, 13 Feb 2024 11:47:03 +0100
Message-Id: <20240213104707.673053-1-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NBFmlxC_6CFYa_d_ubYGWUEtyM3vVF2K
X-Proofpoint-GUID: ciUhBGMK0uDnln8w8l-zq6QWslm8TOGY
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_05,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=588 adultscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130085

Hi All,

This is a rebased version of Josh's patch series with a few fixups.
https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/log/?h=s390

This introduces the capability to compile the s390 relocatable kernel
with and without the -fPIE option.

When utilizing the kpatch functionality, it is advisable to compile the
kernel without the -fPIE option. This is particularly important if the
kernel is built with the -ffunction-sections and -fdata-sections flags.
The linker imposes a restriction on the number of sections (limited to
64k), necessitating the omission of -fPIE.

[1] https://gcc.gnu.org/pipermail/gcc-patches/2023-June/622872.html
[2] https://gcc.gnu.org/pipermail/gcc-patches/2023-August/625986.html

Gcc recently implemented an optimization [1] for loading symbols without
explicit alignment, aligning with the IBM Z ELF ABI. This ABI mandates
symbols to reside on a 2-byte boundary, enabling the use of the larl
instruction. However, kernel linker scripts may still generate unaligned
symbols. To address this, a new -munaligned-symbols option has been
introduced [2] in recent gcc versions. This option has to be used with
future gcc versions.

Older Clang lacks support for handling unaligned symbols generated
by kernel linker scripts when the kernel is built without -fPIE. However,
future versions of Clang will include support for the -munaligned-symbols
option. When the support is unavailable, compile the kernel with -fPIE
to maintain the existing behavior.

Patch 1 filters out -munaligned-symbol flag for vdso code. This is beneficial
when compiling kernel with -fno-PIE and -munaligned-symbols combination.

Patch 2 introduces the 'relocs' tool, which reads the vmlinux file and
generates a vmlinux.relocs_64 section, containing offsets for all
R_390_64 relocations.

Patch 3 enables the compilation of a relocatable kernel with or without
the -fPIE option. It  allows for building the relocatable kernel without
-fPIE.  However, if compiler cannot handle unaligned symbols, the kernel
is built with -fPIE.

Patch 4 handles orphan .rela sections when kernel is built with
-fno-PIE.

kpatch tools changes:
* -mno-pic-data-is-text-relative prevents relative addressing between
  code and data. This is needed to avoid relocation error when klp text
  and data are too far apart. kpatch already includes this flag.
  However, with these changes, ARCH_KFLAGS+="-fPIC" should be added to
  s390 kpatch tools, As -mno-pic-data-is-text-relative can be used only
  with -fPIC. The corresponding pull request will be sent to kpatch
  tools.

Thank you,
Sumanth

Josh Poimboeuf (2):
  s390: Add relocs tool
  s390: Compile relocatable kernel without -fPIE

Sumanth Korikkar (2):
  s390/vdso64: filter out munaligned-symbols flag for vdso
  s390/kernel: vmlinux.lds.S: handle orphan .rela sections

 arch/s390/Kconfig                    |  15 +-
 arch/s390/Makefile                   |   8 +-
 arch/s390/boot/.gitignore            |   1 +
 arch/s390/boot/Makefile              |  14 +-
 arch/s390/boot/boot.h                |   6 +
 arch/s390/boot/startup.c             |  80 +++++-
 arch/s390/boot/vmlinux.lds.S         |  18 ++
 arch/s390/include/asm/physmem_info.h |   1 +
 arch/s390/kernel/vdso64/Makefile     |   1 +
 arch/s390/kernel/vmlinux.lds.S       |  15 ++
 arch/s390/tools/.gitignore           |   1 +
 arch/s390/tools/Makefile             |   5 +
 arch/s390/tools/relocs.c             | 390 +++++++++++++++++++++++++++
 13 files changed, 542 insertions(+), 13 deletions(-)
 create mode 100644 arch/s390/tools/relocs.c

-- 
2.40.1

