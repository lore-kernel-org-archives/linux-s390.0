Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2B63AE6F3;
	Fri, 28 Aug 2026 23:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787959201; cv=none; b=jMlRDYf1sU7cMrxrhckhXcOE540w1o10qj8jxZhtvM8DRALcxZih6eXCs9ay+wVGsj9fNDI1TZpCDq8oX+++OSd2RIpungOqLn7pb2vsMor2Um1xb3ooICCWlKWEm7njAiarLmOK0NjKBLI5HDApcA6MVfF6/E1vCbQ9HXOrpBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787959201; c=relaxed/simple;
	bh=pezqgXs2c+1cQ4734sDOC9wRjgEjVhfgVHY9/iPvELc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kXugaZ2P7LjmD59vq45T9QjQ3QSrR0pkvABbUWW8dLy4bvKP3hwmHj6akYZHmYQ9V0AEjdDNoSsNq7mgzq0lGHaB99kwOccD2V8GUiy+v9gkT7x7O/TSDRa/rehfUCj8fEKimqwmtZnRoQ4+FKF90oTr4pCwBOZyKEFAaWCJHhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=U+CiV+Bp; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="U+CiV+Bp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=JIUSFmyC6+iUD6fdE7w3U4GDAoc/E60DHnaacMNDtGU=; b=U+CiV+BpsVClMXlS+p4CEpacAp
	wod4jwsJo1LQBycy5qsytCTrsEfYU6YS96W7E9lhF+vq6jQc+E7sbrxrA4clyRhfmeTsM37cn5XAC
	/57NpnQxdav6GeynimY4/l9AR0nu1/MhhA4u/36Ps/RCIsg7i4J7FrlqEYf+97fI61FrpP0gtrVVM
	MaB55HnsHcJCv6kcRZgQJTe/s3jZ2VGf6MESs/8UHdSwvUMkPllmgQoq5OVAyq5GSdQGyE6suwNl6
	L8up0oMqYmkJ/MGbzSpbGv9Ju6VWkzJn7J13Ekxpnu5mS0e1ohMKsXDHvMS25I3x7aw4ob4pU5Guk
	k1alZhjQ==;
Received: from [187.57.78.212] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1x05rP-00B3sF-IA; Sat, 29 Aug 2026 01:19:47 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Fri, 28 Aug 2026 20:19:29 -0300
Subject: [PATCH v6 02/13] syscalls: Create unified partial table for all
 archs
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-tonyk-syscall_table-v6-2-fdd358456cf1@igalia.com>
References: <20260828-tonyk-syscall_table-v6-0-fdd358456cf1@igalia.com>
In-Reply-To: <20260828-tonyk-syscall_table-v6-0-fdd358456cf1@igalia.com>
To: Masami Hiramatsu <mhiramat@kernel.org>, Arnd Bergmanon <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, kernel-dev@igalia.com, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 linux-alpha@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev, 
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.15.2

To take advantage of the subset of syscall numbers that are guaranteed to
be shared, create a new table and adapt generation scripts to use it. In
that way, every new syscall can be added to a single file.

Create special ABIs in order to make the table work for different archs:

 - `clone3` for archs that use the common clone3 entry
 - `__clone3` for archs that use their own special entry point

Create flags for syscall Makefiles to use the common table.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Changes in v6:
- Make it compliant with POSIX shells
---
 scripts/syscall_common.tbl | 84 ++++++++++++++++++++++++++++++++++++++++++++++
 scripts/syscallhdr.sh      | 63 ++++++++++++++++++++++++++--------
 scripts/syscalltbl.sh      | 32 ++++++++++++++----
 3 files changed, 159 insertions(+), 20 deletions(-)

diff --git a/scripts/syscall_common.tbl b/scripts/syscall_common.tbl
new file mode 100644
index 000000000000..8085030eb869
--- /dev/null
+++ b/scripts/syscall_common.tbl
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+#
+# syscall numbers shared by all architectures
+#
+# The format is:
+# <number> <abi> <name> <entry point> [<compat entry point> [noreturn]]
+#
+# The abi can be "32", "clone3", "__cln3" and "memfd_secret"
+#
+# clone3 stands for the common clone3 entry, used by most archs. Some archs have
+# their special entry and should use "__clone3".
+#
+# "memfd_secret" is not implemented by every architecture
+
+403	32	clock_gettime64			sys_clock_gettime
+404	32	clock_settime64			sys_clock_settime
+405	32	clock_adjtime64			sys_clock_adjtime
+406	32	clock_getres_time64		sys_clock_getres
+407	32	clock_nanosleep_time64		sys_clock_nanosleep
+408	32	timer_gettime64			sys_timer_gettime
+409	32	timer_settime64			sys_timer_settime
+410	32	timerfd_gettime64		sys_timerfd_gettime
+411	32	timerfd_settime64		sys_timerfd_settime
+412	32	utimensat_time64		sys_utimensat
+413	32	pselect6_time64			sys_pselect6			compat_sys_pselect6_time64
+414	32	ppoll_time64			sys_ppoll			compat_sys_ppoll_time64
+416	32	io_pgetevents_time64		sys_io_pgetevents		compat_sys_io_pgetevents_time64
+417	32	recvmmsg_time64			sys_recvmmsg			compat_sys_recvmmsg_time64
+418	32	mq_timedsend_time64		sys_mq_timedsend
+419	32	mq_timedreceive_time64		sys_mq_timedreceive
+420	32	semtimedop_time64		sys_semtimedop
+421	32	rt_sigtimedwait_time64		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
+422	32	futex_time64			sys_futex
+423	32	sched_rr_get_interval_time64	sys_sched_rr_get_interval
+424	common	pidfd_send_signal		sys_pidfd_send_signal
+425	common	io_uring_setup			sys_io_uring_setup
+426	common	io_uring_enter			sys_io_uring_enter
+427	common	io_uring_register		sys_io_uring_register
+428	common	open_tree			sys_open_tree
+429	common	move_mount			sys_move_mount
+430	common	fsopen				sys_fsopen
+431	common	fsconfig			sys_fsconfig
+432	common	fsmount				sys_fsmount
+433	common	fspick				sys_fspick
+434	common	pidfd_open			sys_pidfd_open
+435	clone3	clone3				sys_clone3
+435	__clone3	clone3			__sys_clone3
+436	common	close_range			sys_close_range
+437	common	openat2				sys_openat2
+438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	faccessat2			sys_faccessat2
+440	common	process_madvise			sys_process_madvise
+441	common	epoll_pwait2			sys_epoll_pwait2		compat_sys_epoll_pwait2
+442	common	mount_setattr			sys_mount_setattr
+443	common	quotactl_fd			sys_quotactl_fd
+444	common	landlock_create_ruleset		sys_landlock_create_ruleset
+445	common	landlock_add_rule		sys_landlock_add_rule
+446	common	landlock_restrict_self		sys_landlock_restrict_self
+447	memfd_secret	memfd_secret		sys_memfd_secret
+448	common	process_mrelease		sys_process_mrelease
+449	common	futex_waitv			sys_futex_waitv
+450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	cachestat			sys_cachestat
+452	common	fchmodat2			sys_fchmodat2
+453	common	map_shadow_stack		sys_map_shadow_stack
+454	common	futex_wake			sys_futex_wake
+455	common	futex_wait			sys_futex_wait
+456	common	futex_requeue			sys_futex_requeue
+457	common	statmount			sys_statmount
+458	common	listmount			sys_listmount
+459	common	lsm_get_self_attr		sys_lsm_get_self_attr
+460	common	lsm_set_self_attr		sys_lsm_set_self_attr
+461	common	lsm_list_modules		sys_lsm_list_modules
+462	common	mseal				sys_mseal
+463	common	setxattrat			sys_setxattrat
+464	common	getxattrat			sys_getxattrat
+465	common	listxattrat			sys_listxattrat
+466	common	removexattrat			sys_removexattrat
+467	common	open_tree_attr			sys_open_tree_attr
+468	common	file_getattr			sys_file_getattr
+469	common	file_setattr			sys_file_setattr
+470	common	listns				sys_listns
+471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	fchroot				sys_fchroot
diff --git a/scripts/syscallhdr.sh b/scripts/syscallhdr.sh
index bad1ab606a0f..a9b880070a3d 100755
--- a/scripts/syscallhdr.sh
+++ b/scripts/syscallhdr.sh
@@ -16,7 +16,7 @@
 set -e
 
 usage() {
-	echo >&2 "usage: $0 [--abis ABIS] [--emit-nr] [--offset OFFSET] [--prefix PREFIX] INFILE OUTFILE" >&2
+	echo >&2 "usage: $0 [--abis ABIS] [--emit-nr] [--offset OFFSET] [--prefix PREFIX] [--common-tbl PATH] INFILE OUTFILE" >&2
 	echo >&2
 	echo >&2 "  INFILE    input syscall table"
 	echo >&2 "  OUTFILE   output header file"
@@ -26,6 +26,7 @@ usage() {
 	echo >&2 "  --emit-nr          Emit the macro of the number of syscalls (__NR_syscalls)"
 	echo >&2 "  --offset OFFSET    The offset of syscall numbers"
 	echo >&2 "  --prefix PREFIX    The prefix to the macro like __NR_<PREFIX><NAME>"
+	echo >&2 "  --common-tbl PATH  Use the common number table"
 	exit 1
 }
 
@@ -34,6 +35,8 @@ abis=
 emit_nr=
 offset=
 prefix=
+common_tbl=
+common_tbl_path=
 
 while [ $# -gt 0 ]
 do
@@ -50,6 +53,10 @@ do
 	--prefix)
 		prefix=$2
 		shift 2;;
+	--common-tbl)
+		common_tbl=1
+		common_tbl_path=$2
+		shift 2;;
 	-*)
 		echo "$1: unknown option" >&2
 		usage;;
@@ -69,13 +76,35 @@ guard=_UAPI_ASM_$(basename "$outfile" |
 	sed -e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
 	-e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g')
 
-grep -E "^[0-9A-Fa-fXx]+[[:space:]]+$abis" "$infile" | {
+emit_start_guard() {
 	echo "#ifndef $guard"
 	echo "#define $guard"
 	echo
+}
+
+# emit_nr(prefix, nr)
+emit_nr() {
+	local nr=$1
+	local prefix=$2
+	echo
+	echo "#ifdef __KERNEL__"
+	echo "#define __NR_${prefix}syscalls $nr"
+	echo "#endif"
+}
+
+emit_end_guard() {
+	echo
+	echo "#endif /* $guard */"
+}
+
+max=0
+# gen_hdr(infile)
+gen_hdr() {
+	input=$1
+	tmpfile=$(mktemp -p .)
 
-	max=0
-	while read nr abi name native compat ; do
+	grep -E "^[0-9A-Fa-fXx]+[[:space:]]+$abis" "$input" > $tmpfile
+	while read nr abi name native compat; do
 
 		max=$nr
 
@@ -84,15 +113,21 @@ grep -E "^[0-9A-Fa-fXx]+[[:space:]]+$abis" "$infile" | {
 		fi
 
 		echo "#define __NR_$prefix$name $nr"
-	done
 
-	if [ -n "$emit_nr" ]; then
-		echo
-		echo "#ifdef __KERNEL__"
-		echo "#define __NR_${prefix}syscalls $(($max + 1))"
-		echo "#endif"
-	fi
+	done < $tmpfile
+	rm $tmpfile
+}
 
-	echo
-	echo "#endif /* $guard */"
-} > "$outfile"
+emit_start_guard > $outfile
+
+gen_hdr $infile >> $outfile
+
+if [ -n "$common_tbl" ]; then
+	gen_hdr $common_tbl_path  >> "$outfile"
+fi
+
+if [ -n "$emit_nr" ]; then
+	emit_nr $(($max + 1)) $prefix >> $outfile
+fi
+
+emit_end_guard >> $outfile
diff --git a/scripts/syscalltbl.sh b/scripts/syscalltbl.sh
index c4b1f85c2dd6..f5b95b19ac92 100755
--- a/scripts/syscalltbl.sh
+++ b/scripts/syscalltbl.sh
@@ -16,18 +16,21 @@
 set -e
 
 usage() {
-	echo >&2 "usage: $0 [--abis ABIS] INFILE OUTFILE" >&2
+	echo >&2 "usage: $0 [--abis ABIS] [--common-tbl PATH] INFILE OUTFILE" >&2
 	echo >&2
 	echo >&2 "  INFILE    input syscall table"
 	echo >&2 "  OUTFILE   output header file"
 	echo >&2
 	echo >&2 "options:"
 	echo >&2 "  --abis ABIS        ABI(s) to handle (By default, all lines are handled)"
+	echo >&2 "  --common-tbl PATH  Use the common syscall number table"
 	exit 1
 }
 
 # default unless specified by options
 abis=
+common_tbl=
+common_tbl_path=
 
 while [ $# -gt 0 ]
 do
@@ -35,6 +38,10 @@ do
 	--abis)
 		abis="($(echo "${2%,}" | tr ',' '|'))"
 		shift 2;;
+	--common-tbl)
+		common_tbl=1
+		common_tbl_path=$2
+		shift 2;;
 	-*)
 		echo "$1: unknown option" >&2
 		usage;;
@@ -52,12 +59,16 @@ outfile="$2"
 
 nxt=0
 
-grep -E "^[0-9]+[[:space:]]+$abis" "$infile" | {
+# gen_tbl(infile)
+gen_tbl() {
+	input=$1
+	tmpfile=$(mktemp -p .)
 
+	grep -E "^[0-9A-Fa-fXx]+[[:space:]]+$abis" "$input" > $tmpfile
 	while read nr abi name native compat noreturn; do
 
 		if [ $nxt -gt $nr ]; then
-			echo "error: $infile: syscall table is not sorted or duplicates the same syscall number" >&2
+			echo "error: $input: syscall table is not sorted or duplicates the same syscall number" >&2
 			exit 1
 		fi
 
@@ -72,7 +83,7 @@ grep -E "^[0-9]+[[:space:]]+$abis" "$infile" | {
 
 		if [ -n "$noreturn" ]; then
 			if [ "$noreturn" != "noreturn" ]; then
-				echo "error: $infile: invalid string \"$noreturn\" in 'noreturn' column"
+				echo "error: $input: invalid string \"$noreturn\" in 'noreturn' column"
 				exit 1
 			fi
 			if [ -n "$compat" ]; then
@@ -88,5 +99,14 @@ grep -E "^[0-9]+[[:space:]]+$abis" "$infile" | {
 			echo "__SYSCALL($nr, sys_ni_syscall)"
 		fi
 		nxt=$((nr + 1))
-	done
-} > "$outfile"
+
+	done < $tmpfile
+	rm $tmpfile
+
+}
+
+gen_tbl $infile  > "$outfile"
+
+if [ -n "$common_tbl" ]; then
+	gen_tbl $common_tbl_path >> "$outfile"
+fi

-- 
2.55.0

