Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91978384CFE;
	Mon, 15 Jun 2026 18:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781549008; cv=none; b=b+RmnYVLiFwpvevUbwSl4VAGOGap3HvFgX5vyOOAC7LOq6HBogZDDglugpq6435kNHMIxe/4kTmpXbpL5tcFS9sUP/T0BLzFA5ZeTCdxVjstIABiIPHXITHl6GfzT/53uADIAqahKX5x68dq4mXrYBGfGbMMMxvRB/S2kyycT+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781549008; c=relaxed/simple;
	bh=gAHWoaIMppzVt4xsEJ3Z53tk/3acxcW84EX9P8gk0Dk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gqlYMResI/frZ/gc8LYf5m0UesKhjG1RbqoFSsAxjJhuuap39TeoOQAYnsBYYEZj39dSijKACxOLhsitrHgIjcTwrqF+Gohwlk4vamiGo4NFknRs1+aEJMSn+EGBJOyhjMHSFjvzvsqwWwWFh0ecxo8ywL8AXDWuUVWqWTAIa88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEH+P9qt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEH+P9qt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B7381F000E9;
	Mon, 15 Jun 2026 18:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781549007;
	bh=gAHWoaIMppzVt4xsEJ3Z53tk/3acxcW84EX9P8gk0Dk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UEH+P9qtUnWpum6Uv0JM5BzUog6xJQo9+cl3cQD/tcVhN5fE8fdU5y9/8DCku2ZV2
	 oWU3dLiUTqNHAvLTcTvPvHymMoQBlSQhs0EVg/PlBrnERvDlXWB+dltksgDZUOF3jI
	 mf4JN8su4p+bHkBN+T0zp6fNIhSA2Umm8l7crAmLPufPbnu74mUY61qEZCArH6c3Qt
	 MQX377ivylDK0SimuyDBMra3s+kYfj1fIOfX/ziAPeB5Tz6xbZtNUSNdFlcX7i0FoO
	 XW9xCNXOjlHPj3iX3eueSqnJjq04DRZ1qOLSACXNsqS5SM3aYXeuVh2+4yD51PBcBO
	 y8e5xn5zoKhWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 3/4] PCI: Fail FLR when config space is inaccessible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: linux-pci@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260615183524.2880-4-alifm@linux.ibm.com>
References: <20260615183524.2880-4-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 18:43:26 +0000
Message-Id: <20260615184327.0B7381F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> If a device is in an error state, then it's config space may not be
> accssible. Add additional check to validate if a device's config space is
> accessible before doing an FLR reset.
>=20
> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615183524.2880=
-1-alifm@linux.ibm.com?part=3D3

