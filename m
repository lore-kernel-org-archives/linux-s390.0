Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED0B30C608
	for <linux-s390@vger.kernel.org>; Fri,  3 Jul 2026 21:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783114356; cv=none; b=WbnaOCQCaIUXeFNVvWgT5mzpSqlp45kqdzKTv8o/jB/wMKfPgi5ngTb1JzI47B6xmb0lJQg69F3A19Kp/5gHm3NOVRiW7YYyg4ysiluKz/8/8nwAFk6/jCJ10dHPPwafezu3XEHF/GPQx2PwfvBzZEUk3e7O1jurZUmKymwgWEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783114356; c=relaxed/simple;
	bh=2Xe0OMXeeYc9/S4+5LxR1blLhyrbF1Lgb0xGUfI7zl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g1ibMCLqtfD0dSnHABnghqviyDC3ts6UPS6a3lC0QndkU1p2fgRAR1+3H9/abZJOU/85mae/ZdFfIr6xlplUJ2z2aU+Me4/czoHLTkgI52sZlq3hZ2CqjBrGE2cbgpFgjl8mLa+6R4Kg41Ky9QA5GUCKf+VV/veD3l3yiNUxX5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+X+Ve5r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+X+Ve5r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631241F00AC4
	for <linux-s390@vger.kernel.org>; Fri,  3 Jul 2026 21:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783114355;
	bh=OKSIV0oOxnrYHCfPO5lAQhnCzHPQePBOMJ0ktW8HRY4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=L+X+Ve5rFFmAbHC8BOi+ZIIcP1cQ+6P0y9xuzBuOhkmJ2QjJzMsScrnLbDWzVOq2F
	 CDRw2e90XyAgpu6/TyMFoNgZzEENGTgomFDlUcRuJm9oewwWG9q5ETEjSU6LqIhsGT
	 RknHnNUy5yyQndrBMUliVhBzY0Qn/NmCqHjYaJCADLnWhwzXCHKOuadPuwGNjxwDtA
	 egtpUpasm4nM/6WjRe5gSPw3czVm2DxmoU+KdoEpFKeTbOVDwjgFoFvjj0A5eoNhxe
	 CvE2MRoo/X9U67HLSaLEtE3VRR7CyjJyzx+odq7ir+bVHPCL6tick8FTkJRObVbtD3
	 9rin1/KYJiA0g==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aeb11c7347so697749e87.0
        for <linux-s390@vger.kernel.org>; Fri, 03 Jul 2026 14:32:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq9FT7ARd4TNlFk3yGMgRRT2XY4mR99DMqMYwjyyfdIvjssbcalQuGRAo315OHfzU8Sou3xwTlEgwD7@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/audCoxNigW+EEIxqquh+eQXybK++0nFLnvuCS05NvRxTZ9Q8
	UFHuJbno63Qc9lYbH2AffeG/xqOS87UXDiQPflemhwIpfF0a7osmN/96elaG6hpScGpVjTCL0Qq
	1AGKjZhieIpzZD8XrZyQ2Clr7VQcxPMI=
X-Received: by 2002:a05:6512:8391:b0:5ae:ba2b:b469 with SMTP id
 2adb3069b0e04-5aed5092745mr72984e87.18.1783114353971; Fri, 03 Jul 2026
 14:32:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629130616.642022-1-ruanjinjie@huawei.com>
 <20260629130616.642022-2-ruanjinjie@huawei.com> <akdp6GAu77-ipsXA@kunlun.suse.cz>
 <87cxx4mmim.ffs@fw13> <akeIK5TRCjlKbzbp@J2N7QTR9R3>
In-Reply-To: <akeIK5TRCjlKbzbp@J2N7QTR9R3>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 3 Jul 2026 23:32:21 +0200
X-Gmail-Original-Message-ID: <CAD++jLn0Pfhx0bY9XywVkDVU-nyAbvrnf9Wr8TSkuV4hgJL=8w@mail.gmail.com>
X-Gm-Features: AVVi8CegcPVBpxUBhMgaVmjHkjMbMgWpKQVd4voTgZ2p1M7BcZ7lo9TMo7bB8LM
Message-ID: <CAD++jLn0Pfhx0bY9XywVkDVU-nyAbvrnf9Wr8TSkuV4hgJL=8w@mail.gmail.com>
Subject: Re: [PATCH v16 01/18] seccomp: Convert __secure_computing() to return boolean
To: Mark Rutland <mark.rutland@arm.com>
Cc: Thomas Gleixner <tglx@kernel.org>, =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
	Jinjie Ruan <ruanjinjie@huawei.com>, oleg@redhat.com, richard.henderson@linaro.org, 
	mattst88@gmail.com, linmag7@gmail.com, linux@armlinux.org.uk, 
	catalin.marinas@arm.com, will@kernel.org, kees@kernel.org, guoren@kernel.org, 
	chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, 
	tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com, 
	deller@gmx.de, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, ysato@users.sourceforge.jp, 
	dalias@libc.org, glaubitz@physik.fu-berlin.de, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, luto@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	chris@zankel.net, jcmvbkbc@gmail.com, peterz@infradead.org, wad@chromium.org, 
	thuth@redhat.com, ada.coupriediaz@arm.com, kevin.brodsky@arm.com, 
	yeoreum.yun@arm.com, song@kernel.org, james.morse@arm.com, 
	anshuman.khandual@arm.com, broonie@kernel.org, liqiang01@kylinos.cn, 
	pengcan@kylinos.cn, ryan.roberts@arm.com, yangtiezhu@loongson.cn, 
	sshegde@linux.ibm.com, mchauras@linux.ibm.com, austin.kim@lge.com, 
	jchrist@linux.ibm.com, arnd@arndb.de, thomas.weissschuh@linutronix.de, 
	sohil.mehta@intel.com, andrew.cooper3@citrix.com, jgross@suse.com, 
	kas@kernel.org, x86@kernel.org, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mm@kvack.org, linux-csky@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2026 at 12:00=E2=80=AFPM Mark Rutland <mark.rutland@arm.com>=
 wrote:

> Bikeshedding below; sorry.
>
> I think the bigger problem is just that secure_computing() is a terrible
> name that does not express the intended semantic -- it's not clear
> whether "secure computing" means "seccomp permit the syscall" or
> "seccomp is enabled and some special rules now apply" or something else
> entirely.
>
> If we're changing the return type, it might be worth renaming the
> function something like:
>
>         seccomp_permits_syscall()

Yeah that's way better, let's do this.
(I also had problems with this function!!)

Rusty Russel's API design manifesto tells us to do this:
https://gist.github.com/mjball/9cd028ac793ae8b351df1379f1e721f9

Yours,
Linus Walleij
