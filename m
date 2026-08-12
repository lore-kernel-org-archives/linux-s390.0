Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E4B45517D;
	Wed, 12 Aug 2026 14:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786543478; cv=none; b=HZICmKNb2b+0xsvXJssi4EPIWqhFWhL182MaKQWj9nV2vsi3aJBvHeUWzfoYYPXFenIQGwEDw73GURO909FqyCRQunXbBEx7oQefNh/ZmvlljMb+racG5YDCQkdlf4AQ7e6COGDgHNwvZ+n7rhpeTfCK/Z02qv6hCnA24B2WaHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786543478; c=relaxed/simple;
	bh=XSt6xSVZmL1C2rq5KakwMqFyWSp2NzRg57vTqak1YfQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jMhyO+ogp1eQRryb+VWPFUbtcXfO9hXkbbQmfK/+xQSqhfj4EVyc1LXnw3FQoKQ7Osh0MWUL0n7qAKlY90l9LH/lkIE8ufSGnvLKGIpKTbm3+q0OTBZMXZEwUD6JEp/dI5ZWJuvyUVEVfmWTVMYL86mB9DP/cEri889gvbbK1zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqwqnBRL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqwqnBRL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F77B1F000E9;
	Wed, 12 Aug 2026 14:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786543477;
	bh=XSt6xSVZmL1C2rq5KakwMqFyWSp2NzRg57vTqak1YfQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dqwqnBRLuirusJ7F3Ma2ksOXL0l+utF8mpivo1d6N6K5ibvTn8nnbRM+GZYoA0lK/
	 xpA4Pe5U8esR+MB7bTH9kaIf9pSOfqo5D64jnYjsmqLdQB8B/jdySFbBU0vmsiexW4
	 INoGvNcX+x23yOcCzyO78PTme9LNp2ZTpzmJZGxtul8bKLyr8mHGiCmRh6/1g9Hpzn
	 cGXzqF2R4S9GF4BUvej1awZwpgww4JllgmQxIR7r3yS5SlEAcKx0/2yuEXQ6gCBhw0
	 djQGudtMWm4Hnxv/VYcE3wbiGQ76HcrPnZ5FTQGQgpeNdyZEvC9nYaTP4XGoU+JfVR
	 hFcQjYq6NV3eA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/20] KVM: s390: vsie: Add helper to release gmap
 shadow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>
In-Reply-To: <20260812-vsie-sigpi-v4-10-f19e49666315@linux.ibm.com>
References: <20260812-vsie-sigpi-v4-0-f19e49666315@linux.ibm.com>
 <20260812-vsie-sigpi-v4-10-f19e49666315@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 14:04:36 +0000
Message-Id: <20260812140437.1F77B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Create a helper method release_gmap_shadow_safe() to simplify releasing
> the gmap shadow of a vsie_page.
> Will be called from multiple places in upcoming patches.
>=20
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-vsie-sigpi=
-v4-0-f19e49666315@linux.ibm.com?part=3D10

