Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41F62FD69E;
	Mon, 20 Jul 2026 19:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784575271; cv=none; b=XbMCTqgDla/IG1c0w9gd+sICX07wyjqwWgCh3fZ1a6+u0NBdpC4YhiqqvXBjdpHbwzUNARL/sC0VcOrHXMorlsQBWN4+Gavm0E8S1mfG1kCSVVfaXNADqR1NDXmpzoInO+CR+iNqongpltSoz1saPLV5T3M6A7iBPBxUv45hoXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784575271; c=relaxed/simple;
	bh=H/vKTqmynWJ9xGLYIa8zO75nqGaobj6R+UxbFnLBdNk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ns/WBYXQtUdD3S2Cjb/A8hRI1LyhSq8EmQ9ue/mUebmcagp5v8VmfeZZWvfJKWm8zoTrt9aTo9Xaums8xR+3rdjmeuXeknojAl1/Xh2zJTc0Xy5RdbXktX/MgoEweD4OtLRh9bdPqzsA9FzVYhdC+JWUb+4ZQwYzjknQO1fnOJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Spav0GWz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Spav0GWz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC12B1F000E9;
	Mon, 20 Jul 2026 19:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784575270;
	bh=y4vTZRCmYUoacTgRQeb9iD10u8BLXmQ5njXvIgguyco=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Spav0GWz3rWmeiOvTkSHmoLaFmA0dsmghrTMMUGIy7BsnbqtE0r1vEIJpGCtqeWB+
	 BpTJQ6xzB/KOaDAAkoTPfDvyF002TmAYBtSyKK5uExFq/Cj1mLr43Z33qJ2sRMi9Nf
	 nJuZqLg2J7TvcdvdFpFOL3PuoTONb0yf3DbORivGivTO7zCY0H72Bu+OkktKpqh03L
	 Vksh67h0wy7gmPYEI4mwGb9sleMrzw8Jsb1sLuHLmScVy2tv/f+VR08LYTxzvzqe4C
	 b/ZkM/7+AGeKxhezpkSh009TVoxiBEuZvcET+KD3PE+3fxGAVYAS/3R9Y8DzfgWlkp
	 U2Lg+Wsg/dkOQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Shrikanth
 Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Kees Cook
 <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, Sven Schnelle
 <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, Andy
 Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Russell King
 <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Guo
 Ren <guoren@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Helge Deller <deller@gmx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger
 <richard@nod.at>, Chris Zankel <chris@zankel.net>,
 linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org, Arnd Bergmann
 <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Will Deacon
 <will@kernel.org>, Brian Cain <bcain@kernel.org>, Michal Simek
 <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
 linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, Michal =?utf-8?Q?Such=C3=A1nek?=
 <msuchanek@suse.de>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [patch 00/18] entry: Consolidate and rework syscall entry handling
In-Reply-To: <CA+=Fv5TDNH8+JAojV9_W36kUkEE68uiA00FQ7i0vJunebqs1sA@mail.gmail.com>
References: <20260707181957.433213175@kernel.org>
 <CA+=Fv5TDNH8+JAojV9_W36kUkEE68uiA00FQ7i0vJunebqs1sA@mail.gmail.com>
Date: Mon, 20 Jul 2026 21:21:07 +0200
Message-ID: <87wluplb6k.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Magnus!

On Sun, Jul 19 2026 at 13:25, Magnus Lindholm wrote:
> One Alpha-specific wrinkle I hit while rebasing the GENERIC_ENTRY patch is
> that Alpha cannot unconditionally pre-seed the normal -ENOSYS return state
> before calling into the generic entry code: syscall_set_return_value() also
> updates r19/a3, which is still syscall argument 4 on the normal entry path.
> Doing that too early broke early userspace mmap() during boot.

Similar to what Peter and me suggested in the related discussion
vs. s390 which has a similar issue, you can just have a dedicated
syscall_return member in your pt_regs struct, which is preset to -ENOSYS
and operate on that. You have an unused padding entry there which means
it won't even change the size.

> Are you planning to send a v2 with the seccomp recheck fix and any other
> review fixups folded in? Is the intention to route this upstream
> during the next merge window?

You were on CC for the V2, no?

The whole pile including Jinjie's seccomp bypass fix is in

    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/entry

and is targeted for the 7.3 merge window.

If you want to base your stuff on that for 7.3, I can add a tag which
makes it immutable so it can be pulled into the alpha tree.

Thanks,

        tglx

