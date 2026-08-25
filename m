Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763373D3D0E
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 07:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787643526; cv=none; b=rkiMt5fqEQmVxGhdwnH8k9yT3Fkc/ob5j5ZtcdFs7ap+rgGN3LXVFHMVeWeuQSRbtKYCfcRPrrc6dmgT+HEf6QYi5iqM8WGXbNs6ayPznglNJHc0lSFMz6ZXMO1zpPwCbw4/q5YWJFWEfOo4wb7mX3Sr9ZzijsznZ2wad/QnT5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787643526; c=relaxed/simple;
	bh=S5PlGGIqACCcsBZ28Cl1MJEc5JDWnxcCz8OFsjZBWjE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sFiuF9giLw/I4U0EJknePnbQw7N1OZiKhPlZ9BKgkWtwElh8mT0B7pSkbOeaUzIGOHiLdlvN4CrE/PowoFvdfqelWOAorJnG/UCr7E4eUa3/hD3H0IJL8vMG6G3jKSKJPoBWQnh92LEroaCJTXBxbrGijW/HjAkUyMwQonaFtHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ME4ruvj+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ME4ruvj+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04C31F000E9;
	Tue, 25 Aug 2026 07:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787643525;
	bh=S5PlGGIqACCcsBZ28Cl1MJEc5JDWnxcCz8OFsjZBWjE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ME4ruvj+CsrOXW/aZLX+PnqOmLLctGHXG2e7Yj/XqkqzlRjcos7pvJ1vdPCoKMyYk
	 9NXoXZ7O01XNvqPp9QfouVConAjVENqa4m7Iokv2j9zNKClGyn11pzhwzVQc/DeiPS
	 R7efCAhYDu93hOKROu9duliTanvYSr0CkpXYWD8ybVm+sW/1qhI/dQYRYkOO7DtpgK
	 bDd3oWqOWfhfge8qGAwQ3qn12bOyfrKKs+Y6b+Sdob9YiW3stGlEfQ8BbbHhDbYEvO
	 CeXdOuzti8VapcwSLNN9thbakGfIoB40mVATzMACr3nHXjomSyQInMlKR+YFVQog4N
	 ji/Mzplwam3Rw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] s390/pai: Use PAI PMU index as parameter replacing
 event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Richter" <tmricht@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260825072931.3738180-2-tmricht@linux.ibm.com>
References: <20260825072931.3738180-1-tmricht@linux.ibm.com>
 <20260825072931.3738180-2-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 07:38:44 +0000
Message-Id: <20260825073844.B04C31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Use PAI PMU index value as function argument instead of pointer
> to struct perf_event. Only that index value is used inside
> functions pai_alloc_cpu() and pai_event_destroy_cpu().
> No functional change.
>=20
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825072931.3738=
180-1-tmricht@linux.ibm.com?part=3D1

