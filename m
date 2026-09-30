Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AEC4C9DFD;
	Wed, 30 Sep 2026 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781237; cv=none; b=VQOJk5sPXFV6nC/fEvZTyMviLws1Z2E3URY8mU9ufl9aT6kVSzpWRv94XpfVejoMUsgNKQaGPCQqyIYZYYHjWzO60A+tMACN8KWuatzK1dgc3ZXrtHxNmR7puG/CJIONR2XbS47EjcUmhgWf3sBEpTDYynPYXaq3SnPti1L2xPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781237; c=relaxed/simple;
	bh=hIZ8w5BRtWK9k+pdO+taZIGlaFDD5KANeuDVg/5jR7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VanJnv45PfWXoqzhmqKkeN2YZo2CHJDD7wbMdPwDacqpKbnf3K4fFjFlMEqTg4as8DC1vhNjooGvtH4waH4gOE1YGES/2FVl845gq2tpTO6O74P0usNDhZTeoHzKA8pGhmAAgLCTVZ4x3N0xAj6mn6ffOlo6+IqR3ptkPO/1Pk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n05xolRq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n05xolRq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD9E1F00893;
	Wed, 30 Sep 2026 15:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790781227;
	bh=VjvLVAMdH25Pwcx27KXLJsLgwjves/K/FG5W879yHtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n05xolRqMZoeGMX1Ra4yjBtIDnmfnQ1LRl61P06RLuxE0uOOHM/URSrWqCi1e5N5n
	 +mdD4PMTU1Q5epP+tXpj2DjPMhXSXpLaFHOJqibdDNkpBWWZ/nVCo2zgFbkYaLSUF1
	 YufuCIwyVjzc1U2iSBQhPuWlPi1tqYXi0imKd0lPbYcF2S28XjmlPiWUlpR8etfQvF
	 ahR1ytm89zid5O4hkJLCUT8HepSgXHEJCFv3ViscDLZ4eEWA5fb406Hz9q21Z7AgLj
	 QKh8gF/YA+kzVc4c2H/gw4DLcW6PckFQ+eVhgrUAY04S9NR7ZD3xsEA7stQCEkG7oz
	 yjSHW/SJMBLDg==
Date: Wed, 30 Sep 2026 17:13:37 +0200
From: Nathan Chancellor <nathan@kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
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
Message-ID: <20260930151337.GD3142230@ax162>
References: <CAKwvOdmuvn0LZkYEsH84hnOGTYhTtzuWs3wMARtWdTeL6dD9sA@mail.gmail.com>
 <CAKwvOdnxKVpn=nAFaqP+9PTx4PqgHsUVWv6e60Pcr29W_eZrpQ@mail.gmail.com>
 <CAKwvOdmNZL3eFvV3v77GXDzL+XLgz+BT9TA=my0yTnbsHqVeSg@mail.gmail.com>
 <areYMjNcaqe86ds4@zx2c4.com>
 <9d1c338b-368f-4ea2-a12e-c28d49adff5e@kernel.org>
 <are6s5e6On3hpD3M@zx2c4.com>
 <CAKwvOd=BrMfFT88jsvBPhh383qqk5G+J07CsofNu0MVkziyhCg@mail.gmail.com>
 <20260930133813.GA3142230@ax162>
 <ar0a4b9CjL2YHCkY@zx2c4.com>
 <ar0gTS71qxnx9AkW@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar0gTS71qxnx9AkW@zx2c4.com>

On Wed, Sep 30, 2026 at 04:44:29PM +0200, Jason A. Donenfeld wrote:
> Nathan, would this be okay with you?
> https://git.zx2c4.com/linux-rng/commit/?id=d216701724b7d8209ff42150658ad5c712bdb503

Can you stick

  Cc: stable@vger.kernel.org # v6.12+
  Closes: https://github.com/ClangBuiltLinux/linux/issues/2183

on that? Otherwise, looks good to me, that's basically what I had for my
v3 locally.

-- 
Cheers,
Nathan
