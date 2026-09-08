Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D954318EC4
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 06:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788849893; cv=none; b=tV7ptjlqBbNtdNOUQz0HmeLTWBan8t1icdmEPrEXp5DKkGw+hOYo78elKWQRtuFvQkSRZNqc7PxE13NgpMvrc15YDH8lNCi2J/Lz8dRrZ8ZiGrtpy9wal3KbxnOkzALPIJONbkUm1w59UpPyD3KJGXBf13birU3PBFJ5lFlqJG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788849893; c=relaxed/simple;
	bh=dlEySVZcmFwlghqN0LQJWdwWr996tcXwR99scS1o6/g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KmTIIJz96cZD7br4dS5ap8KlfvOM69QhwR4SPedRW1OnN9CsW1pAAzcEmoUVp9lq+pFqQyJUol7Q21ep0dQ49ff/c0N/q8VqMxh3j3WkUVv46SqgYEmW7MgUZ46WWPlEMabkTFaBMX+nXXAaBCmgrPD6XqRPDXzB4kuK/kvCCMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLI4mAbW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLI4mAbW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538E91F00A3A;
	Tue,  8 Sep 2026 06:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788849891;
	bh=ffPMKZGxjKBfuQfIG1eoX6Q8PD6difhh+Ec6B5SWiV0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DLI4mAbW9rdaGGKYs5VdffnVeKXGWeeT0aSwX2icwVQLun/WyY0qOcWOyJdJdCm7Y
	 0ZhGUddLtMAZX5be8aMUB/JKTdz9uhQSuzGuP5+/51d5cM+6ec+zy1LD+jwQj0MmiZ
	 OFQdwDqkD8BEtD/uDlV2gTtjJ5kEkX7tVXYAOWV64b9p7cpvSpCTxAvIeQ4Do7OGIK
	 d7moAfBLJT7Q8XJmFTGg6th5wMYJ2HjHuUVvFQYGBv9ggWMUcSOXSsHICy8i00NvCz
	 lxhnlmDTA07hbGMcFRtdinaXAQQg7qYiL6axu66JoYM/S/I7gIlxU0heaJzy5IQbuH
	 AWj87yiygMz8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/24] arm64: elf: Move relocation constants to UAPI
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: ojeda@kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260908-vdso-absolute-reloc-v5-4-3a93791af1cf@linutronix.de>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-4-3a93791af1cf@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 06:44:50 +0000
Message-Id: <20260908064451.538E91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Exporting R_AARCH64_NONE as 256 to UAPI conflicts with the sta=
ndard userspace <elf.h>, causing macro redefinition errors and silent logic=
 bugs.
--

commit c95aba5e089f1a024a83cb3e067c1b0d44928541
Author: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

arm64: elf: Move relocation constants to UAPI

This commit moves AArch64 static relocation constants from the kernel-priva=
te
architecture-specific header to the UAPI. This is intended to make these
constants available for cross-platform userspace applications.

> diff --git a/include/uapi/linux/elf-r.h b/include/uapi/linux/elf-r.h
> index 001884641e770..cf931fc05afa1 100644
> --- a/include/uapi/linux/elf-r.h
> +++ b/include/uapi/linux/elf-r.h
[ ... ]
> @@ -61,4 +61,56 @@
>  #define R_ARM_THM_MOVW_PREL_NC	49
>  #define R_ARM_THM_MOVT_PREL	50
> =20
> +/* AArch64 static relocation types */
> +
> +/* Miscellaneous. */
> +#define R_AARCH64_NONE			256

[Severity: Critical]
Does exporting this internal value to the UAPI conflict with the standard
AArch64 ELF ABI?

The standard userspace <elf.h> (such as the one provided by glibc) defines
R_AARCH64_NONE as 0, which is explicitly required by the AArch64 ELF ABI.
Exposing the kernel's internal legacy value of 256 here causes macro
redefinition errors for programs including both headers.

Additionally, applications strictly relying on this new UAPI might silently
check for 256 instead of 0, resulting in a failure to handle standard null
relocations emitted by toolchains.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-vdso-absol=
ute-reloc-v5-0-3a93791af1cf@linutronix.de?part=3D4
