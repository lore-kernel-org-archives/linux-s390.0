Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFBB305680
	for <linux-s390@vger.kernel.org>; Mon,  3 Aug 2026 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767823; cv=none; b=oUHpkSom27k0+9zq3SiqN9vvkgW5je4oULXQFY/7Md13TQ5QqyujvS61RBxW9Wo1xCADVcNBLGmbDAZ0tQZbgeHUZ6lhFOUs3574A2jifSz6RUmyGYP+OG5SgI59S7GvPT4v3LYrVNSbpIUoDAkb3z3lYBAY/mktBj6gc46/yPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767823; c=relaxed/simple;
	bh=kM/4Y5e+DaYxq3mvM06Wc7/MfKL2BWr2772icaoILfo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uAeCB/rCF3ZVr9ni1LxmY3B8koXHZgO/CgOy1iidnFbd0cJGYzQiPyktb8qwN0glQnjdyXvQR2/UgB87OMqM21G55TXggz0Nrm7uFBNXzflL8Pt9XplLvhI+siSJ7YeR04VFiwvuz+9kWEUVYXeUr49Ti9Qm7MhG9AGr+WsB5Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtXakM8r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtXakM8r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29BD11F000E9;
	Mon,  3 Aug 2026 14:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785767822;
	bh=kM/4Y5e+DaYxq3mvM06Wc7/MfKL2BWr2772icaoILfo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NtXakM8rpbXp5CtqZ2HdlzdLwfObWhcuJUd4CbLE/sY3ZqqTAlMxstoTkmWWn5yKL
	 Wf2nrs9oqB7b4FIIWoSLM9Ey34asXHHYTDrNtoI9twfpDB7CKV5WIueWjLME+RCG2h
	 tU8vq+TFmIjp4W9xHI/LI0J0SaS72PtVzcX1pE7yYDNF5GdF8o0OIKSqLIrCN1gDEy
	 3BeroNvERvumCkF4cXHFkkTrdYSZpadN4Zvs2Ds66QLfgAvcmnvELamjlUVd6B8nI6
	 FAXsXofb0atI/LC379RgffgxmNVsI+jeJHYcjSR6kGWKJQPYEhHM6E46UNhUEDo9cv
	 1AayfX2OBu9Iw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] s390/pci: Enable CONTEXT_ANALYSIS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260803142907.1771509-4-hca@linux.ibm.com>
References: <20260803142907.1771509-1-hca@linux.ibm.com>
 <20260803142907.1771509-4-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 14:37:00 +0000
Message-Id: <20260803143701.29BD11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Enable CONTEXT_ANALYSIS since s390's pci code compiles now without
> warnings.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803142907.1771=
509-1-hca@linux.ibm.com?part=3D3

