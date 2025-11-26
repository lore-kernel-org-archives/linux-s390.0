Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2CF1D5170;
	Wed, 26 Nov 2025 18:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764183436; cv=none; b=eC4kCynLfNCs7Q7Fw2i2Ju0QVKaHQidmBzEWJf26sKLV8vQzXfbYClxfFPaLIcdpLA/kSn+z4trGF1o6DP2PnV44gjkK5qLIQvdnHHF8FZYBXkSxTvCfBe5pXrJ5Oq4xM+wW54sC2Zhlr3XEpRMaRWYfq4EJQzilcOhbq/iHEcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764183436; c=relaxed/simple;
	bh=vpDzDn4Wi+CKs6uJl+BfvYWGOn9752VZ+OV59Q9ein8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSnYzapqkxFHkfBAcIc4fRoWbyEtBPPx221Cml1ttRb3HgRVNKoBWRPHjC1Odg98mPryKxdwyL5xBRwKmmgf7ajh70/u4FvUqlIojeV3V/vXyK9wlv+fbYQH/lXrglHahl4v44CXJyO8bgPstHaAoip5/06btvV0VvrvFubJu1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEB3RrxE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEB3RrxE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560A6C4CEF7;
	Wed, 26 Nov 2025 18:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764183435;
	bh=vpDzDn4Wi+CKs6uJl+BfvYWGOn9752VZ+OV59Q9ein8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vEB3RrxEQKJl3GoSmyhVuJqpl07ba5wkXbhnmu+yMQYtoeDUXgbZqD5TmRlOvYfzV
	 c2Oj0ELd4PYWeOalgt83KBN5DaGnmX9m4M6W/E3Gd+aNKvsqPZ51tOj5GdZeCkQp8S
	 s2dKAsqEB4E6TSoxOCDLHlEPgsDAljxX8SkWfPPR0Nh9WwiEnQiyBRfi3JK0RHcn5D
	 VOKXiMztS5T2cT+kafXIJZWYI1dNXsyPZ0VZ9xp3Eur19L/Z45sP2GYE3bsN9JFAbz
	 tbgWH3oP3+k9v3UGIzMn9D1As4oR3eIQN43zRiIizCDeZF+mv6PoRZiAF+HSZ/osuQ
	 Y1bY6zMTEms2A==
Date: Wed, 26 Nov 2025 10:57:12 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: acme@kernel.org, Thomas Richter <tmricht@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-perf-users@vger.kernel.org, agordeev@linux.ibm.com,
	gor@linux.ibm.com, sumanthk@linux.ibm.com, hca@linux.ibm.com,
	japo@linux.ibm.com
Subject: Re: [PATCH Linux-next] perf test: Fix test case perf trace BTF
 general tests
Message-ID: <aSdNiF2VZMtjQnUQ@google.com>
References: <aRvSv03cqarM5dY9@google.com>
 <d60860b4-e84b-48e1-87dd-4bd8203a69ad@linux.ibm.com>
 <aRwVifZ_-7puFUVC@google.com>
 <20251118132451.29a35127@gandalf.local.home>
 <aR1JXlhJ8rC8Ujb3@google.com>
 <20251119125903.417f595e@gandalf.local.home>
 <aR5mTLRWA-SLAFUM@google.com>
 <a7a5f95b-25e0-4816-9d0b-04d955c95821@linux.ibm.com>
 <20251126102401.37af98bb@gandalf.local.home>
 <20251126121229.0638407b@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251126121229.0638407b@gandalf.local.home>

On Wed, Nov 26, 2025 at 12:12:29PM -0500, Steven Rostedt wrote:
> 
> Arnaldo,
> 
> How can I make perf trace not confused by the extra fields in the system
> call trace events?
> 
> Ftrace can now show the contents of the system call user space buffers, but
> it appears that this breaks perf!!!
> 
> system: syscalls
> name: sys_enter_write
> ID: 791
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
> 
> That new __buf_val appears to confuse perf, but I'm having a hell of a time
> trying to figure out where it reads it!

I've discussed with Steven and concluded that we should change perf to
ignore fields with "__data_loc char[]" type in syscalls.  Let me take a
look.

Thanks,
Namhyung

