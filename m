Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B25284B33;
	Fri, 11 Apr 2025 21:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744405204; cv=none; b=HhtCN69r0YgThc1+vfcZ4R3IbUc5vgT+JYQIAAXPOI7REtXh5T5kfAXjsEx4KbsbinQfX2RI3VSN/KiDVjx22tXFeZJ7vXSNN9T+54ErEQmyBQzuNhvloiPKEJFpBJ/gUC4WnHmp0ZJd+pi3BSfFyWk+/l3vIkhxQR5nvB7Ngx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744405204; c=relaxed/simple;
	bh=58p2bEquuNdeDBo6V10v9l3W14scmxAZKVaTyX4C2DU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lG3p3vAXZ49oEukR4MCkGma/IncZ7cVqWBb2+herjczIjrGVUp+E6si/ngrZvF2/rBl5Fyo/DX802N87nHWrwi2CopXO/RSAmVR+AogVf5y4Rsu3m2f/WgstqlFvYFBFafuuaZ5ObKAxybBslbusaUdllRuWlfiSZKkGOtsVrmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/pTzjaX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/pTzjaX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327E9C4CEE5;
	Fri, 11 Apr 2025 21:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744405203;
	bh=58p2bEquuNdeDBo6V10v9l3W14scmxAZKVaTyX4C2DU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a/pTzjaXAvsi9ClqZx5p4Cr4BE6hFCH8vUC6zbaUcx5WOxNaokll3EvoYWyiM6Add
	 JTp8sInrMJm3b8y18oMjUrcaIRK0DDdkObJ0ny1O27ZoUA2mRCAGwzxBv6mFT62pFS
	 LIweVAqIyRESZx50DwvExRcsgfpqu8Z+QlLjm0OFCCT3E3fB40oE1lzQFn9RpjQNLc
	 uh4HbTaM/9S+nw3mQUGLaB40EGszYS+I4HsDPZhdwBRV9dv6+yEpcxOBLqncvZZoo1
	 y3/9wQjlGTSruOmWi7ASma0R+G6wJOaLWchWVRVQisqbdLAcMBqUx1ZmcR0cexQH6h
	 jtcAGBcPtIKmw==
Date: Fri, 11 Apr 2025 14:00:01 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-perf-users@vger.kernel.org, acme@kernel.org,
	ctshao@google.com, rogers@google.com, agordeev@linux.ibm.com,
	gor@linux.ibm.com, sumanthk@linux.ibm.com, hca@linux.ibm.com,
	Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v3] perf test: Allow tolerance for leader sampling test
Message-ID: <Z_mC0d2_yRaNEb1F@z2>
References: <20250410085522.465401-1-tmricht@linux.ibm.com>
 <Z_hkF6R9giaDGQZD@google.com>
 <27901544-619e-4704-a2a6-132e8ab6a6e4@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27901544-619e-4704-a2a6-132e8ab6a6e4@linux.ibm.com>

On Fri, Apr 11, 2025 at 08:58:45AM +0200, Thomas Richter wrote:
> On 4/11/25 02:36, Namhyung Kim wrote:
> > Hello,
> > 
> > On Thu, Apr 10, 2025 at 10:55:22AM +0200, Thomas Richter wrote:
> >> V3: Added check for missing samples as suggested by Chun-Tse.
> >> V2: Changed bc invocation to return 0 on success and 1 on error.
> >>
> >> There is a known issue that the leader sampling is inconsistent, since
> >> throttle only affect leader, not the slave. The detail is in [1]. To
> >> maintain test coverage, this patch sets a tolerance rate of 80% to
> >> accommodate the throttled samples and prevent test failures due to
> >> throttling.
> >>
> >> [1] lore.kernel.org/20250328182752.769662-1-ctshao@google.com
> >>
> >> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> >> Suggested-by: Ian Rogers <irogers@google.com>
> >> Suggested-by: Thomas Richter <tmricht@linux.ibm.com>
> >> Tested-by: Thomas Richter <tmricht@linux.ibm.com>
> >> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> >> ---
> >>  tools/perf/tests/shell/record.sh | 33 ++++++++++++++++++++++++++------
> >>  1 file changed, 27 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> >> index ba8d873d3ca7..0075ffe783ad 100755
> >> --- a/tools/perf/tests/shell/record.sh
> >> +++ b/tools/perf/tests/shell/record.sh
> >> @@ -238,22 +238,43 @@ test_leader_sampling() {
> >>      err=1
> >>      return
> >>    fi
> >> +  perf script -i "${perfdata}" | grep brstack > $script_output
> >> +  # Check if the two instruction counts are equal in each record.
> >> +  # However, the throttling code doesn't consider event grouping. During throttling, only the
> >> +  # leader is stopped, causing the slave's counts significantly higher. To temporarily solve this,
> >> +  # let's set the tolerance rate to 80%.
> >> +  # TODO: Revert the code for tolerance once the throttling mechanism is fixed.
> >>    index=0
> >> -  perf script -i "${perfdata}" > $script_output
> >> +  valid_counts=0
> >> +  invalid_counts=0
> >> +  tolerance_rate=0.8
> >>    while IFS= read -r line
> >>    do
> >> -    # Check if the two instruction counts are equal in each record
> >>      cycles=$(echo $line | awk '{for(i=1;i<=NF;i++) if($i=="cycles:") print $(i-1)}')
> >>      if [ $(($index%2)) -ne 0 ] && [ ${cycles}x != ${prev_cycles}x ]
> >>      then
> >> -      echo "Leader sampling [Failed inconsistent cycles count]"
> >> -      err=1
> >> -      return
> >> +      invalid_counts=$(($invalid_counts+1))
> >> +    else
> >> +      valid_counts=$(($valid_counts+1))
> >>      fi
> >>      index=$(($index+1))
> >>      prev_cycles=$cycles
> >>    done < $script_output
> >> -  echo "Basic leader sampling test [Success]"
> >> +  total_counts=$(bc <<< "$invalid_counts+$valid_counts")
> >> +  if (( $(bc <<< "$total_counts <= 0") ))
> >> +  then
> >> +    echo "Leader sampling [No sample generated]"
> >> +    err=1
> >> +    return
> >> +  fi
> >> +  isok=$(bc <<< "scale=2; if (($invalid_counts/$total_counts) < (1-$tolerance_rate)) { 0 } else { 1 };")
> > 
> > Is 'scale=2' really needed?  Does something similar to the above like
> > 
> >   if (( $(bc <<< "($invalid_counts / $total_counts) < (1 - $tolerance_rate)") ))
> > 
> > work?
> > 
> > Thanks,
> > Namhyung
> > 
> > 
> 
> From the man page of bc:
> 
> 
> NUMBERS
>        The most basic element in bc is the number.  Numbers are arbitrary precision numbers.   This
>        precision  is both in the integer part and the fractional part.  All numbers are represented
>        internally in decimal and all computation is done in decimal.  (This version  truncates  re‐
>        sults from divide and multiply operations.)
>        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> This can be proved with:
> # bc <<< "2/27"
> 0
> # bc <<< "scale=2;2/27"
> .07
> #
> 
> Without scale there is no fractional part and integer arithmetic will lead to wrong results.
> 
> I think scale=2 is necessary or we need to use something different like awk.

Ok, thanks for checking it.  Right, the scale=2 is necessary.

  $ bc <<< '(1 / 10) < (1 - 0.8)'
  1

  $ bc <<< '(3 / 10) < (1 - 0.8)'
  1

  $ bc <<< 'scale=2; (1 / 10) < (1 - 0.8)'
  1

  $ bc <<< 'scale=2; (3 / 10) < (1 - 0.8)'
  0

Thanks,
Namhyung

