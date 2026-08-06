Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C58F23E33D
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 06:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785997566; cv=none; b=WaoYyUHbZ3ND+eJH1I66+y2xIWq3RFBAShuQTn8+y0GdOTQ4BlFafi78qlXgrItdxpa7/6HVOPyo1suhgg9j8HtEMk0IV6u2/L40V+3i0vd588cD9VhLtAw9CbsgdpqtWAgCLQJTms6npyBvfwZP2dCdonAyEclTS7dD7pf5gvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785997566; c=relaxed/simple;
	bh=m7Fv8mnbtZ87cY0PBSOlUqm3XrtlpSOh8ifv0AO1yq0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q/auhXwuJ2VZDgPAxnSJ1KPpYMoUo3JDOq0OBZsJoLm1wNmyNNER+QaCyppAauutHZZvifHsThZAAWMoxNqzJsWiLZWFTWcBNTWzgo3iaGjyXyS1RSuQo/RTwLfKgFSh9hmRkIhF3FSRjb0suRM+NM7NLY8xSy8zaD7kpDbl8BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdgrkBJR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdgrkBJR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A9F1F000E9;
	Thu,  6 Aug 2026 06:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785997565;
	bh=g9pHA7gZjTnpcrSk6f47LeVTM/JwjqmnRAn+clKrXdY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JdgrkBJRJyhd5IrDkvntERcAUlR3ZKiY6CId5sV10z8Y1FXu1QYlTRHY2IyarDgdR
	 qec499pQ0OX6gRbArnANpYksojQZ538tmMfQDF9YTfHFOq2B/IEXI6YnNzTUXMIcnK
	 Z4x0zQGoSIIqyeYoreRHdSActWmNFQUG9etN/OF0aNgFN8Eeu2/gMtI+kus9U+MYVu
	 4YSUlFV6wIId141KvavWGbKlTYBhsYQzSOPEQt7klA8hnZqEVebeN3pFrg1sdcdzZA
	 fw/Yww+6Ae+A5udzh/wLSU80XePrW2/1IGgGUSmtMxwvCMgWUh7v8P6iVGkTW3MItb
	 l45FJU2AoalQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] init/Kconfig: generalize config COMMAND_LINE_SIZE
 to all architectures
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wilson Felipe Pereira" <wfelipe@google.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260806061429.474992-2-wfelipe@google.com>
References: <20260806061429.474992-1-wfelipe@google.com>
 <20260806061429.474992-2-wfelipe@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 06:26:03 +0000
Message-Id: <20260806062604.76A9F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Moving COMMAND_LINE_SIZE to init/Kconfig removes the minimum size =
limit of 896 bytes for s390, allowing legacy bootloaders to overflow the pa=
rmarea and corrupt the kernel .text section.
- [Medium] The newly introduced COMMAND_LINE_SIZE Kconfig option is silentl=
y bypassed and acts as a placebo for all architectures except s390.
- [Medium] Making COMMAND_LINE_SIZE globally configurable via Kconfig confl=
icts with its static definition in userspace-exported UAPI headers.
- [Medium] The Kconfig default definition for COMMAND_LINE_SIZE references =
the non-existent symbol 'UM'.
- [Medium] The default value of CONFIG_COMMAND_LINE_SIZE for RISC-V is inco=
rrectly set to 1024, which is a reduction from its existing hardcoded size =
of 2048.
--

--- Patch [1]: [PATCH 1/3] init/Kconfig: generalize config COMMAND_LINE_SIZ=
E to all architectures ---
commit 331242b120be7dde8a2decc92398462a27944ed5
Author: Wilson Felipe Pereira <wfelipe@google.com>
Subject: init/Kconfig: generalize config COMMAND_LINE_SIZE to all architect=
ures

This commit moves CONFIG_COMMAND_LINE_SIZE from s390 to init/Kconfig to
allow all architectures to configure their maximum command line length. It
also sets default values intended to match the existing hardcoded sizes.

[ ... ]

> diff --git a/init/Kconfig b/init/Kconfig
> index 5230d4879b1c8..c581817966ee2 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1566,6 +1566,18 @@ config BOOT_CONFIG_EMBED_FILE
>  	  This bootconfig will be used if there is no initrd or no other
>  	  bootconfig in the initrd.
> =20
> +config COMMAND_LINE_SIZE

[Severity: Medium]
Will this Kconfig option actually be used by other architectures?

For example, in arch/x86/include/asm/setup.h, COMMAND_LINE_SIZE is still
defined as a hardcoded macro:

#define COMMAND_LINE_SIZE 2048

Because the C preprocessor will continue to use the hardcoded macro rather
than the CONFIG_COMMAND_LINE_SIZE Kbuild variable, won't any changes made
by users in menuconfig be silently ignored on architectures other than s390?


[Severity: Medium]
Furthermore, does making this globally configurable conflict with its static
definition in userspace-exported UAPI headers?

Many architectures expose this as a hardcoded constant in their
include/uapi/asm/setup.h headers:

arch/arm64/include/uapi/asm/setup.h:
#define COMMAND_LINE_SIZE 2048

Since UAPI headers cannot depend on kernel build configurations (they do
not include <generated/autoconf.h>), if an architecture maintainer tries to
fix the bypass by replacing the hardcoded value with the Kconfig variable,
wouldn't that break the userspace ABI for tools like kexec-tools which rely
on the UAPI header?

> +	int "Maximum size of kernel command line"
> +	default 4096 if S390 || LOONGARCH || MIPS || UM

[Severity: Medium]
Is UM the correct Kconfig symbol here?

The User-Mode Linux architecture uses the config symbol UML. If UM
evaluates to false because it does not exist, won't User-Mode Linux builds
silently fall back to the incorrect default of 512 instead of 4096?

> +	default 2048 if X86 || ARM64 || POWERPC || SPARC64
> +	default 1024 if ARM || PARISC || RISCV

[Severity: Medium]
The commit message mentions adding defaults to keep values unchanged, but
is 1024 the correct default for RISC-V?

Checking arch/riscv/include/uapi/asm/setup.h shows that the current size
is 2048. If this Kconfig option is respected, would this cause a regression
by halving the allowed command line size for RISC-V?

> +	default 256 if ALPHA || ARC || M68K || MICROBLAZE || SPARC32 || XTENSA
> +	default 512
> +	range 256 1048576

[Severity: High]
Does lowering the minimum range to 256 introduce memory corruption risks
for s390?

The previous range in arch/s390/Kconfig enforced a minimum of 896 bytes. On
s390, the command_line buffer is placed at the end of struct parmarea, and
the executable .text section immediately follows it in the linker script:

arch/s390/boot/vmlinux.lds.S:
.text : {
    _text =3D .;  /* Text */

If an administrator configures a small size like 256, and a legacy
bootloader writes up to the historical 896 bytes into the parmarea,
wouldn't it overrun the buffer and corrupt the .text section?

> +	help
> +	  This allows you to specify the maximum length of the kernel command
> +	  line.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806061429.4749=
92-1-wfelipe@google.com?part=3D1
