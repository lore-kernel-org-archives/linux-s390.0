Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A87B3E5A29
	for <linux-s390@vger.kernel.org>; Tue,  6 Oct 2026 11:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791285860; cv=none; b=F2pv3V7KRd2oWL5rxCQq4AcanwT/KIAstL8ifSKnLKJ8f4ZgnbdjXQRkod1/Or5XR9K6/z+QxcqjQyWyAy+SnhX1n8Uwo25UWkvPwo4AVQQBLOjAzIaTSaCmVp0dk0rdxyrCnvxkJITPHVF9WMgaBora6lAtOLtdeXMKMohqkoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791285860; c=relaxed/simple;
	bh=Q1OqmMVJz4NMcFMSVOhYWyNtCsMh5as057wIa7Wl980=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k4eoYbEXpD9MvgEgLmep+dxGXbRa8rqSlqVUXjmEY7ODfNCpWcxg103mzVLwfUzEM1ms5kNT86bxESwZOjVXRXmpjkVgGex4L1WAc6hv0JrjEM+E6fQ49sN8YlXc+UMMXm6gfXOaK3Pwt+F+tIXtRhbIPw6YmxVCU30S5nmXsYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csJx7n1R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csJx7n1R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D1021F00893;
	Tue,  6 Oct 2026 11:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791285858;
	bh=yYjVX6+jR1iwJ+uYgZzuNJYgIc78Bf5iIgeVUcP1YwU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=csJx7n1RDb9VYaWqAwg9I4YAVBqIxtqeA8XD02xfwZ+g8rZFznj0ZzOf6FwwSaGRF
	 9Phwq1MMo4ps3jEEY+IO94dwpVTX58A9KrY6oLcQoPa8kiHFaDIU4AbgGuNzmS7+Ng
	 WMm8FOXn/S5TV7/f8yVW7WNR9pQIrw89TWn276Y8Gra1Nfmh7zJn8zovkEeBuHjGHm
	 OMd+CzHIsTAGKirMTDnvoyD6Zsdl14v3oTOjauSeaUNhWoYyDxy92TLauDNpaekZ4K
	 bQd7PbcWMsX5EbjOVF1CNtsjcibwNjoulCgXvwnnLl/gI5GcdaK3fgpUQyp88HwlyU
	 fhzFPn82ckdHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] s390/cpum_cf: Honor hwctr session cpu mask during
 hotplug
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sumanth Korikkar" <sumanthk@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261006111304.4023017-3-sumanthk@linux.ibm.com>
References: <20261006111304.4023017-1-sumanthk@linux.ibm.com>
 <20261006111304.4023017-3-sumanthk@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 11:24:17 +0000
Message-Id: <20261006112418.5D1021F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] s390/cpum_cf: strict mask enforcement breaks legacy lshwc tools
--

commit d3def3a5308e1d518c4fe69c3d9a0fc29e832d28
Author: Sumanth Korikkar <sumanthk@linux.ibm.com>

s390/cpum_cf: Honor hwctr session cpu mask during hotplug

This commit updates cfset_online_cpu() and cfset_offline_cpu() to start and
stop counter sets only for active hwctr sessions that include the CPU in
their requested mask. It prevents the kernel from dynamically modifying
the session mask on each hotplug event.

> diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum=
_cf.c
> index 1d63dc3b0ab99..a2334af515447 100644
> --- a/arch/s390/kernel/perf_cpum_cf.c
> +++ b/arch/s390/kernel/perf_cpum_cf.c
> @@ -1778,17 +1779,19 @@ static int cfset_online_cpu(unsigned int cpu)
> =20
>  	if (!list_empty(&cfset_session.head)) {
>  		list_for_each_entry(rp, &cfset_session.head, node) {
> +			if (!cpumask_test_cpu(cpu, &rp->mask))
> +				continue;
> +

[Severity: Critical]
Could this strict mask enforcement cause a userspace regression with legacy
lshwc tools?

Legacy versions of lshwc initiate 'allcpu' sessions by providing the curren=
tly
online CPU mask instead of the possible CPU mask.

When a new CPU is hotplugged, this strict evaluation will silently exclude =
the
new CPU, preventing the legacy behavior of dynamically expanding the session
mask to newly onlined CPUs.

Since this change alters the semantic behavior of hwctr sessions, will syst=
ems
using legacy s390-tools on an updated kernel encounter incomplete data for =
newly
hotplugged CPUs?

Breaking existing userspace applications, even when fixing a bug such as the
incorrect inclusion of CPUs in subset masks, is generally considered an ABI
regression.

>  			p.sets =3D rp->ctrset;
>  			cfset_ioctl_on(&p);
> -			cpumask_set_cpu(cpu, &rp->mask);
>  		}
>  	}
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006111304.4023=
017-1-sumanthk@linux.ibm.com?part=3D2
