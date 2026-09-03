Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82CF4E8DFA
	for <linux-s390@vger.kernel.org>; Thu,  3 Sep 2026 17:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788455884; cv=none; b=cx2Z2aAOFtA605O5ZXz1mqh9aE7YWjnOBeMcIMjOYoF2VkbF3sGcJl/WMj8JwteLQ0smc1pAbcDGrnNL5qUOkM4knyB/ft+WkvG0BL0BPpQ1gJryqeh1UB80hhYaPLvMnzuYR+cYlovLt/FnoOsAz+rrZc1Rj+aH13ECY0aOJtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788455884; c=relaxed/simple;
	bh=carIT4mAfPqjqPmntYCWX3yb1+mpvrgHfJiq/B65gs4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MwxG3sUmBC7AWKbvxGL7fgVCbg01/i4R7sw6txzi2XrTxX5s5A2l1e41AbR2yulv35LPJb+cLQhgZ6o8cYiQXc3SW1KFKZtU9cE2GzDAxMt2cq410wjfklXvqKsRoNpWyDu4WvOwQgefJ+hClmssYUBAXwXZvLy7vO25+3xE4jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRz+pT5L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRz+pT5L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E2E1F00A3D;
	Thu,  3 Sep 2026 17:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788455883;
	bh=l5RX6wr9Uc8jjwwvcKs5CgViONgotjwGXFPsb2zXNcA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JRz+pT5Lf+150mpNQ95VSfzKHbQ/OFXUMXgjvNky8zdm9mYvziRnmifXVsPrMyFkJ
	 eiWWW+i4IOQVfGHnVcBryQbSnfS2sgAUukfgI75D8/bgXsvBFFgMRwkNVRh8g+2aT1
	 kHg/b7mxQMSMW4wY6LFSZehPfmuLQxv2ZcKlsql0mhwDJThkLrG9R23YNNklpQrV9L
	 LpwPxR/HYUOeILuaIpSu0sJUEmOcd2eVQaVk8h2DXCUC3CVJ04kYLoni2duw19Zj/y
	 y3t6mefEVv/9rKQJSH0F7y79Ys61vr+c2g6io23kF2X2WyxcgpNQoqs4NNPgQwXKd+
	 7u8p2AmXVR4Jw==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL] s390 fixes for 7.3-rc2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260903171054.12158A58-hca@linux.ibm.com>
References: <20260903171054.12158A58-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 17:18:02 +0000
Message-Id: <20260903171802.C5E2E1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Hi Linus,
>=20
> please pull s390 fixes and one small cleanup for 7.3-rc2.
>=20
> Thanks,
> Heiko
>=20
> The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b9=
35:
>=20
>   Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-=
7.3-2
>=20
> [ ... ]
>  drivers/s390/crypto/zcrypt_cca_key.h |  1 +
>  drivers/s390/crypto/zcrypt_ccamisc.c | 15 +++++-
>  include/linux/device-id/ap.h         |  2 -
>  17 files changed, 119 insertions(+), 103 deletions(-)
>=20

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903171054.1215=
8A58-hca@linux.ibm.com?part=3D1

