Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794579957;
	b=TrT0HFGb1pGTDbGX/8teLSnmwz3fFJEZphipdS8mFCmy65x8NTv/QNIqeCVdlbX1LX6Z
	 b3RZf+ETmcnNVuA91CpFcFS098wKNz438qGrEgWGNX92OuCL1IwIH/hdqJyB7xBDEaMmI
	 kVQUFjYqyq2bKW5/LFIjfARjLOVLUh1JX66m6m0ivlnbIyErJNX7wLs0oKnqoiCoylP2k
	 xcngD5o9Zu16A/bycsgWFu8PFQU3d0MDllD+wfNBUiCSnR4qgM+WubwAPBnpFsCZcokeW
	 Ihq/95no6Dps2jFkaWIu/3Mao1iAGLFG/6fjUOKqoAbqz/xWwisj3Ie/ppnushWxqQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579957;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WAexHDbSw9xWcxSUvvupC9oApktN7GEooOnFMz2Zc7M=;
	b=l8xoEWZYixRcyEFR0VQoWgFnwP4b5d0kvofPNT9ZL6mWeJrFpvokf9D9Odb+OJvnQ7jg
	 P5o1ApDmMQIV7HWbh2VtlQKae6/WwOUzOdrnxeLgtiL5IcyhooL8qhhUHU7bMIFtw4sWX
	 qQF8PgmRW5682kazWL9oyb5qi8v6Qyaf2diU4UqmGy6K4AuEpmDfBUOgu4lq2dDXvamL5
	 XC+/Q/ylNGRkl7cu5Rb+AfImJYn5ufv9SAMTxEGih+wlLXzzlxRl/xwj/GWKBj4un2+uC
	 Sw2QsQI8oht7yS7MfUJJU0YBd3WvCcpVqpeH53+qKjyaDW9+Lsfyw6YBmsgr14KNvAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WfMoihxF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5770A606A323
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 14:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WfMoihxF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A868E1F000C4;
	Fri, 13 Nov 2026 14:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794579957;
	bh=WAexHDbSw9xWcxSUvvupC9oApktN7GEooOnFMz2Zc7M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WfMoihxFyCKWDwY9FgKkHT0DjtSLGNuAm8bNu1CklEymfD4m1VDTSMTcIAMVNioal
	 GSOlVDKGzfH47ck0biZSA7vzzvgKKJLh5ScPtEsuaUwBi4x3j/eRdKfthUycigSlGV
	 WwjdVdmdWETHCZSQ5GnDV2P3Ouvt73PCSG98zTfFjD5UEADLHLYEuLfGpZd3hKS2Mk
	 nrgUNdSmNRR3VPbqMpjp89TiCzTpmrTLgvYgSuMvWVnwKIfQDutPZg0En2bpV1NcSI
	 pISAJgGel4hSH0KfF5oG6MPRgP5BH/VCk9UOOtgUkVEx3t/v8QlPN5Eld1Bzy1xOne
	 kGbmLycyDBBnA==
Message-ID: <sashiko-outbox-212980@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/9] mm/mprotect: add MM_CP_PERM_UPGRADE
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Q2FybG9zIEzDs3Bleg==?= <clopez@suse.de>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261112142039.907090-7-clopez@suse.de>
References: <20261112142039.907090-2-clopez@suse.de>
 <20261112142039.907090-7-clopez@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 14:25:56 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Add a change_protection() flag for changes that only add permissions,
> so that MMU notifier users can keep their mappings and fault in the new
> permissions later. mprotect() sets it when the new VMA flags only add
> read, write or execute permissions, or VM_ACCOUNT, which does not affect
> the page tables. Any other change, such as a different protection key,
> is not an upgrade.
>=20
> Signed-off-by: Carlos L=C3=B3pez <clopez@suse.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112142039.9070=
90-2-clopez@suse.de?part=3D5

