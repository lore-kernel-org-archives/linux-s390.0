Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5857A168BD;
	Mon,  9 Feb 2026 18:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770663182; cv=none; b=kNA6ebryzi4G6JIkLrHGm0KIb4MH63f9acqrS70teCmViPYKu/+3sohO8fUkpcXINgtQH9A0+Vp5VHf/aqoRHLrqdgOHQalIFLHDYLZmjBeZYgyumEuRamKN6DGuQ8fVZzU5zQ4F2m0lZdoMDC7MEHCcr5WBno99KZmJ61hZxsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770663182; c=relaxed/simple;
	bh=ICoO+Q9XN0JY53liSN3fi3zwyR3bcGxKTgaWVSbm+XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBCqjAwYjVhS0WtAQb06dxBbe4I4CwpgsUUSb5/au2tPL5BCZBNTX1E/fRNYRv9YksbitDJwxYvSUOouzLH/3U5mqBnLSfxMMRhzNuUHr7VJIU8Ceh3yl5cy79mn1Zk3gQ4pzkuNRHzaJKeHTqhrj2Ezo3/w54bkCh6icwIQ3Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbutEHaN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbutEHaN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E04CC116C6;
	Mon,  9 Feb 2026 18:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770663181;
	bh=ICoO+Q9XN0JY53liSN3fi3zwyR3bcGxKTgaWVSbm+XE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hbutEHaN4GJk4RVCOfaDzV9afwRamavrCw7E5viAJYDpP/R0IBEf/fTbbc3HCBcVO
	 p43B1TRxBlf5xBvB+z+8KZR9pWQlSWazFlHXSAWHfB5QtbYdvCeJo5uL+lMWw4GWnD
	 zKL6knvBNe1+uh93cr/el527QEi8o4QzEIEi9cwqaCPWQIoMuR3aoeegEV0T2yQNKa
	 AsuAiBy+ZkJMxqK7vUCArbTdmjKuRqoaezuitrfw5ACC/Ovo7xX63Mn4UB0vS4VS5X
	 ZtdrAkV9owxeJ2KMRTF7kEx4EjphpH2sfQeSXQnN/Dk2GxeHZLP2i2+BkXDxKCKYml
	 Rm6815QcuFwGg==
Date: Mon, 9 Feb 2026 15:52:59 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-perf-users@vger.kernel.org, namhyung@kernel.org,
	irogers@google.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
	sumanthk@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com
Subject: Re: [PATCH linux-next] perf test: Fix test case
 perftool-testsuite_report for s390
Message-ID: <aYotC6uRo4GP1AOr@x1>
References: <20260209153256.601599-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209153256.601599-1-tmricht@linux.ibm.com>

On Mon, Feb 09, 2026 at 04:32:56PM +0100, Thomas Richter wrote:
> Test case perftool-testsuite_report fails on s390 for some time
> now. Root cause is a time out which is too tight for large s390 machines.
> The time out value addr2line_timeout_ms is per default set to 1 second.
> This is the maximum time the function read_addr2line_record() waits
> for a reply from the forked off tool addr2line, which is started as a
> child in interactive mode. It reads stdin (an address in hexadecimal)
> and replies on stdout with function name, file name and line
> number. This might take more than one second.

<SNIP>

> +++ b/tools/perf/util/addr2line.c
> @@ -18,8 +18,8 @@
>  
>  #define MAX_INLINE_NEST 1024
>  
> -/* If addr2line doesn't return data for 1 second then timeout. */
> -int addr2line_timeout_ms = 1 * 1000;
> +/* If addr2line doesn't return data for 5 seconds then timeout. */
> +int addr2line_timeout_ms = 5 * 1000;
  
>  static int filename_split(char *filename, unsigned int *line_nr)
>  {

Thanks, applied to perf-tools-next,

- Arnaldo
