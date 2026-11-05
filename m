Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793909181;
	b=luKROqRuntRQbUYSianU0dvrwovOjVE4MjCQJY+M70QIyIuP2h2bDpZ9Rt7p1ukBkbXb
	 xNCIgOuoEpZ0BWUx3p2TFUQBIiwkysGCXuBn9r4SFinty33ssSMFVPWgspP8eIC16msYo
	 9nuvCc9jqNToHsybOoqWX4dq1oZgy2jYJVku2Skw9ypWh5koxkoNXZj3Up1O91UNkvf+8
	 1KWMRVrV6qyjit2vg2ZqqU69wus2dSuvS1dj0LM5H2lyLIh0ILabx7cW0XM/mrEaicy90
	 dzP63j3vfgRCUpw0VCBBi/BBCyJUWDKut3/g9JkGEsNHkbywJ6ltvo8w9kz/WuRHkSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793909181;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=yadiH2ivGXNxoC2QPKS2gObQGu1mp4cvEnqZn14i3H4=;
	b=kK5VvI6ZQ36lPwKfpvzEpEEe+nUSxpn8jrZsQxAfrzviM7A1If14x7TE8de8/hDLX/S4
	 9RwCuEe5hHZPm4BMqrWYfd3G6APzEzARVYx79ogWJWnY35rAN2i62deObjxv7qZajc9pK
	 1+iaOuULsekYeuQYPlxuaGEMuCrgJ3jXv3ZQfNV9YtBjSl6u82NgS2HKqc8IJtKzJmz37
	 FDwsbsh2aPL3ti+wVXfHcGSIyg65j499/W1RHuFY+GJLWdAl1WWb5una5V7UEx1R2Oo8S
	 Jfcb9ondwpYzkhDUFQ7HPLPIJpY8sLUp8z0xxyXeyLUJUijEOgyeXWvWLyvxFRtKK5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=lb1MnCjk;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0B4606D80A;
	Thu,  5 Nov 2026 20:06:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC0B4606D80A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=lb1MnCjk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=yadiH2ivGXNxoC2QPKS2gObQGu1mp4cvEnqZn14i3H4=; t=1793909180; x=2109269180; 
	b=lb1MnCjkcfbW0297xPH2SUbCLaOyShM4TbQk8zr4M8EIGbn/AwE4FlshwHTMQ9hRsGPT6kZR376
	8Jxfdo7XqwAtKYP/b3owx9Sks4fqQSgnUj0VMGFOQ7+pma8d/JCl6cXjzRlfibxTxYH0qxzCmFgqS
	YPUfGJNGlrG0f/Xh34YsL+aKZw80xwz5uVSvmkvV6SeGA3KnIDtNNvRJUtpbRhjm73ofRgp4gLeed
	znDGCYIxkTTMmo6dhzZkPCmk410eESnPZPoChUszEY/TBrlKC2ADTZzlxkXd3dMeYWfTezOXedYs8
	TGivV9Al1LB6DVxUKZkS4wtozHmDaAR9TY6g==;
Received: from [177.172.122.137] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xP3j0-003hS1-Kr; Thu, 05 Nov 2026 21:06:18 +0100
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 05 Nov 2026 17:05:39 -0300
Subject: [PATCH v9 04/15] s390: Use the common syscall table
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261105-tonyk-syscall_table-v9-4-8d1275885d9c@igalia.com>
References: <20261105-tonyk-syscall_table-v9-0-8d1275885d9c@igalia.com>
In-Reply-To: <20261105-tonyk-syscall_table-v9-0-8d1275885d9c@igalia.com>
To: Masami Hiramatsu <mhiramat@kernel.org>, Arnd Bergmanon <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, kernel-dev@igalia.com, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 linux-alpha@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev, 
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.15.2

Remove some of the duplicated code by using the common syscall number
table.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 arch/s390/kernel/syscall.c            |  2 ++
 arch/s390/kernel/syscalls/Makefile    | 12 ++++++---
 arch/s390/kernel/syscalls/syscall.tbl | 49 -----------------------------------
 3 files changed, 10 insertions(+), 53 deletions(-)

diff --git a/arch/s390/kernel/syscall.c b/arch/s390/kernel/syscall.c
index bcc0b76bd868..d4b5c30e1cbe 100644
--- a/arch/s390/kernel/syscall.c
+++ b/arch/s390/kernel/syscall.c
@@ -40,6 +40,8 @@
 
 #include "entry.h"
 
+#define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, native)
+
 #define __SYSCALL(nr, sym) long __s390x_##sym(struct pt_regs *);
 #include <asm/syscall_table.h>
 #undef __SYSCALL
diff --git a/arch/s390/kernel/syscalls/Makefile b/arch/s390/kernel/syscalls/Makefile
index d5fca0ca0890..4b4490f80467 100644
--- a/arch/s390/kernel/syscalls/Makefile
+++ b/arch/s390/kernel/syscalls/Makefile
@@ -5,19 +5,23 @@ uapi := arch/$(SRCARCH)/include/generated/uapi/asm
 $(shell mkdir -p $(uapi) $(kapi))
 
 syscall := $(src)/syscall.tbl
+syscalltbl_common := $(srctree)/scripts/syscall_common.tbl
 syshdr := $(srctree)/scripts/syscallhdr.sh
 systbl := $(srctree)/scripts/syscalltbl.sh
+abis := common,clone3,memfd_secret
 
 quiet_cmd_syshdr = SYSHDR  $@
-      cmd_syshdr = $(CONFIG_SHELL) $(syshdr) --emit-nr --abis common,$* $< $@
+      cmd_syshdr = $(CONFIG_SHELL) $(syshdr) --emit-nr --abis $(abis),$* \
+		   --common-tbl $(syscalltbl_common) $< $@
 
 quiet_cmd_systbl = SYSTBL  $@
-      cmd_systbl = $(CONFIG_SHELL) $(systbl) --abis common,$* $< $@
+      cmd_systbl = $(CONFIG_SHELL) $(systbl) --abis $(abis),$* \
+		   --common-tbl $(syscalltbl_common) $< $@
 
-$(uapi)/unistd_%.h: $(syscall) $(syshdr) FORCE
+$(uapi)/unistd_%.h: $(syscall) $(syscalltbl_common) $(syshdr) FORCE
 	$(call if_changed,syshdr)
 
-$(kapi)/syscall_table.h: $(syscall) $(systbl) FORCE
+$(kapi)/syscall_table.h: $(syscall) $(syscalltbl_common) $(systbl) FORCE
 	$(call if_changed,systbl)
 
 uapisyshdr-y		+= unistd_64.h
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 1b45e68a217b..ce6d15260dd1 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -350,52 +350,3 @@
 400	common	msgsnd				sys_msgsnd
 401	common	msgrcv				sys_msgrcv
 402	common	msgctl				sys_msgctl
-424	common	pidfd_send_signal		sys_pidfd_send_signal
-425	common	io_uring_setup			sys_io_uring_setup
-426	common	io_uring_enter			sys_io_uring_enter
-427	common	io_uring_register		sys_io_uring_register
-428	common	open_tree			sys_open_tree
-429	common	move_mount			sys_move_mount
-430	common	fsopen				sys_fsopen
-431	common	fsconfig			sys_fsconfig
-432	common	fsmount				sys_fsmount
-433	common	fspick				sys_fspick
-434	common	pidfd_open			sys_pidfd_open
-435	common	clone3				sys_clone3
-436	common	close_range			sys_close_range
-437	common	openat2				sys_openat2
-438	common	pidfd_getfd			sys_pidfd_getfd
-439	common	faccessat2			sys_faccessat2
-440	common	process_madvise			sys_process_madvise
-441	common	epoll_pwait2			sys_epoll_pwait2
-442	common	mount_setattr			sys_mount_setattr
-443	common	quotactl_fd			sys_quotactl_fd
-444	common	landlock_create_ruleset		sys_landlock_create_ruleset
-445	common	landlock_add_rule		sys_landlock_add_rule
-446	common	landlock_restrict_self		sys_landlock_restrict_self
-447	common	memfd_secret			sys_memfd_secret
-448	common	process_mrelease		sys_process_mrelease
-449	common	futex_waitv			sys_futex_waitv
-450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
-451	common	cachestat			sys_cachestat
-452	common	fchmodat2			sys_fchmodat2
-453	common	map_shadow_stack		sys_map_shadow_stack
-454	common	futex_wake			sys_futex_wake
-455	common	futex_wait			sys_futex_wait
-456	common	futex_requeue			sys_futex_requeue
-457	common	statmount			sys_statmount
-458	common	listmount			sys_listmount
-459	common	lsm_get_self_attr		sys_lsm_get_self_attr
-460	common	lsm_set_self_attr		sys_lsm_set_self_attr
-461	common	lsm_list_modules		sys_lsm_list_modules
-462	common	mseal				sys_mseal
-463	common	setxattrat			sys_setxattrat
-464	common	getxattrat			sys_getxattrat
-465	common	listxattrat			sys_listxattrat
-466	common	removexattrat			sys_removexattrat
-467	common	open_tree_attr			sys_open_tree_attr
-468	common	file_getattr			sys_file_getattr
-469	common	file_setattr			sys_file_setattr
-470	common	listns				sys_listns
-471	common	rseq_slice_yield		sys_rseq_slice_yield
-472	common	fchroot				sys_fchroot

-- 
2.56.0

