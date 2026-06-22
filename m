Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34D633F597;
	Mon, 22 Jun 2026 17:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782149242; cv=none; b=GwhsJ5kEFnNdCo8xRdrKYQz6HcwAY/dc0pqbtouaU/YGE/TBzZFNfFtc6HDbdzEVom7MaFeeOjpYywNHX17NZN2bZrxu4Y5LlNCLj+Gzteh4/5qQSkgtFs5hgHXEnQRgWtlri3C/AXs3jD3F/Jicmu54m4Xps+iWOBw+G5GI7C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782149242; c=relaxed/simple;
	bh=u2lEPSI2tUoVpAjWnBvIy2/q2vbxT1nM+e5tOeZgKvs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ED/BBz+NvQlwVmrW7o78Uf80vxFiP54w3+mnP7wVVZb5HYp/6b8sMr7he5r+NoUsC9Vair27Z4V1kflumoFiOOEtVfK0Z8vvDSgFGVaUP5/zVABuEEiN3jEertDAHkhWDGnQgtMVT3WSedLSAz1dKzf4USdRhbpVOFYg+vUtIb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNUsyb4I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNUsyb4I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF5D1F000E9;
	Mon, 22 Jun 2026 17:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782149241;
	bh=u2lEPSI2tUoVpAjWnBvIy2/q2vbxT1nM+e5tOeZgKvs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SNUsyb4IQnSACYphXA65IZ+fG39hajqB6qFG5YCw90hKt9t3uMULRxQCBXIWt4CAp
	 Q+fwUREGmBgFMDops6IpjeGXGqHxrVyahazPxnT2h/gwBGbqs7d+JavGKp5UvkdB0y
	 WKlMFj6u874LdxZtJRTp3zPGgoHR/qUhUcmTV1MfBwFLX4B28Cxd6/SIlZKme2Ueyj
	 zEyVx+p3n3UF0W8SmpIQROgabf2fJ02MLiONC7Ej3DMfOfL2jXISN7Xtm5yU6lCjjl
	 nXj05MY4b1ep5e/THr5X6h/vVumyqr6HgN/QuabYCsOI4yJiKDYVWeL2DJoti4ePZs
	 +Ls1v4j2XfB6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 3/4] PCI: Fail FLR when config space is inaccessible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260622171840.1618-4-alifm@linux.ibm.com>
References: <20260622171840.1618-1-alifm@linux.ibm.com>
 <20260622171840.1618-4-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 17:27:20 +0000
Message-Id: <20260622172721.5FF5D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> If a device is in an error state, then it's config space may not be
> accssible. Add additional check to validate if a device's config space is
> accessible before doing an FLR reset.
>=20
> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622171840.1618=
-1-alifm@linux.ibm.com?part=3D3

