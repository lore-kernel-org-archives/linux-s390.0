Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792487532;
	b=4LLBJP0/SAH6oxWg2T2wMVEQyw7MHRKzITiY7ocXVj13CC6x9cdFpUHCDmQYtSWVVjjW
	 rm5jHghq3Xw8kivJ8iwk+jufoUs2SDMJKrYvzQ2yP6iOI+/FyywX615BNZxVL6LWlY0/l
	 8LYfJGvf4Cv5K3gzKaURav3o0rEqCHXXY8bli1gD7YIJ3vK6WcAdY+2sl1bq9FqFBM+Kf
	 5h1w5M5rTo+sDCXKeEWkluBBCKzI6NUwI4ONROX+sCSKZaHZk05AEYsRXA67wtfrdIAkx
	 97aooEddVepqjT45IhjxheeU730r9ceMRgq9s9HlcWa9lbHYlEUCS/79YAwM7rVR9Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792487532;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9XQ1D361GoW+BynHwFVr/UQ9YY8tow5TQgtwVuzWIp0=;
	b=NbBtcGJIvBv/t9B8iEZQzaBLQPItg2eI1Wa+wkXOIHb59QmGL5npkJ0ztlaAnhb07u4C
	 OHXmpMoHAkAxAcseZOlUg58mp/LU3ffG1Fjvty7ACwTqB5IHBxnxH6EGQ22P++lfkIPTj
	 2Ed4AcKBDG4CpP/7XBU1IGEVFWU8RxEt+cMy9kt9V9PbYmNnBBVU/O/w/diITakVBJcAY
	 dB7zLisen+KUeLZw/Vj0SyW4i+i6th51sfKC/vPfpUHwRgcyWh7awwS6bPJUYLS8WYmHG
	 7c82oy4NpbMrjia34EoBdg5LTXhYYURqF/kg2CDnn1ou3RXHtCgk/fzeJgXjjewtkaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="DCnTNl/9";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB391606A31A
	for <linux-s390@vger.kernel.org>; Tue, 20 Oct 2026 09:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DCnTNl/9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9151F000C4;
	Tue, 20 Oct 2026 09:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792487531;
	bh=9XQ1D361GoW+BynHwFVr/UQ9YY8tow5TQgtwVuzWIp0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DCnTNl/9cIjiDu0Rxgh+V33vQspBAcnWpkf0mLj0TJWny9RWTYtzgMkcOEDzha5cR
	 sMBd8zV3O+zGuYNEIHun1jGY9Qnr9VM5YLgFXC79A2G/r8kv0Jv8RC9V25ZuB9F26F
	 o76XBHsm0ae7U6IzmJPKuHJdXhgSYAFCMD4mdRsYAOMoOcYVwbOtEwsuybEOzdV183
	 9vQP0/LKwos5G/dyXQMDpl/LOivvhIinAvoKzqyuAUeUrru4sDGdF2WWL5B5g7nd8b
	 20P3El0B2s55eVe4r7oQ3pQJH5wkHQwrEYQlcN4YAN6HiJlTbpqObnKflJCvHsV9eF
	 3bxk5aXO4ikDQ==
Message-ID: <sashiko-outbox-178700@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/3] selftests/ptrace: add a test case for
 PTRACE_SET_SYSCALL_INFO syscall skipping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Renzo Davoli" <renzo@cs.unibo.it>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261020065635.490528-4-renzo@cs.unibo.it>
References: <20261020065635.490528-1-renzo@cs.unibo.it>
 <20261020065635.490528-4-renzo@cs.unibo.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 09:12:10 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] selftests/ptrace: tracee ASSERT_EQ() traps on write() before _ex=
it()
- [Medium] selftests/ptrace: set_syscall_info_seccomp() fails instead of sk=
ipping
--

commit cc1ccfdbe8397159a506a6d7612652b6af1ea5d4
Author: Renzo Davoli <renzo@cs.unibo.it>

selftests/ptrace: add a test case for PTRACE_SET_SYSCALL_INFO syscall skipp=
ing

This commit adds a seccomp test case in set_syscall_info.c to verify
PTRACE_SET_SYSCALL_INFO syscall skipping semantics, including setting return
values, error values, and preventing syscall changes after skipping.

> diff --git a/tools/testing/selftests/ptrace/set_syscall_info.c b/tools/te=
sting/selftests/ptrace/set_syscall_info.c
> index 1cc411a41cd6f..e8733c62177a9 100644
> --- a/tools/testing/selftests/ptrace/set_syscall_info.c
> +++ b/tools/testing/selftests/ptrace/set_syscall_info.c
[ ... ]
> @@ -516,4 +542,196 @@ TEST(set_syscall_info)
>  	ASSERT_EQ(ptrace_stop, ARRAY_SIZE(si) * 2);
>  }
> =20
> +TEST(set_syscall_info_seccomp)
> +{
> +	tracer_pid =3D getpid();
> +	tracee_pid =3D fork();
> +
> +	ASSERT_LE(0, tracee_pid) {
> +		TH_LOG("fork: %m");
> +	}
> +
> +	/* tracee */
> +	if (tracee_pid =3D=3D 0) {
> +		tracee_pid =3D getpid();
> +		ASSERT_EQ(0, sys_ptrace(PTRACE_TRACEME, 0, 0, 0)) {
> +			TH_LOG("PTRACE_TRACEME: %m");
> +		}
> +		ASSERT_EQ(0, kill(tracee_pid, SIGSTOP)) {
> +			/* cannot happen */
> +			TH_LOG("kill SIGSTOP: %m");
> +		}
> +
> +		ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
> +			TH_LOG("prctl: %m");
> +		}
> +		ASSERT_EQ(0, sys_seccomp(SECCOMP_SET_MODE_FILTER, 0,
> +					(void *) &seccomp_prog)) {
> +			TH_LOG("seccomp: %m");
> +		}

[Severity: Medium]
Should set_syscall_info_seccomp skip the test instead of failing when
sys_seccomp(SECCOMP_SET_MODE_FILTER, ...) is not supported by the kernel or
architecture?

On kernels built without CONFIG_SECCOMP_FILTER (or on architectures that
support PTRACE_SET_SYSCALL_INFO via CONFIG_HAVE_ARCH_TRACEHOOK but lack
HAVE_ARCH_SECCOMP_FILTER), sys_seccomp() returns -1 with ENOSYS or EINVAL.

Because this ASSERT_EQ() runs inside the already-ptraced child, a failure
invokes __bail() -> abort(), which raises SIGABRT in the tracee and causes
the tracer to fail with "unexpected stop, wait status 0x67f" instead of
skipping the test via SKIP().

> +
> +		/* run getpid unmodified */
> +		ASSERT_EQ(tracee_pid, getpid()) {
> +			_exit(1);
> +		}
> +
> +		/* run getppid instead of getpid */
> +		ASSERT_EQ(tracer_pid, getpid()) {
> +			_exit(1);
> +		}
> +
> +		/* skip getpid and return 42 */
> +		ASSERT_EQ(42, getpid()) {
> +			_exit(1);
> +		}
> +
> +		/* skip getpid and fail with ESRCH */
> +		errno =3D 0;
> +		ASSERT_EQ(-1, syscall(__NR_getpid)) {
> +			_exit(1);
> +		}
> +		ASSERT_EQ(ESRCH, errno) {
> +			_exit(1);
> +		}
> +		_exit(0);
> +	}
[ ... ]
> +		ASSERT_LT(ptrace_stop, ARRAY_SIZE(expected_nr)) {
> +			LOG_KILL_TRACEE("ptrace stop overflow");
> +		}
> +		ASSERT_FALSE(info.seccomp.nr =3D=3D __NR_exit_group && info.seccomp.ar=
gs[0] =3D=3D 1) {
> +			LOG_KILL_TRACEE("tracee error: %s",
> +					testname[ptrace_stop]);
> +		}
> +		ASSERT_EQ(info.seccomp.nr, expected_nr[ptrace_stop]) {
> +			LOG_KILL_TRACEE("syscall nr mismatch");
> +		}

[Severity: Medium]
If any of the getpid() checks in the tracee fail, will the tracee ever reach
_exit(1) to trigger the __NR_exit_group diagnostic check here?

In tools/testing/selftests/kselftest_harness.h, ASSERT_EQ() expands to
__EXPECT(), which logs to unbuffered stderr before running the optional
handler block:

#define __EXPECT(_expected, _expected_str, _seen, _seen_str, _t, _assert) d=
o { \
...
			__TH_LOG("Expected %s (%ju) %s %s (%ju)", \
				 _expected_str, __exp_print, #_t, \
				 _seen_str, __seen_print); \
...
} while (0); OPTIONAL_HANDLER(_assert)

Since seccomp_filter intercepts all syscalls other than __NR_restart_syscall
with SECCOMP_RET_TRACE, the fprintf(stderr, ...) inside __TH_LOG() triggers=
 a
PTRACE_EVENT_SECCOMP stop on __NR_write before the { _exit(1); } block is
reached.

As a result, the tracer wakes up seeing info.seccomp.nr =3D=3D __NR_write r=
ather
than __NR_exit_group, bypasses the testname[ptrace_stop] diagnostic, fails
at ASSERT_EQ(info.seccomp.nr, expected_nr[ptrace_stop]) with "syscall nr
mismatch", and kills the tracee via LOG_KILL_TRACEE(). Plain if (...)
_exit(1); checks in the tracee (similar to TEST(set_syscall_info)) would
avoid issuing extra syscalls before _exit(1).

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020065635.4905=
28-1-renzo@cs.unibo.it?part=3D3
