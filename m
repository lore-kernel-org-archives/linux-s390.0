Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A783FADFA
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 09:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677394; cv=none; b=jmmVxK3lPVsQlyQRPyv7I2QZzjKyT6eejJzWVpETVQKFwUkD4DQYRq/IF7SjSrXeaur6GH5Y/BlQMPm3h4CZKsTFGG14orJA+eVYtCUbkmjFlkWHSdseCDVDUeXQsr+xhf+yUVLGL22hzo5phjmzMx79v6vc0vcnrSKRMuXcVNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677394; c=relaxed/simple;
	bh=5MNGg/A8JaVSQezcsabYZ2PIU1+Mf57v3d/BGIz36VU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QQUZ+5FtrL5r1oaxPKzKfJ9UoUSi+lscYpmHKdohoZVgNFnEj/dDCn/p18oYDDJTHxdWhQlYNt5s/NXWTsoxttSm+J1O0helCk0sgcZhZ8JQOSoTUP0YxvImGVpvsk2vEjlcBI0UO1yoSbYFFc63uYfiVrugvcUG0k7hFuba6+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncEmGc4E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncEmGc4E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8A41F000E9;
	Fri, 10 Jul 2026 09:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783677393;
	bh=dFIhdR4f7Lm8UcPbvPO4I596ATet3XbtYD+Tycq83fY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ncEmGc4EzNe53ev7ms2CEto2kbhxdcSTTHybg7N8l7hwyy66jCLWGR9ECyF5Kncyr
	 8aJShMl9K23+LVI7sh4zy4ao8EApLHVKBHo7w+31PjFotpJASwG1u9iJDflgDyKQEq
	 6CHI+/SRg42JMHEEb1fVz3t8A8ulAAlTTBgvPctAcuodtXO/WhshhIU7k1Wj5Qh43c
	 w3zwsDyferaOrwaG8acxChg5b/f29+I+vsrb593HxiEwaO/LBhcK73GuKoqPT0POBB
	 aAgoWCSKt8Kl09oDgu0RMhrGBtSZdFgRcrujAV8d+7unWF2h9nlkxIt+ZNOJTVuZu8
	 DwxUPEFOeyq+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH rdma-next 13/13] RDMA/selftests: Add rxe_netns_names
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Pirko" <jiri@resnulli.us>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, tj@kernel.org, mkoutny@suse.com, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, hannes@cmpxchg.org
In-Reply-To: <20260709095532.855647-14-jiri@resnulli.us>
References: <20260709095532.855647-1-jiri@resnulli.us>
 <20260709095532.855647-14-jiri@resnulli.us>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 09:56:31 +0000
Message-Id: <20260710095632.8F8A41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The test script declares a test plan of 7 tests, but only contai=
ns logic to execute 6 tests, causing the script to unconditionally fail.
- [Medium] The test `TEST_SAME_NETNS_DUP_RENAME` attempts to rename a non-e=
xistent device, causing the test to pass for the wrong reason and failing t=
o verify duplicate name rejection.
--

--- Patch [13]: [PATCH rdma-next 13/13] RDMA/selftests: Add rxe_netns_names=
 test ---
commit abd8a5c3d2f106017be1f5b869afa69da9c27f3a
Author: Jiri Pirko <jiri@resnulli.us>

RDMA/selftests: Add rxe_netns_names test

This commit adds a kselftest script that exercises per-netns RDMA device
naming with RXE. It covers duplicate names across namespaces, move conflict
handling, move-with-rename, and same-namespace rename requests.

> diff --git a/tools/testing/selftests/rdma/rxe_netns_names.sh b/tools/test=
ing/selftests/rdma/rxe_netns_names.sh
> new file mode 100755
> index 0000000000000..a7e57706fdff7
> --- /dev/null
> +++ b/tools/testing/selftests/rdma/rxe_netns_names.sh

[ ... ]

> +setup || fail "failed to create net namespaces"
> +
> +ktap_print_header
> +ktap_set_plan 7

[Severity: Medium]
Does this plan count match the number of tests executed? It looks like the
script only runs 6 tests, which would cause the test suite to unconditional=
ly
fail during ktap_finished due to a missing test.

> +
> +if setup_devs &&

[ ... ]

> +if ! setup_devs; then
> +	ktap_test_fail "$TEST_SAME_NETNS_DUP_RENAME"
> +elif rdma dev set "$RXE_A" name "$RXE_SAME" &&
> +     rdma dev set "$RXE_B" name "$RXE_NEW"; then
> +	if rdma dev set "$RXE_A" name "$RXE_NEW" >/dev/null 2>&1; then

[Severity: Medium]
Will this command fail because of a duplicate name, or because the device
is missing?=20

The device originally named RXE_A was just renamed to RXE_SAME in the previ=
ous
condition. If we attempt to rename RXE_A again here, the command fails due =
to
the device not being found, which seems to cause the test to pass for the
wrong reason instead of properly verifying duplicate name rejection.

> +		ktap_test_fail "$TEST_SAME_NETNS_DUP_RENAME"
> +	elif rdma_dev_exists "" "$RXE_SAME" &&
> +	     rdma_dev_exists "" "$RXE_NEW"; then
> +		ktap_test_pass "$TEST_SAME_NETNS_DUP_RENAME"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709095532.8556=
47-1-jiri@resnulli.us?part=3D13
