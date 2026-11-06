Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793979021;
	b=ibzUlqz5DZ/BjKzAdXBBGZkve7ZC1JzUwXlII3w4HuB9lqdQhI0vJv7fNnvaiaYJDg9c
	 R/R5zehezW7ABjf4JKMW6hmPlAb7KPcKZf91FnGwgVu+45iXnkAPiz2SAHolCtCjGhVwX
	 UXWfbP8XP2EFYX2u681mwRTJHErJmo/ihhZey+dSrXD5BYXW/hnfBK/DfNFqBFTH399dP
	 tVvvBk9koxx/qYcO14P6patJfZrQSE0osmFpBkfBkl+vR2rQWrCUcNcRX3g9znjvN40Tx
	 5VLkmlIsnO0G92MsfJ6wskxICgE2nIOrJv0lftsnEOYDjZA9lNYu9i7H2033Nc4AWoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793979021;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=juaWQxsEhmNFzix+jE6etMj0wZNIjClbWaW3OpvhDCM=;
	b=G4O9nxXyfrm6queFdMZF1ftnG0yzsnhUeSRKvLCl4OBGSsTJAe0kdENnYN/ReCEAyg1+
	 d2r460lMeGYL4kUY4LoDFLZtgrKVnjGF720V3x71yxAhrpwTNgmf8cfaZP0B4gMCvxXni
	 iabqJFw03onGK/EnbqH6rFsbh3/okmJhOfB7qmJHjTmxGzU6k7/qxjnCEcsCCp/zoc3mP
	 6q8FNdSHdLkrhASCZC3tuBmOhOWNZWvNNBOxJOyVlJVlfiyaqYtA0L7SAaTElubYw2D0U
	 WpbQ3EOjl/F558L1CNPH34vW5/6a8i9ZABDaj8EoVgsXbvG65hBL32cb8J0WXLG+tlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ep2G5Cw/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5419606A32C
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 15:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ep2G5Cw/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 019EC1F008A1;
	Fri,  6 Nov 2026 15:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793979020;
	bh=juaWQxsEhmNFzix+jE6etMj0wZNIjClbWaW3OpvhDCM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ep2G5Cw/ZYq/hE32shzuY7phTrOIO3iewtYA4PwUGs5GU517E8db7H0Ip3y2aaMe1
	 ghF4CTFDH9Y/7cgrtqcbTzACC2PVXXlZ8wJjU7oOFP/LY9c18BPpqA7uOS7YZK+BIo
	 uYXHM2Ecqze34mElftOzXoMCj6ZIP6ySq1KJ9ee0FmTwc8pNDMdkFxXDQzGNBtWFZ8
	 Sd6xxfAo9t0H7vB84B5alkATVbtHUD9m9Eaqy42FwcDS1gqw+OaaKiZDpxcyprzRy7
	 6FA5Ox/3YubM8D190NnAFgc9FQgsECAZzSMDMtsdr1GzjvWTNPd6ss3d064GBZkuKy
	 xYrWAlQh1EmCQ==
Message-ID: <sashiko-outbox-201696@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 01/14] s390/vfio-ap: Provide function to get the
 number of queues assigned to mdev
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106152259.1360651-2-akrowiak@linux.ibm.com>
References: <20261106152259.1360651-1-akrowiak@linux.ibm.com>
 <20261106152259.1360651-2-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 15:30:19 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Provides a function that returns the number of queues that are or will be
> passed through to a guest when the mdev is attached to a guest.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106152259.1360=
651-1-akrowiak@linux.ibm.com?part=3D1

