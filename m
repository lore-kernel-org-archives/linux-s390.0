Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573214D0CF2;
	Fri,  9 Oct 2026 11:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791547014; cv=none; b=Q093dRQNonwlGLZ6FVZcVLM6LQKA4vMBDdcbWCxzxut2YaMfkaCujfZDDKKnbgA/F5sPnvusNXFDgel1CLpig9KNb054q6BcdLOmcqNWI4vjMY4pcXY3ywtuomNtiyjDhxDdHIEMiy8PljiqdaSYo6lG/L2IJDkgSg2pKSbaVvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791547014; c=relaxed/simple;
	bh=RlPj/sswgdTpCcpWY5zXOXatokyuXp2CzsU4RNE5SUc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=MS8+oAZQplfjdbGq2H4e9TZV/R2H27TkSSiEGg2Coff9k9L0wVjevuzjI30RpLb008W70YowpU2WjwxUSXr8OHO6D4dsln1Lon27eGThVhHLxyx0Z7tx8GwV55HgQT4c8bxdvsVlvzuOw7AAHHQFB69B9ZwjmlSkXUux8IzjGXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OkRYO41/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkRYO41/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C51D1F000FF;
	Fri,  9 Oct 2026 11:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791547007;
	bh=RlPj/sswgdTpCcpWY5zXOXatokyuXp2CzsU4RNE5SUc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OkRYO41/c9ZoXMSEZ00ABjiStSGwIBbmmKHgepg5griDlA4+5bYpj/LOSyPygeNVm
	 +3QP5oPit/osI9gRiE3tN8GeFJmsw94LkBJHgjhxK+mw1WyTol7by0+eXzy1LvxcrG
	 1fgiSHYlEBSdGgZKQXMXV7gPru+p+kmG4CqzDsib7L64NMsOUs4GWajusoRfhLmXR8
	 XO8HZ9n2SelQKW0eRuPcUmVuq3axU82R07RnwMmSAgY7y2EQTYGUloK+wXgh3bsKPK
	 UEh60ZbmIKxOUEQZKwl3vJoN4Dw8eQevBek4xIuO0rjL78s1Vjnyz78hwhvMrRkVCL
	 71hPx4rZwurjg==
Message-ID: <sashiko-outbox-165454@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 14/15] s390/vfio-ap: Add 'migratable' feature to
 sysfs 'features' attribute
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20261009114244.1213173-15-akrowiak@linux.ibm.com>
References: <20261009114244.1213173-1-akrowiak@linux.ibm.com>
 <20261009114244.1213173-15-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 11:56:47 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Add the 'migration' feature to the features provided by the sysfs
> /sys/devices/vfio_ap/matrix/feature attribute to indicate that migration
> of vfio devices is supported. Since live guest migration is not supported
> for SE guests, the 'migration' feature will not be included when the
> feature attribute is displayed.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009114244.1213=
173-1-akrowiak@linux.ibm.com?part=3D14

