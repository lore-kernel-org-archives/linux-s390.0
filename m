Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F073054CC;
	Wed, 19 Nov 2025 04:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763527013; cv=none; b=aJ++e1+yMWe/T9HQMh2zfWqTb9gKbWSJ+h9ZZ7gN/EilmcAuyb2GCVKO1r+VCkQVleEIZQul42jWFyNoRILByBkYpADoDW0041IQ/TE4qYt+nSshMUjo3yVaBPFEjDD9PWaIdqEQjsrwEFYp6PiSVlWHTYjHjDczyYXg9zVGPyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763527013; c=relaxed/simple;
	bh=i7FTyMfKA2faDsYEZyR7LnAsGu6Czs+vyOLA26sm3Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1s0kR6FOygcMfyOYQkdcIpq9uaRsiuL5/3yyqCmYkLDmiJyNqyEdPLnLO39XF0cnOMSM6nXZCElLRQ7wfhJD9uk0dUZwr0iABJq/yDM6RhEKwWHnSYm9lKidj47HYcBbGO1BSo2VrT1QW0YOz+BaCglP2RVlnNgJyMTV4BoCq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXFc8ppJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXFc8ppJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EBC0C4AF0E;
	Wed, 19 Nov 2025 04:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763527011;
	bh=i7FTyMfKA2faDsYEZyR7LnAsGu6Czs+vyOLA26sm3Ok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EXFc8ppJrSCRX1JdmRoNUth4BaclTwECsFduCyZrvdfSLrwRS4UMybgMt0F6fF3wT
	 F7tpPJl3kSoN05B8Hn/T89n7okKYyGArBgaiQV5bpeLRpRDm7kjCjDPW67flhmIG9z
	 6tCAPkJAY2NvTkaVVPAJyVWlhi9pfY9zqNMHhdf0v70eiQYpYlZgRgitWg1rO4HC3F
	 +8HgBXgsSJwZjyVd+Y8H2th6+NeI2lh6OLw616LWTWA3dRMov9JrJy++Paux6Abp+d
	 9Yqmpb5h32f1NDJXPsuw5N4l6FHdUdv6v0sTv/jnMZ72L7mJnPeUSLCtIR1AP6+7DG
	 pHfXOF9aaMqPg==
Date: Tue, 18 Nov 2025 20:36:46 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
	acme@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com,
	sumanthk@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com
Subject: Re: [PATCH Linux-next] perf test: Fix test case perf trace BTF
 general tests
Message-ID: <aR1JXlhJ8rC8Ujb3@google.com>
References: <20251117124359.75604-1-tmricht@linux.ibm.com>
 <aRvSv03cqarM5dY9@google.com>
 <d60860b4-e84b-48e1-87dd-4bd8203a69ad@linux.ibm.com>
 <aRwVifZ_-7puFUVC@google.com>
 <20251118132451.29a35127@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251118132451.29a35127@gandalf.local.home>

On Tue, Nov 18, 2025 at 01:24:51PM -0500, Steven Rostedt wrote:
> On Mon, 17 Nov 2025 22:43:21 -0800
> Namhyung Kim <namhyung@kernel.org> wrote:
> 
> > > bash-5.3# uname -a
> > > Linux f43 6.18.0-rc5-next-20251114tmr-n #1 SMP PREEMPT_DYNAMIC Mon Nov 17 11:24:02 CET 2025 x86_64 GNU/Linux
> > > bash-5.3# cat /sys/kernel/tracing/events/syscalls/sys_enter_write/format
> > > name: sys_enter_write
> > > ID: 758
> > > format:
> > > 	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
> > > 	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
> > > 	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
> > > 	field:int common_pid;	offset:4;	size:4;	signed:1;
> > > 
> > > 	field:int __syscall_nr;	offset:8;	size:4;	signed:1;
> > > 	field:unsigned int fd;	offset:16;	size:8;	signed:0;
> > > 	field:const char * buf;	offset:24;	size:8;	signed:0;
> > > 	field:size_t count;	offset:32;	size:8;	signed:0;
> > > 	field:__data_loc char[] __buf_val;	offset:40;	size:4;	signed:0;  
> > 
> > Indeed, I see this new field __buf_val.
> > 
> > Steve, is this what you added recently for taking user contents?
> 
> Yes.
> 
> > Hmm.. this makes perf trace confused wrt the syscall parameters.
> > Is it always __buf_val or has any patterns?
> 
> Really? It still uses libtraceevent right? I made sure that this didn't
> break trace-cmd and thought that perf would work too.

It doesn't completely break perf trace but added new parameter for the
write syscall at the end.  IIUC perf trace iterates the format fields
after __syscall_nr and take them all as syscall parameters.

Thanks,
Namhyung

