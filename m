Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CB0437859;
	Mon, 27 Jul 2026 17:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785174749; cv=none; b=ak1lU+wr4XeHgFUdJzO/GVGv9EHXbDXnaqDAjlpBwoHktxC7reE+XRvQZgAqcMEM+4Ti/uH4kwuVZ0BR6oKpTr3fhIE4F8/lyaJcefmrI6xl/06er+N6LpjEJEMX2QChAtxY3Kl8Hjv+Mu2G7KAvgzL1QqhlTzjFS3MYyvQL4fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785174749; c=relaxed/simple;
	bh=WnRXIwIWimzPTidjcHG/2WI7rSlOJFRFk8CWk62BlQQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BMVXPfZPk3WydXTEdmWgysIGEjXLvB3Y1kzUXgJNSoSn4yoQ0QpNTOnsx9xRCXCpz/qEh41NmiqobSYwwFKP3aW1U4FA3tw2T94P9lvVgbxoUNhha44Lla2MtsDFx/hS2A1OUH5F+Att2cRPdG4tvHf64SSlpcEqyCeXcPKKIZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxF9xZhY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxF9xZhY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC2FA1F00A3A;
	Mon, 27 Jul 2026 17:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785174744;
	bh=WnRXIwIWimzPTidjcHG/2WI7rSlOJFRFk8CWk62BlQQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JxF9xZhYxJTNBj1VAKatsVBr8sA5FzUZwEUtaZiWa0wbWsD3iTNjiHghyK2yORS+W
	 08ILvE8OQsazjSTqJmyDhk6+OCjychWcEqYhRaC7GaQC/jMec/P6jle9LmmRnl3/Bd
	 jPQEb6MBn+MFq1Yaczp7ebHmgOBFInEly5RvpGO+b4M63IP/oA5qM3j6l/oJ8UDxC9
	 e0We4r1Gi6l/R5gB7dXw/rcE4EmIT+Km/2IjbrSNE8Uc89WYJCrbs6secB4enRZYAU
	 C56rPAlj5UAgSNzYt02uEwPDykAeRLwJxgV5hwy1tyKFiOwFGLvVJr0+usxdWEn9FW
	 yFFrRePJfMtvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 04/15] s390/vfio-ap: Reset migration state in
 VFIO_DEVICE_RESET ioctl handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260727173239.2420754-5-akrowiak@linux.ibm.com>
References: <20260727173239.2420754-1-akrowiak@linux.ibm.com>
 <20260727173239.2420754-5-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 17:52:23 +0000
Message-Id: <20260727175223.CC2FA1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> According to the VFIO migration specifications, userspace must issue a
> VFIO_DEVICE_RESET ioctl if a vfio device enters an error state or fails a
> state transition to recover the device and return its migration state to
> RUNNING. This patch adds a function that is called when a VFIO_DEVICE_RES=
ET
> is issued that releases the migration files and frees the storage allocat=
ed
> for maintaining the migration state.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727173239.2420=
754-1-akrowiak@linux.ibm.com?part=3D4

