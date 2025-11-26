Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D4D30F92F;
	Wed, 26 Nov 2025 15:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764170608; cv=none; b=QXP+qyLPUuok+CVCk5Z0V7N+NWk7vFEfuOcbXntDBXXYcGNALGhwVwHQEHoakM90rsJ24QPACF7u5EhBMiQtvB3BWT79x0Uwsh9TgZYJomdYnxDsQfuacEJT/ZkqyoAKIGV0g8ZsDww8xwfHckbPkgo4ke4lHvp9G70vHmcpxgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764170608; c=relaxed/simple;
	bh=LFc/OZL4XClihrVX49UrCO2oWbvxK9XYv0bABP0kvsg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G/6iX08kV9oyJT/upQMrajBDFIYhquK/yykrww0X/DGcVd+jm5/1LWLsR3wJuBkOGT+9SClYoKjXAiWzqP0ECUUgyQef9MTpKtNiDgr/cm/+wwFNUKRfFIf62ylg3G4u1pOltiWedS7gAQBmM5MHsR9Y8yORN9qY54ukh4F35PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 5F1F8160682;
	Wed, 26 Nov 2025 15:23:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 053A720025;
	Wed, 26 Nov 2025 15:23:15 +0000 (UTC)
Date: Wed, 26 Nov 2025 10:24:01 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
 acme@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com,
 sumanthk@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com
Subject: Re: [PATCH Linux-next] perf test: Fix test case perf trace BTF
 general tests
Message-ID: <20251126102401.37af98bb@gandalf.local.home>
In-Reply-To: <a7a5f95b-25e0-4816-9d0b-04d955c95821@linux.ibm.com>
References: <20251117124359.75604-1-tmricht@linux.ibm.com>
	<aRvSv03cqarM5dY9@google.com>
	<d60860b4-e84b-48e1-87dd-4bd8203a69ad@linux.ibm.com>
	<aRwVifZ_-7puFUVC@google.com>
	<20251118132451.29a35127@gandalf.local.home>
	<aR1JXlhJ8rC8Ujb3@google.com>
	<20251119125903.417f595e@gandalf.local.home>
	<aR5mTLRWA-SLAFUM@google.com>
	<a7a5f95b-25e0-4816-9d0b-04d955c95821@linux.ibm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 053A720025
X-Stat-Signature: 8ccgzmrux5oqkypzm45frqu51ujae3nb
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19JwORjpsyMxLCGkDfN3X/20qARCOPcJlQ=
X-HE-Tag: 1764170595-701583
X-HE-Meta: U2FsdGVkX184Xz57GuSVDRGjbgiTKlTWqoJAwNfuPKL+y6fn7ysgNag7J7IvQjvvgkb7FyCodymddTEggcXwOGNo3kZKANrGGMt4NvI6HS/b9g8tQwL426qDlRAP8dM9rY3Rzb8vsKzdGm8CM0z9UWLl4E6WeRyh01FiVwQMYrR6qunE/89dsZhOsIApc5EY7T6kXPiWxJKXhfLwGeyeVf1pMPnkOW8OIfCsARzGR1GolcJnJOzayUb6b3Ge49zctGRWXRld/vq6QRnJgMaLzghjqr2r17RueTSeNNebl/SWu1kracf05risaimcoJAwJYRmEFWE6fh6wvY/lUZocFSGAdoVqzOc

On Wed, 26 Nov 2025 08:13:00 +0100
Thomas Richter <tmricht@linux.ibm.com> wrote:

> >> I haven't tried it without the patches. Does it usually show what "buf" is?
> >> Now with the reading of user space, it can show the content too!  
> > 
> > Yep, it reads the content using BPF.  This is on my 6.16 kernel.
> > 
> >   $ sudo perf trace -e write -- /bin/echo hello
> >   hello
> >        0.000 ( 0.014 ms): echo/61922 write(fd: 1, buf: hello\10, count: 6)                                 = 6
> > 
> > Thanks,
> > Namhyung
> > 
> >   
> 
> Hello Namhyung, Steven,
> 
> friendly ping... any progress here?
> 

I honestly have no clue how to fix this, as I don't even know where to
look. Is it BPF that is messing up? If so, where's the BPF program that is
doing this.

I thought BPF is supposed to handle updates and should never cause API
breakage?

I'll continue to look at the builtin-trace.c, but it seems that the BPF
program it's attached to is handing it garbage with:

	perf trace -e syscalls:sys_enter_write

The new fields are at the end. The BPF program should simply ignore those
values. But again, I don't know where this BPF program lives.

-- Steve
