Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5160A392C2A
	for <linux-s390@vger.kernel.org>; Fri, 28 Aug 2026 23:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787959566; cv=none; b=U9Ati8MvAr1FFP+TdFx85isRIIJ4foqt3CPQp8gfrlEhTAQSs6e5Myl28ctmFZMkHjOtl/6QQbAvZ7qVjk8bTXcnwDtTaggjz2si+R2KPQe8YsJjHiLigB4ttQEY6TRpAKJ9SVDw7RwrGWUa84rj9yYnaNgO6PiX4EMlihT/PR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787959566; c=relaxed/simple;
	bh=5m3DMCFviX4hCfQfDDMV0bouozEeCDy35c6xJRJuhWk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XoI1mGywx3qGIyKthG1lsH/AtLK68yvpM6UWwsRCx3eNSz9Xs9Fe0aDXXp2yglRvTN5VkFWILcJoPVDRDyJqmBgcI1RnJMxOGgCbnZzh93PIuURoH1YGq9KoJOdbqsb4HRHBpubJXgkbPFk9vHAJSr3uqXNeMuqdONVCuUEni8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBmlJ5iE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBmlJ5iE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A301F000E9;
	Fri, 28 Aug 2026 23:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787959564;
	bh=tXZR+3dD7/aGwTlGKIGnd0prep4HJ0CjfUR2wXat9xw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bBmlJ5iErdwph3xUJXsnlf3QgG/qIDQGv9JhF+NJaKgDZIyPqXUAnV7dSKzILm+LA
	 ZPWzxrtWBpo8TY8ZFH+n2+oeUgndfcedvH9s0q0FYJu2UT9SA6VMDfOC8xbw84sW4i
	 2RHtRuWDCXkkhcEgFB5HX0yF1f3ZETDl1ve2ydfX4BFuvbhNZ0EGBYphKW47cs4qCA
	 9ClVE1o6URcPD+6XV/h8q6qa/pzx0E6O5nXOwtjarWbfN7mPpm5Wv1WmETjQiMfmh6
	 iAD/CmP0JVuq+B+hZbR8bU88gqMEZgm3F5hN4gDstM7+PLLHY+NPGjaZU3XAOiKky/
	 CD4K+OQ8wiZHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/13] sparc: Use the common syscall table
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260828-tonyk-syscall_table-v6-6-fdd358456cf1@igalia.com>
References: <20260828-tonyk-syscall_table-v6-0-fdd358456cf1@igalia.com>
 <20260828-tonyk-syscall_table-v6-6-fdd358456cf1@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 23:26:04 +0000
Message-Id: <20260828232604.86A301F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Remove some of the duplicated code by using the common syscall number
> table.
>=20
> The generated files are not exactly the same as before, but they have no
> functional changes:
>=20
>  - syscall_table_32.h would generated lines like the following
>    __SYSCALL_WITH_COMPAT(422, sys_futex, sys_futex), which is equivalent =
to
>    __SYSCALL(422, sys_futex)
>=20
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-tonyk-sysc=
all_table-v6-0-fdd358456cf1@igalia.com?part=3D6

