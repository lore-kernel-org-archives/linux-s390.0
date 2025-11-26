Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062681E231E;
	Wed, 26 Nov 2025 17:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764177111; cv=none; b=dbJoAUnhM2lIBy/aNeQvrveAHaXZAhYZXauZlnSGkdxuMmCy9f+dkJpTFNLVT8EjKnNrIpqhIzhM4gwN+LtKoRRMawoeMwoWqCaTT0Y2v+IHzTiU8i6O8krhnnSpdkboBi1nJ+PAP7J2HeyyWl4UGhPO5gE3F/naEvuCVWIfNzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764177111; c=relaxed/simple;
	bh=JRLnft1STCz5C59hBNcxaMlyKUQU4UY2eeVxGG6JR4g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WCeUPcEuHVXxyne5AkQnzGEXV4gHqW3mrXy9IX6B482Wyyqom8RxT13e+o9Ds3vzPo8Mvgzc88X1fy/TgHdBBIzOBLEz+H9mVy4P1xW0mVgiobh/cnJ1jEcOKbWYMGxg8GJN69xMkSrjvqkeelg8brV792ZN1ZiI1oE9fSmhhGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 39C87503CA;
	Wed, 26 Nov 2025 17:11:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id DB2236000F;
	Wed, 26 Nov 2025 17:11:43 +0000 (UTC)
Date: Wed, 26 Nov 2025 12:12:29 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: acme@kernel.org
Cc: Thomas Richter <tmricht@linux.ibm.com>, Namhyung Kim
 <namhyung@kernel.org>, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
 agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
 hca@linux.ibm.com, japo@linux.ibm.com
Subject: Re: [PATCH Linux-next] perf test: Fix test case perf trace BTF
 general tests
Message-ID: <20251126121229.0638407b@gandalf.local.home>
In-Reply-To: <20251126102401.37af98bb@gandalf.local.home>
References: <20251117124359.75604-1-tmricht@linux.ibm.com>
	<aRvSv03cqarM5dY9@google.com>
	<d60860b4-e84b-48e1-87dd-4bd8203a69ad@linux.ibm.com>
	<aRwVifZ_-7puFUVC@google.com>
	<20251118132451.29a35127@gandalf.local.home>
	<aR1JXlhJ8rC8Ujb3@google.com>
	<20251119125903.417f595e@gandalf.local.home>
	<aR5mTLRWA-SLAFUM@google.com>
	<a7a5f95b-25e0-4816-9d0b-04d955c95821@linux.ibm.com>
	<20251126102401.37af98bb@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DB2236000F
X-Stat-Signature: ixnrs74wi4p5pb44kisrje415ubczgew
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19b9Y/xRLGc2GJWxPuueuF3hjrt+Fp2rqg=
X-HE-Tag: 1764177103-495019
X-HE-Meta: U2FsdGVkX187el5y25s6dq1GvhwlaySD9i6HORjUTb+91SpgFnFjfztaPY3cu3DdcCcXF7g1FGjqPU3sy9Kh8yonotuukLXI4YE4bpJwnCkGn6du+s1PQhp1KDjGZ9nAW3c46rZbYW6gzjfr+3KL8bYDorCetfUZcYL1FgoQX6zpmYI3hs+acCp1DZWCzegisFt/B6xc2/suWqRMLcq0NkiaTvHReB7yzWNQ0X2nSTCzTSFxliXL/mpR8c1bMUhQ3nhQN/UVVZasQjl7YCEk8Xdy0THLouDIimGcEUfb3Xzk7jfxWNU8Gy9l3ykYp2jRK3B3Z6Fno/KnVR3is9oEt321GtHsRjzoHSHsIkT3P26SPZc9nXkjjtfI2RYz8oY9b3IDDXmzbd9GLI3OoPECCg==


Arnaldo,

How can I make perf trace not confused by the extra fields in the system
call trace events?

Ftrace can now show the contents of the system call user space buffers, but
it appears that this breaks perf!!!

system: syscalls
name: sys_enter_write
ID: 791
format:
	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
	field:int common_pid;	offset:4;	size:4;	signed:1;

	field:int __syscall_nr;	offset:8;	size:4;	signed:1;
	field:unsigned int fd;	offset:16;	size:8;	signed:0;
	field:const char * buf;	offset:24;	size:8;	signed:0;
	field:size_t count;	offset:32;	size:8;	signed:0;
	field:__data_loc char[] __buf_val;	offset:40;	size:4;	signed:0;

That new __buf_val appears to confuse perf, but I'm having a hell of a time
trying to figure out where it reads it!

-- Steve


On Wed, 26 Nov 2025 10:24:01 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 26 Nov 2025 08:13:00 +0100
> Thomas Richter <tmricht@linux.ibm.com> wrote:
> 
> > >> I haven't tried it without the patches. Does it usually show what "buf" is?
> > >> Now with the reading of user space, it can show the content too!    
> > > 
> > > Yep, it reads the content using BPF.  This is on my 6.16 kernel.
> > > 
> > >   $ sudo perf trace -e write -- /bin/echo hello
> > >   hello
> > >        0.000 ( 0.014 ms): echo/61922 write(fd: 1, buf: hello\10, count: 6)                                 = 6
> > > 
> > > Thanks,
> > > Namhyung
> > > 
> > >     
> > 
> > Hello Namhyung, Steven,
> > 
> > friendly ping... any progress here?
> >   
> 
> I honestly have no clue how to fix this, as I don't even know where to
> look. Is it BPF that is messing up? If so, where's the BPF program that is
> doing this.
> 
> I thought BPF is supposed to handle updates and should never cause API
> breakage?
> 
> I'll continue to look at the builtin-trace.c, but it seems that the BPF
> program it's attached to is handing it garbage with:
> 
> 	perf trace -e syscalls:sys_enter_write
> 
> The new fields are at the end. The BPF program should simply ignore those
> values. But again, I don't know where this BPF program lives.
> 
> -- Steve

