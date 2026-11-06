Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793926454;
	b=F8YhqDfRmyajYdN+5JanaXHCn5jo7GqQWBODo7xqE4bcH9+vRHkC8FIu1+CXn7JBRqOM
	 tDm+3HtMV6uE+fbYu5hlR0d32PZcrZ2ZDMSq+ay9U4BpwfEAMnPhs+ayMiTFfkNFk/vUB
	 5N/H3mZhtKFrYfbI1STMdcEAfnrBCiMFxekyUk6Qymu/uzfF+Zhtcwm15glhtnAe3FIer
	 KBiG9Bwr4VrGWHqVExMYXy+K3ADBkgTqxIZ/R4/ZQx9jSixgwvTECy5GRVlRV8uHOKAjl
	 iGIC/o/00LKLT0qhakjNdqTtzcvH0f3rJpSE7ROJycsIwkifWbaLsTkq0j33Z9Uq3Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793926454;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PvTW3GwwUaJm9zceP8HmURXvvculND7vyYy8SiGOeW8=;
	b=eW+rGbP93I7CpMbEc+WkdRMH0xNNIkDGck1s4xm7iY8/y9RhcyE9is1MST93rnnKLGU4
	 YMohVkGxyhskvm/+6fSK1wvuHr/GCKnZQZSak+DNAh7WiE8Kz8zgWNV+P5Vj/ZoXvFKYW
	 sy2U4240CAWoVAunbKzFv8xKlrgq00KfShf+wei59UaEnboRxA8Ji2E2Kc3dfw4yNRCf3
	 ykvllqORmSl1SMli589M6Z1wpoECcliXJebN4bYy7xqF/uEPY6tNRHNN5PkD6N83EEgAm
	 7pNR8t3yNzidjt5jiviJLdHAvmjA5JiFC3BbqZ0mY9tRDfvxYhl63T1WxP2zrSVTMfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Kfxj/vAF";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF51606A31B;
	Fri,  6 Nov 2026 00:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kfxj/vAF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D608E1F008A1;
	Fri,  6 Nov 2026 00:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793926454;
	bh=PvTW3GwwUaJm9zceP8HmURXvvculND7vyYy8SiGOeW8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kfxj/vAFt7c0lRuV/CjhosWO4f5u3hnmq/E6203a6Rzezem+mr8E6cCYdGgcH+H3I
	 PXKOUL3F/vM9aHGb4RKoBtlb9JMl2ZLK9EIxRVMudinJ/mlJtUt6uOHJg7LYjaqcVX
	 c0mH8qG66dJrz+hG5OJ1Y42PgeFWgTvhW5eTfeHE63xzmW3jbmPpv0lrDxJ7mkCvZ7
	 /hLQuEq2deiJ7ol23qgXWJD+Xt9cfJGGoY+DyYplH0rABVvD+UaFKedIhJuwoVrHBx
	 jLIF+dLR20NLzhuqK6twnxVcysVPwxe5nupvmbSYDn8wXE6/5A5gYU91Kmq8+o97cV
	 OOm5GZ1DA5/ww==
Message-ID: <sashiko-outbox-200466@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 11/11] KEYS: key_garbage_collector(): process in
 chunks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261105005311.804098-12-jarkko@kernel.org>
References: <20261105005311.804098-1-jarkko@kernel.org>
 <20261105005311.804098-12-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 00:54:13 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> key_garbage_collector() has a design that is not resistant enough for
> workqueue lockups. The duration scales up relative to the number of items
> in the serial tree, which causes a reoccuring theme of being guilty of
> causing workqueue lockups.
>=20
> Resolve the problem by processing in chunks:
>=20
> 1. Declare a static variable key_gc_work, which owns the garbage collecti=
on
>    in-flight state, and key_schedule_gc_work() for re-scheduling the work.
> 2. Define KEY_GC_CHUNK_SIZE, set to 64 keys, as the bound for the number
>    of items scanned and destroyed.
> 3. Define KEY_GC_DESTROYING to mark resume to destruction without repeati=
ng
>    the RCU grace period.
> 4. Define KEY_GC_REAP_REQUESTED for preserving full-pass requests across
>    the continuations.
> [ ... ]
> decline.
>=20
> Fixes: 0c061b5707ab ("KEYS: Correctly destroy key payloads when their key=
type is removed")
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd-=
test.git/tree/package/keygcbench
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105005311.8040=
98-1-jarkko@kernel.org?part=3D11

