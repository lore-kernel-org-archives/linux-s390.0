Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37CD42882A
	for <linux-s390@vger.kernel.org>; Tue, 20 Jan 2026 18:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768934746; cv=none; b=DrfQnkF+euPtJ11mKiTlezQv07YuK1EksH99mqbSxe38rBdc5/FLAu4sjwuqQu5Y0UoKKDTABizT4EKDW+63ji30zc76VNZMvrJd2fiAkm4yF/qpNzla0XQQ98M+GjL8TARG+wIunEFFhfgMET8OfhLTFpadErPCK0rhlMUem2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768934746; c=relaxed/simple;
	bh=yDbiboXvrRh+ivSKcybv8FalD/6w3BtuEBLuaJUmJwE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h2/TkOmUpsFhyJ9eIyPbTjpk1v83gmGHbslXt6ZmR7MJ6/hvS5caJMBZ/0ARdOqR3q9vWnJrXwA/bVkFENuipaQecECk5MMyxRryEqW+JjWHzPSgJ14xASlhqTdVQS7XeYO5WY+ya+mml+XI3Wff0iPh2/Ej+g5UZ/Z98Nh8U0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AV/ELTjQ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AV/ELTjQ"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4358fb60802so65971f8f.1
        for <linux-s390@vger.kernel.org>; Tue, 20 Jan 2026 10:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768934743; x=1769539543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thnE7Lerq2YAOWgwctI0eLWWpc+gSu6vXOqPs3mAkT8=;
        b=AV/ELTjQ1q2kuPpOal2LcflAh8YWQ0n/W6YBPlugIgwvsrq2Sn8td5EZTtyGf5LG5Z
         aE2A6UTUU2ExQB22aU73V+hJay8yMrTXF+a0y9kTl7rSaNzpOzepQ0O5ABciIIfNSIFA
         rSLVpZj60j94NG/XkcXTJuyQsq6VOD4Z9rRIHGrpw+kVFqax/WWLO/EyuruEsHu/To+U
         Ii+iwTzt1DGIfytCSvXKGvBt/4GsvDQOoeGTJnl4Pz9fVaJ8uKAG5D05pNt366oYAmdu
         tOyQAx6bR1z6iiWHbPw2ZsIfBlBAlys69iWGylIk8e4ToINaSrZW7B5OyKM+Se+/6FH6
         523A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768934743; x=1769539543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=thnE7Lerq2YAOWgwctI0eLWWpc+gSu6vXOqPs3mAkT8=;
        b=xTxtnodApyhespr49j6aDf7WbMMz0bHw1kAUjOi70qdAPNGJk2hZW3ztHcoznSkhs/
         jFDiPPC1de0CQaGi3uKmuV/WWUzRGohnoDgER1bWS3sb5icUGTm2icQY5AmG3jLw6PLS
         J+tg8kGdmXglxPgwBS7Ip5BUcVMMvJmjEe2y2te1FYYN7AF2tqPqK7Qra/RxTuCaRsW7
         H6c2NP0E3MqzeTqa7R8ZJyCzBkg4cDPcWt1JcJOwG/0e6dDI9wgY0FzKX79MfXj9nRcu
         +PmcijjulxJtZZmvA+TuNd4TcNSrxBxL9KWUmwzfKOEmSKUVLDfj0gpkne/Hd6s74+Mh
         5Yww==
X-Forwarded-Encrypted: i=1; AJvYcCXAo63EryZOuHPli410DA1Z89QtWEn7wbxOBIvBcu5/ZA6bb70baLe5O2tu5JfJp8fYDuWkgTKNJ5VM@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2AXvhz8GtPWF4PQWaXM4F+FmPGrhijvIrNLUDlzw/tsDFV3Cq
	XeObr6PM08lV/VXWt0U9A7cwa/LraHMZw3RgK/FHVK0z+LI5CTYEunmd
X-Gm-Gg: AZuq6aIhAX9v+MwsdgscKItYzXO46r/Df4cdTh+6qre5FIdOn3USDRfhpQvtjJLALPT
	KcWo/LJASx/YY/gqG1wD4TWHuCVy/TiyD3zyBtAzMcn8B5OKYdJx1NyDGNwiKS3sMDcRXTWPu9t
	HAAHAWQPy5PlVvvl5e0bNX8AbFKDENWbe1shA71z/IqQQLIEku8WXhD2IGdnYiAQfgK+TwFSaVD
	/DDc8ik/5dwIPdvVNTgKMf1bmQlet/y2KKEqcuHwjalWNFSBG3aG1UEXijB3z3WRS3pF8550/ur
	w7b0IvLXoQPq8H1f0+tFN9BGEsQM2+CA1LO8P19cLloEzVr2lZhEysne/EKSp7+SSJ06RYHbDZ0
	t+N9DCFGPzzzMzdgolo8UGJlICE910DfA5djSsNuJ1NLh00UTv465pXuxyHzTzGsg3t9XFULbRA
	SEUtdPLjRyAFzNHODdWmuZ0UIxEyxhAHSAUvTumixHgPvZC3qUXz1o
X-Received: by 2002:a05:6000:2484:b0:430:fcbc:dc4a with SMTP id ffacd0b85a97d-434d75c16c1mr25592154f8f.19.1768934743113;
        Tue, 20 Jan 2026 10:45:43 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997eb1fsm30869735f8f.35.2026.01.20.10.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 10:45:42 -0800 (PST)
Date: Tue, 20 Jan 2026 18:45:41 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Kees Cook <kees@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "Gustavo
 A. R. Silva" <gustavoars@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark
 Rutland <mark.rutland@arm.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>, Ard
 Biesheuvel <ardb@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Fix bugs and performance of kstack offset
 randomisation
Message-ID: <20260120184541.0a463cd1@pumpkin>
In-Reply-To: <a8ca3483-d61a-41bd-9b1b-17a8f3ac03eb@intel.com>
References: <20260119130122.1283821-1-ryan.roberts@arm.com>
	<20fb97f1-7e50-485a-bdfd-a2901d20ec84@intel.com>
	<C502BCE6-2FB2-4A06-93A8-E8DEDFC22914@kernel.org>
	<785a7d90-babe-43af-93a6-c220c1877bcf@arm.com>
	<a8ca3483-d61a-41bd-9b1b-17a8f3ac03eb@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Jan 2026 08:37:43 -0800
Dave Hansen <dave.hansen@intel.com> wrote:

> On 1/20/26 08:32, Ryan Roberts wrote:
> > I don't think this question was really addressed to me, but I'll give m=
y opinion
> > anyway; I agree it's pretty binary - it will either work or it will exp=
lode.
> > I've tested on arm64 and x86_64 so I have high confidence that it works=
. If you
> > get it into -next ASAP it has 3 weeks to soak before the merge window o=
pens
> > right? (Linus said he would do an -rc8 this cycle). That feels like eno=
ugh time
> > to me. But it's your tree =F0=9F=98=89 =20
>=20
> First of all, thank you for testing it on x86! Having that one data
> point where it helped performance is super valuable.
>=20
> I'm more worried that it's going to regress performance somewhere and
> then it's going to be a pain to back out. I'm not super worried about
> functional regressions.

Unlikely, on x86 the 'rdtsc' is ~20 clocks on Intel cpu and even slower
on amd (according to Agner).
(That is serialised against another rdtsc rather than other instructions.)
Whereas the four TAUSWORTHE() are independent so can execute in parallel.
IIRC each is a memory read and 5 ALU instructions - not much at all.
The slow bit will be the cache miss on the per-cpu data.
You lose a clock at the end because gcc will compile the a | b | c | d
as (((a | b) | c) | d) not ((a | b) | (c | d)).

I think someone reported the 'new' version being faster on x86,
that might be why.

	David
