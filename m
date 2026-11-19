Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116673;
	b=doeQOc0er1HdyN0btzijhrMIad8MHzwQWx0zCdLLcXH2VslLjRnlHvCG68n8iNx12gK9
	 KXukEgGuRtyTr67a5/cHEufY3xU7qXNKovXGzRnfyK01GVaCHPM8PxI4nQKfNTlFxoolq
	 R2zxjjc3i19ZkI3Xp1Tz9jKxqRKZbLsfopTmw/ERRQolGbwE93ncVOXenwprmpkrZfMR5
	 kgZYsNaI7IiqMhGI1oj7Euzd/31XwIMAw6XOlV118tmnDAem++l5EGWx8YpyVvd/sqi0F
	 9y1uOWa8SHcadkEbXVFnQrJdSkjNr+2NUS/OCqGKok7UgaDMsv7I42s2UJexzl4MYRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116673;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ucBi/ZKii3YxLHCwipAZ8mLfmsCrwuD90AuTd9nNXc4=;
	b=PT/R5kaHioq2/Iu2XWYaPJ6agVYRSFtTz+ZMN5BBNAaDJP2tFIjIpTney3DWuZ41Ed2c
	 Az++MVnpKuIBtMHF4lDE61jHAlhbWTGvLvs1qEgyaj4KD2O6FexxnMHeXLVygjN2OFOq0
	 ERmsDwix3d9t1zyEwr72RxDTCYDVN+2Pf7t7DC4qUlE1KMVBmAiFtWbgqW5G46WjPCNyt
	 BKc9G7jJiBuaY/vu7pV14tTZgjyPOl4Gn49L14xMw60yqAvv5dwp4M4urpFnS6iBOHIBt
	 a1cKZhEj5hNDOCdeQqF2OE6UCMgQQ9o0ljByy1c4lXXGAsUUIjfggHWut1dV8IhxO+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DZWu0LQR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4B2606A330
	for <linux-s390@vger.kernel.org>; Thu, 19 Nov 2026 19:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DZWu0LQR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366C51F000C4;
	Thu, 19 Nov 2026 19:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116672;
	bh=ucBi/ZKii3YxLHCwipAZ8mLfmsCrwuD90AuTd9nNXc4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DZWu0LQRLNElxn+lOmdorUJXMhYXKqGaVBZeNtf5mc4RiORGGLB0eFRpCV9RNLPJb
	 elU8LBlQ9pgQP0tsl59DQcsPMNDzd8sZ9Y4BQ9MyiD5oTJ4HXCEF0IaQEBNICLoqe4
	 JFrAGsd0IUmUMJTiOslKR0wqgFtPx8wErPYunQT0oas3thXSAhrFF7aLSX6aKnClsy
	 8ylZo8n9K+C7G42j1PA5Pld/JyOF7xkF1p1sFHUb69ckcNbS8VipQamNgnUv09fHuT
	 47deISxI59Sgg9HyArvzQN4SVP0Nt9OunR5FfTyWqhJmfs1XtLAzxjd4TdbTQXXdjm
	 un72Izp0eZlsg==
Message-ID: <sashiko-outbox-223926@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/9] cpufreq: governor: Initialize kobj_type release
 callback statically
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261119192520.1983406-5-irogers@google.com>
References: <20261119192520.1983406-1-irogers@google.com>
 <20261119192520.1983406-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:31:10 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Export cpufreq_dbs_data_release() and initialize .kobj_type.release
> statically in the ondemand and conservative governors instead of
> assigning it at runtime in cpufreq_dbs_governor_init().
>=20
> This prepares for annotating struct kobj_type::release with
> __must_init.
>=20
> Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org> # cpufreq
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119192520.1983=
406-1-irogers@google.com?part=3D4

