Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E133F3DA7D9
	for <linux-s390@vger.kernel.org>; Thu,  9 Apr 2026 14:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775744595; cv=pass; b=OamkOR5k0W56XXYOh+Jni9ftdInEh7c6Hf8dx9YcbJgBmlJGz45y7JV5J8gh7d+JDjraPGLGJbR+qNZPUlQwMr0gAvEpxO1Uu6g0xOdejwohU4CYbHCC7ubtGM8ZluMKf47IBwRlFhOctzzTAUJ0xJtGkqsrMcpwnnRlnaxbmmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775744595; c=relaxed/simple;
	bh=sL+DbYXenYNmTUC/7Bv4zzz+q+E0oZ63r6JaIiUCHkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XrOuL+SkiM8jYtdEvad1aqSIp9bIIW8GQvxe3bbqmIhQkfeF3Ym0WgsNdb54yIz/wraxB4zzgJtTpgG1BU4MKc4gNeIdcyKmbicYIoX62y2jvov0PMDn3eFCA7KjlVLP+hcFrh8gwEF1zEhOIs8sX0g1ynO4HxS9A3X/IFvvpNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qdnkxGJZ; arc=pass smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdnkxGJZ"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8a049a767c3so10168476d6.1
        for <linux-s390@vger.kernel.org>; Thu, 09 Apr 2026 07:23:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775744590; cv=none;
        d=google.com; s=arc-20240605;
        b=XN+XGG2AIiqms/wSZjYbdr+qhxkY0n0m/MPDVX3MVJJmnP6z/ecOrjeeJU7vd3lGc6
         kJQzoXuuQ/lqD3lWo76iqUqDw0piEN4MXx5LCX7J5M5SWyNh0wMU9ixrRoyLeTFb1p4z
         hbr17+mDUF2wvMOWAOudrky3hdB6a/izrF+U20GKcgQAD2oW00Mze8A5QMEzDwHAejEI
         eHcO0c+GB1R06oj+Esapyfbyeb+cX+clF7uOUWj0y1SpF45DlMr6fuk/kv/vtcJP4JLH
         NJrMIlUhAEA1+J6zV0CGinq3ZI+HhFW4c89HvESTqlsQVlaS060XJJu+XcsZzKgNtvo0
         ZT+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ok9Bkvi/fMEfbhekzp5HJ85Ko8mmlKRoz8DsAPKgMiE=;
        fh=Q1farkk5tUg428ADnN37GzTuNkXh+3cgx1BeHTBH1Bo=;
        b=aoG3xkL70p10gACqtE19NzUVHty59LAvU58gdlwoj9SPid6KucFRKhHBpGVWwwaM7E
         2KFW++4JXtIfqzC0yq8PyF310Tt3+L7/e3UE/+R3OVqCIhlbKWZFu2eCpuH7CzEDyw9d
         el51GpjvKTVeLC4dBkBStIo89wzQpmpnBg0uprecoT8wAJJ3DDEh5NKtH1qqJ2eHNR7b
         ks30nBgVd4ygwx3pdl1vQ/y4VWgETel563fsMIF3yhYZAF3CE9Z4Z72AjRO80kN1gT+i
         9NvIXSwclbJfFkb7HI2QtbNJpJ8HtTETd/GR5AH92/NKkW7SgT5W6Vi8RMnQ1V6/sU3d
         wgGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775744590; x=1776349390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ok9Bkvi/fMEfbhekzp5HJ85Ko8mmlKRoz8DsAPKgMiE=;
        b=qdnkxGJZZCiRNEBsHBSeD+AYXO/zsKdwjP93YoE7exuF2Lh0+7rJ0lRW35lEcC2UPb
         r89CfTa0/037eoMWbAFc5PVhID72REAyYMZG2JR53ExcS4vgglnC1rw8+/MbHHPNbWEh
         uGADsirmtrfx/HUXQFlq8mYPOlIHbIi4SAu1v6s3iuwnJBQqvHIRNjaKTbxa89tkdBEP
         nUGMPHunpsn4ikMKfS7Ul+Et3jQfmt3ycA41PSe9K0jJF6vVnFV8n627p2xwwtCqRX/C
         P54FeZr1Ce4T2IHwNkYS2gDiidKMZy8okGHf5zMy+Lg92bwQTdruPiKuexGnlumyjBMC
         A/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775744590; x=1776349390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ok9Bkvi/fMEfbhekzp5HJ85Ko8mmlKRoz8DsAPKgMiE=;
        b=pAGHpmIG9INNfdhpxyPPHS7zLRFxtnVq6i+zo0rcdQ2TtIyIK0hsmLxNazAjHqLaUc
         NOFbuSRPtG5i+wTwOdEdyxHzkaJO/ZAGJ5w2jd7AeWSyaLJkwatLL8A1JQzynp1W9eMy
         ZocuUP4gv+5jovGyprUElQim2L//CIC4xt9fT/RWRvlUluto+yIvc1rszERD5xFtFMM2
         KYTt/sRlYFPGgMvrnganQvRt/s1Ti6NZIlmQn1BME/EPJnyrCgPNFgfmrfD8l/aUMrkj
         Kzg44W/iOXfh8XxFNEMpCms12h996n8tkZcamMKe+p13Pl3KZVHrPt5jBwRx8UsuW0QE
         72yA==
X-Forwarded-Encrypted: i=1; AJvYcCUY8bJg0MOYXO1xZ20IfnW9b+5iXrrEUNhTHfuE3lPJX2Hc+Rmpo5Sx5oruWNHgyFbnqW0y8jbo5nf6@vger.kernel.org
X-Gm-Message-State: AOJu0YwHsOOLRuBS8bT1R0OM2H9VSN7zSS+L0FLxSl+Q0s7GVMI09RTL
	vGLImwmIl6AOc5/+p6ZD4PEPJ+KhGw4vP4PIuWgj1A/+57X9m9EHV+lRg+/sMe0MbjhkBEaOenj
	dv5jbBvzCN/Bvi+xVbEt2/cgDX4UepvM=
X-Gm-Gg: AeBDieucIpqVs2JroxJNyfkdaJd4orYv+iPEzZONbHQzkSRX/FjroAQmv//BMyWhqyw
	LqfRpp9eGTXvqqHZwtXaVUuVnQBMzlgJo4OYEtH8Jn15fB5TBG2iXivkvX19gbkTjyDaf1zTBUH
	/bS3JzbP410+zlgsvCubAln6JntK1mmm4UFCofYRrXdBTAFzFD//K9Ci8Si3MM+hPKB1ZMkU4FM
	RcgjwBvmezeE5jRiE8sDvQIt1HmVesc4D2Fp3HjsEaRGLUMXGKie7+KsLikSgzkAmo3V2xgvbDM
	4t9VmQ==
X-Received: by 2002:a05:6214:2484:b0:899:fa7f:7144 with SMTP id
 6a1803df08f44-8ac7469ee67mr54240186d6.26.1775744590254; Thu, 09 Apr 2026
 07:23:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409081154.318898-1-tmricht@linux.ibm.com>
In-Reply-To: <20260409081154.318898-1-tmricht@linux.ibm.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 9 Apr 2026 07:22:59 -0700
X-Gm-Features: AQROBzD80gPK1y_3vDmxCmOBv6wyWKqbtFJ0-pk5BqD2bPZ7-uCZArSH8SDgDDI
Message-ID: <CAH0uvoimMqbULq6gKaVt7Uv4n6Om2Xjpf7yUi7dmVJwtcj_SQg@mail.gmail.com>
Subject: Re: [PATCH] perf test: Make perf trace enum augmentation tests exclusive
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Thu, Apr 9, 2026 at 1:12=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.co=
m> wrote:
>
> Running both tests cases 'perf trace enum augmentation tests'
> and 'perf trace BTF general tests' together causes the first test case
> to fail:
>  # for i in $(seq 5); do \
>         ./perf test 'perf trace enum augmentation tests' \
>         'perf trace BTF general tests'; \
>    done
>  125: perf trace enum augmentation tests  : Ok
>  126: perf trace BTF general tests        : FAILED!
>  125: perf trace enum augmentation tests  : Ok
>  126: perf trace BTF general tests        : FAILED!
>  125: perf trace enum augmentation tests  : Ok
>  126: perf trace BTF general tests        : FAILED!
>  125: perf trace enum augmentation tests  : Ok
>  126: perf trace BTF general tests        : FAILED!
>  125: perf trace enum augmentation tests  : Ok
>  126: perf trace BTF general tests        : FAILED!
>  #
>
> Test case perf trace enum augmentation tests' fails because  the second
> test case 'perf trace BTF general tests' runs concurrently as can
> be observed using a ps -ef | grep perf output list on a different
> window. Both do a perf trace command concurrently.
> Make test case 'perf trace enum augmentation tests' exclusive.
>
>  # for i in $(seq 5); do \
>         ./perf test 'perf trace enum augmentation tests' \
>         'perf trace BTF general tests'; \
>    done
>  125: perf trace BTF general tests        : Ok
>  155: perf trace enum augmentation tests  : Ok
>  125: perf trace BTF general tests        : Ok
>  155: perf trace enum augmentation tests  : Ok
>  125: perf trace BTF general tests        : Ok
>  155: perf trace enum augmentation tests  : Ok
>  125: perf trace BTF general tests        : Ok
>  155: perf trace enum augmentation tests  : Ok
>  125: perf trace BTF general tests        : Ok
>  155: perf trace enum augmentation tests  : Ok
>  #
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Cc: Howard Chu <howardchu95@gmail.com>

Acked-by: Howard Chu <howardchu95@gmail.com>

Thanks,
Howard

> ---
>  tools/perf/tests/shell/trace_btf_enum.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/shell/trace_btf_enum.sh b/tools/perf/tests/=
shell/trace_btf_enum.sh
> index 03e9f680a4a6..437510d46f58 100755
> --- a/tools/perf/tests/shell/trace_btf_enum.sh
> +++ b/tools/perf/tests/shell/trace_btf_enum.sh
> @@ -1,5 +1,5 @@
>  #!/bin/bash
> -# perf trace enum augmentation tests
> +# perf trace enum augmentation tests (exclusive)
>  # SPDX-License-Identifier: GPL-2.0
>
>  err=3D0
> --
> 2.53.0
>
