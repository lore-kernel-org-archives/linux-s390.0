Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794457888;
	b=Mmhimjf3Jafl1n83WaMLhiGdJPPE1mApmy9b2GhQtSu6b/X14emHm4dxN9pm4vLfdmcx
	 urFFYKjTO2jPuBpHw040vTXYPZOffMmbCHy/LheMLSiIt8CP7eHQbjncg+XTt3dddtOjz
	 VK/98PriCyn7MD1EY12rNxAtLTruWoWNl/6lT82VhGTFaY+vf/irzuswGJamISbfqDAwf
	 Nd0yJgYFR58PhJFbK0tqXpy4P+38O+RCwqw7MmhAppCGN64aR3+wF1XVk6sgdH1o7LPdN
	 wFYQDBhNaPXgwDFsMXDE+Qx/6KaMrt6bkvOGlkE8og3a/NH5ZpdHY11GzEn+S4XQucg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794457888;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=I2tYKyVzyKJq3kdk+FrN5fQy/ZAW+/9pfU/dIxlNL1U=;
	b=wfZvmG1cNjXxyl9BTmbIGDHVzIDWQ/Z3q5aDFhi3E7wgjuVqSvh2Jd8qtVfp4G87PbHm
	 o8JjLrKnnRsrVXP66yswxdSrSk0PMeGxQh4QeV3YEL+WlR+HhQMsbPpjNQDdRs3AMGRYo
	 NU5Os9YTkw1sn+0PJAvZtExzOm1EPPJV97U47cAI0mQcl/kRGKi2m5KvficAudQNeW1Xh
	 34HUc17o50ZRFdjcenpXFHdhbgWS+1h6C+ZgaPz5+jdbHuWxuonYTV7mfeGH8FHl4+EU6
	 lTostYt5Qv2tNMecox1Nt1/to3IyFc++se1ribAuoxLrER2hALev6nNHYAYP9RhG+Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cNZCGyo+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B8E606A31C;
	Thu, 12 Nov 2026 04:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cNZCGyo+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19151F00A05;
	Thu, 12 Nov 2026 04:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794457888;
	bh=I2tYKyVzyKJq3kdk+FrN5fQy/ZAW+/9pfU/dIxlNL1U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cNZCGyo+SVG8XoQG1sg15lTfpz0nHREYz2z/pbN/poci2z8jUXdNu9lAPwiai69OT
	 hLw3wexkhCE5LAj1pi2ffBsjVmRasR79ZPXFB7Zd4evMhwz/t/85WzETctfZ1Wv6Ek
	 PNqsZypXKslIftvasqtvPvtRMETukj46nKIWa/QDT5y3L3NVaKthfK4s2mC1tVZeMS
	 jeyxsagsrmpuxuXYEBPn7rLVTS19Zxz90RvtrOKhj5yJqX8YjST92WoV44Sfu4dTfS
	 ry4GbCK5vUORrHPrKJbKdiWmD753um/NSUMzeCdVg5D4rJPXGAc9Lr/o3WfuPlPQlW
	 /Oda5l2YxuQ0g==
Message-ID: <sashiko-outbox-210347@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/13] KEYS: Add key_gc_flush() for draining RCU
 callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261112040242.247168-2-jarkko@kernel.org>
References: <20261112040242.247168-1-jarkko@kernel.org>
 <20261112040242.247168-2-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 04:31:27 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> keyring_clear() and key_invalidate() release keyring links via call_rcu(),
> and key_put() defers final key destruction to key_gc_work.
>=20
> Once keys pin their type, callers that clear an internal cache before
> module unload need a synchronous barrier so module references can be
> dropped before delete_module() checks the refcount.
>=20
> Add key_gc_flush() for flushing the remaining key_gc_work passes.
>=20
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112040242.2471=
68-1-jarkko@kernel.org?part=3D1

