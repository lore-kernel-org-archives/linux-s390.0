Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AA13F39D7
	for <linux-s390@vger.kernel.org>; Mon, 27 Jul 2026 10:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785149552; cv=none; b=FvKj7cCxgO+XrJVctjL1pYNddTyUak3nur9jJtQsmOsxtzGyVVcunO35bMjpjI0esa3pzWIEYjpJfyS/+yyH4U4IoJ3rYxQjCARo1hvfKoXV75JFJqfSVpv6NaobWGHr7JP/pbV1xB5LUO9K26l55a4vdBOsafr9+Fz0gbtYXm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785149552; c=relaxed/simple;
	bh=RA8Eld6Gp9RNlTt7BEGEVH+8ifcOAiZ+FBnnQND9LDY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E7azqY7ORkiPyEzSoZmPlVzKJTOW6voE2I2tzY5a+IykCT9rX6lOV+xfKRdn0fF0OOAw13wvvCAvCxhPR02kDArE7mxbZwGy01OVLvklUwHA3TMeAPGj+AYAW0x2xtJeB7QhJLj0aMk0godEfIkh6CSM5qAuqgh+YzJkB1u0Vns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5dsWZKa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5dsWZKa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BCC1F00A3A;
	Mon, 27 Jul 2026 10:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785149550;
	bh=YTBiDEAETut8Zjo89u5Pz7wD1cKbXJ6od1uw7Dg2Ljs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i5dsWZKakelrXgPso++0+W0WUGo8m/VGi/eAu9w4j+X+8g2Wf8dipI+PBmbTj10vM
	 1uWQwyVyCU9YPluLgEKZmcD/AAyq4TtXMaZ6/JVsFPY+5u56uwUXVucYacP4kKewVC
	 oPJiSOXdCGGhbStHCZdyY6Pyonl482BS9iiGFGBy4cIezTFI2pSL9PcT7AtzABlZyh
	 /mNVSQIn9/OIVDDdylRGAmF067MfBlby5bEmVGxvi5Aoz7DXDg5H7T2P8tMSohFVGm
	 ZII6VvV27BJf/h0Q9a3kkuZhX9Bt0YD4fYqB1OJi+y6uhHmiOAJvxBA3mUso3IuSlx
	 ICdH9NxUAq6WA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] s390: Implement arch_do_panic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mete Durlu" <meted@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260727-arch_do_panic-v2-2-4e25ceb05075@linux.ibm.com>
References: <20260727-arch_do_panic-v2-0-4e25ceb05075@linux.ibm.com>
 <20260727-arch_do_panic-v2-2-4e25ceb05075@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 10:52:29 +0000
Message-Id: <20260727105230.45BCC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Moving the s390 on_panic trigger execution to arch_do_panic() caus=
es it to be completely skipped if a non-zero panic_timeout is configured, s=
ilently breaking hardware crash dumps.
--

--- Patch [2]: [PATCH v2 2/3] s390: Implement arch_do_panic ---
commit c54479b24863a9224f8701eeac5365ad207e8313
Author: Mete Durlu <meted@linux.ibm.com>

s390: Implement arch_do_panic

This commit moves the s390-specific panic handling out of the panic_notifier
call chain and into the arch_do_panic hook. The stated intention is to
allow the generic panic_timeout to take precedence over the architecture's
user-defined panic behavior.

> diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
> --- a/arch/s390/kernel/ipl.c
> +++ b/arch/s390/kernel/ipl.c

[ ... ]

> @@ -2115,7 +2115,7 @@ static ssize_t on_panic_store(struct kobject *kobj,
>  }
>  static struct kobj_attribute on_panic_attr =3D __ATTR_RW(on_panic);
> =20
> -static void do_panic(void)
> +void arch_do_panic(void)
>  {
>  	lgr_info_log();
>  	on_panic_trigger.action->fn(&on_panic_trigger);
>  	stop_run(&on_panic_trigger);
>  }

[Severity: High]
If a non-zero panic_timeout is configured, vpanic calls emergency_restart
which never returns.

Since arch_do_panic is invoked at the very end of vpanic after the timeout
logic:

kernel/panic.c:vpanic() {
        ...
        if (panic_timeout !=3D 0) {
                ...
                emergency_restart();
        }
        ...
        arch_do_panic();
        ...
}

Does this mean the s390 hardware dump logic here will be completely skipped
instead of taking lower precedence? Could this regression silently break
crash dumps configured via on_panic=3Ddump when a generic timeout parameter
is set?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727-arch_do_pa=
nic-v2-0-4e25ceb05075@linux.ibm.com?part=3D2
