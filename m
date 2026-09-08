Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A5C388E58
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 07:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788851135; cv=none; b=gnNe7eqX3Aggjp4ITSs+9zhsTgE4fR+YDEeQCYSgF7kSHpHd+yjguO/hCF6PzKoByDyrDYW3xpcw7ItoStLBpTFmG7eSBPZkFZ2SqdjCkea+DxotAMwU6W0GyLayK3mclxQDbOkarbUHadhkObSo6BdaOcFnyNbQ3jHN5cQYNUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788851135; c=relaxed/simple;
	bh=nttwzFH64fGhErHB9UI9FkoSXR2C+kSIJwbRjU7fgUA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y6pqDUd4AkAdkMW+gp3dzRCyCPeADuquWVZWKH2lfEcf/zx372RmGrawBM/yNsKJy2fj7RuY3jR4C1npbpqS73bBHd2uEgkNVaU17n8DPafUzYMNDtYAEcVwo88G6i7gn9ZhbFqwJSJxrgTvEqFT7kkQO1htkB06oGyVwuGzscE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxFyxKb2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxFyxKb2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C7A1F00A3A;
	Tue,  8 Sep 2026 07:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788851133;
	bh=nttwzFH64fGhErHB9UI9FkoSXR2C+kSIJwbRjU7fgUA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YxFyxKb2V2S6+zw+1DAmgRsAEgW1dpLCSL5LphRtVr6W8+n5unjGdfCKWOEM1qCJP
	 rEykBAZfyfWRltGTiXFijEAlQuk+rx6z/x4bt+DmvpszNIiU+rA1qBDvyn2gipXdum
	 aVBU1Lhp7hveQ1nWZjnHwffWplvLCMS3gr3z0m5dagHNipOXnN46+Is2VLnkzGf9Yg
	 P2GmROLA0n1I6HWIvh40ABwxm67EhMvBHbKCGyuUgF6RXookM5ZtnGajoz1LsxYc62
	 OmyLMZwSoEyem2ucEaRbRBpRRAL2RLox8+laSppaExJ13/ZYBqKt8mSKRfq5epXyAA
	 0beBMSaiTQoGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 17/24] powerpc/vdso: Enable the vdsocheck tool
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, ojeda@kernel.org, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260908-vdso-absolute-reloc-v5-17-3a93791af1cf@linutronix.de>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-17-3a93791af1cf@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 07:05:32 +0000
Message-Id: <20260908070533.14C7A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The vdsocheck tool validates the object files and final .so library.
> It can detect if the compiler created relocations which are incompatible
> with the vDSO which need to be worked around.
>=20
> Wire it up for the architecture.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-vdso-absol=
ute-reloc-v5-0-3a93791af1cf@linutronix.de?part=3D17

