Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D25717C203;
	Sun, 12 Jul 2026 21:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783891517; cv=none; b=qhbP0CcdNIHnGP5Bq9iYVNALSKgmQYvvv0AvDBewUymrWVOkhJG+9DaWq73FBvzrwie0cDNgbn942W/QRL3KihVw72n4UFUHjELvPbw/wruDxIC5Z4hLiOCcxKwawd75r4MqK1d+p/pz8a+zn9TAUl8afmPmzjThdu5crMS38Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783891517; c=relaxed/simple;
	bh=hP7lte9xARTw3iph1JAkc0pXwM3iIlnPbn4ZU6WTfaM=;
	h=Date:Message-ID:From:To:Cc:Subject; b=RX3B7k2zBTj962d2AVAaCPi38Z0qdDs2kWp23a8dV10yWTYGJQxd63ovaXP7qfJP0FvvK1NNy72VQfqHAN38Z7/DoABiHEH/oRdY6SCtkhhobGT4nzFVw5zy9nb1VKRvD0zMpTOyF17x3PokIUx7pdBW3g968xKs/16koAeQ3Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUihrXXV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUihrXXV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767DE1F000E9;
	Sun, 12 Jul 2026 21:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783891516;
	bh=lwBg36/x+UtK8CJqmuUc9WLztI2cbur8/uNJ6nqvy3A=;
	h=Date:From:To:Cc:Subject;
	b=iUihrXXVEGq2SYK9UQGaK/ixJHkvadpYQ4DOH4S/nAejgcD/b7GUWwBZ5jduOfGTp
	 i2GmHCBrjqnQqhqfy4uM2Nm1ZqAGGaYxEbfVavR0WHrnlVlBrqHw8lCXBF+I+H4UYL
	 rp//e3HRjshpQ+bNYw6Guvww3ARF7O7HJsAP1v+ktF8f16Gw0ufg7Kv+IvYnQqmnDd
	 nOouURl3ey8GIdW1RylaSmhjzQZmjZJj0NnC6v8qojx/WotJKtYEUPvgrJhaLKZf29
	 MvSWr2X6GY8DZQ/V7/XPuTag3oQfy5KgCPYjv4bZ3cYiQUKKlTvDFxz1jtaHpcPEp9
	 9manpI38rMBQQ==
Date: Sun, 12 Jul 2026 23:25:12 +0200
Message-ID: <20260712134433.549076055@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev,
 Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org,
 Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org,
 x86@kernel.org,
 Mark Rutland <mark.rutland@arm.com>,
 Jinjie Ruan <ruanjinjie@huawei.com>,
 Magnus Lindholm <linmag7@gmail.com>,
 "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Radu Rendec <radu@rendec.net>
Subject: [patch 0/4] entry: Rework syscall skip logic
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

This are the reworked leftovers of the larger entry logic rework series,
which can be found here:

  https://lore.kernel.org/lkml/20260707181957.433213175@kernel.org

The undisputed part of the series has been merged into:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/entry

After a fruitless discussion about the most resilent approach, I decided to
give up wasting my time and reworked the series so it caters to the desire
of powerpc and s390 to be special.

That results in almost identical behavior except for the case where
tracing/probe/BPF sets the syscall number to -1 (or any other out of range
value) and also sets the syscall return value to something different than
-ENOSYS.

PowerPC and S390 will overwrite that value with -ENOSYS.

Loongarch, RISC-V and x86 will not overwrite it because those architectures
preset the return value to -ENOSYS and skip out of range syscalls
completely. Loongarch and RISC-V always did the out of range skip. X86
gained that in the already applied rework, which means that the final patch
which splits the skip decision from the syscall number does not longer
change x86 behavior for the above case.

Documentation is also updated and describes the two implementation variants
and the subtle difference in the resulting behavior.

The series applies on top of:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/entry

and is also available from git:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry/rework

Thanks,

	tglx
---
 Documentation/core-api/entry.rst |   45 +++++++++++++++++++++++-------
 arch/loongarch/kernel/syscall.c  |   14 ++++-----
 arch/powerpc/kernel/syscall.c    |    3 +-
 arch/riscv/kernel/traps.c        |   11 +++----
 arch/s390/kernel/syscall.c       |    7 +++-
 arch/x86/entry/syscall_32.c      |   25 ++++++++--------
 arch/x86/entry/syscall_64.c      |   12 ++++----
 include/linux/entry-common.h     |   58 +++++++++++++++++----------------------
 kernel/entry/syscall-common.c    |   19 ++++++++----
 9 files changed, 110 insertions(+), 84 deletions(-)

