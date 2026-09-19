Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23F23148BF
	for <linux-s390@vger.kernel.org>; Sat, 19 Sep 2026 00:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789778485; cv=none; b=avv/eqp/i9+ih8fXCfugsx8TRRQkcvKs1QRupZd0znyX8k2ja6qf4JC3zwV1WfYM52OBSF+Gv2wZDJhOVqBACd9sSRJFSz/Iz5uejk9D5Ze1SujMA8g3x1/9MDBKPZ5AqeZ15iC1pbWuYpIjEhIEGBm10GSwG5VYHhhCxifhuVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789778485; c=relaxed/simple;
	bh=thrqWiS8JchwdNHMdQTEL/lSlf+WuAfZ7KmxpkVkAfg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DSIbBIVmtWUMdsSA5pvI1PYtlZepn7HhgBdNCEr1QzCwx1e7uNt2qKfM8VBTPYTT7tFrM2QCiurWLHiTzweIUAIpebE2lZCHI38TIgKIZS2YbFMQnoaysGEEBwDTBwomRFnDffRvx+WX4MkidT8b//rZmaPJ915Slp1C/bzmGn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZwPNDzy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZwPNDzy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAE81F000FF;
	Sat, 19 Sep 2026 00:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789778475;
	bh=H9sFTyOiCEUh4cxYOKGv7z31ZsZPG+iJ/GCFa3PVpEo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XZwPNDzyHRmeaU203Rfa0AjMSXW/5MAoJIaR6kV+DGjg8Zw/b3lOmgkCdwd0ywlZF
	 8M1cQpvDffUYaHN68iI9ysMopK+sFXwFylXpXCewM207qZGqf5FhqU7WHNYvqtjg2F
	 9yM8Up/AIDkowN49n3a2iiWtfSg4+jAQsUTj01BTEU7GZEtuyyfXp1mQrSvePkuKsK
	 hS0TwEM04u9AR0Cfp8x+Gpbgwahyxy1WEQ5pxfoQG4I9bTbjcE3VDUGTxooApBGy4O
	 PglndfbcdwRx05rD0BXFFfoJV7pnZBnVMK3xMuL/uLYHpkVpvO4DOp635tMrhRUhCI
	 Rg2WqfM9QFMQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 01/12] syscalls: Make --abis parsing more robust
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260918-tonyk-syscall_table-v8-1-0e2d60cad13e@igalia.com>
References: <20260918-tonyk-syscall_table-v8-0-0e2d60cad13e@igalia.com>
 <20260918-tonyk-syscall_table-v8-1-0e2d60cad13e@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 00:41:14 +0000
Message-Id: <20260919004115.4AAE81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Some archs Makefile have something like this as the rule for making the
> syscall files:
>=20
>   cmd_systbl =3D $(CONFIG_SHELL) $(systbl) --abis common,$* $< $@
>=20
> The $* symbol is evaluated to the variable found at $(uapi)/unistd-%.h,
> where % is 32 or 64, resulting in e.g. `--abis common,32`. Sometimes the
> rule for the file won't have a %, resulting in a trailing comma e.g.
> `--abis common,`.
>=20
> Currently this input is transformed into (common|). This is problematic
> because grep will then match any ABI because of the trailing `|`. Make the
> syscalls scripts more robust by removing any trailing comma.
>=20
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-tonyk-sysc=
all_table-v8-0-0e2d60cad13e@igalia.com?part=3D1

