Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378053161A3;
	Thu,  9 Jul 2026 16:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783614229; cv=none; b=Vslo70LCHAMSKIy4hTivTv4gkU4x4EtL3lpznDOtPWzm/5Hh/ftw2bM80nyRKsX0DTgOAzmvS61K2ohQgeFWSRY7VEV0xKPWvf9eMzr5ui37ezhYF3ZEYRAMeE7DiksnufM5U3+MIoDbl1pdN/uOcXG4kx8co+JCNm/5798gAoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783614229; c=relaxed/simple;
	bh=PYgbxg9gRqFkI+16o1eOO4t2hXv+bYRFkiZ971QQZko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tn34AiouGwwj9hPyUxs/zP5ShJmj/EMRfCsf7YAFxY9g+Cf1Sslrl29Bnj/Lxyj3wyzMlvcDLkuW5hO/SHvw6JqXRvHo6xLt8h12NsC4yX2r1B8JJGf7mH/QbS5NrJCaz5A9XoOHhmkW3WN1MRqOtv2dWuSPMCx029TkaJS6488=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEsGFvG0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEsGFvG0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F271F00A3A;
	Thu,  9 Jul 2026 16:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783614228;
	bh=PVNPrFU1PGB9ZkQlUfz3ePnrtlBWmUW1vci7gbMc020=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dEsGFvG0entc+CRLpmVOaUBCJG4D03DxA7ZPHMA+0bz+ArzFZ4oZ25h3XsZAVyxRR
	 x10/LoE7lElTzHD06XWpE2m6rYMtKRUGebUhQapIBfB+ep4fG37Ng0RaVsx6GdmjM4
	 W83GkVnhwTOjct2PRlsvXAgfF8WsuxadhgjUrZKIFxbiAgM07wgLkRHLtXBID76WXL
	 vXpw2i5GZ2AEQYDFtIGxLdWwAY7AsLhILvFuoodFrluXUPHF4msNedMhyKYrHXoB8T
	 JJj34DTu2/8Sq2sDLaSW1Xi2u/2ZNgMk1vZ51THvkxDDB/2K6ZsmwZ7UkwuT1KfO4D
	 Hq6xN5eyBwNEw==
Date: Thu, 9 Jul 2026 09:23:47 -0700
From: Kees Cook <kees@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Huacai Chen <chenhuacai@kernel.org>,
	loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
	x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Guo Ren <guoren@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Helge Deller <deller@gmx.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Richard Weinberger <richard@nod.at>,
	Chris Zankel <chris@zankel.net>,
	linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
	linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>,
	Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>,
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
	linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [patch 02/18] randomize_kstack: Provide
 add_random_kstack_offset_irqsoff()
Message-ID: <202607090922.4ECAE32C07@keescook>
References: <20260707181957.433213175@kernel.org>
 <20260707190253.768842729@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707190253.768842729@kernel.org>

On Tue, Jul 07, 2026 at 09:06:02PM +0200, Thomas Gleixner wrote:
> add_random_kstack_offset() uses get/put_cpu_var() which is pointless
> overhead when it is invoked from low level entry code with interrupts
> disabled.
> 
> Provide a irqsoff() variant, which avoids that.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>

Seems good. I don't think macro'izing the interior is worth it since
both cases are very short, with only the lockdep and raw bits changed.

Reviewed-by: Kees Cook <kees@kernel.org>

-Kees

-- 
Kees Cook
