Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2197391E60;
	Wed,  3 Jun 2026 21:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780523123; cv=none; b=Rhf1aZWvlLfu6w1pKMU0U3/lyrvKU4UefHA4w5nO6BNk8vLjLR2959k9t5ozia18/yN6OBd5kPssa9XRlK+aNB4xzUfWwUdoMumpU7oNYJdYAU8qjKRB/3T6OUf90JnsnPjNY5NqX/Bg9Y/BYog8nROkgXgSTaIy0i0TfqI8oGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780523123; c=relaxed/simple;
	bh=lBTn7fI4Yzn14yVQX0QarRo44Y/JTxU16bmXY0i+qJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hb7TjCoK4eOLM3CxcWDgDP3IZPVKC5yFZwc0UfOsv8eARRm+bg4nHq0uA2ORXI52qZZOEfDYMdlqpQUR7fMpo2uyP1i9iJ4ytHRGS2beLvW4VPd+yvcoCS0T30wflmIvFfX58zz/LtQ8ozfQihvWf4Dd2yOMvzfRURN6/cwS3ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHSfNbhL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHSfNbhL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB231F00893;
	Wed,  3 Jun 2026 21:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780523121;
	bh=Z9KVZCOeiVINqsCr43Acl+oQQpTBxewnuiH+zDnfm5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QHSfNbhL+U7H6Z/uiB/lMrOSO+CQ9CcwqooDKy75nARdjWF/tL1Yf8zcjIXvGx50a
	 LJoGYXsBTMmgkttVs9DdMxPNgOdj74gXba8Q/fxcszwL4qALf4Wtdrw9IpsI+IlHhL
	 ZcKGwR9eyboR5upJebz1HjGH5Q/Rn4TEuKK247bCkw9nslrKDj0KZA84rrZrEqVXmy
	 rhQa7bGi34v4TixYajZEg+xsuugITOc9I1JUhDlEZB33bC4VfoCEj9X0sXbYEWbVwa
	 Ea39hISv6pjuxWSMcQ2nhFrbKcB/+79zN+XEIkMotttX+wxaTOOChDCbd177h0dMSl
	 0tJqgLlUfv+lg==
Date: Wed, 3 Jun 2026 18:45:18 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, agordeev@linux.ibm.com,
	gor@linux.ibm.com, hca@linux.ibm.com, jameshongleiwang@126.com,
	japo@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org,
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com
Subject: Re: [PATCH v12 00/19] perf: Use e_machine and lazily compute symbols
Message-ID: <aiCgbmUtlMCM4Xzt@x1>
References: <20260602062452.2583619-1-irogers@google.com>
 <20260602152516.2831152-1-irogers@google.com>
 <CAP-5=fWtc0xHfCeXfcPUkmWtHZO4EUriDrqovr5nXzb0GvSWxw@mail.gmail.com>
 <ah--Jc0PMT7Y7Z18@z2>
 <aiCE6Gq7yE2T8ZoT@x1>
 <aiCfgup5q9H0t80_@x1>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aiCfgup5q9H0t80_@x1>

On Wed, Jun 03, 2026 at 06:41:27PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Jun 03, 2026 at 04:47:52PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Tue, Jun 02, 2026 at 10:39:49PM -0700, Namhyung Kim wrote:
> > > On Tue, Jun 02, 2026 at 09:53:59AM -0700, Ian Rogers wrote:
> > > > On Tue, Jun 2, 2026 at 8:25 AM Ian Rogers <irogers@google.com> wrote:
> > > > 1 high issue. Concern over a perf data issue in pipe mode. Addressing
> > > > this would require a fairly major overhail of perf data, so let's add
> > > > fixing to the TODO list.
> 
> > > > >   perf symbol: Add setters for bitfields sharing a byte to avoid
> > > > >     concurrent update issues
> > > > >   perf symbol: Lazily compute idle
> 
> > > > No regressions x2.
> 
> > > Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
> > Thanks, applied to perf-tools-next, for v7.2.
> 
> Now trying to fix this, all old distros, but if the fix is cheap
> enough, lets not drop support for them:

It is an enum, so too much work to cope with that, I'll disable capstone
build in these systems.

- Arnaldo
 
> toolsbuilder@five:~$ cat dm.log/summary
> Subject: tools build test for http://192.168.86.5/perf/perf-7.1.0-rc5.tar.xz
> 
>    1   127.96 almalinux:8                   : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-28) , clang version 21.1.8 ( 21.1.8-1.module_el8.10.0+4172+b6b13d75) flex 2.6.1
>    2    12.44 almalinux:9                   : FAIL gcc version 11.5.0 20240719 (Red Hat 11.5.0-14) (GCC)
>     util/capstone.c: In function 'e_machine_to_capstone':
>     util/capstone.c:186:25: error: 'CS_ARCH_RISCV' undeclared (first use in this function); did you mean 'CS_ARCH_SYSZ'?
>       186 |                 *arch = CS_ARCH_RISCV;
>           |                         ^~~~~~~~~~~~~
>           |                         CS_ARCH_SYSZ
>     util/capstone.c:186:25: note: each undeclared identifier is reported only once for each function it appears in
>     util/capstone.c:187:34: error: 'CS_MODE_RISCV64' undeclared (first use in this function); did you mean 'CS_MODE_MIPS64'?
>       187 |                 *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
>           |                                  ^~~~~~~~~~~~~~~
>           |                                  CS_MODE_MIPS64
>     util/capstone.c:187:52: error: 'CS_MODE_RISCV32' undeclared (first use in this function); did you mean 'CS_MODE_MIPS32'?
>       187 |                 *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
>           |                                                    ^~~~~~~~~~~~~~~
>           |                                                    CS_MODE_MIPS32
>     util/capstone.c:187:71: error: 'CS_MODE_RISCVC' undeclared (first use in this function); did you mean 'CS_MODE_MICRO'?
>       187 |                 *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
>           |                                                                       ^~~~~~~~~~~~~~
>           |                                                                       CS_MODE_MICRO
>    3    17.54 almalinux:9-i386              : FAIL gcc version 11.4.1 20231218 (Red Hat 11.4.1-3) (GCC)
>     util/capstone.c: In function ‘e_machine_to_capstone’:
>     util/capstone.c:186:25: error: ‘CS_ARCH_RISCV’ undeclared (first use in this function); did you mean ‘CS_ARCH_SYSZ’?
>       186 |                 *arch = CS_ARCH_RISCV;
>           |                         ^~~~~~~~~~~~~
>           |                         CS_ARCH_SYSZ
>     util/capstone.c:186:25: note: each undeclared identifier is reported only once for each function it appears in
>     util/capstone.c:187:34: error: ‘CS_MODE_RISCV64’ undeclared (first use in this function); did you mean ‘CS_MODE_MIPS64’?
>       187 |                 *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
>           |                                  ^~~~~~~~~~~~~~~
>           |                                  CS_MODE_MIPS64
>     util/capstone.c:187:52: error: ‘CS_MODE_RISCV32’ undeclared (first use in this function); did you mean ‘CS_MODE_MIPS32’?
>       187 |                 *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
>           |                                                    ^~~~~~~~~~~~~~~
>           |                                                    CS_MODE_MIPS32
>     util/capstone.c:187:71: error: ‘CS_MODE_RISCVC’ undeclared (first use in this function); did you mean ‘CS_MODE_MICRO’?
>       187 |                 *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
>           |                                                                       ^~~~~~~~~~~~~~
>           |                                                                       CS_MODE_MICRO
>    4   101.24 almalinux:10                  : Ok   gcc (GCC) 14.3.1 20251022 (Red Hat 14.3.1-4) , clang version 21.1.8 (AlmaLinux OS Foundation 21.1.8-1.el10.alma.1) flex 2.6.4
>    5    21.66 alpine:3.16                   : FAIL gcc version 11.2.1 20220219 (Alpine 11.2.1_git20220219)
>     util/capstone.c: In function 'e_machine_to_capstone':
>     util/capstone.c:186:25: error: 'CS_ARCH_RISCV' undeclared (first use in this function); did you mean 'CS_ARCH_SYSZ'?
>       186 |                 *arch = CS_ARCH_RISCV;
>           |                         ^~~~~~~~~~~~~
>           |                         CS_ARCH_SYSZ
>     util/capstone.c:186:25: note: each undeclared identifier is reported only once for each function it appears in
>     util/capstone.c:187:34: error: 'CS_MODE_RISCV64' undeclared (first use in this function); did you mean 'CS_MODE_MIPS64'?
>       187 |                 *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
>           |                                  ^~~~~~~~~~~~~~~
>           |                                  CS_MODE_MIPS64
>     util/capstone.c:187:52: error: 'CS_MODE_RISCV32' undeclared (first use in this function); did you mean 'CS_MODE_MIPS32'?
>       187 |                 *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
>           |                                                    ^~~~~~~~~~~~~~~
>           |                                                    CS_MODE_MIPS32
>     util/capstone.c:187:71: error: 'CS_MODE_RISCVC' undeclared (first use in this function); did you mean 'CS_MODE_MICRO'?
>       187 |                 *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
>           |                                                                       ^~~~~~~~~~~~~~
>           |                                                                       CS_MODE_MICRO
>     make[3]: *** [/git/perf-7.1.0-rc5/tools/build/Makefile.build:158: util] Error 2
>    6    14.57 alpine:3.17                   : FAIL gcc version 12.2.1 20220924 (Alpine 12.2.1_git20220924-r4)
>     util/capstone.c: In function 'e_machine_to_capstone':
>     util/capstone.c:186:25: error: 'CS_ARCH_RISCV' undeclared (first use in this function); did you mean 'CS_ARCH_SYSZ'?
>       186 |                 *arch = CS_ARCH_RISCV;
>           |                         ^~~~~~~~~~~~~
>           |                         CS_ARCH_SYSZ
>     util/capstone.c:186:25: note: each undeclared identifier is reported only once for each function it appears in
>     util/capstone.c:187:34: error: 'CS_MODE_RISCV64' undeclared (first use in this function); did you mean 'CS_MODE_MIPS64'?
>       187 |                 *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
>           |                                  ^~~~~~~~~~~~~~~
>           |                                  CS_MODE_MIPS64
>     util/capstone.c:187:52: error: 'CS_MODE_RISCV32' undeclared (first use in this function); did you mean 'CS_MODE_MIPS32'?
>       187 |                 *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
>           |                                                    ^~~~~~~~~~~~~~~
>           |                                                    CS_MODE_MIPS32
>     util/capstone.c:187:71: error: 'CS_MODE_RISCVC' undeclared (first use in this function); did you mean 'CS_MODE_MICRO'?
>       187 |                 *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
>           |                                                                       ^~~~~~~~~~~~~~
>           |                                                                       CS_MODE_MICRO
>     make[3]: *** [/git/perf-7.1.0-rc5/tools/build/Makefile.build:158: util] Error 2
>    7    13.58 alpine:3.18                   : FAIL gcc version 12.2.1 20220924 (Alpine 12.2.1_git20220924-r10)
>     util/capstone.c: In function 'e_machine_to_capstone':
>     util/capstone.c:186:25: error: 'CS_ARCH_RISCV' undeclared (first use in this function); did you mean 'CS_ARCH_SYSZ'?
>       186 |                 *arch = CS_ARCH_RISCV;
>           |                         ^~~~~~~~~~~~~
>           |                         CS_ARCH_SYSZ
>     util/capstone.c:186:25: note: each undeclared identifier is reported only once for each function it appears in
>     util/capstone.c:187:34: error: 'CS_MODE_RISCV64' undeclared (first use in this function); did you mean 'CS_MODE_MIPS64'?
>       187 |                 *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
>           |                                  ^~~~~~~~~~~~~~~
>           |                                  CS_MODE_MIPS64
>     util/capstone.c:187:52: error: 'CS_MODE_RISCV32' undeclared (first use in this function); did you mean 'CS_MODE_MIPS32'?
>       187 |                 *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
>           |                                                    ^~~~~~~~~~~~~~~
>           |                                                    CS_MODE_MIPS32
>     util/capstone.c:187:71: error: 'CS_MODE_RISCVC' undeclared (first use in this function); did you mean 'CS_MODE_MICRO'?
>       187 |                 *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
>           |                                                                       ^~~~~~~~~~~~~~
>           |                                                                       CS_MODE_MICRO
>    8   127.15 alpine:3.19                   : Ok   gcc (Alpine 13.2.1_git20231014) 13.2.1 20231014 , Alpine clang version 17.0.5 flex 2.6.4
>    9   124.98 alpine:3.20                   : Ok   gcc (Alpine 13.2.1_git20240309) 13.2.1 20240309 , Alpine clang version 17.0.6 flex 2.6.4
>   10   134.36 alpine:3.22                   : Ok   gcc (Alpine 14.2.0) 14.2.0 , Alpine clang version 20.1.8 flex 2.6.4
>   11   128.47 alpine:3.23                   : Ok   gcc (Alpine 15.2.0) 15.2.0 , Alpine clang version 21.1.2 flex 2.6.4
>   12   134.59 alpine:edge                   : Ok   gcc (Alpine 14.2.0) 14.2.0 , Alpine clang version 19.1.4 flex 2.6.4
>   13    13.41 amazonlinux:2023              : FAIL gcc version 11.5.0 20240719 (Red Hat 11.5.0-5) (GCC)
>     util/capstone.c: In function 'e_machine_to_capstone':
>     util/capstone.c:186:25: error: 'CS_ARCH_RISCV' undeclared (first use in this function); did you mean 'CS_ARCH_SYSZ'?
>       186 |                 *arch = CS_ARCH_RISCV;
>           |                         ^~~~~~~~~~~~~
>           |                         CS_ARCH_SYSZ
>     util/capstone.c:186:25: note: each undeclared identifier is reported only once for each function it appears in
>     util/capstone.c:187:34: error: 'CS_MODE_RISCV64' undeclared (first use in this function); did you mean 'CS_MODE_MIPS64'?
>       187 |                 *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
>           |                                  ^~~~~~~~~~~~~~~
>           |                                  CS_MODE_MIPS64
>     util/capstone.c:187:52: error: 'CS_MODE_RISCV32' undeclared (first use in this function); did you mean 'CS_MODE_MIPS32'?
>       187 |                 *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
>           |                                                    ^~~~~~~~~~~~~~~
>           |                                                    CS_MODE_MIPS32
>     util/capstone.c:187:71: error: 'CS_MODE_RISCVC' undeclared (first use in this function); did you mean 'CS_MODE_MICRO'?
>       187 |                 *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
>           |                                                                       ^~~~~~~~~~~~~~
>           |                                                                       CS_MODE_MICRO
>     make[3]: *** [/git/perf-7.1.0-rc5/tools/build/Makefile.build:158: util] Error 2
>   14    14.14 amazonlinux:devel             : FAIL gcc version 11.3.1 20221121 (Red Hat 11.3.1-4) (GCC)
>     util/capstone.c: In function 'e_machine_to_capstone':
>     util/capstone.c:186:25: error: 'CS_ARCH_RISCV' undeclared (first use in this function); did you mean 'CS_ARCH_SYSZ'?
>       186 |                 *arch = CS_ARCH_RISCV;
>           |                         ^~~~~~~~~~~~~
>           |                         CS_ARCH_SYSZ
>     util/capstone.c:186:25: note: each undeclared identifier is reported only once for each function it appears in
>     util/capstone.c:187:34: error: 'CS_MODE_RISCV64' undeclared (first use in this function); did you mean 'CS_MODE_MIPS64'?
>       187 |                 *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
>           |                                  ^~~~~~~~~~~~~~~
>           |                                  CS_MODE_MIPS64
>     util/capstone.c:187:52: error: 'CS_MODE_RISCV32' undeclared (first use in this function); did you mean 'CS_MODE_MIPS32'?
>       187 |                 *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
>           |                                                    ^~~~~~~~~~~~~~~
>           |                                                    CS_MODE_MIPS32
>     util/capstone.c:187:71: error: 'CS_MODE_RISCVC' undeclared (first use in this function); did you mean 'CS_MODE_MICRO'?
>       187 |                 *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
>           |                                                                       ^~~~~~~~~~~~~~
>           |                                                                       CS_MODE_MICRO
>     make[3]: *** [/git/perf-7.1.0-rc5/tools/build/Makefile.build:158: util] Error 2
>   15   116.53 archlinux:base                : Ok   gcc (GCC) 15.2.1 20250813 , clang version 20.1.8 flex 2.6.4
>   16   130.36 centos:stream                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-21) , clang version 17.0.6 (Red Hat 17.0.6-1.module_el8+767+9fa966b8) flex 2.6.1
>   17   123.85 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 15.1.1 20250602 releases/gcc-15.1.0-174-gc096341a08 , clang version 20.1.0 flex 2.6.4
>   18    12.15 debian:10                     : FAIL gcc version 8.3.0 (Debian 8.3.0-6)
>     util/capstone.c: In function 'e_machine_to_capstone':
>     util/capstone.c:186:11: error: 'CS_ARCH_RISCV' undeclared (first use in this function); did you mean 'CS_ARCH_SYSZ'?
>        *arch = CS_ARCH_RISCV;
>                ^~~~~~~~~~~~~
>                CS_ARCH_SYSZ
>     util/capstone.c:186:11: note: each undeclared identifier is reported only once for each function it appears in
>     util/capstone.c:187:20: error: 'CS_MODE_RISCV64' undeclared (first use in this function); did you mean 'CS_MODE_MIPS64'?
>        *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
>                         ^~~~~~~~~~~~~~~
>                         CS_MODE_MIPS64
>     util/capstone.c:187:38: error: 'CS_MODE_RISCV32' undeclared (first use in this function); did you mean 'CS_MODE_MIPS32'?
>        *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
>                                           ^~~~~~~~~~~~~~~
>                                           CS_MODE_MIPS32
>     util/capstone.c:187:57: error: 'CS_MODE_RISCVC' undeclared (first use in this function); did you mean 'CS_MODE_MICRO'?
>        *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
>                                                              ^~~~~~~~~~~~~~
>                                                              CS_MODE_MICRO
>   19    12.08 debian:11                     : FAIL gcc version 10.2.1 20210110 (Debian 10.2.1-6)
>     util/capstone.c: In function 'e_machine_to_capstone':
>     util/capstone.c:186:11: error: 'CS_ARCH_RISCV' undeclared (first use in this function); did you mean 'CS_ARCH_SYSZ'?
>       186 |   *arch = CS_ARCH_RISCV;
>           |           ^~~~~~~~~~~~~
>           |           CS_ARCH_SYSZ
>     util/capstone.c:186:11: note: each undeclared identifier is reported only once for each function it appears in
>     util/capstone.c:187:20: error: 'CS_MODE_RISCV64' undeclared (first use in this function); did you mean 'CS_MODE_MIPS64'?
>       187 |   *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
>           |                    ^~~~~~~~~~~~~~~
>           |                    CS_MODE_MIPS64
>     util/capstone.c:187:38: error: 'CS_MODE_RISCV32' undeclared (first use in this function); did you mean 'CS_MODE_MIPS32'?
>       187 |   *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
>           |                                      ^~~~~~~~~~~~~~~
>           |                                      CS_MODE_MIPS32
>     util/capstone.c:187:57: error: 'CS_MODE_RISCVC' undeclared (first use in this function); did you mean 'CS_MODE_MICRO'?
>       187 |   *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
>           |                                                         ^~~~~~~~~~~~~~
>           |                                                         CS_MODE_MICRO
>   20    12.30 debian:12                     : FAIL gcc version 12.2.0 (Debian 12.2.0-14+deb12u1)
>     util/capstone.c: In function 'e_machine_to_capstone':
>     util/capstone.c:186:25: error: 'CS_ARCH_RISCV' undeclared (first use in this function); did you mean 'CS_ARCH_SYSZ'?
>       186 |                 *arch = CS_ARCH_RISCV;
>           |                         ^~~~~~~~~~~~~
>           |                         CS_ARCH_SYSZ
>     util/capstone.c:186:25: note: each undeclared identifier is reported only once for each function it appears in
>     util/capstone.c:187:34: error: 'CS_MODE_RISCV64' undeclared (first use in this function); did you mean 'CS_MODE_MIPS64'?
>       187 |                 *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
>           |                                  ^~~~~~~~~~~~~~~
>           |                                  CS_MODE_MIPS64
>     util/capstone.c:187:52: error: 'CS_MODE_RISCV32' undeclared (first use in this function); did you mean 'CS_MODE_MIPS32'?
>       187 |                 *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
>           |                                                    ^~~~~~~~~~~~~~~
>           |                                                    CS_MODE_MIPS32
>     util/capstone.c:187:71: error: 'CS_MODE_RISCVC' undeclared (first use in this function); did you mean 'CS_MODE_MICRO'?
>       187 |                 *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
>           |                                                                       ^~~~~~~~~~~~~~
>           |                                                                       CS_MODE_MICRO
>   21    94.47 debian:13                     : Ok   gcc (Debian 14.2.0-19) 14.2.0 , Debian clang version 19.1.7 (3+b1) flex 2.6.4
>   22   104.26 debian:experimental           : Ok   gcc (Debian 15.2.0-17) 15.2.0 , Debian clang version 21.1.8 (7+b1) flex 2.6.4
>   23    26.18 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 15.2.0-17) 15.2.0  flex 2.6.4
>   24    19.18 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 14.2.0-13) 14.2.0  flex 2.6.4
>   25    19.94 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 14.2.0-13) 14.2.0  flex 2.6.4
>   26    19.03 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 14.2.0-13) 14.2.0  flex 2.6.4
>   27    14.16 fedora:35                     : FAIL gcc version 11.3.1 20220421 (Red Hat 11.3.1-3) (GCC)
>     util/capstone.c: In function 'e_machine_to_capstone':
>     util/capstone.c:186:25: error: 'CS_ARCH_RISCV' undeclared (first use in this function); did you mean 'CS_ARCH_SYSZ'?
>       186 |                 *arch = CS_ARCH_RISCV;
>           |                         ^~~~~~~~~~~~~
>           |                         CS_ARCH_SYSZ
>     util/capstone.c:186:25: note: each undeclared identifier is reported only once for each function it appears in
>     util/capstone.c:187:34: error: 'CS_MODE_RISCV64' undeclared (first use in this function); did you mean 'CS_MODE_MIPS64'?
>       187 |                 *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
>           |                                  ^~~~~~~~~~~~~~~
>           |                                  CS_MODE_MIPS64
>     util/capstone.c:187:52: error: 'CS_MODE_RISCV32' undeclared (first use in this function); did you mean 'CS_MODE_MIPS32'?
>       187 |                 *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
>           |                                                    ^~~~~~~~~~~~~~~
>           |                                                    CS_MODE_MIPS32
>     util/capstone.c:187:71: error: 'CS_MODE_RISCVC' undeclared (first use in this function); did you mean 'CS_MODE_MICRO'?
>       187 |                 *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
>           |                                                                       ^~~~~~~~~~~~~~
>           |                                                                       CS_MODE_MICRO
>   28    13.01 fedora:36                     : FAIL gcc version 12.2.1 20221121 (Red Hat 12.2.1-4) (GCC)
>     util/capstone.c: In function 'e_machine_to_capstone':
>     util/capstone.c:186:25: error: 'CS_ARCH_RISCV' undeclared (first use in this function); did you mean 'CS_ARCH_SYSZ'?
>       186 |                 *arch = CS_ARCH_RISCV;
>           |                         ^~~~~~~~~~~~~
>           |                         CS_ARCH_SYSZ
>     util/capstone.c:186:25: note: each undeclared identifier is reported only once for each function it appears in
>     util/capstone.c:187:34: error: 'CS_MODE_RISCV64' undeclared (first use in this function); did you mean 'CS_MODE_MIPS64'?
>       187 |                 *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
>           |                                  ^~~~~~~~~~~~~~~
>           |                                  CS_MODE_MIPS64
>     util/capstone.c:187:52: error: 'CS_MODE_RISCV32' undeclared (first use in this function); did you mean 'CS_MODE_MIPS32'?
>       187 |                 *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
>           |                                                    ^~~~~~~~~~~~~~~
>           |                                                    CS_MODE_MIPS32
>     util/capstone.c:187:71: error: 'CS_MODE_RISCVC' undeclared (first use in this function); did you mean 'CS_MODE_MICRO'?
>       187 |                 *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
>           |                                                                       ^~~~~~~~~~~~~~
>           |                                                                       CS_MODE_MICRO
>   29    11.56 fedora:37                     : FAIL gcc version 12.3.1 20230508 (Red Hat 12.3.1-1) (GCC)
>     util/capstone.c: In function 'e_machine_to_capstone':
>     util/capstone.c:186:25: error: 'CS_ARCH_RISCV' undeclared (first use in this function); did you mean 'CS_ARCH_SYSZ'?
>       186 |                 *arch = CS_ARCH_RISCV;
>           |                         ^~~~~~~~~~~~~
>           |                         CS_ARCH_SYSZ
>     util/capstone.c:186:25: note: each undeclared identifier is reported only once for each function it appears in
>     util/capstone.c:187:34: error: 'CS_MODE_RISCV64' undeclared (first use in this function); did you mean 'CS_MODE_MIPS64'?
>       187 |                 *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
>           |                                  ^~~~~~~~~~~~~~~
>           |                                  CS_MODE_MIPS64
>     util/capstone.c:187:52: error: 'CS_MODE_RISCV32' undeclared (first use in this function); did you mean 'CS_MODE_MIPS32'?
>       187 |                 *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
>           |                                                    ^~~~~~~~~~~~~~~
>           |                                                    CS_MODE_MIPS32
>     util/capstone.c:187:71: error: 'CS_MODE_RISCVC' undeclared (first use in this function); did you mean 'CS_MODE_MICRO'?
>       187 |                 *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
>           |                                                                       ^~~~~~~~~~~~~~
>           |                                                                       CS_MODE_MICRO
>   30    11.70 fedora:38                     : FAIL gcc version 13.2.1 20231011 (Red Hat 13.2.1-4) (GCC)
>     util/capstone.c: In function 'e_machine_to_capstone':
>     util/capstone.c:186:25: error: 'CS_ARCH_RISCV' undeclared (first use in this function); did you mean 'CS_ARCH_SYSZ'?
>       186 |                 *arch = CS_ARCH_RISCV;
>           |                         ^~~~~~~~~~~~~
>           |                         CS_ARCH_SYSZ
>     util/capstone.c:186:25: note: each undeclared identifier is reported only once for each function it appears in
>     util/capstone.c:187:34: error: 'CS_MODE_RISCV64' undeclared (first use in this function); did you mean 'CS_MODE_MIPS64'?
>       187 |                 *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
>           |                                  ^~~~~~~~~~~~~~~
>           |                                  CS_MODE_MIPS64
>     util/capstone.c:187:52: error: 'CS_MODE_RISCV32' undeclared (first use in this function); did you mean 'CS_MODE_MIPS32'?
>       187 |                 *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
>           |                                                    ^~~~~~~~~~~~~~~
>           |                                                    CS_MODE_MIPS32
>     util/capstone.c:187:71: error: 'CS_MODE_RISCVC' undeclared (first use in this function); did you mean 'CS_MODE_MICRO'?
>       187 |                 *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
>           |                                                                       ^~~~~~~~~~~~~~
>           |                                                                       CS_MODE_MICRO
>   31    12.18 fedora:39                     : FAIL gcc version 13.3.1 20240913 (Red Hat 13.3.1-3) (GCC)
>     util/capstone.c: In function 'e_machine_to_capstone':
>     util/capstone.c:186:25: error: 'CS_ARCH_RISCV' undeclared (first use in this function); did you mean 'CS_ARCH_SYSZ'?
>       186 |                 *arch = CS_ARCH_RISCV;
>           |                         ^~~~~~~~~~~~~
>           |                         CS_ARCH_SYSZ
>     util/capstone.c:186:25: note: each undeclared identifier is reported only once for each function it appears in
>     util/capstone.c:187:34: error: 'CS_MODE_RISCV64' undeclared (first use in this function); did you mean 'CS_MODE_MIPS64'?
>       187 |                 *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
>           |                                  ^~~~~~~~~~~~~~~
>           |                                  CS_MODE_MIPS64
>     util/capstone.c:187:52: error: 'CS_MODE_RISCV32' undeclared (first use in this function); did you mean 'CS_MODE_MIPS32'?
>       187 |                 *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
>           |                                                    ^~~~~~~~~~~~~~~
>           |                                                    CS_MODE_MIPS32
>     util/capstone.c:187:71: error: 'CS_MODE_RISCVC' undeclared (first use in this function); did you mean 'CS_MODE_MICRO'?
>       187 |                 *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
>           |                                                                       ^~~~~~~~~~~~~~
>           |                                                                       CS_MODE_MICRO
>   32   111.06 fedora:40                     : Ok   gcc (GCC) 14.2.1 20240912 (Red Hat 14.2.1-3) , clang version 18.1.8 (Fedora 18.1.8-2.fc40) flex 2.6.4
>   33   107.16 fedora:41                     : Ok   gcc (GCC) 14.3.1 20251022 (Red Hat 14.3.1-4) , clang version 19.1.7 (Fedora 19.1.7-5.fc41) flex 2.6.4
>   34   106.95 fedora:42                     : Ok   gcc (GCC) 15.2.1 20260123 (Red Hat 15.2.1-7) , clang version 20.1.8 (Fedora 20.1.8-4.fc42) flex 2.6.4
>   35   103.93 fedora:43                     : Ok   gcc (GCC) 15.2.1 20260123 (Red Hat 15.2.1-7) , clang version 21.1.8 (Fedora 21.1.8-4.fc43) flex 2.6.4
>   36   108.14 fedora:44                     : Ok   gcc (GCC) 16.1.1 20260515 (Red Hat 16.1.1-2) , clang version 22.1.6 (Fedora 22.1.6-1.fc44) flex 2.6.4
>   37   109.25 fedora:45                     : Ok   gcc (GCC) 16.1.1 20260515 (Red Hat 16.1.1-2) , clang version 22.1.6 (Fedora 22.1.6-1.fc45) flex 2.6.4
>   38   106.11 fedora:rawhide                : Ok   gcc (GCC) 16.1.1 20260515 (Red Hat 16.1.1-2) , clang version 22.1.6 (Fedora 22.1.6-1.fc45) flex 2.6.4
>   39    43.21 gentoo:stage3                 : Ok   gcc (Gentoo 13.3.1_p20240614 p17) 13.3.1 20240614  flex 2.6.4
> toolsbuilder@five:~$
> 
> 
