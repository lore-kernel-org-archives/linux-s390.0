Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794828520;
	b=TDEiFwaeCa4A82VVuROTHpc29WeDB/VFnk+QOm37opIwV1UjTsvQkY/lQfbi5u7qZliC
	 hoM3MYE4JYd3sNX1wY6ssbzDohg0FwkpqUkGx9A/njQYu3ssFpjJdDKcZcGF76w6629k9
	 +tIfs+JbrWU9uBpefK147l8n5Mk8aF7dZpJa6Vzwt2UA0/xIcArdZLL1WV1/rEFHEBCy5
	 a5Q+POzjPajEpIl7RjqYJIN/Zvv6WlsxyiEFsVKMREylVaNujfgf+3qoa/FiB7XrWTgen
	 InSUj6K2K4z+GRwpIkSSQh9w6WGPHNBtot8qQfVCiJ8MrqE8PMEWKh78KJ4ZIsmdykA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828520;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ga/GHY9OK2PnbqOmY8JihTbKvXihg8HGF2S/cCRwxYs=;
	b=mQ65s7PecqIfNJ2sPMlqcQ9WTfPIGsc8p8XWlyzNNVtQDZPnDcuNPec8rYPnYmV102PV
	 v0NuZzYPWlQrfU2bI31s2tQ9jMipl3W3KLpUU/ue4oDfoGBPVm6nI5l2zhHPhaTbUHAXl
	 jXPLaGSkbcqP1jWUHq4q8ieRipdy2EgRNfpuVvnYUasFhHI5tfdCh2aGggl8ECVLFiD+N
	 +QLEr0Idh1DnvNzPjOTSELa6wOvTYRU2yrKWyzMU4sy7FRjCYEpCBuMNuButD9ezp17Nw
	 km23GpBYfUuROEBnrcPdLM/nvTqCZYCy3NQ0J5d70a2KkW931a6HB/1/kV/9Q1SY4ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lQhqN3hC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1958606A330;
	Mon, 16 Nov 2026 11:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lQhqN3hC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BDE91F000C4;
	Mon, 16 Nov 2026 11:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794828519;
	bh=ga/GHY9OK2PnbqOmY8JihTbKvXihg8HGF2S/cCRwxYs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lQhqN3hCBuHvSxiyoy/7ZLOaNV7VCo0NYyaIL9m9VSESNCn33lL6sclwWyd9LZO1t
	 965LL1zdeeBUr80K7TildATR0161GgQrl4Rxs2W82v062E1P1YU+/Oo6aWfCYcmtS+
	 7btXni3mU9mr75sNvWq3/MtZPs5r6PWHzOFZ1GC6sXRQ6A3lYnnp4UQf9E+oFOu//7
	 EBCuAmKr13J/T7a0M78tmOp9HZNt3BP080n9cP4MKXEB0dq+ZOGZWeLUASj3a3Tosj
	 Nqa5su+1OkHtnwgKWjChBZH/pI2rGuepDNVAYkVxsXPDyxJ8G5yvuVtD6TL3LZI26T
	 Ab8So2VuMmnuQ==
Message-ID: <sashiko-outbox-216928@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 30/44] powerpc/spufs: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261116-work-loop-pseudo-v3-30-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
 <20261116-work-loop-pseudo-v3-30-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:28:38 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize spufs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. spufs never holds executables or
> device nodes.
>=20
> SB_I_NOEXEC also refuses PROT_EXEC mappings. The spufs files that can
> be mapped expose local store and problem state areas of the SPU,
> nothing the PPU executes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-loop-=
pseudo-v3-0-8cbbea1cf34f@kernel.org?part=3D30

