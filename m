Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5B237AA70
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 06:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788849840; cv=none; b=F0rds97n6RS3bODncj3RVP4jMX1VrSCin+9DLdy8LLmnDriCEr4cfszDhw8karVwGQJ1ro4QHQbixj071sTy5V21jzmAsOdYATmB+1mHfhCDMjkFXD4X8ojTbVBZ8lYbV0TOWk4c4IuEYQAXsUEoKvlY0YhDcChIgxEqFsifSJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788849840; c=relaxed/simple;
	bh=dcOv/qH5I+WuhRvVoJtUm3X///NaX5hbSf2We77K4tg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TapjxuMMHfBFZqTUpCbzHkaW+NOnqgRKtREm080fFasTgba/mkQ1FqejA0SBEAYi+KDQq4rzQsB53ZdgVUGhwo97IvDUL0EgyORtpWPy4j1/H2Riyw0sOpjCWG+YeiY3tuBCbbHk486Y0zFsjJd9207fDUaTlR+00eITzKVavDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHs1cP1E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHs1cP1E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953D91F00A3A;
	Tue,  8 Sep 2026 06:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788849839;
	bh=FyaNp+k/WnbjnI3Ies0ifjPIEtz5+U8l0DJSIkt1eFs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nHs1cP1EOtcqB1vMOdXIVgEVztV70ICVEAckymkVVGQqxfgbO5NrG+XrszbiJ4vS7
	 U+222HTWRRsA6rD9VrwiMct/OjFFfi4gjr+rOWYYj0uohRb1uqOsXldlMbqPzomXaY
	 ckyqFidVZnxYaPtZ/TEy+XSUmipztT/VLEZsVNZ4O2/E9qtmRBcfTT+huW/y45zcSR
	 EcW1x1AG6HzBc5F9oSkxPmjamQF6HiJ0zoRYGg8JtDTvJnBVI4+LpigvJMAE+bDczN
	 NwwyDwL+p9xeiYgClBH8VHpM8vHr9p9G5PUvqSxtjjqUyO71BQsq5QAVl7bL/1Woxn
	 o9ZyUYatRL/vA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/24] powerpc/elf: Move relocation constants to UAPI
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: ojeda@kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260908-vdso-absolute-reloc-v5-5-3a93791af1cf@linutronix.de>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-5-3a93791af1cf@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 06:43:58 +0000
Message-Id: <20260908064358.953D91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Removing PowerPC ELF relocation constants from `uapi/asm/elf.h` =
without providing a fallback include breaks backward compatibility for user=
space compilation.
--

commit 329aaa1bbce8cdbdd0158227a5a1193c91112b27
Author: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

powerpc/elf: Move relocation constants to UAPI

This commit moves the PowerPC ELF relocation constants from the architecture
specific header to the common include/uapi/linux/elf-r.h header. This aims =
to
make them available for cross-platform userspace tools processing ELF files.

> diff --git a/arch/powerpc/include/uapi/asm/elf.h b/arch/powerpc/include/u=
api/asm/elf.h
> index a5377f494fa31..aba921b8249a2 100644
> --- a/arch/powerpc/include/uapi/asm/elf.h
> +++ b/arch/powerpc/include/uapi/asm/elf.h
> @@ -17,78 +17,6 @@
>  #include <asm/cputable.h>
>  #include <asm/auxvec.h>
> =20
> -/* PowerPC relocations defined by the ABIs */
> -#define R_PPC_NONE		0
> -#define R_PPC_ADDR32		1	/* 32bit absolute address */

[Severity: Medium]
Does removing these constants without leaving a compatibility include break
backward compatibility for userspace builds?

When a userspace program includes <asm/elf.h> and references R_PPC_* macros
against the updated kernel headers, compilation will fail. Should we add an
#include <linux/elf-r.h> fallback here to maintain the exported API?

The commit message also notes moving these from a "kernel-private" header,=
=20
but since arch/powerpc/include/uapi/asm/elf.h is already within the uapi=20
directory, it is already an exported userspace header.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-vdso-absol=
ute-reloc-v5-0-3a93791af1cf@linutronix.de?part=3D5
