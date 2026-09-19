Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B08A30F92D;
	Sat, 19 Sep 2026 00:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789777891; cv=none; b=gQlHDlzkM16gea34T6HRd1CGqIa3RpEuvZprMvDFVLWd4LNn2xp55A6YATrIPFM41Lg5DZS0CRnTeXdhDbRjboho4cxsJraOsXknrPv8WxwluM1bIPRxtaHc8cYJTY+IpVo0oytVYkbrLlMpv5/bAvV/B5EylH/Zr9hIvnSxuxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789777891; c=relaxed/simple;
	bh=eSE4282gtSkx53qUyiD+AxM4Aqf74mvIzwxnVNx/4X0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=djpIf7W5Vh70LfN1Hq8wSnKjLShFAl3J08FIKOq3NN4jTTqGlCgelXN1js96ZIw5HymrFGdNTbP1N+0intmjtkviPusomley0Rjp4dRfR1VK3FN+SpvL3ZQqmmcyQde19+jODebz3pGM/MDRNsEILtaRkA9Xzm8OUPFF0zH0mkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=nCMQBNrj; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="nCMQBNrj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:From:Reply-To;
	bh=tecnNpkcuzQb1g9n/363b8Fb2gTSV+syzGvJZJJTHR8=; b=nCMQBNrjl6nHrfdrR/7iN/L2t6
	F/CsxVPJclK0o9URw/b+zP6Fq6DGnXUlG+OHBJrKQ/iffNpsv5/RYGgBDYqD4Ex5S/nSeLJppa+65
	cVDuLV95nzoHGaNyJsni8L3TzWHhCs/C4GbVSHuaqzY/oLWy60YqxdV2xsU+4rg16R+1ZlTWoAnpB
	xcZVEj/LQnIqMAH3+MZhoK6UCawFPB437G1B2USSPiPVcESKybHQ2qcjjbI0aW2lwQZxlfw1DaSdg
	NWU/153StfdOlwE8b9uU4F7n9ZtMtdcCM6WM+i1v+zB4M0CXX2R8T6IZtC8xbWJtw1AeZuPD+NW1W
	44QAl71Q==;
Received: from [177.172.123.214] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1x7iz2-004Bwz-4u; Sat, 19 Sep 2026 02:31:12 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v8 00/12] syscalls: Add a shared table for all archs
Date: Fri, 18 Sep 2026 21:31:07 -0300
Message-Id: <20260918-tonyk-syscall_table-v8-0-0e2d60cad13e@igalia.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43QzUrEMBQF4FcZsjaS3PzWle8hIvmdidZWmlosQ
 9/dZFxMpR1xeeDc78A9oxyGFDJ6OJzREKaUU9+VoO8OyJ1Mdww4+ZIREJBEAcdj381vOM/ZmbZ
 9GY1tA25AW2upBWktKpcfQ4jp66I+Pf/k/GlfgxsrVRunlMd+mC+zE629vxcmiglunGBUaw7Mm
 8d0NG0y965/R3VigjWi9hGoiPA80hC4onGDsCuiyQ2EFUQ5LgwwJ4gVG4SvEAr7CK8I154ANMZ
 zskHEPxBREOaZZg0oJ0mzQeQKAb2PyIJE75nQXEgX6QZRV6ShN36iKsKd11EHBvL3T5Zl+QaFu
 PWMZwIAAA==
X-Change-ID: 20260724-tonyk-syscall_table-928bbb1b26bb
To: Masami Hiramatsu <mhiramat@kernel.org>, Arnd Bergmanon <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, kernel-dev@igalia.com, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 linux-alpha@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev, 
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
 Magnus Lindholm <linmag7@gmail.com>
X-Mailer: b4 0.15.2

While implementing a new syscall, we need to wire up it's number to the arch
table. Since syscall number 403, all architectures are on sync regarding the
number (except alpha), which make things a lot easier but more repetitive as
well. Have a look at commit b36d4b6aa88 ("arch: hookup listns() system call"),
with 15 lines of mostly:

  +470    common  listns                          sys_listns

There's already a "common" table shared with a bunch of archs at
`scripts/syscall.tbl`, but due to historical reasons some archs will never be
able to move to this table and share all the numbers.

The generic table starts from 403 (clock_gettime64), the first common syscall.

I've compile tested for arm32, arm64, s390, mips, sparc and alpha by comparing
the syscalls_*.h and unistd_*.h files generated before and after this patchset.
For most of cases the files are identical, for the few cases that they are not,
there's a note in the commit explaining why they are equivalent.

Thanks!
	André

Changes in v8:
- syscall.tbl: Fix clone3 entries for nios2 and openrisc.
- arm: Dropped arm32 from patchset for now, till we figure a good way to deal
  with OABI issues
- mips: Removed common file (syscall_n.tbl) for syscall_n32.tbl and
  syscall_n64.tbl
- alpha: Fix __clone3 entry
- Link to v7: https://patch.msgid.link/20260917-tonyk-syscall_table-v7-0-f4cd8f8e3265@igalia.com

Changes in v7:
- mips: Fix rules to make it rebuild when tables file change
- mips: Update unistd_%.h rule to new table files
- arm: Add back syscalls from 403 to 423. arm can't use the common table
definition for those syscalls, because the common table defines compat entry
point for some of them, and arm32 does not. On arm32 with OABI, this will cause
linking issues.
- Replace mktemp -p with mktemp, to make it more portable
- Link to v6: https://patch.msgid.link/20260828-tonyk-syscall_table-v6-0-fdd358456cf1@igalia.com

Changes in v6:
- Rebased on top of 7.3-rc0: new syscall fchroot()
- Fix compliance with POSIX shells
- Add $(syscalltbl_common) to the prereq build files, so the build is triggered
if the common table changes
- v5: https://patch.msgid.link/20260812-tonyk-syscall_table-v5-0-3d383927c609@igalia.com

Changes in v5:
- Add archs lists to Cc
- alpha: Change custom alpha_syscall to __syscall
- mips: Use "common" for all ABI tables
- mips: Kept it as a single table for n32/n64
- Fix bug introduced by mixing --offset and --compat-offset
- v4: https://patch.msgid.link/20260812-tonyk-syscall_table-v4-0-748d0229ad40@igalia.com

Changes in v4:
- Replace cln3 with clone3 in the ABIs
- mips: Get rid of custom mips ABIs (o32, n32, n64) and use 32 and 64
- mips: Unify n32 and n64 tables
- Add alpha to the syscall party, along with it's adaptations
- Remove --no-compat option and define SYSCALL_WITH_COMPAT() macro for archs
that need it
- v3: https://patch.msgid.link/20260807-tonyk-syscall_table-v3-0-7c45a23c50b5@igalia.com

Changes in v3:
- Removed x86 for now, let's wait till x32 is dropped
- Added much more archs
- v2: https://patch.msgid.link/20260727-tonyk-syscall_table-v2-0-95d4f1ee471f@igalia.com

Changes in v2:
- Managed to move to the real first common syscall: 403 (clock_gettime64)
- Added -no-compat option to be used with x86_64
- v1: https://patch.msgid.link/20260724-tonyk-syscall_table-v1-0-9c53188423da@igalia.com

---
André Almeida (12):
      syscalls: Make --abis parsing more robust
      syscalls: Create unified partial table for all archs
      scripts/syscall.tbl: Use the common table
      s390: Use the common syscall table
      sparc: Use the common syscall table
      mips: Remove duplicated syscallnr.sh
      mips: Get rid of custom mips ABIs for syscall tables
      mips: Use the common syscall table
      syscalls: Add an option for offsetting the common table
      alpha: Define entry point for set_mempolicy_home_node syscall
      alpha: Remove alpha_ prefix from custom syscall entries
      alpha: Use the common syscall table

 arch/alpha/kernel/entry.S                 |   8 +-
 arch/alpha/kernel/syscalls/Makefile       |  14 +-
 arch/alpha/kernel/syscalls/syscall.tbl    |  55 +-
 arch/alpha/kernel/systbls.S               |   1 +
 arch/arc/kernel/Makefile.syscalls         |   2 +-
 arch/arm64/kernel/Makefile.syscalls       |   2 +-
 arch/arm64/tools/syscall_32.tbl           |  69 ---
 arch/csky/kernel/Makefile.syscalls        |   3 +-
 arch/hexagon/kernel/Makefile.syscalls     |   2 +-
 arch/loongarch/kernel/Makefile.syscalls   |   4 +-
 arch/mips/kernel/scall64-n32.S            |   1 +
 arch/mips/kernel/scall64-n64.S            |   1 +
 arch/mips/kernel/syscalls/Makefile        |  28 +-
 arch/mips/kernel/syscalls/syscall_n32.tbl | 735 ++++++++++++--------------
 arch/mips/kernel/syscalls/syscall_n64.tbl | 707 ++++++++++++-------------
 arch/mips/kernel/syscalls/syscall_o32.tbl | 827 ++++++++++++++----------------
 arch/mips/kernel/syscalls/syscallnr.sh    |  26 -
 arch/nios2/kernel/Makefile.syscalls       |   2 +-
 arch/nios2/kernel/syscall_table.c         |   1 -
 arch/openrisc/kernel/Makefile.syscalls    |   2 +-
 arch/openrisc/kernel/sys_call_table.c     |   1 -
 arch/riscv/kernel/Makefile.syscalls       |   4 +-
 arch/s390/kernel/syscall.c                |   2 +
 arch/s390/kernel/syscalls/Makefile        |  12 +-
 arch/s390/kernel/syscalls/syscall.tbl     |  49 --
 arch/sparc/kernel/syscalls/Makefile       |  12 +-
 arch/sparc/kernel/syscalls/syscall.tbl    |  69 ---
 scripts/Makefile.asm-headers              |  11 +-
 scripts/syscall.tbl                       |  69 ---
 scripts/syscall_common.tbl                |  84 +++
 scripts/syscallhdr.sh                     |  83 ++-
 scripts/syscalltbl.sh                     |  46 +-
 32 files changed, 1300 insertions(+), 1632 deletions(-)
---
base-commit: 238650ef6c7c7cca08e032527329424c9fbd70e5
change-id: 20260724-tonyk-syscall_table-928bbb1b26bb

Best regards,
--  
André Almeida <andrealmeid@igalia.com>

