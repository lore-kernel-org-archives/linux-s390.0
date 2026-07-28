Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91B63B992A
	for <linux-s390@vger.kernel.org>; Tue, 28 Jul 2026 15:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253097; cv=none; b=hMI/1PLhMmEb1k1Zb+sfTrUMpjVaTadBJsoqXe5EXCYW7r0v7vYaxuLuP384WgTG/TN9V8ojNc56PyT++NhZmsPLQx5GQL7NciGJTFRnBEalkSTXp+9OfsbOLR+xUlGwnpOCoX1cTm/L1hyFfl0YL7CWwvAzA5kQNxu/GDI4Q2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253097; c=relaxed/simple;
	bh=Dm2qdN/eHTpIgssQSjAwRT/CeibfFTs7rNwnUwUbQYg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Aa+UYaGn8U+ymKxAULwvJ7usIKF35kJQ2HXb4NlRik/YN4dS/MJEvEtQoetfRj//8Phe+ye3LwWg8lUMfT6gI5oCw+BbBD2AwYFYMo8N4lOG1ogkHqJKDsA3Y0mLckvfEE/M8qzRG6jJXpbZ1bARdoyX0um9IPTll+d3gaHMCxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8ZOiZ+M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8ZOiZ+M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0CE1F000E9;
	Tue, 28 Jul 2026 15:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785253096;
	bh=Dm2qdN/eHTpIgssQSjAwRT/CeibfFTs7rNwnUwUbQYg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J8ZOiZ+MWCFF71M5F1dML+9J1Nb1lNYpqVDTGy/LPENqq8q3ZPudkzX8h0aPajOFb
	 C3+SKWPDUuQAZ+aKoLR62Rz7ozitVA9bRkhzJyOMfGYNNUBiVthrQd+yECY9ZNxsIa
	 JBTTzIiKmLL5GAgQE63NDymIhVqMYisukVY3oheu5orRZuQdufmEtqkk0eW6zjxDSH
	 46spP9/jE6OA8LoH3d7Mb10jPMVcZ1mHYMw4Jov76eVXup/0S+uLAdqEGziXFU1sq+
	 Rv+d+3CQSSzd5yvX4vxqcP7gXVboAoiafYtOoBbImEeXQRjYZZEPcWemxV0SLBvtLH
	 yfnLrKYpRGv0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] KVM: s390: Remove cond_resched() calls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260728150412.3893933-3-hca@linux.ibm.com>
References: <20260728150412.3893933-1-hca@linux.ibm.com>
 <20260728150412.3893933-3-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 15:38:15 +0000
Message-Id: <20260728153816.0E0CE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Since [1] cond_resched() is a no-op on s390. Remove all calls.
>=20
> [1] commit 7dadeaa6e851 ("sched: Further restrict the preemption modes")
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728150412.3893=
933-1-hca@linux.ibm.com?part=3D2

