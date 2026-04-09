Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFA01A6806;
	Thu,  9 Apr 2026 02:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775701883; cv=none; b=mdxWY/ULJ5LAtbm73yMz4oma9pLnaiAT80LnK/gpoFqw7S1bmbVY6fXyUGn8UMiOYAaKL0yQxZ/HO2zJOkQ0a7FEp8F8wV0U2ELniypox4QcIaCuQCrcLSBM9LhVrWqhzr7Uqh4FsDkXJfxBQPlDGcbibR5rIHC48oC6I3OZhI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775701883; c=relaxed/simple;
	bh=2LD2aoMOCesgl9IV2xjHcC0+vY1Ph83SfHtEPcwqT8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCihFUH7GvZdhBPzgRiq8XSxQ/gCObFVoA/fG1V888pwKSjbJ16bXgKuUGdpaJfSlnjQ8SRJvescOM0vuak6K2js2mkwSdilT5lYb0hra3mV5X8hXw9+9OJX/iLYaBdIj7hyVlXpqzWpPnvxzqpjIUxUzggP+jkO8XyX7/oMKPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4E7spz3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4E7spz3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DFC2C19421;
	Thu,  9 Apr 2026 02:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775701882;
	bh=2LD2aoMOCesgl9IV2xjHcC0+vY1Ph83SfHtEPcwqT8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B4E7spz3HVhcmMHSlq0a9lsulIcEKKjhqlzvRkOsiqNQ5WdHHIsk5lMFKwEeuv/8c
	 rvFuvEae9ospxTEt50On5IxX/sigGcrXsxXQKMkBOiUClzNwemNKpCHHFltQNZJDkp
	 HC/YZtYaEji9vUtPYoid97/cWmhcP1HrvO9Xyxv4po0x/emlm20UrGyO7oy24zHIGN
	 AvgypD+ViG1RnaMY5C+sOI2VidGlkMWvzlk93W3tbFX+VF/g4BvTf86Q88WZm1RUAc
	 2HXXxh8nNMBwoiPYsj54Pk1lWoPnMqaQ6/alHMqHycf1BaMQzjkQvcn/lVct2QbWwR
	 Sma6AufTZ69lg==
Date: Wed, 8 Apr 2026 19:31:20 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-perf-users@vger.kernel.org, acme@kernel.org,
	irogers@google.com, howardchu95@gmail.com, agordeev@linux.ibm.com,
	gor@linux.ibm.com, sumanthk@linux.ibm.com, hca@linux.ibm.com,
	japo@linux.ibm.com
Subject: Re: [PATCH v2] perf test: Run test 126 exclusive
Message-ID: <adcPeB5qc0M0K8Fw@google.com>
References: <20260408113143.1645091-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260408113143.1645091-1-tmricht@linux.ibm.com>

On Wed, Apr 08, 2026 at 01:31:43PM +0200, Thomas Richter wrote:
> V1 --> V2 Fixed commit message
> 
> Running both tests cases 126 128 together causes the first test case
> 126 to fail:
>  # for i in $(seq 3); do ./perf test 126 128; done
>  126: perf trace BTF general tests    : FAILED!
>  128: perf trace record and replay    : Ok
>  126: perf trace BTF general tests    : FAILED!
>  128: perf trace record and replay    : Ok
>  126: perf trace BTF general tests    : FAILED!
>  128: perf trace record and replay    : Ok
>  #

The test numbers can be different on other platforms, let's use the test
names like below.

> 
> Test case 126 fails because test case 128 runs concurrently as can
> be observed using a ps -ef | grep perf output list on a different
> window. Both do a perf trace command concurrently.
> Make test case 'perf trace BTF general tests' exclusive.
> 
> Output after:
>  # for i in $(seq 3); do ./perf test 'perf trace BTF general tests' \
> 	'perf trace record and replay'; done
>  127: perf trace BTF general tests                   : Ok
>  155: perf trace record and replay                   : Ok
>  127: perf trace BTF general tests                   : Ok
>  155: perf trace record and replay                   : Ok
>  127: perf trace BTF general tests                   : Ok
>  155: perf trace record and replay                   : Ok
>  #

I believe I have a fix for this problem but it's blocked by a BPF
verifier issue.  I need to find time to work on it again..

https://lore.kernel.org/linux-perf-users/20250814071754.193265-1-namhyung@kernel.org/

Until then, I think it's ok to have this.

Thanks,
Namhyung

> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Cc: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/tests/shell/trace_btf_general.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/trace_btf_general.sh b/tools/perf/tests/shell/trace_btf_general.sh
> index ef2da806be6b..7a94a5743924 100755
> --- a/tools/perf/tests/shell/trace_btf_general.sh
> +++ b/tools/perf/tests/shell/trace_btf_general.sh
> @@ -1,5 +1,5 @@
>  #!/bin/bash
> -# perf trace BTF general tests
> +# perf trace BTF general tests (exclusive)
>  # SPDX-License-Identifier: GPL-2.0
>  
>  err=0
> -- 
> 2.53.0
> 
