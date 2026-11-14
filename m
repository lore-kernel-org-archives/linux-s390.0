Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662563;
	b=loz0jOvoQqcvn9bC/A8kiyje32dYnmUB1DaS5qVvG1z72jVssd1VJlsahOC18i3o67Ls
	 sGRMg/bH1je7xua3ua+NM8Z1bSG7A2D4BpkrP56OVcWdNyKxOiJfqgWFnwyEy+8NWNzSc
	 4aUgq2fE2yUn8fArcOIUMPYVz34YAn3O/q6rfyafHXU2Nzn0YG8cvIV7NPmVZ2AtbYXyC
	 BvDIbU1rf9AQxDCPLGpCrnO4O951SJQxJSHFdAXN0MUUREjaySa2V/Exud9JMnrNA0PHq
	 4MQ0GfL56wDHRPJpZ4FgB/s4lZ9o7C/uXBEHM4KF1ZesEFoAI5oSf+Bd53BKkLxkyNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662563;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SrO4s05WokXvookpu3lN1QaiwwkDf15drEILclzdVxc=;
	b=VfJey8cVuMyx/t1nni+jqhsku7d4YCKfKGjUirSGaV9ISCE7i4+me2OArfrt3KhXi5zo
	 5m4FZYpcSwMbz+9j6MznJih+KW8oK4JKg2iy3Xm7IKitqCrwP4qQbXF0qR1EqCJxWF5AH
	 efpln40mYfnxysiQGt8kF5G5TUbHl6/vEr9iJ5jB2tpy4xaiYGL6G099UkCxlW4hAeGIw
	 Y3J3+uH4AUo2Gk0mGSB+oh0p3uPk6subiMTV3JFGDiMnjKh9e9qtbaKgTTQKxu4u/0dC8
	 4vdIy3vFitwd34fNtnKDz2F1HiZpNB8PXYMump0eiiqk+hiPpR+A5RSxYN68ilroMBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M5yUxLaw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E72606A333;
	Sat, 14 Nov 2026 13:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M5yUxLaw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E16671F000C4;
	Sat, 14 Nov 2026 13:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794662563;
	bh=SrO4s05WokXvookpu3lN1QaiwwkDf15drEILclzdVxc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M5yUxLaw9A5nf3YL/cPXnH1QEF54C7emNxBnXIHcSyphr2O8WaG1e/QxmFBET2z1T
	 CQjbN+bOKx/N/1aJWIuW3GGbDYo6fX0xoZocO16eJe/MjDT0NBOztnDndVY1YWPBra
	 6+p4npdIVNllDJM15x3pwEsVVocIw0JD1att7eAoyeMQUS5HEuW1dBB1RMZbSEOw1M
	 tNPvot93RaPLDqhKbogK2cjEDntlM8Mfh4yYP21AxnCBMb+HBpTnK6cM63xn6ZbVV0
	 YzdLSrG8lkpJTreRdjqdahADPTlXwdzXsfMe+t6z4J0UUY4sxG3yIV1TwefGjvIKtR
	 /4IyQHM8MLHsw==
Message-ID: <sashiko-outbox-214558@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 17/42] securityfs: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261114-work-loop-pseudo-v2-17-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-17-98639a2286fb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:22:42 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize securityfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. securityfs never holds executables or
> device nodes.
>=20
> AppArmor puts a .null device node into securityfs but only ever opens
> it via dentry_open() which doesn't care about SB_I_NODEV.
>=20
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-work-loop-=
pseudo-v2-0-98639a2286fb@kernel.org?part=3D17

