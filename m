Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79051397
	for <linux-s390@vger.kernel.org>; Fri, 28 Aug 2026 23:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787960347; cv=none; b=gPOuop1dYBpGr355kHMgfiCkiest3r0LX/CY4t5fP5QJtKnDyaHsUwEvMOjqdDLXTPLgkLmqk3tnz9QP/xpwUmyyRjzASYZ0AtGq1HAElt0FHZjyp+h6Rheea13yUWInglaeL+pMyc3JeyPBXfxs8vdwVL0tTh5+3RWR0ABfu9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787960347; c=relaxed/simple;
	bh=n1anmCpAnC5UV8UOI5/FsjBBca0QyZ5wD1ugO9sJLQw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GUtstSgrXHlDBTKgjGd0BOJA7M46TE3VtGxhUJhZt/A1uFjdxeTbZeMs/i3HIck4Ho9ZXeDZRvMcyQSeFk1RrCKHHO8JDyMkBjV5lF4P4GmyIYgMRMH9nx9yauap8oS0XeEdOQ7dIdhMJRJMsQEr4jx02MdCacQl5EILNo/J5Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhDLw8zA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhDLw8zA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A3A1F000E9;
	Fri, 28 Aug 2026 23:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787960346;
	bh=n1anmCpAnC5UV8UOI5/FsjBBca0QyZ5wD1ugO9sJLQw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BhDLw8zAEShF0gY3JD4JVdT/aCYahoaknceoWMzMHV7ZyhSNO7mB4Ru2gka1QhRM4
	 8tn1B4NVlGI1mlrjxPyXih3kN6PpsTdMqWdEmRBD0i3qbZcsBBhKpTGdQlCJismxRl
	 coMKGuYRxDupqE7RbGnbTbpmIMcowlZHO3mecjn323CxM6gnL9E7WI6//tN2XuqfbQ
	 ECxLv8VscEFYufNcw6awhAd3k0qR/9wvc5/luNAS69K5FNS5gb8saZs+w4/hG4/x8b
	 phQCYQt8KGAQYTDIqgfA1wcrdB2VxY2qXUzPtw4XaztwNGmo2nIYRqZJPQpKyKRLob
	 /IwWaL8dZ87Mw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 13/13] alpha: Use the common syscall table
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260828-tonyk-syscall_table-v6-13-fdd358456cf1@igalia.com>
References: <20260828-tonyk-syscall_table-v6-0-fdd358456cf1@igalia.com>
 <20260828-tonyk-syscall_table-v6-13-fdd358456cf1@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 23:39:05 +0000
Message-Id: <20260828233906.12A3A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Remove some of the duplicated code by using the common syscall number
> table.
>=20
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-tonyk-sysc=
all_table-v6-0-fdd358456cf1@igalia.com?part=3D13

