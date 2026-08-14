Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35C9486B95;
	Fri, 14 Aug 2026 16:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786725987; cv=none; b=AJ6S/U+X5pvx0ix/YSc2GBBgELCZAbZNl+31B4Rb206g/OVB8zX3kJfDatAKdTmNTAK/7wcPDWIljGRMlrUC9sbNlgtjfgg5bCR6OLEvM4J4uec90QtfhCLIFjqNEvM9QH4NNM3PaNjYfDA2vo4PONZFcKOd6Vtw8FoY43B8UH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786725987; c=relaxed/simple;
	bh=UUq38cMvDjWXd5eq/+IsgJhclpggeKL9zrBW2EaSf+w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lVnc9srlnPLyPn4kCzWDTEFJivPVzXL/tI5jgWc54y2VG9Qurtr7NkBe+W05RZjt5dTF9S2o3iv2dr7GYyUYf7KVTHD8CQt1ObKhmyRgYo8SQvFtDizX8mRzIk4grSGW2o4EUZvGRCrlXTqK5AuoC4Uf/pNU5ifdrNnLyhGhEnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/y6EhAj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/y6EhAj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B0751F00A3A;
	Fri, 14 Aug 2026 16:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786725986;
	bh=UUq38cMvDjWXd5eq/+IsgJhclpggeKL9zrBW2EaSf+w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O/y6EhAjqImyxBL/LHgmUzHYpnQukMeF0brqcwXs4GtYp2ol3fXxyELKSrQRAeQlx
	 358sadsE4fXjXcikWcrwRs8P3At0insnNJNPLxEPQ35+uVnGrkz/YOkXMnqEmmxu2Y
	 YZjHGUJmmWG8HB7VTxQdYcEN9XwsQks2GhB6R5DJygW7c4iGe2NnZWqPCLF8eupEou
	 9K9iSIQs1wZM6Dp7y2Ti+ALK1N4yLrJ7Cg9FtGBDoGwHeHOwCT1TpQHj2WT/qZqqae
	 oOhiendnd7LQwDTODhuA/mFXNLrWtYJvhqPEOQlqra8BYWUbwOn75W6zLe7nvwMbfq
	 jE2+/QCgvKYxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/6] KVM: s390: Move all code into
 kvm_arch_prepare_memory_region()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260814163355.227191-5-imbrenda@linux.ibm.com>
References: <20260814163355.227191-1-imbrenda@linux.ibm.com>
 <20260814163355.227191-5-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 16:46:25 +0000
Message-Id: <20260814164626.0B0751F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Move all code from kvm_arch_commit_memory_region() into
> kvm_arch_prepare_memory_region(). This allows the function to fail
> gracefully if needed. The previous behaviour was to print a warning and
> continue execution with page tables incosistent with the memslots.
>=20
> Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814163355.2271=
91-1-imbrenda@linux.ibm.com?part=3D4

