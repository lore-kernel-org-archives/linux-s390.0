Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768D0126C02;
	Sat, 26 Sep 2026 12:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790426357; cv=none; b=DVJAmCwoHhG4VbwM4zA5zJBhgDaz7NUguW3ETghi8relwgnsujVo8yVJ35cnDn5+swbo88CBt5CDwT92U4OPMQGUh7GT/+U75wg8YkAEAXw4SaDJoepTKPKrllZbYwI5cdYdqzHQfqxOHOepZ+S9nFMt5/Uz1kKBhtzl6pSzqN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790426357; c=relaxed/simple;
	bh=C7CUUnBt5TXvA5ptaCYvt0JS3Dvwmd2X76y7hjyODBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AD721DVbZA9BJ6wAx4oVKKpTEsr2jSy7EQ5yjB0eaa0C3vE9OYm5hjGHw5uhBma0T3BuDGBRT9lLrjeHuLxEP679/chmdPUfERTxJE2KsSP7YTBDcPmLxCCMBfKdtqAA1NdKRNdHFYufWcgByMmapZtgPLbfgRTvnJZ33o+qOP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqO5QHmR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqO5QHmR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CFA1F000FF;
	Sat, 26 Sep 2026 12:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790426355;
	bh=xUrWyqVmnKFt3e8RhkrZ2j3Y0i3O/ft05oQJMh6wlj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mqO5QHmRcMSYwDEgOPDLIZcr6jr2YfLZFqWA7XF/GlNNvRhVaLD2MqTlse+KUluEL
	 xzQtAcTaB0AUUAyhyXub2Dl1sDoMhQBVGpEqYPhOFnxMIeHAfILAjiNHt5KASH4zgE
	 9rM1gY9zZsC843JVDcJ/evpaUDkxxUnTOWMufD7S2+kem/c2g2lrgfyGSMRjpNUarx
	 z5QFeWBKFuAmXjti4J2zAENqDWuza+nvxNd9M8lkcQxgEaFZWFlweuEwmQoJ24uygc
	 ZwThu0B4gX8MvLQqagGgOMSxUH5JZWmq/Uwr7kjbGCVNI+MI7sGEzKwfcBn23nv76b
	 a+d3+QTbcxiZg==
Date: Sat, 26 Sep 2026 13:39:06 +0100
From: Nathan Chancellor <nathan@kernel.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
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
Message-ID: <20260926123906.GB1486962@ax162>
References: <20260925-vdso-getrandom-avoid-memset-llvm-24-v2-1-ce640f872393@kernel.org>
 <CAKwvOdmuvn0LZkYEsH84hnOGTYhTtzuWs3wMARtWdTeL6dD9sA@mail.gmail.com>
 <CAKwvOdnxKVpn=nAFaqP+9PTx4PqgHsUVWv6e60Pcr29W_eZrpQ@mail.gmail.com>
 <CAKwvOdmNZL3eFvV3v77GXDzL+XLgz+BT9TA=my0yTnbsHqVeSg@mail.gmail.com>
 <areYMjNcaqe86ds4@zx2c4.com>
 <9d1c338b-368f-4ea2-a12e-c28d49adff5e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d1c338b-368f-4ea2-a12e-c28d49adff5e@kernel.org>

On Sat, Sep 26, 2026 at 12:55:34PM +0200, Christophe Leroy (CS GROUP) wrote:
> Le 26/09/2026 à 12:02, Jason A. Donenfeld a écrit :
> > Apparently not on RISCV, which is what prompted this patch in the first
> > place. So I suspect Nathan's v2 here is the way to go.
> 
> 
> Don't you have -fno-builtin on RISCV like we have on powerpc ?
> 
> Or is it clang that is missing this option ?

Yes, clang has -fno-builtin but as I mention in the commit message, that
may not always stop the compiler from generating calls to memset(),
which it is allowed to do even with -ffreestanding (which implies
-fno-builtin) per GCC's documentation. -fno-builtin with GCC < 14 just
happens to avoid generating memset() for memset_inline() in all of my
tests, hence why I went with this approach as suggested by Jason.

-- 
Cheers,
Nathan
