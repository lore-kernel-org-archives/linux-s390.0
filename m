Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1011722E3FD;
	Fri,  2 May 2025 16:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746203759; cv=none; b=BWa3rwAvxm03/yzAugNnEVRF2uiJezVyVVsHzowP7irYK84GxODG60VF+EJ6qX6qoDbTdKkw2oWbyb3DOBnA9VdJA2VmH0HZe+M4uLxa6xG4pjjlnshviBH7XwREv62eQoM0q6jN6P88sZrZjglhXb/cw7hwoj2pMUcZrU02Eic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746203759; c=relaxed/simple;
	bh=S/qCvrBSGGRtAj9ZsZ/DLBIwlalTY1STD7YmVaAa29g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oG1Cx9gCNCPV7rdtNkfJqQhRAhboYhC0ia6auj3b8byoe2q+N2XzguLXp78oKuWMoX8dxoCZgV88Edx2zfuWxNsL1BwAcFOGAXB0zQuwhb44Y/Ln4ZeSoiMCNMiQL+bmXTBfe4Ooc+LtGxEGFgSK20+C/i64zG07RNy4qrl7Vvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U570FMRx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U570FMRx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC37C4CEE4;
	Fri,  2 May 2025 16:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746203758;
	bh=S/qCvrBSGGRtAj9ZsZ/DLBIwlalTY1STD7YmVaAa29g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U570FMRx1Qo0G/QgdqD/GFlUUnMjHerG6l7Bp9281RtY7FV15hPKwZfg6KJB6VqRP
	 8Q5QIUUWjYgeYeh4sC2lSdUo6yr+HeQ19ABkyxUqcchYQZuLuAudKKQEP0KemBDUgE
	 z+N7dyk7JLcSegQNvHe0Fl8BW1tqLZOv9IYdqT2N01UlPY5p8oq/x+6GBerlouwcGi
	 +xKRsPSw8MYURhRhl99fGGo5mWT2Rw2J8g7A2WJWXdSGIYNn97pF45cX6fpF3dghig
	 zlxmhcnhCm2OM2CYp/FxlutBk1YvZkhicQAPAhZQNyfYmBhw59UNnNhdHJzAzGWEIt
	 tr0JBiUiRLEuQ==
Date: Fri, 2 May 2025 13:35:55 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-perf-users@vger.kernel.org, namhyung@kernel.org,
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
	hca@linux.ibm.com, irogers@google.com, ctshao@google.com
Subject: Re: [PATCH V4] perf test: Allow tolerance for leader sampling test
Message-ID: <aBT0a5lGzUSLpWpX@x1>
References: <20250430140611.599078-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430140611.599078-1-tmricht@linux.ibm.com>

On Wed, Apr 30, 2025 at 04:06:11PM +0200, Thomas Richter wrote:
> V4: Update to be applied onto linux-next
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

But who is the author? As-is this patch states Thomas Richter as the
author, but since there is also a Suggested-by and Tested-by Thomas
Richter, it makes me believe the author is Chun-Tse Shao, is that the
case?

- Arnaldo

> Tested-by: Thomas Richter <tmricht@linux.ibm.com>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/perf/tests/shell/record.sh | 33 ++++++++++++++++++++++++++------
>  1 file changed, 27 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index 05d91a663fda..587f62e34414 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -240,22 +240,43 @@ test_leader_sampling() {
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
> -  perf script -i "${perfdata}" > "${script_output}"
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
>    done < "${script_output}"
> -  echo "Basic leader sampling test [Success]"
> +  total_counts=$(bc <<< "$invalid_counts+$valid_counts")
> +  if (( $(bc <<< "$total_counts <= 0") ))
> +  then
> +    echo "Leader sampling [No sample generated]"
> +    err=1
> +    return
> +  fi
> +  isok=$(bc <<< "scale=2; if (($invalid_counts/$total_counts) < (1-$tolerance_rate)) { 0 } else { 1 };")
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
> 2.45.2
