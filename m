Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C44730E0EF
	for <linux-s390@vger.kernel.org>; Mon, 16 Feb 2026 14:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771251626; cv=none; b=jId6otOmPf8m4pAbHbhEEdLl3ovQ2wms12GW96C97liRYGOqYJCGSpIOssHd/JHaY++vpyj4XQSS7AH2nQL21O5O1BZi87Tw7+n0o+0HuWUqMEjxkd6kLeUB21z+L9uT1OaiEmXWRoy15DZq6XbEL3O4UUREKl3PE1OUuWvLCQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771251626; c=relaxed/simple;
	bh=rPUTAnHPdeqX9YHPt/UQx4jCrkdrGUDL58HGWAC39Q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cx1dStrQDqe/qPXRrynmDiC4O6vyJXyST8hyxC3h/0iGH570ktR5sgXxh2V7XczWC5fDtHRml5lPuh/p8sT0XQUfcD3RfkRbaopoeY4NX70RsEvSqZP5wsghIupEXWGLl/yANSFOByG8nacwkwR6oD5h6d8hBL6cjdwWCtrS8FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s0NS95mP; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s0NS95mP"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-436234ef0f0so2212008f8f.1
        for <linux-s390@vger.kernel.org>; Mon, 16 Feb 2026 06:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771251622; x=1771856422; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JI0abDjoXH12yXpjgx00HS4Kr5u5a9GKP4jRb96jhT4=;
        b=s0NS95mPk0hV08v2qWqPlU6zLV3hQRGMEXIql3e3d7OTHRjY6EvdgnuhfJcKg/8ppE
         xAg8utL6i//oaKeJDbRVpJZaiClHAxSG91A3s0VkCylfz1wQ7Vk6DZZoDoem7WVLmDdh
         Z+8gjUsGIDvViyoTHiJlRX7rDVET5H1QBZZZxF7lbDmwIEuMqTEHxC+M0a9fg1MvDX+R
         Ub0sFYGG8AzrU94PpnBznRi2ia1sj+bro9Id6gVnCBTCh9XV+9WPW5eM8cQHTCDajEhc
         uACT8tZioEZheor02puVBCRiM3XWqnbudhWX9wml/Kn5NfmiaYm8+FDTijPX8HppdyMv
         LtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771251622; x=1771856422;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JI0abDjoXH12yXpjgx00HS4Kr5u5a9GKP4jRb96jhT4=;
        b=VBFUFPHIr773axDO5tcXxKd5RYzy2XaY9pmcw+hDmsO/H19lNL1y8vEOWoTDEgd7Tp
         790p27TwIN3GTH4/jxcMVvMYip+HtcDd04aRHv47zXGrfWTvjRVzYBZwckUjHwoxiEb6
         dSThJF7aaNmOIOi8Ok++gzxsMswrZC+j4u4ltSfaSDgarZbgteRhgYZpRaygBD8zgQwZ
         JsZpWBsjaqYe+qMao/qOu9B2lru1XtWMvmO5Rd3KvAg10v47RC+loviiI2xQBG9CxDIt
         aoQZVswxZ3+PiqCcQ5ZX3Y3YhmOk9bJ69Or3WNGT6/C4GHKDct0QKV2C2/mBRXuze/PD
         SLJw==
X-Forwarded-Encrypted: i=1; AJvYcCXNN81KlJysmkaMzXJ46IOHEYmQcr7o2gMLhef0lZxZ8ok5qTjo6VhoqL3DpT81iRkwg/kVFsF+k6rR@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyz6aM5sbHrIojR2kx58adUJHhyvL614xh46+coaDTff3jETJH
	kw411L9jsu3kDVltzLk2La++K7tSlBa1T3gPiiJN+4elx/vcM0P4stWo7vpeY9cmTxA=
X-Gm-Gg: AZuq6aK3gn5io4Em5chF+UG71AKlhRXxT9EswZpm5NjgTx9BzzGBP6EqmkR4lH18w8t
	al/FFTCy3FEqYt/r3ahiRJ87WMZHXDgk0IPdL15SUWtbULXBurduJQ0CFi+OtH5BWukuy0AwA2N
	9uPP/NSe2smaTUBYDoRSw59yetHtZ6+26fLD4+mBfkpHfi9rKpE3vFKy5sQwjCt1I8TSdOigXN1
	QKewJWkWLm6IZHRENUwF7tLzIj8UgSyoLyv4cFQqRC2yrd2NjmOgXtP9v1U46tBgfkTzorXelCS
	HmOl6HrKdkzX+DdxTR9mn8v8GjH1ljXflVazBZU9G7HWI+HYzID2/LdE7IEmITFGPXRMOTbPzS/
	F/E0x9u3i58INYD66esqPi1/jCxfiVj7c7EorHbBaAgZUr4VI493Bdy+WMJZou3AIq3cUEt4nwe
	K3D7wjeoDZsNgZ6VmMRhQDjnxDWP1H
X-Received: by 2002:a05:600c:529b:b0:47d:92bb:2723 with SMTP id 5b1f17b1804b1-483739fc4d0mr202466985e9.3.1771251621937;
        Mon, 16 Feb 2026 06:20:21 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48387ab1974sm76075795e9.3.2026.02.16.06.20.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 06:20:21 -0800 (PST)
Message-ID: <4565f331-6dd6-4be9-8e6c-e6b6a4a628b3@linaro.org>
Date: Mon, 16 Feb 2026 14:20:20 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 linux-next] perf parse-events: Fix big-endian
 'overwrite' by writing correct union member
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
 hca@linux.ibm.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
 acme@kernel.org, namhyung@kernel.org, irogers@google.com
References: <20260216131050.2581963-1-tmricht@linux.ibm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260216131050.2581963-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/02/2026 1:10 pm, Thomas Richter wrote:
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
> string and value. add_config_term() now creates a complete node element
> of type evsel_config_term and handles all evsel_config_term::val union
> members.
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
>   tools/perf/util/parse-events.c | 96 ++++++++++++++++++++++++++++------
>   1 file changed, 80 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index b9efb296bba5..bd48435a3e13 100644
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
> @@ -1128,8 +1128,78 @@ static struct evsel_config_term *add_config_term(enum evsel_term_type type,
>   	INIT_LIST_HEAD(&t->list);
>   	t->type = type;
>   	t->weak	= weak;
> +
> +	if (str) {
> +		t->val.str = strdup(str);
> +		if (!t->val.str) {
> +			zfree(&t);
> +			return NULL;
> +		}
> +		t->free_str = true;
> +	} else {
> +		t->val.val = val;
> +	}

You could drop this if/else and do each thing in the switch, then 
there's no need for the comments saying it's already done e.g.:

   case EVSEL__CONFIG_TERM_PERIOD
   case EVSEL__CONFIG_TERM_FREQ:
   case EVSEL__CONFIG_TERM_STACK_USER:
       t->val.val = val;
       break;

   case EVSEL__CONFIG_TERM_DRV_CFG:
   case EVSEL__CONFIG_TERM_RATIO_TO_PREV:
   case EVSEL__CONFIG_TERM_AUX_ACTION:
       assert(str);
       t->val.str = strdup(str);
       if (!t->val.str) {
          zfree(&t);
          return NULL;
       }
       t->free_str = true;
       break;

> +
> +	switch (type) {
> +	case EVSEL__CONFIG_TERM_PERIOD:
> +		/* Union member type match, assignment above */
> +		break;
> +	case EVSEL__CONFIG_TERM_FREQ:
> +		/* Union member type match, assignment above */
> +		break;
> +	case EVSEL__CONFIG_TERM_TIME:
> +		t->val.time = val;
> +		break;
> +	case EVSEL__CONFIG_TERM_STACK_USER:
> +		/* Union member type match, assignment above */
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
> +		/* Type is string, assigned above */
> +		break;
> +	case EVSEL__CONFIG_TERM_BRANCH:
> +		/* Type is string, assigned above */

Minor nit: You can collapse all the ones with the same comments, same as 
you have done for EVSEL__CONFIG_TERM_USR_CHG_CONFIG*

> +		break;
> +	case EVSEL__CONFIG_TERM_DRV_CFG:
> +		/* Type is string, assigned above */
> +		break;
> +	case EVSEL__CONFIG_TERM_RATIO_TO_PREV:
> +		/* Type is string, assigned above */
> +		break;
> +	case EVSEL__CONFIG_TERM_AUX_ACTION:
> +		/* Type is string, assigned above */
> +		break;
> +	case EVSEL__CONFIG_TERM_USR_CHG_CONFIG:
> +	case EVSEL__CONFIG_TERM_USR_CHG_CONFIG1:
> +	case EVSEL__CONFIG_TERM_USR_CHG_CONFIG2:
> +	case EVSEL__CONFIG_TERM_USR_CHG_CONFIG3:
> +	case EVSEL__CONFIG_TERM_USR_CHG_CONFIG4:
> +		/* Union member type match, assignment above */
> +		break;
> +	default:

I get this with clang:

util/parse-events.c:1200:10: error: label at end of compound statement: 
expected statement
         default:

Other than that it looks correct.

> +	}
> +
>   	list_add_tail(&t->list, head_terms);
> -
>   	return t;
>   }
>   
> @@ -1234,20 +1304,15 @@ static int get_config_terms(const struct parse_events_terms *head_config,
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
> @@ -1277,10 +1342,9 @@ static int add_cfg_chg(const struct perf_pmu *pmu,
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

