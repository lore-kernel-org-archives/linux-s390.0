Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3F63659FA;
	Tue, 17 Mar 2026 10:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773745034; cv=none; b=NEj/NtXUcF5eh8xQZ9wet3hFTuTlfAjD8gZGWhEnwZOnmwIregZbSOp24MsuiHiHasHDGbsCx5eoWjzobm7FRMPYgKxzh0sHxcQ8hxsAMWvHoQexAGjMO7wWzC/kRmcu8Z2/H5ATikEatImka5VT/xC4n5woEYxvlUc1NY5Iqso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773745034; c=relaxed/simple;
	bh=l6cEIrSwaUSKW9ZZZ60N6/1onMQZSNnrbK/gQBiYoXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSBAlcYF3nkq99iutAk++XjZgZld28nddS+Ce06TTDTbWgw1HKkxazkVo/Eo6xGngiDrVnL5FN5gteUQlZaCJQMCEoYE4Dbndn57X2pGe20SUW7eTwmBDT/KXnN1raGRRDchmD6tDwIYrzfGuYg5QtE4xaDi/+bBfQ5QjCyFc14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BFE41477;
	Tue, 17 Mar 2026 03:57:06 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 457E83F7BD;
	Tue, 17 Mar 2026 03:57:06 -0700 (PDT)
Date: Tue, 17 Mar 2026 10:57:04 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oleg@redhat.com,
	chenhuacai@kernel.org, kernel@xen0n.name, hca@linux.ibm.com,
	gor@linux.ibm.com, agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com, svens@linux.ibm.com, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, arnd@arndb.de, peterz@infradead.org, luto@kernel.org,
	shuah@kernel.org, kees@kernel.org, wad@chromium.org,
	kevin.brodsky@arm.com, deller@gmx.de, macro@orcam.me.uk,
	akpm@linux-foundation.org, ldv@strace.io, anshuman.khandual@arm.com,
	ryan.roberts@arm.com, mark.rutland@arm.com, thuth@redhat.com,
	song@kernel.org, ada.coupriediaz@arm.com, linusw@kernel.org,
	broonie@kernel.org, pengcan@kylinos.cn, liqiang01@kylinos.cn,
	ziyao@disroot.org, guanwentao@uniontech.com, guoren@kernel.org,
	schuster.simon@siemens-energy.com, jremus@linux.ibm.com,
	david@kernel.org, mathieu.desnoyers@efficios.com,
	edumazet@google.com, kmal@cock.li, dvyukov@google.com,
	reddybalavignesh9979@gmail.com, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-s390@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v13 RESEND 00/14] arm64: entry: Convert to Generic Entry
Message-ID: <abkzgKwMTOtGqSRb@e129823.arm.com>
References: <20260317082020.737779-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317082020.737779-1-ruanjinjie@huawei.com>

This series looks good to me.

Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>

> Currently, x86, Riscv, Loongarch use the Generic Entry which makes
> maintainers' work easier and codes more elegant. arm64 has already
> successfully switched to the Generic IRQ Entry in commit
> b3cf07851b6c ("arm64: entry: Switch to generic IRQ entry"), it is
> time to completely convert arm64 to Generic Entry.
>
> The goal is to bring arm64 in line with other architectures that already
> use the generic entry infrastructure, reducing duplicated code and
> making it easier to share future changes in entry/exit paths, such as
> "Syscall User Dispatch" and RSEQ optimizations.
>
> This patch set is rebased on v7.0-rc3. And the performance
> benchmarks results on qemu-kvm are below:
>
> perf bench syscall usec/op (-ve is improvement)
>
> | Syscall | Base        | Generic Entry | change % |
> | ------- | ----------- | ------------- | -------- |
> | basic   | 0.123997    | 0.120872      | -2.57    |
> | execve  | 512.1173    | 504.9966      | -1.52    |
> | fork    | 114.1144    | 113.2301      | -1.06    |
> | getpgid | 0.120182    | 0.121245      | +0.9     |
>
> perf bench syscall ops/sec (+ve is improvement)
>
> | Syscall | Base     | Generic Entry| change % |
> | ------- | -------- | ------------ | -------- |
> | basic   | 8064712  | 8273212      | +2.48    |
> | execve  | 1952     | 1980         | +1.52    |
> | fork    | 8763     | 8832         | +1.06    |
> | getpgid | 8320704  | 8247810      | -0.9     |
>
> Therefore, the syscall performance variation ranges from a 1% regression
> to a 2.5% improvement.
>
> It was tested ok with following test cases on QEMU virt platform:
>  - Stress-ng CPU stress test.
>  - Hackbench stress test.
>  - "sud" selftest testcase.
>  - get_set_sud, get_syscall_info, set_syscall_info, peeksiginfo
>    in tools/testing/selftests/ptrace.
>  - breakpoint_test_arm64 in selftests/breakpoints.
>  - syscall-abi and ptrace in tools/testing/selftests/arm64/abi
>  - fp-ptrace, sve-ptrace, za-ptrace in selftests/arm64/fp.
>  - vdso_test_getrandom in tools/testing/selftests/vDSO
>  - Strace tests.
>  - slice_test for rseq optimizations.
>
> The test QEMU configuration is as follows:
>
> 	qemu-system-aarch64 \
> 		-M virt \
> 		-enable-kvm \
> 		-cpu host \
> 		-kernel Image \
> 		-smp 8 \
> 		-m 512m \
> 		-nographic \
> 		-no-reboot \
> 		-device virtio-rng-pci \
> 		-append "root=/dev/vda rw console=ttyAMA0 kgdboc=ttyAMA0,115200 \
> 			earlycon preempt=voluntary irqchip.gicv3_pseudo_nmi=1 audit=1" \
> 		-drive if=none,file=images/rootfs.ext4,format=raw,id=hd0 \
> 		-device virtio-blk-device,drive=hd0 \
>
> Changes in v13 resend:
> - Fix exit_to_user_mode_prepare_legacy() issues.
> - Also move TIF_SINGLESTEP to generic TIF infrastructure for loongarch.
> - Use generic TIF bits for arm64 and moving TIF_SINGLESTEP to
>   generic TIF for related architectures separately.
> - Refactor syscall_trace_enter/exit() to accept flags and Use syscall_get_nr()
>   helper separately.
> - Tested with slice_test for rseq optimizations.
> - Add acked-by.
> - Link to v13: https://lore.kernel.org/all/20260313094738.3985794-1-ruanjinjie@huawei.com/
>
> Changes in v13:
> - Rebased on v7.0-rc3, so drop the firt applied arm64 patch.
> - Use generic TIF bits to enables RSEQ optimization.
> - Update most of the commit message to make it more clear.
> - Link to v12: https://lore.kernel.org/all/20260203133728.848283-1-ruanjinjie@huawei.com/
>
> Changes in v12:
> - Rebased on "sched/core", so remove the four generic entry patches.
> - Move "Expand secure_computing() in place" and
>   "Use syscall_get_arguments() helper" patch forward, which will group all
>   non-functional cleanups at the front.
> - Adjust the explanation for moving rseq_syscall() before
>   audit_syscall_exit().
> - Link to v11: https://lore.kernel.org/all/20260128031934.3906955-1-ruanjinjie@huawei.com/
>
> Changes in v11:
> - Remove unused syscall in syscall_trace_enter().
> - Update and provide a detailed explanation of the differences after
>   moving rseq_syscall() before audit_syscall_exit().
> - Rebased on arm64 (for-next/entry), and remove the first applied 3 patchs.
> - syscall_exit_to_user_mode_work() for arch reuse instead of adding
>   new syscall_exit_to_user_mode_work_prepare() helper.
> - Link to v10: https://lore.kernel.org/all/20251222114737.1334364-1-ruanjinjie@huawei.com/
>
> Changes in v10:
> - Rebased on v6.19-rc1, rename syscall_exit_to_user_mode_prepare() to
>   syscall_exit_to_user_mode_work_prepare() to avoid conflict.
> - Also inline syscall_trace_enter().
> - Support aarch64 for sud_benchmark.
> - Update and correct the commit message.
> - Add Reviewed-by.
> - Link to v9: https://lore.kernel.org/all/20251204082123.2792067-1-ruanjinjie@huawei.com/
>
> Changes in v9:
> - Move "Return early for ptrace_report_syscall_entry() error" patch ahead
>   to make it not introduce a regression.
> - Not check _TIF_SECCOMP/SYSCALL_EMU for syscall_exit_work() in
>   a separate patch.
> - Do not report_syscall_exit() for PTRACE_SYSEMU_SINGLESTEP in a separate
>   patch.
> - Add two performance patch to improve the arm64 performance.
> - Add Reviewed-by.
> - Link to v8: https://lore.kernel.org/all/20251126071446.3234218-1-ruanjinjie@huawei.com/
>
> Changes in v8:
> - Rename "report_syscall_enter()" to "report_syscall_entry()".
> - Add ptrace_save_reg() to avoid duplication.
> - Remove unused _TIF_WORK_MASK in a standalone patch.
> - Align syscall_trace_enter() return value with the generic version.
> - Use "scno" instead of regs->syscallno in el0_svc_common().
> - Move rseq_syscall() ahead in a standalone patch to clarify it clearly.
> - Rename "syscall_trace_exit()" to "syscall_exit_work()".
> - Keep the goto in el0_svc_common().
> - No argument was passed to __secure_computing() and check -1 not -1L.
> - Remove "Add has_syscall_work() helper" patch.
> - Move "Add syscall_exit_to_user_mode_prepare() helper" patch later.
> - Add miss header for asm/entry-common.h.
> - Update the implementation of arch_syscall_is_vdso_sigreturn().
> - Add "ARCH_SYSCALL_WORK_EXIT" to be defined as "SECCOMP | SYSCALL_EMU"
>   to keep the behaviour unchanged.
> - Add more testcases test.
> - Add Reviewed-by.
> - Update the commit message.
> - Link to v7: https://lore.kernel.org/all/20251117133048.53182-1-ruanjinjie@huawei.com/
>
> Jinjie Ruan (13):
>   arm64/ptrace: Refactor syscall_trace_enter/exit() to accept flags
>     parameter
>   arm64/ptrace: Use syscall_get_nr() helper for syscall_trace_enter()
>   arm64/ptrace: Expand secure_computing() in place
>   arm64/ptrace: Use syscall_get_arguments() helper for audit
>   arm64: ptrace: Move rseq_syscall() before audit_syscall_exit()
>   arm64: syscall: Introduce syscall_exit_to_user_mode_work()
>   arm64/ptrace: Define and use _TIF_SYSCALL_EXIT_WORK
>   arm64/ptrace: Skip syscall exit reporting for PTRACE_SYSEMU_SINGLESTEP
>   arm64: entry: Convert to generic entry
>   arm64: Inline el0_svc_common()
>   s390: Rename TIF_SINGLE_STEP to TIF_SINGLESTEP
>   asm-generic: Move TIF_SINGLESTEP to generic TIF bits
>   arm64: Use generic TIF bits for common thread flags
>
> kemal (1):
>   selftests: sud_test: Support aarch64
>
>  arch/arm64/Kconfig                            |   3 +-
>  arch/arm64/include/asm/entry-common.h         |  76 ++++++++++++
>  arch/arm64/include/asm/syscall.h              |  19 ++-
>  arch/arm64/include/asm/thread_info.h          |  76 ++++--------
>  arch/arm64/kernel/debug-monitors.c            |   7 ++
>  arch/arm64/kernel/entry-common.c              |  25 +++-
>  arch/arm64/kernel/ptrace.c                    | 115 ------------------
>  arch/arm64/kernel/signal.c                    |   2 +-
>  arch/arm64/kernel/syscall.c                   |  29 ++---
>  arch/loongarch/include/asm/thread_info.h      |  11 +-
>  arch/s390/include/asm/thread_info.h           |   7 +-
>  arch/s390/kernel/process.c                    |   2 +-
>  arch/s390/kernel/ptrace.c                     |  20 +--
>  arch/s390/kernel/signal.c                     |   6 +-
>  arch/x86/include/asm/thread_info.h            |   6 +-
>  include/asm-generic/thread_info_tif.h         |   5 +
>  include/linux/irq-entry-common.h              |   8 --
>  include/linux/rseq_entry.h                    |  18 ---
>  .../syscall_user_dispatch/sud_benchmark.c     |   2 +-
>  .../syscall_user_dispatch/sud_test.c          |   4 +
>  20 files changed, 191 insertions(+), 250 deletions(-)
>
> --
> 2.34.1
>
>

--
Sincerely,
Yeoreum Yun
