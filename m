Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E743ACF1D
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 08:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785487680; cv=none; b=nOmk/+1G0RwpPw7nQx7yzMHa0NnDT+lADJBn/BWmBNuRbbA3k5qvBjYke+8gxb/tORyzocOalIPBfS6QgBKrlWjwk1USeDvOERf4Xqr9lA/e2WTf9+88bfgO5BzkXwhAuimAS9Zy6y2C4B1U6D3/G1yk/blylsjh7Gc/UbAil2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785487680; c=relaxed/simple;
	bh=decNqs4gXCeyY/bvuadSSWMKdvYy3yCAfdlxThKld/Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g7YqoRjZy8358t1WDc024ZjUhVWPFOEsH1ppUW5tFHPEGzU9A1e5IDPK5blo47pmuN/Z44YnNxyJ9ZSys+kxkHZMkr8AUGoVfDvtca64DJgKelwWHYFi/JEFMf9fdwgfrwGyypE8A3yJFyNiqRLt7c7kUPUBH8iOYoNX3xBJwJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDEzp/jT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDEzp/jT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188E21F000E9;
	Fri, 31 Jul 2026 08:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785487677;
	bh=McTP0S+mYYODasd41taKX9jc0gx85HXELbh0nHiBBr4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XDEzp/jTM3JWATWQ3I+gS44RZzd+NpvvXlfcviAdeDAFOJlJbwv80wvyQo35v1Rm0
	 zU920lADemdg76WOUKBNuKP09D9m4TZYToUd05DWzvI+f45KyVng0Z6IMitNc59sC3
	 iMbyltcmbMqZlT0p6NqlYDZSVzJQzoOwVytTOqJ8xcD81VmlSjcr7pxGDPyjGkUAvd
	 /p5M7YvkmoOK4Stckqn9z1PputeZOnEMotcdFOsWBc6h6xy2l7hlsLTpJISZBDUgzm
	 RgyLytif+X+IJtee62bIIIvAGhJq5nmn/5nWQ6nf0+Fe/nuu409EY//8EHYMu5G4//
	 ISQ3nZBsoKEXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/pai: Handle CPU hotplug add for PAI PMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Richter" <tmricht@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260731084011.2568310-1-tmricht@linux.ibm.com>
References: <20260731084011.2568310-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 08:47:56 +0000
Message-Id: <20260731084757.188E21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The command 'perf stat -e pai_crypto/CRYPTO_ALL/ -- <command>
> crashes the kernel when CPUs are hotplug added during that run.
>=20
> Root cause is the allocation of struct pai_mapptr at first
> event initialization. The allocation is dynamic and the first
> event that has task context creates such a structure for
> each online CPU. This is not sufficient. CPUs may be offline
> during event creation and can be set online during the
> perf run time. For example commands
>=20
>  # echo 0 > /sys/devices/system/cpu/cpu1/online
>  # perf stat -e pai_crypto/CRYPTO_ALL/ -i -- stress-ng -t10s --matrix X
>  # sleep 1
>  # echo 1 > /sys/devices/system/cpu/cpu1/online
>=20
> [ ... ]
> possible CPUs, not just the ones currently online.
>=20
> Fixes: 92ea686840ac ("s390/pai_crypto: Enable per-task counting event")
> Cc: <Stable@vger.kernel.org> # v6.11+
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731084011.2568=
310-1-tmricht@linux.ibm.com?part=3D1

