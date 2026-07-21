Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC8E2FB97D;
	Tue, 21 Jul 2026 08:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784621873; cv=none; b=ob0Stmd0x47dR9Be8LsZDkmj0NMKTPkUZbC1+bgbZr9GQ3aNJQ72HSKePVv/e4ep3hq8xBmkCZr/UY9P1azV9Dge8Q3tgf0utUNpO0FeqmXqaNKS68nYRs+f5CHfODc6Tzh2OwdapzK5adTRijJQg8yYng5xLk6mZNa4eC7Q05c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784621873; c=relaxed/simple;
	bh=Un4kruJR9OSZ5yVJVOk6XAfzBtg4S1W3/ssotgwdLao=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YvbU1Id+tS+oU896G7h/j0HUYUBt37Kn8YFDwSmOKwccOeSwDObzTRYI8HsAUSHK4f8v/YS/D9VAiMcjLQv+S3/6rvyI8bKQL98WpFUyjLjU92ukOTlYHVla+e2Uf5x+xmJcpJ8yPlGXRYc8Qc411yj6OukRnqFyI/i8/yKH6iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzjjESdF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzjjESdF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7485D1F000E9;
	Tue, 21 Jul 2026 08:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784621872;
	bh=T6g9AHg6Msysl37eYnjnLtQmEqUs+OTtZKGs9WFjvSk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=gzjjESdF8CyzkjGgzLW39bNILuphzcta3sLi1URSjyAFzJLipC3UmTrXu3jFFA61P
	 pi0PV5sSxroT5MC4vSB4irmB8zkSTQpTKtCfEXUbyhmwF4wWaIQ7lbNCZq0H7DmKFK
	 8I7OxSO8hwMcqfwnwS7791wWvgudq6KYGJc2fT4Fg1b9+hIgTc7vYx2BwdLm81gs4i
	 wUS79qiWoSovsixtK4st1zKQHQc+AVAWsjP8+JuFDiWzJmzXtUEBmK6h+qeN8XDX1T
	 q37KCU+p9yvcznsgWiTAyqiGmNVH8Q7lJHO4++M0Slhqh7kAciZtfiGRWhaqAlyvHz
	 9t2nZgwHDG8hg==
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
In-Reply-To: <CA+=Fv5Sd5+-K3-MOiEc2N8z_5CoLQPVPUwjiugSj3u8cBWJXXQ@mail.gmail.com>
References: <20260707181957.433213175@kernel.org>
 <CA+=Fv5TDNH8+JAojV9_W36kUkEE68uiA00FQ7i0vJunebqs1sA@mail.gmail.com>
 <87wluplb6k.ffs@fw13>
 <CA+=Fv5Sd5+-K3-MOiEc2N8z_5CoLQPVPUwjiugSj3u8cBWJXXQ@mail.gmail.com>
Date: Tue, 21 Jul 2026 10:17:49 +0200
Message-ID: <87ecgwlpsi.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Magnus!

On Tue, Jul 21 2026 at 00:01, Magnus Lindholm wrote:
> On Mon, Jul 20, 2026 at 9:21=E2=80=AFPM Thomas Gleixner <tglx@kernel.org>=
 wrote:
>> If you want to base your stuff on that for 7.3, I can add a tag which
>> makes it immutable so it can be pulled into the alpha tree.
>
> Yes, please. There is still some ongoing testing/review of my Alpha
> GENERIC_ENTRY series, but assuming it is ready in time for the 7.3 merge
> window, an immutable tag would be very helpful.

Here you go:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-entry-for=
-arch-07-21-26

Thanks,

        tglx
