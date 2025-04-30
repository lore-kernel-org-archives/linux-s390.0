Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654581754B;
	Wed, 30 Apr 2025 17:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746033393; cv=none; b=XpSO964+uF6Eg/8QZBmQmGFfXCXHOcmBCRabRFq+/CsEMTV7t7xtcR9IiQPyk28bfc31BKpfJ9t/hhFxE0nsle6yls395D8255TskuSM6XYUrA4rthQuwRBGjAHd8gviETIG4CvRN+xub+PMVLSan3tjhNlNWAAZsMttaSKmLAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746033393; c=relaxed/simple;
	bh=3kFc6bITolNQ6TSbrVeg0UUkF0uc4ccuVasUl9gV4ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPt7FdItJBq33Ur5vnwkbIQiMs+J0SVPlZi215uLR3sqk98uk0sw5h2D4BallIejfAXRIafapAOkTcKBwCXxB64MYhdgpMKhUm0YKkAQeggA8HDBRrOSya+/k0d3xY/bA6CIf+b62z02lxu5uv2r9KKEScnQlgravB3akLWVIlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btCa1JS7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btCa1JS7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB81C4CEE7;
	Wed, 30 Apr 2025 17:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746033392;
	bh=3kFc6bITolNQ6TSbrVeg0UUkF0uc4ccuVasUl9gV4ZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=btCa1JS7AQHDhlnrJPPp66XcaQy+9ZdIyLgkmE8cp+NMWjggVdullhDz5saEv3nGK
	 p9VY3HHbKSpKg4uRMWUTLj7U4GmJP+9kKiSEKmUJ4l2fDRuD/YOQzKtK6jYjywVc3W
	 x18FK46b8x6zKLoB+pRNw1Bh2sPdf6CM4axK/DBs8+MzqlcY8v4SBXNBFvprv1/n6F
	 0RtNKSrqaPsZhCTtQtk5q6s4Z91yeSKBJaIdWYPAlY/fqlxFzd0OJTkRVipJcpX0ht
	 wmtNV8KPXss3+k9DCRnZWTI2/IGuGPAZ/AjonKSjVJlnqDtwAET5Hfz0ASIBCsltS2
	 7JXZrE7FBYJtA==
Date: Wed, 30 Apr 2025 10:16:30 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-perf-users@vger.kernel.org, acme@kernel.org,
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
	hca@linux.ibm.com, irogers@google.com, ctshao@google.com
Subject: Re: [PATCH V4] perf test: Allow tolerance for leader sampling test
Message-ID: <aBJa7qrdMcIEt7y8@google.com>
References: <20250430140611.599078-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250430140611.599078-1-tmricht@linux.ibm.com>

Hello,

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

I think the 'if-else' part can be omitted but I can live with that. :)

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
> 2.45.2
> 
