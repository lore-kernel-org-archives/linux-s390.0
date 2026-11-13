Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794579960;
	b=fMdSRcnC2wUn+NJesUnk1AI9p6dv9CqomWxmDlvbCwzOcZoSH4T9YRMaSKMKhhUp3NbN
	 AiiUjqNQl/LP2qBWzL1j7jxx4k2aZnydWng3J+XDV/XUk0DM4K3GMRkBu0Hs8dons9mzb
	 qxV+4NNjKR0M+0n1wDHnptFLcPWCNu3FQS8gx8povxbt75yo4o25jbo7BqKwoLlpaRXq4
	 rqhzk69r+7+7jAY046tHeIBti/5ylNJ7qEHh4D9cahrbBE0WpSwWAirhB8ijCP13nzszf
	 BmDSqUPvpjWtjS1qkdtzDtwzg8YTepplTfEBaC4W8kwwyqznYd7cC2R6XFo0d0nDb7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579960;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VPWhYSPMu5EorGDwyGFMmHsUzu4H+X53HWVxBme8Ybg=;
	b=eqzNECedZWirHwYrfIjQVIMnG8bf3Nnx5ySbvuimVTh77Ul1Tk3FPAqCYG3NzxF6FrBS
	 9JH4tXh+o47ly+Any0SdNhCB4p4LbhAfOBikI04Ox/hKGB1WfU3PHLjKdlQQZxkCrQ6zl
	 UCUvFCqc1x3SslkKal1pYSSpAhN7838yx7pdWV7Cf8w3pihIvtQCTE5y2zUNd+KE1LtFy
	 kgKtCWxxPgpuwjiweJyVRAdGE8Teld4ac+P4snvVhaJ9+3Ph7khZC6ScXEen8jP9krpKb
	 xFBZHBRDEeqsZ7gp+232dfjU5E2n1CHM7xcMqsCD5X9WesenII+L0N8yG5TPWASk3bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VtOHxcSE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42EB606A335
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 14:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VtOHxcSE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B7F1F000C4;
	Fri, 13 Nov 2026 14:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794579959;
	bh=VPWhYSPMu5EorGDwyGFMmHsUzu4H+X53HWVxBme8Ybg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VtOHxcSEsbMEZqTqh/fAaHGtOitCE2i1ZNfJyiUps65XgYnhs5UJM/dCnGknyjOYw
	 2LSJ3Y3Zbc2hqDntymZnU31NPEUw9SHTN2OUBUQ2toPAfWXSagORmzFw9BWh228+4b
	 8sYxVcORqhzFfk7GirpSf4l9ooBQvX3kyOG612u3hUX3uakCwWTuH3a9hJ3NmuJKGP
	 3vq+VNN81JhNQ5v5eOu2qw/kpWPhapsKRrIvCQ0iW9fudEeMpze7tiUUR30skE4cgK
	 8qiHZhe0EZ21pMg5WaQl1WfBeD5sZ2ZpoIfmusB+giWunoSfUVuUniTw2C7Neb0n9Q
	 v3QTWGB1IxkpA==
Message-ID: <sashiko-outbox-212982@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/9] KVM: pass the mmu_notifier event and flags to
 kvm_gfn_range
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Q2FybG9zIEzDs3Bleg==?= <clopez@suse.de>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261112142039.907090-9-clopez@suse.de>
References: <20261112142039.907090-2-clopez@suse.de>
 <20261112142039.907090-9-clopez@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 14:25:58 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Propagate the event and flags of the mmu_notifier invalidation into
> struct kvm_gfn_range, so that architecture handlers can detect a
> permission upgrade (MMU_NOTIFIER_RANGE_PERM_UPGRADE). No functional
> change.
>=20
> Signed-off-by: Carlos L=C3=B3pez <clopez@suse.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112142039.9070=
90-2-clopez@suse.de?part=3D7

