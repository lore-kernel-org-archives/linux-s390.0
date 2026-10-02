Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745B8483BFB;
	Fri,  2 Oct 2026 10:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790938668; cv=none; b=kGCd7VUIhVuNYynaqLcBbI44MREo9Vx7ffl24oVdjvZcYS3y/LFYIEsUIyf+2TS2R7JFTmhrqA67KiWsyuMZ5YWziUoZCOQuyiSJmPlmtCI6Y/ZKCkuPnYZwfx1jVrIATg/eHBWni2adOuUWE+OLRQzQyNUJ1sLtFL4VjOtPiZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790938668; c=relaxed/simple;
	bh=R51dg7ziNjc7/URYyrQ8hbJ1FiRW53tsc+2qT9TtDSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FkekjaWfs5hjtUSevl7sPQe4wjnZynR6QUWI1tzVoCsMvvRDp+y6FdOEr2cnIL9QHQYIxmLchHkjcXVvVskfUqO2PfiVDKbVAL90Nw7wTEfYYkXFtMazP0Uu/gV7HOZqfMUVZtmxPfJHCQ9YXpRu6hmXoqeeLXPf1aDuBYOX+LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWofcNL0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWofcNL0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC801F000FF;
	Fri,  2 Oct 2026 10:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790938663;
	bh=XhYZeDORiSI8/JK5prOnI48AZTeR83aeNlRw2yNVr5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aWofcNL0IpfhNz1F+V5tIezxAIC+6gSsXgAkREeV4BVed+0FiauQXMNWVw9LKPLB6
	 ir4DE+mQOj7fAnn9wWN24mGIs2yiLoWuxDgSoIcePHXYebp3Jn+1nUa9x2wySQefzf
	 WQmIi/OFo2WoqQKAzGhoPoMrrzBB5bUlFah8eMf2FJVRJ6H6P9gC/qpBZuRnPjv0y/
	 F5TtGt5oyxTCxCgpw9JS+D+Ugcg53pdmW58E1qfTVRE4UNxCd1Jv8/fulyxe9xvM3n
	 QuSyWTZZF/fLNAxS4cWJJyIBxQRSN/S3tMrqSUHZbQdB27JrxaRUMLy+tg6NqQf98F
	 +C8Ubag62FOcA==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Christophe Leroy <chleroy@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v2] random: vDSO: Avoid call to memset() when zeroing reserved in __cvdso_getrandom_data()
Date: Fri,  2 Oct 2026 12:57:06 +0200
Message-ID: <179093852073.149722.832232613857480812.b4-ty@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925-vdso-getrandom-avoid-memset-llvm-24-v2-1-ce640f872393@kernel.org>
References: <20260925-vdso-getrandom-avoid-memset-llvm-24-v2-1-ce640f872393@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=948; i=chleroy@kernel.org; h=from:subject:message-id; bh=cZWyz0y5XGYe9zKs9PNHSxiUlxW65egvfT4xEgdntpI=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWTt7+OJ/rvq89WD/OHOTgfiuFYb3eV9siQjX6ZB4uV8W fGZTfsNOkpZGMS4GGTFFFmO/+feNaPrS2r+1F36MHNYmUCGMHBxCsBElsQyMkw/0pmesd3U1s2/ +cCt35+i1GxcP3PlXZzn80qx+rxOmQLD/5gj9bZ29RUatWfD9vbt1+NKmTHbS7kya1+avMNCTlt NfgA=
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit


On Fri, 25 Sep 2026 22:46:32 +0100, Nathan Chancellor wrote:
> After a recent change in LLVM [1], builds with the random vDSO
> implementation, such as PowerPC and RISC-V, fail when checking the vDSO:
> 
>   arch/powerpc/kernel/vdso/vdso32.so.dbg: dynamic relocations are not supported
>   arch/riscv/kernel/vdso/vdso.so.dbg: dynamic relocations are not supported
> 
> memset() is now generated when zeroing params->reserved for some builds
> because LLVM has an optimization (now run in more instances) that can
> recognize at compile time when it is assigning a static value to a
> contiguous area of memory and turn that into a call to memset(). Both
> clang and GCC assume memset() is always available [2].
> 
> [...]

Applied, thanks!

[1/1] random: vDSO: Avoid call to memset() when zeroing reserved in __cvdso_getrandom_data()
      (no commit info)

Best regards,
-- 
Christophe Leroy (CS GROUP) <chleroy@kernel.org>
