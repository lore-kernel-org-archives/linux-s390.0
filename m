Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269DB37F313;
	Wed, 29 Jul 2026 18:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785348780; cv=none; b=fO/WIs6YyyRWsCsBDbR5iLdl6wkQMXUu58GvArrW3a+R/BBpvWWTZ++SPJnsAE+g07l8V6ypjpeDi5yeecBlL2EXFxUGo1U0bsEuF3vhbxy78070cpNjF6/yr+n5ujq8DZtR3se+HGq0OKGvBZAH+rfr4/XcDb5iNSHZMf/rwSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785348780; c=relaxed/simple;
	bh=DzryJh43pQgzqvZ9qNIpPbUUQll0gXm8bFQX1KKMdKI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hNwK49DPhreAwHGZYa3S4phJJHDHkFYfxbUTnGo3GpRKsCOSesz8WWtf9+XpJi0hWWMybh+1l1eHoTxCUASzGgazPbtE2ykiG4vBL2gikPjkQD+FZr7dhpUpw9DLehl4X7wMbdxWcpRYEaf/j5L4hvoED+G73AYMwfSYwYWL7QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cbd4MR+N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cbd4MR+N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328241F000E9;
	Wed, 29 Jul 2026 18:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785348778;
	bh=DzryJh43pQgzqvZ9qNIpPbUUQll0gXm8bFQX1KKMdKI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cbd4MR+NnL/McQTiGalTBG2sHfR4pr/IOiX/2gB/WVuJ6sqxD+KBn+degQB7kBxI/
	 5WMABMJQi8/i7wiDTLoOHlqStnSBiLq6f3rT7nlhTMr0W5ge0pjpEoDSYdz1C0B0QU
	 yXz9PVtnLVe7omzbQkgqqA7bCztM959GL6XW7PzPWtme/CJOEWkmUyI5WkiK2ck4vG
	 hl9qRbbWmCKqY5YvU4+vtSoBLgC9ICndjuavRM41F9eBkTzINmLeVlNa/36mUveVZH
	 rADk3Y0HOavRUjuuZfRE1qnO2fFLQ9HOdxBEo6WOaobyvTJMQQ43H3RS8t9nvbSafA
	 OA5RBVp76nYQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/13] KVM: s390: Return -EINTR if a signal was
 pending while faulting-in
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260729152938.782383-11-imbrenda@linux.ibm.com>
References: <20260729152938.782383-1-imbrenda@linux.ibm.com>
 <20260729152938.782383-11-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 18:12:57 +0000
Message-Id: <20260729181258.328241F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> If a fatal signal is pending while trying to fault-in a page, return
> -EINTR instead of -EAGAIN.
>=20
> Also fix unpack_one() to handle -EINTR properly.
>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729152938.7823=
83-1-imbrenda@linux.ibm.com?part=3D10

