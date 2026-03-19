Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1AA3D410A
	for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 14:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773930932; cv=none; b=VgJ3/FW3g5JXzmv9AJVeiju0gctnyKpjkc3ul1zfYHk8upTk0+jOocGolv1E5QIoQc3EcKDKCD/xNwMryTM8tYtXDMxIwlN8kBmUYDmDsUFYeTxVO+tF3i+DaT/yaW428Aha3MwbUhQ+LGPOX5qHHdNPWYKtBLL4DVBjO8SdzGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773930932; c=relaxed/simple;
	bh=C43MUNVQK8EXrW7Zf6LgUhm00HoYmn5oeIlfwWEy15s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JNgK03lzeDByK60ct+pTDZhhYjtBaxJ+SNgB0+J/4G5Jt/x+KQlfjcT14TyGrRFsAszMkyHh2zq2JXW4szfGhs7sWlgsbFHo3+bM87yU7JVw4oPUgYV+j9nEkOD03PFoRwWT5pOQNkKj/n7xfKo5vkZjvxiaAsokmOI3yEs/lso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrUI7AhQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrUI7AhQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CDA1C2BCC9
	for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 14:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773930932;
	bh=C43MUNVQK8EXrW7Zf6LgUhm00HoYmn5oeIlfwWEy15s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZrUI7AhQe6kfCTIwsDVJLnC59+UP2pbL7mtdfXS2RzGUbQGXCLuUqNaJfy8oBA3SX
	 IcrVj/b0p4JWmMvFBiCrPuhd2re8pyKntbbpKf8epozab6Mbz1MavHSq1pmDZRXU35
	 TLfnKRuV8vZqmyY67zfuWxwqGhN6M4X/ozmcUY8B4bjpoj+8clkQ6CTPJcC37gEgU/
	 5X3/2HBYZZlnOUDrhlbeiS4u/yucxSKgak3enZWYedLGWvx0o3JlAoRz/7LvQI/0Ka
	 8o9bl7uHTGD30K+T5JR3Ny+Esdcw4ba/b400XSpyPWqi5XJSYhD2Q0ImmcruBR/cJ9
	 MmNnoKthnKfJg==
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7986fb839f5so11250837b3.0
        for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 07:35:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXKUh6Mj8MZzO5N/oyUyQ9/HhHFpZeNRSmuCuyiIvOwoZuZaR75Z+oXqx/0yYc0uesefnbmelWTs16@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Cgoi81jcG/6nDIjam7+m6JsKolQ6WJJkytElB6uFk8ESKqKH
	hP55tpnVzEy0Th4AveuPP4xOPxK9m4gnyqDYo6FPsdxkk31pxgj/sX556aTGnkoeuycGllCLeaB
	OSls8xVQAllMxGNnfRYL339Epl/pC+H4=
X-Received: by 2002:a05:690c:101:b0:79a:20a5:6fb8 with SMTP id
 00721157ae682-79a71db829cmr84616947b3.62.1773930931249; Thu, 19 Mar 2026
 07:35:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317082020.737779-1-ruanjinjie@huawei.com>
In-Reply-To: <20260317082020.737779-1-ruanjinjie@huawei.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 19 Mar 2026 15:35:20 +0100
X-Gmail-Original-Message-ID: <CAD++jLmai3mxCr6EYzfrirLfV_RNaun-QSr-ZzWL0j1ZT2cCpg@mail.gmail.com>
X-Gm-Features: AaiRm50HnrcExGdaAPLmtIwuEQVXfiGYZML0zWPSVHP71lGgUFt26zL5uGY5MkM
Message-ID: <CAD++jLmai3mxCr6EYzfrirLfV_RNaun-QSr-ZzWL0j1ZT2cCpg@mail.gmail.com>
Subject: Re: [PATCH v13 RESEND 00/14] arm64: entry: Convert to Generic Entry
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

> Currently, x86, Riscv, Loongarch use the Generic Entry which makes
> maintainers' work easier and codes more elegant. arm64 has already
> successfully switched to the Generic IRQ Entry in commit
> b3cf07851b6c ("arm64: entry: Switch to generic IRQ entry"), it is
> time to completely convert arm64 to Generic Entry.

Looks good to me, except patch 14 that needs your Signoff.

Perhaps it is best if patches 1 thru 11 are applied separately
to the arm64 tree and the remaining patches either postponed
to the next kernel cycle or applied on top of an immutable branch
based off v7.0-rc1 from the arm64 tree?

Yours,
Linus Walleij
