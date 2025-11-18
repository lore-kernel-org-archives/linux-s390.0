Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601AB19E82A;
	Tue, 18 Nov 2025 06:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763448205; cv=none; b=fiMC0mPD/RZFaaIl76crVvnKcjEfWHkMhbK/3kJ03gDhU+BNi86BHa7oaznCw6OOP/Gn0hg3NNc+BT62IQ4mJZCJwVQjbuXblpbijt1hcreW1YGgypH+vpHG2eEDGKkZ0WFXcKBzg2TrMJDjiQEkPRixspQbb7DScK4nn/nUW5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763448205; c=relaxed/simple;
	bh=cnxqSavRDXRgmStSAMorwEeh76IAMbVyat/rjuS/Urg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkm/2Sa/n7ucP76DZ65bw8BRAAgFqE/cdkNoOJzE4sz1EMERf/CdJ2utzIJBF0tZ4lWNqgAaDj6VuPEdY+C2yqAkMAf/XUVzP7bdvnEC9QbhVZ7abB/Kd7MWFpiVZQ0UeqMJk+DWMurgpU2SF2QFwcx3+XdDtM6yRLAzBIaC9iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxkpDbI2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxkpDbI2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0B0C19421;
	Tue, 18 Nov 2025 06:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763448204;
	bh=cnxqSavRDXRgmStSAMorwEeh76IAMbVyat/rjuS/Urg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jxkpDbI2dHNrME9wNi6gK2eXgAHndxfBTQk3n3vveBqld8eAvPao9W75+UlvyJgNT
	 6w7O0pGsTKAqJsL848IhIlSk/JuYYeuMq13LbRdjSQPU/g4VGI+NjU5/uITcknxDz2
	 VGnpL7CyY1UAa/h9QsIknMxAnTYgEPSrLGBeT0Fj1hCcQ06rx1uC5Fp2/fOmeWejTD
	 7CMjLc9HSMLcUJacJKZ6zhHmHrN4R/enqD6+AUoy54HFc4htVbGfOl1QGD8pcTyT6J
	 2jWBGs5Kei6gJYo37jOrXitOIpMoQHr1C/3fJdyxWVY/Wx3HyCqHqzx2ZhHXvBf0VF
	 dD9nPCncZVBng==
Date: Mon, 17 Nov 2025 22:43:21 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-perf-users@vger.kernel.org, acme@kernel.org,
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
	hca@linux.ibm.com, japo@linux.ibm.com
Subject: Re: [PATCH Linux-next] perf test: Fix test case perf trace BTF
 general tests
Message-ID: <aRwVifZ_-7puFUVC@google.com>
References: <20251117124359.75604-1-tmricht@linux.ibm.com>
 <aRvSv03cqarM5dY9@google.com>
 <d60860b4-e84b-48e1-87dd-4bd8203a69ad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d60860b4-e84b-48e1-87dd-4bd8203a69ad@linux.ibm.com>

On Tue, Nov 18, 2025 at 07:15:45AM +0100, Thomas Richter wrote:
> On 11/18/25 02:58, Namhyung Kim wrote:
> > Hello,
> > 
> > On Mon, Nov 17, 2025 at 01:43:59PM +0100, Thomas Richter wrote:
> >> The following test case fails on linux-next repo:
> >>
> >>  ❯ uname -a
> >>  Linux s83lp47.lnxne.boe 6.18.0-20251116.rc5.git0.0f2995693867.63.\
> >>       fc42.s390x+next #1 SMP Sun Nov 16 20:05:28 CET 2025 s390x GNU/Linux
> >>
> >>  # perf test -Fv 109
> >>  --- start ---
> >>  Checking if vmlinux BTF exists
> >>  Testing perf trace's string augmentation
> >>  Testing perf trace's buffer augmentation
> >>  Buffer augmentation test failed, output:
> >>  buffer content
> >>  echo/23281 write(1, buffer conten, 15, "") = 15
> >>  ---- end ----
> >>  109: perf trace BTF general tests            : FAILED!
> >>  #
> >>
> >> The root case is a changed output format on linux-next.
> >> There is an addional "" string as forth parameter in the write()
> >> line. Here is the detailed output on linux-repo.
> >> Please note that this depends on the kernel and not on the perf tool.
> > 
> > Thanks for the report.  Do you know what the 4th arg is?  It'd be nice
> > if you can dump the contents of the event format which is
> > /sys/kernel/tracing/events/syscalls/sys_enter_write/format.
> > 
> > Thanks,
> > Namhyung
> > 
> 
> Here is the output from my x86 virtual machine with linux-next 20251114 tag.

Thanks for sharing this!

> 
> bash-5.3# uname -a
> Linux f43 6.18.0-rc5-next-20251114tmr-n #1 SMP PREEMPT_DYNAMIC Mon Nov 17 11:24:02 CET 2025 x86_64 GNU/Linux
> bash-5.3# cat /sys/kernel/tracing/events/syscalls/sys_enter_write/format
> name: sys_enter_write
> ID: 758
> format:
> 	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
> 	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
> 	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
> 	field:int common_pid;	offset:4;	size:4;	signed:1;
> 
> 	field:int __syscall_nr;	offset:8;	size:4;	signed:1;
> 	field:unsigned int fd;	offset:16;	size:8;	signed:0;
> 	field:const char * buf;	offset:24;	size:8;	signed:0;
> 	field:size_t count;	offset:32;	size:8;	signed:0;
> 	field:__data_loc char[] __buf_val;	offset:40;	size:4;	signed:0;

Indeed, I see this new field __buf_val.

Steve, is this what you added recently for taking user contents?
Hmm.. this makes perf trace confused wrt the syscall parameters.
Is it always __buf_val or has any patterns?

> 
> print fmt: "fd: 0x%08lx, buf: 0x%08lx (%s), count: 0x%08lx", ((unsigned long)(REC->fd)), ((unsigned long)(REC->buf)), __print_dynamic_array(__buf_val, 1), ((unsigned long)(REC->count))
> bash-5.3# 
> 
> Hope this helps.

Yes it did, thanks!
Namhyung

