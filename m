Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB7B3D88F7;
	Sat, 26 Sep 2026 09:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790416086; cv=none; b=axT9bThcP0gL3FUJ4SjKeUhotD2drSVJ4qnQsV9Z8pCKdaJyhj7P/5/yGQdAavpZ9PTFxUKXyYBssG96JjqVqt3/7+OvykdOz4fBjP+UOiDt55+H/76LyP+/QhUI+ZMhMOmFb84140qdJZPyo2uxYoDjwTF88I1vmdlk4ZiYHbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790416086; c=relaxed/simple;
	bh=KSRclUbiChdvva1viNPPMjblDnBYwYSw9BmIEoDsjIM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LBtGsg9sPCQ8UcQH+ECD29AwBQpOaBgz4cduYxAo9+Bg4WDbRcFvKrTWxJb2VQR755HFQmxeaJcvcGL2bMzrddZlNFhFNJep6DJLsOYktaACvIVvjJrVGYj3maoyJilUmb1LZQHCB3d3WJAd53CiAmj4Phul8jr9fGySe9O1zMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by mail-out.m-online.net (Postfix) with ESMTP id 4hsMx95lHWz1sPSD;
	Sat, 26 Sep 2026 11:39:57 +0200 (CEST)
Received: from frontend03.mail.m-online.net (unknown [192.168.6.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4hsMx35nYKz1sPRy;
	Sat, 26 Sep 2026 11:39:51 +0200 (CEST)
Received: from localhost (dynscan3.mnet-online.de [192.168.6.87])
	by mail.m-online.net (Postfix) with ESMTP id 4hsMx319yNz1qqlR;
	Sat, 26 Sep 2026 11:39:51 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.6.182])
 by localhost (dynscan3.mail.m-online.net [192.168.6.87]) (amavis, port 10024)
 with ESMTP id r0-zxGatOHrc; Sat, 26 Sep 2026 11:39:43 +0200 (CEST)
X-Auth-Info: wFe88JiXbDxEAWB88fOER1RGk4p+sTXtzQeYAh7Q9amIwrx952rztx0YkIPQk3RO
Received: from tiger (aftr-82-135-83-101.dynamic.mnet-online.de [82.135.83.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Sat, 26 Sep 2026 11:39:43 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>,  Thomas Gleixner <tglx@kernel.org>,
  Theodore Ts'o <tytso@mit.edu>,  "Jason A. Donenfeld" <Jason@zx2c4.com>,
  Vincenzo Frascino <vincenzo.frascino@arm.com>,  Nick Desaulniers
 <ndesaulniers@google.com>,  Bill Wendling <morbo@google.com>,  Justin
 Stitt <justinstitt@google.com>,  Catalin Marinas
 <catalin.marinas@arm.com>,  Will Deacon <will@kernel.org>,  Mark Rutland
 <mark.rutland@arm.com>,  Huacai Chen <chenhuacai@kernel.org>,  WANG Xuerui
 <kernel@xen0n.name>,  Madhavan Srinivasan <maddy@linux.ibm.com>,  Michael
 Ellerman <mpe@ellerman.id.au>,  Nicholas Piggin <npiggin@gmail.com>,
  "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,  Paul Walmsley
 <pjw@kernel.org>,  Palmer Dabbelt <palmer@dabbelt.com>,  Albert Ou
 <aou@eecs.berkeley.edu>,  Alexandre Ghiti <alex@ghiti.fr>,  Heiko Carstens
 <hca@linux.ibm.com>,  Vasily Gorbik <gor@linux.ibm.com>,  Alexander
 Gordeev <agordeev@linux.ibm.com>,  Christian Borntraeger
 <borntraeger@linux.ibm.com>,  Sven Schnelle <svens@linux.ibm.com>,  Ingo
 Molnar <mingo@redhat.com>,  Borislav Petkov <bp@alien8.de>,  Dave Hansen
 <dave.hansen@linux.intel.com>,  "H. Peter Anvin" <hpa@zytor.com>,
  x86@kernel.org,  linux-arm-kernel@lists.infradead.org,
  linux-kernel@vger.kernel.org,  loongarch@lists.linux.dev,
  linuxppc-dev@lists.ozlabs.org,  linux-riscv@lists.infradead.org,
  linux-s390@vger.kernel.org,  llvm@lists.linux.dev
Subject: Re: [PATCH v2] random: vDSO: Avoid call to memset() when zeroing
 reserved in __cvdso_getrandom_data()
In-Reply-To: <20260925-vdso-getrandom-avoid-memset-llvm-24-v2-1-ce640f872393@kernel.org>
References: <20260925-vdso-getrandom-avoid-memset-llvm-24-v2-1-ce640f872393@kernel.org>
Date: Sat, 26 Sep 2026 11:39:43 +0200
Message-ID: <87zex4ic68.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sep 25 2026, Nathan Chancellor wrote:

> +#if __has_builtin(__builtin_memset_inline)
> +#define memset_inline(dst, value, size) __builtin_memset_inline(dst, value, size)
> +#elif IS_ENABLED(CONFIG_CC_HAS_OPT_INLINE_MEMSET)
> +#define memset_inline(dst, value, size) __builtin_memset(dst, value, size)
> +#else
> +static inline void *memset_inline(void *dst, int value, size_t size)
> +{
> +	char *d = dst;
> +
> +	while (size--)
> +		*d++ = value;
> +
> +	return d;
> +}
> +#endif
> +

memset actually returns the original pointer, not the incremented one.
Nothing uses the return value of memset_inline here, but it is
confusing.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
