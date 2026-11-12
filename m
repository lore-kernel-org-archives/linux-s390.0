Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794457890;
	b=WwqdlPNG8jfheSCyxE5GpFeRX12VBLBve8K2MEvySG3zkqCxhcIpF7byeh5q5m/PGPKZ
	 sGrTsBbtj28CIbuvYE7OkyUCh0Hc15yh45s6StnVE5/Pc5nW6r/s1YUZ491DL3drVyIS+
	 m6amKRWkROC9xD+InrN8yEhK38HfEKWYAe0PTFARKW8S9Ho4lo1V7UU6/P6ogtx33ERx5
	 AAmlUOCZ6NaewTTc8CDnXBGKnXWs0D9O1tfsXSjwS2vL/2xuit8edFPLetHCPP8QmI73Q
	 96dNfRaiqw807oK2LJHaGRasaCo6p+ew0sptm89eocgnHFG8kcemOWTDdTJeMj1N2Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794457890;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZZDX/Dk4rS9pIdvgJRvgNQamhyrXwIbvMfMiSrpVJwY=;
	b=wvFid0O3zi6SizTnz4YJ0OFa52w9XJqGqs2evjUfUDGitY8VFjvDlMI0T8/KExkHNSeD
	 5lJAcKhzGFBLeShAtrB+I2qW4kysMaOcE13urNq7LOlXzg+f15cMfZ908nFxhXQC7I8f5
	 KZlB8wSiHwBGSeFxQBPtJpxjCtowNw9OXAQjeGxPBRUC2B4iZ2D7vgNqHADzCmcCU7b6h
	 FSYQ4fQDta5pv6SKIp/X5ovukystUJG1xvg8tQwwLp8/bQThJT6UtLBJGBM7rjXLC7rHv
	 wJg3gVmHUe71MOc4eIMl/BS0/WM2SgbuiER4jwxKFtUUkPwgFFY2OmT0GMAO3UpxlcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P7PLbq94;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3222606A31C;
	Thu, 12 Nov 2026 04:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P7PLbq94
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566331F00A05;
	Thu, 12 Nov 2026 04:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794457889;
	bh=ZZDX/Dk4rS9pIdvgJRvgNQamhyrXwIbvMfMiSrpVJwY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P7PLbq94Gs444V7sbHUvMW7n6ikxcphBSqPktd8eTFGH4aq6gnMI/acCYptqcpyYv
	 KLB/sMhYP9MUnD2rDnahBb3di5qKs0zFYyEUUOzrSi5LpQ3DvyzVpem81emrHmpk3h
	 +p9mJp81we8VqdPpRbkDbxmY2wYfHo93t3IQ0QI8zrHnMT2Qz922BpXFT2Bs8cJDZn
	 y5Z5GoEKCUgonCeptDWZrBFszIp1M3921eC/QeiYicjc9f4dxbMs9wkg8B4Q81FpQv
	 1WWuMBDhOBKvsW2y1yfqY90zRcT6ttjBW0+zKpsDH6OpK5tdigbiJT9PkwEeScWnWv
	 ZUqDekgNg/8mg==
Message-ID: <sashiko-outbox-210349@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/13] NFSv4: Clear idmap keyring cache when the last
 client unloads
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261112040242.247168-4-jarkko@kernel.org>
References: <20261112040242.247168-1-jarkko@kernel.org>
 <20261112040242.247168-4-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 04:31:28 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> id_resolver_cache->thread_keyring caches id_resolver_legacy keys up until
> nfs_idmap_quit() tears down the keyring.
>=20
> Once keys pin to the kernel module of their key type, the cached keys
> prevent module_exit() from ever happening.
>=20
> Track the active idmap instances under a mutex and clear the idmap cache
> keyring once the last client has been destroyed.
>=20
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112040242.2471=
68-1-jarkko@kernel.org?part=3D3

