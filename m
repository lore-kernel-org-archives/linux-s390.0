Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79244A2A5C;
	Wed, 16 Sep 2026 21:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789595106; cv=none; b=tcvRaplDYfTD/y+0r8zKjrdG1ZAaBxyyl4VofXGWGpXcCWS6+J0QqbfzETc1y3b7K/GJNj2MKtsDhzI45MczEeTR0MUVKzwzXTDNU+bjP2Wl+2vXIhWO992nenRPamixvp28595IeiXH526LCW/A6G6XWRumUn6r5nnaUHI+fy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789595106; c=relaxed/simple;
	bh=jpDEVb+hvcUwXdHeSb9u09S3YBFkKwfr+Vk+WnqK7ZI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TynP60ZPtK4fLZyWJmEb51bwDhqb+FN1fom2TpFgvGSGp0AkjPpC1xtZtmDoTU/UXPP2zrahVWSZUzOJrynRK/HQ1pJ2QUJNr5CDWkxz7+LtCRPuZ0tS9ZtUccdrpvXf81bb5cZr6I80LZKMq5Q2nw3effT8f/PghqU8U9/Kf2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anqqSgNs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anqqSgNs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760601F000FF;
	Wed, 16 Sep 2026 21:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789595065;
	bh=jpDEVb+hvcUwXdHeSb9u09S3YBFkKwfr+Vk+WnqK7ZI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=anqqSgNsiwdjg8jBTYqrFD5xt7D5JnDbCZMZnUYusUDB1DvaQIF0Xty5krm1DM4e/
	 Km4qA3gSJLEkR86g/h4bG55sHNxOrKT+YjUm0DJEUiQ5Pco4NKd5+FuYSZxvStlHqF
	 FdrxsM9Lnna17KH1dNGGP59N/DHOm0SJaaaF6RyOle6UZqt4OcQykd2V+LBHrrwFm0
	 b3VSFAkMzfI9oySj/qM0r+wa3yy2+w5ADhPKv2xPC3U6CxQog36rM3WeP7mytsAiXY
	 oP2xJrXKdhQunuI8LqE7C0hDCxSyHPXWgzjtK7f99mSU7rMFjF/2CCOscUj2hNFq6z
	 yfV37tstTrWsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/4] s390/pci: Hold fmb_lock when enabling or
 disabling PCI devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Elghoul" <oelghoul@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260916213222.233-2-oelghoul@linux.ibm.com>
References: <20260916213222.233-1-oelghoul@linux.ibm.com>
 <20260916213222.233-2-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 21:44:24 +0000
Message-Id: <20260916214425.760601F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Ensure that fmb_lock is held by pcibios_enable_device() and
> pcibios_disable_device() when calling zpci_fmb_enable_device() or
> zpci_fmb_disable_device(), respectively. Additionally, assert that the
> fmb_lock is held within the latter two functions to prevent future race
> conditions regarding new callers.
>=20
> Fixes: af0a8a8453f7 ("s390/pci: implement pcibios_add_device")
> Fixes: 944239c59e93 ("s390/pci: implement pcibios_release_device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916213222.233-=
1-oelghoul@linux.ibm.com?part=3D1

