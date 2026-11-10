Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302775;
	b=VVPJ8HFVzvCGK9F1G3UJQ6RYHkQDQYRg/7MoN5ZIEepXfcxpqbcKw3GThDMQEySjWWls
	 AUUZJcUbakaszdhbMmjY/fODW1Fzqy+X+PxFt+uSZIyNhJlbE/ccERPi7VDRTrrBwT9xA
	 KEKDjiU7wLVeacGIMb0BPE33V7RGQZK72E8y8BRVTCH//BE46ySiSKKchnCHxja9tlA8a
	 Jg7nHtAzCPgtgjAETc7OaeJRYt+FBvbBDlv6Cw2cdRh1rxwdrFfg88a4RrMVuWHyiJb/n
	 mp61MAwHuo3Tu2qKz4qjpo8GADV2NVDAATOd8V5ggnhePVWp96NkC/Gb7xqsQ6vQH1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302775;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uHknV0aT0hZFYeAbtadWg1qaXVH/wDYZyHfUb4vJtzw=;
	b=KcwhWftno3fZyJ+T/obRciqAZC3W+lW26NSAsr+8aJFoqf6a6+WDtxZyvBBAC9mSO/cL
	 JyHOkI1f5YcowAutICN0rBAxFzRmYhl0NTSi5qjnQAV4WkiYsqixw1atmjdDOuC6SPJqN
	 NaoUARjnJ1mb+vttqjTTj6DUVgMPwF/bZxq86lcNoud9IP4ebX39X97iY3pGX/TQce4qw
	 3sBG209pzRZQrZrt+dsjELRBLs4IoboacdNgyBj0oSFHkDlvRxqQdfayZFrPJCaUDxjuR
	 Ctt6ytGdoTccu6neMH8cIJQZRHmedNelo0agdFJLQxflcCE+B1oiH0ZbJoSC5cCFwgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X1cI3bqV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A888C606B2E5;
	Tue, 10 Nov 2026 09:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X1cI3bqV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA0D1F0089F;
	Tue, 10 Nov 2026 09:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302774;
	bh=uHknV0aT0hZFYeAbtadWg1qaXVH/wDYZyHfUb4vJtzw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X1cI3bqV4+jj88clK9xXNvVkF+NHL5/UUFPAUmxq+E0z7vqYMTEeKzbNd1RkDjGqc
	 or60F1MuWN/BnWd1/83lqoJ0kM5qGfpbvHa9YIAfQyHfnmo4+Xnx4ESch8ibVkVRXr
	 yQIgymMd9WizkZS9VDcpfQ+q5Agao+HqdcslajEd/DL9BkXjYLM15kt4I3kMIACoKG
	 yY0QH0PtiMPJnezV/PGvOvxx8bWwzAnQ/4rdq1FDh2YjqApJ1Hzjsj4YeyQh8Lfm4a
	 Ma7ibQTVWeYA27/bb9zXlLZ0PVbWahyXTYgoTHFytPTvuu66HhbzU7Zbun4/Fzq7LU
	 CVr5SS3XA+cMg==
Message-ID: <sashiko-outbox-206745@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 28/41] ocfs2: use fc_init_pseudo() for dlmfs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-28-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-28-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:26:13 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize dlmfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. dlmfs never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-work-loop-=
pseudo-v1-0-4c998976c6c7@kernel.org?part=3D28

