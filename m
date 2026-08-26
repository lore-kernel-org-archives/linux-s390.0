Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E493F58FF;
	Wed, 26 Aug 2026 15:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787757126; cv=none; b=tcti72A4j0rtNBjLzZpycbcgX/h1ou6Z0KmW28/MN6SUHMv6Bpc+f8MOVLehhEFWPeVd02keI68oAXozUtpcG8WBwns6/txQ6A6EpvnkCx1oAOM/SXcLylxQCVtp6sMZ4eGAAoCCxXz2Qj9MBun3VBJU8rll6RkSdAjdQN0sp+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787757126; c=relaxed/simple;
	bh=KYS2sdsikAl93rlY5Oeblp4xNqu4WRdDDqlfluxj//M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cUSJ1mcXVT4n6CKfcjP7yEWGz6J6dmDFwevV4OqMPNvwSh1ZGrZl5OqPgJDDHeez6TdXSTBmKPGSe/ZARpWIaROXvQ0vJpHvcqurTVIDX67PLPuVYGNG+4WmMWcdmWkzy371uR/JZwFvgvbVIP8xilIZFh2OiIW9r3xwO1MkkjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UI9tC/Fz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UI9tC/Fz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7FD61F00A3A;
	Wed, 26 Aug 2026 15:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787757125;
	bh=KYS2sdsikAl93rlY5Oeblp4xNqu4WRdDDqlfluxj//M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UI9tC/FzjllQYbGcD0VPcgnNUlkN4Zidc0HXSpKGh7KzmY9vxKpnJFjFacLi7X+P0
	 Y1Od3+uy2sSW9l99aIrnlXSvRgSJ1LCpOy0nLx5Ce2bVw3t1/eqtWkK7BplYV4mvJp
	 kky4gOlbPjDH0S0NPvqxuJ8qmndQolR+krZ/KzNkT1WNavnKB/df9DYL9VbzZXSWmT
	 RgZMsMQAw82iTcF49Zi7rOIBaUGYlukDWW7QqAom9AUAoJgnEC3/ODuJ4YX7ItHdnK
	 vYFvzG0iZOqlK+Ul74SKmGZU16mOtH9j8eTaYC5TcHLWsUglWX5pY0XbMwUXEEQz3n
	 a9nCM00V4L5aA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/21] KVM: s390: vsie: Add vsie_interp_extf
 detection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260826-vsie-sigpi-v5-3-cf471edb46b2@linux.ibm.com>
References: <20260826-vsie-sigpi-v5-0-cf471edb46b2@linux.ibm.com>
 <20260826-vsie-sigpi-v5-3-cf471edb46b2@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 15:12:04 +0000
Message-Id: <20260826151204.E7FD61F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Add sensing of the VSIE Interpretation Extension Facility as
> vsie_interp_extf from SCLP. This facility is introduced with IBM Z
> gen17.
> Along with the new facility add a KVM struct member use_ssca that we
> enable when the vsie_interp_extf is available.
>=20
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826-vsie-sigpi=
-v5-0-cf471edb46b2@linux.ibm.com?part=3D3

