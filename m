Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B01443B3EE
	for <linux-s390@vger.kernel.org>; Mon, 20 Jul 2026 22:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784584880; cv=pass; b=aC4G/Ndtx0ax3vT0qgDhdgeGrhljKLcnwOOAw7RNlgYtQraUIQMNGnZAscjYIkidskluOa33BPdzBwEcHAUcPa764Z3YtVcd6vmj7yIH2OcuxaHSgy//EAwOjEmkx5X6HosAtLQPa+xifW75qUZ3xQ6E/o5A8VxMjeKqyIhywXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784584880; c=relaxed/simple;
	bh=j/7Pu0goIzrDPISYd7UGXNeACZWMCvQbsT7AmxUh2RI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oFxs8P8tMrMlyZx51d4n9ujOGKE1x5uCI1bP9AEbPfLVH7rJGdSog/FdGE6tmi04OJOVooMsHAeoIe8SZZQHC1MRzobImHO5K9mpnlEWBXwlghPmQSsK2XnTuzIz7cMHHW3jRTcxrE8cZOkMcXIX6OLChV4Bmil69bCKHxIzViM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMey3lva; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMey3lva"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-698a9f11776so12016608a12.1
        for <linux-s390@vger.kernel.org>; Mon, 20 Jul 2026 15:01:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784584875; cv=none;
        d=google.com; s=arc-20260327;
        b=V22iaImWu22/HCBqXVty4EXALfMHkEfaTOdI8HuMOi1SavONZW5VGZf6oPZQd4lFWk
         rksBf+Zq+YFLLODCgUW9JfbU1P3QEChk3S2kbfmfYKqTYlcQBMra62xaFUmdl/i4ntZp
         LasF4E02G5aJ/BX29LFUQtiekm3lxVYTuPQgUZAgfSzTpPU6fSLcFeiqG8NidLie1NGf
         pQeU5Rjf2Vv+AuQXqrBNMKXcna5alo19DLKYNnedYxyf7KWTa3TqAN36cnlqsxRtKaF0
         r0NJoIDf2Mpr09fuborJOJnZQsUq353gp0j0z3v5qkDDUq5mjUUrstRtsLQAkl5zN+dZ
         9bnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OFKHaLiuiIMT2s5Bf3SZwWbn7++lylaBZHxfNpeM7Fk=;
        fh=9PlthWm569Aa7sjJ12FBzTYeizn/eezMDpJH848pfHY=;
        b=X8snTxdZxNUp0Cd4/1Zsfk0xxZyXf+ZkEkUFctoIckPTq9r3lt8WQvicgBLx6tgPOv
         siZknh5HMJcZcs4Isn4rioK3VVnfzusfd5rXy6f24i4UcmfOICVEbpGKLUsgj7akSyta
         LIBAet4PRypZNtgbbrnG/G+5mocifQLXWSIHVkBmaU3K3/eo2LL/W/RRmt5L9m/xoJNZ
         q/fC6ynMNwXxHoQV0BTdr8dzQu1YjLeilM3rwH5bALsqHB6qGT01PsyxIOJVAsnlgHwW
         tfHomiv3OPb/MWtLFtzsg/LK9munhhYVi06jPSdRo+chG4cxw+g+BNUbSvT3zsChjLqo
         B7CQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784584875; x=1785189675; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OFKHaLiuiIMT2s5Bf3SZwWbn7++lylaBZHxfNpeM7Fk=;
        b=ZMey3lvahqP+YPW9LamnWQzczRxQiZ4wg9gw2Nu7P3y1v17JUAuMM/AR3JTiQFFKU8
         d9noasqw2G++q5S+mCeWeywDA5kpg8MuVxJjECyua9/y3jlOjzMIOYlRYZqO13STHgxR
         WQ87V1/rMYJN18KwPy7Kt1f4oO1hp7OTlSg/lmBFsB1gkADDpu+GAYd81uYxtDWFgDYj
         g7E/fCVHIhWUawA3wQ30Wot0eYDovRLDP5gkADBspVyzhS4siR8fFKxsvW3/xg6aPXXq
         4tTUNL4YjCh2lps4QkQgZ6MAQbSDaAHnlH759VBDRh1kPBksK3QYu64fJW2a6dhpi8jy
         qpww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784584875; x=1785189675;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OFKHaLiuiIMT2s5Bf3SZwWbn7++lylaBZHxfNpeM7Fk=;
        b=SC9Z3A5UEa1xc5WJGctkhN62IgKTyhUr4e+oTSHODmXYEqoVxOhtanSu9ECn1HI/yo
         yT3i8GIr25t8e4eQ83mIf0mQAsGhN+TVnbbYRchFoZZF32JLNHqjN9SbgdHkftSgtidb
         vFlyPLl8I9gXIyHFAyv9myfLyGiyIf7vvumfExkRfXfRci4ICKHkebsnuEOjKzkB3olD
         0g9fbx8AdW8EIn05vNWo1bgT/JUhKz4FbFipo0PRP5xhZOUS0l+z+n7ExwAzl8yvez+W
         bmB/85ezJmotRxeJ0xUZEwPX9Tkjds5vxGMBR9IVwrBhczNiYOpvR+kCPW1oh7UFJ+dN
         Kyfg==
X-Forwarded-Encrypted: i=1; AHgh+Rod+jpu/PiX0cDKDBd67ZxzwZNIM03pwM4zArjdtoDHLos+ekRovzBYH6+w9rQga9bLR5SApYt0u16N@vger.kernel.org
X-Gm-Message-State: AOJu0YxiXCdc4VQFIzutQ9NVVrSLZJs92NDaJVZkd/ZZWWj8us4zMtgk
	aTSmBhf01PSvG8QaHNRYZ8qVF8E6tWWhZ7xZtYsL750Z1quW1UQnEvqHpTqTxKh9rR3bIY08O2v
	0dQ3VCFhZnj4gh97rf/zmVzixQy42h3w=
X-Gm-Gg: AR+sD12iwUqNqNEAQ9pIu2WeqyWQhPBMPKQ2HGFTVBkj8O//LXcCdcUc89MxS62fdUM
	ZuUVrT/6vCf7b/Xj542Tbc6KfWxE8KYOdFZLdF70+XAtC64i2Qe/gb4MR0z4EdHDQlP1A6adelz
	wmFS1b9Tnk7PY8JkNpNWnkXBBQOE7Kc4ZqwgOnr5EGIDRR0GF7Hgunx0j/OEHD8OnZmobWH7Uxv
	4PPG4PXNd3BdWMB3EoYhGuOkBRzSGZyoT7TGCbkvk2v6wPcMIU5dTkHhN27lD0WTSTWcOHtlsmF
	qcCuALoYnuFFOynJZfaEIacuBFn+f7c=
X-Received: by 2002:a05:6402:2356:b0:674:5b2c:d42c with SMTP id
 4fb4d7f45d1cf-69e6525c770mr6536246a12.3.1784584875096; Mon, 20 Jul 2026
 15:01:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707181957.433213175@kernel.org> <CA+=Fv5TDNH8+JAojV9_W36kUkEE68uiA00FQ7i0vJunebqs1sA@mail.gmail.com>
 <87wluplb6k.ffs@fw13>
In-Reply-To: <87wluplb6k.ffs@fw13>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Tue, 21 Jul 2026 00:01:03 +0200
X-Gm-Features: AUfX_mw5696pn_wiz_LjCaJHiFU9IchwhNNUbBWmuIdhtqSFIK3TJnj9-atYCBw
Message-ID: <CA+=Fv5Sd5+-K3-MOiEc2N8z_5CoLQPVPUwjiugSj3u8cBWJXXQ@mail.gmail.com>
Subject: Re: [patch 00/18] entry: Consolidate and rework syscall entry handling
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Helge Deller <deller@gmx.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>, linux-arm-kernel@lists.infradead.org, 
	linux-alpha@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-um@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, 
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-arch@vger.kernel.org, =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thomas,

On Mon, Jul 20, 2026 at 9:21=E2=80=AFPM Thomas Gleixner <tglx@kernel.org> w=
rote:
>
>
> Similar to what Peter and me suggested in the related discussion
> vs. s390 which has a similar issue, you can just have a dedicated
> syscall_return member in your pt_regs struct, which is preset to -ENOSYS
> and operate on that. You have an unused padding entry there which means
> it won't even change the size.
>

Thanks, that makes sense in principle.

One complication is that my Alpha GENERIC_ENTRY branch already reuses that
former pt_regs padding slot, while keeping the pt_regs size and stack
alignment unchanged. The extra syscall-entry bookkeeping I needed so far li=
ves
in thread_info rather than adding more fields to pt_regs.

So the padding slot is not free in my current branch. I can still look at
whether a dedicated syscall_return scratch value would be cleaner, but the
tested version currently handles this by setting the default -ENOSYS result
only on the no-dispatch path, after generic entry processing, and only if
ptrace/seccomp/BPF did not already provide a return value.

>
> You were on CC for the V2, no?
>

Sorry, I must have missed that.

> The whole pile including Jinjie's seccomp bypass fix is in
>
>     git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/entry
>
> and is targeted for the 7.3 merge window.
>

Great!

> If you want to base your stuff on that for 7.3, I can add a tag which
> makes it immutable so it can be pulled into the alpha tree.
>

Yes, please. There is still some ongoing testing/review of my Alpha
GENERIC_ENTRY series, but assuming it is ready in time for the 7.3 merge
window, an immutable tag would be very helpful.

Magnus
