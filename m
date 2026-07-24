Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C570531326A;
	Fri, 24 Jul 2026 02:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784859308; cv=none; b=eLEBvrY+L5uelxNHfdW4TPJ7oI6SPM3vO4hdBH4uTp8zaOpngBhw5J5aV/SVRxmAQs+cCt5fUAU+9W+7eij+AOWE5TtMGRKkC8vHKT9E40V0oFYT4rn2nl1E8cgphdm07GcNGsalHp3C7y3JyeW9YyT8euT0Q1tvIjyzf2Pl4D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784859308; c=relaxed/simple;
	bh=LKtT/eMA/HP7kj2W7H5SSET9KgmXLRS52Vtq6yJWNx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UsDuw5y+94Iih+R7735hZBFoNS5gmtx6VmtgmihXUMaGxueqUGVZhdVRJY5Yj20obLJQqNnbf7FNuzy2LxqLxTeVqe9rYQCp4/hKZPbwSQdX21oFwYelBnBQgaQ0/Ld7Ti3UJKOfyRHWyzDw4UGKe/2lLdMsMZXtTBRRFBmOkOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=A58Q0hC7; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="A58Q0hC7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=77
	TlUQQ5Ug6Bo+r9yStAO1cYSC7lbr5tqO3K9ciX64s=; b=A58Q0hC7pBgmyd1P0k
	hLdauK2xNyRBVzvhAisrBvhwe51IYuU3v9CdBPEmeUuNhaOUQCGDOQWF5MJocr6d
	sUDDytIRZ4RCNVAsuNo5OmI5d3/Yw40nyoy5CkXb3KuvjzGCqY5FdMsT584qwXjb
	/BY0wrzWkU1UlbE8vhPU3x/hE=
Received: from song-MS-7D48.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSkvCgDnr+wRymJqH7z4DA--.34972S2;
	Fri, 24 Jul 2026 10:12:35 +0800 (CST)
From: Song Chen <chensong_2000@126.com>
To: arnd@arndb.de,
	kees@kernel.org,
	clm@fb.com,
	dsterba@suse.com,
	linux@armlinux.org.uk,
	catalin.marinas@arm.com,
	will@kernel.org,
	guoren@kernel.org,
	kernel@xen0n.name,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	gor@linux.ibm.com,
	borntraeger@linux.ibm.com,
	agordeev@linux.ibm.com,
	svens@linux.ibm.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	jpoimboe@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Song Chen <chensong_2000@126.com>
Subject: [RFC PATCH v2 0/3] btrfs: add error injection support for checksum verification
Date: Fri, 24 Jul 2026 10:12:26 +0800
Message-ID: <20260724021229.47302-1-chensong_2000@126.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSkvCgDnr+wRymJqH7z4DA--.34972S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF1xWr1UWw47tryUKF4Durg_yoW8GF1rpr
	y3u3s3uryrC34fCrnxAay8Zw1Fkrs5W34UXFnrG348W343Za4qq3WkKa4UJ3WS9rWUGw17
	X3WUKr4UWr1UAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UonmiUUUUU=
X-CM-SenderInfo: xfkh02prqjsjqqqqqiyswou0bp/xtbBsxPpaWpiyhNNnAAA3g

This patchset adds fault injection support for btrfs_data_csum_ok,
enabling controlled simulation of checksum mismatches to test btrfs
silent data corruption detection and reporting paths.

The first patch extends the error injection framework with a new type,
EI_ETYPE_FALSE, which allows bool-returning functions to be overridden
with a false return value directly.

The second patch marks btrfs_data_csum_ok with ALLOW_ERROR_INJECTION
using this new type.

The third patch adds a parent field to fei_attr to allow fault injection
on a function only when called from a specific parent function. 

Song Chen (3):
  error-injection: Introduce EI_ETYPE_FALSE for fail_function
  btrfs: Allow error injection on btrfs_data_csum_ok
  error-injection: Introduce parent in fei_attr

 arch/arm/lib/error-inject.c           |  6 ++
 arch/arm64/lib/error-inject.c         |  6 ++
 arch/csky/lib/error-inject.c          |  6 ++
 arch/loongarch/lib/error-inject.c     |  6 ++
 arch/powerpc/lib/error-inject.c       |  6 ++
 arch/riscv/lib/error-inject.c         |  6 ++
 arch/s390/lib/error-inject.c          |  6 ++
 arch/x86/lib/error-inject.c           |  6 ++
 fs/btrfs/inode.c                      |  1 +
 include/asm-generic/error-injection.h |  6 ++
 kernel/fail_function.c                | 98 ++++++++++++++++++++++++++-
 11 files changed, 152 insertions(+), 1 deletion(-)

---
changelog:
v1 --- v2:
Add a parent field to struct fei_attr.

-- 
2.43.0

