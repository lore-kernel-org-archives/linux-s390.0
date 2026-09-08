Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF67636F901
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 07:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788851157; cv=none; b=Rs3zw9DcpgSNMc5jknaR8Q4JWYlNKCit8YkM4gJJFY5RBuF9XOuJD/dOJtFppKRVd4d8IzxjAHuVPV9MG2OTVCkP4cd0InBFRyd4El9k6kSe/9lzTVbiWLD7QaUuXMmMhfdVhG9OUH9YhU+BCHlgpe3csHSyFCU5JG8FYe49uqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788851157; c=relaxed/simple;
	bh=4oG0dEHB4j9jZV/CsTLkiXtuw4qw1Ap27xuUKZdj6e0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qtWaW+SId6cnPaa+5r4AgZ2uIYpSrx0N01gsnOVzk88m0f7DWE2LYAdXNTNYjXLxuuOQBoQeID/73lkHg98K3jA8brdbSJUoLFKWDAlLZhwG8IIxayFbJhTpTi2Jolv5LMCl0q4tUml79NA5d04UQ6RlB29+Tq7Fz2MKsuQDmqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koXMDpse; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koXMDpse"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B881F00A3A;
	Tue,  8 Sep 2026 07:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788851156;
	bh=4oG0dEHB4j9jZV/CsTLkiXtuw4qw1Ap27xuUKZdj6e0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=koXMDpseYpHi3XvtgH4SvPGvEoTpYmhqllFP5MUCri4GseQbGBC5l3iFbFkuQreUZ
	 B2d13i0z7xvIlgZJ7UDqas4PWg2j9VCGG58LtahjoeIVhDYW2x4BsIdrMGv5TOdksh
	 Jomq/Fmz0ooPbSu73lQ+VVFLSY9oggMjnYUeTH8TDo/BbymHr0/lufqscenZK2WBiH
	 z3gTfx3pqrm1rDzZ7zIh8vAn2JYF7QBSBxuua17mzNxqGQwNPpRj6z9F272uZTz58P
	 nvsplCRM/tK9v7rjL8FWGYO7DF7q9RrlXXlB0ap/s88h/RaeUxesE5JHkmx49ONUak
	 kEVkBT1qsOvtA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 21/24] MIPS: ELF: Add more PC-relative relocation
 definitions
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, ojeda@kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260908-vdso-absolute-reloc-v5-21-3a93791af1cf@linutronix.de>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-21-3a93791af1cf@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 07:05:54 +0000
Message-Id: <20260908070555.26B881F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> These are used by userspace and are necessary for the vdsocheck tool.
>=20
> Also update the copy in tools/ so they can be used by vdsocheck.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-vdso-absol=
ute-reloc-v5-0-3a93791af1cf@linutronix.de?part=3D21

