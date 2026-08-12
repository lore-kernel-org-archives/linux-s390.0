Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2BA470EA3;
	Wed, 12 Aug 2026 17:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786556338; cv=none; b=P/XE/8wedriIXSzv5jtVJ9o+OGp7CzPsncFfJZzpPHm0yGxSJ3Et5E+98rynX8M4ArDnp29NsA6+P2Tn6bRAadazcNIPLBtoW7CLjGu8DKgqS0tb8CKu/qkj1yH6bIormJrSINfvhn/tJ3oSSQzNeztspkZsL9ukl4AtzopAqPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786556338; c=relaxed/simple;
	bh=BdUMFNJCzMTJ9yhgxSUMIomgDrolOO5XsRQnbpuBLYY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cBHydaEaGuUjSr4bgOUCobIen6s4a5nztUXtTf0bFZSQ5BXMd+Gf2fN4RHq34RFLFdbcaQx46o+4Idg4t93d4uZRKX2kNXBwVZuwOkQlaG0LYm/EHO5YVZisk3ivWBdQ7WbGxuY8StfzdIqnt0D/0ikCThyuzpF88hAEmmq6yuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=OxgkpZiX; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="OxgkpZiX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:From:Reply-To;
	bh=6EzYPaGuuMIoxmiqca3tHSV0ntTQ4/JK20Xi8w7N9+U=; b=OxgkpZiXhDR/EcCzamW0ylPShj
	oWHhVie6raLq6F9t/ANzDoRIteOmIH3FCvGN00E0Oy9cUopBIBUIY9nQAUMGNpz4nRT2M/0XFCtW9
	7DUvCow2v0D0N1mjGa0W08HDnoCbK8AROYQgw6w2HbgHIn9CtBHN+JjwhHKZVGJpnzwHpDzdNdLlN
	kZwPNGv+ogJRaw1pKSgaK+zASX0fUpIFdNov+mYqPrjgRB3hOgofcHt8n6lhtvsRyfxdQIi+oWktZ
	kEmQfktpKszHcoTleA1LplJbnQFblmCuJr/Tn5Csi8gbjSKEW1g9+y6yQKjaFNRakv/Q87XFfWCXv
	rKjtFCJQ==;
Received: from [177.139.22.20] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wuCug-000FR2-Ux; Wed, 12 Aug 2026 19:38:51 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v5 00/13] syscalls: Add a shared table for all archs
Date: Wed, 12 Aug 2026 14:38:31 -0300
Message-Id: <20260812-tonyk-syscall_table-v5-0-3d383927c609@igalia.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NwU7DMBAE0F+pfMbIXq8bhxP/gSrktTetIU1Qn
 EZEVf6duBwoauE40sybs8g8JM7iaXMWA08pp75bg33YiHDw3Z5limsWoGCrKkA59t38LvOcg2/
 b19FTy7IGR0SaYEsk1uXHwE36vKgvu++cT/TGYSxUaRxSHvthvtxOuvT+f5i0VLIO1mjnEEz0z
 2nv2+QfQ38U5WKCa6S6j0BBbMRGM2OlmxvE/CBO/YGYFakCWg8mWEX2BsErRMN9BAuCLiqA2kd
 Uv5BlWb4AS3uiUZgBAAA=
X-Change-ID: 20260724-tonyk-syscall_table-928bbb1b26bb
To: Masami Hiramatsu <mhiramat@kernel.org>, Arnd Bergmanon <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
 kernel-dev@igalia.com, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 linux-alpha@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev, 
 linux-mips@vger.kernel.org, parclinux@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
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
André Almeida (13):
      syscalls: Make --abis parsing more robust
      syscalls: Create unified partial table for all archs
      scripts/syscall.tbl: Use the common table
      arm: Use the common syscall table
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
 arch/alpha/kernel/syscalls/Makefile       |  10 +-
 arch/alpha/kernel/syscalls/syscall.tbl    |  54 +-
 arch/alpha/kernel/systbls.S               |   1 +
 arch/arm/tools/Makefile                   |  10 +-
 arch/arm/tools/syscall.tbl                |  68 ---
 arch/arm64/tools/syscall_32.tbl           |  68 ---
 arch/mips/kernel/scall64-n32.S            |   1 +
 arch/mips/kernel/scall64-n64.S            |   2 +
 arch/mips/kernel/syscalls/Makefile        |  30 +-
 arch/mips/kernel/syscalls/syscall_n.tbl   | 464 +++++++++++++++++
 arch/mips/kernel/syscalls/syscall_n32.tbl | 412 ---------------
 arch/mips/kernel/syscalls/syscall_n64.tbl | 388 --------------
 arch/mips/kernel/syscalls/syscall_o32.tbl | 826 ++++++++++++++----------------
 arch/mips/kernel/syscalls/syscallnr.sh    |  26 -
 arch/s390/kernel/syscall.c                |   2 +
 arch/s390/kernel/syscalls/Makefile        |   8 +-
 arch/s390/kernel/syscalls/syscall.tbl     |  48 --
 arch/sparc/kernel/syscalls/Makefile       |   8 +-
 arch/sparc/kernel/syscalls/syscall.tbl    |  68 ---
 scripts/Makefile.asm-headers              |   9 +-
 scripts/syscall.tbl                       |  68 ---
 scripts/syscall_common.tbl                |  83 +++
 scripts/syscallhdr.sh                     |  81 ++-
 scripts/syscalltbl.sh                     |  47 +-
 25 files changed, 1094 insertions(+), 1696 deletions(-)
---
base-commit: 075b74841bd0065a3bda3440873c747938e69b68
change-id: 20260724-tonyk-syscall_table-928bbb1b26bb

Best regards,
--  
André Almeida <andrealmeid@igalia.com>

