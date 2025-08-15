Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5F61A8412;
	Fri, 15 Aug 2025 20:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755290032; cv=none; b=LXsrFhW9LPB6pWIFIjn5EugXozcvkOo9ceeMH4Jo6CIksymFiaNgq0j1ioHm0kiHdM5Z65nQkze/auISg7z+8nNGn7V40Bgkw2n9Di+FftjbiPkXh9tf8lSR8OBnI/9aTbjEbyBhHM1lLzfEXSX4Yk6fdEZ1NmLId3Z3jNiKA+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755290032; c=relaxed/simple;
	bh=aKahq0zkXbLhMufv1BIwwA1c+93c4alHfaVKPwhcGVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QT6v0y43Ade/ddHd6laarQEtxYMG1dYZW0HjWrZpyzA8XiXArl/hOJ+qKL2aTsT3nJct2iubrMOXpvyFJ4czE3yi3uCgmh+xIvLrKB51QkitHes+K5CRFGCW6u2MmHeb/chQ0mI4CvOS6c30/wqsxeTF3hHTNQvoP/cYfSkyHbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3wI9tuV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3wI9tuV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF3EC4CEEB;
	Fri, 15 Aug 2025 20:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755290031;
	bh=aKahq0zkXbLhMufv1BIwwA1c+93c4alHfaVKPwhcGVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I3wI9tuVF58aohU//+TfmlbFk9tUnRrF9Xl60FKhcdSSXPYjKeU1eopGrWdQktyHP
	 meSkycHj1ifSMSxCfyDkVkbdUGLLJ5oUcn/I623bBH/yR5ZAN9iNJypa2OERfHjEtH
	 Y1df5wpFM5K2rb/nNwqKZ0Z+B71M+9Ume6/rQUzO7Pumqb6USh1U5QGYH8dv6hOrqu
	 CArfF/Td4CJi/sWCMeuZDVTPRj7LKfNUyacxkTHqPY472w/PkE5yvc6WO+gn+5hUJ3
	 gVpfflx4pnoJhGTbBMgqdRv534EYOQROEInplHJ4oQ7Q5n+meauNdNlvPOdGwc5jbq
	 RjkdsEPm0s6gg==
Date: Fri, 15 Aug 2025 13:33:50 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-perf-users@vger.kernel.org, acme@kernel.org,
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
	hca@linux.ibm.com, japo@linux.ibm.com
Subject: Re: [PATCH] perf/docu: Update header documentation on BPF_PROG_INFO
Message-ID: <aJ-ZrlaDDbvY_wbi@google.com>
References: <20250805090349.361730-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250805090349.361730-1-tmricht@linux.ibm.com>

Hello,

On Tue, Aug 05, 2025 at 11:03:49AM +0200, Thomas Richter wrote:
> Update the perf.data file format description on header
> section HEADER_BPF_PROG_INFO.
> The information is taken from process_bpf_prog_info()
> and write_bpf_prog_info() from file util/header.c.
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> Reviewed-by: Jan Polensky <japo@linux.ibm.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/Documentation/perf.data-file-format.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
> index cd95ba09f727..0437eb5d9188 100644
> --- a/tools/perf/Documentation/perf.data-file-format.txt
> +++ b/tools/perf/Documentation/perf.data-file-format.txt
> @@ -348,6 +348,16 @@ to special needs.
>  
>  struct perf_bpil, which contains detailed information about
>  a BPF program, including type, id, tag, jited/xlated instructions, etc.
> +The format of data in HEADER_BPF_PROG_INFO is as follows:
> +	u32 count
> +
> +	struct perf_bpil {
> +		u32 info_len;	/* size of struct bpf_prog_info, when the tool is compiled */
> +		u32 data_len;	/* total bytes allocated for data, round up to 8 bytes */
> +		u64 arrays;	/* which arrays are included in data */
> +		struct bpf_prog_info info;
> +		u8  data[];
> +	}[count];
>  
>          HEADER_BPF_BTF = 26,
>  
> -- 
> 2.48.1
> 
