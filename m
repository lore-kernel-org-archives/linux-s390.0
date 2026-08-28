Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAF9305699;
	Fri, 28 Aug 2026 23:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787959195; cv=none; b=d0MM8XTzJsVQ5Dvqs1PXBYcDhoRnIGV3nmPQqEVTcJCvnwYtkNiFvl/7use6l9AZdBBKz+BRe05F7T6E0B92gbOURAXZ//3CJWsaFPAWX0GIzDG1DnD6IMGSjVUUPxXtncQEELYOUn7pSY3USn0zCAADNgPpQ6XbOoDV5Nx+YPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787959195; c=relaxed/simple;
	bh=mCmFhyvB3CiDIQFueNr3U4X4g7jmuLEAwOL4s3m6sKQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OCcQ/HQPKdjMUj1mAfhoRhyLqiEPXuRNf1tFQarevsedxkM7m+E6p7CnSRYx6OHYmCnwfMH/y7J7TFaS/SJ/Aa/DBYHTUIwmG7tnNFRrJsH8e3o0RDpNUNHRtSCmp30A7tKfjWZYyJr7tULd7+87dY4CpMwiXZrV77ILU7YUS4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=AFBr+8MF; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="AFBr+8MF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:From:Reply-To;
	bh=3lS8Pe52E15AsSTbFDf2Q8tOnEgRxl/Bw8+tn4QAZ3Q=; b=AFBr+8MF6Vo2i6RVnqs6KlfZGV
	MqMzbqDgglqnFphc/cnp9EsC5M1YMlCCa8uuHY82nTwytw0vgNMyHDHGwexSVgELFlkEj36oG5H8/
	fqvxBpUdG7QMdriCtgNoTTLJU8jeZHfvE64QQJITv/uP+DgdJCeuhOp0aG12Z++AbA0QHqB1IjVtf
	9xVemXIycIb/pvCosC495IjxXXO01gZjV+hF1isHqoD/O4Y9/9GmyMjdY/gWK2VXp0yuWg4MLxnn2
	aV8w51KZdz8AR29jCkajERX+bxfEmlnltDqEOEGYexi9CZ8hOR2XgRjSpQAIBenxVLPKrox169wKa
	BHvhK/Jg==;
Received: from [187.57.78.212] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1x05rI-00B3sF-KD; Sat, 29 Aug 2026 01:19:40 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v6 00/13] syscalls: Add a shared table for all archs
Date: Fri, 28 Aug 2026 20:19:27 -0300
Message-Id: <20260828-tonyk-syscall_table-v6-0-fdd358456cf1@igalia.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NTU7DMBQE4KtUXmNkP9uxzYp7VBXyz0trCAmKQ
 0RU5e7YZUFRCmI50sw3Z5JxTJjJw+5MRpxTTkNfQnO3I+Hk+iPSFEsmwKBhGiSdhn55oXnJwXX
 d0+R8h9SC8d5zD433pCzfRmzTx0XdH75yfvfPGKZK1cYp5WkYl8vtzGvv74eZU0ZtUIIbI0FE9
 5iOrkvuPgyvpF7McI3o2whUREXZckSpebtBxDdi2C+IKIgOUjkQQTGvNoi8QjjcRmRFpIkMwLo
 o2QZR/0BUQUQURljQoWH2B7Ku6yfn2gP73QEAAA==
X-Change-ID: 20260724-tonyk-syscall_table-928bbb1b26bb
To: Masami Hiramatsu <mhiramat@kernel.org>, Arnd Bergmanon <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, kernel-dev@igalia.com, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 linux-alpha@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev, 
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, 
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
 arch/alpha/kernel/syscalls/Makefile       |  14 +-
 arch/alpha/kernel/syscalls/syscall.tbl    |  55 +-
 arch/alpha/kernel/systbls.S               |   1 +
 arch/arm/tools/Makefile                   |  14 +-
 arch/arm/tools/syscall.tbl                |  69 ---
 arch/arm64/tools/syscall_32.tbl           |  69 ---
 arch/mips/kernel/scall64-n32.S            |   1 +
 arch/mips/kernel/scall64-n64.S            |   2 +
 arch/mips/kernel/syscalls/Makefile        |  30 +-
 arch/mips/kernel/syscalls/syscall_n.tbl   | 464 +++++++++++++++++
 arch/mips/kernel/syscalls/syscall_n32.tbl | 413 ---------------
 arch/mips/kernel/syscalls/syscall_n64.tbl | 389 --------------
 arch/mips/kernel/syscalls/syscall_o32.tbl | 827 ++++++++++++++----------------
 arch/mips/kernel/syscalls/syscallnr.sh    |  26 -
 arch/s390/kernel/syscall.c                |   2 +
 arch/s390/kernel/syscalls/Makefile        |  12 +-
 arch/s390/kernel/syscalls/syscall.tbl     |  49 --
 arch/sparc/kernel/syscalls/Makefile       |  12 +-
 arch/sparc/kernel/syscalls/syscall.tbl    |  69 ---
 scripts/Makefile.asm-headers              |  15 +-
 scripts/syscall.tbl                       |  69 ---
 scripts/syscall_common.tbl                |  84 +++
 scripts/syscallhdr.sh                     |  83 ++-
 scripts/syscalltbl.sh                     |  50 +-
 25 files changed, 1111 insertions(+), 1716 deletions(-)
---
base-commit: 548e7bcd0c5460ddcbca9600cea603ebeebf4da7
change-id: 20260724-tonyk-syscall_table-928bbb1b26bb

Best regards,
--  
André Almeida <andrealmeid@igalia.com>

