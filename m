Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793719043;
	b=d4C/8HutDqknBkNb8UVTN7/Yv2rhhAXcD2gh8IqC+ny8sl7U2W4RIseKjxhEmrimgeQn
	 db20Lpc8ddeSfOatII9bh9A9l1SdjxkS9JyYg3xD7ujLsvuMk6TmN7HNADtlCwRpbbXC7
	 oYvtgNzU9U8yrhWbY7VjegNN/oKblkbV23GgIVtzsSDQIQsfiCgqi4UzHtYbQWjOB+tgz
	 Gsbq72WWtwKNKrZt3RczmX4NrukH6j4/PLiKfJyQnoQINhZv5WeN4oQGYJr8PyyMqSGGd
	 GDCQSXVIfe5X/YP7Gf5KHCrEzr+Cv58GmjtwnelZ/oDuBLg3lFMLYd68FItBpXc6jGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793719043;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RvDMrSwdCMAnZG6OnuLDpdI82b0RcKD5Iz5ctCKZdzI=;
	b=Rl1rWM6BDfuoXxEZ4tnZw+VP0GXDRBjIn5PSNxugS8+wDhJzCmoZWmUWo+ggG20qtc+h
	 tokALHSz8YyUVzi257j5gAA42q0MZY6DUPS8YhhrLOPQQjQrIxmbSEN9zh51GKP8UgIz8
	 TUPdxH8d1/OEXJZ21LK+b6TfYbF/Ckl6JKcRQBqH70FAkgLGXANa85HseblmY577RNUma
	 Fk/3MEs6PvWiIFfJeYytqTTNEw3EcLYvo8jgWp0Jx+UEGMjdehEgd5GGIa+FqFqWjiD2k
	 oTwtRI+8P6dsKrpeoJwkwcRsCM69OWxNjhmHYlQMyMUfSyeR/Q5IqDKAKmkxulg7Baw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hc1e1VkG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633FE606A326
	for <linux-s390@vger.kernel.org>; Tue,  3 Nov 2026 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hc1e1VkG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B401F000C1;
	Tue,  3 Nov 2026 15:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793719043;
	bh=RvDMrSwdCMAnZG6OnuLDpdI82b0RcKD5Iz5ctCKZdzI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hc1e1VkGUQxrkZGFOsHgeS7l+kKUg9mDDxL4Rbig6ZdLbsB5jzrjRYjhiEh08qIt0
	 O8Vwqj/3kDvXfoIeC+obUE8o0o/kyVm5hK+smBGHEKtxmWokdeu8AGd9UHKaYiSeHd
	 Ak6P+5mtfM9RWyGXBUdV7eUr8hoGcjr/w2m5QXOJYV1bwUl/2uu73E1olyIW3E7+BU
	 XBdbG4ly135uFkjxdwBlXCz1t0ansNxvNRZk1dxAI82Qx9Y2HPFcWZvO63tYsK3EYy
	 P12Cj1HoFl2Fy0CqPD+bmH07AgdF7BpU1LovyMLnCG26kN7zlUZL3Oi5nHu7rhSfLB
	 Zwx3BdKZVZZvQ==
Message-ID: <sashiko-outbox-195579@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 2/5] s390/pci: Improve function measurement state
 management
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Elghoul" <oelghoul@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261103150114.68873-3-oelghoul@linux.ibm.com>
References: <20261103150114.68873-1-oelghoul@linux.ibm.com>
 <20261103150114.68873-3-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:17:22 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> When a zPCI function is disabled and re-enabled, the firmware implicitly
> disables function measurement while the kernel still believes it is
> enabled, leading to a disconnect between the user-visible state and the
> actual device state.
>=20
> Add the statistics_on field to struct zpci_dev to track the desired FMB
> state. Introduce the functions zpci_fmb_request_on()/_off(), which defer
> to zpci_fmb_enable()/_disable() to perform the actual firmware change.
> This decouples the enablement or disablement step from managing the
> user's requested state.
>=20
> Restore the state in pcibios_enable_device(), pcibios_disable_device(),
> and zpci_reenable_device(). New devices start with measurement on by
> default, unchanged from before.
>=20
> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103150114.6887=
3-1-oelghoul@linux.ibm.com?part=3D2

