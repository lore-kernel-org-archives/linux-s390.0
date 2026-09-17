Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1805937BE8E;
	Thu, 17 Sep 2026 23:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789688786; cv=none; b=HaTtFWJcfSSh+RAkO1SBBhHhrzSut/v0Hkjwk4XHLNlCooZE91ZvHR0AFiW/3/osvpyHVN3pSKGGhP+0FuR5YHGEhVPer8yU+7iz1Uni1VZSVUeZYWQzFJFg77JBJtOG0MWhIKs1y8o7R5pVEDPtPO5RS4kN3sPmmE3CP8TIlmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789688786; c=relaxed/simple;
	bh=vHHIHPa1lFsjzg7u0Oxq2Vzrvlk/fTZC+qk65jaY26s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JlnMxG4bCaVwacK5nlaPVih64oXWJOLAG6LYPAFDD4+ofS5+avtj0FbBdG1q6TSaw8cR8r52eDYgryoNGAg65HivmqI59l/dC3jmPj+uXt9E84Y8RcyD7cxMN3uGYQk7K0RFj0ttLqAtM68oacUre9FXMj5CBIv8H4vG6dDXhZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=fi+SmG/8; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="fi+SmG/8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:From:Reply-To;
	bh=5hETPJVC8a/fIzBrvnlwFruo7YVOIY2oNEFBg9dFIVs=; b=fi+SmG/8LruQujn0/ZBuo8T2F2
	dJwYRbQ9kVK42n7zhIPO5fuQfhPwpan6qw2m8BCISBXExlepwO++SWEplLt0oVSXTxTMyctE4+HhW
	HqjFIuq20AUsyaWFnr8Oyvn/bi2mAYScMRRFcYBkT+QasaEWzFHTBVS5fQIn7wZVl5PoBI7GqZHI1
	pzodGPvq93zP/uD3U/7483cjbBz2h+5C5z+BxAsTO/0Mwjnfaydy9Zk8OPQPxLkund8G2YVL7pFBB
	xJg1Dw3P22IimXbRg5lwf6xr4CW3dZqZl9p/RIYccvfM1HsGq5tbZbJnRXB99XMlqLdn2IubeWGBF
	iTUPU2gA==;
Received: from [177.172.123.214] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1x7Lo1-003hU7-N6; Fri, 18 Sep 2026 01:46:17 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v7 00/13] syscalls: Add a shared table for all archs
Date: Thu, 17 Sep 2026 20:46:03 -0300
Message-Id: <20260917-tonyk-syscall_table-v7-0-f4cd8f8e3265@igalia.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NS07DMBgE4KtUXmNk/36GFfeoKuRnawgJikNEV
 OXu2GVBUAJiOdLMN1eUw5BCRg+HKxrClHLquxLU3QG5i+nOASdfMgICkijgeOy7+QXnOTvTtk+
 jsW3ADWhrLbUgrUVl+TaEmD5u6vH0lfO7fQ5urFRtXFIe+2G+3U609v5+mCgmuHGCUa05MG8e0
 9m0ydy7/hXViwnWiNpHoCLC80hD4IrGDcK+EU1+QVhBlOPCAHOCWLFB+AqhsI/winDtCUBjPCc
 bRPwDEQVhnmnWgHKSNBtErhDQ+4gsSPSeCc2FdJH+QJZl+QQukRL1IgIAAA==
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
 arch/arm/tools/syscall.tbl                |  49 --
 arch/arm64/tools/syscall_32.tbl           |  69 ---
 arch/mips/kernel/scall64-n32.S            |   1 +
 arch/mips/kernel/scall64-n64.S            |   2 +
 arch/mips/kernel/syscalls/Makefile        |  38 +-
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
 scripts/syscalltbl.sh                     |  46 +-
 25 files changed, 1112 insertions(+), 1699 deletions(-)
---
base-commit: 238650ef6c7c7cca08e032527329424c9fbd70e5
change-id: 20260724-tonyk-syscall_table-928bbb1b26bb

Best regards,
--  
André Almeida <andrealmeid@igalia.com>

