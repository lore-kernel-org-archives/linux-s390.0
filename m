Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4548713B280;
	Thu, 31 Oct 2024 01:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730337606; cv=none; b=iRDUg5F6IwIp9pe+qz4bKgX29rJDze6y0OXnNZTMrLNbEVPz6JGd/A7yRCpyK0cbEVYox5I39dYCE1dpiSZ5Wg6VG7iZnJUvlxx3wJqB4zgQj7aR3PnPkb+S2xBCzzVhTMhqW8jTmc2eo5ZvCaKX0llZYxeoL3imIBOt+DYIJAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730337606; c=relaxed/simple;
	bh=n7MVTWqgW2sq1pNmrEu9M8ySxqOFlO6+vLFgYzO8lYQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=G+YQ6eI2xIWLg7BXWyxSoUjxrVZgL2zKFn5LWQQOoOAZn5PYIVR9vJb2IuvZaeMBp0Eao6HdaY6aaqenx0VcOb3FpBeTggUCKYgloOWMMp4iAbuHlBs9Vp2SfWdxCO+B0aRZ9VExy/PnrhNfcNyzOV6kyVgiOmxTjckAe2t1MYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9Rvt7D0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9Rvt7D0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209E8C4CEF6;
	Thu, 31 Oct 2024 01:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730337605;
	bh=n7MVTWqgW2sq1pNmrEu9M8ySxqOFlO6+vLFgYzO8lYQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y9Rvt7D0BGIZbUFnBH1Hi0pPO212QDc3dichA8Myyphu4i3m/6HWTLfvYxGG2ankf
	 XWZE2R9sTCx54+7Uq/xqybOtL6kWlXpk4bf8HJhXvCG4h58jBqwDd+D4G1KHZD4ke1
	 Y81xNSAKL+uEVUYw+zziQBRUL5UnMZvjImxmrVj4RqQjFwx8aeYHTbNKXDTDoYupRT
	 MjDZvdoASNaGslKqh7GVxJc44hBxjik+PForP/Pfiy6zRPKL0w1CT7LWYF20XcsEi7
	 7VnosdvI32kfRGZ+so2SfDjj6bWAn4NVGd6o7IDLoKFq8ILhOt/L7I8/t0v9RiCfLc
	 ule/WzKhi5ORw==
Date: Thu, 31 Oct 2024 10:20:01 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: "Steven Rostedt" <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
Subject: Re: [PATCH 0/1] s390: enable HAVE_FTRACE_GRAPH_FUNC
Message-Id: <20241031102001.a5fe04365acdecbf84f54dd6@kernel.org>
In-Reply-To: <20241028082738.3293096-1-svens@linux.ibm.com>
References: <172991731968.443985.4558065903004844780.stgit@devnote2>
	<20241028082738.3293096-1-svens@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Oct 2024 09:27:37 +0100
Sven Schnelle <svens@linux.ibm.com> wrote:

> Hi Masami,
> 
> this enables HAVE_FTRACE_GRAPH_FUNC for s390. It is based on your
> ftrace/fprope-on-fgraph patchset. I talked to Heiko, and we agreed that it
> would be best if you include this patch in your "fprobe: function_graph:
> Multi-function graph and fprobe on fgraph" patchset.

Great! Thanks!

> 
> Thanks,
> Sven
> 
> Sven Schnelle (1):
>   s390/tracing: Enable HAVE_FTRACE_GRAPH_FUNC
> 
>  arch/s390/Kconfig              |  1 +
>  arch/s390/include/asm/ftrace.h |  5 ++++
>  arch/s390/kernel/entry.h       |  1 -
>  arch/s390/kernel/ftrace.c      | 48 ++++++++++------------------------
>  arch/s390/kernel/mcount.S      | 11 --------
>  5 files changed, 20 insertions(+), 46 deletions(-)
> 
> -- 
> 2.45.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
