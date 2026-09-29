Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D035335B6;
	Tue, 29 Sep 2026 16:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790701191; cv=none; b=gWoL6CHAHwiNN2YM4JwtnGh+Y9BdME5tbEZVxr4aZUd24C0u9wtZ4qWrRVeQexnk2xPraAtmLuhI5n7MMkUZPxEeyarlsLF88i9kBGgmHwBXSGqnji3TFUfgpC/mjsbGUw6tZQgmAi5fFD3K3fu89V4NgBLhmSzaMMggc5HZfig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790701191; c=relaxed/simple;
	bh=Kqj6KV4ty0Cf9LzChQtzVbl7VP0gUL4ZFCNlHxFRHsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYtPo0di0BpMu6hDxqmUHRFtUvdfNlJ830ZNdumBNdd7s0bnq3ZVevATNYRF3+MyqjwrKqmd5XM2pXVne32y0KlbzerUWGtHWCabxSL0+AlL3h4TpuFgczxDWoKiucUvaZJ5QTvJs3FQyv2nQ4hkH2RCUPrNYgm153IZCpBQZGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjePm7x0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjePm7x0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153C71F000FF;
	Tue, 29 Sep 2026 16:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790701190;
	bh=MGBWHHaEJganj8D1yagMHRlcdsNEyTtM3iC7GV8hUXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SjePm7x02Lah5vOELf9ce4YUO5z/8quB47KG1ZoIMK72aUNVrPrCdr0c0MhVEUCct
	 e/pjkzplRRlc+iDw8myI00JnCkhOCgIGqKVjqAEmF68e1bsSBFWkNDo/dnGaHUUbmN
	 gGTfswdR99FIW24ZhkxFSWQUM+NnT0oWNEgj5t/DAU3kIqebd4giVteYXHP1sJE9R7
	 LMnUflkro8TfjhlCllhq8FQKM35R/YNnamS2pvqYaCoDITHJ1zkhAY1dQR0e4Sb4q1
	 loj77pP8vyLLK7xfd/8pczOKmPjnIREFvATiAc8+2ruPOGvW7PPEKs8kujnvVWWvGM
	 j5+6rTn2iVdcw==
Date: Tue, 29 Sep 2026 18:59:39 +0200
From: Nathan Chancellor <nathan@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v2] random: vDSO: Avoid call to memset() when zeroing
 reserved in __cvdso_getrandom_data()
Message-ID: <20260929165939.GA1890629@ax162>
References: <20260925-vdso-getrandom-avoid-memset-llvm-24-v2-1-ce640f872393@kernel.org>
 <87zex4ic68.fsf@linux-m68k.org>
 <20260926121927.GA1486962@ax162>
 <are7cfMIHZZn6jLz@zx2c4.com>
 <20260927080225.37534e7c@pumpkin>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927080225.37534e7c@pumpkin>

On Sun, Sep 27, 2026 at 08:02:25AM +0100, David Laight wrote:
> On Sat, 26 Sep 2026 14:32:49 +0200
> "Jason A. Donenfeld" <Jason@zx2c4.com> wrote:
> > Do we even need to return a value at all? Might as well just make the
> > function two lines:
> > 
> > +       for (char *d = dst; size--;)
> > +               *d++ = value;
> 
> Wouldn't it be better to add a barrier() or similar in there to
> stop the compiler playing unwanted games>

Wouldn't that just result in the same code generation issue that Jason
pointed out on my v1?

  https://lore.kernel.org/aquyVkdYceiWdckX@zx2c4.com/

Maybe that doesn't matter because modern compilers have better options?

-- 
Cheers,
Nathan
