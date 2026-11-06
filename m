Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793980367;
	b=YpDBgmxPmyljLlJktCf1fp3w3Ut4CdoAtlHtWwmCqm99o2B3OGmL5qhORSTc8BijGfRC
	 xQNGyLt+sI7y9UXTvfnLo8sMQSrtczdIy71jSVhvOzqoie5SHPO81C7Efji0r6upJmMDw
	 HR1+Tr5/s3AkfzemqSjNckVyjfz9Wur+852mJjxRxwEOhk7Qddsy0Bb3rQtV/t/xQqvne
	 xRKoxe1bYTUogCfvrXVWPcihpcY23Fmzdm0my93/2aoC6r5KHRyG+Ewj6rn9DietVFZx+
	 FB9IpRNNJre3fgnVDO0C0xc6rCHzVXl2Fna0ZrnCKO+XjejTB8rUUsrjr9rTzzYtQog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793980367;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5/v0b5mmIiVweCoQKGIqXg2dteccJQL42rDbWUOzmag=;
	b=U0GfFvuWFBOBRgAZx6SDmL54c6ZirtH/FREAQdspItNPJcGd/3O0IHd3jPpTP2fhqXyK
	 EZoDov/TY5sdOK/617JRhEawBzkWDe54YHLZyM4aqDFeRkup3GUWGhKSxXwJ2g9gQWT+T
	 QLEbBGZvQnd1cNrT11AFq6Ha6eytgPs2XR83o2vlLtffEmekyUwcwxGQL/4CiRf8Xee2M
	 dsqPp9qBVGe9MxNkmI5osx/i3Zb4YTV8lENkiAuMTedTJy8kB3BeTkxNjOcqyYQQzLbUI
	 D7+EhXpdRG1GFjYF1N+PcUdn8mG6feMlBuMPr7rgsc0L2YVpW6nUOCa7AsInFberUCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ik0d+EC5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F24606A326
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 15:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ik0d+EC5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253E11F0089F;
	Fri,  6 Nov 2026 15:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793980366;
	bh=5/v0b5mmIiVweCoQKGIqXg2dteccJQL42rDbWUOzmag=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ik0d+EC5e2X5MXY02Z7+ZtmVMN0glCZlhxhdYIt0NeQeZGXpSvmLjBUCfkQxgYAkL
	 QBtb7c0VM26AtIXD6QbWOmis694EowIe/8q/eO44XVR76Z4x+wvjaP12b1673EBHf+
	 LZ8IGHLVx73DhK1uxhiyyR1KvkAGEPtkhbVSpKkH1IdYUjVe6+QIhxWuX/bRIMdR+r
	 OxUxvitxq/1ScWIGKkln8Qn8XEUJrW1GFcHjfvy43vvKT5UsywjYt1LCJ5Dyut+MWW
	 Jrbn0YNEvjDa/eBIxr0vRY4G4KdQgNW64RKtKlbBxhsuJj5iMAYct0G09TWm/NvZVY
	 xAGpk/tdWscow==
Message-ID: <sashiko-outbox-201740@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 11/14] s390/vfio-ap: Callback to get the size of
 data to be migrated during guest migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106152259.1360651-12-akrowiak@linux.ibm.com>
References: <20261106152259.1360651-1-akrowiak@linux.ibm.com>
 <20261106152259.1360651-12-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 15:52:45 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Callback to get the estimated data length of the data that will be requir=
ed
> to complete reading of the vfio device's internal state. It's mandatory f=
or
> VFIO_DEVICE_FEATURE_MIGRATION migration support.
>=20
> The function pointer for this callback is specified via the
> 'migration_get_data_size' field of the 'vfio_migration_ops' structure
> which is stored with the VFIO device when the 'vfio_device'
> structure representing the mediated device is initialized.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106152259.1360=
651-1-akrowiak@linux.ibm.com?part=3D11

