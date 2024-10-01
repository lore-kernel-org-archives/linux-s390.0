Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B3B19D88D;
	Tue,  1 Oct 2024 12:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727787319; cv=none; b=W700VYkZGIPFKcOWZ8/U2auaX/GQgAnO78+XIqbYSPd5w4FgvL1xWEdhuGJqoK0f+Zu3O2pRqokvmYo3esIWtf3TtzJ8Ju0PSbYMjmlhWMU2KCYzrqugHzrhv68aF3sh0dlA4Y5B8R08yxjHDrnMG0weOMi9Ba5GPNrxloBEMVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727787319; c=relaxed/simple;
	bh=4jYLX63CHrFBvYvxwP4y6kaYbM2w8WN3NfNT6GNQ0H8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Pg7apwKtx3MsN7QPvvNm97Vhcin3+IdMhpRrcarunRtJ9DU0i4WlaDMOmtEl7uGdecGqdO77mWeNMvIcxiZ4sBhUwPJyg2vxqIci8no7gsgFT3q/F9ERbw+IJa9uapJ7kL2J+0H0y+UvPkuXpPNftqKe9TaWEXUzBoC0m6agy+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kc+tbpwN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kc+tbpwN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F86AC4CECD;
	Tue,  1 Oct 2024 12:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727787318;
	bh=4jYLX63CHrFBvYvxwP4y6kaYbM2w8WN3NfNT6GNQ0H8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kc+tbpwN8O31sDzcMN4ydFZNEGz+egj6SYAuwdxQN0jJtzY1e5QZ3g0OjV0W5qswr
	 s57CtXojP86rVknEvsFidaFcWTJUWyToqHME1MUBgKTMn0QR3U3OGI++O47PH75ocM
	 MoYc92YvFHl56+ph4E3suuGyLlstP3pO7Lelq9a7njB2Uj4UdeuAUGZB3MIZmVKljQ
	 xMAVyJU+M3XDiV/L3i4zhKkqKQJFmU5JwuBUno4Dw6LOylrvCJ9E8oKhvN+LBQkGv7
	 7GLulPRmTXkLGFVI0aegcZf7Dp7YVQoqBm8gVeDNcaHaGPHwHG8MrdtQ52zdOvVrli
	 GaW+rEY3ubViw==
Date: Tue, 1 Oct 2024 21:55:11 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Florent Revest
 <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Mark Rutland <mark.rutland@arm.com>, Sven
 Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v14 04/19] function_graph: Replace fgraph_ret_regs with
 ftrace_regs
Message-Id: <20241001215511.e01163ada44914ac8c6cffc1@kernel.org>
In-Reply-To: <20240916185905.5704-A-hca@linux.ibm.com>
References: <172615368656.133222.2336770908714920670.stgit@devnote2>
	<172615373091.133222.1812791604518973124.stgit@devnote2>
	<20240915051559.435abfcd@rorschach.local.home>
	<20240916121656.20933-B-hca@linux.ibm.com>
	<20240916122930.523af6c5@rorschach.local.home>
	<20240916185905.5704-A-hca@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Sep 2024 20:59:05 +0200
Heiko Carstens <hca@linux.ibm.com> wrote:

> On Mon, Sep 16, 2024 at 12:29:30PM -0400, Steven Rostedt wrote:
> > On Mon, 16 Sep 2024 14:16:56 +0200
> > Heiko Carstens <hca@linux.ibm.com> wrote:
> > 
> > > This does not pass the ftrace selftests. Please merge the patch below
> > > into this patch. With that:
> > > 
> > > Acked-by: Heiko Carstens <hca@linux.ibm.com>
> > 
> > Thank you very much, this is why I wanted arch maintainers acks before
> > taking anything.
> > 
> > There may be other patches in this series that I didn't Cc everyone
> > (yet). Did you look at the other patches? If not, I'll go and do the Cc.
> > It's a manual process.
> 
> I just had a quick look and tried Masami's git tree with the
> topic/fprobe-on-fgraph branch and tried the ftrace selftests, which
> resulted in the provided small fix.

Thanks, and sorry, my change on s390 was wrong. I confused that 
`stack_frame` can be a part of `ftrace_regs`. But at least in this
moment, `ftrace_regs` should replace only `fgraph_ret_regs`.

> 
> But now that you ask, I can see that FPROBE is not available on s390
> anymore with the full series, since HAVE_FTRACE_GRAPH_FUNC is not
> available.

Right, this is required for implementing fprobe.

> 
> Also the s390 variant of arch_ftrace_fill_perf_regs() seems to be
> incorrect.

Can you tell me what part will be wrong?

Thank you,

> 
> Looks like some work is needed from our side.


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
