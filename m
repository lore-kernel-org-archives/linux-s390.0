Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD29815689A;
	Tue,  4 Feb 2025 03:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738640541; cv=none; b=X8jZ0SimTtvQa2rQwqTR6gQHczUB3JDmMlhrTAdfISo47+EHZnixCTLSiNWyOG1VcDjpk7Er/3+GQdATEirt8vJ5CMG/CzlLOScZD3A02/jW9zigfq49dvBcH9TH0lt5oFBxkkGKomQpv6X6kqyFbN/EqM9arJhNtQIg2vVpG0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738640541; c=relaxed/simple;
	bh=5CHz9yyeZs0EA8QG0X+vsnfv5KE42hIvyG3YFhIufZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iaAZnZJl3ai83eHm9Cw1OuBA8B5l1wDPoVEQm67+bkdamVDO4OHT4Wfdbia9A5Z+6Cax6Lfa+mgpWs+MRcaGFv2s4RY/dn8CtxmCN0OZeJE3JVAAmsrmi/GtJ/xvRXv4ErFihUE0S3oBIJm3NbEa0TDJ1ocQ+5gWeR/28mPEWbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6/hZ3Tl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6/hZ3Tl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8EE3C4CEDF;
	Tue,  4 Feb 2025 03:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738640541;
	bh=5CHz9yyeZs0EA8QG0X+vsnfv5KE42hIvyG3YFhIufZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V6/hZ3Tl/MkO1zyYAiF2wZzbxY/FeNv/Il9nShI9sBMBTD8+GYJLxOXTgj7kF75XM
	 jTTKfnmaGPIIT56yH/hsuwcSB69t0GPKiC+6KtMrYXLzkAgZYrSqMGAqsOjbVW+4rd
	 IO7g/7sFRcpLqTwU6uNGHvHyFvqKJ5ueHH3oEqs7ymYNil5BwnKkvaOwSulbeoWWMV
	 3PLrJvx0kZ2n7nkji7GwLMs6iN8fFyTywrpfb+HzYesoTYMPfVcUAugjUG4ajfTatR
	 3kQ3tio3uMqrAvHD/LUHukrvopXQX6UQr47wGFyDt3C2haoM4T7Odz6450OiMx2Pzx
	 RiI4ldXF/XbkA==
Date: Mon, 3 Feb 2025 19:42:19 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	acme@kernel.org, linux-s390@vger.kernel.org, james.clark@linaro.org,
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
	hca@linux.ibm.com, Kan Liang <kan.liang@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH 2/2 v3] perf test: Change event in perf test 114 perf
 record test subtest test_leader_sampling
Message-ID: <Z6GMmxKvXd0-fd_-@google.com>
References: <20250131102756.4185235-1-tmricht@linux.ibm.com>
 <20250131102756.4185235-3-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250131102756.4185235-3-tmricht@linux.ibm.com>

Add Kan and Dapeng to CC.

Thanks,
Namhyung


On Fri, Jan 31, 2025 at 11:27:56AM +0100, Thomas Richter wrote:
> On s390 the event instructions can not be used for recording.
> This event is only supported by perf stat.
> 
> Change the event from instructions to cycles in
> subtest test_leader_sampling.
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Suggested-by: James Clark <james.clark@linaro.org>
> Reviewed-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/tests/shell/record.sh | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index fe2d05bcbb1f..ba8d873d3ca7 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -231,7 +231,7 @@ test_cgroup() {
>  
>  test_leader_sampling() {
>    echo "Basic leader sampling test"
> -  if ! perf record -o "${perfdata}" -e "{instructions,instructions}:Su" -- \
> +  if ! perf record -o "${perfdata}" -e "{cycles,cycles}:Su" -- \
>      perf test -w brstack 2> /dev/null
>    then
>      echo "Leader sampling [Failed record]"
> @@ -243,15 +243,15 @@ test_leader_sampling() {
>    while IFS= read -r line
>    do
>      # Check if the two instruction counts are equal in each record
> -    instructions=$(echo $line | awk '{for(i=1;i<=NF;i++) if($i=="instructions:") print $(i-1)}')
> -    if [ $(($index%2)) -ne 0 ] && [ ${instructions}x != ${prev_instructions}x ]
> +    cycles=$(echo $line | awk '{for(i=1;i<=NF;i++) if($i=="cycles:") print $(i-1)}')
> +    if [ $(($index%2)) -ne 0 ] && [ ${cycles}x != ${prev_cycles}x ]
>      then
> -      echo "Leader sampling [Failed inconsistent instructions count]"
> +      echo "Leader sampling [Failed inconsistent cycles count]"
>        err=1
>        return
>      fi
>      index=$(($index+1))
> -    prev_instructions=$instructions
> +    prev_cycles=$cycles
>    done < $script_output
>    echo "Basic leader sampling test [Success]"
>  }
> -- 
> 2.48.1
> 
