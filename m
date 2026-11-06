Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793982233;
	b=noIJaXiNSevRt8HaF/92bA0F+bAVNfzGfHGvYZalPc0FUV5Z+DlzZAtOYYJoml5V2v0Z
	 Rdda7XMSl5P3a3Ty5PG4KYmyPifSrMp4AxWXAp4fHhx2smeeAiYPohKZBqKyHNmvMZ/1k
	 3oY4GBO1WneyvT0l8ziCB+0xdRF2kCO9scDmUSklkG+Pv10ebaV3AYVFnjlEBM93zpctv
	 hqqmtkFuoLotWX9vFBu6FuEt8Z5udEQA82je+BRehfyEZr7izomjuW2PaG8FVWpNrmrfy
	 GEzOcsB5NNoqT70p3rXProlcwHMjy3FTlIM3boIGv102CGbIFFfbcC9EMYuDcoD2hBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982233;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nivzUp82dTqtDHjRtfO+hp5LsfGX9nGjZN1xrbtHJ+M=;
	b=1WKir8avVdNYDTM8ptQ6L/9XzNxo1tLW+tmfPJRYqtm0d2Cq+bRApNsMttZ4WIWx8QX+
	 lYRhKKI4fTKTZIL3wdTFgShJB8EQE7GdY9PKPlRamG6Y/fw1dpql4YqIM5kI1yIalHEwX
	 CxR0HqlDoIdw9U+7JEE2FomPJRbB8Dreu6jQF8fJ6BooTVfiKR5gZVSAIbqmlw60MN+kg
	 q5FgkUPzgueik2cVPXrp8jstJsTjMBigdp50UUeKjmAnKaD3fYurKAMDpT8dcorBEk4m1
	 PLwERrJX7rcNHg80RgNhKkyLEvMd7NJvQKTMgIsIMaynFiI4DLB/JRkIJBdPTd4cWmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mWNnMFbO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEC5606A329
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 16:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mWNnMFbO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD0A1F0089F;
	Fri,  6 Nov 2026 16:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793982232;
	bh=nivzUp82dTqtDHjRtfO+hp5LsfGX9nGjZN1xrbtHJ+M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mWNnMFbOKLJdo7BwRAPB/MUTlGD2LLHdb9QnNXFhaN5cRBRXFT0y6nfhGrvky9eg1
	 J+nJSbt5+G/mwwM7nI5+KdYDxQjT+IQ8UT1g4+vYaIJZRvGQXa3h6GM0saFai0JBvd
	 xL++DKJDPp4YkpX++28rIpJIMu6JujEgAvzWkrC4qO8h8yJyx3eO9sBJ1fgvejo1so
	 26/usDSuTroWVb8zo2WqYRBWBxFxV57G+van1ye48Ji5jK/Syjih4gvxadQp7YGH3P
	 APLYhyWDVLcAxCRKwsOwEObfvOc6fVStz6rpyErUqOX8vuhmzo1s/vgnzwV5i2ZhSi
	 HE+pNk2q+92yQ==
Message-ID: <sashiko-outbox-201799@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/23] KVM: arm64: Refactor idreg caching into
 dedicated structure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106-sysreg-v3-1-75e95980fb10@linux.ibm.com>
References: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
 <20261106-sysreg-v3-1-75e95980fb10@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 16:23:52 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Move VM-wide ID register emulation fields from struct kvm_arch into a
> new struct kvm_vm_id_regs. The new struct is placed in a shared region.
> Update all users to use the new structure.
>=20
> No functional changes.
>=20
> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-sysreg-v3-=
0-75e95980fb10@linux.ibm.com?part=3D1

