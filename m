Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53C7374E41;
	Wed, 19 Aug 2026 02:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787107103; cv=none; b=iyM5649Apat0GOCBLeGwbXGw0PCQ3JCiXG3dUc9V7pM5O2M7Jt++0Ug6Io/TkG7izqnz7rzhWE8GPN8jWmzldY+nX4V3ymm6IRmCTzRrHC1+gitEtdOmEAJQsifCAkrplsev2SA1jlStWguFV8L2ql0PMozZv2+l3Flo4SidG1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787107103; c=relaxed/simple;
	bh=dAPDnJodTNfRsv3ZShdBGG0kvVW1OP6hbIXhn7Ch86k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lhq0dNhnSwCRtJa85kp3HKraHIG8U7v47gdbIinRCs/0mntLRPL/8mPVM/GXwziENw+HQcZFdv9toB/5CGjW/fPQMv3wiWxsGSq3+wfQK/tgLOgNLD77KqQ0n3TWMLUxJOR9qjeAd62ml6gyFnbWfEcTalUeT91Dl/OO6WzHwh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sz9viCCk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sz9viCCk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 215791F000E9;
	Wed, 19 Aug 2026 02:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787107102;
	bh=dAPDnJodTNfRsv3ZShdBGG0kvVW1OP6hbIXhn7Ch86k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sz9viCCkvHxviNE6Vo7hUifr1qUTnKE2v4EC7rpm1HUbw+COMNRjQ0NIfIyJ38UM0
	 P0Oljp56yzf3jSDEY/o+XxbOt53EbCmPGlWjpgchCTVnIkh0xz3jfjKriy+ry1dUZG
	 dWKnHr8aC1B9f+CVbUZonEAqRoxo90tfFbUCd2FC+aUC2CM5czZDBiH3DBbnHlK2ED
	 jqd//G6qZVk/SCHsfcv7/4a7QlqC6zDqMc/kE1I6CnUbGaCq5CxcxlyF7xRw4N8mVI
	 PZ8dncnEFro2qQ82LDhCU/cn//L/ZA0n+CO19SZCD+yr3CsMVOoNWF7MpurYHR9qjS
	 FHixyDNc8gE6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 11/13] sysctl: unrandomize struct
 ctl_table.procname
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mauricio Faria de Oliveira" <mfo@igalia.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, bpf@vger.kernel.org, mptcp@lists.linux.dev, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260818-sysctl-module-aliases-v2-11-d5a69dae5798@igalia.com>
References: <20260818-sysctl-module-aliases-v2-0-d5a69dae5798@igalia.com>
 <20260818-sysctl-module-aliases-v2-11-d5a69dae5798@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 02:38:21 +0000
Message-Id: <20260819023822.215791F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The 'struct ctl_table.procname' field (sysctl filename) cannot be accessed
> by scripts since it is defined in kernel headers (see "don't include kern=
el
> headers into userspace" in file2alias.c) and its offset may be randomized.
>=20
> Unrandomize '.procname' as the first field so its offset is always zero a=
nd
> match the 'struct ctl_table' symbol address, which can be found by script=
s.
>=20
> Originally-by: Mauricio Faria de Oliveira <mfo@canonical.com>
> Signed-off-by: Mauricio Faria de Oliveira <mfo@igalia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818-sysctl-mod=
ule-aliases-v2-0-d5a69dae5798@igalia.com?part=3D11

