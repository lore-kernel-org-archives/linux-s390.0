Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B346E403EB1
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 10:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787827050; cv=none; b=duuCSEtlsVpLzwsQ2yr1bdxmV3KgO2GoHhkuh3yXEj+3UCaGgmhbCk7L4qvF3m9v054STbz19qXrLmHMDIrFbksEfTdsPMPZid0FuXqUsuWRFrt7SCCAJ0iZydbDpTF0lQJHd6eXm32ZJFFr8qJVpaCi0XzB1V3dzxKA7CCjfTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787827050; c=relaxed/simple;
	bh=NuWq4jPuUw53jPoNZAro76mB0yUqP4Z4sizmqHVytkQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gNWVtebOFPU/VJ1F4mVl8Wm3PuylSrRMiUUEt+0OnB6rnsClMuaLC1u38jY04lrXXmrANugMoyU3xeGXibtu9E5pBESSvidkgAhDvQ/5meYA2Hzd30eE3Ertgyod0b6E3SuvnoJ434cVAwpl6BTZ33YGDOg7k4dcPAYcCoP4AJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQbiDOfg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQbiDOfg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080BD1F000E9;
	Thu, 27 Aug 2026 10:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787827049;
	bh=NuWq4jPuUw53jPoNZAro76mB0yUqP4Z4sizmqHVytkQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mQbiDOfgaNDlf2OSb8EbfZ2ofnoHSnKX+zbg5oQnYX4rgtA3dFw+moFRe4wlyDfbo
	 mMuVlsmMnC5Xxch/bAZbXx1DGsiJzNTThD0OCtPJ3beS/qzB3QIRR+0OIEGUZk8iki
	 MbYBMfOgDeoWd/6J07z7xNo0BtDxiVzfkKGlqGTzdJ2VhCa7ELTNgukuXbobjP+LF9
	 T86vdRPuKz/l8F/42ztcYG3W6DG/2CUi7ttD/jeOdRW4N0BxU6fkmWzUzSWDSbyv02
	 +hvq90jieVRDLwH1LIEJnUOsiSZ7/IyY5bA5gJNOMkXaw6l7BhigQm8MJparivNXNv
	 GcJZTPxP7+Oxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/mm: Simplify crst_table_upgrade()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260827102832.3823857-1-hca@linux.ibm.com>
References: <20260827102832.3823857-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 10:37:28 +0000
Message-Id: <20260827103729.080BD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> In case of an upgrade from four to five level page tables, and a failing
> pgd allocation, the exit path of crst_table_upgrade() would incorrectly
> dereference the p4d NULL pointer via pagetable_dtor().
>=20
> Address this by reworking crst_table_upgrade(), which basically is a
> revert of [1]. Take into account that GFP_KERNEL order-2 allocation
> failures are very unlikely. Therefore keep the code as simple as
> possible:
>=20
> In case of an upgrade from three to five levels, and an allocation
> failure of the fifth page table level, keep the upgrade to four levels
> instead of reverting back to three levels. This allows to keep error
> handling minimal.
>=20
> [1] commit 31932757c612 ("s390/mm: optimize page table upgrade routine")
>=20
> Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827102832.3823=
857-1-hca@linux.ibm.com?part=3D1

