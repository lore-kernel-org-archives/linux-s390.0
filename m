Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EDD4DA9AC;
	Fri,  9 Oct 2026 11:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546541; cv=none; b=sirL8sPbJpcPFLMrDNhPIXEq/QIO/2hzNqG5HU2PHZJO9zTGKfZKdXf5afLurDkH/BeTb4XBEaDxEjcCFB3APrfzxtuCK4BmkdXfE/RIhG3mQ3AqiKZnIesSlbl2cjb2HZyEYjs4dRN1acQCdaTl6Oe5FtE3EuWgiaGRFTFhKUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546541; c=relaxed/simple;
	bh=F2j+qlXzUm3e/LDSO5Ug14ANo2HC1DdF80YbTzmUUBo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=lV0xkRRVSglt2i3QEVUeCOGT+mzgnno1czsLUMSXW1BP4EKM/4Mr0YYXnB9D+SxKaK7C3H+JKErglxyIfT/Wp+WHEye1PDbmiIF0cMfxR1a36qyP3Wc/ZyYFXS5nI7/MrRAvpOzhEi3K3t9TWxiMMWW5Ksj5SQLJNpt9F+4kG7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KsaGcwpz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KsaGcwpz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8541F000FF;
	Fri,  9 Oct 2026 11:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791546533;
	bh=F2j+qlXzUm3e/LDSO5Ug14ANo2HC1DdF80YbTzmUUBo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KsaGcwpzMOByHoeDtpomHKEkGwf/6hDQ6+mdqvHin9QXHsa/sywgStKyaeQAkxC62
	 qEkyFKb7F+HFPd/xDzQHOjicGADUlsUtxHw/ceLyT8kqyEYKWerD5gDSonmKgfkv+u
	 63hW15PYB+YSyldTrtygAn7FYlLaUxt01l9MPgqV0uMl81OlRPBR4EmD+OKCD+r1Wg
	 Uurwl5pWHSCIjbwYaKFsojrfGAKONNeO8UyYJDOUyAOA5yPVVJfAI7pc+sjkVOUVHB
	 k2YyiXflGS+7QJWCvpjRU23JnKiTps54wx9HWmgMYyXxeQsSyY0w3yuaOwL0i+PpdW
	 2FkcuUOYJGQGg==
Message-ID: <sashiko-outbox-165413@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 01/15] s390/vfio-ap: Provide function to get the
 number of queues assigned to mdev
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20261009114244.1213173-2-akrowiak@linux.ibm.com>
References: <20261009114244.1213173-1-akrowiak@linux.ibm.com>
 <20261009114244.1213173-2-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 11:48:53 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Provides a function that returns the number of queues that are or will be
> passed through to a guest when the mdev is attached to a guest.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009114244.1213=
173-1-akrowiak@linux.ibm.com?part=3D1

