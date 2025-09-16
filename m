Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB5A324B19;
	Tue, 16 Sep 2025 14:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032572; cv=none; b=uLZotxEfdwXIeJw9TkQx/rdnvjiudbFGQjh2RBNBh1dtQJ4xUwvYCnX8BmNbh+iZ+lA4sMygw+4XWWzX7CpD6DdhBUOx3x05YsfO6KsQSMp+ZWSiis08vJr+Upyy/XT/dq5NngRIYZyQVkDsE3uxNF97S8216wEtmTWbeUfM7bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032572; c=relaxed/simple;
	bh=0CutIDzf/gEGdyoCPqnfpMJMlGQ4+9GmtlU266DyMnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcBaxsgxLF6GC1VCirHQtDfB3mecDlxBm8GrSUAAYW8yaNhGobY0MECOgMDDf4gNmP8bPSL4KARH+/jteHO0ZK4I6ub7MgzrXNbUxjDO0z0oks1fg6iu6nCPaZSFw9ESG0PW0OjHOhBgZfLBFfwVb5MHq6vuQXrxlOGImT7Cw4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZ5BNsDL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZ5BNsDL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763A0C4CEFA;
	Tue, 16 Sep 2025 14:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758032571;
	bh=0CutIDzf/gEGdyoCPqnfpMJMlGQ4+9GmtlU266DyMnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WZ5BNsDLwOgHNIha/I0j9jft0g3C7S2CTsWdsOnkL5CWbvBFkZXMLWxLHnkHFRiL2
	 KQUSOKI9uEL9vqaMNOel2i+ln5DNkYwxkLo0F9KWQqKvmFJ6pTsUmyA3g1ir/pM4Wh
	 lV4TE9MVF83JVQK1mu5TNy3SexFjjqHCYeSND2AbVu48USbdEwjfnNANlg6xJpLm4K
	 Z8qWbl2lQFiPa3/7I2U0QAMMADVbG0zZFYcBX9lxAtIL+cqKbMl/WrpAM8SnB2EiOs
	 1K2zUmLeFPzBuvV0rcsFHQTb5I78lh8p/UtLrEwpNb14oe5tqn+CRPrCF7o0e6wEc7
	 sILjC/wrhwGlA==
Date: Tue, 16 Sep 2025 11:22:48 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
	hca@linux.ibm.com, japo@linux.ibm.com
Subject: Re: [PATCH] perf/docu: Update header documentation on BPF_PROG_INFO
Message-ID: <aMlyuHe2gg9r7iCQ@x1>
References: <20250805090349.361730-1-tmricht@linux.ibm.com>
 <aJ-ZrlaDDbvY_wbi@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJ-ZrlaDDbvY_wbi@google.com>

On Fri, Aug 15, 2025 at 01:33:50PM -0700, Namhyung Kim wrote:
> On Tue, Aug 05, 2025 at 11:03:49AM +0200, Thomas Richter wrote:
> > Update the perf.data file format description on header
> > section HEADER_BPF_PROG_INFO.
> > The information is taken from process_bpf_prog_info()
> > and write_bpf_prog_info() from file util/header.c.

> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> > Reviewed-by: Jan Polensky <japo@linux.ibm.com>
 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next,

- Arnaldo
