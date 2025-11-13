Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD1B2F3C3F;
	Thu, 13 Nov 2025 15:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763046489; cv=none; b=Z5g/8oitnugcEr/hq3MGAHL5lNjcgxfZFsBd6hM5NS9hlC8JZ0Jwpqpe0RiCmMeXmUuQ9u0CAwVsd+jn14CYbcW3ejnPS3+hH89GuNBc6wUAVCSoneUrWp82YMuPmg0smb9bozjW4xfw1re7PGF9fKI+rc30K93xzVHYMHKwArc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763046489; c=relaxed/simple;
	bh=F8P6NHWQEct3nFEOyL+U7h1DJJaarkBySFhTY95Nb2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z6hsJaGktSf6BgcZK6BODGZ2xLprz6wqAmmpUX4V2NJrN8pf5PWaZSihtQ4AVtmwnOKYl9nHxlKxsFskYzprTaQxQN044TMWNLx4A7JJ+ZF+g+NViW6fdDwAcBc/lHZ75NtSp2HR+rLfpymeiVBve+kNh04KC2WrRuNflBaQXyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fQar0AoU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fQar0AoU"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD2UVE1002861;
	Thu, 13 Nov 2025 15:07:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=9NTmSUitK0P5PpXVCm709mlVxm77a0r7joKmMYbLT
	fk=; b=fQar0AoUhJfLZtzX0Vt3rvyUTjBp+pxFwpzhJrLikSm8Y3jT6LRX0wj+G
	XrlCqf3u6EQ10wnT6ACJm5a+tOQuZhKzQJePlXNMbzOwaNOG8dwecYfrpq/CTx3s
	aabm/re+6T7a1d2+jMIxg1P6Nlrkb4O1145Bm4FTi36sxaUWX/cXf0DMC6oGQ7cl
	La4MTHO+L0zqeuXjroAnV4d5vI6rcViS97Jwl667+JuCTGxhNR+72ChORuaEuGBv
	kBXDZtrmUn0sgc2UBnF0m2gI51faUReI/fFsNBDWqNVJnP+XfSuEMdPA/OIoBAAI
	14q3lR5wxBpe71UcAf7GOl1u8bMPA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa3m8e7c0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 15:07:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADCd835014779;
	Thu, 13 Nov 2025 15:07:35 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aahpkedfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 15:07:35 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ADF7Vvj39715090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 15:07:31 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A82520040;
	Thu, 13 Nov 2025 15:07:31 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32DB62004B;
	Thu, 13 Nov 2025 15:07:31 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Nov 2025 15:07:31 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 0/8] s390: Remove compat support
Date: Thu, 13 Nov 2025 16:07:22 +0100
Message-ID: <20251113150731.2697279-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MtZfKmae c=1 sm=1 tr=0 ts=6915f438 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=kIL1Vrm2_W73AkNJbIIA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 7lcZ9OV8MYY1TCmhCZT8BNsTvUyo7TLA
X-Proofpoint-ORIG-GUID: 7lcZ9OV8MYY1TCmhCZT8BNsTvUyo7TLA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA3OSBTYWx0ZWRfX0b4NI4dJIHe0
 o3KZ3KY2dUSmI99ntfFH/WT4pURRwVvFcrRRjjQtP/JYvSTTIia8FT0HFl3rLrHSGMMaKTjwY72
 TJLyANwP7OJ4brNkzm2F3hpxmXbEa2inaGzcGis/DKia7aBFpDBn4ign4pj9mCOnGjCdYpRe+p9
 TUnDU53nuxGWNhsNr2da9uxIdbModmh9Vgsp3qyIeqE7yRwEN2FdKmyUUzB4sKrOQB7C/GhqDnG
 ENNqM79GYz5O8sCXItibLtEDeVuNzMRjRHTfitn6ORRGIj/5SmGrPgBn/ch+HmGS47aV7HYYVvi
 bS5yllN4XYil+EqWmQPvr73xURuLmcAvhXGHYJwwHMiaPp3DEHDa1cQ2KvcAEG5OVSc4LFMhwRT
 beSXWonLz1zhiQO6AlT/o2ckFiAgLw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1011 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080079

Changes since RFC:

- Reduce changes to tools to a minimum: only change __s390__ to __s390x__
  guards if this comes with code removal. This avoids unnecessary churn and
  potential merge conflicts

- Completely remove 32-bit s390 support from nolibc

- Explicitly use sys_ni_syscall as entry point for dead system calls for
  which system call numbers still exists

- Add Arnd's Reviewed-by tag to all patches

RFC: https://lore.kernel.org/r/20251110185440.2667511-1-hca@linux.ibm.com/

---

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

Arnd, I added your Reviewed-by also to the first patch, even though this is
the only one of this series with some larger changes compared to the RFC.
Let me know if you are not ok with this.

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
 tools/include/nolibc/arch-s390.h              |   5 -
 tools/include/nolibc/arch.h                   |   2 +-
 tools/lib/bpf/libbpf.c                        |   4 -
 tools/lib/bpf/usdt.c                          |   2 -
 .../testing/selftests/nolibc/Makefile.nolibc  |   5 -
 tools/testing/selftests/nolibc/run-tests.sh   |   6 +-
 tools/testing/selftests/rseq/rseq-s390.h      |  39 -
 tools/testing/selftests/vDSO/vdso_config.h    |   4 -
 79 files changed, 462 insertions(+), 3540 deletions(-)
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

