Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4512701C0
	for <linux-s390@vger.kernel.org>; Fri, 12 Sep 2025 11:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757676770; cv=none; b=LZASuVbZQkgzBiAz+6R8688K5Re0j68weHRslf6EtnRoN0O9HT23PTtlHNJnlsrAnLZHJDWhze+OHBjZlPOpl/gNvGo1e9YKHxN9/OjjZNbKQmYGyUegB2CbJ52aMpUrRoc2FSoaZ08PoayQ69xDHoa37fRoSOjTVI3/E6VlOMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757676770; c=relaxed/simple;
	bh=mEjJFVIYIe7tqpxYWnwn8npcdZ3rzCy2M6nLHqTd3WY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=akfkNvUgeWllq4CI4EBWkaFHRfama32BBiAXd9mBN+BLxwc9nxy/UxDLH09UD64Wsh/KRqKzInHP0YVw9W93kGvUgx50G/uJMuCXVTw3XUM7i1m9pBdZO8uEGgyc9tH0wC2olAMn40NwuCAYQEBYHbHxuTkCYva5uVFV4+oNRbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uhVfks31; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uhVfks31"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24cb39fbd90so15714135ad.3
        for <linux-s390@vger.kernel.org>; Fri, 12 Sep 2025 04:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757676768; x=1758281568; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y6Vu9krI8L/L917eJRdmIwH3Jf+YuSh9fi/gZdnGGTM=;
        b=uhVfks31+0tcoVyU0GVpuTuBPBKY4lB1FDJ5XgACl0jUahUff6jWNOqMHF1Teq0DSz
         MKLzWdnPqVv2oxkuf8PTybCakTNdK4ETOw7VmakDHzWm896g21AZlWm7waq3hWr1LGHQ
         zePyhUg5J3RtXp1MJIB5i9idbBbnRwzWIeHqp8xqX4/SgMvOXQYMm/iHFLAyMPHv3wNE
         bWbArj9TWcprjsWdNkqUNHNtF0sjmrKaGUCZUG3M/UzVy47o8dd8mWGiOaZwmbf0HS8p
         l7kGHURM1tsfCKP/b3YX1HeAPOthQwSVXL4eZchuchq11tpbiDZFWGsUmb3se+D7GncR
         ddEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757676768; x=1758281568;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y6Vu9krI8L/L917eJRdmIwH3Jf+YuSh9fi/gZdnGGTM=;
        b=ApzYzrS8JlFU/OxlVplWLPmG5FVs5Enjjbpukzao7x6NeNR4frCaqZXF2lqEDdcRVp
         6KImwbjYAeyR0I1uM9F009Mt9Ga2SCk86VUWL7EhnC03Mx9b1yQblsgiew1T1TC8qiPZ
         2QQdX+ppfBXJHer+LgD+C/lERypRYrsrNG4Uvrcsl11QAFrE1kX9Lw35PtcZklhE8/FH
         2FWAEeEP5bb/kRotgCav3dXXylHupScc48KWVVEB05pxoy7JDAnsbTKQW8BSpkegQaQc
         pSaPYTskc3R3Xax7uVlnmQJVD1EpFYoJB72oYeJTHZ8rjEA5ng3OEaNrjpr4YSjhN5pY
         mSmA==
X-Forwarded-Encrypted: i=1; AJvYcCWAKYBVFy3I8RvfBS8cvU+gSpUOtvA34z421Faj6BRQXEnUHl8W2qyMM4LYpX0+1ThascESehKawPPG@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ+k3JO5Ffl9sVQL0Uorlp4i7jbqCIh0vXo4W0p5Da5wEDVEYz
	bPc1bPH4y5I2GH+wZC3WTbALsFYUpXj4LrAvCD+MP1P3HqAJy364AFjD2a4RKCJgHeVeP3nLVxi
	xgiu+jGB8rEAH4vNsMQ2Ux9ws1COH9MmnimpDUfNpIQ==
X-Gm-Gg: ASbGncts4iCH7N5R07L1Loo9HZRUu70GwHIO/L3J+6pfsN0HdDkOHuKlJ5ndle6DDH+
	VNXR8Beav2jgvzpGhZmQOnctUhrrZZ1XpG7MEgY+sl3ZTz0Zh0TfxUi7XiD6FtMmVgr6bF26Xy9
	vIF2dK4Wjx0ps1Kn9wpm6tedgfRc6RXKQb5lIjkjqRInGFdoji4rszSlOpp7CfiZYuC/+wAw04A
	CmsTbbunD+wUWNKzQA5P45VS6I7+lmgmPpX8OW6AxdocGEAzvgHEBeAwYSw4VWborEqd4wcDt+h
	MUF0TVI=
X-Google-Smtp-Source: AGHT+IF1n0wZVljtgQdO4YjkTkuDA16K7j3EGrt+LavVV05cNjZjVMw0mRnQJqWQrvbyjkw61l+wH9wnd6eTRWsTKWg=
X-Received: by 2002:a17:902:c40d:b0:251:a3b3:1580 with SMTP id
 d9443c01a7336-25d24cac4eemr35190575ad.6.1757676768437; Fri, 12 Sep 2025
 04:32:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 12 Sep 2025 17:02:36 +0530
X-Gm-Features: AS18NWCRkwK2BEtW0uxWjqehT8uEFjWUmULflZWeqoftij31KvQE0_RmSXQs-jg
Message-ID: <CA+G9fYvQekqNdZpOeibBf0DZNjqR+ZGHRw1yHq6uh0OROZ9sRw@mail.gmail.com>
Subject: next-20250912: riscv: s390: mm/kasan/shadow.c 'kasan_populate_vmalloc_pte'
 pgtable.h:247:41: error: statement with no effect [-Werror=unused-value]
To: kasan-dev <kasan-dev@googlegroups.com>, linux-mm <linux-mm@kvack.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>, linux-s390@vger.kernel.org, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The following build warnings / errors noticed on the riscv and s390
with allyesconfig build on the Linux next-20250912 tag.

Regression Analysis:
- New regression? yes
- Reproducibility? yes

Build regression: next-20250912 mm/kasan/shadow.c
'kasan_populate_vmalloc_pte' pgtable.h error statement with no effect
[-Werror=unused-value]

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

$ git log --oneline next-20250911..next-20250912 --  mm/kasan/shadow.c
  aed53ec0b797a mm: introduce local state for lazy_mmu sections
  307f2dc9b308e kasan: introduce ARCH_DEFER_KASAN and unify static key
across modes

## Test log
In file included from include/linux/kasan.h:37,
                 from mm/kasan/shadow.c:14:
mm/kasan/shadow.c: In function 'kasan_populate_vmalloc_pte':
include/linux/pgtable.h:247:41: error: statement with no effect
[-Werror=unused-value]
  247 | #define arch_enter_lazy_mmu_mode()      (LAZY_MMU_DEFAULT)
      |                                         ^
mm/kasan/shadow.c:322:9: note: in expansion of macro 'arch_enter_lazy_mmu_mode'
  322 |         arch_enter_lazy_mmu_mode();
      |         ^~~~~~~~~~~~~~~~~~~~~~~~
mm/kasan/shadow.c: In function 'kasan_depopulate_vmalloc_pte':
include/linux/pgtable.h:247:41: error: statement with no effect
[-Werror=unused-value]
  247 | #define arch_enter_lazy_mmu_mode()      (LAZY_MMU_DEFAULT)
      |                                         ^
mm/kasan/shadow.c:497:9: note: in expansion of macro 'arch_enter_lazy_mmu_mode'
  497 |         arch_enter_lazy_mmu_mode();
      |         ^~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

## Source
* Kernel version: 6.17.0-rc5
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git describe: 6.17.0-rc5-next-20250912
* Git commit: 590b221ed4256fd6c34d3dea77aa5bd6e741bbc1
* Architectures: riscv, s390
* Toolchains: gcc (Debian 13.3.0-16) 13.3.0
* Kconfigs: allyesconfig

## Build
* Build log: https://qa-reports.linaro.org/api/testruns/29863344/log_file/
* Build details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250912/log-parser-build-gcc/gcc-compiler-include_linux_pgtable_h-error-statement-with-no-effect/
* Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/32aTGVWBLzkF7PsIq9FBtLK3T4W
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/32aTGVWBLzkF7PsIq9FBtLK3T4W/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/32aTGVWBLzkF7PsIq9FBtLK3T4W/config

## Steps to reproduce
 $ tuxmake --runtime podman --target-arch riscv --toolchain gcc-13
--kconfig allyesconfig


--
Linaro LKFT
