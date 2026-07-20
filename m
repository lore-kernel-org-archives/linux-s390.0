Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BB52D0C9D;
	Mon, 20 Jul 2026 09:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784539602; cv=none; b=Q/7eA0WoJrM99+frW19YE8O+8AS/LHed3QMsk5F/buGq1sf/DH9/JiSYyyrphq6/y3qwjyKl4ue5TR16L855yVIiagN0VU3Zg/R8a6WEFWjRcWA/Rwg5yNKJ2uiGONmJFPLktHGnhQ53QhOQGj2ezfEFpU7I4wPiFXxutmEfNXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784539602; c=relaxed/simple;
	bh=PjX4aCJbESbKLKzy8PnUrea6vnbPsiCLwGPFS1jiytM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P8oQkpwSRiLYdZjOXYi8w6CZFbqWlw8qLhQY3puh/f49zUWQXuXNiylrLDR48rkb7FJAh0rMtsKOvmwCc4tGPcAmqFW97sJcDM24xnfRmIldh/GjzhJnFfbYX469R8cLtWJkZpzCyTmlkBY1ToZOsWqAG2xRi0m98h+rMo82WGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRaZJSfX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRaZJSfX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0B41F000E9;
	Mon, 20 Jul 2026 09:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784539601;
	bh=PjX4aCJbESbKLKzy8PnUrea6vnbPsiCLwGPFS1jiytM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mRaZJSfXeVvbOQw/EPfDdwFqmlNJeG4T33Vn0K7lN3HXukko7akd73Pd9B4vfnuMO
	 RkOC14i9DMWWKdgL+vcal6fm3HGbLDzD3MevY6FOQfImqPSCubDKmDN1IW30XF5Rvh
	 Fsw2StvLpAV1J5FkjCZIGz1RBCqEIPzr8JphO6WhUT4Q/6Fm71gn34BgnDWNeZKc8o
	 FLRt1sVF2j0LpVrq+cjiAb4Q/vptZ/wwbEcO9m6MPfvjuVIDbPs9WNKPlEh+MwMGBv
	 R/g5/Q0ofy4EuWYI5MzldHfS8h0qsIZ7j9T4y0yeWbScofyh7vpga6tFmMZTGxtU2d
	 njfcMr7vfgWaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/8] s390/mm: Use handle_fault_error() in
 do_secure_storage_access()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260720085834.898025-7-hca@linux.ibm.com>
References: <20260720085834.898025-1-hca@linux.ibm.com>
 <20260720085834.898025-7-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 09:26:41 +0000
Message-Id: <20260720092641.7F0B41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Similar to the normal exception handler use handle_fault_error() which
> handles accesses from user space and kernel space differently.
>=20
> This also addresses failing kernel accesses via e.g. copy_from_user()to
> user space: instead of an endless loop, the fixup handling is performed.
> Even though this could only happen if arch_make_folio_accessible() would
> permanently fail, which is not realistic.
>=20
> Therefore this is rather a cleanup patch.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720085834.8980=
25-1-hca@linux.ibm.com?part=3D6

