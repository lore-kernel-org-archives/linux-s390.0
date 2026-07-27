Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B77834D4CE;
	Mon, 27 Jul 2026 19:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785181969; cv=none; b=ntQhkKGJQrdXARq4belrXi5rDBe3/YC/89+mpjj7gI6udEI9XesEIp7ffu1ObnDG3ellLA1MppjXY7NF53h5YLlTKTHYyahhlSh4ypZhCxmZ5gT+xC18nH6ZUB1UsGSor8gAqiBOK4L9JJOi/4DNhEs/fa9xtnDmT7o3IDBlufE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785181969; c=relaxed/simple;
	bh=fF5sjsGNWKvL1GnzFlg0YiF2q1494y49Ij+AqxeyPQg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kC8P3iEOvZtf8Bar4HO3yrmAarAxJaGC4xTiZbBaLORCzBNf8XJTJgrfv+VknWBhlQ6wejGVGsUK369PkWqmTbvEhPmRZVHOPUwJsWHJmiyvWvmCUI3OIwJGz/H4zFs3peYGMNyK5hZHEo1a35oLfJZ6i90HGBQ9a2ARujzUAuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6OAjKnv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6OAjKnv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09811F00A3A;
	Mon, 27 Jul 2026 19:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785181968;
	bh=fF5sjsGNWKvL1GnzFlg0YiF2q1494y49Ij+AqxeyPQg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g6OAjKnvRfR35uacJBwWu+7Wq56F1Acw3WIzH3J//Q8NEeSvXA94owathRqmSRA4Z
	 LphUmOrRs4TWKLg72bJdFVYPxir5H2zu8IQMmhMyAf6NCdFXEBcHglF3hZyY8oVXd3
	 dp/hAoXUYlpR2KWHI8GjKG1pw38EpES9YUmTHSWr9xolEuXUGaYeEa1lS/5szrN03R
	 uTRkyi7EThTrcmmG4eIlKh6vtBsmwTffbi45nT5HJiz2iMzDAL3J1jf39I1UY6J8w6
	 rOsWwT8BH+FZppEXZa7mR0rwgXyecAPsPlFh8oAzWc1Bebzky/fONk5r6EecbfxApW
	 mttWWok5YEt3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/10] s390/vfio_ccw: limit the number of channel
 program segments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260727192230.2715207-3-farman@linux.ibm.com>
References: <20260727192230.2715207-1-farman@linux.ibm.com>
 <20260727192230.2715207-3-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 19:52:47 +0000
Message-Id: <20260727195247.B09811F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The processing of channel programs, and the CCWs within them, is done
> recursively. As such, there is an arbitrary (but not architectural)
> limit to the number of CCWs that can exist in a single channel program.
>=20
> The vfio-ccw logic breaks these channel programs into segments whenever
> it encounters a Transfer-In-Channel (TIC) CCW, and the combined number
> of segments count towards the global limit. Impose an equivalent limit
> to the number of segments until such logic can be made non-recursive.
>=20
> Fixes: 0a19e61e6d4c ("vfio: ccw: introduce channel program interfaces")
> Cc: stable@vger.kernel.org
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727192230.2715=
207-1-farman@linux.ibm.com?part=3D2

