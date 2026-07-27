Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B3A248F7C
	for <linux-s390@vger.kernel.org>; Mon, 27 Jul 2026 09:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785143442; cv=none; b=t8mGMaEZdf7STw0IazBSA+Ka/RIyxO2iDtovKcyYQxPcJe/bQ/b5LdwQCVYChpBiZ7GR9NBDgASPvr7F9CukccQrEQy2ObCxW537v+g4Mq+UDZK+WtWhKFUJVxbPiHPWNABJrPNmq0/TC47ETcyWI/BLOFpiY5PR714jHTwv+HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785143442; c=relaxed/simple;
	bh=mFIp3+79sn0FYkk6r755VGx8m0SgiqE2dwpo4ICKf18=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B954CB/vjjqLUHkRf2a8aMdkbOZIFhzafktoipT+IqOZqG0uw1xaJUFERI4GrppL+8eeMZ23of/zVakjgvVTvCoR9H9CV4lMsacNbBmOlv3aOTkNrDD+HZGZejx9wbKhAF5d5R8WIYpVx3r/MyeLQ9NoGSNRLGT86aFaHQrPPmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFYzZ4dp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFYzZ4dp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F791F000E9;
	Mon, 27 Jul 2026 09:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785143441;
	bh=MzRWBAYA2T8cB00SfxBlq/Y+HZYzB4UPN4vGWYebzDE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PFYzZ4dpLLnw4PCzsS2SopS+gZ0Ox8SAgNu60STnfzhQo9XcjU5fi/lSkZIVgvPua
	 Qg6agEhNYw3mPzF2Z/1bQLQUza0p7NreIPlVy2gp4jbdW95yniaqiuVJszv+7qRIeh
	 pvM9vrSGMY9cFH0PKGKWFjEwBl/kgcdXcZ8EM9vPUCEQ9OB1n9Bu4wi7ZBIurFm1Dl
	 juwtF8Kxk/aMopt2hktlEUsXCTFQeAYcdpAyhsXAoiX9Z98x3r++kOq6qe/eKnswVc
	 6bX+ccCxJhJZHhNwVkMTM6fQmb0S4yOtwFE/z+JNQDw8GHiQhRJj6oOgAfLnVumahn
	 T2i0N5DW1ScWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] s390: Implement arch_do_panic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mete Durlu" <meted@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260727-arch_do_panic-v1-2-ca1777547c38@linux.ibm.com>
References: <20260727-arch_do_panic-v1-0-ca1777547c38@linux.ibm.com>
 <20260727-arch_do_panic-v1-2-ca1777547c38@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 09:10:40 +0000
Message-Id: <20260727091040.A7F791F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] arch_do_panic() is bypassed when panic_timeout !=3D 0
- [Low] Unused declaration of s390_do_panic()
--

--- Patch [2]: [PATCH 2/3] s390: Implement arch_do_panic ---
commit 640e72aef0a165dacc87c9e5913aa8f9442aa6e9
Author: Mete Durlu <meted@linux.ibm.com>

s390: Implement arch_do_panic

This commit implements the arch_do_panic() hook for s390 to handle
architecture-specific panic actions instead of relying on the panic_notifier
chain. This change allows user-specified panic_timeout values to be evaluat=
ed
in common code before executing the s390 specific actions.

> diff --git a/arch/s390/include/asm/ipl.h b/arch/s390/include/asm/ipl.h
> index b0d00032479d6..38924c4a5d1d7 100644
> --- a/arch/s390/include/asm/ipl.h
> +++ b/arch/s390/include/asm/ipl.h
> @@ -166,5 +166,6 @@ enum diag308_rc {
>  extern int diag308(unsigned long subcode, void *addr);
>  extern void store_status(void (*fn)(void *), void *data);
>  extern void lgr_info_log(void);
> +void s390_do_panic(void);

[Severity: Low]
Is this declaration necessary?=20

It looks like s390_do_panic() is declared here but never implemented or use=
d,
as the actual implementation provided in arch/s390/kernel/ipl.c is named
arch_do_panic().

[ ... ]

> diff --git a/kernel/panic.c b/kernel/panic.c
> index 1eb0cdc159d94..de0bda946cabb 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -755,9 +755,6 @@ void vpanic(const char *fmt, va_list args)
>  		pr_emerg("Press Stop-A (L1-A) from sun keyboard or send break\n"
>  			 "twice on console to return to the boot prom\n");
>  	}
> -#endif
> -#if defined(CONFIG_S390)
> -	disabled_wait();
>  #endif
>  	pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);

[Severity: High]
Does this change unintentionally bypass the s390 panic actions when
panic_timeout !=3D 0?

Looking at vpanic() in kernel/panic.c, if a panic timeout is set, the system
will restart before reaching arch_do_panic():

    if (panic_timeout !=3D 0) {
        ...
        emergency_restart();
    }
    pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);

    arch_do_panic();

Since emergency_restart() does not return, will the user-configured on_panic
actions be lost in this scenario?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727-arch_do_pa=
nic-v1-0-ca1777547c38@linux.ibm.com?part=3D2
