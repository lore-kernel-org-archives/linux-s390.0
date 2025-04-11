Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359DE36D;
	Fri, 11 Apr 2025 00:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744331802; cv=none; b=rJbTg4oTAkUAgs0NmpGoy6oWKcE5qDCpFgelPutp9eAq3BL2F74epw/JtpMekAuRlouKFrzylUBPLptZVG+M+BAURN2aDw3zb+SBMiqZEVfj3D5hZppKO7jXvKOMDpu7FnodYhOPbkmdAr8r8brcEEuJQI0gbDSo0xwjzdRMK2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744331802; c=relaxed/simple;
	bh=lE4nTXO4MAppOW16nbEnxqr5/YrynS26YWxLS3vMqEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMgvWdaQNScr+tRaCns8Z2HSE52PIOsGo+eiwRu1rQ0uY2vaIb9BhQw2kqsfZCIIbTCFt94ruhYIwMknHNGeJ88F/WiQAf67e9C7LMQ6JYKxUqzORR6/ZHDeko8YrtLz19iY/QNz5SqdXq+zciOULttdHsGGecM4KvrpoO9oFj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRt79iQh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRt79iQh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C024C4CEDD;
	Fri, 11 Apr 2025 00:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744331801;
	bh=lE4nTXO4MAppOW16nbEnxqr5/YrynS26YWxLS3vMqEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NRt79iQh78Z3bTh6TAqfyhyc/h53ZY3cy/YNkdX9kEhiQ7/5qvPgoxYN+i8UG4X+y
	 CRniUsv7TIqi2Uyy1M21DjCfg+Vvh1I+Z9d9SulMEpiwz9iggsK3hkBD+4SO/R4fAy
	 N2uLAgCe76/V0LqJEsW43/RfKe1HcjcRuG0mTueKMAu9M3w5AbMEZrkOIuxt4nd9z3
	 oNl5puzwmpg8/VAIMPxHuuFUjz4BOC6GZAlfs83+b03eD6Lyi2xMSNSzHOoeRUj3WU
	 ZEsnmUvHeX31dg2jkXNmidKWCSY59kO+PxiH0rEudtZYf4s1m+uVHX+lxffJfoAKCY
	 USBTI7RBq96Mw==
Date: Thu, 10 Apr 2025 17:36:39 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-perf-users@vger.kernel.org, acme@kernel.org,
	ctshao@google.com, rogers@google.com, agordeev@linux.ibm.com,
	gor@linux.ibm.com, sumanthk@linux.ibm.com, hca@linux.ibm.com,
	Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v3] perf test: Allow tolerance for leader sampling test
Message-ID: <Z_hkF6R9giaDGQZD@google.com>
References: <20250410085522.465401-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250410085522.465401-1-tmricht@linux.ibm.com>

Hello,

On Thu, Apr 10, 2025 at 10:55:22AM +0200, Thomas Richter wrote:
> V3: Added check for missing samples as suggested by Chun-Tse.
> V2: Changed bc invocation to return 0 on success and 1 on error.
> 
> There is a known issue that the leader sampling is inconsistent, since
> throttle only affect leader, not the slave. The detail is in [1]. To
> maintain test coverage, this patch sets a tolerance rate of 80% to
> accommodate the throttled samples and prevent test failures due to
> throttling.
> 
> [1] lore.kernel.org/20250328182752.769662-1-ctshao@google.com
> 
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> Suggested-by: Ian Rogers <irogers@google.com>
> Suggested-by: Thomas Richter <tmricht@linux.ibm.com>
> Tested-by: Thomas Richter <tmricht@linux.ibm.com>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/perf/tests/shell/record.sh | 33 ++++++++++++++++++++++++++------
>  1 file changed, 27 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index ba8d873d3ca7..0075ffe783ad 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -238,22 +238,43 @@ test_leader_sampling() {
>      err=1
>      return
>    fi
> +  perf script -i "${perfdata}" | grep brstack > $script_output
> +  # Check if the two instruction counts are equal in each record.
> +  # However, the throttling code doesn't consider event grouping. During throttling, only the
> +  # leader is stopped, causing the slave's counts significantly higher. To temporarily solve this,
> +  # let's set the tolerance rate to 80%.
> +  # TODO: Revert the code for tolerance once the throttling mechanism is fixed.
>    index=0
> -  perf script -i "${perfdata}" > $script_output
> +  valid_counts=0
> +  invalid_counts=0
> +  tolerance_rate=0.8
>    while IFS= read -r line
>    do
> -    # Check if the two instruction counts are equal in each record
>      cycles=$(echo $line | awk '{for(i=1;i<=NF;i++) if($i=="cycles:") print $(i-1)}')
>      if [ $(($index%2)) -ne 0 ] && [ ${cycles}x != ${prev_cycles}x ]
>      then
> -      echo "Leader sampling [Failed inconsistent cycles count]"
> -      err=1
> -      return
> +      invalid_counts=$(($invalid_counts+1))
> +    else
> +      valid_counts=$(($valid_counts+1))
>      fi
>      index=$(($index+1))
>      prev_cycles=$cycles
>    done < $script_output
> -  echo "Basic leader sampling test [Success]"
> +  total_counts=$(bc <<< "$invalid_counts+$valid_counts")
> +  if (( $(bc <<< "$total_counts <= 0") ))
> +  then
> +    echo "Leader sampling [No sample generated]"
> +    err=1
> +    return
> +  fi
> +  isok=$(bc <<< "scale=2; if (($invalid_counts/$total_counts) < (1-$tolerance_rate)) { 0 } else { 1 };")

Is 'scale=2' really needed?  Does something similar to the above like

  if (( $(bc <<< "($invalid_counts / $total_counts) < (1 - $tolerance_rate)") ))

work?

Thanks,
Namhyung


> +  if [ $isok -eq 1 ]
> +  then
> +     echo "Leader sampling [Failed inconsistent cycles count]"
> +     err=1
> +  else
> +    echo "Basic leader sampling test [Success]"
> +  fi
>  }
>  
>  test_topdown_leader_sampling() {
> -- 
> 2.49.0
> 
