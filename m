Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506AD1514E4;
	Thu,  2 Apr 2026 00:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775088092; cv=none; b=Qn/CfzF1h+A5TxcYofUHp8hWX/gzb/3nAJvNp71MfgneIkqjWHGg5MXMF05FsfNO6PjclO1KunH4n4gNGbf/b7kc8D/0SROe6pqyyLuPz4UDcDYnciQDmXQvVWN/n3PwMOllFIpUl8g3rZu9aBzy7+h2MSsiZX8uO12d8nceqrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775088092; c=relaxed/simple;
	bh=6080+FBODSSgbzwCNhsTSNLbXwrIt7Pw0HI9C699/hE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lt37p79P4FPtm+R+AXNOdf8cZ3Vh/k4B7SIDRbhMw2e/8HUgip4PNYKMj/LrxT3iqo9GPkVtSMCtSWdHpA+m6C/lCDRbFTbqhCBgPZv2yPL//2ZhaNxmWa/EYiwdPiyGKUcB9yedPtMgy6fUvjGHNHE6CNz6ra3atWsEWKkJj6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFXru1tu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFXru1tu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C3EC4CEF7;
	Thu,  2 Apr 2026 00:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775088092;
	bh=6080+FBODSSgbzwCNhsTSNLbXwrIt7Pw0HI9C699/hE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UFXru1tu3kx5tOSHE5BisJWIs18Wzji4lKzSzE2yVEAQUgu8Fra7F6kxkPRLFfSLM
	 O0Q52y9N9nMix4omRafmgbZYEtVC4eXcA+mZYm3y6LrMicwZprZuqE0ljivrfyLv5j
	 I/lMLqiDqtjHRIJMWSqhzb+NM/Lnc8GWPhY4lTLzE5O+58+ukWU0dl2lJHaKfHfZ7K
	 AB2OGxIxN1xSXH82cO0+BvJlY+dNAoAhsl+IfhAikP8CUfEOXh9c/a9jEHs+1XPKJZ
	 AeZJTUtqiSLJJUZ/SuokGgLpWTAkTLTHaR2kEZG5s+BI74XyZKNk6p4RLwRV4RDniC
	 7rI9qVVXsAH5Q==
Date: Wed, 1 Apr 2026 17:01:30 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-perf-users@vger.kernel.org, acme@kernel.org,
	irogers@google.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
	sumanthk@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com
Subject: Re: [PATCH 2/3] perf config: Make
 symbol_conf::addr2line_disable_warn configurable
Message-ID: <ac2x2lSmDQE8YHgW@google.com>
References: <20260325120627.1841175-1-tmricht@linux.ibm.com>
 <20260325120627.1841175-3-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260325120627.1841175-3-tmricht@linux.ibm.com>

On Wed, Mar 25, 2026 at 01:06:25PM +0100, Thomas Richter wrote:
> Make symbol_conf::addr2line_disable_warn configurable by reading
> the perfconfig file. Use section core and addr2line-disable-warn =
> value.
> 
> Example:
>  # perf config -l
>  core.addr2line-timeout=500
>  core.addr2line-disable-warn=1
>  #
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Cc: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/config.c | 3 +++
>  1 file changed, 3 insertions(+)

Can you please update Documentation/perf-config.txt as well?

> 
> diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
> index 0452fbc6c085..31541e03aab7 100644
> --- a/tools/perf/util/config.c
> +++ b/tools/perf/util/config.c
> @@ -461,6 +461,9 @@ static int perf_default_core_config(const char *var, const char *value)
>  	if (!strcmp(var, "core.addr2line-timeout"))
>  		addr2line_timeout_ms = strtoul(value, NULL, 10);
>  
> +	if (!strcmp(var, "core.addr2line-disable-warn"))
> +		symbol_conf.addr2line_disable_warn = strtoul(value, NULL, 10);

Sashiko review: Please use perf_config_bool().

Thanks,
Namhyung

> +
>  	/* Add other config variables here. */
>  	return 0;
>  }
> -- 
> 2.53.0
> 
