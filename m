Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FB225760;
	Sat,  1 Feb 2025 11:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738409652; cv=none; b=Z8TE8lhCjCZXflp/J2F9zO17vwYPJZuex8qNB0CK9V/lxulhYf9tqq/ipGMKneMuZZvD61TWv4VKZXiothOAQ6iFcvzT3tShpcUeFshLxEfL3+m6jt4Kcbp6aDmJsGIb829B/D+vpl0XWS7eY235hKdvK/fMM73xOMhBGamLO3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738409652; c=relaxed/simple;
	bh=2E0q54b3eypL3Ri2OP5FYkG06AqSFV2huCTuS8ngfn0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AxiN/2OiCv76aJyH4MgMxzDPoqv9/av/aZSluWis7qsZvqDcTycpfucVwpuPlXilQ9EhGzb2IyBZvuzLcsRqrXdDNB2L8aCy8l8fBEPisBeW9EZ9tbcP0FtmZhgwX/3tKui+2gjwTEuxhTffY1rHZkj3XQZXmVaPdKmovELa8NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gaqgJn8S; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gaqgJn8S"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-436281c8a38so20555985e9.3;
        Sat, 01 Feb 2025 03:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738409647; x=1739014447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQomFJ4ChnU4fj4lFRCI9h/dmZzlSZdFogkPyQv5YjU=;
        b=gaqgJn8Scloe+tZ8749PO59kUBdJNUScqXUjE1WmLFoBB5ppceXLLNg66B9R4+fAbL
         EITRwIgjzBCGv0YR+ZDFzgddUKGXLVC+qnFU/H68ZHnJWTswPHWt1W8KeNvqpqWYDr0+
         YJJMvSGK//+wGtrHervyzvA7lo7LMCTkUkloac5hUWzLHmlrHcbtuUEoFQT/b+AY9W+G
         FhNUwnSTJ5FJyGFQQdbT+sYh/kWclfs+Cg1X/xUiFsIwo5fSTgj6BVQOClJk5Hql/bk2
         Qi1bRDxFdurF4+7hlUtX/YxbfSijtbVPHH/WCnJYvxzlARKN9ekG0l9Jc4Q4oA7H+nEl
         G3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738409647; x=1739014447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQomFJ4ChnU4fj4lFRCI9h/dmZzlSZdFogkPyQv5YjU=;
        b=fspzqWyWv0snFhkw8GzJS1xjKFUx9vBVLo+9qKf+Ei2nG3QgVWvG+2k7KJKgOT8HMu
         PCbrCqPQ9oRNxE/hCT7kYj5uEn1oMEv3fRB1k19Z6y2hBg/Zlb6qhdINk7PB0XlIjaPG
         lJI010VQ6luFQAUy2IGOqDK3j+lgwbjkJvSdYHilv7NcZ7JjKDAhO3GEuKu6jETzDcmx
         htBCUEZmp+GMK70JeY3LUt/dlIdLAXN1dVNtWwgi+8H8my7Bm1w0ksOM54bc9Qv4e9vh
         F7dMB3l6gRAGbbWYIBKyjpK/oRBSuN2y34DoHj3cVwRVJkNXFamz8iQJtNf/lr+NYQBH
         2pVA==
X-Forwarded-Encrypted: i=1; AJvYcCWu8xynsBUcHEZr4pQA26nv17LKh58HhddbdcO+GWMc4zBfU6ePdQXEorQuBMsiCo+6oxfcqQp183kuCcBfYuPQ@vger.kernel.org, AJvYcCX3ry8p+mbQEv1E+5Dy5DnhGTXPWxueEY/TgWev8lq4aonf2c3WgG11bxgbL0P+uPxGVV7/m5PZtTyBcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHJvCd3Xt88bG0qOyf/XcCW99mSiyDZ+F2EhfS1Qp/qB9tYOEG
	jGW3UqHqZ/qqostfqcz0E2bccW38JA6WdHCN5KR/6xqAo5+7ec5y
X-Gm-Gg: ASbGncvKKXAppBRLJ2pqwHvI7X6kJCglHY+ztpD/aS+OAdopxuX5RTO2guUEd7pFmH6
	DjML5Re5KJvaY2C9YA9EHsz0JntBaj1fPSidklmNycW+9FPR5HPvRI8jH/AZcZnDjAGp0Lxkl8S
	sq6OO2n/WVitutsT7bV1vXMN1SY18SagIAI9R5CQPGPG1J3m1JQ9AHrgxsWoskBKu/7JXQrQ2lh
	alejYpHnV3KT8G0Y3Z7a1q5/AiIYZDYuGfl/S37VBPuioyHPlxIRhB5oMTJcMR+XLnC5PoFOSxE
	Vhc9RY3kSTZUF5C3OMxJj28jevKpgdA/9OeAVOvjIregrdB6MGfF4Q==
X-Google-Smtp-Source: AGHT+IFnnAAw3xF3oDUKUQhc4FZRLZaD+TRflMNSpfR1uTA1CXslNeBfeoL7eV4BqL2DdUjlQsg+Fw==
X-Received: by 2002:a5d:6d0c:0:b0:38a:88b8:97a9 with SMTP id ffacd0b85a97d-38c51949b38mr11350742f8f.2.1738409647375;
        Sat, 01 Feb 2025 03:34:07 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c0ecc80sm7224343f8f.16.2025.02.01.03.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 03:34:07 -0800 (PST)
Date: Sat, 1 Feb 2025 11:34:06 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
 irogers@google.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
 sumanthk@linux.ibm.com, hca@linux.ibm.com
Subject: Re: [PATCH] perf test: Fix perf test 11 hwmon endianess issue
Message-ID: <20250201113406.4312a601@pumpkin>
In-Reply-To: <20250131112400.568975-1-tmricht@linux.ibm.com>
References: <20250131112400.568975-1-tmricht@linux.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Jan 2025 12:24:00 +0100
Thomas Richter <tmricht@linux.ibm.com> wrote:

> perf test 11 hwmon fails on s390 with this error
> 
>  # ./perf test -Fv 11
>  --- start ---
>  ---- end ----
>  11.1: Basic parsing test             : Ok
>  --- start ---
>  Testing 'temp_test_hwmon_event1'
>  Using CPUID IBM,3931,704,A01,3.7,002f
>  temp_test_hwmon_event1 -> hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/
>  FAILED tests/hwmon_pmu.c:189 Unexpected config for
>     'temp_test_hwmon_event1', 292470092988416 != 655361
>  ---- end ----
>  11.2: Parsing without PMU name       : FAILED!
>  --- start ---
>  Testing 'hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/'
>  FAILED tests/hwmon_pmu.c:189 Unexpected config for
>     'hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/',
>     292470092988416 != 655361
>  ---- end ----
>  11.3: Parsing with PMU name          : FAILED!
>  #
> 
> The root cause is in member test_event::config which is initialized
> to 0xA0001 or 655361. During event parsing a long list event parsing
> functions are called and end up with this gdb call stack:
...
> However member key::type_and_num is defined as union and bit field:
> 
>    union hwmon_pmu_event_key {
>         long type_and_num;
>         struct {
>                 int num :16;
>                 enum hwmon_type type :8;
>         };
>    };

That is entirely horrid.

I'm surprised this even compiles:
static size_t hwmon_pmu__event_hashmap_hash(long key, void *ctx __maybe_unused)
{
	return ((union hwmon_pmu_event_key)key).type_and_num;
}
It has to be just 'return key', but I'm not sure what the hashmap code is doing.

AFAICT the code is just trying to generate a value for the hashmap to hash on?
Why not just use (type << 16 | num) instead of 'trying to be clever' with a union?

	David


