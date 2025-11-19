Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3554B2EBBB7;
	Wed, 19 Nov 2025 17:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763575125; cv=none; b=Gxk/zeVOkY5GWXDOUa8t13LXLbTDp3KwxzO8okV08NUV3ZuxJZxvYvyyVzpy/I867TVCs5ftt7SqPBT9PT+ACJ+WNW+JLdvsozrFZyrBX1RgVgkeBw+qJysDeSIVLfB22WXVaO/lncPoktshK7Hd1R3AKwGL9gGyF78cPl4Kie0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763575125; c=relaxed/simple;
	bh=kYjc7AUSoKczd6a1nR8PezTDOKfA2MimUMNaPmkVbEY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T2rz9Fj/MdwFRCJrIAoaml4kv0qU9p6+97WLOsLiCdC6FN65LvYQ1ym6OxUxDVvbPQBfui6O/F0uTFVDVNDQCNZGYfx3VVU5bziyYSmwhAa1U8/mA36ug01/EJidsWJitRnM+bg3MpusMCLu6+EOpIAC70Q30OuYNGMAHECcvF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 3F21889882;
	Wed, 19 Nov 2025 17:58:36 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 04C6630;
	Wed, 19 Nov 2025 17:58:33 +0000 (UTC)
Date: Wed, 19 Nov 2025 12:59:03 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
 acme@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com,
 sumanthk@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com
Subject: Re: [PATCH Linux-next] perf test: Fix test case perf trace BTF
 general tests
Message-ID: <20251119125903.417f595e@gandalf.local.home>
In-Reply-To: <aR1JXlhJ8rC8Ujb3@google.com>
References: <20251117124359.75604-1-tmricht@linux.ibm.com>
	<aRvSv03cqarM5dY9@google.com>
	<d60860b4-e84b-48e1-87dd-4bd8203a69ad@linux.ibm.com>
	<aRwVifZ_-7puFUVC@google.com>
	<20251118132451.29a35127@gandalf.local.home>
	<aR1JXlhJ8rC8Ujb3@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 04C6630
X-Stat-Signature: hmhzk9tx4ftwxzhin3i8137syi6y38j8
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/C+w+oo5oaHCcTt5ftk0o6BQGum86oSic=
X-HE-Tag: 1763575113-918048
X-HE-Meta: U2FsdGVkX1+K91x+L7qCqI+J8jmCqEOKUdpR7bGQOvpK+HNRZklsgAxx5RtDir3qvbSo0W5l6CBR/5NTI4jyer/Nm1oQbBV+FxZnqS8gHyCoyxbRaStUN54/wVSwPrgcCOs+ISlo3wWc2pevayScRQxlZSkn/hVPn920acnZSx4qR+nBlD31FWLx2yF4F9ZifU1FsPD0rB40g3bLmRt3V4W9QhQKA00Co9prnM69H3MlLqhHVujr03VbGMXxEGg3uiJregGpHTivUjHNBTfod3otfMYFK+QTAylBk+idIYXGuZQuSvheQoQhlN45AHM86cQV8VIzJuwDCUNjCHI/uTsO6bo906h0

On Tue, 18 Nov 2025 20:36:46 -0800
Namhyung Kim <namhyung@kernel.org> wrote:

> > Really? It still uses libtraceevent right? I made sure that this didn't
> > break trace-cmd and thought that perf would work too.  
> 
> It doesn't completely break perf trace but added new parameter for the
> write syscall at the end.  IIUC perf trace iterates the format fields
> after __syscall_nr and take them all as syscall parameters.

Is this a regression? Or can perf be fixed?

I just ran it and I have this:

   542.337 ( 0.131 ms): sshd-session/1189 write(fd: 7<socket:[9749]>, buf: , count: 268)                        = 268

I haven't tried it without the patches. Does it usually show what "buf" is?
Now with the reading of user space, it can show the content too!

-- Steve
