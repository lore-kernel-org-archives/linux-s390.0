Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDD644E655
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787236009; cv=none; b=Pz0/DcsLvbt1JFrE0TbEfvG0FjIZiZLKohDIHLZuwkK3SinJGQkHxpNqAFPw7fvktzmcxRncD9KnruMUEBUlJGYAEVX4aX5AKwu4FZX+coCzJx0itSKuD9R7pO6+0vCfJBR2NgQlmz92OaHWwY2O//nwAnY7N6rQ+PXU01NuZ6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787236009; c=relaxed/simple;
	bh=2PBstPfxgTGMkEJe9omqqzqxuO7qrHXshBAtTQCKCDk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h+c9MZl3kYKeJRqDAkkqSbyCzdXSjLUkE11vjt+FW5gOPYyifbvtDgN9s0Pt1QZPshRoK4vpB9+F+VvaF63QDDCcpacbtYhDMAcbYXG/ICSlQ6YPXHS79JtbzQUQPuzOLYfVD95TaCimOvSpKFovv3ci5zmnS7KAqt/gvOefUUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZQ3Fsgz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZQ3Fsgz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018911F000E9;
	Thu, 20 Aug 2026 14:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787236008;
	bh=2PBstPfxgTGMkEJe9omqqzqxuO7qrHXshBAtTQCKCDk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EZQ3FsgzwcY9BvPyoFih/gOHJQQqTthRHlJ9MM7vdu0T3EN+gscSCM9BUraxkfEJS
	 ioVa1duqANqQB7ReyIoQXXpWNGT1w1ybkneDD5Z/GzlwI6U9FQFnlf3QvR3Rw7viT1
	 PhT4PmWl6KGpNRx4nZfQzXgMpX21XkYFw1UOV2Sew3aHMAZp7Q86GrR1yj262ETY6S
	 BfQPv9WKtBmZKZ8iEmYPOq5jz5FfPeCEdpqwXlPpJuYoaXs/3t5v2yXpa2ce7cLqZL
	 aD5PpBZ3RHuS+UvcHmgHQuzxIUACujANGuYdPB7oeT8QrKEABURHUBCIfKBkCWq3HA
	 tC/0oGBh6nhmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/8] s390/crypto: Fix missing cra_flags in paes_s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260820141957.19091-5-freude@linux.ibm.com>
References: <20260820141957.19091-1-freude@linux.ibm.com>
 <20260820141957.19091-5-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 14:26:47 +0000
Message-Id: <20260820142648.018911F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The 4 algorithms implemented in paes_s390 never had any cra_flags
> set. So add code which sets the cra_flag to CRYPTO_ALG_ASYNC and
> CRYPTO_ALG_NO_FALLBACK.
>=20
> Fixes: 4ccd065a69df ("crypto: ahash - Add support for drivers with no fal=
lback")
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820141957.1909=
1-1-freude@linux.ibm.com?part=3D4

