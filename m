Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D5F18027;
	Thu, 20 Nov 2025 00:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763599952; cv=none; b=H5jRCsvZwr7tgSqze0IkaJFArGbjhpxgRjSkzvUz5O7nn3Fg5kqE74GRKBqppZsWsbU6LI8P1NFj/8xn9zBSTpCUJaIwu6h55kAVPLtqNRiR7js+vvLyXJjxC1iwSY2EfnO4E9Bbb7JnylmE1HUY2yQRx5K+vNYKodcNrKTPsV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763599952; c=relaxed/simple;
	bh=E0xOOa7njA7SpFU4Ry9v+uPAwFdSFTB7StCg8u2S8jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDex5m6+0T/Q7zOG+pnvIIElOJ9FlPzTAOnbAAbkayzpNH8RLzD9gZyqpaULeRKf5W6JW3pF3R9w1iG9T9cGMO9tzme+RgUcAcBO61ZBvwftC3Xpf5wt+BFbWcSdRObJOp9o4XC/B00VjSqTUmJTArI+qhVgNDOcx0SGT+OlzXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=phUWyOgp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="phUWyOgp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D6AC4CEF5;
	Thu, 20 Nov 2025 00:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763599951;
	bh=E0xOOa7njA7SpFU4Ry9v+uPAwFdSFTB7StCg8u2S8jk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=phUWyOgpMy+3vcJCzM5EzWFb/e5oY2FCbGluvocuYrNS+87Te2bpxZkz6eYQSoKAb
	 QuWhNLz9XsJrO/B2jO/fAyA+bNVsiqrrIVBwQExddMywTnJnWDZrUDRxH3Mf5ERAEH
	 CdVNSgh+wQNq5HGjDkjOYMCFMkFaa+YI0sBkt2UsT2GRSRtbmX900kq62iC/A2tjzz
	 lEZkwnrPcSUjwm/X0kOXMvRMK6wmqH8Q/9QilbOgPr00SeCDhPFYLO1rTX5vXJ3Bhz
	 Dg7p+0nPG7Ny535h4Wt30Blu1j3f8jpuPsn3bpxqJZEnRTOaVgmmhMUXHeVFZnkRuS
	 NFEVcJIH+SddA==
Date: Wed, 19 Nov 2025 16:52:28 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
	acme@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com,
	sumanthk@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com
Subject: Re: [PATCH Linux-next] perf test: Fix test case perf trace BTF
 general tests
Message-ID: <aR5mTLRWA-SLAFUM@google.com>
References: <20251117124359.75604-1-tmricht@linux.ibm.com>
 <aRvSv03cqarM5dY9@google.com>
 <d60860b4-e84b-48e1-87dd-4bd8203a69ad@linux.ibm.com>
 <aRwVifZ_-7puFUVC@google.com>
 <20251118132451.29a35127@gandalf.local.home>
 <aR1JXlhJ8rC8Ujb3@google.com>
 <20251119125903.417f595e@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251119125903.417f595e@gandalf.local.home>

On Wed, Nov 19, 2025 at 12:59:03PM -0500, Steven Rostedt wrote:
> On Tue, 18 Nov 2025 20:36:46 -0800
> Namhyung Kim <namhyung@kernel.org> wrote:
> 
> > > Really? It still uses libtraceevent right? I made sure that this didn't
> > > break trace-cmd and thought that perf would work too.  
> > 
> > It doesn't completely break perf trace but added new parameter for the
> > write syscall at the end.  IIUC perf trace iterates the format fields
> > after __syscall_nr and take them all as syscall parameters.
> 
> Is this a regression? Or can perf be fixed?
> 
> I just ran it and I have this:
> 
>    542.337 ( 0.131 ms): sshd-session/1189 write(fd: 7<socket:[9749]>, buf: , count: 268)                        = 268
> 
> I haven't tried it without the patches. Does it usually show what "buf" is?
> Now with the reading of user space, it can show the content too!

Yep, it reads the content using BPF.  This is on my 6.16 kernel.

  $ sudo perf trace -e write -- /bin/echo hello
  hello
       0.000 ( 0.014 ms): echo/61922 write(fd: 1, buf: hello\10, count: 6)                                 = 6

Thanks,
Namhyung

