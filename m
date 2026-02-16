Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B6A253932
	for <linux-s390@vger.kernel.org>; Mon, 16 Feb 2026 11:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771240741; cv=none; b=KWQ39gkdy11y/ZOIvXUppp7oOEOvVhmcDg2axGIGfxh0pUC1q9+hE+hTjm6grlqcL33Uf0oD/67v5MU4nYQXYixaTtX2JpMtIUsLurlAPZ7r9lxf8ZsUP+WzvjzMal4/VofDHaAM1DcxI87pcobRkxY+WGfk+tQX5eWrRZFfdi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771240741; c=relaxed/simple;
	bh=PaZgIpamPhNVAi3HF1I8yncBr3MffQm3k/+p5MOwzLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JUIUteS121rqlV0kCZcRMRgyQgrVgthJsTIRyWOTHhB4lNVVRb3AQttUJCcmcXowJs1AUfcI+9PjztifwmFNvGRXp1fmAUOryBCN4/OJoRWHy/AMpBNdqnoQRfQpCcUb6VCxnQ/cgKUZbiXSE/oLB7V0eBtbbng9vEDy7HEYXvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DThxHIxS; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DThxHIxS"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43945763558so732169f8f.3
        for <linux-s390@vger.kernel.org>; Mon, 16 Feb 2026 03:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771240738; x=1771845538; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=17HFvC407rHFCRdTCYg/CjcUmCQt5v/OQzlYZuxdpL0=;
        b=DThxHIxSIF3WKiHj/QVRaRQtKPJaJt2fXXgYq/4oaqgV4uEexz9i2xUY0KDo0vaxm+
         /b8eznsxvTlsx3zpp8oOFJwpAjJfLEGDjurxjiDJwx9/exzFIT65Jn/aLely6iWtKOwk
         2N2M+/p/KD1ppR0MhLozPkiaeOjq6ymcgDlS5gn5Zihuy17XBQFlD7Sf1ZLC3uofbjH9
         KPKybQH6difAdpCDWWojrgGIhyUyQqbjqB4arplMNy8bdwTUSOfiVZ1llcIsbMBr3ZuR
         Jfuc2Q/UzJiIWbw8I5wR8ZhYs7JAqmu6qF9ytTNYuSbwGCf+vzCzFsbQGWYXzIXGMosz
         s4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771240738; x=1771845538;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=17HFvC407rHFCRdTCYg/CjcUmCQt5v/OQzlYZuxdpL0=;
        b=oI2HF7vvMx45zA/mAX17Mc1GaBbjRe662yh6YJNLumuVyGDk90Lq6eg/61pvZsCORA
         BRcnbeJxY5yVTphj8vtNcuwDvlmDw/scDcl+1kUFGXotAUBBaR9JYgCn+VVKMPrGjq2a
         RQmv1EsLTtoEDSNdIS0jcpVR3QRv6o/ynXuogPAvHdxvOxyAtdjib8SwVN4rUxYudDSi
         I7KUpv1zYZZvoWnp7Rl1nXlXyen2j0ddYxXQERFsK11nMQTrvKyYCcDjVE5CiqDTafh9
         jx3s8qt0le+Y8GQUvhtZNZqHTQ4wSSCsbyPvp5lN/bnuLeJYPXyewXVgH4sh3PxbMr2S
         g/HQ==
X-Forwarded-Encrypted: i=1; AJvYcCWc+RZauEdukrs/pS1BzaAELyHLaPcERQwqzlkgu7aSBF9PjT3jFM4crwXMrarPA0kfwVSpccWJSPdZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi36E4Gqx9r6BkEpE8CAdGVebol7i4bSZr37lpkqI2/z3qZ9xa
	y0UehX7TNDh61afyTrsn6vMz02uf4Rvo7PWdnVYePQU9PsCTuxedLOkXeFYtqN4LzlI=
X-Gm-Gg: AZuq6aJ5bfkdUQYmsd/PdX+vP0DVCewvnhKuTjWz6KeFZrzlVHcKo4OH0YMDiBPn/iX
	n6+sd/VmXZIWR7I9xrYJXTWerQtGAPkJEIBh6YRw0eqkSbUN4MKBZP17hHCP6xRUlVPpGRPJdFW
	44E2YSkDj2kl0BvcVPSfJ0+IGq36rDRiiyfga1WGcbTZZ3nnRgLCDUlzqjUzVmUwdQJV/sC23wl
	UnyHqiF629MQM+yKzOYMoDq5tN8/X7vvSFckgp81i/l76nYujFLYjCjNpEXL/A0avEU/MxfTYuO
	85q9EZg1fgkQ1w4yXtWQqyR0IIynqUuLrtlrMetO32nhjcJVLtr/9Y6nwT1zJ5sNETaAbhNyGGm
	rKg37u/Uq1KTglaNiLyiJNB6e2RAne5ZqB43CnPhPlJKoHj7FYOBCaa4VinVBqfDeGXLhoyNDZE
	cTyMQNlPBv5meiCi8pi0dgek4sRcf5XwZvSFOzwRA=
X-Received: by 2002:a05:6000:178b:b0:435:9690:f056 with SMTP id ffacd0b85a97d-43796aefb76mr19098979f8f.35.1771240737133;
        Mon, 16 Feb 2026 03:18:57 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abc8b1sm27555334f8f.23.2026.02.16.03.18.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 03:18:56 -0800 (PST)
Message-ID: <2109e3bf-8c33-49cf-aa52-e81e7c5ef87b@linaro.org>
Date: Mon, 16 Feb 2026 11:18:55 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next] perf parse-events: Fix big-endian 'overwrite'
 by writing correct union member
To: Thomas Richter <tmricht@linux.ibm.com>, Ian Rogers <irogers@google.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
 agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
 hca@linux.ibm.com, japo@linux.ibm.com
References: <20260212125315.777356-1-tmricht@linux.ibm.com>
 <CAP-5=fWxHfGZaLyrvzuQF83K1g=LaFC4uRvg3HjM0=W9ts_yxQ@mail.gmail.com>
 <30f598eb-4c9e-49da-a643-118b462b8b77@linux.ibm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <30f598eb-4c9e-49da-a643-118b462b8b77@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16/02/2026 10:04 am, Thomas Richter wrote:
> On 2/12/26 19:17, Ian Rogers wrote:
>> On Thu, Feb 12, 2026 at 4:53 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
>>>
>>> The "Read backward ring buffer" test crashes on big-endian (e.g. s390x)
>>> due to a NULL dereference when the backward mmap path isn't enabled.
>>>
>>> Reproducer:
>>>    # ./perf test -F 'Read backward ring buffer'
>>>    Segmentation fault (core dumped)
>>>    # uname -m
>>>    s390x
>>>    #
>>>
>>> Root cause:
>>> get_config_terms() stores into evsel_config_term::val.val (u64) while later
>>> code reads boolean fields such as evsel_config_term::val.overwrite.
>>> On big-endian the 1-byte boolean is left-aligned, so writing
>>> evsel_config_term::val.val = 1 is read back as
>>> evsel_config_term::val.overwrite = 0,
>>> leaving backward mmap disabled and a NULL map being used.
>>>
>>> Store values in the union member that matches the term type, e.g.:
>>>    /* for OVERWRITE */
>>>    new_term->val.overwrite = 1;  /* not new_term->val.val = 1 */
>>> to fix this.
>>>
>>> Impact:
>>> Enables backward mmap on big-endian and prevents the crash.
>>> No change on little-endian.
>>>
>>> Output after:
>>>   # ./perf test -Fv 44
>>>   --- start ---
>>>   Using CPUID IBM,9175,705,ME1,3.8,002f
>>>   mmap size 1052672B
>>>   mmap size 8192B
>>>   ---- end ----
>>>   44: Read backward ring buffer                         : Ok
>>>   #
>>>
>>> Fixes: 159ca97cd97c ("perf parse-events: Refactor get_config_terms() to remove macros")
>>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>>> Reviewed-by: Jan Polensky <japo@linux.ibm.com>
>>> Cc: James Clark <james.clark@linaro.org>
>>> Cc: Ian Rogers <irogers@google.com>
>>> ---
>>>   tools/perf/util/parse-events.c | 49 +++++++++++++++++++++++++++++++++-
>>>   1 file changed, 48 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
>>> index d4647ded340f..12fe5392c832 100644
>>> --- a/tools/perf/util/parse-events.c
>>> +++ b/tools/perf/util/parse-events.c
>>> @@ -1250,7 +1250,54 @@ static int get_config_terms(const struct parse_events_terms *head_config,
>>>                          }
>>>                          new_term->free_str = true;
>>>                  } else {
>>> -                       new_term->val.val = val;
>>> +                       switch (new_type) {
>>> +                       case EVSEL__CONFIG_TERM_PERIOD:
>>> +                               new_term->val.period = val;
>>> +                               break;
>>
>> Thanks Thomas and sorry big endian got broken! I'm a little confused
>> here as period is a u64 so I think this one can be a default case.
>>
>>> +                       case EVSEL__CONFIG_TERM_FREQ:
>>> +                               new_term->val.freq = val;
>>> +                               break;
>>
>> Also a u64.
>>
>>> +                       case EVSEL__CONFIG_TERM_TIME:
>>> +                               new_term->val.time = val;
>>> +                               break;
>>> +                       case EVSEL__CONFIG_TERM_STACK_USER:
>>> +                               new_term->val.stack_user = val;
>>> +                               break;
>>
>> Also a u64.
> 
> Agreed, I really don't mind. However should that type be changed (yep extremely unlikely)
> we run into the same issue again.
>>
>>> +                       case EVSEL__CONFIG_TERM_INHERIT:
>>> +                               new_term->val.inherit = val;
>>> +                               break;
>>> +                       case EVSEL__CONFIG_TERM_OVERWRITE:
>>> +                               new_term->val.overwrite = val;
>>> +                               break;
>>> +                       case EVSEL__CONFIG_TERM_MAX_STACK:
>>> +                               new_term->val.max_stack = val;
>>> +                               break;
>>> +                       case EVSEL__CONFIG_TERM_MAX_EVENTS:
>>> +                               new_term->val.max_events = val;
>>> +                               break;
>>> +                       case EVSEL__CONFIG_TERM_PERCORE:
>>> +                               new_term->val.percore = val;
>>> +                               break;
>>> +                       case EVSEL__CONFIG_TERM_AUX_OUTPUT:
>>> +                               new_term->val.aux_output = val;
>>> +                               break;
>>> +                       case EVSEL__CONFIG_TERM_AUX_SAMPLE_SIZE:
>>> +                               new_term->val.aux_sample_size = val;
>>> +                               break;
>>> +                       case EVSEL__CONFIG_TERM_CALLGRAPH:
>>> +                       case EVSEL__CONFIG_TERM_DRV_CFG:
>>> +                       case EVSEL__CONFIG_TERM_BRANCH:
>>> +                       case EVSEL__CONFIG_TERM_AUX_ACTION:
>>> +                       case EVSEL__CONFIG_TERM_USR_CHG_CONFIG:
>>> +                       case EVSEL__CONFIG_TERM_USR_CHG_CONFIG1:
>>> +                       case EVSEL__CONFIG_TERM_USR_CHG_CONFIG2:
>>> +                       case EVSEL__CONFIG_TERM_USR_CHG_CONFIG3:
>>> +                       case EVSEL__CONFIG_TERM_USR_CHG_CONFIG4:
>>> +                       case EVSEL__CONFIG_TERM_RATIO_TO_PREV:
>>
>> I think these cases are all assigning a str so would using str rather
>> than val be cleaner?
>>
>> The change looks good but it is a little inconsistent that the default
>> copying is done for str values but not for u64. It would kind of be
>> nice to remove the default copying so that if a new config term is
>> added the switch will fail to compile due to a missing case statement.
>> Then we can do the right copy for big endian. Given we've broken
>> big-endian here we should probably add a comment.
>>
>> Thanks,
>> Ian
> 
> Yep I will send v2 later today and hopefully address your remarks completely.
> 

Oops sorry about the breakage. You could remove the val member entirely 
now and set them all individually. I only added it to avoid a second 
switch statement after creating the new entry. But if we have to add the 
switch back in again and list out each item we might as well go back to 
how it was before and assign each one individually.

Or a nuclear option could be to just have a single u64 numeric member 
and a string one and not try to rename them and change the types so 
much. Ironically half of the usages of the bools look like this:

  attr->aux_output = term->val.aux_output ? 1 : 0;

Almost makes all the shuffling around and renaming seem a bit pointless 
in the end.


>>
>> I> +                       default:
>>> +                               new_term->val.val = val;
>>> +                               break;
>>> +                       }
>>>                  }
>>>          }
>>>          return 0;
>>> --
>>> 2.53.0
>>>
> 
> Thanks
> 

