Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1803D339705
	for <linux-s390@vger.kernel.org>; Sun, 20 Sep 2026 03:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789876216; cv=none; b=IrGfCKURI28eWIml+Win78StQRxL8wsEn7ssdfhYdFkR1SBNR55/wWAEwOhXe+te2AdiNJwyRrLYGdxsdjOSA2QBLU2dXG+eUE0BwF/6MPreXwnE0PNa8ty1Cc5VnmsvPPAeIotfiSvTgZzQaIdS+XCilevv6KMOHk4cAqPDkrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789876216; c=relaxed/simple;
	bh=2J6/kJKAInuG9srgq3hvosti10Po+SoZhnxnOGS+z8o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mq7bf58KOnTqu1iXfbi+V/0nC73YvD+55x+4wIrEI9Rw50TYbUqIBB++u2zYXiVGCssnhFC+9uxohIsr+Or7hsqLY8xGh9jlIXRlrBEavi4lv76jMYM3liVKqWWI6A+Vr4Wci77yrIeTNS50AlONXbAP1jUsUlXcAkv44r+co8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVZ//tCN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVZ//tCN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645681F00893;
	Sun, 20 Sep 2026 03:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789876214;
	bh=2J6/kJKAInuG9srgq3hvosti10Po+SoZhnxnOGS+z8o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DVZ//tCNAp9TqFhs1uEPNtLjkL4+vnHCWpYPeWIUDMTbxAx4Cj9MQSfIHVcD7ITf5
	 Kjm59KfFOr9/ySOg+76fNqO0ityZJaOf9B4ssKUORD+mg5zzYyZuY1/epx/77hVZ8M
	 5YYJzK+lcBlTQHXw0H77BLzB6Cwlg+Nmb3tcRv3jRgxd+mUy8V7BIb3iOv5vMlTzOV
	 mHtPz17e/XMGp7Nhk2qo4J9IbKRP/k3AI4Xdv1405UgFI7JhRvxeP2pPsJzswDpRC2
	 AzuJF4yPUyJEItrviygq9Y5Ae61In9Um6s2lDws2CJUtGW8g/x2yLe4xHkE2GHki/n
	 QPrJgEP7ThStg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3] net/iucv: require IUCV for AF_IUCV sockets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pengpeng Hou" <hppiscas@163.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260920034503.17322-1-hppiscas@163.com>
References: <20260920034503.17322-1-hppiscas@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 03:50:13 +0000
Message-Id: <20260920035014.645681F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> AFIUCV can currently be selected with IUCV disabled. That configuration
> does not build af_iucv.o because the parent Makefile only enters
> net/iucv under CONFIG_IUCV. Independently entering the directory is not
> sufficient: AF_IUCV also relies on the IUCV implementation.
>=20
> Restore the IUCV dependency for AFIUCV, as proposed during review. This
> also constrains AFIUCV to a module when its IUCV provider is modular,
> without changing the directory traversal rules.
>=20
> The issue was found by our static-analysis tool.
>=20
> Fixes: c69748d1c9b5 ("iucv: kernel option for z/VM IUCV and HiperSockets")
> Assisted-by: gpt 5
> Signed-off-by: Pengpeng Hou <hppiscas@163.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920034503.1732=
2-1-hppiscas@163.com?part=3D1

