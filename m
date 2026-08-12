Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0982E3955CD;
	Wed, 12 Aug 2026 16:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551317; cv=none; b=qTRpfhtdmo98k3Q99iMpnwMTA3riqKararhZ6UBgIhhaov/inbkEYc6X6mA7cu+udxfHnihNHrXfzh3w0BgrnUAw9Px70URkDp2/xzsYmBWsfrb4VkichWGqtMikOJ9YGf9cevtCRltYU+Uj07M8u1q7pg6PVW3aNYT3ODIHh+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551317; c=relaxed/simple;
	bh=nkJ1vlWhnog9ZdIKcHRGPPH5Pd7+bfU+NFE7Aw/8mLk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rgoW6V1BeVDqLtfGezxfdvrPMqm0dfcgpXd5H9J9M5aL8YO4ViSzTkuZOZCbcZbLxNq342D/jqAcck57TsvpyWmcgREDsKV7Oae8rPN81IpbwR1JZy0qhCWlJm5eqfRPpTlY9GCpWvCLDLuis7b7l0Bdfw9pCcdAQZZ7jmERd1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7tfW+1G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7tfW+1G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5A01F000E9;
	Wed, 12 Aug 2026 16:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786551315;
	bh=nkJ1vlWhnog9ZdIKcHRGPPH5Pd7+bfU+NFE7Aw/8mLk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B7tfW+1GoHiRqyooFrnHPaTdqdGkbcT4lTJvxZlhnfoGfwPaACZ3bFisQ/9Bhr0pD
	 7wYZcAw1p4bV8SdphNaBBmwQyivt6j0p7ATY2Mdb4BC6CL+1rhPMJh2gQWhlgCtE9k
	 DywJPRakJb2bRfEM+YQEhvAdx5tVF3W66uw9sIbjp6kh1KvU7Dg7oT8DTXQMD899xy
	 nmTeGAv1m05egF/OYSRw5Pnqu8pdV4XtkWDYyvCk51XIPAwXTs8jNOn5ILS8pny5w1
	 wwBSMqRJdRQ6zVuykNpXNs6fE8DNFSxVYU0KIX3AhGq+WqOr1dSJ2XCUSRue4o2+u0
	 I9cvraEhTPaOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] s390/uv: Prevent potential out-of-bounds read
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>
In-Reply-To: <20260812-uv_secrets_fix-v3-2-a85bd29e0666@linux.ibm.com>
References: <20260812-uv_secrets_fix-v3-0-a85bd29e0666@linux.ibm.com>
 <20260812-uv_secrets_fix-v3-2-a85bd29e0666@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 16:15:14 +0000
Message-Id: <20260812161515.4C5A01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When the system has more than 85 secrets, the uv_secret_list struct
> array only holds up to 85 items per page, resulting in an out of bounds
> read in find_secret_in_page if the targeted secret is in the next page
> or not stored at all.
>=20
> Fix this by looping over the number of stored secrets which is the
> per sub-list count of stored secrets and not the overall count.
>=20
> Fixes: 7c9137af2042 ("s390/uv: Retrieve UV secrets support")
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-uv_secrets=
_fix-v3-0-a85bd29e0666@linux.ibm.com?part=3D2

