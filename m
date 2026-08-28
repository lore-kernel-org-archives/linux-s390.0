Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBA4390CAC;
	Fri, 28 Aug 2026 23:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787959209; cv=none; b=jvMKHq3rJkqlMGcmevtaDY5Jn0iJjDj8gXTnMo3SncclZi51RbUtVykbVDXGNrK98RrNGUga22i7EmS5W5M77KOe4z2eVsnwEncxMc4P+wtYBCh0J09+mbzl4wCB08OtfXjhEF6vKHnd3khNDGXLuzVM1zwqEErlP7EbMf5+ucU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787959209; c=relaxed/simple;
	bh=8KINWR3aWJNh3jsfo9XdixjHepxXNFEX1tdYtF6OHNc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lsHiGcBTCf5HDHMdWUPlnSL2QKUSaGGvGi02U7Ici1zoOOH5wOiC4VqlambD69rflnCPEq/VGZXgCKkPR5MufDOGWNA/J5IgagIM57xn0t6+vezSleMLCMA0UFuInbUaeYcWdgTTcxxrHml+6T3LKQnc93sqcaazogReoC98rjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=dYJsvH15; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="dYJsvH15"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=quF/rmJR+ZZUaD4FKwu0PINJg03Gp63DAJI73RocdGk=; b=dYJsvH15sYuxRnAjv+mfsqpraQ
	ek5x/IRCx/aAv9PPtGxCuycfr5RGLmOrEzy/4msiCN1yTUINi3iGQQveZb4LPgQTGh+f4DNSVr8mU
	0LRQf792LSIgHxBaMiSOxDLg7XUhbEzIwk74xjvuTWctLiWXuENZRuXU5Ap4xV0bURrYo8O80Z5ve
	LTaqGW9Xk/7+ZtoUzS0hE/wjCLgpCxzgd67MqnjZ2Ww+bgSOrr1nGAs7eMd6iYfeJEgmjOa+JInkd
	8zRnKieDVDi/xjwrJW9B3lrV7mOlhaMbF7yy+MZxFtw/7amse6K/Q6H2Ty1OHcxe/f/aMFWxbvxnF
	hwmnPsUQ==;
Received: from [187.57.78.212] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1x05rg-00B3sF-Tb; Sat, 29 Aug 2026 01:20:05 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Fri, 28 Aug 2026 20:19:34 -0300
Subject: [PATCH v6 07/13] mips: Remove duplicated syscallnr.sh
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-tonyk-syscall_table-v6-7-fdd358456cf1@igalia.com>
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

The common scripts/ already have a script for generating the numbers of
syscalls file. Use it and drop the custom script.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 arch/mips/kernel/syscalls/Makefile     |  9 +++++----
 arch/mips/kernel/syscalls/syscallnr.sh | 26 --------------------------
 2 files changed, 5 insertions(+), 30 deletions(-)

diff --git a/arch/mips/kernel/syscalls/Makefile b/arch/mips/kernel/syscalls/Makefile
index 56f6f093bb88..69adc21483ed 100644
--- a/arch/mips/kernel/syscalls/Makefile
+++ b/arch/mips/kernel/syscalls/Makefile
@@ -5,16 +5,17 @@ uapi := arch/$(SRCARCH)/include/generated/uapi/asm
 $(shell mkdir -p $(uapi) $(kapi))
 
 syshdr := $(srctree)/scripts/syscallhdr.sh
-sysnr := $(src)/syscallnr.sh
+sysnr := $(srctree)/scripts/syscallnr.sh
 systbl := $(srctree)/scripts/syscalltbl.sh
 
 quiet_cmd_syshdr = SYSHDR  $@
       cmd_syshdr = $(CONFIG_SHELL) $(syshdr) --offset __NR_Linux $< $@
 
 quiet_cmd_sysnr = SYSNR   $@
-      cmd_sysnr = $(CONFIG_SHELL) '$(sysnr)' '$<' '$@'		\
-		  '$(sysnr_abis_$(basetarget))'			\
-		  '$(sysnr_pfx_$(basetarget))'
+      cmd_sysnr = $(CONFIG_SHELL) $(sysnr) \
+		  --prefix $(sysnr_pfx_$(basetarget))_Linux_ \
+		  --abis $(sysnr_abis_$(basetarget)) \
+		  $< $@
 
 quiet_cmd_systbl = SYSTBL  $@
       cmd_systbl = $(CONFIG_SHELL) $(systbl) $< $@
diff --git a/arch/mips/kernel/syscalls/syscallnr.sh b/arch/mips/kernel/syscalls/syscallnr.sh
deleted file mode 100644
index c190bbefbfc2..000000000000
--- a/arch/mips/kernel/syscalls/syscallnr.sh
+++ /dev/null
@@ -1,26 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-in="$1"
-out="$2"
-my_abis=`echo "($3)" | tr ',' '|'`
-prefix="$4"
-
-fileguard=_UAPI_ASM_MIPS_`basename "$out" | sed \
-	-e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
-	-e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g'`
-grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
-	printf "#ifndef %s\n" "${fileguard}"
-	printf "#define %s\n" "${fileguard}"
-	printf "\n"
-
-	nxt=0
-	while read nr abi name entry compat ; do
-		nxt=$((nr+1))
-	done
-
-	printf "#define __NR_%s_Linux_syscalls\t%s\n" "${prefix}" "${nxt}"
-	printf "\n"
-	printf "#endif /* %s */" "${fileguard}"
-	printf "\n"
-) > "$out"

-- 
2.55.0

