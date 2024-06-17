Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81625DDA6;
	Mon, 17 Jun 2024 23:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718667108; cv=none; b=lnJfwr9QLN1GP4novoYiyBhUbD/fhYScuzGyt9q05bXJrEW4ad0ZINwXysL1NZbUBfAitKJ1j2sonfu3QhAdLN31LE4QAAqVyzEcPc1X47LFNUDSRxnBZFEnwsZ/ScXUXk/NBWTyWiAkXb7KMY927kYM13+0SupxohL5hWyMImo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718667108; c=relaxed/simple;
	bh=4KZkD3adnWFBE0CL7l4ZcutJUzuc0oVMJV2Ijc+6+ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gh5NMw9rOqmj8ec66B2Te1NcnYvLAe9bATv1MZVdbKs7KKizxLD72AKWxV+M6bCXAOW+TytSiczMr5JC9g5fl8HJoEi5h5nm/PUmxBnALOiOyB2r3QKqR8/rR14DefZ2gJ18eJUsgeDFhF//DP+bbkubIERuWtTk6Gng0c65UWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g51AgzHV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g51AgzHV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2906C2BD10;
	Mon, 17 Jun 2024 23:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718667108;
	bh=4KZkD3adnWFBE0CL7l4ZcutJUzuc0oVMJV2Ijc+6+ts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g51AgzHVXFVuX6oGkjN69HCIu9soTKyZLJzm4ofCyzigdOGRQanOnL35s24Aol1FH
	 zpXTOqnhgt4mFbc/KwrPpE+mGpwzhyHw1gfihkTb9T/Cbs1ZcMjMtuZdeLeOVGUuf8
	 hdNaotoUTLyCsSDOOBRAdewJvF2/lMiZreACRkKtZIUm8wZsXqNV7oregbbc2ZmEtZ
	 +mpfb3S2Xrny33zu+Cq4Fq+QrYuNtGhrBvgkYu2D+OPJa2kVNYFlhdJVCtJ4m+Fza9
	 vu3/y88gXe3zIfSQACIyaGkvQTm3p3CpKSR8tOFbXiMtuOxApbr4s2SBry50aiHwFi
	 NBWsWZdhpJc4Q==
Date: Mon, 17 Jun 2024 16:31:47 -0700
From: Kees Cook <kees@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Yuntao Liu <liuyuntao12@huawei.com>, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-hardening@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
	gor@linux.ibm.com, Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Leonardo Bras <leobras@redhat.com>, Mark Brown <broonie@kernel.org>,
	imbrenda@linux.ibm.com, pawan.kumar.gupta@linux.intel.com
Subject: Re: [PATCH] remove AND operation in choose_random_kstack_offset()
Message-ID: <202406171618.A92D064@keescook>
References: <20240617133721.377540-1-liuyuntao12@huawei.com>
 <ZnBbr2CAqBGDe2aN@J2N7QTR9R3>
 <202406171122.B5FDA6A@keescook>
 <d0959336-4430-4062-b909-54d553238468@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0959336-4430-4062-b909-54d553238468@app.fastmail.com>

On Mon, Jun 17, 2024 at 10:33:08PM +0200, Arnd Bergmann wrote:
> On Mon, Jun 17, 2024, at 20:22, Kees Cook wrote:
> > On Mon, Jun 17, 2024 at 04:52:15PM +0100, Mark Rutland wrote:
> >> On Mon, Jun 17, 2024 at 01:37:21PM +0000, Yuntao Liu wrote:
> >> > Since the offset would be bitwise ANDed with 0x3FF in
> >> > add_random_kstack_offset(), so just remove AND operation here.
> >> > 
> >> > Signed-off-by: Yuntao Liu <liuyuntao12@huawei.com>
> >> 
> >> The comments in arm64 and x86 say that they're deliberately capping the
> >> offset at fewer bits than the result of KSTACK_OFFSET_MAX() masking the
> >> value with 0x3FF.
> >> 
> >> Maybe it's ok to expand that, but if that's the case the commit message
> >> needs to explain why it's safe add extra bits (2 on arm64, 3 on s39 and
> >> x86), and those comments need to be updated accordingly.
> >> 
> >> As-is, I do not think this patch is ok.
> >
> > Yeah, I agree: the truncation is intentional and tuned to the
> > architecture.
> 
> It may be intentional, but it's clearly nonsense: there is nothing
> inherent to the architecture that means we have can go only 256
> bytes instead of 512 bytes into the 16KB available stack space.
> 
> As far as I can tell, any code just gets bloated to the point
> where it fills up the available memory, regardless of how
> much you give it. I'm sure one can find code paths today that
> exceed the 16KB, so there is no point pretending that 15.75KB
> is somehow safe to use while 15.00KB is not.
> 
> I'm definitely in favor of making this less architecture
> specific, we just need to pick a good value, and we may well
> end up deciding to use less than the default 1KB. We can also
> go the opposite way and make the limit 4KB but then increase
> the default stack size to 20KB for kernels that enable
> randomization.

I'm all for more entropy, but arch maintainers had wanted specific
control over this value, and given the years of bikeshedding over the
feature, I'm not inclined dive back into that debate, but okay.

FWIW, the here's the actual entropy (due to stack alignment enforced by
the compiler for the given arch ABI).

standard cap is 0x3FF (10 bits).

arm64: capped at 0x1FF (9 bits), 5 bits effective
powerpc: uncapped (10 bits), 6 or 7 bits effective
riscv: uncapped (10 bits), 6 bits effective
x86: capped at 0xFF (8 bits), 5 (x86_64) or 6 (ia32) bits effective
s390: capped at 0xFF (8 bits), undocumented effective entropy

So if x86, arm64, and s390 maintainers are okay with it, we can try
dropping the masks on those architectures. They would gain 2, 1, and 2
bits respectively.

-Kees

-- 
Kees Cook
