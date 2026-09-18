Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C27B342509;
	Fri, 18 Sep 2026 15:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744597; cv=none; b=CbgGF4qyCHA9K8sBmMMWu+f+e7fOrulj3IvMKkx7y98U4CJ2j4FTq/kTx6f+1iLoevr6qubxjbHj5NIoOxc4kUoW/ch0dYAFRD/0rF8kmQNZLGVK3s+GcU8bGPz0pQ/I/isHPV5GBQ4TApL+ci+EMA3IhluCI1NJEHGbwqsFUP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744597; c=relaxed/simple;
	bh=avcDYpRZIGMzM3DoGgE/7KaAhcue4GgheA70YOHpVR0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e0chL78sEPnY/HFI2THJHY3gIwCg6UVVc3Qdg0kljmLDUfNItcdCO9pGUGBOupEvMxJoPN+AyiqO2tlBYFSMFIsMr9RsqTIOFf4WYc6TO/opLVS6xVbICEKQfDZ3D2GQVVchFetaNo0KNvO8B5lZqG89/rNfN/A0ikQGX2ZtIH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8cyNIaj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8cyNIaj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F94C1F000FF;
	Fri, 18 Sep 2026 15:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789744596;
	bh=avcDYpRZIGMzM3DoGgE/7KaAhcue4GgheA70YOHpVR0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B8cyNIajJTgq21ya4YbzKXJq+WdGz/SE7603oGy7oVX3BT2broWoPnSDzg0NV7Nq9
	 YbOEb6ajj3IH6N1B8P9XNkpBiIhRm9ksTehj8jXtMZbLFhfBTblwJBLJsR4R8/LNXb
	 jzeknnX0ZRjlOpuHD5OA/iP1ZKcS3//dZORf49W/UlwHTAEvML7L8TaNnILw/YMOgi
	 xXs8HhHFqPGuRrnJS5hLGG/hvwg5/EbxWRDOCWrxOvVSiizTh9Kw5cn8KdtLATgnYT
	 kACR4BKCaPQLNsx31vXSTF0M82Da04T5Pj4m7aQk23naUy4e/Y+tnjtnzuSFptn2MF
	 wnteHxr1MtUIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/21] KVM: s390: vsie: Move pin/unpin guest page
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260918-vsie-sigpi-v7-5-f39806eaae37@linux.ibm.com>
References: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
 <20260918-vsie-sigpi-v7-5-f39806eaae37@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:16:35 +0000
Message-Id: <20260918151635.8F94C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Move {,un}pin_guest_page() up in preparation for the next patches to
> avoid having to resort to forward declarations later on.
> No change intended.
>=20
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-vsie-sigpi=
-v7-0-f39806eaae37@linux.ibm.com?part=3D5

