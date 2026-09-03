Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174603403E3
	for <linux-s390@vger.kernel.org>; Thu,  3 Sep 2026 08:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422553; cv=none; b=II2SCVCPU0q2jpRFGKx/Aj/2lcc1aTbcXV4ArRURbUMyfDP2gnMoPBPdohK3zZd1nB7T6XqnUZmQ//Iu5leEPlglFzAPyTOcLnC4LQciyot/VlhTcee6HDaO4aAvU4wG7IkV2jeh8F8Ju0NTepknQivcIry2IeGlREM7bNJhGuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422553; c=relaxed/simple;
	bh=/Ax6NECGQgZ3spKq2EA/8Qq6t3z9W8gCkbCL8recPbk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AsZbTHswVOAs2dBLXLMy/SyZjpDwxHoPv6z7f9EbNif7eayM8/n6W9/6vtJUtF8hBHJ0S/BWmQTGqEqqYY0GLSg0Wa+E+wpcYdJ6d24XxsAnLZIaSmxZTNf1Wg1QsgfzBDMoflQ6Wg2yh6Nr8KCAPgk03grmlykc2o81s0iMcuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ct4YWvG2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ct4YWvG2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404781F000E9;
	Thu,  3 Sep 2026 08:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788422551;
	bh=/Ax6NECGQgZ3spKq2EA/8Qq6t3z9W8gCkbCL8recPbk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ct4YWvG2khNqc93Ap6u13OFXSJx1oI9Bs69EiMjo7jxIwa7Z2SYhtXx+mLuBgGegT
	 fcAQvkrm9OSAB4nllp5sLbZ+qgt2MB/xEWG1GN5hJmokVpgvW8YLjfCqZSuDbmcpmX
	 n79y3NxeoEoKIPqMS4sJhgxlmCfQYwzPryg6gnRhWS8A8a2Uz43fDRNJS7s3dxQG2l
	 SE3iTT7JN6djBzgqQGqclxpzlf/59+pHobJ3PxhjIC+X8Ac4mOiMZjy2XxQ7hL5D+B
	 iMiW9ShtrqTxWyPPi4bB/07wCpIIitUsQlCQ239bHbPbG0b2k0xNCyPDJuW+yz+dEX
	 ajFhiVfCNfwFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/15] s390: Remove AT_VECTOR_SIZE_ARCH from UAPI
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260903-at-vector-size-arch-v2-9-5bc32a71e3d8@linutronix.de>
References: <20260903-at-vector-size-arch-v2-0-5bc32a71e3d8@linutronix.de>
 <20260903-at-vector-size-arch-v2-9-5bc32a71e3d8@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 08:02:30 +0000
Message-Id: <20260903080231.404781F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> There is nothing userspace can do with this value. In the kernel is
> always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
> userspace and also changes from time to time.
>=20
> Move the symbol to a kernel-internal header.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903-at-vector-=
size-arch-v2-0-5bc32a71e3d8@linutronix.de?part=3D9

