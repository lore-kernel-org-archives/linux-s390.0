Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7077639A80E
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 09:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120341; cv=none; b=Raf+YEAfZv07Klbp2bKdVF46Mt+7PULii5+A03ojhuEvf2BeBptRefPOqIuVHSjhys786zSAlrYulibp9U+Ke3zGkzdadLmEiF2CQABpnfjRpz6M0ORcCvZWWr5RtHNRtTwew1jEZffam25bjnjD30El1454vQ2iipjDqSoSSpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120341; c=relaxed/simple;
	bh=foBiRzj/cXAIJFAVSNYQZm1+W39c9b6Yo6GFF65Fv10=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pXO1xVQmdwqbKnCpedZh/korWwjrxTg1RIlMfD5vvhIx72jmC2dgh1vazfW4eyon5IX7i1Ll42V1QmiGKH+tnGh+osO3kgnOhq3wKKysJ/aA8brsDopF5ZQccrA3vorfswkG0UBfyfkCXIJVB9dX/HIvwQpN0eAEoBREnZSTIpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkTB2Bmj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkTB2Bmj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE41E1F000FF;
	Fri, 11 Sep 2026 09:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789120340;
	bh=3/vtlQ8Nz6Q9OdolqTd/1zlJkTugHy373WFuUvd9CmY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IkTB2BmjZ0HW4RwjxdkORbFX28ZJLjHMb0kaDdp3Ajp37uKhKOQw94wtuFA9JmWoK
	 nWAP23wMfMXT56k8DqdH3tfRTOMry5OEdNBGElEbZL1INAEwWMYmQ7Moj5e03gFFim
	 h8CWGwReXlBGRIGevAbYqpU67IlUQGKM15wfd1F+ZHPTjoqGL6phOSt7cQAkCF4VH+
	 XqnTVtEPiNvSiIj5CkpRerMrxi2VeVRg98HwOMN8U/rkrUZTo3YF80y9rDn+ZoP9f+
	 FIVpnaUUEK0ctDAUzrmSntx20sBXqY+LJ5ID1mTnFgew4iMvGWlxuoFo3FDjlH3yQe
	 LA6rWchf4Lrjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf header: Fix HEADER_CPU_DOMAIN_INFO feature
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Richter" <tmricht@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260911094129.2032815-1-tmricht@linux.ibm.com>
References: <20260911094129.2032815-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 09:52:19 +0000
Message-Id: <20260911095219.AE41E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Critical] The patch adds a new field `nr_cpus` to the `HEADER_CPU_DOMAIN=
_INFO` section in `write_cpu_domain_info()`, but completely fails to update=
 the corresponding read logic in `process_cpu_domain_info()`. As a result, =
the parser mistakenly consumes `nr_cpus` as the first `cpu` ID, permanently=
 desynchronizing all subsequent reads of variable-length arrays and strings=
. This fatally breaks the perf.data format reading for this feature.
- [Low] The updated documentation in `perf.data-file-format.txt` erroneousl=
y contains literal `+` signs (diff artifacts) and misrepresents the structu=
ral layout of the binary format by appending the new fields instead of show=
ing them at the beginning of the header section, contradicting both the ser=
ialization code and the commit message.

Pre-existing issues:
- [Critical] Heap out-of-bounds write in `build_cpu_domain_map()` when pars=
ing `/proc/schedstat`. The `cpu` index is extracted and used directly as an=
 array index into the dynamically allocated `cd_map` array without any boun=
ds checking against its allocated size `nr`.
- [Critical] Stack buffer overflow in `build_cpu_domain_map()` when parsing=
 unbounded strings from `/proc/schedstat`. The unbounded `%s` format specif=
iers write directly into fixed-size stack buffers (`dname` of size 16, `cpu=
mask` of size 4096) without width limits.
--

commit b3021ce087d716ca61ad4fc99fbab6158ead0501
Author: Thomas Richter <tmricht@linux.ibm.com>

perf header: Fix HEADER_CPU_DOMAIN_INFO feature

This commit updates the `HEADER_CPU_DOMAIN_INFO` feature serialization to
include a new `nr_cpus` field and aims to align the documentation with the
binary layout.

> diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/p=
erf/Documentation/perf.data-file-format.txt
> index b90cba9168f84..e37f7484487bc 100644
> --- a/tools/perf/Documentation/perf.data-file-format.txt
> +++ b/tools/perf/Documentation/perf.data-file-format.txt

[ ... ]

> @@ -461,7 +461,14 @@ struct domain_info {
>  struct cpu_domain_info {
>  	int cpu;
>  	int nr_domains;
> -	struct domain_info domains[];
> ++	int schedstat_version;
> ++	int max_sched_domains;
> ++	int nr_cpus;
> ++	struct {
> ++	       int cpu;
> ++	       int nr_domains;
> ++	       struct domain_info domains[nr_domains];
> ++	} [nr_cpus]
>  };

[Severity: Low]
Does this documentation update mistakenly contain literal '+' signs from di=
ff
artifacts?

Additionally, does appending the new fields at the end misrepresent the act=
ual
structural layout of the binary format, which writes these values before `c=
pu`
and `nr_domains`?

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 7db7da090a1e0..770fd21eb1a55 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -1836,7 +1836,7 @@ struct cpu_domain_map **build_cpu_domain_map(u32 *s=
chedstat_version, u32 *max_sc

[Severity: Critical]
This is a pre-existing issue, but does `build_cpu_domain_map()` have an
out-of-bounds write when parsing the cpu index from /proc/schedstat?

tools/perf/util/header.c:build_cpu_domain_map() {
...
		} else if (strncmp(line, "cpu", 3) =3D=3D 0) {
			retval =3D sscanf(line, "cpu%u %*s", &cpu);
			if (retval =3D=3D 1) {
				cd_map[cpu] =3D zalloc(sizeof(*cd_map[cpu]));
...
}

The `cpu` index is extracted and used directly as an array index into the
dynamically allocated `cd_map` array without a bounds check against its
allocated size `nr`. Could this lead to a heap out-of-bounds write?

[Severity: Critical]
This is also a pre-existing issue, but does `build_cpu_domain_map()` overfl=
ow
its stack buffers when parsing unbounded strings?

tools/perf/util/header.c:build_cpu_domain_map() {
...
	char dname[DNAME_LEN], cpumask[MAX_NR_CPUS];
...
			if (*schedstat_version >=3D 17) {
				retval =3D sscanf(line, "domain%u %s %s %*s", &domain, dname,
						cpumask);
...
}

The `%s` format specifiers in `sscanf` write directly into the fixed-size
`dname` and `cpumask` stack arrays without length limits. Can this lead to a
stack buffer overflow?

>  static int write_cpu_domain_info(struct feat_fd *ff,
>  				 struct evlist *evlist __maybe_unused)
>  {
> -	u32 max_sched_domains =3D 0, schedstat_version =3D 0;
> +	u32 max_sched_domains =3D 0, schedstat_version =3D 0, nr_cpus =3D 0;
>  	struct cpu_domain_map **cd_map;

[ ... ]

> @@ -1855,6 +1855,15 @@ static int write_cpu_domain_info(struct feat_fd *f=
f,
>  	if (ret < 0)
>  		goto out;
> =20
> +	for (i =3D 0; i < nr; i++) {
> +		if (!cd_map[i])
> +			continue;
> +		++nr_cpus;
> +	}
> +	ret =3D do_write(ff, &nr_cpus, sizeof(u32));

[Severity: Critical]
By adding `nr_cpus` to the payload here, do we need a corresponding update =
in
`process_cpu_domain_info()`?

Without a matching read, it appears `process_cpu_domain_info()` will consume
`nr_cpus` instead of the first `cpu` ID:

tools/perf/util/header.c:process_cpu_domain_info() {
...
	ret =3D do_read_u32(ff, &max_sched_domains);
	if (ret)
		return ret;
...
	env->max_sched_domains =3D max_sched_domains;

	for (i =3D 0; i < nr; i++) {
		if (do_read_u32(ff, &cpu))
			return -1;
...
}

Will this permanently desynchronize all subsequent reads from the perf.data
file?

> +	if (ret < 0)
> +		goto out;
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911094129.2032=
815-1-tmricht@linux.ibm.com?part=3D1
