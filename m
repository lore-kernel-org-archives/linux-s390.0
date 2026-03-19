Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD5E332911
	for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 14:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773929701; cv=none; b=p54EkQZcH2vM/kglde1XD5fD954uwY+YliUCkH34BwuCOn7ODmHx4WeYs5Spp93BOhgCmVRnsX7163+hNIq4jH4cAwx6wR27FLoc0wXj+k4ghNTTI7aQ7H3j1G7hzM7sPSAp7+5KCoTwfW23BpAyNecCTU5lsQ9YcqvyhHTMFWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773929701; c=relaxed/simple;
	bh=siBUZXFQrW3WG414z3XwSGJh9Rh8xvrFpXx8+5dxurc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iVv+lWDS0wqCXDsBLKApmmJBN57aMW8yEgW7qckVaPU2ofC98ekfiPFC2p55AmDH3oyS7gRNOhYxYWAEODfPrtUe7evH9FOgZOk4GoZO4JqCzvsHVRp0NGHKYR27/f58dSPiP8SlqoWgRf3Ot4p7lPMD3giJUqO7/vWOcZDPDfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWiZfyKt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWiZfyKt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8277DC4AF0B
	for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 14:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773929701;
	bh=siBUZXFQrW3WG414z3XwSGJh9Rh8xvrFpXx8+5dxurc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QWiZfyKtSTu5VAxd4NqtdosVlxNOZnsHbkOQroXm2rh1idU5YG8k0RfWGpxwGCsMO
	 Wl3an4UDbftKqPR8r1IJMvXJ054gr5E1HGZCnX0ICm66qH37HIiFyv78l7GVGBMSHS
	 eYHBYLrdHYVQr8dmggUnbBtmgv9xzC86dtA2FJ33hdmLZOWS6r5MGhu4Td0Vj/LE7d
	 XoSBPWofUiZd6GCi0mfRHVBbS5JJ03kiAkF1tzcgpt2mNJOexQ+Z+mriiq393PqD0J
	 ot9OUqwM8is6k+pMj1BNTtx/haTMxWsCkdqWBehXuBX5spNW+r1VTgV4D1Hb2aeg4o
	 QyP4k80MrRJAQ==
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64ae222d87dso1032373d50.2
        for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 07:15:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUWxmLzJ+yUjLbOGoY8H8QmMvwvfYf4u0xSMV36fuy6noggOHayQ+cQ/h495Wtf7FHiR3j2QTBmy/xf@vger.kernel.org
X-Gm-Message-State: AOJu0YyeoDCTgmMJsa0sM/h2vNgqL6bqr+WFWbb8gVhgkBLgLbKGWG9p
	jt6SRSMEPO6fSCGQSlSP4VwlPrNQ8B3wDX2HV7bevEmsJ7Qmj+yMiPhz2WOvQ7vXiJoGG7MOA9t
	aoMvoEv4btPrKRsMOEvsQQXMJR6uVo34=
X-Received: by 2002:a05:690c:e3ce:b0:798:6042:12f8 with SMTP id
 00721157ae682-79a71cb3425mr66055977b3.55.1773929700196; Thu, 19 Mar 2026
 07:15:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317082020.737779-1-ruanjinjie@huawei.com> <20260317082020.737779-5-ruanjinjie@huawei.com>
In-Reply-To: <20260317082020.737779-5-ruanjinjie@huawei.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 19 Mar 2026 15:14:49 +0100
X-Gmail-Original-Message-ID: <CAD++jL=s1LzyoyANzTiU-Y1xh7b9fqUSHOOYnZdPReJctQ-QvQ@mail.gmail.com>
X-Gm-Features: AaiRm529IHnMzPCccxvwnmkfcrTA0f3Z6ET0HOvZ4g4MIV-cA5draGQXMNj2eRI
Message-ID: <CAD++jL=s1LzyoyANzTiU-Y1xh7b9fqUSHOOYnZdPReJctQ-QvQ@mail.gmail.com>
Subject: Re: [PATCH v13 RESEND 04/14] arm64/ptrace: Use syscall_get_arguments()
 helper for audit
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

> Extract syscall_enter_audit() helper and use syscall_get_arguments()
> to get syscall arguments, matching the generic entry implementation.
>
> The new code:
> - Checks audit_context() first to avoid unnecessary memcpy when audit
>   is not active.
> - Uses syscall_get_arguments() helper instead of directly accessing
>   regs fields.
> - Is now exactly equivalent to generic entry's syscall_enter_audit().
>
> No functional changes.
>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
