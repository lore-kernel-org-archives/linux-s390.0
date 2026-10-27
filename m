Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111679;
	b=ONb3OHDjFmc6jJGteS2YGb5hJkVocU9iYV78nE7Cq+9ifRcOeZ/RxRTlwdVRFa7Cqtqa
	 aKvuCZAKi6rCBCu2Fvl3mnjBZgXYvhyKq+25rolHt05Z4OzTndy2DhjYMoljjRuNDJpT6
	 sdoP+Or66kcxBzuibYho0JE4OJ/a+d0HktkuNcjd0YBD5+jEG4Oo1OJ5jVKp+oC0h1rBX
	 7RaRqXvRA8CRsx3yQy//trnU8iaqh10Lx50UHcB+21zeeFJyWlMiOftPEHlHAagVvtSnS
	 9Hrbh75jITWj5T6vJz/T/MfZOBa2cQByd0ZwW0MgtwgsWBTj5IMDVDI4/87+SCUZAhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111679;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kwijO+ncnK04LSVed5Upld4qudylV0DpLwfuvzbcPl0=;
	b=qYMvrlkLmKtwrL7fmTKFZ/xAwsAbDdkgxYX8JZsGqgufcKo7ZaxD897t5LcwNj1KCK+n
	 KbO5jq2ZTVIilTQ54jUnF111nPddhM9bZotAGop2IB45QK7idLOxVcyamm5OzluP+8IIb
	 m06jEL+5ovQOKZU/PYnSnpa73r/4VSaEvO798kqhZZ1mJXmRxqKsH4P9Ke5ZFK5bM77eK
	 O7TOHvj9yxvn36zcPkKivhKVfbnV8/JAnngOJieTWPJfcVP98lztnED1TF4NOIY430+nj
	 QmoYIz9uLZhgRzsRzIlRmXe0blwrDN3t0a2Dp6GsVr4+ZpKiiwqRZg1HmAcYLAonaSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WU+bpqIj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41092606A31A
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 14:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WU+bpqIj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27071F031E1;
	Tue, 27 Oct 2026 14:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793111678;
	bh=kwijO+ncnK04LSVed5Upld4qudylV0DpLwfuvzbcPl0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WU+bpqIjJ+uxntcj+E1EoPtbsDt/RpUUPCkI2ZGhRl2lDKVTSw1QyQakFRlY2BTxL
	 Ci6R92UtmPND7x91bObOWCCOmpU3z1T5JvyqtXNXCFJFT0/HCMyczDs8HX6bV9kAhl
	 vUits9MNuuWF+Z+mDTqNnBXzHbda5NCSzmiBVqCb47Rua801OK/VfF5tomI2Xkkqj/
	 J4DrUhkkozsl11X6V8rYbnKJZCkkT4dE8d4K8yBlCxFLewIUz3K41YpbA0wvcgI3Zq
	 0v6gV5elHcTBFyqy+HJfIrbyWOhMnhJ9Z8rtnqCQqoqENgrdP4L9nkSLuAYWuBXj8b
	 4OWWNgKeSTewQ==
Message-ID: <sashiko-outbox-186729@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/10] s390/stackprotector: Serialize text patching
 with text_mutex
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261027143030.3154657-7-hca@linux.ibm.com>
References: <20261027143030.3154657-1-hca@linux.ibm.com>
 <20261027143030.3154657-7-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 14:34:38 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Acquire text_mutex inside __stack_protector_apply() to serialize text
> patching.
>=20
> Serialization is not required for __stack_protector_apply(), however this
> is part of larger series where at the end s390_kernel_write() requires
> that callers hold text_mutex.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027143030.3154=
657-1-hca@linux.ibm.com?part=3D6

