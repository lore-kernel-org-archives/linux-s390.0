Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263310;
	b=jsqkf8h3+dLFyiZaoycgLl8jl+E5mFUsX7LKC77AJr32kUkncKvxVTe5DW1EWbO0LwQk
	 BZwx/9MYFWiv16yRkKeBkP6qTZ/W5JbEm7jdj7v1iE2xfJQuhuJ/usBG7ZgEgJv1Nkf+0
	 iMqwZOThO82ch3Q0EfYuFsJYVlvmpW7A2rmx5F5o+SqIdHMfnxeiXl+9HZtNXwYTfVvCU
	 +LdZu6qjdevlQZCKa2wRxgQeD7GZ6JqTHUUWFeePjcHtOjNqmYr9EnCw08BKx1bQWvNvL
	 PMJaPD17UgpXybBjYkTVBs/KW2O+fpGI8wusK5969pnzh4UhD7oEvTLiNW4qcYyryzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263310;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=s8Yx1ijRxcczlM+iQYMlk/PqSmAPrKOtgK2BWAfXGxI=;
	b=oQjS1/z6Jq6AvNUhL+MfjTFtcQZzx9yrjNvy/km/6KAlPqkbpRJYE6aP/r8ExFODqf1X
	 TvMQwFYzZIPC5+W3KLbvKH9jq8SfmaIUiQDuAClmjkcUUIwB0mLOJakSw7e4yDT0V92xq
	 8TMWLsJoGQD/u/n++WgeSr8LfKjnxixhQsuIY5NbEjwpuuXtoc6cNVV4O8RjuX+KxH7R0
	 WB6NtfiibA7biXRtxu8RPXB7PdirWqX4BUSda9wJGX0qnN9M2H1xnB4KJESGJn347/Gw/
	 vkNmrRaL1oi6uXyBuTpa1roQXUpmIB9ulxQ1xeuvDklQg/g8NogjHK7jM/0lhSdSuDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FB++vqqm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982CF606A31C;
	Mon,  9 Nov 2026 22:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FB++vqqm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165C91F0089F;
	Mon,  9 Nov 2026 22:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794263310;
	bh=s8Yx1ijRxcczlM+iQYMlk/PqSmAPrKOtgK2BWAfXGxI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FB++vqqmMAFn7/ThgHLgb1wptBE29SISdczPoCeHA5JD1EfmMfGdJP0jhKudRejNH
	 z4nn5CatH9CKuaO/JylqGzFFKz/LkBADTC1+wraG1d66a0LJOkk6+/hJF2vl2ls3FQ
	 ab4uaQX2rbI6O10ImVG0oC0sr1QVgkZ2oW5SYcJ4RLLeSQJjhV2web5o/Zokw0BrOJ
	 vz5vsNDIR6fI5fneXX6LuWKk4p57GqMfQVHPeEl9ZoZWTF7lfEYTJvr8GvD4DHHJnt
	 Vo7MXLd8kMieldBRnMjp5+MdyWLNI8okLDpiiiyr6M8+tgZKKMfGGUftbktBHCFn3Y
	 /4rKd68qIRF/g==
Message-ID: <sashiko-outbox-205733@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/12] KEYS: trusted: TEE: Disable sysfs bind
 attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261108222719.304712-8-jarkko@kernel.org>
References: <20261108222719.304712-1-jarkko@kernel.org>
 <20261108222719.304712-8-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 22:28:29 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Suppress sysfs bind and unbind attributes on trusted_key_driver so that
> userspace cannot unbind the driver and unregister key_type_trusted while
> the trusted module remains loaded.
>=20
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108222719.3047=
12-1-jarkko@kernel.org?part=3D7

