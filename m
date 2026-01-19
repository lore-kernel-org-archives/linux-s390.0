Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E7C1DE3B7
	for <linux-s390@vger.kernel.org>; Mon, 19 Jan 2026 12:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768825376; cv=none; b=l4thaSSPMtxtieYSY6LqvLc63QynQV59/ybBbCXzEcla5itUOZKaxBD79gT8aGLO7v8LPAvGJS7hjTEqAETdfuT/CN6fBFw30ywqYNy/ELeFEZnwhtW+FT+bKqIjiyvr3KhzSdlHBNM4AkOxHBR7ilwvMuownQ+fxYcwiNiBMkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768825376; c=relaxed/simple;
	bh=iL5a5vWD3elCqNsh2PkBrIKfV1bPfWFLdSevvtw348k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=THXfbiwr1SD8lmLhq8SbZJKYkEdmbzSeOp2EVbQuIQVPVN8ak7ROuX2p1/Wv2PEFIRZjEJ2bX2brbCgp5oykg9eEMI4dMezOveN3X8brw6e0mwnmD9HqHder9TqNbNo39M7Nfaym/JWo7BVONUVGdcSOikMa+jDtNvJD6lMKH+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PCF69CPM; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCF69CPM"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4801d98cf39so17390245e9.1
        for <linux-s390@vger.kernel.org>; Mon, 19 Jan 2026 04:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768825373; x=1769430173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hizH6Y0dclm/GlFu897aCLzhsPW9G/RqQepyEMFpeE8=;
        b=PCF69CPM0lLs+Yyg0Fgq0uDLVyEcxNqGvMHx3WNWpGAwuvvmvejaa8o6vuVCtJb2Sw
         E/kvMsMgdmn0sm8yAPQ7PB5tELTzEgycup8KYF+X6xNlkQpwT1AGLCdOb21Sd5rkq+Rm
         aMLnzCs7uaQCvxz7u/1RLjh/mLcmehTR2XEzC5To/r15Cbb70osJCX1imhRhwPUywwAw
         qlIAYhR8b6yl7vO8ZGIAIPtX5NKLPUvrxHLE0E7Lc+wh9Yw0UY4MORlhoY3y4YyrRUh4
         jw+92nCjcUMpVaZj+gTR1A2ofZw/aKwhaEqhk6ARhOKdbwVshW4z97MF2o/x2bmst2nb
         3CAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768825373; x=1769430173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hizH6Y0dclm/GlFu897aCLzhsPW9G/RqQepyEMFpeE8=;
        b=cT8IFR/JFV9eA8qYbS5HMUQXTmYRygd2X7/KnahIQzE9V4MPZTaYDivZxd3fuyNt7Q
         0V7UCKsOmMafbaDCCL/oRVZjG0+ADzyrbDlLYbh1UIKZPlGyxgLkBBvn55eFCY/nhXK+
         FjBOa7vG7bCAhb0zxQy+RdUyzrS0JsCOi9t9k/NIeeN+XnZlbWgNCtGYzzpIptDGsdJq
         w4ChJd9FDLIFkvpAbz2GHeoPyFY43jwh2s+zw8Y+ubW2SPKLIKfzh5sjL9HgDPNa2idx
         8AurMPq7N+dH39XBHXU9OJ0fJxkOGW/A9MBGRq6MQvXxTIXMJFA7ldXCWUOQ25dDPa/n
         ixmw==
X-Forwarded-Encrypted: i=1; AJvYcCXpqAm4PsiY5sQ009Wdtu9gpK1vTzODbuvwnU0S3ohHgpenMljNCrvQQ+AW3qD8dltd1umm6HOvm9F1@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8n6sdLKb8HmeZmSZGKoS+mXn0/j1pSwSDVVnzriCuA9XrW0Qf
	7+MFks2hwYPpTDqWdGS058h1oCvpG7QwIJe30YBEkN9HJPYvftV6IvUD
X-Gm-Gg: AY/fxX4qqVP5TiA7pMV3cTKavZaM0FF7o29EWFxuwTiTy/fiTmfuRoOGXxdCVRN8Kbe
	4MnRr9O9Dfse84gsQujoGaQIUi+bKPw8mm/XOVlBMlQv54+v/azBmSAb/SxIq4JRIg+NeUcsven
	M2wO100rI3bZs72WKE39FMU3rBRUYXOWYOcBD+YlldTfEqIn+Oy59XF2P2+bH0ScpZuC4UjRe52
	ZtLN5DX9bWeUYZWJUUSVaK+bZ6aTbangOxw1re9Q3K4VcT2HDE8HLJcuCQXThC0QHVh7pBNwMVm
	KNn4I1nE9N57TTyE+jAY7DqqHdMqrm1g+JwD6krQRO+rohdcT52lBL6sCCxj6eFcmU5Bpx6DoBu
	cQpEzhwxtintAwd/7KydOmvR+55T1s7tlsB+9DSG89FxWkkMPRudlxIZSew8XO5gUpqQxzM6lRl
	ixVbSpC07Ye9+MhUgDH6vOseLlFwj/oOzgmZqhXJxCb79WP9KUwuvS
X-Received: by 2002:a05:600c:3509:b0:47a:94fc:d057 with SMTP id 5b1f17b1804b1-4801eab54e2mr107589925e9.2.1768825373288;
        Mon, 19 Jan 2026 04:22:53 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801fe67780sm78105625e9.16.2026.01.19.04.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 04:22:52 -0800 (PST)
Date: Mon, 19 Jan 2026 12:22:48 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Kees Cook <kees@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "Gustavo
 A. R. Silva" <gustavoars@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Jason
 A. Donenfeld" <Jason@zx2c4.com>, Ard Biesheuvel <ardb@kernel.org>, Jeremy
 Linton <jeremy.linton@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Fix bugs and performance of kstack offset
 randomisation
Message-ID: <20260119122248.30974c78@pumpkin>
In-Reply-To: <aW4NC9P3K7Ab_e8j@J2N7QTR9R3>
References: <20260102131156.3265118-1-ryan.roberts@arm.com>
	<aW4NC9P3K7Ab_e8j@J2N7QTR9R3>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Jan 2026 10:52:59 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> On Fri, Jan 02, 2026 at 01:11:51PM +0000, Ryan Roberts wrote:
> > Hi All,  
> 
> Hi Ryan,
> 
> > As I reported at [1], kstack offset randomisation suffers from a couple of bugs
> > and, on arm64 at least, the performance is poor. This series attempts to fix
> > both; patch 1 provides back-portable fixes for the functional bugs. Patches 2-3
> > propose a performance improvement approach.
> > 
> > I've looked at a few different options but ultimately decided that Jeremy's
> > original prng approach is the fastest. I made the argument that this approach is
> > secure "enough" in the RFC [2] and the responses indicated agreement.  
> 
> FWIW, the series all looks good to me. I understand you're likely to
> spin a v4 with a couple of minor tweaks (fixing typos and adding an
> out-of-line wrapper for a prandom function), but I don't think there's
> anything material that needs to change.
> 
> I've given my Ack on all three patches. I've given the series a quick
> boot test (atop v6.19-rc4) with a bunch of debug options enabled, and
> all looks well.
> 
> Kees, do you have any comments? It would be nice if we could queue this
> up soon.

I don't want to stop this being queued up in its current form.
But I don't see an obvious need for multiple per-cpu prng
(there are a couple of others lurking), surely one will do.

How much overhead does the get_cpu_var() add?
I think it has to disable pre-emption (or interrupts) which might
be more expensive on non-x86 (which can just do 'inc %gs:address').

I'm sure I remember a version that used a per-task prng.
That just needs 'current' - which might be known and/or be cheaper
to get.
(Although I also remember a reference some system where it was slow...)

The other option is just to play 'fast and loose' with the prng data.
Using the state from the 'wrong cpu' (if the code is pre-empted) won't
really matter.
You might get a RrwW (or even RrwrwW) sequence, but the prng won't be used
for anything 'really important' so it shouldn't matter.

	David
