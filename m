Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EDC361DCF
	for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 14:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773930301; cv=none; b=nXROZI8X7oAA8KQaELLtZ4PE/6SlU76hxuZLQ4QScYEyC/aPw40a+HbYRL/1Xxuh1zuNKZQT0fKtEY3fw5r7ebWi1cbF4MEgRmIz9lzGQ+op3+8rCnkbcK/F6M8I7sk5ULs2nJeJHGG/vn0mrOc39NTuKWz39Ugy3JhDuntZFvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773930301; c=relaxed/simple;
	bh=kNLFhe5koYhQ2GMx0yl+/l5hbVUXpsA6TkF04beCZE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tBomGNACwOGAiDRPZHSnrIBRTkTxda6bIygVgHh1H3Nly9wOg0zKzLcjrQf4ug5sfcr1+X6yfXYfPrTp4CJCMhgFsG61ZZg0i5PyZArqSwh1xR1KS63G1pyaFMbhBxg49QQko+VnHsIWLMCuf0od4VGnBItWne0H2Gv443Gm6Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgP0Grmh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgP0Grmh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C612C4AF12
	for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 14:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773930301;
	bh=kNLFhe5koYhQ2GMx0yl+/l5hbVUXpsA6TkF04beCZE4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tgP0GrmhLHYfNTZB592HITldbUJTMcTzsT8AdlL0nJVr/6ov0c93Fj4guk+TOpD+C
	 yLSaFhX2vWgCxvpt3j21j7bSa4wmN7WE1lPnHrUUOC3goZf910KuAHaq+ynDgM1Pzr
	 HpVwrNRyzLE8KUthkJkIw22wVQ89VVwIy1efRUSxSlAzI6RCRXy02ERKEA8Zwibdjm
	 ATSBD8PhSIorqTlR5+rU0nHTtIdW1iyqRQB1on/SQZmVNRdKOSDQCdvz2YZ1KLjHHj
	 YnkPFffu+SJEX+fh72LFJcNgv6bmeUXhKsvO9lgwdETEzQMjXN8Cl/TDAhK62LPxos
	 keV8JJ6mHpHtA==
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79a610a32a6so12250987b3.0
        for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 07:25:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXNUlgdk0sIwfi1XPRPiwor85Ay0dcv4AQQla3Ejus4gXdMRs0aZuSN0kZxTTBTzKmu6xG6054U5n8+@vger.kernel.org
X-Gm-Message-State: AOJu0YyoDp22aOYxIGzI8sncF9wfS9LUN+eapIsANxIqDGSs/74QPZDz
	2TmpkXynnKlP2MhD/9bInlOPPxI5D9ZYUWPeSH2NaSN/fukN4+ZD0iPr9cmRky3US5blNxXZ4aO
	Yenpjuw8M2SBAXfT91u3hxrPWqM3j0/s=
X-Received: by 2002:a05:690c:c4e8:b0:79a:7d50:fbc5 with SMTP id
 00721157ae682-79a7d50ffe2mr47392627b3.49.1773930300323; Thu, 19 Mar 2026
 07:25:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317082020.737779-1-ruanjinjie@huawei.com> <20260317082020.737779-14-ruanjinjie@huawei.com>
In-Reply-To: <20260317082020.737779-14-ruanjinjie@huawei.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 19 Mar 2026 15:24:49 +0100
X-Gmail-Original-Message-ID: <CAD++jLmq0NMEL7BLexugvyY_YvQMGCt7T9HpqkNbEkn1PU9cLg@mail.gmail.com>
X-Gm-Features: AaiRm5035IAWAKizkHQuG2dwP1mJS80mfL8fV1T70pFNvBv5XvZbCQVCTwQtBCs
Message-ID: <CAD++jLmq0NMEL7BLexugvyY_YvQMGCt7T9HpqkNbEkn1PU9cLg@mail.gmail.com>
Subject: Re: [PATCH v13 RESEND 13/14] arm64: Use generic TIF bits for common
 thread flags
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oleg@redhat.com, 
	chenhuacai@kernel.org, kernel@xen0n.name, hca@linux.ibm.com, 
	gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com, 
	svens@linux.ibm.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, arnd@arndb.de, 
	peterz@infradead.org, luto@kernel.org, shuah@kernel.org, kees@kernel.org, 
	wad@chromium.org, kevin.brodsky@arm.com, deller@gmx.de, macro@orcam.me.uk, 
	akpm@linux-foundation.org, ldv@strace.io, anshuman.khandual@arm.com, 
	ryan.roberts@arm.com, mark.rutland@arm.com, thuth@redhat.com, song@kernel.org, 
	ada.coupriediaz@arm.com, broonie@kernel.org, pengcan@kylinos.cn, 
	liqiang01@kylinos.cn, ziyao@disroot.org, guanwentao@uniontech.com, 
	guoren@kernel.org, schuster.simon@siemens-energy.com, jremus@linux.ibm.com, 
	david@kernel.org, mathieu.desnoyers@efficios.com, edumazet@google.com, 
	kmal@cock.li, dvyukov@google.com, reddybalavignesh9979@gmail.com, 
	x86@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 9:20=E2=80=AFAM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:

> Use the generic TIF bits defined in <asm-generic/thread_info_tif.h> for
> standard thread flags (TIF_SIGPENDING, TIF_NEED_RESCHED, TIF_NOTIFY_RESUM=
E,
> TIF_RESTORE_SIGMASK, TIF_SINGLESTEP, etc.) instead of defining
> them locally.
>
> Arm64-specific bits (TIF_FOREIGN_FPSTATE, TIF_MTE_ASYNC_FAULT, TIF_SVE,
> TIF_SSBD, etc.) are renumbered to start at bit 16 to avoid conflicts.
>
> This enables RSEQ optimizations which require CONFIG_HAVE_GENERIC_TIF_BIT=
S
> combined with the generic entry infrastructure (already used by arm64).
>
> Cc: Thomas Gleixner <tglx@kernel.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
