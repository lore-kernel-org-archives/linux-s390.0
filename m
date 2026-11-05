Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793909178;
	b=wje+5Gn6AMUilD6UjWytD+SE4BoKwepZcUl5W2z//+RLdN7er3xx1WTpJ2bLqt5hnmG1
	 lqkISWlLCUvWG9DzRumyuSRRPIhDeqOW6RwWxe3HtOA2JBDIaEAp3Xq1XEn6b949i41Cy
	 4Y49jmTgL5mXVCY85Q8C5sSnuOtQ3975mJQreYrBNssm8SSY080YAqUBU1Oc/YRgncqtv
	 xYzh2hwgYvScC7IXTP1v/6DoZ/oNa71LtDRwFgi3Do8184azd2FRks4Wy25lKfPcGHQtE
	 vzzT5PfIhCGsE/jxb4nn0nmDzdlCh4BBbtFtH8oMg1f+FXnqp6aLqApjwGg2ArVfaOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793909178;
	h=DMARC-Filter:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer;
	bh=LKPxNJL5D83v9Bql8mK2j7RYIcWIvXSuqXd/N7BefGA=;
	b=Oxg8ST6xrOYQaJsllD8FrQeNySWrHl8Ue7zquLMcAtm7Zy2aoOm7kAb342frtgyAvq10
	 oVovjwBHnpe8jbowLudJ67utvbYzCvR5XI2YngmWn9fHkM4wtjRMiGbbKyaGlJ7cruSDE
	 V+fjda6svsqtThJs9ho2HGC0VBwJ0lopAMWvPvkhR7rJrG5Vdoto3hQCQhzF2pA3i20+r
	 Z4+yljTHyb9wfWeGBshXJqSCCYkL0ADe96BArR0rp1WRs8jzU/2brGcLgaKMO/894xDLZ
	 lZO6xhzym/800cJUry8E5ghM+4ItOxHxlQNJGux+Igp/thXS/SLs2zsCQibrOVSvqOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=OHGbzEbs;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DE6606A326;
	Thu,  5 Nov 2026 20:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28DE6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=OHGbzEbs
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:From:Reply-To;
	bh=LKPxNJL5D83v9Bql8mK2j7RYIcWIvXSuqXd/N7BefGA=; t=1793909175; x=2109269175; 
	b=OHGbzEbscLQKJIdsIaUkTl4P6zvcNv6/Tc329WE0uzlHKbSETBB48HP++jcpADCRVs0k+Rm2fsF
	KMNssLJAhF5jgJHryYFJZJ2Saend1HGwP1tg6fXKBLD3jyEhjGswriHWCy+Lsu9iNhD52+MflvfwX
	QyhqY86l2dhsW+qtpGidca0GK1cxtf+y0XMJWR/fmqEHdfacL31cCEoX4Qq5hrKfyXPtMlkmB/Nco
	C0+yuvEufSw+i6RwVc1jJK/70Vwr2vzpJe90NsDM1J1JwaYQ5CXdMxMGucCYjpi6Ahd07Plphyeg4
	rVZVufD+AdmcBO+1JpB3pZxE39zrjGpcNb9A==;
Received: from [177.172.122.137] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xP3in-003hS1-BW; Thu, 05 Nov 2026 21:06:05 +0100
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v9 00/15] syscalls: Add a shared table for all archs
Date: Thu, 05 Nov 2026 17:05:35 -0300
Message-Id: <20261105-tonyk-syscall_table-v9-0-8d1275885d9c@igalia.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43Qy07DMBAF0F+pvMbIHr9Z8R8IIb/SGkKC4hARV
 fl37LJoUFLE8koz547mjHIcUszo4XBGQ5xSTn1Xgrk7IH+y3THiFEpGQEASBRyPfTe/4Txnb9v
 2ZbSujdiAds5RB9I5VDY/htikr4v69PyT86d7jX6sVJ04pTz2w3ypnWid+7thophg4wWjWnNgw
 T6mo22Tvff9O6oVE6wRtY9ARUTgDY2RK9psEHZFNLmBsIIoz4UF5gVxYoPwFUJhH+EV4ToQAGM
 DJxtE/AMRBWGBaWZAeUnMBpErBPQ+IgvShMCE5kL6hm4QdUUMvfETVRHug250ZCC3P9Fr5MYlu
 iAkQpDE20BZ/IUsy/INN/1Fo6wCAAA=
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

Changes in v9:
- arm: get arm32 back. The local syscall table entries was splitted making
easier to deal with OABI, OABI with compat and EABI.
- Link to v8: https://patch.msgid.link/20260918-tonyk-syscall_table-v8-0-0e2d60cad13e@igalia.com

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
André Almeida (15):
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
      syscalls: Avoid matching substrings in the ABI parsing
      arm: Reorganize syscall table and separated the ABIs
      arm: Use common syscall table

 arch/alpha/kernel/entry.S                 |   8 +-
 arch/alpha/kernel/syscalls/Makefile       |  14 +-
 arch/alpha/kernel/syscalls/syscall.tbl    |  55 +-
 arch/alpha/kernel/systbls.S               |   1 +
 arch/arc/kernel/Makefile.syscalls         |   2 +-
 arch/arm/kernel/entry-common.S            |   4 +-
 arch/arm/tools/Makefile                   |  15 +-
 arch/arm/tools/syscall.tbl                | 152 +++---
 arch/arm64/kernel/Makefile.syscalls       |   4 +-
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
 35 files changed, 1377 insertions(+), 1728 deletions(-)
---
base-commit: 34d5717d427cc2d8f21e6e72f9ded880a148cfeb
change-id: 20260724-tonyk-syscall_table-928bbb1b26bb

Best regards,
--  
André Almeida <andrealmeid@igalia.com>

