Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D9436CDEB;
	Tue, 31 Mar 2026 07:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774941766; cv=none; b=ChCeKPYz3ugfT2RBe6Fwr1+wmDYA9dq/3iUxdsoXFIpvASO4OnKPuioHZVWBDbQyhk6fRSz8LixUKEZJwrDxmCbgVf9fGqV7RGijv7DdM5KdsLuOQubV62Vhs5ACrHKU7TZsKknu+p9J9BYrZRPTRbid4gGx98QK4kgH89OkwrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774941766; c=relaxed/simple;
	bh=sPxW0yfu//zSeLtd/BQuzmOsxO+8k5NcO+wTPrKFW+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGS6cMxvEJXA6IrPP+Dq8iEnyGbs586QUF7+6tlEEt0D/iZIL6Z8uVtIYqdBZs2RK7GAEPQtqzNUQFXZ4k8Urg7JVJGwXDgBECwPVwZ/KyQTPZE+qP0h4u/UzPsKnSK63scyKxT7J+Yc973JtfqgUqRVG93eP5PZ7SMWhVZAi7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxPC10co; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxPC10co"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A49FC19423;
	Tue, 31 Mar 2026 07:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774941766;
	bh=sPxW0yfu//zSeLtd/BQuzmOsxO+8k5NcO+wTPrKFW+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JxPC10co6ceWQbAP2hKDc8epXBuGI4dlBAGH/JoTicdxGKXmnJQe4/Kelt/VHDJam
	 12llJFRqQVTg6l5pTnW7fRYkbpM9NdPKG92nFB2wJBxZDdyty2uD3peuXRi4RgILrY
	 YehkIntpPrkEBy549yPRXPoxu3yvuyVu9raOOqRzzynTl1eL4jUf9ypOhkfVCTE9tG
	 68QW69BCu2lUK5X6kOLUOUFoSkXhmXKXXX32KFbB/QhDUribjqHe8rjejHnPDxG71f
	 f/qcOA+gebitYS7HMO8LudZZeSol8XzciGVrXXriqmaHjuwCjN6nz8Zn3lmm7BzJ2O
	 jqV3axVjr1dXg==
Date: Tue, 31 Mar 2026 00:22:44 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com,
	hca@linux.ibm.com, jameshongleiwang@126.com, japo@linux.ibm.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-s390@vger.kernel.org, sumanthk@linux.ibm.com,
	tmricht@linux.ibm.com
Subject: Re: [PATCH v2] perf tests task-analyzer: Write test files to tmpdir
Message-ID: <act2RNT6-3Kx_h5p@google.com>
References: <20260326174521.1829203-1-irogers@google.com>
 <20260327060033.2294469-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260327060033.2294469-1-irogers@google.com>

I'm curious why this patch is in the idle symbol thread.


On Thu, Mar 26, 2026 at 11:00:33PM -0700, Ian Rogers wrote:
> Writing to the test output files in the current working directory can
> fail in various contexts such as continual test. Other tests write to
> a mktemp-ed file, make the "perf script task-analyszer tests" follow
> this convention too. Currently this isn't possible for the perf.data
> file due to a lack of perf script support, add a variable for when
> this support is available.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/shell/test_task_analyzer.sh | 38 +++++++++++---------
>  1 file changed, 21 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/test_task_analyzer.sh b/tools/perf/tests/shell/test_task_analyzer.sh
> index e194fcf61df3..b1a6a7e017e4 100755
> --- a/tools/perf/tests/shell/test_task_analyzer.sh
> +++ b/tools/perf/tests/shell/test_task_analyzer.sh
> @@ -3,6 +3,11 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  tmpdir=$(mktemp -d /tmp/perf-script-task-analyzer-XXXXX)
> +# TODO: perf script report only supports input from the CWD perf.data file, make
> +# it support input from any file.
> +perfdata="perf.data"
> +csv="$tmpdir/csv"
> +csvsummary="$tmpdir/csvsummary"
>  err=0
>  
>  # set PERF_EXEC_PATH to find scripts in the source directory
> @@ -15,11 +20,10 @@ fi
>  export ASAN_OPTIONS=detect_leaks=0
>  
>  cleanup() {
> -  rm -f perf.data
> -  rm -f perf.data.old
> -  rm -f csv
> -  rm -f csvsummary
> +  rm -f "${perfdata}"
> +  rm -f "${perfdata}".old
>    rm -rf "$tmpdir"
> +
>    trap - exit term int
>  }
>  
> @@ -61,7 +65,7 @@ skip_no_probe_record_support() {
>  
>  prepare_perf_data() {
>  	# 1s should be sufficient to catch at least some switches
> -	perf record -e sched:sched_switch -a -- sleep 1 > /dev/null 2>&1
> +	perf record -e sched:sched_switch -a -o "${perfdata}" -- sleep 1 > /dev/null 2>&1
>  	# check if perf data file got created in above step.
>  	if [ ! -e "perf.data" ]; then
>  		printf "FAIL: perf record failed to create \"perf.data\" \n"

Please update this part too.

Thanks,
Namhyung


> @@ -130,28 +134,28 @@ test_extended_times_summary_ns() {
>  }
>  
>  test_csv() {
> -	perf script report task-analyzer --csv csv > /dev/null
> -	check_exec_0 "perf script report task-analyzer --csv csv"
> -	find_str_or_fail "Comm;" csv "${FUNCNAME[0]}"
> +	perf script report task-analyzer --csv "${csv}" > /dev/null
> +	check_exec_0 "perf script report task-analyzer --csv ${csv}"
> +	find_str_or_fail "Comm;" "${csv}" "${FUNCNAME[0]}"
>  }
>  
>  test_csv_extended_times() {
> -	perf script report task-analyzer --csv csv --extended-times > /dev/null
> -	check_exec_0 "perf script report task-analyzer --csv csv --extended-times"
> -	find_str_or_fail "Out-Out;" csv "${FUNCNAME[0]}"
> +	perf script report task-analyzer --csv "${csv}" --extended-times > /dev/null
> +	check_exec_0 "perf script report task-analyzer --csv ${csv} --extended-times"
> +	find_str_or_fail "Out-Out;" "${csv}" "${FUNCNAME[0]}"
>  }
>  
>  test_csvsummary() {
> -	perf script report task-analyzer --csv-summary csvsummary > /dev/null
> -	check_exec_0 "perf script report task-analyzer --csv-summary csvsummary"
> -	find_str_or_fail "Comm;" csvsummary "${FUNCNAME[0]}"
> +	perf script report task-analyzer --csv-summary "${csvsummary}" > /dev/null
> +	check_exec_0 "perf script report task-analyzer --csv-summary ${csvsummary}"
> +	find_str_or_fail "Comm;" "${csvsummary}" "${FUNCNAME[0]}"
>  }
>  
>  test_csvsummary_extended() {
> -	perf script report task-analyzer --csv-summary csvsummary --summary-extended \
> +	perf script report task-analyzer --csv-summary "${csvsummary}" --summary-extended \
>  	>/dev/null
> -	check_exec_0 "perf script report task-analyzer --csv-summary csvsummary --summary-extended"
> -	find_str_or_fail "Out-Out;" csvsummary "${FUNCNAME[0]}"
> +	check_exec_0 "perf script report task-analyzer --csv-summary ${csvsummary} --summary-extended"
> +	find_str_or_fail "Out-Out;" "${csvsummary}" "${FUNCNAME[0]}"
>  }
>  
>  skip_no_probe_record_support
> -- 
> 2.53.0.1018.g2bb0e51243-goog
> 
