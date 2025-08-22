Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3935B29C338
	for <linux-s390@vger.kernel.org>; Fri, 22 Aug 2025 18:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755885761; cv=none; b=mTvQ3rhpf+NxAjNMXsGUoUTfK67Zl8o+qB5z84Iyc6SzCKcMHFyn/0+pU00/auKyD/Dmt54Uaq83qsl58srTs4+qZpqe7GIlUrqkrg6o39lcD+iuCFNTt6llk4+dze5F3xJXOXRKU1Z7v4iveHtmfrq/V0SC7ktM0Nl/dWrwmxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755885761; c=relaxed/simple;
	bh=Tb1rxvji81DhNvos9+34Dpiz+Ba65Rcpm8zkhIppG0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tWpwj6L8wxaTvj8UThVENc5DyFkmjp1p4CXdLUrZueeyYTK9RCR4Cwnac6MAxclWU9lmJ3g+gFtNcqUN0jMGq+mIP8ISkWJSv8qJ+BlDA3y54t5Je108f7ApnoLzORMn7uuscTqSTWgMrPymgijUd/ZcgMprHKilB/wfNMY2JEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q2IsVA4u; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q2IsVA4u"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24611734e18so14405ad.1
        for <linux-s390@vger.kernel.org>; Fri, 22 Aug 2025 11:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755885759; x=1756490559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWb7ujFJINgkd2DMZmp5XVtgDqGOY0d1N6wa3FF1s2Y=;
        b=q2IsVA4uk7cAFQyRT8/zD5kkaWNv1H7tnRqdHK6frrKyZpDmpAX3ASRhPpVgPnp+F7
         UxXg8ZWXnVnn93ZNqpRPrJfXC+q1dGh/Ekh/1QGBzsn5pQLAfkEpIzCKvVdAl8VNb5Ek
         +A8Bihb4cixZdjz4p7sbaOoBjn1USipl8C9PUqlcrtmhplKf14KijV5ELIBSXXl6kqv6
         CcV3QgD6m0eiA69MGn8nDfZiNTGbI2dj32Wm7RrjWPTis3E8qX6H5bvOvUaots9dPHQt
         ISzlYhrK4njCGjFMeG756/SfhcUukKI3g9VMOi//0uyWEpGa70lC405sMlwFIMb40geP
         hw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755885759; x=1756490559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWb7ujFJINgkd2DMZmp5XVtgDqGOY0d1N6wa3FF1s2Y=;
        b=EFy5qwqRnqR/0udWtpsB6i8Ag+OAl1YU7laKhAumyxczbQyHoDBE5pZee94+l783pp
         yD0SICRsmGp/IBb0q674WlxoMi4Otp39MF+stxk/L/rPKooeLvJw1+z2r7/HmGiVph9x
         uaQo1kwyRP0idh1umVCJW6gMGAF5TY4DFdhs7t1vBGeLHTyF63stltyKUqeC3nn+568Y
         +ErViRa1a7XRqW26+Wk6J4wPJytjYlHPneppECerjy2X4Z1OIjUWN4yplQaxDt2oMwv2
         ejR29S3jw9ab58vJg68o2N6hyeDRItJ6JrRToI/EHvY6ubdV3tB40GGD06kJbs2Wub7M
         N28w==
X-Forwarded-Encrypted: i=1; AJvYcCVdBBouYjwq31kJ3Js0bPP82kS5EOgnFjDGjv9SVz16ZBjVSLOZVBIks3bzvbIjJyLLVZm9EtFdqdQz@vger.kernel.org
X-Gm-Message-State: AOJu0Yx23iLhA7BwNpg7XP64Mj+NN82NCFNw2omyYchE+KQl31FM46j1
	Ag5kwxQCBZJfR0q92ZnhyYLrcqwFYhrDtF13KsPdnI8pIzzedD6IclcwkG8xckbkalWRk3hT8iH
	iTIIGzd8ytfgNKZYWl3XdwCWi089CPX868KUhCvlB
X-Gm-Gg: ASbGncuBTfP2sinjKatIAeKZKMUdpNoEMaqBP/sikAbV0QQ9d77N/r/5MhenbrdSVEO
	riXj8ZERxqIzGNFiAd9r5B9rA3TopQVc1OU1U7TSFouVICkTRMYRlcqbz+gBLKEQbmB9vn8XxKd
	TXMFtjRkqagAz249Yg+B2Ba0rG2AbaNs5biA4KqInZqUiTwZIkn7kkXl1G9kl6i+32tfMqblhZq
	MR2YHxrVBAh8mY=
X-Google-Smtp-Source: AGHT+IFA2af6rcs83KxLB8fpKojCpWMKu9Z76RWMk+J7SWpv7uZ/ZhBHV2AkeRZ3bikP+3HIPQPdbu4m0lj7cvNT4m0=
X-Received: by 2002:a17:903:2f82:b0:240:520b:3cbc with SMTP id
 d9443c01a7336-2466fa251e2mr168825ad.14.1755885759046; Fri, 22 Aug 2025
 11:02:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822122540.4104658-1-tmricht@linux.ibm.com>
In-Reply-To: <20250822122540.4104658-1-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 22 Aug 2025 11:02:27 -0700
X-Gm-Features: Ac12FXyykAui8r7AO-hPS1XawpXPdLCTa7zC7cWNH1M5PInPONEDUvbV_1htBbE
Message-ID: <CAP-5=fW43ZAguuB-FB2F6CFTCgd1Fy1Xd+WAt4WSA-fMRTwG5A@mail.gmail.com>
Subject: Re: [Ping][PATCH] perf test: Checking BPF metadata collection fails
 on version string
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	blakejones@google.com, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	sumanthk@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 5:26=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> commit edf2cadf01e8f ("perf test: add test for BPF metadata collection")
>
> fails consistently on the version string check. The perf version
> string on some of the constant integration test machines contains
> characters with special meaning in grep's extended regular expression
> matching algorithm. The output of perf version is:
>
>  # perf version
>  perf version 6.17.0-20250814.rc1.git20.24ea63ea3877.63.fc42.s390x+git
>  #
>
> and the '+' character has special meaning in egrep command.
> Also the use of egrep is deprecated.
>
> Change the perf version string check to fixed character matching
> and get rid of egrep's warning being deprecated. Use grep -F instead.
>
> Output before:
>  # perf test -F 102
>  Checking BPF metadata collection
>  egrep: warning: egrep is obsolescent; using grep -E
>  Basic BPF metadata test [Failed invalid output]
>  102: BPF metadata collection test             : FAILED!
>  #
>
> Output after:
>  # perf test -F 102
>  Checking BPF metadata collection
>  Basic BPF metadata test [Success]
>  102: BPF metadata collection test             : Ok
>  #
>
> Fixes: edf2cadf01e8f ("perf test: add test for BPF metadata collection")
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> Cc: Blake Jones <blakejones@google.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/test_bpf_metadata.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/shell/test_bpf_metadata.sh b/tools/perf/tes=
ts/shell/test_bpf_metadata.sh
> index 69e3c2055134..be67d56e0f09 100755
> --- a/tools/perf/tests/shell/test_bpf_metadata.sh
> +++ b/tools/perf/tests/shell/test_bpf_metadata.sh
> @@ -61,7 +61,7 @@ test_bpf_metadata() {
>                 /perf_version/ {
>                         if (entry) print $NF;
>                 }
> -       ' | egrep "$VERS" > /dev/null
> +       ' | grep -qF "$VERS"
>         then
>                 echo "Basic BPF metadata test [Failed invalid output]"
>                 err=3D1
> --
> 2.50.1
>
>
