Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6C237E315
	for <linux-s390@vger.kernel.org>; Mon, 23 Feb 2026 23:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888490; cv=none; b=YaKQnre60z2WFJnTtlVBUf7C5kT2fVBJgRKnR1vlubBp7T4/g06hDlXpQDUJjsTyW6yRwxC7zDfwIQxNksI/7oTZQrhmS7sKNue3ygklhxQCpNqlyp7gDjcFuS/jIS38gFGFrHYxcBmBvWZHskJkLMn11swcP8qX2m1hQRVKVJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888490; c=relaxed/simple;
	bh=JyP8xZsY798o/0PE1UPbXTVaou8v7v8Te0+LuhPVmxo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=JkR7ZD+ZcApafTdnTKn0iYUGi7bMBfsUGR5jtGKdvcIoQa2ECRMyRsis5haZQiTSqC7fmyBZJThSS10Fykl+kUuvQKOUO41P2Qkdifv295cKgpZhTUiDxeI+CMs6aOWKwWMGdd4W3Aac6J1B3q3EXzsMFmThbhYMC133WAdtUlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M61VmCZB; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M61VmCZB"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-94dd2d71231so119795241.0
        for <linux-s390@vger.kernel.org>; Mon, 23 Feb 2026 15:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771888488; x=1772493288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Fbph/XM0xt7O8t9uLxxk2AnhFh/nLkRg8Z1c3orIPEA=;
        b=M61VmCZBdFgMRPExBy4IKcjdoIFaiKElNADFaN75LSheF1rcvTNUjA+tnm5b0DorEL
         MtMvMbOtepxvewiH1DSmzwR8gEtvGCXWRADNs68kZmgDZ5ErlsSgGWHoWOZ5IEMSijj6
         OqxoKEMmDbVSq/V/Iqy3A6krPb8DPxRXg69kxIsWIux0oA7VVAcMt8gK9T3i8HCHD6bH
         TSOXgP+f7LoesU5ewU7Oa6ewuUCxi3n6hnjQYItX9vsblIXe8a0PpW43Odf2vJLikTSF
         U1BFXOHy8jfQdmUSqujuO6GniDegtGQsffMll6PYgZglxvtl88NtKLGnPSaeSG9LFkQT
         JZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771888488; x=1772493288;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fbph/XM0xt7O8t9uLxxk2AnhFh/nLkRg8Z1c3orIPEA=;
        b=aOTVeHpN/2uIprePsYqmWluqBou1TkamDo0fUu11BVha8+s9m2TOocHpFliB2ji3ef
         gonyWbclvKyXVmgzz/fNa01KHu0jc18u7AMzA7vn63RQcYqUj70jEs3cxulq1bDtuZ2W
         o85ARvpUXeZnGgAwi1qgduXq3r/cibJpiOsPJlFEu9hKC1rNIlV7vNHAhqethzDEIWn3
         lPb6ahFHEMBxbCjh1is71mk+Nbgkt22HbjuVyrhB0SLCXApbzuLGxWTF/cRgFvLIVMKQ
         P1JwcPQ+jh2lgAWJEqrJUuwcTkimFTVEBQdUj4Qiw/tBp0OnVtd1zJPE1BKR1GocD5qx
         6siA==
X-Forwarded-Encrypted: i=1; AJvYcCUBvoqgwccXUnTAHeRwrfKHkdl5YN10POOH+93tq6H1YoG6102crLoOJWFXoP3uW6T5iblMjCVhNWcS@vger.kernel.org
X-Gm-Message-State: AOJu0YwesxbQKq5WTgg5S0V+2BtQ/BX/EXIVRuIGeemDKPOrrUdmjctd
	rJlavs7mG66ezDkIS5/UoIggCePpKmtagVFm5rsEgitfo0tMk1d2d6WWXMbOKg==
X-Gm-Gg: ATEYQzzVDFI96GwZWSuxn4X5iiRFNuS2WEgauTwh7dv0UWg6AFQahyO2QyTdmvx9yFZ
	TaxXz/XaHQFDGO2uAEnwfUCqe6+Esp/PfnchCgLKVaa5ilwFlm7gbfPuy/rlrIO8FVRjJgVawP6
	slEefhfdx9l7EK7Pa89ukNqcxlHnOo664iaAMXVVHDu0g4URC3rLnc7W/3p1a6x7LITbqX1P2CH
	5W7uK1Ocxspr1Ih9LA+UZR2HUp/NaJDkm94KI+uP3mXpY/lJd7BQwMUHWAWK3NdrM89aXl3j/Kg
	MRrtnmjxoAdr+rM9qPckg5Pt7kG+/CALR6bUI7TY9LmWWmOym5nNFaqYvlILjJwNTWZnHBX/7UP
	LIOMonRzaR5Xwi94a13q6bangKBBmC4x9jmWyrvijJuzHOJe/vBva/qmfCMcSzp3OHNXVrKCFJh
	mnwiDWLXpM7IMFYprL4tKnj4jXae8i4/2t6Ecu
X-Received: by 2002:a05:6102:3a0a:b0:5f5:5925:defb with SMTP id ada2fe7eead31-5feb2ea36d9mr4002898137.10.1771888488425;
        Mon, 23 Feb 2026 15:14:48 -0800 (PST)
Received: from ehlo.thunderbird.net ([186.208.68.154])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5feb6485fd5sm9152375137.11.2026.02.23.15.14.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 15:14:47 -0800 (PST)
Date: Mon, 23 Feb 2026 20:14:12 -0300
From: Arnaldo Melo <arnaldo.melo@gmail.com>
To: Namhyung Kim <namhyung@kernel.org>, Thomas Richter <tmricht@linux.ibm.com>
CC: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-perf-users@vger.kernel.org, acme@kernel.org, agordeev@linux.ibm.com,
 gor@linux.ibm.com, sumanthk@linux.ibm.com, hca@linux.ibm.com,
 japo@linux.ibm.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_perf_symbol=3A_Remove_?=
 =?US-ASCII?Q?psw=5Fidle=28=29_from_list_of_idle_symbols?=
User-Agent: Thunderbird for Android
In-Reply-To: <aZzKrRB0__RahFJV@google.com>
References: <20260219113850.354271-1-tmricht@linux.ibm.com> <aZzKrRB0__RahFJV@google.com>
Message-ID: <E491E5CA-49E8-4B41-8701-6C07B2F77A98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On February 23, 2026 6:46:21 PM GMT-03:00, Namhyung Kim <namhyung@kernel=
=2Eorg> wrote:
>On Thu, Feb 19, 2026 at 12:38:50PM +0100, Thomas Richter wrote:
>> Commit fa2ae4a377c0 ("s390/idle: Rewrite psw_idle() in C")
>>=20
>> removes symbols psw_idle() and psw_idle_exit() from the linux
>> kernel for s390=2E Remove them in perf tool's list of idle
>> functions=2E They can not be detected anymore=2E
>
>But I think old kernels may still run somewhere=2E  It seems the above
>commit was merged to v6=2E10=2E  Maybe we should wait some more time befo=
re
>removing it in the tool=2E

Right, people keep asking if one can use a new version of perf on an old k=
ernel and vice versa=2E=20

So I think we should not apply this patch=2E=20

There has been efforts in the past to try to have have some info per sampl=
e indicating the "context" for a sample, if it was in idle processing, hard=
/soft irq processing, etc, but that didn't come to fruition so far=2E=20

With that we could get rid of this flaky heuristic of looking at a symbol =
name=2E

- Arnaldo


>
>Thanks,
>Namhyung
>
>>=20
>> Signed-off-by: Thomas Richter <tmricht@linux=2Eibm=2Ecom>
>> Suggested-by: Heiko Carstens <hca@linux=2Eibm=2Ecom>
>> ---
>>  tools/perf/util/symbol=2Ec | 2 --
>>  1 file changed, 2 deletions(-)
>>=20
>> diff --git a/tools/perf/util/symbol=2Ec b/tools/perf/util/symbol=2Ec
>> index 814f960fa8f8=2E=2E575951d98b1b 100644
>> --- a/tools/perf/util/symbol=2Ec
>> +++ b/tools/perf/util/symbol=2Ec
>> @@ -752,8 +752,6 @@ static bool symbol__is_idle(const char *name)
>>  		"poll_idle",
>>  		"ppc64_runlatch_off",
>>  		"pseries_dedicated_idle_sleep",
>> -		"psw_idle",
>> -		"psw_idle_exit",
>>  		NULL
>>  	};
>>  	int i;
>> --=20
>> 2=2E53=2E0
>>=20

- Arnaldo 
