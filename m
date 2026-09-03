Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B03236C9D9
	for <linux-s390@vger.kernel.org>; Thu,  3 Sep 2026 08:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422654; cv=none; b=fHSMKD3MO/grP2nxTPv5JAElcoJNMOThOBdBOCKi2okLbWLxUP1RCj4z4ckPMarC8PF2+Koy2ZRnsLzbk2p0tc8jx0gA/64MzRhjaJu9KbfWn5eZziZJ6oSAlDuUEcc5JQPOsCOdtGy9PFKZ/MFetij72+oi1qiEhUHeQ2+lo+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422654; c=relaxed/simple;
	bh=D7oLV6Sd5E7pSyWo5uMHCT3rxtvabtz/vnP0ICUZTFo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qN1nant9O7g/cjooxiTFCvtrfMjZBJoeeRjIutIyGEq0ZA3/vyTbxHYt9CerX1mgy95C3ofqAhDDTIhqDcLy+fN+iuS/YznU8qntg7IXGfya6hL9UramFkF9RTnrCUNn8InxQY08YYn6M1979pyUeKt1aHR/hte8HRA6AZcC0wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pn1X4Jo4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pn1X4Jo4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCAFE1F000E9;
	Thu,  3 Sep 2026 08:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788422653;
	bh=D7oLV6Sd5E7pSyWo5uMHCT3rxtvabtz/vnP0ICUZTFo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pn1X4Jo4Ft53kdafi1qhPGVqujEFddZ61OUOUTsR2iLNWOvn7lvbiQ4tpgsAWzycX
	 tUkwo9Sxowlt+vAyjlc0BIwtYVWNeIRPG8JWO2/+8g0crlD7+BMdTBILWHie4Q2uV6
	 8bbLUpp5SQiY7coRPM8qwVDhvW3/V5j80YpG5ZLLqIEXbTxm52oP2F7KvSR60sQo4v
	 linuNGahxgsOD3hHxiWEmoqf05d2KE6qeI1zMFXzN9bNu80F7vnkNi3pOpDzt/uEms
	 DaxHekI/YjhPtCd/QAMfsvZ7sg8JSBRGH5imVRkdWr9pmDe7n75PuNZZxJ9QRG8Ufu
	 LQGsT9pu1OdtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/15] MIPS: Remove AT_VECTOR_SIZE_ARCH from UAPI
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260903-at-vector-size-arch-v2-11-5bc32a71e3d8@linutronix.de>
References: <20260903-at-vector-size-arch-v2-0-5bc32a71e3d8@linutronix.de>
 <20260903-at-vector-size-arch-v2-11-5bc32a71e3d8@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 08:04:12 +0000
Message-Id: <20260903080412.CCAFE1F000E9@smtp.kernel.org>
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
size-arch-v2-0-5bc32a71e3d8@linutronix.de?part=3D11

