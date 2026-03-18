Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7831B4F09;
	Wed, 18 Mar 2026 01:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773798758; cv=none; b=Qtt873142T1vK6+XsNCOgOiW4Gy1vkoJ8W94Riy9+/gIRM0hwCKhGr85YCwoQ+XGFT8mwJZKRsiI+/aBqpWQY+4Y7Y/VcE0PFWzEMTd9/fi5pQByzxvo3r0KtkzKAyHzGAigYXOm79kTi2xHI5LAhWA22XnmDnfnW1zpRsO9Ev8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773798758; c=relaxed/simple;
	bh=qNmcaRf1or87FJtpGhBUNODnaoOwhhxyGrn3R71WJGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m0HlDbG+Hyu2FL6jJTFSkEI3FEAu6X/SgsiO4F7Pml8U1LnTNBr/HzCV8h9yOyRytTvygyujZzxUATcLltjobaQsp+xBQ0mpKBFLwE3QhYYd2+ckciWherDBwakaR/246EB+wG1APQ9oO1gS/0EHvkNQrDtaYxdyORRMaVxqrZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YOY7SKZb; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YOY7SKZb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773798756; x=1805334756;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qNmcaRf1or87FJtpGhBUNODnaoOwhhxyGrn3R71WJGk=;
  b=YOY7SKZbITS/HGFj0H10X8b47thkrXuFdn8fthsqnRhGh3yBmJr5hegS
   zspBLdozknKPLidhek1/L8x/rofPlA7W5XI3pMKY7AsOibi9Ak8aZGZ8/
   0LT5FI9irOcNaE91qjK4ttqBA8fH2UeAak6yZNxA3076sGXd556jmc0SE
   yPTnRj2JnwtQIri3b+7Iyt3TXG2R3CVAdFO3T/K3na+8sOjZY39LUCUo0
   RZBOFiwcQJ7cjA0FJaGwTzCHXGr2zHH6nR0xwK8CxbOj/nUHmUXBFYJPn
   BPDPHUj7GHXjlruG3x26u45afcGPhvNAgerxtZ949NiRJ7+7WrvNRUQbL
   w==;
X-CSE-ConnectionGUID: HbEwPmyzTtmA4wtrd33NUg==
X-CSE-MsgGUID: NRtLGty0TICOSHok09KBKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="100307293"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="100307293"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 18:52:35 -0700
X-CSE-ConnectionGUID: j3uJvxpCQh2mPviTNuknxQ==
X-CSE-MsgGUID: DecEX2TzRhGwxJ9QKqYipQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="245479958"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 18:52:33 -0700
Message-ID: <53039fb5-4785-48ac-8e9a-7b561a3242c6@linux.intel.com>
Date: Wed, 18 Mar 2026 09:52:30 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf record: Add support for arch_sdt_arg_parse_op()
 on s390
To: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
 acme@kernel.org, namhyung@kernel.org, irogers@google.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
 hca@linux.ibm.com, japo@linux.ibm.com
References: <20260317110641.39975-1-tmricht@linux.ibm.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260317110641.39975-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 3/17/2026 7:06 PM, Thomas Richter wrote:
> commit e5e66adfe45a6 ("perf regs: Remove __weak attributive arch_sdt_arg_parse_op() function")
> removes arch_sdt_arg_parse_op() functions and s390 support is lost.
> The following warning is printed:

Not sure if I miss something, but it looks there was also no s390 specific
support for arch_sdt_arg_parse_op() before the commit e5e66adfe45a6 ("perf
regs: Remove __weak attributive arch_sdt_arg_parse_op() function") and we
would see same warning even without the commit e5e66adfe45a6, right?


>
>   Unknown ELF machine 22, standard arguments parse will be skipped.
>
> ELF machine 22 is the EM_S390 host. This happens with command
>   # ./perf record -v -- stress-ng -t 1s --matrix 0
> on a z/VM system when the event is not specified.
>
> Add s390 specific __perf_sdt_arg_parse_op_s390() function to support
> -architecture calls to arch_sdt_arg_parse_op() for s390.
> The warning disappears.
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Tested-by: Jan Polensky <japo@linux.ibm.com>
> ---
>  .../perf/util/perf-regs-arch/perf_regs_s390.c | 89 +++++++++++++++++++
>  tools/perf/util/perf_regs.c                   |  3 +
>  tools/perf/util/perf_regs.h                   |  1 +
>  3 files changed, 93 insertions(+)
>
> diff --git a/tools/perf/util/perf-regs-arch/perf_regs_s390.c b/tools/perf/util/perf-regs-arch/perf_regs_s390.c
> index c61df24edf0f..2aa70eb23311 100644
> --- a/tools/perf/util/perf-regs-arch/perf_regs_s390.c
> +++ b/tools/perf/util/perf-regs-arch/perf_regs_s390.c
> @@ -1,7 +1,13 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> +#include <errno.h>
> +#include <regex.h>
>  #include "../perf_regs.h"
>  #include "../../arch/s390/include/perf_regs.h"
> +#include "debug.h"
> +
> +#include <linux/zalloc.h>
> +#include <linux/kernel.h>
>  
>  uint64_t __perf_reg_mask_s390(bool intr __maybe_unused)
>  {
> @@ -95,3 +101,86 @@ uint64_t __perf_reg_sp_s390(void)
>  {
>  	return PERF_REG_S390_R15;
>  }
> +
> +/* %rXX */
> +#define SDT_OP_REGEX1  "^%(r([0-9]|1[0-5]))$"
> +/* -###(%rXX) */
> +#define SDT_OP_REGEX2  "^([+-]?[0-9]+)\\(%(r[0-9]|r1[0-5])\\)$"
> +static regex_t sdt_op_regex1, sdt_op_regex2;
> +
> +static int sdt_init_op_regex(void)
> +{
> +	static int initialized;
> +	int ret = 0;
> +
> +	if (initialized)
> +		return 0;
> +
> +	ret = regcomp(&sdt_op_regex1, SDT_OP_REGEX1, REG_EXTENDED);
> +	if (ret)
> +		goto error;
> +	initialized = 1;
> +
> +	ret = regcomp(&sdt_op_regex2, SDT_OP_REGEX2, REG_EXTENDED);
> +	if (ret)
> +		goto free_regex1;
> +	initialized = 2;
> +
> +	return 0;
> +
> +free_regex1:
> +	regfree(&sdt_op_regex1);
> +error:
> +	pr_debug4("Regex compilation error, initialized %d\n", initialized);
> +	return ret;
> +}
> +
> +/*
> + * Parse OP and convert it into uprobe format, which is, +/-NUM(%gprREG).
> + * Possible variants of OP are:
> + *	Format		Example
> + *	-------------------------
> + *	NUM(%rREG)	48(%r1)
> + *	-NUM(%rREG)	-48(%r1)
> + *	%rREG		%r1
> + */
> +int __perf_sdt_arg_parse_op_s390(char *old_op, char **new_op)
> +{
> +	int ret, new_len;
> +	regmatch_t rm[6];
> +	unsigned long i;
> +
> +	*new_op = NULL;
> +	ret = sdt_init_op_regex();
> +	if (ret)
> +		return -EINVAL;
> +
> +	if (!regexec(&sdt_op_regex1, old_op, 3, rm, 0)) {
> +		/* Extract %rX */
> +		new_len = 2;    /* % NULL */
> +		new_len += (int)(rm[1].rm_eo - rm[1].rm_so);
> +		*new_op = zalloc(new_len);
> +		if (!*new_op)
> +			return -ENOMEM;
> +
> +		scnprintf(*new_op, new_len, "%.*s",
> +			  (int)(rm[1].rm_eo - rm[1].rm_so), old_op + rm[1].rm_so);
> +	} else if (!regexec(&sdt_op_regex2, old_op, ARRAY_SIZE(rm), rm, 0)) {
> +		/* Extract #(%rX) */
> +		new_len = 4;    /* (%)NULL */
> +		for (i = 1; i < ARRAY_SIZE(rm) && rm[i].rm_so != -1; ++i)
> +			new_len += (int)(rm[i].rm_eo - rm[i].rm_so);
> +		*new_op = zalloc(new_len);
> +		if (!*new_op)
> +			return -ENOMEM;
> +
> +		scnprintf(*new_op, new_len, "%.*s(%.*s)",
> +			  (int)(rm[1].rm_eo - rm[1].rm_so), old_op + rm[1].rm_so,
> +			  (int)(rm[2].rm_eo - rm[2].rm_so), old_op + rm[2].rm_so);
> +	} else {
> +		pr_debug4("Skipping unsupported SDT argument: %s\n", old_op);
> +		return SDT_ARG_SKIP;
> +	}
> +
> +	return SDT_ARG_VALID;
> +}
> diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
> index 5b8f34beb24e..f52b0e1f7fc7 100644
> --- a/tools/perf/util/perf_regs.c
> +++ b/tools/perf/util/perf_regs.c
> @@ -23,6 +23,9 @@ int perf_sdt_arg_parse_op(uint16_t e_machine, char *old_op, char **new_op)
>  	case EM_X86_64:
>  		ret = __perf_sdt_arg_parse_op_x86(old_op, new_op);
>  		break;
> +	case EM_S390:
> +		ret = __perf_sdt_arg_parse_op_s390(old_op, new_op);
> +		break;
>  	default:
>  		pr_debug("Unknown ELF machine %d, standard arguments parse will be skipped.\n",
>  			 e_machine);
> diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
> index 7c04700bf837..573f0d1dfe04 100644
> --- a/tools/perf/util/perf_regs.h
> +++ b/tools/perf/util/perf_regs.h
> @@ -62,6 +62,7 @@ uint64_t __perf_reg_mask_s390(bool intr);
>  const char *__perf_reg_name_s390(int id);
>  uint64_t __perf_reg_ip_s390(void);
>  uint64_t __perf_reg_sp_s390(void);
> +int __perf_sdt_arg_parse_op_s390(char *old_op, char **new_op);
>  
>  int __perf_sdt_arg_parse_op_x86(char *old_op, char **new_op);
>  uint64_t __perf_reg_mask_x86(bool intr);
