Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793371495;
	b=Hhh7OEniSeYXqwUb2G3eP/tC9B2X+ENQR6+z+kT6G+wHocwPh7unRgUhmGhtWWAmlWVg
	 oqeh+nrf5sgCXI0rrYoUz7xy/zXW+bBH3KwH++7+sTh49sPaMXJaDqsPYvQYN3WBAzkzs
	 7R8lxpDVi+rnGdqBD8v8QqY5BQKmf1rYuFRlRtqQyjD/lwAm0AOIC0KNGjQkByhzLcMnq
	 P6+IN4g53KDtkK0Q4G1c7wtSAyKEVlAJvGZ8t8g979dh+DzMOk2sMi9Lo5Itjlx54QLVh
	 KrQzXn88VOui1bcx74LqjRU23ARQsqTJMzIHAxTwGakAaCHnqsSAID8fel1B99fXfAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793371495;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UPAdiehkOCUgHrPUjM6IrYKFUVUYxoVqVOf6uAoG1Bw=;
	b=1h7eqUYEttBPcLv57xZDKA26wtD2zky4Bd/dbDVRuLVSZEVrCfcau03yHLbVnp7NAoMk
	 w9xF6rKp6BGPw5IDugefAdg6yVoUy22RO/1HcZKH+zS+wKO6/MnWpvvzzktolwKwK3OTN
	 BzVs3WfiHkCldqMqlk64hjGQlOFj60yHiEnMf4o9LjAWeYO6CRq9WjqkSVa4shZw7X9Aw
	 WtpefOWYj9OB5VKy+clNfDZHQ5o5LoesZIqHwzJLVQLSVQ1sg2PhHeWovgczR0Y2gCLjv
	 FBhTKvty5SmxEtOYnYVN0p/FvCNdaMiHsmyc8WvC6y6CTlbJEXLaR7uqDO8gGRxogRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mH1SRi8n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7FF606A32D
	for <linux-s390@vger.kernel.org>; Fri, 30 Oct 2026 14:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mH1SRi8n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B6F1F000C1;
	Fri, 30 Oct 2026 14:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793371494;
	bh=UPAdiehkOCUgHrPUjM6IrYKFUVUYxoVqVOf6uAoG1Bw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mH1SRi8noSeyI9MWIj1ZR9Of+ml3duRCOZInbzXIyWtwaEieh5/X43zQTmmspT6WE
	 5oLdH3BihVkiNmEJoTOQzf5E/ivVOdSSe+r8KwpMkndjQd+smnb4UGk9Fxqazhmkgi
	 wWlQpBC7Cx0oVpb07WZbKu4bguMFWRnWfec4LntYSwQLNLdCzBGCpP98QgIGgSB7DS
	 +C7K08wouLYe8TjuLcT0BFLbr/42+u+NbpRRmcxI/AE8irIjry0qbajWNigMg9L1fU
	 eZ0wvDsdu2C2DU9abvSTw2ix4aI1nsfV012tts2kV1m/hGRpzoBwS658kBPRWhatg9
	 IkjWx/BK0wwmg==
Message-ID: <sashiko-outbox-191119@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/4] KVM: plumb MMU_NOTIFIER_RANGE_PERM_UPGRADE into
 kvm_gfn_range
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Q2FybG9zIEzDs3Bleg==?= <clopez@suse.de>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261029143336.390231-6-clopez@suse.de>
References: <20261029143336.390231-3-clopez@suse.de>
 <20261029143336.390231-6-clopez@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 14:44:54 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Propagate the permission upgrade flag from the mmu_notifier range into
> struct kvm_gfn_range, so the unmap handler can react accordingly. The
> value is not consumed yet, so no functional change.
>=20
> Signed-off-by: Carlos L=C3=B3pez <clopez@suse.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029143336.3902=
31-3-clopez@suse.de?part=3D3

