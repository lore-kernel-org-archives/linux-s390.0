Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E933D1A8E;
	Thu, 23 Jul 2026 22:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784845591; cv=none; b=paj/QWXcMF8OyKyEz2aXN7MenK5hF+vC02cgdOYnTIHnVd0usi7rYXXPWPQfr5XV3wVplTZLdJOIouaaADXe9vLDjRR58u/VJk2oiTJ1RR73RFiWIV/I9bN1H2I44+OfILbzAkXagggdYqV6om8CW9bQMAfsfeRAXheLw+njMGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784845591; c=relaxed/simple;
	bh=TGkcN5PJ54O7zevjVC7OHOjPRi97bl5N4MPfK2rdu5I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fmpFQBRfiOzDM34d1v3HhenU8P0AhR6/irX8RIhNa5vkUkFJ9Gok3iJY/p2FDxRiCAyJjTbh79sEFHijANqHUE72kr/hm3pKdJMURBxuwpkRZHeH6bIyF8OCZOWu5IcDXZCiTwjoamFZR6VwwP11ZSEuJAZPTDhiO2BKEvMhDG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NO6GrglE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NO6GrglE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D6B1F000E9;
	Thu, 23 Jul 2026 22:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784845586;
	bh=TGkcN5PJ54O7zevjVC7OHOjPRi97bl5N4MPfK2rdu5I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NO6GrglEowL/+sWROnjZJhCnyzelTZmQ8ylFmB206OrYm7H914q9jSuHsM6+eh0JS
	 DkFz1biN2Q+Io3bK1QdgD9kuvzrWoLwkgrsXzlj/0hcszrAFxUu1JSF7HKbuLVRGno
	 tAPRQnbWEzAkWKg/1Eu0PB+utZxZbhblada95cM9hi7Byy+ya6BGPmX051p73jZubb
	 NG+C8mzKzt4jcPRw7DTrJ6eyt6mRCdPmCPSLJd6fxSp7gU2OaOa+GxR+IwouLrWsxz
	 9+YPKjajNypqEYJRuh9+rY8We+evda70PE5KNl6qUdD8Ix/Y4y9v3HbHbo8kyrlDYQ
	 NgcSsbjiOWCWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/6] KVM: s390: pci: Fix memory accounting for
 pinned/unpinned pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260723221409.5874-3-alifm@linux.ibm.com>
References: <20260723221409.5874-1-alifm@linux.ibm.com>
 <20260723221409.5874-3-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 22:26:25 +0000
Message-Id: <20260723222625.C6D6B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The account_mem() and unaccount_mem() functions call get_uid() which
> increments the reference count of struct user_struct on every invocation.
> But we don't decrement the count by calling free_uid(). It also
> accounted/unaccounted the pages against the current->mm. But its possible
> the unaccount_mem() can be called from a different process context than t=
he
> one that originally pinned the pages.
>=20
> Let's fix this by storing the pinning process user_struct and mm_struct
> when accounting for pinned pages, and subsequently free these resources
> when the pages are unpinned.
>=20
> Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disab=
ling interrupt forwarding")
> Cc: stable@vger.kernel.org
> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723221409.5874=
-1-alifm@linux.ibm.com?part=3D2

