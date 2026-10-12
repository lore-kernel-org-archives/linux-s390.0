Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5431D455605
	for <linux-s390@vger.kernel.org>; Mon, 12 Oct 2026 08:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791794466; cv=none; b=HdX7pUyagiMHYOUlrR9gDH6OOOLR1TvVW22ThG7Tt4yGqdswdu4rZKg0k+JTzaE0QSp2TgO9LZPiVpoNwNVO9oLwmt+6GsKBxAoXAxcpyytBpQqoT5an7wtJ26L+Sd+qxUvnILrUCPsMQmwYZ6x7uNZuuNtqN8Vv0xENC8dFZwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791794466; c=relaxed/simple;
	bh=RcJg1C4Ms3jjb274VpOoc6YVQ1dWjRp2way/Ox+QU3o=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=jjAiBy3ARoZ/HTrMK6qDaCRYlpRVnEhlWrJytUQZYrLKhlfcALvgwImCyy14xS9eYAldcKMu1zTgEfD1zNRedwU2FPfQt4M7S9FIdzaGUbmdqL64rVz9rVrE6EtvqglC7mIlsY11GwgBYFz1eEEv4iXVcSSr2A1CbVhIFuYDLgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xo1Mj1Y5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xo1Mj1Y5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9CC1F0089B;
	Mon, 12 Oct 2026 08:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791794465;
	bh=RcJg1C4Ms3jjb274VpOoc6YVQ1dWjRp2way/Ox+QU3o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xo1Mj1Y51uamJLgfFLMdX4aXsvlx6mzW0DZYmn0pmPlHhvX8sGU4vdC7KGHIgkir3
	 WtwfJOSiKuO5QZ03pcBApHTZ8ziEFJTznH06WoVfxSA8NIvKMmrQgTgvJ/PU9rZN8H
	 ngyJr9Nb+cC1i9MEDA2JXH3a/2QQ98YA634dR2ivWB8HADFMBtzC8cXPO7ZDEYzOvN
	 8MBFxXSEhwed8rfUeeQtHzaM90QcDaKOqZNeUo+cvMaWyHTHurqkV+6C1TuAdNrdzN
	 pmbk/8zOvlASI15X4Df3no3qStm95vT13uiD+4pHXTm/QJQdgKdozx5G0n57UTn2fw
	 YEWfQZXug+7QQ==
Message-ID: <sashiko-outbox-167855@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] s390/probes: Fix wrong opcode for cgrb fixup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20261012083629.2109206-2-hca@linux.ibm.com>
References: <20261012083629.2109206-1-hca@linux.ibm.com>
 <20261012083629.2109206-2-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 08:41:04 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The last byte of the cgrb instruction is 0xe4, however the probes code
> compares against 0xe6. Fix it.
>=20
> Fixes: 6b169ac9b434 ("s390/kprobes: add support for compare and branch in=
structions")
> Cc: stable@vger.kernel.org
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012083629.2109=
206-1-hca@linux.ibm.com?part=3D1

