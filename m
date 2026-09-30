Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51BD36A033
	for <linux-s390@vger.kernel.org>; Wed, 30 Sep 2026 15:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781728; cv=none; b=ILVd+EwZCDI9IBh03kmdVxLS0LwoYTqip+V43BkIo/IaCQy6Vb2IO5juNqAN7tlQVzVa5TF8DX+jWavXytQ0nqiqchXdqwanDEdqXvV+8k/tAUQt/hmD0HQ78OSasHJS7iAIQdtz/0G3OAMTtB633uf3qv0aweHcOat17y5UKWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781728; c=relaxed/simple;
	bh=yDrsOb4hwWXIN+T6cItrahv2HmKPc/RBpYKbK6q2uSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LCObxxyTT5a5XlrcV3ugkFfRz66VuFlQ44Gv2H//vvSxc28Xzw/aMl4Zb6eSSmYbqT0vLQgCiurnI0GhFNLwkqJTfAea424UpmytrTjwLrT+wSKyYwC1KGlZJa3NPDag1nOT4IW6QmYxwgEteT4xmh44FYzEubX1Bf15Rwe9oUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=ki28e/aC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ki28e/aC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24471F00893
	for <linux-s390@vger.kernel.org>; Wed, 30 Sep 2026 15:21:56 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=ki28e/aC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1790781713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3YhJg/Vg0kUrlQnIKq6WPQNTQH9OtFetyfT9AbDxDuA=;
	b=ki28e/aCX6SUUT/BDlof/PFCCFqk8LvEE9heb9lcmxi9beD24wgYAuVZQMjmWs707wrzM4
	UqSFfD/YJKSUJUpWmxwdPxxEeBOc5xxX7CZgH1tJBixutaQziZfNkM/SgR3YON852FWplC
	disfybXsga0q2MJr3PQCU7uUPZyMHIo=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id 3468cf93 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <linux-s390@vger.kernel.org>;
	Wed, 30 Sep 2026 15:21:53 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id a640c23a62f3a-c2940ff2313so158443866b.1
        for <linux-s390@vger.kernel.org>; Wed, 30 Sep 2026 08:21:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzjxVDHujvEwEIf3Y/j1kvuYanK6q926nMBFkxr/tagJB8a2d7XMfA1Sd6o4OxIFJHxSWkdYXTB+GY8@vger.kernel.org
X-Gm-Message-State: AFuF++moaQ8cqxctvxPaahVeRFU2LCK00NCgAMzkf6Mg+h38HBKWIExA
	uQ2tYrYCzaSIqX7HaDEmyU4moJKLkEopm7Tqhg9l3xS7x2MdbcQGK2VdziMEo1cK+K489KlgMCR
	YrMstlaCNFNbHzjggUfZXOj4MbTewE3Y=
X-Received: by 2002:a17:907:6095:b0:c29:c575:de84 with SMTP id
 a640c23a62f3a-c2e240ee3f5mr135965366b.8.1790781405942; Wed, 30 Sep 2026
 08:16:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKwvOdmuvn0LZkYEsH84hnOGTYhTtzuWs3wMARtWdTeL6dD9sA@mail.gmail.com>
 <CAKwvOdnxKVpn=nAFaqP+9PTx4PqgHsUVWv6e60Pcr29W_eZrpQ@mail.gmail.com>
 <CAKwvOdmNZL3eFvV3v77GXDzL+XLgz+BT9TA=my0yTnbsHqVeSg@mail.gmail.com>
 <areYMjNcaqe86ds4@zx2c4.com> <9d1c338b-368f-4ea2-a12e-c28d49adff5e@kernel.org>
 <are6s5e6On3hpD3M@zx2c4.com> <CAKwvOd=BrMfFT88jsvBPhh383qqk5G+J07CsofNu0MVkziyhCg@mail.gmail.com>
 <20260930133813.GA3142230@ax162> <ar0a4b9CjL2YHCkY@zx2c4.com>
 <ar0gTS71qxnx9AkW@zx2c4.com> <20260930151337.GD3142230@ax162>
In-Reply-To: <20260930151337.GD3142230@ax162>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Wed, 30 Sep 2026 17:16:34 +0200
X-Gmail-Original-Message-ID: <CAHmME9pA+AntJ6hWoFYpTVjh-NUSd0ZGXp5XiUuhQcq3HjQT3g@mail.gmail.com>
X-Gm-Features: AclHuK-3j-Oh9f_5JCjhD5NbddIhsNHXCyGk_sGVp-iO-7Ny0UWZ0eR4ti5Aiu0
Message-ID: <CAHmME9pA+AntJ6hWoFYpTVjh-NUSd0ZGXp5XiUuhQcq3HjQT3g@mail.gmail.com>
Subject: Re: [PATCH v2] random: vDSO: Avoid call to memset() when zeroing
 reserved in __cvdso_getrandom_data()
To: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	"Theodore Ts'o" <tytso@mit.edu>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 5:13=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> On Wed, Sep 30, 2026 at 04:44:29PM +0200, Jason A. Donenfeld wrote:
> > Nathan, would this be okay with you?
> > https://git.zx2c4.com/linux-rng/commit/?id=3Dd216701724b7d8209ff4215065=
8ad5c712bdb503
>
> Can you stick
>
>   Cc: stable@vger.kernel.org # v6.12+
>   Closes: https://github.com/ClangBuiltLinux/linux/issues/2183
>
> on that? Otherwise, looks good to me, that's basically what I had for my
> v3 locally.

Sure, done. Also removed the now-unused array_size.h include.

Jason
