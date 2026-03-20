Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF091317175
	for <linux-s390@vger.kernel.org>; Fri, 20 Mar 2026 13:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774014071; cv=none; b=DV6uiYQl4ky+V1dz7S4EJyGT0FWdnV/6GDwTqTnEXJzP9HYsaj4C/G6N4erfr2Qm0sXWkSl7Ihe3ZslPGJ13QI9R8NwFpcRDna082l0I1viwZHEBQhNvvjUDwAKJQSEYlo2vbEbpb1Jox3ysw/HR2lp2D8HPtlNBEIMWqGi3ltQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774014071; c=relaxed/simple;
	bh=4cQ77l3jUUu/0NTgxuBkklNb6Y2mFPOzQNvBYvPzuUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U1h/MGIG5OgYBz+AlW/qlXkobpAdQwZZcoITppFIRg5AVa2YQebBx3Nk/CKjAZS8KrsBRcgoPYRTGB/XVfZjwqiv7xEVoaguRmStrawODaZqoukD79L9jGb42dlbKCf9+kchfkKbdqhstBfeVqxB3G3jQClPL2WtknL3/5g6K+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ww44zBT8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ww44zBT8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73702C2BCAF
	for <linux-s390@vger.kernel.org>; Fri, 20 Mar 2026 13:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774014071;
	bh=4cQ77l3jUUu/0NTgxuBkklNb6Y2mFPOzQNvBYvPzuUA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ww44zBT8YZ32c5W/sr0XJLW1VRxTvZHMiL/3oSaZdEm53jx6FFoIRcyE/YmJSKuhY
	 vUpfMsZpnblONjDHF6wQCNtH7jHTt90/TYH4TOHcTZy6TRCTCXXmMA0XTGN38NRNyi
	 cg8yjzjdr3yrFaHnbJNlH8rLx6ejfEz7mB/MJ/eLuDr156jeE0YJ+NGSj1O7upmW9M
	 KrAvcUh0+Db+QXarBipd8Sn8vTKBkE5lTxgv+EaJ81rY8x5nUnhF2WCiedOKJEGu2f
	 ROw2opoBPCWT9eOuWyJILlE0s5KZWlUnCGsOm4ot1lCFLAYcqqYugTNCHXEGyR6bvg
	 jKNINJOE8MSdQ==
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64c9a6d7f81so560757d50.3
        for <linux-s390@vger.kernel.org>; Fri, 20 Mar 2026 06:41:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXIPJDRnly7107JkvFTlyYOV2otEQMbmGXQBo64LPjulIA8jsCGxD+YG5Yhmwy/OyzeaRgbja3AaXKl@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd2XFRuVL7Ku/WWEqWLVCuuXWDxjFAB0TVroksXbHFD8BpUkg5
	2xOMvkVQwyiifImCHv3dwMBcCPA1V6kql5HBIqR6/A85GfsHcHJI3MeSGnG5Ea5cA7pE17Omm0K
	XDSNe5+E3kbIHjNp6lvHvnpRPvN0RXjo=
X-Received: by 2002:a05:690c:4992:b0:79a:9308:956d with SMTP id
 00721157ae682-79a93089ad2mr24134867b3.42.1774014070583; Fri, 20 Mar 2026
 06:41:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320104222.1381274-1-ruanjinjie@huawei.com> <20260320104222.1381274-5-ruanjinjie@huawei.com>
In-Reply-To: <20260320104222.1381274-5-ruanjinjie@huawei.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 20 Mar 2026 14:40:59 +0100
X-Gmail-Original-Message-ID: <CAD++jLnGb261e-OBSM0Cq1WeqreC0_mhwr2Drs=jxTA_BPdZJA@mail.gmail.com>
X-Gm-Features: AaiRm53_RKos6cVTpDm6VjWzuRZcscDfdc9HHkMQundtQ2MYdyZbCDI6tg8vY8E
Message-ID: <CAD++jLnGb261e-OBSM0Cq1WeqreC0_mhwr2Drs=jxTA_BPdZJA@mail.gmail.com>
Subject: Re: [PATCH v14 4/4] selftests: sud_test: Support aarch64
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org, 
	kernel@xen0n.name, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com, 
	oleg@redhat.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, arnd@arndb.de, shuah@kernel.org, 
	kevin.brodsky@arm.com, yeoreum.yun@arm.com, anshuman.khandual@arm.com, 
	thuth@redhat.com, ryan.roberts@arm.com, mark.rutland@arm.com, song@kernel.org, 
	ziyao@disroot.org, schuster.simon@siemens-energy.com, jremus@linux.ibm.com, 
	akpm@linux-foundation.org, mathieu.desnoyers@efficios.com, kmal@cock.li, 
	dvyukov@google.com, reddybalavignesh9979@gmail.com, x86@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-s390@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 11:41=E2=80=AFAM Jinjie Ruan <ruanjinjie@huawei.com=
> wrote:

> From: kemal <kmal@cock.li>
>
> Support aarch64 to test "Syscall User Dispatch" feature with
> sud_test selftest testcase.
>
> On qemu-kvm machine, the sud_benchmark test results are as below:
>
>         # ./sud_benchmark
>         Calibrating test set to last ~5 seconds...
>         test iterations =3D 24500000
>         Avg syscall time 208ns.
>         Enabling syscall trapping.
>         Caught sys_1c2
>         trapped_call_count 1, native_call_count 0.
>         Avg syscall time 213ns.
>         Interception overhead: 2.5% (+5ns).
>
> Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
> Signed-off-by: kemal <kmal@cock.li>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
