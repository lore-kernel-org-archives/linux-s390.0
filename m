Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A8E387370;
	Fri, 13 Mar 2026 09:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773395248; cv=none; b=BJ6mZQURgM1NvHRx19NkEtMkXlmUvAQYuh9uTNvr5h5CnZZQ/CDSuNKpBBy6surMsMT4MzG0GvXk9U8Q4f1heisQIs6k73N9QCZejSLLnjR7Ewf6muh8sRVrOUi8/S+SyzHbBw+3m1JpcntuHQuGa7TxskKUTFSw11m/PRzSTqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773395248; c=relaxed/simple;
	bh=MFJ9b4yHc2E1Yph79Dii89VlwizOkONNhtg1BW4N74A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UheTtaRmYBjmC+ltJeCCYV/uzM9lfJSeDT48KcrrGwpohfgHybVorUbhSOXFnKG5bOmwZkgD+M+cR3czbH950GoPji/cjre7QvwkrQmYd7gYciIsN5iCBgoabxd8/Lhl3Vftqn138QJR7bN5EZYrFKoLzmI2Xw1b9qtdPFxyfes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=HAU5kaZr; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="HAU5kaZr"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=uUvR+81wm+zWhWtbzjXtYMG1VZZm3awUgeEKEtwQxng=;
	b=HAU5kaZr4rNFR9Gi3VIvT/X0pimy0yJ1CkXegGn3JQ0ZS+OzHoOoEl5rcKg4I+2A7rAEIrN3w
	plOl8fk+HE/SSTIx5dd3BwUnFdH/+1NJc4nm3oiKNZ9NgatIrkeKQICooAvIb25ffkhaLXVgFsk
	W/FfaUtio4oUf1JomTFJz9I=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4fXKJr5RjSzLlTZ;
	Fri, 13 Mar 2026 17:42:20 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 2E70540565;
	Fri, 13 Mar 2026 17:47:17 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 13 Mar
 2026 17:47:15 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<hca@linux.ibm.com>, <gor@linux.ibm.com>, <agordeev@linux.ibm.com>,
	<borntraeger@linux.ibm.com>, <svens@linux.ibm.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <arnd@arndb.de>, <shuah@kernel.org>, <kees@kernel.org>,
	<luto@amacapital.net>, <wad@chromium.org>, <kevin.brodsky@arm.com>,
	<charlie@rivosinc.com>, <macro@orcam.me.uk>, <deller@gmx.de>,
	<ldv@strace.io>, <anshuman.khandual@arm.com>, <song@kernel.org>,
	<ryan.roberts@arm.com>, <mark.rutland@arm.com>, <ada.coupriediaz@arm.com>,
	<broonie@kernel.org>, <pengcan@kylinos.cn>, <liqiang01@kylinos.cn>,
	<thuth@redhat.com>, <andreas@gaisler.com>,
	<schuster.simon@siemens-energy.com>, <jremus@linux.ibm.com>,
	<jgross@suse.com>, <mathieu.desnoyers@efficios.com>, <yeoreum.yun@arm.com>,
	<kmal@cock.li>, <dvyukov@google.com>, <akpm@linux-foundation.org>,
	<reddybalavignesh9979@gmail.com>, <richard.weiyang@gmail.com>,
	<x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v13 00/12] arm64: entry: Convert to Generic Entry
Date: Fri, 13 Mar 2026 17:47:26 +0800
Message-ID: <20260313094738.3985794-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500011.china.huawei.com (7.185.36.131)

Currently, x86, Riscv, Loongarch use the Generic Entry which makes
maintainers' work easier and codes more elegant. arm64 has already
successfully switched to the Generic IRQ Entry in commit
b3cf07851b6c ("arm64: entry: Switch to generic IRQ entry"), it is
time to completely convert arm64 to Generic Entry.

The goal is to bring arm64 in line with other architectures that already
use the generic entry infrastructure, reducing duplicated code and
making it easier to share future changes in entry/exit paths, such as
"Syscall User Dispatch" and RSEQ optimizations.

This patch set is rebased on v7.0-rc3. And the performance
benchmarks results on qemu-kvm are below:

perf bench syscall usec/op (-ve is improvement)

| Syscall | Base        | Generic Entry | change % |
| ------- | ----------- | ------------- | -------- |
| basic   | 0.123997    | 0.120872      | -2.57    |
| execve  | 512.1173    | 504.9966      | -1.52    |
| fork    | 114.1144    | 113.2301      | -1.06    |
| getpgid | 0.120182    | 0.121245      | +0.9     |

perf bench syscall ops/sec (+ve is improvement)

| Syscall | Base     | Generic Entry| change % |
| ------- | -------- | ------------ | -------- |
| basic   | 8064712  | 8273212      | +2.48    |
| execve  | 1952     | 1980         | +1.52    |
| fork    | 8763     | 8832         | +1.06    |
| getpgid | 8320704  | 8247810      | -0.9     |

Therefore, the syscall performance variation ranges from a 1% regression
to a 2.5% improvement.

IPI latency benchmark (-ve is improvement)

| Metric         | Base (ns)     | Generic Entry (ns)| % Change |
| -------------- | ------------- | ----------------  | -------- |
| Dry run        |  1068988.5    |  1072546.5        | +0.33%   |
| Self IPI       |  6362086.5    |  6334899          | -0.43%   |
| Normal IPI     |  174613249    |  183019457        | +4.81%   |
| Broadcast IPI  |  455716928    |  437884726        | -3.91%   |
| Broadcast lock |  469317979    |  449988738.5      | -4.12%   |

Therefore, the IPI performance variation ranges from a 4.8% regression
to a 4% improvement.

It was tested ok with following test cases on QEMU virt platform:
 - Stress-ng CPU stress test.
 - Hackbench stress test.
 - "sud" selftest testcase.
 - get_set_sud, get_syscall_info, set_syscall_info, peeksiginfo
   in tools/testing/selftests/ptrace.
 - breakpoint_test_arm64 in selftests/breakpoints.
 - syscall-abi and ptrace in tools/testing/selftests/arm64/abi
 - fp-ptrace, sve-ptrace, za-ptrace in selftests/arm64/fp.
 - vdso_test_getrandom in tools/testing/selftests/vDSO
 - Strace tests.

The test QEMU configuration is as follows:

	qemu-system-aarch64 \
		-M virt \
		-enable-kvm \
		-cpu host \
		-kernel Image \
		-smp 8 \
		-m 512m \
		-nographic \
		-no-reboot \
		-device virtio-rng-pci \
		-append "root=/dev/vda rw console=ttyAMA0 kgdboc=ttyAMA0,115200 \
			earlycon preempt=voluntary irqchip.gicv3_pseudo_nmi=1 audit=1" \
		-drive if=none,file=images/rootfs.ext4,format=raw,id=hd0 \
		-device virtio-blk-device,drive=hd0 \

Changes in v13:
- Rebased on v7.0-rc3, so drop the firt applied arm64 patch.
- Use generic TIF bits to enables RSEQ optimization.
- Update most of the commit message to make it more clear.
- Link to v12: https://lore.kernel.org/all/20260203133728.848283-1-ruanjinjie@huawei.com/

Changes in v12:
- Rebased on "sched/core", so remove the four generic entry patches.
- Move "Expand secure_computing() in place" and
  "Use syscall_get_arguments() helper" patch forward, which will group all
  non-functional cleanups at the front.
- Adjust the explanation for moving rseq_syscall() before
  audit_syscall_exit().
- Link to v11: https://lore.kernel.org/all/20260128031934.3906955-1-ruanjinjie@huawei.com/

Changes in v11:
- Remove unused syscall in syscall_trace_enter().
- Update and provide a detailed explanation of the differences after
  moving rseq_syscall() before audit_syscall_exit().
- Rebased on arm64 (for-next/entry), and remove the first applied 3 patchs.
- syscall_exit_to_user_mode_work() for arch reuse instead of adding
  new syscall_exit_to_user_mode_work_prepare() helper.
- Link to v10: https://lore.kernel.org/all/20251222114737.1334364-1-ruanjinjie@huawei.com/

Changes in v10:
- Rebased on v6.19-rc1, rename syscall_exit_to_user_mode_prepare() to
  syscall_exit_to_user_mode_work_prepare() to avoid conflict.
- Also inline syscall_trace_enter().
- Support aarch64 for sud_benchmark.
- Update and correct the commit message.
- Add Reviewed-by.
- Link to v9: https://lore.kernel.org/all/20251204082123.2792067-1-ruanjinjie@huawei.com/

Changes in v9:
- Move "Return early for ptrace_report_syscall_entry() error" patch ahead
  to make it not introduce a regression.
- Not check _TIF_SECCOMP/SYSCALL_EMU for syscall_exit_work() in
  a separate patch.
- Do not report_syscall_exit() for PTRACE_SYSEMU_SINGLESTEP in a separate
  patch.
- Add two performance patch to improve the arm64 performance.
- Add Reviewed-by.
- Link to v8: https://lore.kernel.org/all/20251126071446.3234218-1-ruanjinjie@huawei.com/

Changes in v8:
- Rename "report_syscall_enter()" to "report_syscall_entry()".
- Add ptrace_save_reg() to avoid duplication.
- Remove unused _TIF_WORK_MASK in a standalone patch.
- Align syscall_trace_enter() return value with the generic version.
- Use "scno" instead of regs->syscallno in el0_svc_common().
- Move rseq_syscall() ahead in a standalone patch to clarify it clearly.
- Rename "syscall_trace_exit()" to "syscall_exit_work()".
- Keep the goto in el0_svc_common().
- No argument was passed to __secure_computing() and check -1 not -1L.
- Remove "Add has_syscall_work() helper" patch.
- Move "Add syscall_exit_to_user_mode_prepare() helper" patch later.
- Add miss header for asm/entry-common.h.
- Update the implementation of arch_syscall_is_vdso_sigreturn().
- Add "ARCH_SYSCALL_WORK_EXIT" to be defined as "SECCOMP | SYSCALL_EMU"
  to keep the behaviour unchanged.
- Add more testcases test.
- Add Reviewed-by.
- Update the commit message.
- Link to v7: https://lore.kernel.org/all/20251117133048.53182-1-ruanjinjie@huawei.com/

Jinjie Ruan (11):
  arm64/ptrace: Refactor syscall_trace_enter/exit() to accept flags
    parameter
  arm64/ptrace: Expand secure_computing() in place
  arm64/ptrace: Use syscall_get_arguments() helper for audit
  arm64: ptrace: Move rseq_syscall() before audit_syscall_exit()
  arm64: syscall: Introduce syscall_exit_to_user_mode_work()
  arm64/ptrace: Define and use _TIF_SYSCALL_EXIT_WORK
  arm64/ptrace: Skip syscall exit reporting for PTRACE_SYSEMU_SINGLESTEP
  arm64: entry: Convert to generic entry
  arm64: Inline el0_svc_common()
  s390: Rename TIF_SINGLE_STEP to TIF_SINGLESTEP
  arm64: Use generic TIF bits for common thread flags

kemal (1):
  selftests: sud_test: Support aarch64

 arch/arm64/Kconfig                            |   3 +-
 arch/arm64/include/asm/entry-common.h         |  76 ++++++++++++
 arch/arm64/include/asm/syscall.h              |  19 ++-
 arch/arm64/include/asm/thread_info.h          |  76 ++++--------
 arch/arm64/kernel/debug-monitors.c            |   7 ++
 arch/arm64/kernel/ptrace.c                    | 115 ------------------
 arch/arm64/kernel/signal.c                    |   2 +-
 arch/arm64/kernel/syscall.c                   |  29 ++---
 arch/s390/include/asm/thread_info.h           |   7 +-
 arch/s390/kernel/process.c                    |   2 +-
 arch/s390/kernel/ptrace.c                     |  20 +--
 arch/s390/kernel/signal.c                     |   6 +-
 arch/x86/include/asm/thread_info.h            |   6 +-
 include/asm-generic/thread_info_tif.h         |   5 +
 .../syscall_user_dispatch/sud_benchmark.c     |   2 +-
 .../syscall_user_dispatch/sud_test.c          |   4 +
 16 files changed, 166 insertions(+), 213 deletions(-)

-- 
2.34.1

