Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE21448B84;
	Fri,  4 Sep 2026 11:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788520912; cv=none; b=Trkoxbj1R4pz7qoCFsKLnN6kDah6hoygNsqYP970ZoAFaJtZuxiCr3QX1nMn86AR/ONgdO1t3otguGGPM9xidcd4ENIjI5ZzCzX2pT589TR6tEyBu+j4iY6A94gVNxWtAiGUPjCd7E6zEwJZcanxTwoykC/a+CmTuhuyFztkM0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788520912; c=relaxed/simple;
	bh=hwzDcPMFWdUV2GphYi2BnmUFqG3KANLJRukzDcqfbZQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mb/3KV4fUg24HrrEr5niIS1850aAkFMomzARDnwhld+vEmIO5gl35PLyyG3JrG++x51xdgfwA8+BJrq6FZ/eNcD1CR6FYn3f5Db7jU5Axxdq6KPK/Lceppyy7NOdTmUR9eWZufUgvXxKZMUOAGSbuhPj85SnCF706YwCQs2RyEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMBp0wjt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMBp0wjt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CBFB1F00A3D;
	Fri,  4 Sep 2026 11:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788520911;
	bh=/KF3xIMezszoztZEf/AbVIn9xAa0yrrHaiMLrWyR4VM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FMBp0wjtBsDxxH7kMkMJhyGyNRoWWvc3eBHpHZcVhuM+mliKNO5VAlUPiLxQSxnwm
	 YIJEUjPlSNVKIKvvTwbFUZTDdajSlDfp1bQ8ULRwG/GGUguJ4nDwX7ppr14R9z8KNp
	 M6k7sVO4VKYjhjQf+30n1/LMqFX9cDQe6Cp5Xvf38fc+X01w7mJMJPH5CkOnqB/tnO
	 2ZTXNrZa/38ZeNZVhcfZu95/Nsf82Lewi3RnP+0M65ftEAiYPqGD+V8Mz+axs3ZveX
	 quxLslG1pCFWra3rrVdFyMglvQH5FDwaESD0L/TMgtSxjqI7u2ARvDQH0YzLKVwdFz
	 KXtz0lLQFaRXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/12] of: Export of_node_to_nid()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: devicetree@vger.kernel.org, media-ci@linuxtv.org, dri-devel@lists.freedesktop.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, robh@kernel.org, conor+dt@kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260904-tegra-vpr-v6-6-79042cfa8de5@nvidia.com>
References: <20260904-tegra-vpr-v6-0-79042cfa8de5@nvidia.com>
 <20260904-tegra-vpr-v6-6-79042cfa8de5@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 11:21:50 +0000
Message-Id: <20260904112150.9CBFB1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing #include <linux/export.h> for EXPORT_SYMBOL macro.
--

commit 44baf41b1565a3ea5c2669a320dc9b29217d32c3
Author: Thierry Reding <treding@nvidia.com>

of: Export of_node_to_nid()

This commit exports of_node_to_nid() so that drivers buildable as modules=20
can use it.

> diff --git a/drivers/of/of_numa.c b/drivers/of/of_numa.c
> index 230d5f628c1b4..da2e9bd1717c2 100644
> --- a/drivers/of/of_numa.c
> +++ b/drivers/of/of_numa.c
> @@ -171,6 +171,7 @@ int of_node_to_nid(struct device_node *device)
> =20
>  	return NUMA_NO_NODE;
>  }
> +EXPORT_SYMBOL(of_node_to_nid);

[Severity: Low]
Should this file explicitly include <linux/export.h> or <linux/module.h>?

Using EXPORT_SYMBOL without explicitly including its defining header relies
on transitive includes. This could potentially cause build failures=20
if those implicit includes change in the future on certain configurations
or architectures.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-tegra-vpr-=
v6-0-79042cfa8de5@nvidia.com?part=3D6
