Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA892424D42
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 13:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787578064; cv=none; b=cbluMVEhAYuviAka9jtsJuN22FLupOtcaLUM3lpTjz1R/DAyLpFVZA8iZLYxwrzn7CuALTcaBY2qy26F6JvKsA7S+G9ugQf6kfb9Zrvl8rcu8L3aPXBkCdKltvgLP9M2SOGVCIB/9/qYvbj7cn+0Swf5W0MzUMiQyeeUdjuVOB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787578064; c=relaxed/simple;
	bh=Tb3F7NoV6UscVV4OV5nsT7w6YoMxyOXeb9VZQ05/jUI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pD6a4NT8AsUlAhyNRLbPL8gsBpMFwop+bAIfBOXUtUEPrqDQ+6BizAK0b4psQPjtQTpRKkCleERuwSDtO1V8GYtUhdBlGrcYpxRDgHhE0S/pjTmpomGI2LjLtNgdJWc5j9d/PTNf5qXPXh2q0JPfDjneVGZqj4sOndWxVOgDKoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLI4Xn63; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLI4Xn63"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F5B1F000E9;
	Mon, 24 Aug 2026 13:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787578063;
	bh=tJn63/1VYeIIWcy5gGfTQyW2C7ihFsGNXzrsV6EDPAE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SLI4Xn63ILv8XNd5xoFh5AmEqteKi4H3Qk6J5FLFVGpXG7HW32cUcaaoo660NuRLi
	 PfXx3kH7UHGiL8E7YRfcE14E/+nIj1riaRgdmRqkqU8OLun2kf1pHUb0ndwNQdTox/
	 340gNb/Kf7oQ5IsENstipcBpZiZbTZ++ZAkaK3h+utaQh1myGtbvvo75szG5TUKu+n
	 vQPUyUtpVH26oKJ277mIvs4rHA49FdMghlnmwpLFlyImtm6aKtc+L3PNtp826NH5xo
	 uDMybWn+WB7qkAR+3wA4oDjFUFWDHBa2yIUE7ZdtyCFSbRZzN2/xQmzuEgOLGpyEPG
	 7EZx+nL9fL/sw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3 v5] s390/pai: Support CPU hotplug for PMU PAI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Richter" <tmricht@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260824131751.179275-4-tmricht@linux.ibm.com>
References: <20260824131751.179275-1-tmricht@linux.ibm.com>
 <20260824131751.179275-4-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 13:27:42 +0000
Message-Id: <20260824132743.07F5B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Calling `cpus_read_lock()` inside CPU hotplug callbacks causes a g=
uaranteed self-deadlock.
--

--- Patch [3]: [PATCH 3/3 v5] s390/pai: Support CPU hotplug for PMU PAI ---
commit c7c540e2c7341f700711120ef64b2203ca9970ed
Author: Thomas Richter <tmricht@linux.ibm.com>
s390/pai: Support CPU hotplug for PMU PAI

This patch adds CPU hotplug support for the PAI PMU driver. It allocates and
frees per-CPU data structures during CPU online and offline operations to
prevent a kernel panic when PMU callbacks run on newly onlined CPUs.

> diff --git a/arch/s390/kernel/perf_pai.c b/arch/s390/kernel/perf_pai.c
> --- a/arch/s390/kernel/perf_pai.c
> +++ b/arch/s390/kernel/perf_pai.c

[ ... ]

> @@ -1216,8 +1256,38 @@ static int __init paipmu_setup(void)
>  	return install_ok;
>  }
> =20
> +static int pai_online_cpu(unsigned int cpu)
> +{
> +	int rc;
> +
> +	cpus_read_lock();

[Severity: High]
Will this cause a self-deadlock? The CPU hotplug core already holds the
cpu_hotplug_lock for writing when it invokes the hotplug callbacks.
Attempting to acquire it for reading via cpus_read_lock() here seems like
it would cause a deadlock, as percpu_rwsem does not support recursive
read-after-write locking.

> +	mutex_lock(&pai_reserve_mutex);
> +	rc =3D pai_alloc_cpu(PAI_PMU_CRYPTO, cpu, true);
> +	if (!rc) {
> +		rc =3D pai_alloc_cpu(PAI_PMU_EXT, cpu, true);
> +		if (rc)
> +			pai_event_destroy_cpu(PAI_PMU_CRYPTO, cpu, true);
> +	}
> +	mutex_unlock(&pai_reserve_mutex);
> +	cpus_read_unlock();
> +	return rc;
> +}
> +
> +static int pai_offline_cpu(unsigned int cpu)
> +{
> +	cpus_read_lock();

[Severity: High]
Similarly, does calling cpus_read_lock() here in the offline callback cause
a self-deadlock for the same reason?

> +	mutex_lock(&pai_reserve_mutex);
> +	pai_event_destroy_cpu(PAI_PMU_CRYPTO, cpu, true);
> +	pai_event_destroy_cpu(PAI_PMU_EXT, cpu, true);
> +	mutex_unlock(&pai_reserve_mutex);
> +	cpus_read_unlock();
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824131751.1792=
75-1-tmricht@linux.ibm.com?part=3D3
