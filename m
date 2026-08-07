Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04903C1F43;
	Fri,  7 Aug 2026 22:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786143295; cv=none; b=IcsG7XbRWFGtyuBHh8eJfQBHucNUBlYtMNuHULNtwtyPGvTqanJxIXOghw6CYptV/B0at+PxR0m3Lsr6gE371OzxOEHvy/ezgLjuvG9nb5pjjPajuG/2jHSRmR+/2rcTtoxqJcc+n0AP90Sv0+1tvcTGatYcZzOu2DmNy/UzCm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786143295; c=relaxed/simple;
	bh=79eCwqGfHm8xK90Tpd1W0vuiPt8Mg0DOqJwsWW4bOEY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bBqwsOvHuR9kVYYy+vfG5Lsk6A1cYh0OdmugFSSQfR9b87csk2fEsjMIu6dh5jMobwN13mrfTcV+Ht2+kJVb/ZNsAehTE39aAADrijHnepO+SjmtsabNeKKMJPtq+MerxOfpF2a6QuBC0UXtcJXGbMQcpx3ThTGwWW0lv0fNZp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/OmtFvK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/OmtFvK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40DF61F000E9;
	Fri,  7 Aug 2026 22:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786143294;
	bh=79eCwqGfHm8xK90Tpd1W0vuiPt8Mg0DOqJwsWW4bOEY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M/OmtFvKjRqvYzcsOkY3P6SU5auwp4q+xqRXrM0AWlV+1n9vxJmLsFWVXfHPK7cRs
	 blnMEwJF3rGQ/2lDosCSSqBa7YgtUfIzpGsOfJO/2ptigQnIcs/1h/UJ8yitmF/Z7+
	 93eRmJItsutgW6sSpWMs671Z/0eW0ZLqwNvsuEhE9x7wnirwfgSZtTF1dhkl0E321V
	 hj4YUlRQBWynNNLjL2FyI2L4wSrE7YioK7QBvYWv3kB91KSCwjENkpP3zNXpkiHBVy
	 K3NE+Enyven7H2IuvNTzgraG9nLBRptlSJ8NQIhIX2RKdkZHlOxs18AwnCkv7mN1O5
	 HihyB8gVqxr/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 04/15] s390/vfio-ap: Reset migration state in
 VFIO_DEVICE_RESET ioctl handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260807221834.562851-5-akrowiak@linux.ibm.com>
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-5-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 22:54:53 +0000
Message-Id: <20260807225454.40DF61F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807221834.5628=
51-1-akrowiak@linux.ibm.com?part=3D4

