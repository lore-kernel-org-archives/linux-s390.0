Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997216;
	b=qEeX+Rx+TsF2ftsFa6TgVFSCZXaPxRDPnKTGfviChZiLH+KP5sD6SEjRntUPOhpZvx1S
	 Fus6MnKcOXXbGTMvgzIj7A/ndBRb/Pr8TKx9yD0TwGAl0e1o3bDQv6/IMDNAZtv45oO/v
	 X3+xxyCcpneD7NOEGlh5g5QzfEmv8CvAXBaETV2D8DpCqXQQJXTUw9txyd5B16BFk7Xkr
	 ZvZAV8U0N4D6Ns3RV86SBYppS6r+vIbnhKfIpc2R+pqIdLehb5OpH+oJ9dxEYtaCyfizc
	 VeqrzAz0kcmRTVYMMGPWPjadokxFihNRgIy1HlRSTbt977NRrPSuKFZ+1bXP9YGvx5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997216;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Q+3ya/WV+zAAGSVOE6aHUYaputVSKResbBEnCKzrJ8U=;
	b=xT7ZkC4Dfe0jM+1Bl9H9qiJgHeb0X9xJkX8NY5EhUSaoELR4jvMWHTgK/bYP8akfoQ3L
	 gdD6ugS7rXvbq4c3qzDXOPCbloQR+jZ0/c9T2loDHOr53Ld5C50ajwohnupVxYYZoBqag
	 2s5P2W1SmXYN8dCCk/LhEcymIXQ3vRqDq//O1kPnYSiNOefRVmJPXfZCVS+xUGRHtfaQB
	 avbRJONVXCMZRmCKwR+JjW1qf0HzttTAbTt+bdgXEcg5jXXnGEJ66M/5VLPVaaAbYhj85
	 nBlq1WSDBUIJjwpWD7f+8X1bE0H068WUIOLHJjJFmhSdQI2gF0175zHJN1v8F5f4XcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Y/MCkUOb";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6181606A326;
	Fri,  6 Nov 2026 20:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y/MCkUOb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B356E1F0089F;
	Fri,  6 Nov 2026 20:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793997215;
	bh=Q+3ya/WV+zAAGSVOE6aHUYaputVSKResbBEnCKzrJ8U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y/MCkUObVm5MoJ0t6yk4+7mYfREfhT2AH9ij2MBjvvelnidtwQom3DJo86SgyQAqr
	 vGGfqXzE8V+t16I++7X8hT/54Ye42JL75nRCGbCTrMjDID9t94OWd5KnZbrGQIOK8e
	 JGub9/TyGAWLNo/3Es5Mf1EU/++ePL3XCHUG4SSEhLJMhvpOjbJowViFvnreXHdiBR
	 sosAKTUK6JWZRD2Z7cJpToDQeltihZWVq2zvjg6jSz/JJdG1IUMY1W+A/Yga4Hdoob
	 djXvKQkNJUn83STpdNxXTGvci+3WP1z6I63OrinfCL0CFLc+jRkWZ9MgZU7uNCzKnB
	 nSLV0XWZLjdGg==
Message-ID: <sashiko-outbox-202216@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 03/15] scripts/syscall.tbl: Use the common table
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, "Arnd Bergmanon" <arnd@arndb.de>
Cc: "Christian Brauner" <brauner@kernel.org>, linux-kbuild@vger.kernel.org, kernel-dev@igalia.com, "Thomas
 Bogendoerfer" <tsbogend@alpha.franken.de>, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, nathan@kernel.org, nsc@kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261105-tonyk-syscall_table-v9-3-8d1275885d9c@igalia.com>
References: <20261105-tonyk-syscall_table-v9-0-8d1275885d9c@igalia.com>
 <20261105-tonyk-syscall_table-v9-3-8d1275885d9c@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 20:33:34 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] perf: missing syscall_common.tbl support in perf
  syscalltbl.sh
--

commit dac6905b3ac66002c3213b943d87d4be75189339
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

scripts/syscall.tbl: Use the common table

This commit removes syscall entries 403 through 472 from scripts/syscall.tbl
and arch/arm64/tools/syscall_32.tbl so that they are instead sourced from
scripts/syscall_common.tbl via scripts/Makefile.asm-headers. It also adds t=
he
clone3 ABI to architecture Makefile.syscalls files accordingly.

> diff --git a/scripts/syscall.tbl b/scripts/syscall.tbl
> index 0ab5316051202..ee828d03094ed 100644
> --- a/scripts/syscall.tbl
> +++ b/scripts/syscall.tbl
> @@ -344,72 +344,3 @@
>  293	common	rseq				sys_rseq
>  294	common	kexec_file_load			sys_kexec_file_load
>  # 295 through 402 are unassigned to sync up with generic numbers don't u=
se
> -403	32	clock_gettime64			sys_clock_gettime
> -404	32	clock_settime64			sys_clock_settime
> -405	32	clock_adjtime64			sys_clock_adjtime
> -406	32	clock_getres_time64		sys_clock_getres
> -407	32	clock_nanosleep_time64		sys_clock_nanosleep
> -408	32	timer_gettime64			sys_timer_gettime
> -409	32	timer_settime64			sys_timer_settime
> -410	32	timerfd_gettime64		sys_timerfd_gettime
> -411	32	timerfd_settime64		sys_timerfd_settime
> -412	32	utimensat_time64		sys_utimensat
> -413	32	pselect6_time64			sys_pselect6			compat_sys_pselect6_time64
> -414	32	ppoll_time64			sys_ppoll			compat_sys_ppoll_time64
> -416	32	io_pgetevents_time64		sys_io_pgetevents		compat_sys_io_pgetevents=
_time64
> -417	32	recvmmsg_time64			sys_recvmmsg			compat_sys_recvmmsg_time64
> -418	32	mq_timedsend_time64		sys_mq_timedsend
> -419	32	mq_timedreceive_time64		sys_mq_timedreceive
> -420	32	semtimedop_time64		sys_semtimedop
> -421	32	rt_sigtimedwait_time64		sys_rt_sigtimedwait		compat_sys_rt_sigtim=
edwait_time64
> -422	32	futex_time64			sys_futex
> -423	32	sched_rr_get_interval_time64	sys_sched_rr_get_interval
> -424	common	pidfd_send_signal		sys_pidfd_send_signal
> -425	common	io_uring_setup			sys_io_uring_setup
> -426	common	io_uring_enter			sys_io_uring_enter
> -427	common	io_uring_register		sys_io_uring_register
> -428	common	open_tree			sys_open_tree
> -429	common	move_mount			sys_move_mount
> -430	common	fsopen				sys_fsopen
> -431	common	fsconfig			sys_fsconfig
> -432	common	fsmount				sys_fsmount
> -433	common	fspick				sys_fspick
> -434	common	pidfd_open			sys_pidfd_open
> -435	common	clone3				sys_clone3
> -436	common	close_range			sys_close_range
> -437	common	openat2				sys_openat2
> -438	common	pidfd_getfd			sys_pidfd_getfd
> -439	common	faccessat2			sys_faccessat2
> -440	common	process_madvise			sys_process_madvise
> -441	common	epoll_pwait2			sys_epoll_pwait2		compat_sys_epoll_pwait2
> -442	common	mount_setattr			sys_mount_setattr
> -443	common	quotactl_fd			sys_quotactl_fd
> -444	common	landlock_create_ruleset		sys_landlock_create_ruleset
> -445	common	landlock_add_rule		sys_landlock_add_rule
> -446	common	landlock_restrict_self		sys_landlock_restrict_self
> -447	memfd_secret	memfd_secret		sys_memfd_secret
> -448	common	process_mrelease		sys_process_mrelease
> -449	common	futex_waitv			sys_futex_waitv
> -450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
> -451	common	cachestat			sys_cachestat
> -452	common	fchmodat2			sys_fchmodat2
> -453	common	map_shadow_stack		sys_map_shadow_stack
> -454	common	futex_wake			sys_futex_wake
> -455	common	futex_wait			sys_futex_wait
> -456	common	futex_requeue			sys_futex_requeue
> -457	common	statmount			sys_statmount
> -458	common	listmount			sys_listmount
> -459	common	lsm_get_self_attr		sys_lsm_get_self_attr
> -460	common	lsm_set_self_attr		sys_lsm_set_self_attr
> -461	common	lsm_list_modules		sys_lsm_list_modules
> -462	common	mseal				sys_mseal
> -463	common	setxattrat			sys_setxattrat
> -464	common	getxattrat			sys_getxattrat
> -465	common	listxattrat			sys_listxattrat
> -466	common	removexattrat			sys_removexattrat
> -467	common	open_tree_attr			sys_open_tree_attr
> -468	common	file_getattr			sys_file_getattr
> -469	common	file_setattr			sys_file_setattr
> -470	common	listns				sys_listns
> -471	common	rseq_slice_yield		sys_rseq_slice_yield
> -472	common	fchroot				sys_fchroot

[Severity: Medium]
As reported by Sashiko on v8 [1], removing syscalls 403 through 472 from
scripts/syscall.tbl leaves tools/perf out of sync and unable to resolve the=
se
syscall numbers when tools/scripts/syscall.tbl is updated.

In tools/perf/check-headers.sh, scripts/syscall.tbl is checked against
tools/scripts/syscall.tbl:

    declare -a FILES=3D(
      ...
      "include/uapi/asm-generic/unistd.h"
      "scripts/syscall.tbl"
    )

And in tools/perf/trace/beauty/syscalltbl.sh, build_tables() generates the
perf syscall tables for CSKY, RISC-V, and generic EM_NONE targets solely fr=
om
tools/scripts/syscall.tbl without reading scripts/syscall_common.tbl or
including the clone3 ABI:

    build_tables "$tools_dir/scripts/syscall.tbl" "$outfile" common,32,csky=
,time32,stat64,rlimit EM_CSKY
    ...
    build_tables "$tools_dir/scripts/syscall.tbl" "$outfile" common,32,risc=
v,memfd_secret EM_RISCV
    echo "#else" >> "$outfile"
    build_tables "$tools_dir/scripts/syscall.tbl" "$outfile" common,64,risc=
v,rlimit,memfd_secret EM_RISCV
    ...
    build_tables "$tools_dir/scripts/syscall.tbl" "$outfile" common,32 EM_N=
ONE
    echo "#else" >> "$outfile"
    build_tables "$tools_dir/scripts/syscall.tbl" "$outfile" common,64 EM_N=
ONE

Will this cause check-headers.sh warnings during perf builds, and cause perf
trace to lose syscall number-to-name mappings for syscalls >=3D 403 on gene=
ric
syscall table architectures once tools/scripts/syscall.tbl is synchronized =
or
new syscalls are added to scripts/syscall_common.tbl?

[1] https://lore.kernel.org/r/20260918-tonyk-syscall_table-v8-3-0e2d60cad13=
e@igalia.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-tonyk-sysc=
all_table-v9-0-8d1275885d9c@igalia.com?part=3D3
