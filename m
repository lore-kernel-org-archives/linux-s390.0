Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795119720;
	b=G91RKRqfCaib6VnHTc3t4HigYR46z70ozzw+tOCZqaxB/q9FQasnuEhOrWn/sU21Y2FI
	 CL/FCPPxB3+hnsdjT3fSrR8iTqy8aUmT7Aoyrpgms5Pgk/fZNhtnYqfCUMrTWHURM5WvG
	 k3fFvotPro0VwVDLJmqr7tqA3IR0jh2ujzpjU5tAM3ljHIghTIZn2zG4f1JFegblvr2Oe
	 rR4y+9iAWXl42I8UzXz3pPXjGXs6YYDdYaL2eyXHl87fJA6FOVoD5RgTJVypbcq1HJbLm
	 T9NIrPSHeAs4j09LR0uy8ojfmDXrxv40dFJOLxepRVomtDdEUksbjCyYGr5DLYCGtmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119720;
	h=DMARC-Filter:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer;
	bh=lKqTvjfVAMuV2tixJjKzEjlDg6oeaFaEwcBN1UQ2ZBQ=;
	b=sTPZcVFEqJidyE1IBgt6ZKo0Zbs29V4oHyZA6dk/9OPRttHMoAZTaRbQMqeBWjNzmVg4
	 M64X2+sE2YneC6L+0+ZPhXHn/D9Rh7ROiPx4wsCsGKzw8og29BcmgPvQVP2OOpCAm3Ccv
	 mIExsip7AGc2wq8neN+daSPjJ28be2DaholVweD2GQrSDvENXuyXjsZ3y+OY0kdxUR8ih
	 /73yMDMHXr16pSWwni1Ai2pKRGIZbGj8TJ2XOmxdWzuOnybWHLu3RmXhZ4AnQMtwumIpM
	 AqRl38ayvj0zgjF9f5pEO8EazlFP6x4xxHDgDCm84JJtbhO2G3npwaSFmERjPX4GvhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b="r/pSEXxD";
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9E5606A331;
	Thu, 19 Nov 2026 20:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC9E5606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=r/pSEXxD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:From:Reply-To;
	bh=lKqTvjfVAMuV2tixJjKzEjlDg6oeaFaEwcBN1UQ2ZBQ=; t=1795119718; x=2110479718; 
	b=r/pSEXxDxhVPCQy3OjmmLOJLN9mwpAJAg66ni/PRgwHzZwdEMQvhxwNCG9bo/R2jbwEY5A8Q7Fv
	tZaYmUTG8MB6qiqpSV+qz/0HVKtqpkaHJxs4wX9iW+TXvLHhSwLDjvueMW62SqDt48KXRbBxPSmiF
	wiNGPRxeTbKqeaBee45IUGte+KC+WRPBSNzZdG83L7P67V2evkVwSG8n5D5izgAcp24Z5zTDvDMSU
	WSKdEzrIcbePfax0ZaD/z6ImzNny1Ac2DOSUx3+vN2KAjMZV4Fto25mH6x6126aWD4+C40nmGW+9a
	tu6rB7q1mpKXF+bvJf/EDpcn3Nkg+PaK8mbA==;
Received: from [177.172.124.218] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xU8dm-00000001cIK-1RKD;
	Thu, 19 Nov 2026 21:21:54 +0100
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v10 00/16] syscalls: Add a shared table for all archs
Date: Thu, 19 Nov 2026 17:21:50 -0300
Message-Id: <20261119-tonyk-syscall_table-v10-0-a7c9ebd900f6@igalia.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43Q207DMAwG4FeZck1R4pwcrngPhFBO3QLdippSM
 U17d9IhsaJ0iEtb9vdbPpEchxQzedicyBCnlFN/KAWjdxvid/awjU0KpUGAgqIaRDP2h+Nbk4/
 Z2657Ga3rYmMAnXPMgXKOlM33Ibbp88I+PX/X+cO9Rj/O1DyxS3nsh+Mld2Lz3N8JE2toY7zkD
 FEAD/YxbW2X7L3v92SOmGCJ6HUEZkQG0bIYhWZthfArgvQGwguivZAWuJfUyQoRC4TBOiJmRGC
 gAMYGQStE/gORBeGBIzegvaKmQtQCAVxHVEHaELhEIZVvWYXoK2LYjZ/oGRE+YIuRg6p/gkvkx
 iVYEBohKOptYDxWiPlBGKNyHTEFwcBAS0QZjP+FnM/nL220kPTyAgAA
X-Change-ID: 20260724-tonyk-syscall_table-928bbb1b26bb
To: Masami Hiramatsu <mhiramat@kernel.org>, Arnd Bergmanon <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, kernel-dev@igalia.com, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 linux-alpha@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev, 
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
 Magnus Lindholm <linmag7@gmail.com>, 
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

This patchset depends on recent alpha commits (from "alpha: fix saved registers
in page-fault oops dumps" till "alpha: use generic CPU device registration
until") that can be found at:

  https://git.kernel.org/pub/scm/linux/kernel/git/lindholm/alpha.git
  branch: for-next

Thanks!
	André

Changes in v10:
- New patch for synchronizing perf with the new common table
- Fixed missing oabic entry for sys_syscall
- Reworked --common-offset option to make the syscall numbers look like #define
  syscall (<offset> + <nr>) instead of the final number
- Rebased on top of new syscall alpha patches
- Link to v9: https://patch.msgid.link/20261105-tonyk-syscall_table-v9-0-8d1275885d9c@igalia.com

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
André Almeida (16):
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
      alpha: Use the common syscall table
      syscalls: Avoid matching substrings in the ABI parsing
      arm: Reorganize syscall table and separated the ABIs
      arm: Use common syscall table
      perf: Add an option for common table for build_tables()
      perf: Synchronize syscall tables with shared table

 arch/alpha/kernel/syscalls/Makefile                |  14 +-
 arch/alpha/kernel/syscalls/syscall.tbl             |  49 --
 arch/alpha/kernel/systbls.S                        |   1 +
 arch/arc/kernel/Makefile.syscalls                  |   2 +-
 arch/arm/kernel/entry-common.S                     |   4 +-
 arch/arm/tools/Makefile                            |  15 +-
 arch/arm/tools/syscall.tbl                         | 153 ++--
 arch/arm64/kernel/Makefile.syscalls                |   4 +-
 arch/arm64/tools/syscall_32.tbl                    |  69 --
 arch/csky/kernel/Makefile.syscalls                 |   3 +-
 arch/hexagon/kernel/Makefile.syscalls              |   2 +-
 arch/loongarch/kernel/Makefile.syscalls            |   4 +-
 arch/mips/kernel/scall64-n32.S                     |   1 +
 arch/mips/kernel/scall64-n64.S                     |   1 +
 arch/mips/kernel/syscalls/Makefile                 |  28 +-
 arch/mips/kernel/syscalls/syscall_n32.tbl          | 735 +++++++++---------
 arch/mips/kernel/syscalls/syscall_n64.tbl          | 707 ++++++++----------
 arch/mips/kernel/syscalls/syscall_o32.tbl          | 827 ++++++++++-----------
 arch/mips/kernel/syscalls/syscallnr.sh             |  26 -
 arch/nios2/kernel/Makefile.syscalls                |   2 +-
 arch/nios2/kernel/syscall_table.c                  |   1 -
 arch/openrisc/kernel/Makefile.syscalls             |   2 +-
 arch/openrisc/kernel/sys_call_table.c              |   1 -
 arch/riscv/kernel/Makefile.syscalls                |   4 +-
 arch/s390/kernel/syscall.c                         |   2 +
 arch/s390/kernel/syscalls/Makefile                 |  12 +-
 arch/s390/kernel/syscalls/syscall.tbl              |  49 --
 arch/sparc/kernel/syscalls/Makefile                |  12 +-
 arch/sparc/kernel/syscalls/syscall.tbl             |  69 --
 scripts/Makefile.asm-headers                       |  11 +-
 scripts/syscall.tbl                                |  69 --
 scripts/syscall_common.tbl                         |  84 +++
 scripts/syscallhdr.sh                              |  83 ++-
 scripts/syscalltbl.sh                              |  46 +-
 tools/perf/arch/arm/entry/syscalls/syscall.tbl     | 153 ++--
 .../perf/arch/mips/entry/syscalls/syscall_n64.tbl  | 707 ++++++++----------
 tools/perf/arch/s390/entry/syscalls/syscall.tbl    |  49 --
 tools/perf/arch/sparc/entry/syscalls/syscall.tbl   |  69 --
 tools/perf/check-headers.sh                        |   1 +
 tools/perf/trace/beauty/syscalltbl.sh              |  38 +-
 tools/scripts/syscall.tbl                          |  69 --
 tools/scripts/syscall_common.tbl                   |  84 +++
 42 files changed, 1875 insertions(+), 2387 deletions(-)
---
base-commit: 17ef53bb8c797a1a9a60021355c636bf63c46886
change-id: 20260724-tonyk-syscall_table-928bbb1b26bb

Best regards,
--  
André Almeida <andrealmeid@igalia.com>

