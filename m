Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B6B17BCA;
	Sat, 25 Jul 2026 15:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784993680; cv=none; b=Smc78me11CjRs4WGTOflFRU6JnV6mjpEE4WVX9XrbVt4H3eYV7/2tpbVKk4OEVZ90dCZcgSVZRVyrdyB+GMUycITC/Qq84H+QUS9IgOWK0h0JT+hvaTqoJ0Cls0AUBE4X4Z4pHbyYDW5Almgx30n5AeJeisT9x+bXrvTCuFtFCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784993680; c=relaxed/simple;
	bh=1yKaRR74ASTmqy2iiDaxqYk8W2YNuWL0vMr+q6/0jjM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dzOCgufXEBOlUa7MlCqecUsZTeLMCKMUGOBewg1QkLmsVL521WMJczvRoEoqqTIiDGAN74o4QWmIGK7fbI3LvXezSqX50xfF4XC4kWKaHmaPYaMQbuN/1Atu0Ibq1uRkT3eYuIf+kTCJ3jb6yEklJKoquGRdG6P4mg5sB02aVj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AalQSPlZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AalQSPlZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3AB1F000E9;
	Sat, 25 Jul 2026 15:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784993677;
	bh=1yKaRR74ASTmqy2iiDaxqYk8W2YNuWL0vMr+q6/0jjM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AalQSPlZnAKPq/weCHdsJR6pMgGSX4owyhqo3Sh/A3sPFxvvO7wNBbsN2zNmqAHta
	 Yn+k9CWISmVSZ0bEPVqziUbIQX7KgyOBvGpN90jjZnqCgDSJB4cD2pS8TB0mhBVbPK
	 MBLDdi4ooMSwkocvnPjX4acRkYFH9LbYLCUWnaGj/9LwXE/yviObI3bumCtf8wWDvO
	 aO8x1cLQt0wq5hp5cZobijHTe7rKMZy4prEgjQx/5P4jHn57Q7UGA7VcymF18NTZMa
	 k5FklRkHxz/x+FZWvJcBFH0ae9oKB16phvmB/0ehSSSxShfzShhhQ6Z1zichb0Mfhl
	 OOxYeMC0NdGjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/9] s390/vfio_ccw: calculate idal length based on
 idaw type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260725152705.3958100-6-farman@linux.ibm.com>
References: <20260725152705.3958100-1-farman@linux.ibm.com>
 <20260725152705.3958100-6-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 15:34:37 +0000
Message-Id: <20260725153437.9A3AB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Sashiko pointed out that get_guest_idal() unconditionally calculates
> the length of the IDAL presuming everything is a Format-2 IDAW.
>=20
> The output of vfio-ccw is always Format-2, but the input can be either
> Format-1 (31-bit addresses) or Format-2 (64-bit addresses). As a result,
> the size of the guest IDAL may be incorrect and should be trimmed down.
>=20
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/r/20260720203400.7328E1F000E9@smtp.kernel.o=
rg/
> Fixes: 1b676fe3d9d3 ("vfio/ccw: handle a guest Format-1 IDAL")
> Cc: stable@vger.kernel.org
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725152705.3958=
100-1-farman@linux.ibm.com?part=3D5

