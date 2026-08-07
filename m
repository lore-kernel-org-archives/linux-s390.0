Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AF741A79A;
	Fri,  7 Aug 2026 22:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786141918; cv=none; b=c3URkfuAe4OM85BDmvd5Ik15Ye9RlI5AUzLdpKXVI+4FaqMbt4573+sVm++DNMwk10fMgfRzxvuDb792c2CWIN6g3HdiXZHsuHA5AGjgRBLmXvZcVkOjEMbMU4D1zECrZF24CGkqB3sICfql/NAhE5ZRjVb3vrnCvzfz1ZXWvtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786141918; c=relaxed/simple;
	bh=e//50ONLA6TLrVodTTbaMqtchilYw/iWIjLe5ELQbh8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=igZMqHn7hty8qRY+alXOwnysGPhGncVNeJxmsCvT5nt77PkjnLaoqh/hzZQEjE3kVtUjdFjRepCofxLFkFkNi2Av0tisQJdi5ch6PLF2HEivoi2mcSmJ1nLX4OIJ/lpY73BOo8qF6xbLVapfg/OmJHPFFLkQCSd0TQrE7q3f7Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqhKN+gn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqhKN+gn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3D31F000E9;
	Fri,  7 Aug 2026 22:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786141917;
	bh=e//50ONLA6TLrVodTTbaMqtchilYw/iWIjLe5ELQbh8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WqhKN+gnbrm+uaR7F1kdy8Wxp5o0ZdbKybsYXse77EE2NxTIUasIjAjFsoe3ClE/C
	 lNGGHE4ALJktN0kL+xV88DFOIj6Dut2lLTPWdlIH4hoOPR0/jkoG+TE51uyD5Z0Dmu
	 SaH1NYKHpkKGZzeo/EqFqP+aumNnvXIlt6sqkumHNszxgUrbfJiy1Rez5A5yqnTtC2
	 hAmWMhZ1U3KL57a2r8wvSeFGYuHojI7OswKeQtOmGbVyNdpFePHleywRTk2uInaDcz
	 SerKkdW4okMmUqzahTNbxagepGTE4Niudd6JObo9HtSokGgrqIP5VhTFswVbl6h7GZ
	 J5UHMlmp0DLXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/15] s390/vfio-ap: Data structures for facilitating
 vfio device migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260807221834.562851-3-akrowiak@linux.ibm.com>
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-3-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 22:31:56 +0000
Message-Id: <20260807223157.3B3D31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Creates the data structures used to facilitate state transitions during
> vfio device migration.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807221834.5628=
51-1-akrowiak@linux.ibm.com?part=3D2

