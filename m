Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CA0376475
	for <linux-s390@vger.kernel.org>; Sun, 23 Aug 2026 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787486188; cv=none; b=g1ZP3F+EnLmHNKWSh0cSnAMBvuIRhYXZJ+/xD7QXwiE9woSyRsxE0U1zNW5L88SiSEGrZ3aoNO70U0oWs5Yh7CccwVSa9hvtUk6iirseR30rKbh23jYwjP6VA8yLmWpGBFpr5n+BNIsW/Is0kcusd7E2AOAY0Uja/cr1fXiIQTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787486188; c=relaxed/simple;
	bh=dLP4o82gKAKSuLCdNDOTfIpvq3BvJZDZjwcp37LNvE8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rGKGyvVnhe++dbH2UI58xdvsursdqDcchwugze1E3XP+X5z80+tveTvUID9XnxCl4f+NM92NqNazES1kdZESNoYJ/Im6GVor4vQUZ+sNyPFHRIZ/FIdY71RUKeaivA19cR1Ps7mK9fhiKQfE6yrnvE+fu1eVpHY77UeedVdb5rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdS0vSLV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdS0vSLV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC0D1F000E9;
	Sun, 23 Aug 2026 11:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787486186;
	bh=dLP4o82gKAKSuLCdNDOTfIpvq3BvJZDZjwcp37LNvE8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gdS0vSLV7TP5Xc8S4nJDESrBdK4SJ7jskueTJXlZiKh9Sbsvy5IFb8cPTTrA5bPZA
	 MWKSEC9SePqlUtGbY+UUoJtEPJVgtZKEHo4zADn8NcRw8vqHXnigo/T+zChfs6KUy6
	 ErDm2zINp8Or/Vk9IWpBs8pjLPQ5vL8j0aF8qwtDnZ3foW0RVVQgNmUHhk4leugPkz
	 zrBbswaLEGgBG7qfUX8Qfl20VXJ7lUQ5pIMbjB5nhRjYxe/q6uBVmpF7imQ8Z1wTUU
	 X5s5tfCKr9IfQe1HXhU84nn0L+hk1VBLEZ37+4l5vA3qWojk0eWB4xCFPL2DpxvhC8
	 Cuz5dx7udCyvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/6] set_memory: add number of pages parameter to
 set_direct_map APIs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260823-execmem-set-vm-perms-v0-2-v2-1-b013a37d84b3@kernel.org>
References: <20260823-execmem-set-vm-perms-v0-2-v2-0-b013a37d84b3@kernel.org>
 <20260823-execmem-set-vm-perms-v0-2-v2-1-b013a37d84b3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 11:56:25 +0000
Message-Id: <20260823115626.4AC0D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When set_direct_map APIs were introduced by the commit d253ca0c3865
> ("x86/mm/cpa: Add set_direct_map_*() functions") the single page
> parameter made sense because the initial callers (vmalloc and
> hibernation) had sets of unsorted struct pages that required changes of
> their mappings in the direct map.
>=20
> Since there is an increasing demand for direct map manipulation and it
> is also desirable to be able to update larger physically contiguous
> mappings, for example an entire large folio, extend set_direct_map APIs
> to receive number of pages parameter.
>=20
> As there is still only a handful of callers, change the existing
> functions directly and update all the call sites rather than adding
> wrappers for single page case.
>=20
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823-execmem-se=
t-vm-perms-v0-2-v2-0-b013a37d84b3@kernel.org?part=3D1

