Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519DD47F4A;
	Fri, 23 May 2025 18:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748025263; cv=none; b=AO9HMC4oklksDfcdROVm4KuKLI2+F48uTtnpnKRLrzN9aJhmYC4YGIVzsR7nuKitq7wKV1h8iyKhDGhyM3mTgL3cFV/3hAb5hzUKUBLQPnR/Woy6uGeIjgTliIOpXd1esrzl8WQHc2iu/iu24/LKIW7rgSH5i7nzBCp7OynHPgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748025263; c=relaxed/simple;
	bh=aiCDRpCM0aBAeFpIIKvCn4LoQ/Un/5gTKeDZNjIe3Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=D4TEZAQUJ0+1/gptXZ42tn9I97+MJeglWfgk31TbS1CUPXv5l4OTHun22jUXywJaqYZt8TsBsO+sCT0KmZvYFp4xskxidcG8cjP+G81JIWTYNhEh+m7RPFW6Q5D09NmK8d/p9qHCp9rzFnh/ZBxAbwN8RskkrOghjc5h2kw0OOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B31O/7kP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B31O/7kP"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NGWCZG008490;
	Fri, 23 May 2025 18:34:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=B7mk01gXFGsuT3ZTmTEQEtlJNc4hvNp7zzX1RdYXwao=; b=B31O/7kP
	JaBh5LAAMTW+10ymZn9CYrRmWqx/jAPsBr4rgVtIP8y7XFyDXbqTpCCY9D8NbH9x
	A4Qq4NO5Zm1/j2du4SypI+vfVlfAt63obaYBQOjyS+XlzKl1HYh2LkPt6GXQbaXa
	Bov53kHRpyukMxui4W2SgXwq8jLsCD+nTTRvvjc1enT9W/bWg+3M36QReGvjhE6G
	DVPC2tlWc/JK+I5AKAc9O+ont5Iz6M+8VyCIr3q0Yk+I0HN0IFIPZAuK6mrVHf4S
	tw7zYcEvvtWs7H0YWnt72+nWJqmUlTJeZNGFlxV4qp6z/n05aoBKNXEzlu89KRZD
	DARgjPgw7NTRbQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46sxhwhgva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 May 2025 18:34:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54NI8f58032122;
	Fri, 23 May 2025 18:34:18 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46rwnmqwvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 May 2025 18:34:18 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54NIYEZw48169352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 May 2025 18:34:14 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B2DD20040;
	Fri, 23 May 2025 18:34:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 03E5720043;
	Fri, 23 May 2025 18:34:14 +0000 (GMT)
Received: from osiris (unknown [9.111.6.167])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 23 May 2025 18:34:13 +0000 (GMT)
Date: Fri, 23 May 2025 20:34:12 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 updates for 6.16 merge window
Message-ID: <20250523183412.8641Ac6-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDE2OSBTYWx0ZWRfX6a8U445BmLRv K9wFJJDcYpTXXztkbuY7h5KH1pZeH+N4SeMP5F1BPA8BFD6UTFY4XBtkSdNX4eJ6d3u2ZxS39tT xGZ/shexEw46nP5gSsD/SGP/QpyMCmZIjfaMJglt7vX0HgRi9YyfC12q9dFAnRGpda8OPuO7Omn
 RbmriWMLl7DYNj70aIOQGngplYLxrWlmAkSGR02ldoz9CEgl1JMXFV9FdPCSXovInOinmqhY8Zw Jhlt6317RAp6FTTlVn9CROs4eGY9D6U3uTVihhzB2PQPshw7/MNwamsWWRkY5R3qTYcJ/sAHqR4 kvhWMXKz/7fvU4kVcRhygaRzh8Z4s9EcvapgwMZ+mdna0ud0NZs+/8gd7nhE8w+cJtOnJlbH6Z6
 D13Y/LtNWimXJtSH4dq5hImSZotxtnOM3gwzhcVpGBJTGhqx8PcnhF6y6IkV3iMHtLvTYZCY
X-Proofpoint-GUID: r8hgU4K1kNz_gDvPBM17piHuQ5spAPW-
X-Authority-Analysis: v=2.4 cv=O685vA9W c=1 sm=1 tr=0 ts=6830bfab cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=RuseMzuXUqbHZjU2If8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: r8hgU4K1kNz_gDvPBM17piHuQ5spAPW-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_06,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505230169

Hi Linus,

please pull s390 updates for the 6.16 merge window.

Thanks,
Heiko

The following changes since commit 8ffd015db85fea3e15a77027fda6c02ced4d2444:

  Linux 6.15-rc2 (2025-04-13 11:54:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.16-1

for you to fetch changes up to 774a1fa880bc949d88b5ddec9494a13be733dfa8:

  s390/pci: Serialize device addition and removal (2025-05-22 16:12:53 +0200)

----------------------------------------------------------------
s390 updates for 6.16 merge window

- Large rework of the protected key crypto code to allow for asynchronous
  handling without memory allocation

- Speed up system call entry/exit path by re-implementing lazy ASCE
  handling

- Add module autoload support for the diag288_wdt watchdog device driver

- Get rid of s390 specific strcpy() and strncpy() implementations, and
  switch all remaining users to strscpy() when possible

- Various other small fixes and improvements

----------------------------------------------------------------
Gerald Schaefer (1):
      s390/extmem: Add workaround for DCSS unload diag

Harald Freudenberger (28):
      s390/ap: Move response_type struct into ap_msg struct
      s390/ap/zcrypt: Rework AP message buffer allocation
      s390/ap: Introduce ap message buffer pool
      s390/zcrypt: Avoid alloc and copy of ep11 targets if kernelspace cprb
      s390/ap/zcrypt: New xflag parameter
      s390/zcrypt: Introduce cprb mempool for cca misc functions
      s390/zcrypt: Introduce cprb mempool for ep11 misc functions
      s390/zcrypt: Rework zcrypt function zcrypt_device_status_mask_ext
      s390/zcrypt: Introduce pre-allocated device status array for cca misc
      s390/zcrypt: Introduce pre-allocated device status array for ep11 misc
      s390/zcrypt: Remove unused functions from cca misc
      s390/zcrypt: Remove CCA and EP11 card and domain info caches
      s390/zcrypt: Rework cca findcard() implementation and callers
      s390/zcrypt: Rework ep11 findcard() implementation and callers
      s390/zcrypt: Rework cca misc functions kmallocs to use the cprb mempool
      s390/zcrypt: Propagate xflags argument with cca_get_info()
      s390/zcrypt: Locate ep11_domain_query_info onto the stack instead of kmalloc
      s390/zcrypt: Rework ep11 misc functions to use cprb mempool
      s390/pkey: Rework CCA pkey handler to use stack for small memory allocs
      s390/pkey: Rework EP11 pkey handler to use stack for small memory allocs
      s390/uv: Rename find_secret() to uv_find_secret() and publish
      s390/pkey: Use preallocated memory for retrieve of UV secret metadata
      s390/uv: Remove uv_get_secret_metadata function
      s390/pkey: Provide and pass xflags within pkey and zcrypt layers
      s390/pkey/crypto: Introduce xflags param for pkey in-kernel API
      s390/cpacf: Rework cpacf_pcc() to return condition code
      s390/crypto: Rework protected key AES for true asynch support
      s390/crypto: Extend protected key conversion retry loop

Heiko Carstens (17):
      s390/mm: Reimplement lazy ASCE handling
      s390/mm: Select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
      watchdog: diag288_wdt: Implement module autoload
      s390/string: Remove optimized strncpy()
      s390/ipl: Rename and change strncpy_skip_quote()
      s390: Remove optional third argument of strscpy() if possible
      Merge branch 'zcrypt-no-alloc'
      s390: Simple strcpy() to strscpy() conversions
      s390/boot: Use strspcy() instead of strcpy()
      s390/con3270: Use strscpy() instead of strcpy()
      s390/string: Remove strcpy() implementation
      s390/mm: Add mmap_assert_write_locked() check to crst_table_upgrade()
      s390/mm: Fix potential use-after-free in __crst_table_upgrade()
      Merge branch 'prot-key-async'
      s390/thread_info: Cleanup header includes
      s390/ptrace: Always inline regs_get_kernel_stack_nth() and regs_get_register()
      s390/pci: Fix __pcilg_mio_inuser() inline assembly

Niklas Schnelle (4):
      s390/pci: Remove redundant bus removal and disable from zpci_release_device()
      s390/pci: Prevent self deletion in disable_slot()
      s390/pci: Allow re-add of a reserved but not yet removed device
      s390/pci: Serialize device addition and removal

Thomas Richter (1):
      s390/cpumf: Adjust number of leading zeroes for z15 attributes

Vasily Gorbik (2):
      s390/boot: Add sized_strscpy() to enable strscpy() usage
      s390/boot: Replace strncpy() with strscpy()

 arch/s390/Kconfig                      |    1 +
 arch/s390/boot/ipl_parm.c              |    7 +-
 arch/s390/boot/printk.c                |    7 +-
 arch/s390/boot/startup.c               |   17 +
 arch/s390/boot/string.c                |   12 +
 arch/s390/crypto/paes_s390.c           | 1867 ++++++++++++++++++++++----------
 arch/s390/include/asm/asce.h           |   36 +
 arch/s390/include/asm/cpacf.h          |   18 +-
 arch/s390/include/asm/cpufeature.h     |    1 +
 arch/s390/include/asm/diag288.h        |   41 +
 arch/s390/include/asm/futex.h          |    6 +
 arch/s390/include/asm/machine.h        |    1 +
 arch/s390/include/asm/mmu_context.h    |   17 +-
 arch/s390/include/asm/pkey.h           |   15 +-
 arch/s390/include/asm/ptrace.h         |   47 +-
 arch/s390/include/asm/string.h         |   20 -
 arch/s390/include/asm/thread_info.h    |    5 +-
 arch/s390/include/asm/uaccess.h        |   12 +
 arch/s390/include/asm/uv.h             |    5 +-
 arch/s390/kernel/asm-offsets.c         |    1 -
 arch/s390/kernel/cert_store.c          |    2 +-
 arch/s390/kernel/cpufeature.c          |    5 +
 arch/s390/kernel/crash_dump.c          |    2 +-
 arch/s390/kernel/debug.c               |    2 +-
 arch/s390/kernel/entry.S               |   20 +-
 arch/s390/kernel/ipl.c                 |   27 +-
 arch/s390/kernel/perf_cpum_cf_events.c |    4 +-
 arch/s390/kernel/processor.c           |   16 +-
 arch/s390/kernel/ptrace.c              |   33 -
 arch/s390/kernel/smp.c                 |    2 +-
 arch/s390/kernel/uv.c                  |   47 +-
 arch/s390/lib/string.c                 |   47 -
 arch/s390/lib/uaccess.c                |    5 +-
 arch/s390/mm/extmem.c                  |   18 +-
 arch/s390/mm/pgalloc.c                 |   17 +-
 arch/s390/pci/pci.c                    |   45 +-
 arch/s390/pci/pci_bus.h                |    7 +-
 arch/s390/pci/pci_event.c              |   22 +-
 arch/s390/pci/pci_mmio.c               |   12 +-
 drivers/pci/hotplug/s390_pci_hpc.c     |    2 +-
 drivers/s390/block/dcssblk.c           |    4 +-
 drivers/s390/char/con3270.c            |   17 +-
 drivers/s390/char/diag_ftp.c           |    2 +-
 drivers/s390/crypto/ap_bus.c           |   74 ++
 drivers/s390/crypto/ap_bus.h           |   30 +-
 drivers/s390/crypto/pkey_api.c         |   50 +-
 drivers/s390/crypto/pkey_base.c        |   34 +-
 drivers/s390/crypto/pkey_base.h        |   37 +-
 drivers/s390/crypto/pkey_cca.c         |  136 ++-
 drivers/s390/crypto/pkey_ep11.c        |  117 +-
 drivers/s390/crypto/pkey_pckmo.c       |    9 +-
 drivers/s390/crypto/pkey_sysfs.c       |    4 +-
 drivers/s390/crypto/pkey_uv.c          |   44 +-
 drivers/s390/crypto/zcrypt_api.c       |  167 +--
 drivers/s390/crypto/zcrypt_api.h       |   16 +-
 drivers/s390/crypto/zcrypt_ccamisc.c   |  486 +++------
 drivers/s390/crypto/zcrypt_ccamisc.h   |   49 +-
 drivers/s390/crypto/zcrypt_cex4.c      |   41 +-
 drivers/s390/crypto/zcrypt_ep11misc.c  |  454 ++++----
 drivers/s390/crypto/zcrypt_ep11misc.h  |   27 +-
 drivers/s390/crypto/zcrypt_msgtype50.c |   36 +-
 drivers/s390/crypto/zcrypt_msgtype6.c  |  109 +-
 drivers/s390/net/ctcm_mpc.c            |    2 +-
 drivers/watchdog/diag288_wdt.c         |   53 +-
 64 files changed, 2612 insertions(+), 1857 deletions(-)
 create mode 100644 arch/s390/include/asm/asce.h
 create mode 100644 arch/s390/include/asm/diag288.h
