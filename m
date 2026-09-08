Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE11346ADB
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 06:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788850016; cv=none; b=LFr7Ei3LD9pENVGzWIHlKfWTW4qJVR8+k5jOCQCQmWl1t4FFkC/AkrjMa4XXsmzOKoP7RntHbJjzkwhIxg+3l7oySHC3K3O3zHcWll5FC2WzTPABy2bRZ6u4MgqLgBOPSEBVwjmc/+V2gPJLoT+c3X7FiZ+OLTlv2sVtebpwjyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788850016; c=relaxed/simple;
	bh=5GD4F/nkwyRsvSt0G/a6mGCSqp5CfW12QCfEEIyGTKw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NfdkKV0NlpUhjWMpjn6rlgICQj4iDDuW8wtCH/Ien+gDeE2ndVzB+utcq7FXITECnubqK6HxoQOMnTzGVPJIGFJ6AuAGspLx8TdrePBtfJ9VjW+Iivr5yoJRTBqYx/RFzp3HJkqC1MnpGshI2Sb2F9Klf1y49hHqNVKdksjt7iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMWvS4pQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMWvS4pQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1E81F00A3D;
	Tue,  8 Sep 2026 06:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788850014;
	bh=BartsO94Dbh6b+uIeVYo8OdQ9aFWsDZYIpUh2yCoVKQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kMWvS4pQuSaoTwqvY6FOw/nHte8/SB2rSPILP1/5l5bNWw3oqB43JjmxgK0PdGn/P
	 eeYZFkAP9HDBQ3FXlFh7w3hJrGc8EKoo6e2EyNKxS/ISeU+DyEwB5JHiV1vz7lh3A6
	 SRRDMLtcBVvyVagYVcGxaWu7GR9xay5MixguK5D3oG8C1dpWhD29SGxMahBsC+JWJU
	 RIx2tJUbFIKn7xb6kEcRPng64vZq4SqS0hHq/mSLhFXchQoM8zsnGuMPT5UPhr+wWR
	 8q9qzwSHdrpu9h4zd63h3CYPlp9Tq5QBO+FcgfnJz7WHbI+E3zNgJ50bo9bfp2t9n0
	 +qfDqF3EP7Wrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/24] x86/elf, um/x86/elf: Move relocation constants
 to UAPI
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, ojeda@kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260908-vdso-absolute-reloc-v5-2-3a93791af1cf@linutronix.de>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-2-3a93791af1cf@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 06:46:53 +0000
Message-Id: <20260908064654.5E1E81F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Exporting R_386_NUM to UAPI creates a macro redefinition conflic=
t with standard userspace <elf.h> and provides an artificially truncated re=
location count.
--

commit 04f5ee349c07c0271a15b30572253e0eef4d906f
Author: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

x86/elf, um/x86/elf: Move relocation constants to UAPI

These constants are useful for cross-platform userspace, for example to
process ELF files during kernel cross-compilation.

Move them from the kernel-private architecture-specific header to the UAPI.

> diff --git a/include/uapi/linux/elf-r.h b/include/uapi/linux/elf-r.h
> index 2c382c8a4807f..45a160ecf4057 100644
> --- a/include/uapi/linux/elf-r.h
> +++ b/include/uapi/linux/elf-r.h

[ ... ]

> @@ -2,4 +2,38 @@
>  #ifndef _UAPI_LINUX_ELF_R_H
>  #define _UAPI_LINUX_ELF_R_H
> =20
> +/* i386 relocation types */
> +#define R_386_NONE	0
> +#define R_386_32	1
> +#define R_386_PC32	2
> +#define R_386_GOT32	3
> +#define R_386_PLT32	4
> +#define R_386_COPY	5
> +#define R_386_GLOB_DAT	6
> +#define R_386_JMP_SLOT	7
> +#define R_386_RELATIVE	8
> +#define R_386_GOTOFF	9
> +#define R_386_GOTPC	10
> +#define R_386_NUM	11
                        ^^

[Severity: Medium]
Will exporting R_386_NUM to UAPI cause a macro redefinition conflict with
standard userspace <elf.h> headers?

If userspace includes the system <elf.h> along with this new <linux/elf-r.h=
>,
it may result in compilation errors due to conflicting values for R_386_NUM,
or it may cause ELF processing tools to use an artificially truncated count
(11 instead of the 40+ typically defined in glibc).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-vdso-absol=
ute-reloc-v5-0-3a93791af1cf@linutronix.de?part=3D2
