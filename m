Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE381332EB0
	for <linux-s390@vger.kernel.org>; Tue, 17 Feb 2026 14:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771337399; cv=none; b=ORa48/I8kRBPuZ6e1GLCZMHbpgpajzprNiwCa0KcanaumA1spwcEtq6sAKdrcw5S6fufc/mNnRhLVVIQjzFMfe/gi8HiekruUSPU9YFkE0TIglwyf1o2fCm/XyUYXXYGC21j65U7XiBmFFQDUJK25tfOeoS70uW6ZWUUMFj3beg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771337399; c=relaxed/simple;
	bh=/jyvLfP/QBMizw9HkoY82Vlo6F/zdu08l7YEVLT9TK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M4lGYhJEl7MnbaIA1D1VQv7iENiu7E13ZYTc7LgvOqSiF4p7u94DxyisQFW7BRWXf3ZCNdCTJAwiEw3AOM/WIzIpyCCIy+uR/9diIKfE5ib65XQzDwPUrccNNRsBYuSiiOkY3gJFq45U8THJuHzOPQXTpnN8FIl0V3C6bV2xMao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yqo/n1+t; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yqo/n1+t"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-65a36c8bcabso1331584a12.1
        for <linux-s390@vger.kernel.org>; Tue, 17 Feb 2026 06:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771337396; x=1771942196; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ev0baLIks11CklQ1arlG40s9hBdfba5EjCldYEhDhHc=;
        b=yqo/n1+tdHsNpJhtkZz8EviYOVCUFUMoI1egstfQl2qaoIQglcQq1+JKyNEs5bxIPA
         +fs3iiqa1FhVyVcCt0TXsx7BQBshoM5Oaq4CC4BXT4s9+BQk+QRx785G+YHU2dKet8qW
         aNoyaN0DD4lBQHfTuhpTfdUsT28PU5GtHloqbv8LJsb0qVdkmTai4m5NgcRrUBVWLw3z
         /HO7tXDv/szBm5iaEfgaoSlG3+8SotEaWzd201GGzqaLzBMVTHhNeHuvUJXKexNESfHA
         BqAeuis5R2P0uY0lCK2VZq8SwOdCobzgEGdco665D0NJJOnx9dvI7bd+akNrd4i0JMcn
         slyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771337396; x=1771942196;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ev0baLIks11CklQ1arlG40s9hBdfba5EjCldYEhDhHc=;
        b=e0vXBX/ogvC+HUPHBRWYXPnQfy+nLMgC0uKIynCYg5zF7z/O8vauO/ZQox6HD5WAym
         eEuWQH7cFHU/pU/H5OUausiVtdl7PWsPA3ow3t3vjkWwIswOuwkp1CJ5lc/zLBL4G36G
         Q4xmS00+pr5B5NARGmNeZYdK3izLA4mtC6EtMscEMv6MTqtolX7jJZGtCVmJSHrI8W/5
         fLLl5BqMKytm6whKM3n0sJ+KkKK90XAN9hrFrogYlUe0x+AqKPV8tGsAk+i0S5g4RE6f
         I2jpLX93CRAYuAolh8HhaCHE7LwX7xY7u8FULjgPLFFZD6c+jORcJshScANX/D60RYr8
         88Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUfmZnMFaSJFz5mHyf/zpeaSTN/R540ej5LtAfe91iUk0xzJne/0dfg0z+MEHTf+NmaQWaxPIcO4x4M@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2FufHjbyNk8JjBVtKSpV5Op42X/NygtpJMOt4QLrTN+dOzEWd
	Wj97UVNOYP2KIES7OEeb9yObGOLZhWrkn6MOoZF4cVtP31O4OEH3SJ2wNWZ1gigkBlo=
X-Gm-Gg: AZuq6aInKTO+EQ8IEJevlYpm0GoBw/1kiae05kvdgqENgYRwiU4kJ0rdMJR9doRlypl
	6JdaNKzvdRIipCP22fftrICcWwZzQ1bWVj9jqkOaFvfZAkdGCveLmeZN12U4MESvIry+ETGf07w
	F/i1MV31e6dx+TlN0GkcEsiJj5PPdn63oeRxtgkKplhlRDZEs8W5tH4p15WuNB1Ml2GsA3ghq7W
	052OLsK1UsXn0FfALLkoz8U616GCgv+iFrzVmakzDuKUuWYg71nmxFjvfDzE1xo65SqyeaZmjY+
	SuTP8sIyHtFxm+32DuRRNmqn0Gbw3o2244Knl4fu8VC7USev/t+oj6iMLsxpT/61nWl8ftvmbeT
	GO3QQrpweejkaZnQiHD4xbFSQBxFWBQXMseCxCMCYao/fcAdyy5ASuKZQ6q+13B3JFDd6BquMwy
	pRn8stKwFw7JiKrA03cZS1XYwIOnptAQP+2qGatLY=
X-Received: by 2002:a17:907:7fa5:b0:b87:1d71:f44d with SMTP id a640c23a62f3a-b8facca14bemr830289966b.11.1771337395929;
        Tue, 17 Feb 2026 06:09:55 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65bad3e39ebsm2421950a12.18.2026.02.17.06.09.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 06:09:55 -0800 (PST)
Message-ID: <9a16463e-c2d9-4ab9-bd1a-a9c6e7981412@linaro.org>
Date: Tue, 17 Feb 2026 14:09:53 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 linux-next] perf parse-events: Fix big-endian
 'overwrite' by writing correct union member
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
 hca@linux.ibm.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
 acme@kernel.org, namhyung@kernel.org, irogers@google.com
References: <20260217131456.4085419-1-tmricht@linux.ibm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260217131456.4085419-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/02/2026 1:14 pm, Thomas Richter wrote:
> v1 -> v2: Add comments from James Clark and Ian Rogers
> v2 -> v3: Improve switch statement in add_config_term()
> v3 -> v4: Fix clang warnings
> 
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
>   tools/perf/util/parse-events.c | 82 +++++++++++++++++++++++++++-------
>   1 file changed, 65 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index b9efb296bba5..7b4629625b1e 100644
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
> @@ -1128,8 +1128,62 @@ static struct evsel_config_term *add_config_term(enum evsel_term_type type,
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
> +		t->val.val = val;
> +		break;
> +	}
> +
>   	list_add_tail(&t->list, head_terms);
> -
>   	return t;
>   }
>   
> @@ -1142,7 +1196,7 @@ static int get_config_terms(const struct parse_events_terms *head_config,
>   		struct evsel_config_term *new_term;
>   		enum evsel_term_type new_type;
>   		bool str_type = false;
> -		u64 val;
> +		u64 val = 0;
>   
>   		switch (term->type_term) {
>   		case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
> @@ -1234,20 +1288,15 @@ static int get_config_terms(const struct parse_events_terms *head_config,
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
> @@ -1277,10 +1326,9 @@ static int add_cfg_chg(const struct perf_pmu *pmu,
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

Reviewed-by: James Clark <james.clark@linaro.org>

