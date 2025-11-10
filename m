Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59203346AF;
	Mon, 10 Nov 2025 18:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762800890; cv=none; b=ipuV5dxAy9gew+HTKS+FM2KYkCrmsbaKKK3Wp8wJiYdorcxCeXX/n7YuTuVA/OhiqdnsmGNQGWSI12/cHhSgX2r9x6W3xe+SEtKQG0dwTHHs/uF3VR7BsCn9AB/RYHkpgLhVeXtFclVbxwT3Dcgn3ZrzTfirdabjHg1Zo0rH2wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762800890; c=relaxed/simple;
	bh=bCYRsoGxDXzF0Oq8lH5JYqekUHCWxQBDlTbWdXZZvU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sLqp7AB+3LY7OisVzA9+ISaWqWtxRIJq2XHYEpUWquQa1cbdYYtT3WYykNOtxJKUxAnZRTB1Bucr7SI2WsJqr0PzEz/HM0dM83ziCGpge+kRzKvJt97r5sH+n6AbUiXys+OQ3a6kBOQ0M0/TkN+f2gENRLK/sabqvVd2TOEONJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ce411Z2r; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ce411Z2r"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAAAfOI008189;
	Mon, 10 Nov 2025 18:54:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=BuyjfRN7YqWIPoqoeetyMHGeEoANtMQwDNr8sZzPi
	xY=; b=ce411Z2rDRpZAN2nNQvuBlsptTJM5Pkoch9YanDXPn/pSB4Mxi3NgIeWi
	kaoqa84QxTu4iDElNv48SZrZVGo/B4VsoWRWWoXONY4J56zUlU5s1UYWTmIJI+nE
	VEXAODiPlOFB7LMAs0T6YuYZZcNyXhp2Stf9QxrH/+zjR1aX3iIXBvoDEQ5V9TaK
	Ssf7hj3wx0g3Z8tz9qyCcTdCvzvAASQ8nR4EKNmvRHD3j2Cygpnfjphc31Jc62Ql
	s74P+9ONxAcxAeoF6b26jsdChJCE01ytyrqGE7IzuWNbbBttrJ9ylA792CPyYmkv
	MF0zFK4riq8oBvONPKav337zYiR3Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa3m7yyf6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 18:54:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAGZ6sD008702;
	Mon, 10 Nov 2025 18:54:45 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aah6mq4mh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 18:54:45 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AAIsekw36700482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 18:54:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBB7C20043;
	Mon, 10 Nov 2025 18:54:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BFB920040;
	Mon, 10 Nov 2025 18:54:40 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Nov 2025 18:54:40 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [RFC PATCH 0/8] s390: Remove compat support
Date: Mon, 10 Nov 2025 19:54:32 +0100
Message-ID: <20251110185440.2667511-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MtZfKmae c=1 sm=1 tr=0 ts=691234f5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=a7UK9rFi0ny4O5OO-skA:9
X-Proofpoint-GUID: ZST27KwhqNA4V0BtSnTw_PG3AyI7t895
X-Proofpoint-ORIG-GUID: ZST27KwhqNA4V0BtSnTw_PG3AyI7t895
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA3OSBTYWx0ZWRfX85y2EJBGX82g
 B7hOSRcQg7FZ/pGtC058Yn2R/XmcWouHhO8oWUx99ZUJ5NmGMCnT1s+Yj9/7rY/7/s2Ys5ZN/j/
 u7xdCIja1Aj5qeg+J3F/09rgfrKC6Bn2KWMgF0T2i/URhH/ntXpsXN8NHWvhwvsTju6cliJWeqT
 6w60Janp/LmrgN6KYcqzw5MZAJ6pqAUfbUOJT6QyA/+kbDDEsh6NruvPC90ZbRERAGHVP1Urvg6
 N3JzyDzHYFmqbu1advYzuTgL77roCXo4WjDllzm9YkCQRicAw+lyisq9O20y1EitOH+E+jyJf4T
 VcH9isrxoUJbTw7h97xGJ+emTMWZd1fRNr0YfE+TeeqIbFCMH6t7aZ6qGIRB2YXu8r41vI8o6CW
 P6Qvhxr8g51jNfJAn0IcfCNMx98qeA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080079

Remove s390 compat support to allow for code simplification and especially
reduced test effort. To the best of our knowledge there aren't any 31 bit
binaries out in the world anymore that would matter for newer kernels or
newer distributions.

Distributions do not provide compat packages since quite some time or even
have CONFIG_COMPAT disabled.

Instead of adding deprecation warnings to config option, or adding kernel
messages, just remove the code. Deprecation warnings haven't proven to be
useful. If it turns out there is still a reason to keep the compat support
this series can be reverted at any time in the future.

Arnd, we talked about this two weeks ago. I would appreciate if you could
have a look at this series, especially the last patch of this series.

Patches 1-3 are just some random cleanups / preparations.
Patches 4-6 remove compat support.
Patches 7-8 switch s390 to generic system call table generation

Thanks,
Heiko

Heiko Carstens (8):
  s390/ptrace: Rename psw_t32 to psw32_t
  s390/kvm: Use psw32_t instead of psw_compat_t
  s390/syscalls: Add pt_regs parameter to SYSCALL_DEFINE0() syscall wrapper
  tools: Remove s390 compat support
  s390: Remove compat support
  s390/uapi: Remove 31 bit support from uapi header files
  s390/syscalls: Remove system call table pointer from thread_struct
  s390/syscalls: Switch to generic system call table generation

 arch/s390/Kconfig                             |  16 -
 arch/s390/Makefile                            |   6 +-
 arch/s390/boot/ipl_data.c                     |   3 +-
 arch/s390/configs/compat.config               |   3 -
 arch/s390/hypfs/hypfs_sprp.c                  |   6 +-
 arch/s390/include/asm/compat.h                | 140 ---
 arch/s390/include/asm/elf.h                   |  47 +-
 arch/s390/include/asm/ftrace.h                |  19 +-
 arch/s390/include/asm/processor.h             |  13 +-
 arch/s390/include/asm/ptrace.h                |   2 +-
 arch/s390/include/asm/seccomp.h               |   5 -
 arch/s390/include/asm/syscall.h               |  19 +-
 arch/s390/include/asm/syscall_wrapper.h       |  95 +-
 arch/s390/include/asm/thread_info.h           |   2 -
 arch/s390/include/asm/unistd.h                |   8 +-
 arch/s390/include/asm/vdso-symbols.h          |   8 -
 arch/s390/include/uapi/asm/bitsperlong.h      |   4 -
 arch/s390/include/uapi/asm/ipcbuf.h           |   3 -
 arch/s390/include/uapi/asm/posix_types.h      |  13 -
 arch/s390/include/uapi/asm/ptrace.h           | 124 ---
 arch/s390/include/uapi/asm/sigcontext.h       |  15 -
 arch/s390/include/uapi/asm/stat.h             |  70 --
 arch/s390/include/uapi/asm/unistd.h           |   4 -
 arch/s390/kernel/Makefile                     |   4 -
 arch/s390/kernel/audit.c                      |  16 -
 arch/s390/kernel/audit.h                      |  16 -
 arch/s390/kernel/compat_audit.c               |  48 -
 arch/s390/kernel/compat_linux.c               | 289 ------
 arch/s390/kernel/compat_linux.h               | 101 ---
 arch/s390/kernel/compat_ptrace.h              |  64 --
 arch/s390/kernel/compat_signal.c              | 420 ---------
 arch/s390/kernel/entry.S                      |  17 -
 arch/s390/kernel/perf_cpum_cf.c               |   1 -
 arch/s390/kernel/perf_event.c                 |   1 -
 arch/s390/kernel/perf_regs.c                  |   3 -
 arch/s390/kernel/process.c                    |   9 +-
 arch/s390/kernel/ptrace.c                     | 524 -----------
 arch/s390/kernel/setup.c                      |   1 -
 arch/s390/kernel/signal.c                     |  23 +-
 arch/s390/kernel/stacktrace.c                 |   3 -
 arch/s390/kernel/syscall.c                    |  12 +-
 arch/s390/kernel/syscalls/Makefile            |  58 +-
 arch/s390/kernel/syscalls/syscall.tbl         | 856 ++++++++----------
 arch/s390/kernel/syscalls/syscalltbl          | 232 -----
 arch/s390/kernel/uprobes.c                    |   6 +-
 arch/s390/kernel/vdso.c                       |  26 +-
 arch/s390/kernel/vdso32/.gitignore            |   2 -
 arch/s390/kernel/vdso32/Makefile              |  64 --
 arch/s390/kernel/vdso32/gen_vdso_offsets.sh   |  15 -
 arch/s390/kernel/vdso32/note.S                |  13 -
 arch/s390/kernel/vdso32/vdso32.lds.S          | 140 ---
 arch/s390/kernel/vdso32/vdso32_wrapper.S      |  15 -
 arch/s390/kernel/vdso32/vdso_user_wrapper.S   |  22 -
 arch/s390/kvm/priv.c                          |   2 +-
 arch/s390/mm/fault.c                          |   1 -
 arch/s390/mm/mmap.c                           |   1 -
 arch/s390/pci/pci_clp.c                       |   4 +-
 drivers/s390/block/dasd.c                     |   1 -
 drivers/s390/block/dasd_eckd.c                |  11 -
 drivers/s390/block/dasd_ioctl.c               |   6 +-
 drivers/s390/char/con3270.c                   |  19 -
 drivers/s390/char/fs3270.c                    |   7 +-
 drivers/s390/char/sclp_ctl.c                  |  12 +-
 drivers/s390/char/tape_char.c                 |  26 -
 drivers/s390/char/vmcp.c                      |   7 +-
 drivers/s390/cio/chsc_sch.c                   |   7 +-
 drivers/s390/crypto/zcrypt_api.c              | 195 ----
 drivers/s390/crypto/zcrypt_card.c             |   1 -
 drivers/s390/crypto/zcrypt_queue.c            |   1 -
 drivers/s390/net/qeth_core_main.c             |   4 +-
 .../arch/s390/include/uapi/asm/bitsperlong.h  |   4 -
 tools/build/feature/test-bpf.c                |   2 +-
 tools/include/asm/barrier.h                   |   2 +-
 tools/include/nolibc/arch-s390.h              |   5 -
 tools/include/nolibc/arch.h                   |   2 +-
 tools/include/uapi/asm/bitsperlong.h          |   2 +-
 tools/include/uapi/asm/bpf_perf_event.h       |   2 +-
 tools/lib/bpf/bpf.c                           |   2 +-
 tools/lib/bpf/bpf_tracing.h                   |   2 +-
 tools/lib/bpf/libbpf.c                        |   4 -
 tools/lib/bpf/usdt.c                          |   2 -
 tools/perf/util/header.c                      |   2 +-
 tools/testing/selftests/bpf/sdt.h             |   2 +-
 tools/testing/selftests/bpf/usdt.h            |   2 +-
 .../selftests/ptrace/set_syscall_info.c       |   2 +-
 tools/testing/selftests/rseq/param_test.c     |   2 +-
 tools/testing/selftests/rseq/rseq-s390.h      |  39 -
 tools/testing/selftests/rseq/rseq.h           |   2 +-
 .../selftests/rseq/syscall_errors_test.c      |   2 +-
 tools/testing/selftests/seccomp/seccomp_bpf.c |   4 +-
 tools/testing/selftests/vDSO/vdso_config.h    |   4 -
 91 files changed, 476 insertions(+), 3545 deletions(-)
 delete mode 100644 arch/s390/configs/compat.config
 delete mode 100644 arch/s390/include/asm/compat.h
 delete mode 100644 arch/s390/kernel/audit.h
 delete mode 100644 arch/s390/kernel/compat_audit.c
 delete mode 100644 arch/s390/kernel/compat_linux.c
 delete mode 100644 arch/s390/kernel/compat_linux.h
 delete mode 100644 arch/s390/kernel/compat_ptrace.h
 delete mode 100644 arch/s390/kernel/compat_signal.c
 delete mode 100755 arch/s390/kernel/syscalls/syscalltbl
 delete mode 100644 arch/s390/kernel/vdso32/.gitignore
 delete mode 100644 arch/s390/kernel/vdso32/Makefile
 delete mode 100755 arch/s390/kernel/vdso32/gen_vdso_offsets.sh
 delete mode 100644 arch/s390/kernel/vdso32/note.S
 delete mode 100644 arch/s390/kernel/vdso32/vdso32.lds.S
 delete mode 100644 arch/s390/kernel/vdso32/vdso32_wrapper.S
 delete mode 100644 arch/s390/kernel/vdso32/vdso_user_wrapper.S

-- 
2.48.1

