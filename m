Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB711EB5B
	for <linux-s390@vger.kernel.org>; Tue, 10 Jun 2025 15:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749571099; cv=none; b=mGmLdIUqFngPxTCWLlnGBiQQ/HuN0+SMcOhRtp8pwvrbZdTrMOgV3nhcfbz1k1T1ZraNS4g4k/INJFJDivZfk5fOIUVfd/8ntkYGYRjJb5boBMc72hRDv6nZQ/Y+tXUGzij8pLRrlbOm46ywMRltt/zCxjuVWME5Z3OXfhf/DMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749571099; c=relaxed/simple;
	bh=JnvDsI2V0SfYirDWe8D7vHoy0/Tmj2p6mupoH7x8L9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FfhWtixnqUHheIVa20tUXufKT/EGWJ4ql1IkpI8NEsEw1F6+Dy+vymgMhluNpBaMdcZqcFIznhi+mQapub7s3lO7ADF7VtTT6qGoKABSfELKkqvhIocQCgRG/eJAoNG+e35EPuQmghSSA+/XNxHdWCyqFYsWZjn89oJLgT+J3TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fpzcavzY; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fpzcavzY"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-acae7e7587dso853538766b.2
        for <linux-s390@vger.kernel.org>; Tue, 10 Jun 2025 08:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749571095; x=1750175895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nrvEV1OyFqB896sh+D7+1KEv79egMokePh1tw2xdC8=;
        b=fpzcavzYpIFPLSAsNFuceyxcoukQwA42mDMP7WkiNYl3VbbETe0oyw2peWRl2bLMaF
         m/G+viYKo5WKUWWt21kyyNcd5BGhibYnOZCD74L4CGCZQ3mbPI8PQcZzyzLhe/xQ/74r
         nzoK7uqRek5xAubfXo/eJKFBf6U54T+zfppK8V4o27lKtNak0uW+rn+VHOLZJuuS9au7
         LiSiUvWFg9kR8zqSuEHCXcTH5oUPnTFMuUx3DNf51gQ8OJoL5L/pDAzidKBE97HYkK9V
         VEAeHIh7wG0+ZQMug+94NSLRDRK/cVr9LDcWptW35if8PFdp8AjDbcsMvopwL92YpTG8
         /Bfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749571095; x=1750175895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/nrvEV1OyFqB896sh+D7+1KEv79egMokePh1tw2xdC8=;
        b=vhMskW/ZElXjYHiX8LfPYmaX6EEOF6Yxu24sjkUVR+0HjL2QaEpzVawf3hUcaOSzki
         SHm29AtW9F41rvpjAFx5lAVC/u6mfWKHuAvwrNHUN/v2qcRuD4SCZ9cj+KyIZq84lWT4
         YbIajXA93JBVUfc20Qv0mnrJm5uOV3zpxGIUkyQZOSH+R6EcpiYQBw32y9fHbzcZJnuq
         Ce1L6KsOBTG/pPpekrZvLgPDO8HM8WmZwYttAtGDrA9g/aIqiOpI9WEZ7CQqEIXKgfUP
         ePNK1bZ+7vHj1gslKd5ANymdVshhFtvFFWBK9l79Ir3ku3nrA7Wla0pfLaaP2VfC5mpi
         /3xA==
X-Forwarded-Encrypted: i=1; AJvYcCVoo5asiIWRwFUmG5cyMMW0wtD0sNGiawHV4EQ3pBjWonEnHnp9iMFqYAREoyRFMDN5bM9boURWE6yd@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy7o+iNZKhS2JrzTjAFHsxEu/Gfp2cnd/KeaURd4aAPFtcepQ3
	k8f778UwSPz6V/V30PoJMjvcUdq8wa5wSud00+yx16SWyrnRavR9j5E+dx9rEbnKw6h3JnAx4ho
	ECdn/KjHhon5R0JLM4MpG3IWRHjWWpAvmHWLsN1zD
X-Gm-Gg: ASbGnctBV1C9uoAITdVovjqxxyukbaXMHQ23YpT14G9yfEWgYrv0eMAWwj3AolE0Vat
	c68Q9ihUDcKrC5ejZzmYuDevqWMqzHOg3lJhFWM0h1GdSvcGLxj2iuk/X5OhzENswwmMubilSAV
	8u2vYd3ydBpwQv5jFXRVg0NFJZ5Cs7VQ1BsO1kTUAOMK+vC64NtTqGmhE5IhYQ4ihPk/Xyo6c=
X-Google-Smtp-Source: AGHT+IGnT2C8qqzfjiqBjWATFVDFEKGYo5bsTw0MRS4kvRY+vyWG7uSjPLyA0jhrMN5sAXMyjjxyLuUOF8Q/Cd3r9Hw=
X-Received: by 2002:a17:907:1c8e:b0:ad8:9466:3354 with SMTP id
 a640c23a62f3a-ade1a9e9335mr1661481266b.54.1749571094854; Tue, 10 Jun 2025
 08:58:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610144507.2839326-1-tmricht@linux.ibm.com>
In-Reply-To: <20250610144507.2839326-1-tmricht@linux.ibm.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Tue, 10 Jun 2025 08:58:02 -0700
X-Gm-Features: AX0GCFvf4WqpGFzStiZrH2ln41VV3jtPIe_kDsffbZb2HUEZr5ZRe6tnhFUMJk8
Message-ID: <CAJpZYjWpcmqZfVFkCPa7ou6C+4zK0J07Q6iGmEPN4-zS9oDsiw@mail.gmail.com>
Subject: Re: [PATCH] perf test: Skip stat uniquifying test if unavailable
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

Thanks for the fix. Arnaldo also had a fix and should fix this issue.

https://lore.kernel.org/all/aEHugAPinlWLuTAS@x1/

Thanks,
CT


On Tue, Jun 10, 2025 at 7:45=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> Commit cb422594d6206 ("perf test: Add stat uniquifying test")
> introduced a new test case which uses an event named clockticks
> which is exported as sysfs file .../uncore_imc_0/clockticks.
> This file does not exist on s390 and causes the test case to
> always fail.
>
> Check for the existence of file clockticks and skip this
> test if the event does not exist.
>
> Output before:
>  #  perf test 87
>  87: perf stat events uniquifying       : FAILED!
>  # ./perf stat -e clockticks -A
>    event syntax error: 'clockticks'
>                         \___ Bad event name
>    ...
>  #
>
> Output after:
>  #  perf test 87
>  87: perf stat events uniquifying       : Skip
>  #
>
> Fixes: cb422594d6206 ("perf test: Add stat uniquifying test")
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> Cc: Chun-Tse Shao <ctshao@google.com>
> ---
>  tools/perf/tests/shell/stat+event_uniquifying.sh | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tools/perf/tests/shell/stat+event_uniquifying.sh b/tools/per=
f/tests/shell/stat+event_uniquifying.sh
> index 5ec35c52b7d9..485ee6e8f574 100755
> --- a/tools/perf/tests/shell/stat+event_uniquifying.sh
> +++ b/tools/perf/tests/shell/stat+event_uniquifying.sh
> @@ -49,6 +49,11 @@ test_event_uniquifying() {
>      uniquified_event_array+=3D("${uniquified_event}")
>    done < <(${perf_tool} list -v ${event} | grep "\[Kernel PMU event\]")
>
> +  if [ -z "$uniquified_event" ]
> +  then
> +    err=3D2
> +    return
> +  fi
>    perf_command=3D"${perf_tool} stat -e $event -A -o ${stat_output} -- tr=
ue"
>    $perf_command
>
> --
> 2.49.0
>
