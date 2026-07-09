Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4F242E8E2;
	Thu,  9 Jul 2026 16:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783614128; cv=none; b=Y5BEaKvyfj9umFm4LQIHUj2Q+C1HHaGaOZiMjaGdkY+h1in51AiLOfZZAwtD1mDTCLnq1PsJq3N+993yD71Mwqrq7lJSFi7EvScvGcfrMPkEFLhwIn4HFl1aMCOIMnfzsu6oDQtVcjM7+YBvC5hZOdnu4xnR3OxIYafkcQPclxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783614128; c=relaxed/simple;
	bh=VI3Ojo7ccWWfCHnU/9oqVcNO820ulcvMp+VbcWTgRSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHunwbQbfxwTT//vRwY1WPAj9TINyxq93S9KS8Hv4UWeVHU/crfjJaceQPtzMIfJaVbzKpSCmJGgsvnetcwsSFzAb4CLjXn/A9xTVfnHl0xPR4XRN3IxCHJ8PZ+usMuBEMg0l5BZW2Bhy5tecgiPpR+DN4aQ8rvYFKFlflQ329o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/Uien6v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/Uien6v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0FB1F000E9;
	Thu,  9 Jul 2026 16:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783614126;
	bh=E3GKiVGCG/M7FltpcGzY43WO5HnNe5q++QmCFGBnpG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S/Uien6vGeymdukHshCIRbD/qQirZnmNv1fkPyrZGO6+K+ckkFdEYSDwlnKFpi2BF
	 tuyJKBhR0dyYdYiHulLx/LgusylN0RPtbaGzeJM/aCdOjZzg650pi7YEBbg+JGqSHR
	 64dXPeQbq2evJa22r52hBC05ICSGISNW2xikw530YpQ+nCbruCjZdneQ5mim5aCUCw
	 Xf0AYTbfJ+wFGM1bNULmUZblGmQ7iYYE8zwgMJIETdC1+LLXgejWycDXueD9QUnxdI
	 F83JV94XXQwp5V/iZ2sAm+8m4as7p5Y/PmHH5g0nCXnFS05/jmhxEmyZJZGFezfdfB
	 UQzRtgW6GQfPA==
Date: Thu, 9 Jul 2026 09:22:06 -0700
From: Kees Cook <kees@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
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
	Michael Ellerman <mpe@ellerman.id.au>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Huacai Chen <chenhuacai@kernel.org>,
	loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
	x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>,
	Brian Cain <bcain@kernel.org>, Michal Simek <monstr@monstr.eu>,
	Dinh Nguyen <dinguyen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
	linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [patch 11/18] seccomp, treewide: Rename and convert
 __secure_computing() to return boolean
Message-ID: <202607090921.ABE4BB4A@keescook>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.230735780@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707190254.230735780@kernel.org>

On Tue, Jul 07, 2026 at 09:06:40PM +0200, Thomas Gleixner wrote:
> From: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> The return value of __secure_computing() currently uses 0 to indicate
> that a system call should be allowed, and -1 to indicate that it should
> be blocked/killed. This 0/-1 pattern is non-intuitive for a security
> check function and makes the control flow at the call sites less readable.

Conceptually, I'm good with this. Just make sure that the
tools/testing/selftests/seccomp/seccomp_bpf tests still passes. :)

-- 
Kees Cook
