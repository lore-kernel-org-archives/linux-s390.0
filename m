Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948A73655FC;
	Fri, 19 Jun 2026 09:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781862163; cv=none; b=qmz4L5EvAX4Id57UKL48mEI0+bqzBzvBh7VD/lmKw2axrCSAyfcV1jz2ujpU4D38Wn/gIu88Org8Od6Wc3w4gPT3Q8xhDqEm79R8alf0BDziTeNdsFvMmWJj2653zoEjEL49xpPRpei3zz86mVkGTpLnvYRUfhpC6XezyhvrQU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781862163; c=relaxed/simple;
	bh=O6Qs7eIt7RLu1huZpyGF5zO9WuzldATuuA8XY4T3C6w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OwJ5gdN0pYDgxkaEm3lubiXb6ZxD0agLNwdXlogqGnTPI/7qhGcrk/HG4DKpifrkjogNMFSP7V4hXdpZxI7kKtABDslLPRdN5TPIaD5LCkZqtkL1r5yidy0mjkGX3X1cocEdJ0jubvHM7QfzGHXf00t1EVPx8aJD0ac9NvLBzX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1SqTblL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1SqTblL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA9B1F000E9;
	Fri, 19 Jun 2026 09:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781862154;
	bh=5ufdFLsvrExnsZZp8FgOXXZmCsFKjDCwV0Ss3vb1WBk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B1SqTblLPuy1D1OwEZVj2NWK0MdliipfQpXwUIqIeDo6LtHvVCidU5gilBesXgFfj
	 OqI3QEGgQQw/69mwOy7cNB7dM/q4QkuB/fZEE3fIsSz+GEDbcFGUpcjQyoQ9Pjc+sf
	 a0o4NlPdGHQhILLYUnFq1NtgTsJYk68IzpBTvGa1n6/fl7S6iykCFCKLr1i7bdW4Z9
	 lZnCpZ9PLwLwToZReTPlaPSXH6nLex0F4I/OM3AcgExHLr7vHdjFvd4s2h0q6BsxSk
	 Zc23qCw4Px/o6zkbbKsLU39iOK6Dv8j5/ZfFOfL3DVg78vZ5wEVJfzl2wF0K1DKJ4Q
	 uxMQeNO5yO1AQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH linux-next] perf test: Skip failing 'perf test aslr'
 test case
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Richter" <tmricht@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260619093531.4038655-1-tmricht@linux.ibm.com>
References: <20260619093531.4038655-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 09:42:33 +0000
Message-Id: <20260619094233.CBA9B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Unconditionally setting `err=3D2` when skipping `test_callchain_=
aslr` masks prior test failures.
- [Medium] Skipping the test incorrectly triggers the test failure cleanup =
path, leaking the temporary directory in `/tmp/`.
--

commit d772895777a1677561d1802ac157c32ce73e1379
Author: Thomas Richter <tmricht@linux.ibm.com>

perf test: Skip failing 'perf test aslr' test case

The test case 'perf test aslr' fails on s390. This commit fixes the failure
by skipping the subtest test_callchain_aslr and emitting a hint when the
--call-graph dwarf option is selected.

Fixes: 60bc9fbc0589 ("perf test: Add inject ASLR test")

> diff --git a/tools/perf/tests/shell/inject_aslr.sh b/tools/perf/tests/she=
ll/inject_aslr.sh
> index c00461828ea79..7fdb43679dc84 100755
> --- a/tools/perf/tests/shell/inject_aslr.sh
> +++ b/tools/perf/tests/shell/inject_aslr.sh
> @@ -135,8 +135,15 @@ test_callchain_aslr() {
>      echo "Callchain ASLR test [Failed - no noploop samples in original f=
ile]"
>      err=3D1
>    elif [ -z "$new_addr" ]; then
> -    echo "Callchain ASLR test [Failed - could not find remapped address]"
> -    err=3D1
> +    if perf evlist -v -i "${data}" | grep -q 'sample_type:.*STACK_USER';=
 then
> +      echo "Dropping stack user sample as possible ASLR leak"
> +      echo "Call-graph dwarf not supported with 'perf inject --aslr'"
> +      echo "Callchain ASLR test [Skip]"
> +      err=3D2

[Severity: Medium]
Does unconditionally setting err=3D2 here mask prior test failures?

If an earlier subtest fails, the global err variable is set to 1. When
test_callchain_aslr() decides to skip and assigns err=3D2, it overwrites
this previous failure state.

Since the perf test framework treats an exit code of 2 as a SKIP, the test
suite will report the entire script as skipped, completely hiding the
actual failure from the prior subtest.

[Severity: Medium]
Will skipping this test inadvertently trigger the test failure cleanup path
and leak the temporary directory?

The cleanup() function in tools/perf/tests/shell/inject_aslr.sh explicitly
aborts deletion if the exit code or err is non-zero:

cleanup() {
  if [ "${exit_code}" -ne 0 ] || [ "${err}" -ne 0 ]; then
    echo "Test failed! Preserving temp directory: ${temp_dir}"
    return
  fi
  ...
}

Because cleanup() was not updated to handle the new skip state, it
mistakenly treats err=3D2 as a test failure. This unconditionally leaves
behind the /tmp/perf-test-aslr.XXXXXX directory every time the test skips.

> +    else
> +      echo "Callchain ASLR test [Failed - could not find remapped addres=
s]"
> +      err=3D1
> +    fi
>    elif [ "$orig_addr" =3D "$new_addr" ]; then
>      echo "Callchain ASLR test [Failed - addresses are not remapped]"
>      err=3D1

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619093531.4038=
655-1-tmricht@linux.ibm.com?part=3D1
