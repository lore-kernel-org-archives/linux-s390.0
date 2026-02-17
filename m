Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40CB3271E4
	for <linux-s390@vger.kernel.org>; Tue, 17 Feb 2026 10:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771324855; cv=none; b=AP7/zZ/arkpWcO+KkZmatAb44WIX+GrqA5kTtv7OCVRqFoLhggAYlcWkTWMzJWhW9HxaiBsQgbR0JN/xHPQ54bhLfY8u3sGDwPiAoU/J3w4ibFh6b5LqYQadAeu2IXux8jcXZad6YmcvchZX4toaqVr62pJZQwPxogyLPzEls9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771324855; c=relaxed/simple;
	bh=n07Xnc69x7O23LpLRZxtS2yk+qtvvObSQsLjDfgqsjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V5RHZzw7QDfmPpUxSwabWXGxv8LVxYYbJMJlmKnbVHDKvHskgGdvZumD5H2NOc6kCo/ic3ETNnWZQmZolhifLlYSvPkBUYkXfWV7WtwZ/R3IYEdxacjVdx8AkYvxQ5QRm0kRR3G+WcA/JZ4M7EIfJeoi0B5eb2w4LWkufxLlxz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c4btM4FA; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c4btM4FA"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48373a4bca3so21052025e9.0
        for <linux-s390@vger.kernel.org>; Tue, 17 Feb 2026 02:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771324851; x=1771929651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2PhxNjCXpdi4s6/r1iBSfRnqmVR2UnYY0FetbgzR3vg=;
        b=c4btM4FAdPh5jy+4WTlHjo4EiB1eont/c65NY9U+WTVZvYDl5ONULd5TPYYp6q+4UL
         YYqujJcwcTG3GRTbtttzYdx9NrnA0xXbWouKMVLDqcsYb9SMSUZiMl/wgQmlOFg6ugwn
         Ei9Fqch+eDTfpYwoDIryqsKfKjhwWiEVahpcVJA/lOhf4Xopls4p6XewyWi8gg7LuIud
         vJjXPo2mmsZHxGfqsFbLbN7tKsFMOUyWtk2OXdwN83jIZYqDw+280PGWrg1YjljGAM7N
         euJ9wGJCQV/qfCExOdRTUSGVFEP5+TQ4iLynrgorFIsV54/4vKvMK5ziDCceoZaivWYq
         2aLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771324851; x=1771929651;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2PhxNjCXpdi4s6/r1iBSfRnqmVR2UnYY0FetbgzR3vg=;
        b=EsMZAV8bEfuFHHynVvG167jtvQf1RXwCIbN6+pYToDEI040fSw/F1tTW/rXunwbsgL
         +VFswWb7S9ASjlnNtD8g6tfiGq0qhmGudcA/e0pqb5Kr+6hFOjM/wqdpg63ZswF06j17
         AGjhGxBWK8qfmipvDEvODsgrycPMDv/gjD/0QqX2+pnrx0C6+qweQaLoW0P9d+zDzrb0
         daHs5Rl7faTSjjFBi9/SV+8RRCXQaiCp22r2Xl1n1RTrSJ/JlBTpEeZB3mnqIgE3mOOw
         EVt58a8+5Ng52hwMrzuAzPP1DuOSVCfAZ0Qhjy7oJuUe82mKEi8/3t3btCmTDeJ0YzKs
         40GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWFt2ox3DtugH4GFE1g0O/8nz0qacWOQyivsyG/ywNnaa7DEFH8Y0W6qHQfPjTx6rQ47b+12Zu7YfZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwaNEcvmRYXL42VoBtdMrDRA6cwIWDoRVaqFoAddjk18iK9Ulb7
	SDU+3R5h9apqBhFbQLxVqCDvTcxA+Y6OVVC3V8zLqGWPh1NjEiu7Bjtws+MxaDhu8d4=
X-Gm-Gg: AZuq6aJWCPH97uK2Vz05wkD7bgKqkuQ4bCD/YfwUBYdPYvbQCkTI5IIqiGuOW4ixYvb
	mSdu347wP1gmDPNm9UpW3qJX2wLtO2jZUmLJQQ8dYUtW7v3Xb3EM8oEfs3+uS+rInXhs5Y9ch78
	gBuXoCS+WHlPTS+/d9YlH6+kuqhGQ1T6R4QKGuEfMhs9HV9lMHyMDEhOJes9Un1XsMWCK7k9s/y
	pYTcsQerzjDLpeyoyFyTaFPUgg9hQ0iSTo5L33z+zgS32SwpmKbyXDd1p3yDsfXQJgSnm//S9se
	JoixgDv6QBd5i1tjRQAwMyKF7we/2WJiDDcvkl52Jwqu8rDyQEj1xvtPuY8igrss7WeZzSyZ75m
	QcrY48W+VRBietAKIGgC32mmt2kKPYvpyVpUjJyREpKbgqt80a4W38LcaeXiEUARkeGLDH8kRJh
	tlRjm3q4QmQTvptl7vr/DEnf3zojBg
X-Received: by 2002:a05:600c:548e:b0:480:6dff:e786 with SMTP id 5b1f17b1804b1-48379bff816mr173842505e9.37.1771324851131;
        Tue, 17 Feb 2026 02:40:51 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835dd0deeasm462623585e9.12.2026.02.17.02.40.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 02:40:50 -0800 (PST)
Message-ID: <f1bc86c5-45aa-4cce-b344-7969c16288fb@linaro.org>
Date: Tue, 17 Feb 2026 10:40:49 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 linux-next] perf parse-events: Fix big-endian
 'overwrite' by writing correct union member
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
 hca@linux.ibm.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
 acme@kernel.org, namhyung@kernel.org, irogers@google.com
References: <20260217081344.654399-1-tmricht@linux.ibm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260217081344.654399-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/02/2026 8:13 am, Thomas Richter wrote:
> The "Read backward ring buffer" test crashes on big-endian (e.g. s390x)
> due to a NULL dereference when the backward mmap path isn't enabled.
> 
> Reproducer:
>    # ./perf test -F 'Read backward ring buffer'
>    Segmentation fault (core dumped)
>    # uname -m
>    s390x
>    #
> 
> Root cause:
> get_config_terms() stores into evsel_config_term::val.val (u64) while later
> code reads boolean fields such as evsel_config_term::val.overwrite.
> On big-endian the 1-byte boolean is left-aligned, so writing
> evsel_config_term::val.val = 1 is read back as
> evsel_config_term::val.overwrite = 0,
> leaving backward mmap disabled and a NULL map being used.
> 
> Store values in the union member that matches the term type, e.g.:
>    /* for OVERWRITE */
>    new_term->val.overwrite = 1;  /* not new_term->val.val = 1 */
> to fix this. Improve add_config_term() and add two more parameters for
> string and value. Function add_config_term() now creates a complete node
> element of type evsel_config_term and handles all evsel_config_term::val
> union members.
> 
> Impact:
> Enables backward mmap on big-endian and prevents the crash.
> No change on little-endian.
> 
> Output after:
>   # ./perf test -Fv 44
>   --- start ---
>   Using CPUID IBM,9175,705,ME1,3.8,002f
>   mmap size 1052672B
>   mmap size 8192B
>   ---- end ----
>   44: Read backward ring buffer                         : Ok
>   #
> 
> Fixes: 159ca97cd97c ("perf parse-events: Refactor get_config_terms() to remove macros")
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Reviewed-by: Jan Polensky <japo@linux.ibm.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/util/parse-events.c | 78 +++++++++++++++++++++++++++-------
>   1 file changed, 62 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index b9efb296bba5..0a87987d8c6f 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1117,7 +1117,7 @@ static int config_attr(struct perf_event_attr *attr,
>   
>   static struct evsel_config_term *add_config_term(enum evsel_term_type type,
>   						 struct list_head *head_terms,
> -						 bool weak)
> +						 bool weak, char *str, u64 val)
>   {
>   	struct evsel_config_term *t;
>   
> @@ -1128,8 +1128,60 @@ static struct evsel_config_term *add_config_term(enum evsel_term_type type,
>   	INIT_LIST_HEAD(&t->list);
>   	t->type = type;
>   	t->weak	= weak;
> +
> +	switch (type) {
> +	case EVSEL__CONFIG_TERM_PERIOD:
> +	case EVSEL__CONFIG_TERM_FREQ:
> +	case EVSEL__CONFIG_TERM_STACK_USER:
> +	case EVSEL__CONFIG_TERM_USR_CHG_CONFIG:
> +	case EVSEL__CONFIG_TERM_USR_CHG_CONFIG1:
> +	case EVSEL__CONFIG_TERM_USR_CHG_CONFIG2:
> +	case EVSEL__CONFIG_TERM_USR_CHG_CONFIG3:
> +	case EVSEL__CONFIG_TERM_USR_CHG_CONFIG4:
> +		t->val.val = val;
> +		break;
> +	case EVSEL__CONFIG_TERM_TIME:
> +		t->val.time = val;
> +		break;
> +	case EVSEL__CONFIG_TERM_INHERIT:
> +		t->val.inherit = val;
> +		break;
> +	case EVSEL__CONFIG_TERM_OVERWRITE:
> +		t->val.overwrite = val;
> +		break;
> +	case EVSEL__CONFIG_TERM_MAX_STACK:
> +		t->val.max_stack = val;
> +		break;
> +	case EVSEL__CONFIG_TERM_MAX_EVENTS:
> +		t->val.max_events = val;
> +		break;
> +	case EVSEL__CONFIG_TERM_PERCORE:
> +		t->val.percore = val;
> +		break;
> +	case EVSEL__CONFIG_TERM_AUX_OUTPUT:
> +		t->val.aux_output = val;
> +		break;
> +	case EVSEL__CONFIG_TERM_AUX_SAMPLE_SIZE:
> +		t->val.aux_sample_size = val;
> +		break;
> +	case EVSEL__CONFIG_TERM_CALLGRAPH:
> +	case EVSEL__CONFIG_TERM_BRANCH:
> +	case EVSEL__CONFIG_TERM_DRV_CFG:
> +	case EVSEL__CONFIG_TERM_RATIO_TO_PREV:
> +	case EVSEL__CONFIG_TERM_AUX_ACTION:
> +		if (str) {
> +			t->val.str = strdup(str);
> +			if (!t->val.str) {
> +				zfree(&t);
> +				return NULL;
> +			}
> +			t->free_str = true;
> +		}
> +		break;
> +	default:
> +	}

Hi Thomas,

This still has nothing for the default label which clang doesn't like:

util/parse-events.c:1182:10: error: label at end of compound statement: 
expected statement
         default:

And then fixing that by replacing all the "t->val.val = val;" cases with 
just "default:" gives a new error. "val" in get_config_terms() is 
uninitialized (although unused, but the compiler doesn't know that):

util/parse-events.c:1269:8: error: variable 'val' is used uninitialized 
whenever switch case is taken [-Werror,-Wsometimes-uninitialized]
                 case PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV:
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
util/parse-events.c:1296:42: note: uninitialized use occurs here
                                            str_type ? term->val.str : 
NULL, val);


> +
>   	list_add_tail(&t->list, head_terms);
> -
>   	return t;
>   }
>   
> @@ -1234,20 +1286,15 @@ static int get_config_terms(const struct parse_events_terms *head_config,
>   			continue;
>   		}
>   
> -		new_term = add_config_term(new_type, head_terms, term->weak);
> +		/*
> +		 * Note: Members evsel_config_term::val and
> +		 * parse_events_term::val are unions and endianness needs
> +		 * to be taken into account when changing such union members.
> +		 */
> +		new_term = add_config_term(new_type, head_terms, term->weak,
> +					   str_type ? term->val.str : NULL, val);
>   		if (!new_term)
>   			return -ENOMEM;
> -
> -		if (str_type) {
> -			new_term->val.str = strdup(term->val.str);
> -			if (!new_term->val.str) {
> -				zfree(&new_term);
> -				return -ENOMEM;
> -			}
> -			new_term->free_str = true;
> -		} else {
> -			new_term->val.val = val;
> -		}
>   	}
>   	return 0;
>   }
> @@ -1277,10 +1324,9 @@ static int add_cfg_chg(const struct perf_pmu *pmu,
>   	if (bits) {
>   		struct evsel_config_term *new_term;
>   
> -		new_term = add_config_term(new_term_type, head_terms, false);
> +		new_term = add_config_term(new_term_type, head_terms, false, NULL, bits);
>   		if (!new_term)
>   			return -ENOMEM;
> -		new_term->val.cfg_chg = bits;
>   	}
>   
>   	return 0;

