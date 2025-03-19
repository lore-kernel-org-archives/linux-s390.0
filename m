Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141C52135C3
	for <linux-s390@vger.kernel.org>; Wed, 19 Mar 2025 09:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742378300; cv=none; b=A7QyOmrjOSS3oFb/FteYxbbJgTSeHWneisdtbbEu/QnYsfy+QpFe3YBCDJMNIhPS9I1eNT721e9jz9qLW0iylUV7KO5ST3bvnvX1gfMxe8fUj8cxpOnb8uDV1aEE1vdZi0F8ed3EWSkLY4hQAeY+CnMkFcxjqLOeNKjrifUEjPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742378300; c=relaxed/simple;
	bh=USWnUdlqECdrR7Um+9d+S7qmu3tqiAL591URZ/mVzbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ffue61dyvQptNJ5CEQ+TRjHPhKR3O94Medomp65FJxp/8su4gpxmTkTWMGCgzB1zRgDhl+vCTmTOwt4dNmIO//UHy/6vo1L8I6ddvNOOntFPkQP++6HhseYlCG+0jwNowgVgG0uXEtq/p46du4ivyr3sLXcufGyljXR+bNJrN4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q9AMMj8M; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q9AMMj8M"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43d07ca6a80so20399345e9.1
        for <linux-s390@vger.kernel.org>; Wed, 19 Mar 2025 02:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742378296; x=1742983096; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2PqWUxX7LYlbsygC64qOjXpYerJEQjDp14rdLABmm2k=;
        b=Q9AMMj8MjQ6Rd68Pvy9mda8QSo1qEANW18iZYDudBH4dm+Q4x1gMaTydjiLs5ig2vk
         MX2chSuLbfzPCKCJzYascImL1feg25X8DpZMTigSAtJAQdMCaIF/5FYiXkXSwDo+tCgG
         6bl544TxGsVDc7B8jLnftanl7szb7ZYdjXJdZJKvqBdeyqZdq4v3EOcfVsqstqXFVy9b
         OE/06mmAFGDLx58CvhiNnT5lBjJpH+O7vCBJUi625gLpokqUjzWbE0XCe1pdIGrVK5h+
         QMttB6xjfNv55pauaevNK8djQ3eXskkoD2HK5rV4FUTQDsRqGNmw2e68q/stmZEFeLvI
         Zy5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742378296; x=1742983096;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2PqWUxX7LYlbsygC64qOjXpYerJEQjDp14rdLABmm2k=;
        b=ocTppMHKodKyyMA24ns7/kdb7LufrkSsow3buyWAn4AFOjP9ctQ0MVOY/mTKoHRUp9
         Ixsb46Yl6N2O0JYskcH/V38SOqjuOdVNUjzfWBHitEnwWi60fQpTsaRuKsq6H7yuDHgo
         SmZVliFs+i0p4AbxZjCdyOROsU2DeySiYZvl6K5ltmDlQzynMbP1Jaf2Faqh6rmzWtB+
         QjK/S8OnxgEG4HXHOVK4gu70OPm3+D3tLgAOWxb8qCfYq7NT3BgtfFJXDC+WjRf1se6S
         HpyF4iOqKJFZzwatCfwObMd3rI/izcyiB1bIi/jNcG3UmifKdB28zv0rSjHmjr4PbHkQ
         Bvxg==
X-Forwarded-Encrypted: i=1; AJvYcCXyiz13JHsbjOKAB7jhR6r3AddKFWZGLKgBLO2CWu3DmdNnavQNwtI9yPCw3ClcYYF0HHW51igyuDi0@vger.kernel.org
X-Gm-Message-State: AOJu0YwrONYxIp4Gf3UT1XCNrkaf8sbjHi5wTl+uxMSW8O7cYsVxqpFE
	JZSvdx/pKwwAAWiCvEul941F5X/X0TTVpraFnXKNF6MaE3XbeQM24HH1gKY4ywo=
X-Gm-Gg: ASbGncsjXPIJg1pMtW9G8RWK+nUJXRw/WVtIdrFbreFtVrF9zT0Sopg1lwTUPlbEN0h
	K21gLuOlYmeYLEC4OBZJ5vS6EphYlXigZWow6KZPC2idmJiYfp+bsIytxtNXg/cWB5SO55409S0
	pOYs+CYXqUlVxxeO2K1kf1H6rpjuBL8dBLENbNgG3qPExRP8cv1W/BW5yRqBb/y3fyoAjrmGVez
	CTDFfKoMoHQ4zBEU9rqMCGubSywxim/sxYxuyWhpH51RAPuABiLvSqd0CoLRAqnBIT0q6y6MjPI
	G4XFXAqE5ZDQuuf0P5fzJE9K6vDo7/smbEalZSX3p3lgChtberMoYQ==
X-Google-Smtp-Source: AGHT+IHxkQSlupYMP4LYGGZIuEwlkxEtovdoMF1P/KgUdpQt8IWKUrUDhmouBZQv2CGhFtATx8RJEw==
X-Received: by 2002:a5d:6481:0:b0:391:2c0c:126b with SMTP id ffacd0b85a97d-399739c93e8mr1589174f8f.23.1742378296293;
        Wed, 19 Mar 2025 02:58:16 -0700 (PDT)
Received: from [192.168.1.247] ([145.224.67.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c888167bsm20451233f8f.45.2025.03.19.02.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 02:58:15 -0700 (PDT)
Message-ID: <9f9c007a-78fe-4709-9063-eb4df72d4f63@linaro.org>
Date: Wed, 19 Mar 2025 09:58:14 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf pmu: Handle memory failure in tool_pmu__new()
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
 hca@linux.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
 irogers@google.com
References: <20250319092847.1192988-1-tmricht@linux.ibm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250319092847.1192988-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19/03/2025 9:28 am, Thomas Richter wrote:
> On linux-next
> commit 72c6f57a4193 ("perf pmu: Dynamically allocate tool PMU")
> allocated PMU named "tool" dynamicly. However that allocation
> can fail and a NULL pointer is returned. That case is currently
> not handled and would result in an invalid address reference.
> Add a check for NULL pointer.
> 
> Fixes: 72c6f57a4193 ("perf pmu: Dynamically allocate tool PMU")
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@linaro.org>
> ---
>   tools/perf/util/pmus.c     | 3 ++-
>   tools/perf/util/tool_pmu.c | 9 +++++++++
>   2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index 9b5a63ecb249..b99292de7669 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -265,7 +265,8 @@ static void pmu_read_sysfs(unsigned int to_read_types)
>   	if ((to_read_types & PERF_TOOL_PMU_TYPE_TOOL_MASK) != 0 &&
>   	    (read_pmu_types & PERF_TOOL_PMU_TYPE_TOOL_MASK) == 0) {
>   		tool_pmu = tool_pmu__new();
> -		list_add_tail(&tool_pmu->list, &other_pmus);
> +		if (tool_pmu)
> +			list_add_tail(&tool_pmu->list, &other_pmus);
>   	}
>   	if ((to_read_types & PERF_TOOL_PMU_TYPE_HWMON_MASK) != 0 &&
>   	    (read_pmu_types & PERF_TOOL_PMU_TYPE_HWMON_MASK) == 0)
> diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
> index b60ac390d52d..d764c4734be6 100644
> --- a/tools/perf/util/tool_pmu.c
> +++ b/tools/perf/util/tool_pmu.c
> @@ -495,12 +495,21 @@ struct perf_pmu *tool_pmu__new(void)
>   {
>   	struct perf_pmu *tool = zalloc(sizeof(struct perf_pmu));
>   
> +	if (!tool)
> +		goto out;
>   	tool->name = strdup("tool");
> +	if (!tool->name) {
> +		zfree(tool);
> +		tool = NULL;

Hi Thomas,

zfree() already sets the thing to NULL but you need to pass a pointer to it:

   zfree(&tool);

Without doing that you only free the first u64 of the struct, which 
happens to be zero in this case so free() does nothing. Then zfree() 
sets the first u64 of the struct to zero which it already is.

With that fixed:

Reviewed-by: James Clark <james.clark@linaro.org>

