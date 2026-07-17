Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D0A3FDBFD
	for <linux-s390@vger.kernel.org>; Fri, 17 Jul 2026 13:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784294670; cv=none; b=V5RnqLksA+lmPs8r8s/m4bVcnbW3x0DzZeMOIvPPPaFs2NZVhJCA5LSX2r7DE8e9iNWmvmUrKdkQ1ZUrD92ilJfxBL/AWkvldTrSE2VPJAAG8lJR7/gdDm8DT4Ef89J0WZ4ZKqc2a3VuTTNXDEIIx7fQ3g3kdPgtzR2l+L7US2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784294670; c=relaxed/simple;
	bh=NR+vUgXPH/r6rQ+sf9LT4nEimKp3xCmEsdQ7t2TCq0U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IEfeHGnT4TNi1lm44N6tEx0vx4/EAa423leqyn2sQ+1rrQrhkpBE+VnIumjWI3faZc5VbD9uUwSYF16Jo7y3oPS/j1ZMOLkjrB/UR86Tobkq7jYYqG/4k2y6+RxQV1C5eL9gtIy6GRNioOjh4rn+R1VdsE+u7DdD3J73Xr6iRKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcoJR+qd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcoJR+qd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE161F00A3D;
	Fri, 17 Jul 2026 13:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784294669;
	bh=htmizBFt6s14bqasDx/Rki9GMaON0jZEfTeDQM7PIuo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TcoJR+qd0gTQmVmh4r/RegAdKeXkwRw3ZhxIn+B5BEKFKX5yZ3+T8fPbiO4Ry8iod
	 otf7YcOM2LhlgyYzkiBha62z2Gb78PSuYVLPfWWpjvIhmlbOuegxlu1FXJDE6ofQ2w
	 dWK/q+Tu8t+8R6TGevJqMpOZX3tGJS997+EdJrkPHgEn989CWlrfm8krxJDNF1yw81
	 MHCfrQobA3SCQH/9duKeTqoO+2lb7mJpbSmMrzcv2XClPx1kmlU97xIqyy7ZGtiYcn
	 iB7r6ZxZnY4OX+6DsSROYsKR6kWnzm7VZSuZipqkIuHyA0uwTYM+hR6N1S1+wb0vEb
	 vAhVWdTo9y8wA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH rdma-next v3 14/14] RDMA/selftests: Add rxe_netns_names
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Pirko" <jiri@resnulli.us>
Cc: tj@kernel.org, mkoutny@suse.com, hannes@cmpxchg.org, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260716132316.1495242-15-jiri@resnulli.us>
References: <20260716132316.1495242-1-jiri@resnulli.us>
 <20260716132316.1495242-15-jiri@resnulli.us>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 13:24:28 +0000
Message-Id: <20260717132429.3DE161F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] `wait_rdma_devs_gone()` fails to wait for dynamically renamed RD=
MA devices (e.g., `ibdevX`) to finish asynchronous unregistration, potentia=
lly causing module unload failures.
--

--- Patch [14]: [PATCH rdma-next v3 14/14] RDMA/selftests: Add rxe_netns_na=
mes test ---
commit dabec57822c009814520c6cece67efb39fb7b1f8
Author: Jiri Pirko <jiri@resnulli.us>

RDMA/selftests: Add rxe_netns_names test

This commit adds a kselftest script that exercises per-netns RDMA device
naming with RXE. It covers duplicate names, conflicts, move-with-rename, and
same-namespace rename requests.

> diff --git a/tools/testing/selftests/rdma/rxe_netns_names.sh b/tools/test=
ing/selftests/rdma/rxe_netns_names.sh
> new file mode 100755
> index 0000000000000..f40118407f4c0
> --- /dev/null
> +++ b/tools/testing/selftests/rdma/rxe_netns_names.sh

[ ... ]

> +wait_rdma_devs_gone()
> +{
> +	local i name ns
> +	local names=3D("$RXE_A" "$RXE_B" "$RXE_SAME" "$RXE_NEW")

[Severity: Medium]
Does this hardcoded list of names miss dynamically assigned fallback names
like 'ibdevX'?

During the TEST_TEARDOWN_RETURN test, the device moves back to init_net and
conflicts with an existing name, receiving a dynamic fallback name (e.g.,
ibdev0). When cleanup_devs() deletes the underlying dummy netdevs, it calls
wait_rdma_devs_gone() to wait for asynchronous unregistration.

Since the dynamic name isn't in this list of expected names, the function m=
ay
return early before the device actually finishes tearing down. Could this
cause the script to fail to unload the rdma_rxe module or leave a dirty sta=
te
for subsequent tests?

> +
> +	for i in $(seq 1 50); do
> +		local found=3D0
> +
> +		for name in "${names[@]}"; do
> +			if rdma_dev_exists "" "$name"; then
> +				found=3D1
> +				break
> +			fi

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716132316.1495=
242-1-jiri@resnulli.us?part=3D14
