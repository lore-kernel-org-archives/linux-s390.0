Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53A33F210B;
	Wed, 26 Aug 2026 15:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787757125; cv=none; b=lS6gN3U0Pazb24Y7aa7CfPc8mlCglsQuh0zYX/1Vv1dYlbZ18NJ7lHLX+DZ3vMToxlse5k6q0VjS8cg6KDKwWSONzHRQN8LYArZlomOVnqoJJF+qteJxcEv2ORA1TCoT5jRvSI03WOfF7+s6nvgkHBcUHNTBcbYSZwR87m93pLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787757125; c=relaxed/simple;
	bh=piQ5qpLuA7yYeFiqA65tYJJbbBz7ZWSe+ONt2yA4p38=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UsOkEke3/oBiPcQmZLgSqZ+OQbMaBMzCBR2a5WhaLCqJjUgbeHipu67mRsXgbPnq/ZowYGaGG/cjNmezN3tXP8uLnOZS/DGRNcv0hSvfz9sS+tvUEr/dqtGhSE3oZjZqO/2n8yN/2cRYnBeOdUg+EFXEsOj0f7Fu3F8+s1KnNZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrY/L6NY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrY/L6NY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27AF1F000E9;
	Wed, 26 Aug 2026 15:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787757124;
	bh=piQ5qpLuA7yYeFiqA65tYJJbbBz7ZWSe+ONt2yA4p38=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mrY/L6NYEa4tE+ajK1tXREXAlDrMWfy7TfJaH70sVDXFC5nmGyvcUilAS3W8spy73
	 XQZ5GmQSsMkewY8oeEhPrvF3mpAcHF8Ry7yfEnhz0nJb6LIZIngkhIfod4/7JDycV+
	 wDdcu+fiBAwFfgtqR65Z74LZD0EPT4Wkg1kNUbQjgzdRUMoKypZvnBuRPuvl1uNj0Q
	 t80ZRMsruv0tamdcYPxvWs/8ermt4ZxGuNuiUuTlDbDnQl6DgIx8Ooy1SVaF/yBz/Z
	 ouiH5edyqympWEBF7Xh2JfL8tGYkF7i1JqMSo0ojgm/C83MzN7toUiTH7epYSjo//y
	 gku3kbjs4T1Qw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/21] KVM: s390: vsie: Add SCAO read and write
 helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260826-vsie-sigpi-v5-1-cf471edb46b2@linux.ibm.com>
References: <20260826-vsie-sigpi-v5-0-cf471edb46b2@linux.ibm.com>
 <20260826-vsie-sigpi-v5-1-cf471edb46b2@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 15:12:03 +0000
Message-Id: <20260826151203.F27AF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Introduce some small helper functions to get and set the system control
> area origin address from the SIE control block.
>=20
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826-vsie-sigpi=
-v5-0-cf471edb46b2@linux.ibm.com?part=3D1

