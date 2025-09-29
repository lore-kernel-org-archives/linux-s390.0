Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490702D6E5A;
	Mon, 29 Sep 2025 09:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138718; cv=none; b=O3TpEEDC7iE3+TTRs8HJfhGiqdAWUc9RB/047sxBXj8cqCkpZv9i/umIoxSH0/AHQ9dLrTcY+dnEt9i4eUskXzetskt5+FB3QF3GWimI/2G3wleaI+di0U6JRG5lux9DNaFcWyoa54/Q7oo+XkHJJa2HDsI9KgHn4H7xaqZMUTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138718; c=relaxed/simple;
	bh=ip8Eiq2XA6/9VARQIRsUHVWiOBL5GT7+/j4xcsAiKB0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=k0kt93iah5IZBpImMu7XjpnIBe9l304utDiouy84IXJgdCXHrJEJCTrAv14XfS7LJMPz7LnmbRz/KL4k2lLbITu4dP20B98BAq3lLoOAiOXxk3+jCKKVv/uZfZSXN/5hJrBG7t1Twzs8CTszOoHoPw3bPk+F1UNhNKWYxanJkcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BKnHSUlz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BKnHSUlz"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58T2g48k023884;
	Mon, 29 Sep 2025 09:38:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=2YsSXLVIXynIeARnPuBqEq+VbUJn+hTPvt+N/H5mMSQ=; b=BKnHSUlz
	ABsW7Lu4JHIiaQbOclmazrsIMB8dYtREPU/Pa9GuG6IBmtTv77Id3ei5JCfKS1nG
	pAh2MoAIhlB2suzzsQv7pEY5uGfD9LsFHDPy5rhFy/pJTC2mwXb+24iLhMl7bKvd
	zPpFpzQb5q4jRBpteV8bLK5zj1Qc87ISi/6lwjd6CwMpt2BEfvksrlcFMzAjvKGS
	kLdwuVMlOIO+CuFwBsD/ewZ1xW1oQWiMj0Dx5T9FK/fcziEUjL4H6OlUkNyZopsm
	M9W4kCMXKkOBkoydrdhF6eGWILsM1MFRJGQ8h4rj4mz5QYWdwT9qVLVKzxatAgRK
	Jw5HDOjgsH8LSw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7n7hcur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Sep 2025 09:38:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58T8cpC6003314;
	Mon, 29 Sep 2025 09:38:33 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49etmxnhw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Sep 2025 09:38:33 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58T9cTMp52625772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Sep 2025 09:38:29 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 582FF2004B;
	Mon, 29 Sep 2025 09:38:29 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 368E820040;
	Mon, 29 Sep 2025 09:38:29 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 29 Sep 2025 09:38:29 +0000 (GMT)
Date: Mon, 29 Sep 2025 11:38:28 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 updates for 6.18 merge window
Message-ID: <20250929093828.2714469Af2-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oWId0oa6XwY_W5FlQ1zxSkB4pcx3qUgL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfX2p2dhfxQkFHP
 ieb3KKs2q0e11Wn/VJgZcTVCEIkIDQUEOjF9J3l+BOhCHHyhYWVrsJjE2bifkqiFUEcU082bvxV
 gIAfdhgNHKgT2jsJ2c2cz4S+NvPMTYxQ4W89anzxMnlnDwsq6LchPVjVAbljQ5ddoqNakJz7z4I
 NWU1kD7sA+wEW9/3own01dnCzerDxcEQiQOhk8LWi3PNsW+cjqtTMLB45gXbrmZlOvMbOIChoXR
 A+uB/0Sh4HqoVNScWJCPTEmRV0gW+FETs9dqxuP0UHFDsQobEHVXZK93FIgJoeUmbZAZ9ECzmHI
 MkfmMmmShpDpElJds2UTD0y1zGeiYn2wZjJNENcemiruwMDzJK6YG6dl2Yq7BnNw/52Try2Eive
 XfUQSonkYub3mjQc2USZ0hZHTiXGgQ==
X-Proofpoint-GUID: oWId0oa6XwY_W5FlQ1zxSkB4pcx3qUgL
X-Authority-Analysis: v=2.4 cv=T7qBjvKQ c=1 sm=1 tr=0 ts=68da539a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=qNABUOcEAAAA:8
 a=AECGYZeCvL7t0wi-xxIA:9 a=CjuIK1q_8ugA:10 a=Ytm653ucTKQjCvbzLygB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_03,2025-09-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 clxscore=1011 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025

Hi Linus,

please pull s390 updates for the 6.18 merge window.

There are two merge conflicts:

With the net-next tree resolved in linux-next:
https://lore.kernel.org/linux-next/aNKbgf7GyU5JP3Zh@finisterre.sirena.org.uk/
---
diff --cc arch/s390/configs/debug_defconfig
index b692c95f8083,fdde8ee0d7bd..000000000000
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@@ -118,15 -118,12 +118,17 @@@ CONFIG_PACKET=
  CONFIG_PACKET_DIAG=m
  CONFIG_UNIX=y
  CONFIG_UNIX_DIAG=m
 +CONFIG_TLS=m
 +CONFIG_TLS_DEVICE=y
 +CONFIG_TLS_TOE=y
  CONFIG_XFRM_USER=m
  CONFIG_NET_KEY=m
 +CONFIG_XDP_SOCKETS=y
 +CONFIG_XDP_SOCKETS_DIAG=m
+ CONFIG_DIBS=y
+ CONFIG_DIBS_LO=y
+ CONFIG_SMC=m
  CONFIG_SMC_DIAG=m
- CONFIG_SMC_LO=y
  CONFIG_INET=y
  CONFIG_IP_MULTICAST=y
  CONFIG_IP_ADVANCED_ROUTER=y
diff --cc arch/s390/configs/defconfig
index 22c801449139,bf9e7dbd4a89..000000000000
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@@ -109,15 -109,12 +109,17 @@@ CONFIG_PACKET=
  CONFIG_PACKET_DIAG=m
  CONFIG_UNIX=y
  CONFIG_UNIX_DIAG=m
 +CONFIG_TLS=m
 +CONFIG_TLS_DEVICE=y
 +CONFIG_TLS_TOE=y
  CONFIG_XFRM_USER=m
  CONFIG_NET_KEY=m
 +CONFIG_XDP_SOCKETS=y
 +CONFIG_XDP_SOCKETS_DIAG=m
+ CONFIG_DIBS=y
+ CONFIG_DIBS_LO=y
+ CONFIG_SMC=m
  CONFIG_SMC_DIAG=m
- CONFIG_SMC_LO=y
  CONFIG_INET=y
  CONFIG_IP_MULTICAST=y
  CONFIG_IP_ADVANCED_ROUTER=y
---

And with the kspp tree also resolved in linux-next:
https://lore.kernel.org/linux-next/aNVUMLnpNVGWz7Pb@sirena.org.uk/
---
diff --cc arch/s390/include/asm/bitops.h
index 1564dd3a5a82,fbcc3e1cc776..000000000000
--- a/arch/s390/include/asm/bitops.h
+++ b/arch/s390/include/asm/bitops.h
@@@ -189,26 -191,58 +189,26 @@@ static __always_inline __attribute_cons
   * This is defined the same way as the libc and
   * compiler builtin ffs routines (man ffs).
   */
- static __always_inline __flatten int ffs(int word)
 -static inline __attribute_const__ int ffs(int word)
++static __always_inline __flatten __attribute_const__ int ffs(int word)
  {
 -	unsigned long mask = 2 * BITS_PER_LONG - 1;
  	unsigned int val = (unsigned int)word;
  
 -	return (1 + (__flogr(-val & val) ^ (BITS_PER_LONG - 1))) & mask;
 +	return BITS_PER_LONG - __flogr(-val & val);
  }
  
 -/**
 - * __fls - find last (most-significant) set bit in a long word
 - * @word: the word to search
 - *
 - * Undefined if no set bit exists, so code should check against 0 first.
 - */
 -static inline __attribute_const__ unsigned long __fls(unsigned long word)
 -{
 -	return __flogr(word) ^ (BITS_PER_LONG - 1);
 -}
 +#else /* CONFIG_CC_HAS_BUILTIN_FFS */
  
 -/**
 - * fls64 - find last set bit in a 64-bit word
 - * @word: the word to search
 - *
 - * This is defined in a similar way as the libc and compiler builtin
 - * ffsll, but returns the position of the most significant set bit.
 - *
 - * fls64(value) returns 0 if value is 0 or the position of the last
 - * set bit if value is nonzero. The last (most significant) bit is
 - * at position 64.
 - */
 -static inline __attribute_const__ int fls64(unsigned long word)
 -{
 -	unsigned long mask = 2 * BITS_PER_LONG - 1;
 +#include <asm-generic/bitops/builtin-ffs.h>
  
 -	return (1 + (__flogr(word) ^ (BITS_PER_LONG - 1))) & mask;
 -}
 -
 -/**
 - * fls - find last (most-significant) bit set
 - * @word: the word to search
 - *
 - * This is defined the same way as ffs.
 - * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
 - */
 -static inline __attribute_const__ int fls(unsigned int word)
 -{
 -	return fls64(word);
 -}
 +#endif /* CONFIG_CC_HAS_BUILTIN_FFS */
  
 +#include <asm-generic/bitops/builtin-__ffs.h>
 +#include <asm-generic/bitops/ffz.h>
 +#include <asm-generic/bitops/builtin-__fls.h>
 +#include <asm-generic/bitops/builtin-fls.h>
 +#include <asm-generic/bitops/fls64.h>
  #include <asm/arch_hweight.h>
  #include <asm-generic/bitops/const_hweight.h>
 -#include <asm-generic/bitops/ffz.h>
  #include <asm-generic/bitops/sched.h>
  #include <asm-generic/bitops/le.h>
  #include <asm-generic/bitops/ext2-atomic-setbit.h>
---

Thanks,
Alexander

The following changes since commit c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9:

  Linux 6.17-rc2 (2025-08-17 15:22:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.18-1

for you to fetch changes up to 088bb10e37252034ec58a6152f20bfdc8a837f54:

  s390/mm: Add memory allocation profiling hooks (2025-09-25 14:28:58 +0200)

----------------------------------------------------------------
s390 updates for 6.18 merge window

- Refactor SCLP memory hotplug code

- Introduce common boot_panic() decompressor helper macro and
  use it to get rid of nearly few identical implementations

- Take into account additional key generation flags and forward
  it to the ep11 implementation. With that allow users to modify
  the key generation process, e.g. provide valid combinations of
  XCP_BLOB_* flags

- Replace kmalloc() + copy_from_user() with memdup_user_nul()
  in s390 debug facility and HMC driver

- Add DAX support for DCSS memory block devices

- Make the compiler statement attribute "assume" available with
  a new __assume macro

- Rework ffs() and fls() family bitops functions, including
  source code improvements and generated code optimizations.
  Use the newly introduced __assume macro for that

- Enable additional network features in default configurations

- Use __GFP_ACCOUNT flag for user page table allocations to add
  missing kmemcg accounting

- Add WQ_PERCPU flag to explicitly request the use of the per-CPU
  workqueue for 3590 tape driver

- Switch power reading to the per-CPU and the Hiperdispatch to the
  default workqueue

- Add memory allocation profiling hooks to allow better profiling
  data and the /proc/allocinfo output similar to other architectures

----------------------------------------------------------------
Gerald Schaefer (1):
      s390/dcssblk: Add DAX support

Harald Freudenberger (1):
      s390/pkey: Forward keygenflags to ep11_unwrapkey

Heiko Carstens (10):
      s390/bitops: Slightly optimize ffs() and fls64()
      s390/boot: Add common boot_panic() code
      s390/bitops: Limit return value range of __flogr()
      compiler_types: Add __assume macro
      s390/bitops: Use __assume() for __flogr() inline assembly return value
      s390/bitops: Cleanup __flogr()
      s390/mm: Use __GFP_ACCOUNT for user page table allocations
      s390/bitops: Switch to generic fls(), fls64(), etc.
      s390/bitops: Switch to generic ffs() if supported by compiler
      s390/mm: Add memory allocation profiling hooks

Hendrik Brueckner (1):
      s390/configs: Enable additional network features

Juergen Christ (1):
      s390/bitops: Optimize inlining

Marco Crivellari (3):
      s390/tape: Add WQ_PERCPU to alloc_workqueue users
      s390/diag324: Replace use of system_wq with system_percpu_wq
      s390: Replace use of system_wq with system_dfl_wq

Sumanth Korikkar (2):
      s390/sclp: Refactor sclp_cmd.c
      s390/sclp: Move memory hotplug code for better modularity

Thorsten Blum (2):
      s390/debug: Replace kmalloc() + copy_from_user() with memdup_user_nul()
      s390/hmcdrv: Replace kmalloc() + copy_from_user() with memdup_user_nul()

 arch/s390/Kconfig                     |   7 +
 arch/s390/boot/boot.h                 |   8 +
 arch/s390/boot/decompressor.c         |   4 +-
 arch/s390/boot/physmem_info.c         |   4 +-
 arch/s390/boot/startup.c              |  13 +-
 arch/s390/configs/debug_defconfig     |   6 +
 arch/s390/configs/defconfig           |   6 +
 arch/s390/include/asm/bitops.h        |  88 ++-----
 arch/s390/include/asm/pgalloc.h       |  30 ++-
 arch/s390/kernel/debug.c              |  12 +-
 arch/s390/kernel/diag/diag324.c       |   4 +-
 arch/s390/kernel/hiperdispatch.c      |   2 +-
 arch/s390/mm/pgalloc.c                |  19 +-
 drivers/s390/block/Kconfig            |  12 +-
 drivers/s390/block/dcssblk.c          |  35 ++-
 drivers/s390/char/Makefile            |   1 +
 drivers/s390/char/hmcdrv_dev.c        |  19 +-
 drivers/s390/char/sclp_cmd.c          | 478 +++-------------------------------
 drivers/s390/char/sclp_mem.c          | 399 ++++++++++++++++++++++++++++
 drivers/s390/char/tape_3590.c         |   2 +-
 drivers/s390/crypto/zcrypt_ep11misc.c |   4 +-
 include/linux/compiler_types.h        |  23 ++
 init/Kconfig                          |  10 +
 23 files changed, 611 insertions(+), 575 deletions(-)
 create mode 100644 drivers/s390/char/sclp_mem.c
