Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC664AD4A1
	for <linux-s390@vger.kernel.org>; Mon,  5 Oct 2026 14:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791212197; cv=none; b=hgpncavE+gpFp5fHvciWMyIjAzyyTzTJuwID/yVcTIlybOjZJWgvWiwPuCaqLlr/l5rWPHVuNWcxUs6zqLkgQu7XG6fMfN7XZBjV0Jcrw3pKTemjvjMJsvf7kCcFYpaZ238C1/NloAhp5TwkcZL5GPBEYXbnKDqZfuhRohtqAPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791212197; c=relaxed/simple;
	bh=uwryASB3soUNvGXDP91Pj8TrNCdpwblAXbraC9x8KDE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OgTVsRAp/jblFohp4eLeyYrjV8BIGbX9vU/AfHFGErnaYQCpfKJT6Y/sa+qOe1UIL8kdM0PIo3xtdr9ZJ0fVcOpWZ7GgwLTZGL+cflB7B/DwxHWZhKVov4ohooY8/OpBgaOd2HCPQK4l544rvtlM+B7FNePOj+d2z2VXNFHxyIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ed5S8rd3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ed5S8rd3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBEF1F000FF;
	Mon,  5 Oct 2026 14:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791212195;
	bh=uwryASB3soUNvGXDP91Pj8TrNCdpwblAXbraC9x8KDE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ed5S8rd3N5vwVDonGSdFeGcuP5hsCWPPNJR5JxFbk3B6WDeq/pete9l2BK3Q81aH6
	 2lGSU9eC5o2fU1486S6G4JTcwPjm1BqQJw45NXQIMC+VWm+egO4RURbbPvbQaku9AC
	 QqFghpvkOi+Su3CCfgwYS13Xrik3rRrdKXzrnLBc70ISShYF6vwK3keIkYEd7fkBD2
	 E0QkWuzV828fPNtCeV7lQRP/VouTHVQ6YUJqymSyuZv1GGDMZqaFT1kdMavEOLsb65
	 LOkm+Ky5+L+Rya3Ou/Tw+OLp1zj/Zhq+snCM6xm9IyzruY1hdazLew2FYOilcUV2sO
	 3PmTyjNafFRLg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/2] s390/vtime: Remove vtimer infrastructure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261005145004.156348-3-hca@linux.ibm.com>
References: <20261005145004.156348-1-hca@linux.ibm.com>
 <20261005145004.156348-3-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 14:56:33 +0000
Message-Id: <20261005145634.BEBEF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The only user is gone - remove the vtimer infrastructure.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005145004.1563=
48-1-hca@linux.ibm.com?part=3D2

