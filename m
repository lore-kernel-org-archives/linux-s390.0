Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7FB51AFC4
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906020; cv=none; b=RRormP/yJ58joJk7JUuwOKPPcWl+ZVYWN8A3UTNtUBOP+S4CqYxGTyeGDSeiw2md38Z73/5J3CP8fE5hjuGL+0JKYaywkKt5CHSKfeNh2cEKhJixpWV38ABMsAmuP6H7+PrPXAyi599/clvYzNuADFAfoFRkTxZ6QejqaaQN6lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906020; c=relaxed/simple;
	bh=6ZDebk1lQQuO8R1VY4M/rJfF87A9+fP4pq96vz0V8m0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=AMPm9ZeSNYRP/Gj+BzO3fpFPqqBTZclkqs0K6bOLelki83vgtn0zqPbSgMe+4vtXX8HZ/Vz3SRVLZcoxbQRfzuP4dSYEb4cUMglTKrzBq7oDXw6Fec5yMuCftG1gYol1unbIEAEazLXJxibg7vs/cRYNGE6EXkD8r5NdchJkE7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzc0ETG6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzc0ETG6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3E411F000FF;
	Tue, 13 Oct 2026 15:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791906019;
	bh=6ZDebk1lQQuO8R1VY4M/rJfF87A9+fP4pq96vz0V8m0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lzc0ETG66WsaoEXpGNtrMAuTcyT0q31HlCd/xmxrfyjZjnEGjQ+HTTRrIS53fZOVw
	 s/plwgkQO3/1ZVGaLyEd9d+naTaS54qHguB+weZ8aXGfXTfhpiorpYFXRP45lWDWKf
	 be1dSq4UI8UPMRHCjlQcAqX20jI4n9Vrdku8rUdtdeTpoIj3jPE8uzs1YZKCwzomE+
	 v8BJGThAMpv6vrT73k0Jqat8m+K+omrp7NEEkvlzzyjmY6FXT+xvO24BBSCFTY0XrX
	 uwsSmpQFTZt+yA1wfNybAujm9ODLk4XsHHdYIzO0cQdms7VreyS7JA2R4++XwCWa9n
	 w434WNnDu01lw==
Message-ID: <sashiko-outbox-170031@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 02/15] s390/vfio-ap: Data structures for facilitating
 vfio device migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261013153219.3534306-3-akrowiak@linux.ibm.com>
References: <20261013153219.3534306-1-akrowiak@linux.ibm.com>
 <20261013153219.3534306-3-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 15:40:18 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Creates the data structures used to facilitate state transitions during
> vfio device migration.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013153219.3534=
306-1-akrowiak@linux.ibm.com?part=3D2

