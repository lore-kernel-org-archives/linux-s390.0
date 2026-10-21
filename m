Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792593857;
	b=EYbebAWjqR6qrM3MXWzxNhI7EkMx7YtcELCwEndm6j3txQjl+5eV4qrVm8AsbhHuaoaJ
	 mUITn8yAbxfv6gbVibAiTJvpVG29xtmsaWF5i9wYd6gXXu7R5Rm1MqIwOBrcaawkvv/cE
	 GkAMAcs2fZO4qdqyur7pRHENJz/b/B9bdE3WgZ3ebLSxZtz1vHwUROhidhdbBdC0c6KHR
	 by5QJYOlpHv6I1I4h9mqSOVxAO0lvFn1l/5FYKw+aAqyMrFuFs9wYUNnEOABbCYo0SDI/
	 o7hybB8Eqh1Ja/mWzjAs1oMYKKdkfPHybade8myIklRHBPlAJptMEZv1w4BdxO2aLog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792593857;
	h=Received:DKIM-Signature:Date:From:To:CC:Subject:User-Agent:
	 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Y2tC8SXoBQ3oYesXX9enzJXSSVTIvRj44fi71d4FwrE=;
	b=LMwvXdmaUkrWl5PfFM27eANAXxINmtewrYHTEC7DofOZsp5om4TfUbV31nCfw58TMviy
	 4Zp3OdIZMpcrqLq0VHzCns5Dyo1nNsb+0qfuOX9TBIOkh3G9GxsHYLoHJ0PlztNS39ZpJ
	 UvjYGsQrVhXPJ1TBfmn7j0X0eGgKPJmcqSvC78snTONIensekU62/0iwl0LO4jDkviR+9
	 EkhSRQm7mtvD+VNjyAP5lc90d6fkLGxilWcQS5bELawaTsedsuAR+zP1mv+XzhZpAYbav
	 Oo9uu293hfOYR0LxmBMvgBPGa1RtgvkE9opXJfnuTmACmV+fkmh+hqS3pLxa8gnJsbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mIa++Fwv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEDF606A319;
	Wed, 21 Oct 2026 14:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mIa++Fwv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EED1F000C1;
	Wed, 21 Oct 2026 14:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792593856;
	bh=Y2tC8SXoBQ3oYesXX9enzJXSSVTIvRj44fi71d4FwrE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References;
	b=mIa++FwvTPmXGjfM82gOimKDgCaIkFs7zuS72xRTLcZA040J5hT6CDv0UGQpaIctO
	 3VYr2B4M/x+ZVS8yxFtevloORtWaC/HA/qh79BHBLswkuh9Lj0Mk+OUSdAfhHD8MMA
	 ph7D8CK+lQeKVzE/x4Q0SYxyq7xqxGuJ0NkidTg295rQ8J9K70/Dio4h+7NApvXoBT
	 qBbZb24K498m2Tg/0zoSPp7+jl4ueKwcXdvuEVwH1hohRIEIs7ZskMkclEo06hA/sF
	 hD2Ifwq6zJcJw0ecdt758RRi7YrIazjjox6p4VbQV2uNwZNYt5393qV7HjZHIanEvX
	 BuNBnnRru6kFQ==
Date: Wed, 21 Oct 2026 07:44:16 -0700
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>
CC: Julian Braha <julianbraha@gmail.com>,
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>,
 linux-s390@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/2=5D_kbuild=3A_Move_testing_of_?=
 =?US-ASCII?Q?=27-mfentry=27_back_to_Makefile_from_Kconfig?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20261020-kconfig-fix-mfentry-check-v1-1-428258bc0fc0@kernel.org>
References: <20261020-kconfig-fix-mfentry-check-v1-0-428258bc0fc0@kernel.org> <20261020-kconfig-fix-mfentry-check-v1-1-428258bc0fc0@kernel.org>
Message-ID: <F643B506-5031-4BEA-8279-199E7E181721@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On October 20, 2026 2:52:18 PM PDT, Nathan Chancellor <nathan@kernel=2Eorg=
> wrote:
>Unlike cc-option in Kbuild, cc-option in Kconfig does not test options
>with either bit ('-m32' / '-m64') or endianness ('-mbig-endian' /
>'-mlittle-endian') flags because which flag to use may depend on the
>result of the configuration stage=2E

Oooh, yeah=2E=2E=2E Do we have any silent failures due to this in other pl=
aces? On x86 I worry we'll see similar problems=2E Stack protector arg chec=
king comes to mind=2E I will go see if I can find anything=2E=2E=2E

-Kees

--=20
Kees Cook
