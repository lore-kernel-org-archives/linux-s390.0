Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794457907;
	b=xC/J5O39U8Gd9z4edUBeCaM/47GnIBCKTBnirYjnUTMCEKn109ZcXWlP0xUnV2+HRGWj
	 Ua6m5+dN3N1c65HYuYWtmnHl16yX8TYyHP77Fs2mWLWqBWslDAATa0KYAU+HJWijLt16c
	 JQAYj2ntRGTb9YPIhPztzhqkdxpsoFf/gq0JxD5f3afuhz4B/miMcgd14zsMc1O0JMKO9
	 kyQ1ZRPQNEg6OeLFsLiukzG69pIs4P6UpnmM7ueZdyiCny1EjOIee8nL/DGoPvbdXB98n
	 Oy5rUNLBDbfAtOYk4/u+ZgR1QbR19oULjB6922efd9A1qgLE7MZ4i5yh7fGFRvalSlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794457907;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NtpQbn2holw6suXA0+B2qHBzsDeTEnoTvgQZs3Wie/4=;
	b=MDfgFsK2phLaa6+ibaVSYUysOhaeg+w847qTUNqJbPKbGqmrHkZwxVqzjViculLdN3pC
	 eRhWLl04Eil9O1bry/v95uWKcrKgH1HUk6ONj1gOGDKsGlCsqHj/jprG+l8oGxHGpR/uM
	 8FTJzyAfDOgInNzUWMXyBxXX57ah0s3+FtyKFyxLTbo6eXN5+DZIjlaOcOq9OxBA1Z9pY
	 diTDp5TAbPostNHuPNfaClD2xVWNBxVZZRerEinuZmeH2KMG/QCZ2QXG1y7G6OR55qj7y
	 mSNBwl2Fbjhjk2uH8eljqvAqT64jS/kJ5l1EcT6Bk7zN5Q+s5J02t79M7/bGK6n0nHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iAMFT0sf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9412B606A32E;
	Thu, 12 Nov 2026 04:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iAMFT0sf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A7A71F00A06;
	Thu, 12 Nov 2026 04:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794457907;
	bh=NtpQbn2holw6suXA0+B2qHBzsDeTEnoTvgQZs3Wie/4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iAMFT0sfbeN9QktyIqDKhNJ4K1C4st5q0/3sIpRsZPkAN9QmePnzfcydyEbaFIf1O
	 dyq2dj8z+fCZHyCYQLnv+4ZvQSOQAW/zggvYqkG424gMTKK1XCTQZgV8MlrwHBPXCq
	 ACvZkzKY0sK4CES/GmPdD7eK5955/2WZ4KwTOG1OSE5FPWCy3aVmViW+UheOUdmPFt
	 pqNo5xVl9o/a/mUCvjys0nZ4Y6RIe1rknzLO7zR9MOxCjc1PzIH2XdT46s+aHDXx0R
	 NQVxJlX/jfCLhrJmOQMFbH7WSNu+w1NOL71t/wvA4RnnptwHp++uT/+HRpLxvoRLho
	 1w/R58100m/Ow==
Message-ID: <sashiko-outbox-210359@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 13/13] KEYS: key_garbage_collector(): process in
 chunks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261112040242.247168-14-jarkko@kernel.org>
References: <20261112040242.247168-1-jarkko@kernel.org>
 <20261112040242.247168-14-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 04:31:46 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112040242.2471=
68-1-jarkko@kernel.org?part=3D13

