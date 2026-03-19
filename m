Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CAC36F410
	for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 14:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773930377; cv=none; b=u7/H6XpK2hWVwoPgsOK4u2b1TYaCUOCkxRr56TigxrSOmI0l/ByY+2ieF+OSBXH7YZIAqqNLHoapMITg8gDW+/jOPbqP0BAhJzufsgQprxlEibFTUnXV6Xi0cHqmVG0Lvga83thltT5fCMBYEo1SeTFvZeHykzJN/TvJxl8OUr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773930377; c=relaxed/simple;
	bh=EfYzODYTn0NTm+Mvi25JjdLYLxLuMewomF3tXPZzqjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jAer3UfpvGBWKbwhemGoqQ0y2LOJKnVA1a9OVIaVjGmAr6IzU5r0+w5pc5Pe3uWLBzst76lvc2ahf0p0mcQnUR0jwtDcpu9T26+tY2zaKHHjb2KaMzUuSRkDiyRczYUhQjW3UGnrTWOljAAfNIatwpogMP+Z22gjb8F2NHZSFv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dff3BK9q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dff3BK9q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67DDC2BD00
	for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 14:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773930376;
	bh=EfYzODYTn0NTm+Mvi25JjdLYLxLuMewomF3tXPZzqjU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Dff3BK9qblMvdaGnMX1CDzOnH6xEGROfjGr6QMMmkKcKL7jiomhG+5Fw/BDFAmJPK
	 xPUHtJhc+niI4/UoqiRzv/ppoiVu/XuEgVOyG7dWHdPmCWKBv0Y26L7XwSt6b5xHtg
	 glEa3utWOkxMiEE+QRQ0BL7aPsv0RSEHYxPF4p4afgzyfbVFiZhX/uzWC17WvEj2PW
	 ZbM++Dc1n9vxjq33XSgVnKNZ01bWq3a8hLRdoCFAW5nhn6I3ruLe+zr3y9KhQHP2CR
	 w1u8XKrFTRayqvzqdMQ1syFj4zKaT/mfb92PN/rSEKQZAtVbOFq2Aq7XXwVugOW3Cq
	 IaXoUwGxaV1cg==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79a75818937so10573307b3.2
        for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 07:26:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWLHVFF6F4yishhnaVDKlfzv9/e7f7amCTjrma2gQNSV200KyaVYtPCMSyFzDuB5LwfsUT3ACgP/Bcx@vger.kernel.org
X-Gm-Message-State: AOJu0YwblEww6AbrLSXfc0Vi5fJtc1+6ASOwKd3RodH4MK3BRM/p+6zp
	bMqROH7D5H97IrMqlYI5Tk1EIFy7mn8PHMYsurfVY3hABsFheDuW+jFXGEqkOEryb+Hrp9cvtAY
	1H1s7DI+yyaATMvF/NPCK0kcdySZRHME=
X-Received: by 2002:a05:690c:660e:b0:79a:37c5:5d29 with SMTP id
 00721157ae682-79a71db8246mr80698987b3.57.1773930375929; Thu, 19 Mar 2026
 07:26:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317082020.737779-1-ruanjinjie@huawei.com> <20260317082020.737779-15-ruanjinjie@huawei.com>
In-Reply-To: <20260317082020.737779-15-ruanjinjie@huawei.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 19 Mar 2026 15:26:04 +0100
X-Gmail-Original-Message-ID: <CAD++jLkpHbZ5rf=D+Az=XiWmDFOdD6MPjEVPBLCf820q1Jef4A@mail.gmail.com>
X-Gm-Features: AaiRm514Fbz_01wtqZJwa0U5dvzrhpy5vnegDsf7QhH81-s0mjNJm5JdcFU2cz0
Message-ID: <CAD++jLkpHbZ5rf=D+Az=XiWmDFOdD6MPjEVPBLCf820q1Jef4A@mail.gmail.com>
Subject: Re: [PATCH v13 RESEND 14/14] selftests: sud_test: Support aarch64
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

> From: kemal <kmal@cock.li>
>
> Support aarch64 to test "Syscall User Dispatch" with sud_test
> selftest testcase.
>
> Signed-off-by: kemal <kmal@cock.li>

You need to sign this off since you are on the delivery path.

Yours,
Linus Walleij
