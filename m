Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596221;
	b=nJRte6L4fcVnOv6jD4hpa8CxmDqede/olPfPOXxfb7JbhMaDCQZLcoWkE+srvbF1rW++
	 6mTpos6TM9j76wgmx6kw6q29JzhD+R0oPyXG3Bt2qovpi+OSDrWwX9a8BGjkZroV0d5ZI
	 /po2xIqYTOLI96kuV09q6QDRz22oVJIukgPoX+So4Q3+faT5abyx46OkloUEo+TX8HCUq
	 krQ0u75NxXf2MC68/dJK1wnqTjsuaAjXD3mtPQ5T6P+Wl1rw+etxVMp1WRkETr3JacV+o
	 nZV46Cnymw0eRIIBkE49TFfCtvEC+JLbcO7/WwLN9FLxapg0dqxxXpcIzfShuW5CMqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596221;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5PNzAELFVoAcuL2+u0PGl236dr73etAjVsgX/Bj8pno=;
	b=IDTzvAJYy+B7k3MjRidnvxGMenvm3dWbRiZ8WqUpGssix+8UTB3XjZmDZZsonioKTgJ4
	 WD43g5fFPVKQbcqi0bRi3r2VWR60QEF0QvwN1ir2cH5oUvrDEbfJXz0/GPYitODMWlyjM
	 VyKHzxIbS79Srvk35cTAymXRGF1jVmpmi56KFFbACDWpy7Hk2gKrtiW47/goq4bBJ37Cc
	 Fq0THpE3fSdJMLkLd4K1rcw5fcYXFoCOy6EVLQWk4dolycIGSVU8lls/lmmGHTq7+UYAP
	 GLbSRLpSlGPyMcJWjUy41KewayZEWAAZadsZZbNaXdD7lY5XvrsySCNoTeUh8lq8r1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jgostoIV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A45606B36C
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 18:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jgostoIV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6732A1F000C6;
	Fri, 13 Nov 2026 18:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794596220;
	bh=5PNzAELFVoAcuL2+u0PGl236dr73etAjVsgX/Bj8pno=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jgostoIVlPgb2IFkXTE2O4KqGeohd9Uknu4SxHanFqpSBGcDijk7Vr6PQ91yTBoaw
	 eI8GfGvX2l1fH8KLRMJREvQbxwlI6P8LwMPk6BBqf94JKd6zNdWzQMmw2ElGA2JRrW
	 i7/9P6LAs8hG0UPeSkDiS57dX8y3PpwmMGmiHUl1PQftBW5Xz/NX/s+MAdNwSlkq/B
	 0/ins0tkz6STyEAnBf7h2ZVhZYCOYzvvubrD3N+mi6Q4n8n1Sok5qx58ep+iGVXN5k
	 qqSYfYfiIy1CrV3arRfeSlrp+ty4vlWCe9aTGt/2pMT1GLLsJGaFzhsfgCl8caP1zn
	 RL/dmFB0ITZ6w==
Message-ID: <sashiko-outbox-213482@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/7] virt: steal_governor: remove the minimum
 elapsed-time check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261113184257.621707-4-ynorov@nvidia.com>
References: <20261113184257.621707-1-ynorov@nvidia.com>
 <20261113184257.621707-4-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 18:56:59 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> The governor queues its worker with a sampling interval of at least
> 100ms, so its one-millisecond elapsed-time check is redundant. The
> existing denominator clamp already prevents division by zero when
> calculating the steal ratio.
>=20
> This series adds a hook on hotplug events. It may trigger this error
> path pointlessly. Just drop it.
>=20
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113184257.6217=
07-2-ynorov@nvidia.com?part=3D3

