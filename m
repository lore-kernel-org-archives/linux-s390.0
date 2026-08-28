Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53A51C84AB;
	Fri, 28 Aug 2026 12:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787919491; cv=none; b=DknxVba3E6H6hv3l2qWYrqxkdVEF7/lXpPL3Nli5f+51tLflufl2Wa7cbSX3C/qg758wt41zIppJlpD9QSJhwyLVmVjO/zaN7u1b+tzmRsoDJsmRCKBHLquZqisrmT2BKNhz0/thlPYYuSjk7A+0WeqIVWlwV2LqXctejzRM38M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787919491; c=relaxed/simple;
	bh=a8AVLVI/ja7DGx3/WxWFjadrGi90RjSV9kx8JFINPvo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oixkhrRMDOAWzhHvbm0fjXBEp4Mq+BkgM/VN15SxnsuB3Y10dOhDIl8lWv+xCzLirf3Un9nnZJ+707jgOaGpNvCWXYMfbbyndtyVWBt6XHoZFXHVY/j+AtWT+39fHG2cuuS4wlGHm3z1fSpcIE2neTHuSQtvymq1OG1mZrcyn6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9JpDldr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9JpDldr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383B81F000E9;
	Fri, 28 Aug 2026 12:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787919482;
	bh=a8AVLVI/ja7DGx3/WxWFjadrGi90RjSV9kx8JFINPvo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L9JpDldrA8MEV/b2uwc8DRb9CZt17UAfAC5I7I228tjvOtWWw38XAXXm4RasmE7CB
	 YrJdx22NVJyug27k9XErm0PMq3hVGZ03jViRr92fVd1PAbKBavelVNo6khuMYd5yGh
	 Fb/wi5fsY8a//RYWSD8SayWei5OmQZbYeTsOpfFInFtHYjrhV+Ww54+EfJhrFYCJ69
	 Pm0qns4OuKX2XK4Yjo2TqcJ2jlfAwTxQJYN8b7NVHYTPHpLu50ZpeXq9uSyRpMNLK+
	 Ip5ct6kUaU2laf3Me0hpPiHGxF5Mn7Miish6RXKwFDPSbPp1kuL4JjbMFP115ydeB+
	 eEot5KK/E1eyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 8/8] KVM: s390: Fix race in _destroy_pages_crste()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260828115439.145885-9-imbrenda@linux.ibm.com>
References: <20260828115439.145885-1-imbrenda@linux.ibm.com>
 <20260828115439.145885-9-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 12:18:01 +0000
Message-Id: <20260828121802.383B81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Use READ_ONCE() in _destroy_pages_crste() to read the crste, avoid
> dereferencing the pointer multiple times.
>=20
> Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828115439.1458=
85-1-imbrenda@linux.ibm.com?part=3D8

