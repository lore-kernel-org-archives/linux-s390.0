Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99D4375F7B
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 07:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788850839; cv=none; b=u7Akq2+kkU3mmPoxDCRchHvilBXTW+6u6WTBjA8ZaC7U7qTC75oaq82CSRQ7N/cCJX/kvIWvzENKGZib8sS9JquzjDBX4zV4aDz77M1BEMrevax69sXn2Ot7ECM/K4HbHWyh3iPn15AkLQFegCWfWOqp7efitAYJ69jb0KXjk5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788850839; c=relaxed/simple;
	bh=cGhgzkDWJbMY1t6RPmy90REjOc7zDAnjc0WPCdlQqLA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YJExmFUsB3TzGIK9pZiHzk0qtee2imdlAdDDTQHSJoTcwZbaJiyqTyDtLYiIlMo/Dszy16CrJRW8gHZT9Xa8iUMZjWnqd8MQ4ZQIQXZ4gyhscQds7pCCitOXskcpr+vQQkygMvVYuKsMquQNzN2KG/g8qn0eLu4v9b7oZ8510zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1G+mxmv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1G+mxmv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73541F00A3A;
	Tue,  8 Sep 2026 07:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788850838;
	bh=GIn0kxlrUTsvDAlw8GQdmT43DIfKI3hw7w6k89vSwUA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E1G+mxmvLA9d8eViMeIXiQjbS9j9gC6TJfA/U8JSL+PsOamJM1Fiq1qgltEQJdJRw
	 330iD5Zc8H0UYmYgcZwV8rwzZHaRuo69UFE5A1RMLByXQ1zMAo8rLxZxp5vby8pPjK
	 nlzFJRt9tZQchcaNAutwA5UA/8K/FzP4RMe4vdRDoYNw3b7XDqwZtJvLa3wxjSmc+A
	 h64uqKOkiJZCxt1vkxRoj6dcek198Di9OG2nc5Mb0LrXb1rp2GH1aYjz+cXFbjzaMY
	 xDHENUn1O8wWiwJl3lCQn4f5R2B8WqX+7N10OHhGSh6E8Q0DC8lTcjiTeaxsJYiS9a
	 kj0tyCdgxAKgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 13/24] x86/vdso: Enable the vdsocheck tool
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, ojeda@kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260908-vdso-absolute-reloc-v5-13-3a93791af1cf@linutronix.de>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-13-3a93791af1cf@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 07:00:37 +0000
Message-Id: <20260908070037.B73541F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The AllowedRelocations list for EM_386 is missing bindings::R_386_P=
LT32, which can cause valid 32-bit VDSO builds to fail.
--

commit d74c76b651e13f383612ff619529355d8cc73129
Author: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

x86/vdso: Enable the vdsocheck tool

The vdsocheck tool validates the object files and final .so library
and detects incompatible relocations. This commit wires it up for the
x86 architecture.

> diff --git a/lib/vdso/check/vdsocheck.rs b/lib/vdso/check/vdsocheck.rs
> index f4c0730bc976d..1174d896a68b9 100644
> --- a/lib/vdso/check/vdsocheck.rs
> +++ b/lib/vdso/check/vdsocheck.rs
> @@ -34,6 +34,20 @@ fn is_ignored_section(&self, section: &elf::Section<'_=
>) -> bool {
> =20
>  fn allowed_relocations_for_machine(machine: u16) -> Option<AllowedReloca=
tions<'static>> {
>      match machine as u32 {
> +        bindings::EM_386 =3D> AllowedRelocations {
> +            in_object_file: &[
> +                bindings::R_386_PC32,
> +                bindings::R_386_GOTOFF,
> +                bindings::R_386_GOTPC,
> +            ],

[Severity: Low]
Is the AllowedRelocations list for EM_386 missing bindings::R_386_PLT32 her=
e?

The vdsocheck tool validates object files during the kernel build. If a
compiler generates R_386_PLT32 relocations for local function calls in PIC
code (which is common in many GCC versions), the build will fail because
this relocation is not in the allowlist.

For 64-bit VDSO (EM_X86_64), bindings::R_X86_64_PLT32 is explicitly allowed
just below. Additionally, the kernel's relocs tool treats R_386_PLT32 as
equivalent to R_386_PC32 because it is a standard PC-relative relocation
emitted by GCC for function calls.

Could omitting it from vdsocheck cause spurious build failures on valid
32-bit C code?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-vdso-absol=
ute-reloc-v5-0-3a93791af1cf@linutronix.de?part=3D13
