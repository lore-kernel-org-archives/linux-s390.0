Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5084147DD40
	for <linux-s390@vger.kernel.org>; Mon,  2 Mar 2026 19:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772480676; cv=pass; b=s9Vlmw2Z6yUC8yu0VtjbMlYCwremEc91J98aBVkl0b0iy7+znGehvBTNBG8k7seAwk2KY4r6mSq706mkLKjA1XoYYqCYeR54l5capap/raHlwwJqCyKS0dJ6qomtcKIfpO6/erfhMYvl19qouD1Jx8IOfaVQ1kTtb6GD8rR9/v8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772480676; c=relaxed/simple;
	bh=NblyPX6n2MFoNyHMvC5PC/8KGB/1sHVY4XCBHJPPHfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EKKSvOpgR2tDOagmzXQ6LyHEKQKA3ga5P8guQqE8h0anqqHjOr3dQdhxnxcJfCLTz+2E5jP5M83Pl46UgXp47kYG4jd78LRlDUbaySo4TD+ns+39l7bTagdTAchp0ERHoYacBiHM/ClDVbLot/xNxB8vR5UP5W3OKBy6skx9MYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DqEbp8Bg; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DqEbp8Bg"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ae49120e97so13825ad.0
        for <linux-s390@vger.kernel.org>; Mon, 02 Mar 2026 11:44:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772480672; cv=none;
        d=google.com; s=arc-20240605;
        b=SvqCfWcSV2c97AtwsbIE74OqFVy/ys3UrQzCEZDcBQdqLrozzHET9zQZcki0MDTpUW
         E903cVh6Ae5dj3cvCO12yMUYDLIpBZ6GP1xcw8fVjU5wIHLx/CKEMONhvAwyXKwF4ImI
         T/x81eV0VlRSi3ehnBa4iqQwSYTJMEnfa0vdtmmLZDcuYIvMhISSvrrqFKImKw87biA3
         pbgVz//jv+mAarf9JEfMZlsqoiVtLqUN6vz1z4Ruy1Feezi+LtI5EOpPclEIQ1G1/ghA
         dYJzmRZSVZxvK4tQtaKjIMMH8Gwazjjeb5uVNNv+Du7J99M7n+KgfHPSKhAVYD51PFQs
         mcDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LlQjSWWG40FnbFrNMu/cs5V+4LjgLVNlHIV7QUIZ7bk=;
        fh=NWE2/+vjBrjXFHaRDp7Vkus2HJVVuC+o21o1RLoBHM0=;
        b=Fc1PA1e6INzw/cokE5aICMiibaUwKe3U4UE/U43SoMKUTyQrXGT2wZQ8TT4WnCeT3p
         90+SKpNXikI/UGPMUPzUsNITLY8a4xjebMPX7sdx1EwgTQHYUsegCSgR0IQMprJdfjK/
         lSbQUKwIv3t3DLZ+RR0Jaya5wA51LAxkmnUUZozj3tkC6zj/0LGSHvGNCqrRtjsV755h
         PKhpDURhybKSQVsoqy9mtOQDqlS90a3oEiu/xLQ50N0mqywY0KTi3lO28Gb+l6PCTTM2
         27LBbmUsxDJAS7pwZ8dW51EC6TaclsM0e7EE/VaomBj9ZlEyt4x/Keh10XjDoxdQfiye
         oGXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772480672; x=1773085472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LlQjSWWG40FnbFrNMu/cs5V+4LjgLVNlHIV7QUIZ7bk=;
        b=DqEbp8BgU3DfRFRZ2HrAEwzipmyo4U6K+S1eWyE7TryKrDeDiZPODTR4S+4mPvF9wF
         qwHwrDsgYkO6f2Q1Kw43t1lbi7Lb1G7BKj49DzjSvFSYmI+csnLk/bjBIvfTKIep/cw3
         Jtu+3vmiF46NSNnlKs8DOes25tg7B+VhCt01ZutRmgybbbUlRotEnDoZIvdrwfBVHdyU
         56LaJGu9C2UIJr/aIs56XuvpZKD7mJE8R4mrEsqE0bxMxo8f3wnFy0u5BbgJNss4Fg+n
         P4Riuq6U0j9T6Wj/Ge0kMcqNwWKnG5NYzGzCv3wobUPdYw2+6eMnWmUJvgBft0x+ITyp
         QyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772480672; x=1773085472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LlQjSWWG40FnbFrNMu/cs5V+4LjgLVNlHIV7QUIZ7bk=;
        b=XjMktfeagZRTjzXWV89sRygio6C/wCouPn2X+yP9W4OUGVHZOfk+CrZWirYC/JEGVv
         WROFQgtx4o9yjCkj0x6wqq2Aaf7FIEhZrR1HlISfvYAdop0vw5q+qNh0w3yGh5Yt8+Cg
         yIxVwZmGz8R0BfxlmKrd/B472WCSfX6vNw7ZQ2a4rkz8VmTat/Lt7lLjehV+NoVsKyUv
         YSsWNfIksB3Dr/AvEcxIYfjq5cbjQZsU2v5RVGAcZJsBW9GHMtPO0GVhG0oMaeA5Md+c
         lP9be8u/rVMBcU8HQFdS5Aeodu/ErgE23ygCbwUgl8IYQsQLmFifLH57LlSVEwXYw7b4
         MEuA==
X-Forwarded-Encrypted: i=1; AJvYcCUhe1slv6mrd13k49ZcUi06ubyTCWpGFVveOQw0KuVyRif2vtVsoufhZQx9Jq2E4H7vLIV4z0r1HF7S@vger.kernel.org
X-Gm-Message-State: AOJu0YwCla0ZYByol04tZi03V9ngJYxrZO3MUx87P8oJ/PEuppbJGKtj
	OwCyp95LFftEJY5a7eA+/n9npUtl2nyCIG0QbWRXUmDCvo/xiiOb7p2ioK97oAgh8fBvEInmc18
	STt6fmCn5hf44sgHH4zyvljgq1xYjGrc+Vdq619nwyxwX7LFzunv2/bwPoZ4=
X-Gm-Gg: ATEYQzx0prEpWZpf5MnxxQV6ocQvlDVn7MknJIrKxOoO2Laaioo+D3GrC8sRTQlBNt2
	2ySL1z2w2f3pw8epaNSA7o+SXbskH0u9io7ODYs7nuYWHfJkn5xH+Cwtlt15gJlxxPYwGZ8GAmm
	u9yUmcDM28afIyHtVh4QWNtHBGnxI7RCaYvdhgtSpJh0Rssxvi0A1ZGEO0zLdEPDSaLenbGGFjp
	iB1GVEOfAPNVDWHAji9wXrniG81D2qINbllgfhxbgd4wzhYmIw1cPmvXa70ytAGMyKkEDQ2/4GT
	75GgRv6fY+Csvnm0LdXOc0t+aQdxvwY20Bvr
X-Received: by 2002:a17:902:f68c:b0:2ae:567a:c5a6 with SMTP id
 d9443c01a7336-2ae567ac7c9mr2196405ad.15.1772480671854; Mon, 02 Mar 2026
 11:44:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219113850.354271-1-tmricht@linux.ibm.com>
 <aZzKrRB0__RahFJV@google.com> <aaXaX676sTLCX_LG@x1>
In-Reply-To: <aaXaX676sTLCX_LG@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 2 Mar 2026 11:44:19 -0800
X-Gm-Features: AaiRm50TvWo3R468bpix3BeemkoGP8INcHKdpEntHMODNS40opE6pvZgBur7zak
Message-ID: <CAP-5=fUjyOUi9J6WfXf0HkbiD6Y=vAfT2gSMo0e-L7LOOtPW=A@mail.gmail.com>
Subject: Re: [PATCH v2] perf symbol: Remove psw_idle() from list of idle symbols
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	sumanthk@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 10:43=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Feb 23, 2026 at 01:46:21PM -0800, Namhyung Kim wrote:
> > On Thu, Feb 19, 2026 at 12:38:50PM +0100, Thomas Richter wrote:
> > > Commit fa2ae4a377c0 ("s390/idle: Rewrite psw_idle() in C")
> > >
> > > removes symbols psw_idle() and psw_idle_exit() from the linux
> > > kernel for s390. Remove them in perf tool's list of idle
> > > functions. They can not be detected anymore.
> >
> > But I think old kernels may still run somewhere.  It seems the above
> > commit was merged to v6.10.  Maybe we should wait some more time before
> > removing it in the tool.
>
> Agreed, using a new perf tool, say built from the tarballs made
> available at:
>
> https://www.kernel.org/pub/linux/kernel/tools/perf/v7.0.0/perf-7.0.0-rc1.=
tar.xz
>
> (I will not make a rc2 available since there are no changes to the
> tools/perf codebase in this rc).
>
> On older kernels should still ignore those functions.
>
> A suggestion for work in this area instead is to get those samples into
> a special bucket, the "idle" one, and show it at some place in the
> screen.

Would it also be sensible to pass the perf_env:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/env.h?h=3Dperf-tools-next#n74
into symbol__is_idle? The contents of the perf_env are shown by `perf
report --header`:
```
# =3D=3D=3D=3D=3D=3D=3D=3D
# captured on    : Mon Mar  2 11:34:47 2026
# header version : 1
# data offset    : 904
# data size      : 4268216
# feat offset    : 4269120
# hostname : google.com
# os release : 6.17.13-1rodete1-amd64
# perf version : 7.0.rc1.g982b63f6380b
# arch : x86_64
# nrcpus online : 28
# nrcpus avail : 28
# cpudesc : Intel(R) Core(TM) i7-14700
# cpuid : GenuineIntel,6,183,1
...
# e_machine : 62
#   e_flags : 0
...
```
The kernel version is in the release and the e_machine/arch captures
the CPU type.

Thanks,
Ian

> Thanks,
>
> - Arnaldo
>
