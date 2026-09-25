Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D3F2F28EA
	for <linux-s390@vger.kernel.org>; Fri, 25 Sep 2026 21:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790373417; cv=none; b=QCW8pTrSWtjq7ZfoT72dwEY3MqAsBg+MOK3iUoOSR9NcGKIHQH46dCH/fRtENRcBOcTRabcMCwhOWJm/JI6ysb9yEVGjcBkSAigectI+FuLIdjivAHG5jeYo9/3RE6zYjjGvPo/s52A1Fi0eUO21R9L1YPC2qznjmZG/ZzsiJdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790373417; c=relaxed/simple;
	bh=By7TQEVFy9jS0FLkR8hBUxnCPy3PqnB3fC+8svtGUwA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QhWHByIEpbjjKaMwJ1MiTH/Lt2wy1nSAYQE1fW1pr4rbI5yumu5m3n1fGItf7xI7WWd5h1KVwKny0t9sehtcLHmmiXFfRKU3JH8nvUigCKZKL9EuEs3XAitiE6NZJjbpMOpGKV5sSkTafCZhY7Sqa2yRaLNc+GyySxEk349eBh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKNRGb7r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKNRGb7r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CF21F000FF;
	Fri, 25 Sep 2026 21:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790373414;
	bh=v+OHy4dWcMPYgXDAXZPdiRSt117YGnHEF/pwNti0x58=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PKNRGb7r6rXbTM8lmNgmr+oV8zsTfLfa+L51CwsdpYpPqQ66bfWpoKBCaAmZZ17SY
	 mLjEYk3Bbg0BuO5i72qUG3vtzqRg95bx1QNz1gYx28/AVefMM1uNoT+KLVvnBN9QA7
	 IwKuWOvRc1PpMCeSLHR8+/p+6K+DEqCPR/QaR1teGsozKtelykA3kGkMgRLLUkGAs6
	 TkCx3DEvC7dWwvhM6+dt3jD7vIOImmIlPPVrQJ5GN8gj/7o19DVFDe8tGSfd9sTaVx
	 VATdm3qsgfY3Kr9gdMeNb+4pF9wFCmWuS76Je6i+vr8kgN1RhxfPuTMehbFA8R6rLy
	 mk38VaTyj1aNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] random: vDSO: Avoid call to memset() when zeroing
 reserved in __cvdso_getrandom_data()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Chancellor" <nathan@kernel.org>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260925-vdso-getrandom-avoid-memset-llvm-24-v2-1-ce640f872393@kernel.org>
References: <20260925-vdso-getrandom-avoid-memset-llvm-24-v2-1-ce640f872393@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 21:56:53 +0000
Message-Id: <20260925215653.B4CF21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> After a recent change in LLVM [1], builds with the random vDSO
> implementation, such as PowerPC and RISC-V, fail when checking the vDSO:
>=20
>   arch/powerpc/kernel/vdso/vdso32.so.dbg: dynamic relocations are not sup=
ported
>   arch/riscv/kernel/vdso/vdso.so.dbg: dynamic relocations are not support=
ed
>=20
> memset() is now generated when zeroing params->reserved for some builds
> because LLVM has an optimization (now run in more instances) that can
> recognize at compile time when it is assigning a static value to a
> contiguous area of memory and turn that into a call to memset(). Both
> clang and GCC assume memset() is always available [2].
>=20
> clang provides a builtin, __builtin_memset_inline [3][4], that can be
> used to ensure an external function call is not generated when zeroing
> this memory. Use it when it is available.
> [ ... ]
> Link: https://gcc.gnu.org/git/?p=3Dgcc.git;a=3Dcommit;h=3D1ff6d9f7428b066=
8cd8ab0b3e3ab94f1d733124d [5]
> Link: https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html#index-finl=
ine-stringops [6]
> Suggested-by: "Jason A. Donenfeld" <Jason@zx2c4.com>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-vdso-getra=
ndom-avoid-memset-llvm-24-v2-1-ce640f872393@kernel.org?part=3D1

