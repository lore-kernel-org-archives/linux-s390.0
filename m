Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A742D0610
	for <linux-s390@vger.kernel.org>; Mon,  9 Mar 2026 18:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773080324; cv=pass; b=DNSQS0UorJ0HOmTsu4TMkrF6TYkTLLWR3LGm3P/wvyrZb7jXXQWK4mtp+ywus5KZDVXrC4Eo5cLeNtRQoOq1nwrf9jHAHyn5P7g5C9TWvpQiWI3g8UmdW7FJ9yguHnYQDQ8Bp13a6r8deNsh2yWWffLT7FKyoujIH/Mb6ZMIgYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773080324; c=relaxed/simple;
	bh=VjCK9O9mWN+S+Owop3XPnvrdHjcUqFjZT/JVHGCIYYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KPpeUNSZUpvWo6/92pX7K5uu86B14IMFRO93yoqwDFWL2/V4RAnnv7ONUszPqLFYUkDh1s0hKIa0CDUHySraeLkTIDu89Cj96zT2txuo8ThrWk4vBLsP2oZ0dbm5sfrdvYeV6RtZrvPuXBoFBgJ5YgbGtwOex5zCJWElPmq90Bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QjYRfoHO; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QjYRfoHO"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ae4b40999bso19455ad.1
        for <linux-s390@vger.kernel.org>; Mon, 09 Mar 2026 11:18:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773080320; cv=none;
        d=google.com; s=arc-20240605;
        b=fa2uHPXsu+S94rbziGG92PS9P9R0p8emgFJmE8nUunj7dLOqYRiXrA/PMhAH9yTJcI
         Qa/wvhKzgCNJTLKbMqJyjUbeRaL2twX6fO/eTb6IxOvcZDNPihazhZEbEaVk/XsuUKfu
         neHjnmqB+R6uZZKFUqa+8f+eYJla8N/wpJUmvBDb6YxB3N8KMMwa/vHMjlr40EY7qJjv
         STqscoFEg9jWQNAWh2mA/ruyqA4xVVPKpEBlyXrnXuTAFKu9rOG8737V9ku1QvBCRn0m
         Jhnz7vcACWvygXdA4AISxrZqieUGPS/lynssBu53JteOrUCgGpV9VadQ2Alo4oQtlJfL
         eVLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mNFhEsxk7RBeGZyKEG7ERKLw/wU59C/RzDtV/jvgQtI=;
        fh=HohoiW53O26JKnG6eJ1kMKCt+3Vvb0TUEj8ZEQyZidg=;
        b=SZ9lOzl5o0rXeEPlMjcwbmTzDkYbV/40gbKBqZB9xeEMiXvQpkclJyoHqGk3YK1+t4
         g4U2bc1HOh7fe2/mkKcrrrYexHJRFJgQkFzmHPQZinZtZxbKc+Dsa/MiMF1dscx44YPN
         9Z1aop2ECOya50ppN289l5CKahiKjB2WCCi/1F0b1tnzL/ctcH1DJ0Gp4FbLiRtALd1y
         kwXoeE4sUPLTtCt4tt6l+2vKl94mkKyT5M7v6vRqO39sk7JByX+/nVGv5NoRKd4RBaFM
         t2Y1cz97htzjB8pwolA9/8b8XZchMmI0ysgnkMw+Pg2NPcJwAAKFJpTeXT29ctZrxzaT
         QP8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773080320; x=1773685120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNFhEsxk7RBeGZyKEG7ERKLw/wU59C/RzDtV/jvgQtI=;
        b=QjYRfoHOuF+CorLAMzY3+zlv3ZDDwWpP7V9fVALAxmLYX25J3dbAP+yVqwkMQBdrbT
         /Fbgt7iUB8bRi/ijLAaOvjLmTSpU5ROiHfhP1wM/TxC4HXUaPUtQJiwaQ7z/X3JNKlQv
         wwGOJtbsIW09xKlffd6a7urvktoDMh4hXDEn/on5Kxc3RJ4aS4KUdCW+wTEjjSxk139F
         FzLPlneLjOqUJtUNbdcrFzCM3Dkiamp+bR1FlSqN+H8FOoHLza/UZgMmcPbH4WkwNAUv
         mzGOfTK0KFOG3hf+eihbQj9tCLowOs1E1sADouuLblLgmN6RdRnsv5jKrHT4V6jHGzob
         bBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773080320; x=1773685120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mNFhEsxk7RBeGZyKEG7ERKLw/wU59C/RzDtV/jvgQtI=;
        b=k782N1z4OEfu3RD4ITVh46u/90iUrzjSZeJZEmrrRZLQ7feI/hGuUfbtJGgVpLkuGf
         GInRIzkYfcBr+BASZp538ma1lTChdTmiwzBpRFDPAdROM2ZEdoTPd+lbk3HbqRUmMO4p
         pPhv5wlO3UnxeiBOK6SZjYNajffeW1AMMjymmu30oXe55DE6zalIMP1ux1QNW1w8CgmL
         s0e9OSXCWzo/R8BrQ0f2mjov75HXEtw+gKhEz2hC85NXLm9oo0D8EVGkuw9MC5pd8aE1
         PbZOx15wsPDDIyXaE5IBe0smYMaKGOV8r4Xs4grdOtJif720nHs2fZCrNLQboTzFQtnX
         4ZQg==
X-Forwarded-Encrypted: i=1; AJvYcCU5Ym5Sy2Hl2DggkShdlYAR1KmHyqc/gBev9DtI8axFa7HlwNsl3IqGyz+R/FOO+DO5PU7Pw4JkcLWd@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ26/8pkeqRVQUWP12vS9vc/TB6vJRoA73EWO72rGms09FVr/R
	q80/ZhKMau/9GVR4NOCPA4oXsAL4Z0+JJ1lNiLeEbq810GupuRilvIAuD7bCyVEj1rd0o5WaGgt
	11+IrWIsq+3F0esWDBWEyKMvqxIac9V0oSZ5siJq6
X-Gm-Gg: ATEYQzxh0aWXro9uibAI+93euOExl2J3zEvTHKXDO1FaMiGRTukJg38iro8bB0ncDnp
	E8jCwL+TzszrHwmf3MScO/kkC4jLPNVN06l+0wZGzT7H77TvKNrsLZqpox2ozEMTlwIHJi29+Wz
	96S6yN7E1ByxIoKlWRX+SdD+kMFRV6HtAH4v4O2DSNBEPpzr6/j52oOAbCLPGuLkn6N/6uQTq7A
	vx4V6NLuaCC89IFwUV3H9ikMlfVqyzR/HtQ2IDHPD2L53ppSGYibguLGa6XEGb3B/s+v3GhaQPz
	woUfH3in8z9Bqgvrm0FQpfAjB6+Oz4mdQAXXgS50iHdPfg==
X-Received: by 2002:a17:902:f601:b0:2ad:6f9b:7818 with SMTP id
 d9443c01a7336-2aea32a5a08mr210975ad.23.1773080320080; Mon, 09 Mar 2026
 11:18:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306071002.2526085-1-tmricht@linux.ibm.com>
 <aar4GKP1c66egZnn@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
 <CAP-5=fXs0UrMVhwU-_=iunCYa_ye18FHj0W1V8sE5T9nOkeZWg@mail.gmail.com> <a3b8bf7e-ec5c-460b-9ffc-ca1d2cd9e223@linux.ibm.com>
In-Reply-To: <a3b8bf7e-ec5c-460b-9ffc-ca1d2cd9e223@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 11:18:28 -0700
X-Gm-Features: AaiRm53NpshLl2TAryEIsM_KO_pJOOQiJbOuKf-KMqb7PS5CdD3Srr6i6S6j9u8
Message-ID: <CAP-5=fVziHx2B8QPWafPo0T_JWm06zD4vwtR4DmcFyePV04U0Q@mail.gmail.com>
Subject: Re: [PATCH] perf test: Fix test case 120 and 121 for s390
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: Jan Polensky <japo@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, 
	namhyung@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	sumanthk@linux.ibm.com, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 5:59=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.co=
m> wrote:
>
> On 3/6/26 17:53, Ian Rogers wrote:
> > On Fri, Mar 6, 2026 at 7:52=E2=80=AFAM Jan Polensky <japo@linux.ibm.com=
> wrote:
> >>
> >> On Fri, Mar 06, 2026 at 08:10:02AM +0100, Thomas Richter wrote:
> >>> Perf tests
> >>> 120: 'perf data convert --to-ctf' command test
> >>> 121: 'perf data convert --to-json' command test
> >>> fail on s390. It is caused by selecting the default event cycles
> >>> which does not exist on s390 z/VM. Use software event cpu-clock
> >>> and specify it explicitly on the command line.
> >>>
> >>> Output before:
> >>> =E2=9D=AF perf test 120 121
> >>> 120: 'perf data convert --to-ctf' command test       : FAILED!
> >>> 121: 'perf data convert --to-json' command test      : FAILED!
> >>>
> >>> Output after:
> >>> =E2=9D=AF perf test 120 121
> >>> 120: 'perf data convert --to-ctf' command test       : Ok
> >>> 121: 'perf data convert --to-json' command test      : Ok
> >>>
> >>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> >> [snip]
> >> Thanks for providing this, Thomas!
> >> Tested-by: Jan Polensky <japo@linux.ibm.com>
> >> Reviewed-by: Jan Polensky <japo@linux.ibm.com>
> >
> > Should we not fallback for the cycles as a default event?
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/builtin-record.c#n1374
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/util/evsel.c#n3792
> >
> > Thanks,
> > Ian
> >
>
> The fallback should be cpu-clock in case hardware event cycles (or CPU_CY=
CLES on s390) does not exist.

Thanks Thomas, so the change is doing:
```
-       if ! perf record -o "$perfdata" -F 99 -g -- perf test -w noploop
+       if ! perf record -o "$perfdata" -e cpu-clock -F 99 -g -- perf
test -w noploop
```
where the default event is cycles:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/tools/perf/util/evlist.c#n116
Given that cycles will fail but then fallback to cpu-clock:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/tools/perf/util/evsel.c#n3792
I wonder if the issue is that the fallback is broken. Specifically:
```
   evsel->core.attr.type   =3D=3D PERF_TYPE_HARDWARE &&
   evsel->core.attr.config =3D=3D PERF_COUNT_HW_CPU_CYCLES) {
```
It isn't going to work well on hybrid machines or those whose PMU's
sysfs events or JSON include a cycles event. I wonder if using
`evsel__match(evsel, HARDWARE, CYCLES)` would be better, as the
evsel__match code is more robust to these kind of variances. I don't
know if that will address the fallback problem for you.

Thanks,
Ian


> Thanks Thomas
> --
> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, German=
y
> --
> IBM Deutschland Research & Development GmbH
>
> Vorsitzender des Aufsichtsrats: Wolfgang Wendt
>
> Gesch=C3=A4ftsf=C3=BChrung: David Faller
>
> Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stut=
tgart, HRB 243294
