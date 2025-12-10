Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A139A2E7F21
	for <linux-s390@vger.kernel.org>; Wed, 10 Dec 2025 18:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765391718; cv=pass; b=QybwxQ0AFUI8lvOKumx+JSomqbk/OixzS90nXmeLbkB1ap6PD+11gApYwazW1HJYdM8rfCLyALXND8LQtwCGXksiGfBU7zloF5V8xsbEnvJslKkwGyTI4r2vnP0POzjCqcCypCW1F9dj69neByfcNxEKy2XrmUc2zpEU6vxHGGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765391718; c=relaxed/simple;
	bh=7iUZibeL2UHNIR4N1JDwRiO59K1+1GWyhNYWdVfQPPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CFfuQpxIs90sprZI39NTJDcG0zpTb6VHysaW5wSkHxRarS/yiMwIfmrAf0Lm3ThuAddwzuDd9ypp3OwJyIxtkV12mUKaNA3wGLuen9+/B2reoZru9AQ20D5AU5jB6sEM6vd82xZD3YOUt4AN2pFo1sJxn7RAWyTQhP2FAkCZwO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vZS16Qhx; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vZS16Qhx"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2980343d9d1so12475ad.1
        for <linux-s390@vger.kernel.org>; Wed, 10 Dec 2025 10:35:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1765391715; cv=none;
        d=google.com; s=arc-20240605;
        b=P0WwFCQZAi/kytMfxYYyUx46a29jyoyjiMSefXhA2ifMlZJsqN294iK+kDp6BqtdIJ
         skid6+/aD+NNtYNYLsRt667OG/YbHf2mua4cSDmIrnqMKbM8tQvN3l8PYQxLIgOCLXJ6
         OHFKFr7HEQVvt11V+5CyKo+MCph9TZ+FOIdj1/VdXm+lr38y9rOf/dso0smsJKljckGi
         L2YCOhKDujq5kkWdb7o/ovZ1oLH+XfcjEWPvH/oTKV5PKIrg1rLbsSjBDYz6GzHyQdWv
         EQRKQPxcD0rIUg2w5cdOGfnwruQHq+MvVYpvus5JuPpaTcTcDCg6lot7U1fa7A/T5Bv9
         pvSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BZMRIR2Q3ZuqewvXWF5v1G95vOLQu6CiC7DhBrH8+jg=;
        fh=wM21gNOy3cxUm5fh+oUtPWePUAf72QXpOtEdhXUDNWc=;
        b=f+5TE4M2vnytmPgmaOaWLlgPQ0PUu4AaOWtIsNZ8p5zAabdqldyqHETEk7umhDZusF
         ttRjd/RNbnryKP9yhZ58IyWz5elYQJN9W3stGX2W9gRN/dAhFvTSIy9NVAjUjJ46Wdb8
         +iuYRd2+w+HEIe5KrrbBGOL8Dh5DVKtDoCK9C72GT/Wz8HEAIN2GapTOb9QEAwb+mSfk
         V0ZYDet3TS2nkB8k6RIVCBVP31UvKwESJ9RBntlG1Agya0nR/EbqzHWpK5wrUqr7lzK/
         JSRT6Qdx2XAl5cdrd+La0aPrQw2AeWK8JxzORbws5WEYAgioos7UCFpgYZsbFRkRnKzT
         +lqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765391715; x=1765996515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZMRIR2Q3ZuqewvXWF5v1G95vOLQu6CiC7DhBrH8+jg=;
        b=vZS16QhxgBSv1dxUPLO4n60wA4jEGpDJrcxCWPjES9oNxZQVVwXBFHadQYkat1D/Zw
         QmVk4VCmwu+eRUn+gs96X4yl5azYF8W19ElbPFpvH+WMCiaDHfkNl1+gOq1iNPcrasOx
         3AC1TiLxI6Mz6A+IkXEpKAhoF7zOiOylM7DhfOxw/aN5QwS3l+5cY53bAs2btNZ1we1u
         3Ve2YrjyZvFd09UffnwZWdUw0v9N8sXlaI5YFDek+5XpDJp3qWG6L2OcjJ3gP6OM34H7
         qK+3HGaLQBq/Wy3PpqJOvn4BDzQclmDkJSA7WcedDhxmlgN9G/R6xBoeG2wqaszNj0z0
         KI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765391715; x=1765996515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BZMRIR2Q3ZuqewvXWF5v1G95vOLQu6CiC7DhBrH8+jg=;
        b=dpPL9GsBFiIr6RKVJBfDKZe3af29TqkMqWyVGDdvpUM9RGQalUO3U652tpG1dIdvJh
         uSLRu0xDthd8jqXpRa4t9osrQ1wVS9rcvHjwqgEbbhj6o+Jm9393JM7iX/onKAxdyxpW
         z8NjdELZVZYjTSkneH0gGMVa6xE9/RjuCya7eF08fncdGYRSi9x9aMD0JhcXoZQPRylk
         8e2djykZFHKZtqXlJIM1NFUjfRJruyRTs+qPDPrvlBrQxRu+WRcqZJ5+Ui+Oh1Cgp3bX
         1+pdytcbQI0aDFdBm3xOcMVs2dWjicf5Kkw6sxJ3IyraE/DE8hPhCzz02RHJ+WhF0Mvw
         KecA==
X-Forwarded-Encrypted: i=1; AJvYcCUolHkhV8ALK7BRR96yBI2+JE0IZ2+G0n7iiCwImGOZ8xe5UCbHXWv/dwJHF1gEsidTJZB7zI6xxbkD@vger.kernel.org
X-Gm-Message-State: AOJu0YwW+kNBYe5wQLixHAHBNtfmqZWjSHL/puyvMRngLecLTkWx8ewl
	zUie5CHhof45CqThuDhe0fJrfd3doah7aLi035rEs7OltTRt4sLtkkYoQucwK0Q6SN38689vD1k
	WiDKBDuwYKNvpnL95r8/drq22RkNM7UKSM9nutPEL
X-Gm-Gg: AY/fxX45D4REmgEIfUJeHmbFJpqPoJcX8p6+oWPtiXfAuY1T3Hjhw5pe0/AL7VCjfHn
	R/2nWYbSzxGMbwssS41cT/EmqCWOFxbWWu14aCjnYiCz7jakJW8zSkhjFL3G8f2rwrbuCoRlXVT
	xdXHrITGZJuLjV3t6OK+uylv9c+CgOsLjzTo2U/AQYK+AOstJabxCxvb9kr1Fy9iM2qvHj59xoz
	v7zBApbpHPOnes20AYa0hTNEyhiXc84tOSzgPTCCF8UIw5kNDrmhdTVkPmhIz6bPkmPqvUhsaed
	iP/MtPSwNwiiR27dy1VCfi2iHg==
X-Google-Smtp-Source: AGHT+IHkNtWv5/wfc7clfE6FKDxA6B6rrCfOLX5MNaL0d4/+iHfwM93T6frSydRfoQD0vFxm5erOpRpxXqxo4Y94ORY=
X-Received: by 2002:a17:903:3c70:b0:292:b6a0:80df with SMTP id
 d9443c01a7336-29eea1fa30bmr107165ad.10.1765391713128; Wed, 10 Dec 2025
 10:35:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210071752.4160369-1-tmricht@linux.ibm.com>
In-Reply-To: <20251210071752.4160369-1-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 10 Dec 2025 10:35:01 -0800
X-Gm-Features: AQt7F2p7zkl5_tleQz8BxMy-eEc6AfcdZWPmBPnZXC7zroc51uSFIkefyEI9spM
Message-ID: <CAP-5=fXZw9NA7bK6bH+hxPYG0nHGPYKqtYt3pg7iNmsQPWHRig@mail.gmail.com>
Subject: Re: [PATCH v2] perf test: Fix test case perf evlist tests for s390x
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 11:18=E2=80=AFPM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> Perf test case 78: perf evlist tests fails on s390. The failure
> is causes by grouping events cycles and instructions because
> sampling does only support event cycles.
> Change the group to software events to fix this.
>
> Output before:
>   # ./perf test 78
>   78: perf evlist tests              : FAILED!
>   #
>
> Output after:
>   # ./perf test 78
>   78: perf evlist tests              : Ok
>   #
>
> Fixes: db452961de939 ("perf tests evlist: Add basic evlist test")
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

Tested-by: Ian Rogers <irogers@google.com>

Thanks!

Ian

> ---
>  tools/perf/tests/shell/evlist.sh | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/shell/evlist.sh b/tools/perf/tests/shell/ev=
list.sh
> index 140f099e75c1..5632be391710 100755
> --- a/tools/perf/tests/shell/evlist.sh
> +++ b/tools/perf/tests/shell/evlist.sh
> @@ -38,13 +38,14 @@ test_evlist_simple() {
>
>  test_evlist_group() {
>         echo "Group evlist test"
> -       if ! perf record -e "{cycles,instructions}" -o "${perfdata}" true=
 2> /dev/null
> +       if ! perf record -e "{cpu-clock,task-clock}" -o "${perfdata}" \
> +               -- perf test -w noploop 2> /dev/null
>         then
>                 echo "Group evlist [Skipped event group recording failed]=
"
>                 return
>         fi
>
> -       if ! perf evlist -i "${perfdata}" -g | grep -q "{.*cycles.*,.*ins=
tructions.*}"
> +       if ! perf evlist -i "${perfdata}" -g | grep -q "{.*cpu-clock.*,.*=
task-clock.*}"
>         then
>                 echo "Group evlist [Failed to list event group]"
>                 err=3D1
> --
> 2.52.0
>
