Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF5D3612C3;
	Tue, 18 Nov 2025 18:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763490270; cv=none; b=Xjb5XZ5pSdFAAO8fSySEUvznlRFCT9uVeg9EBkrfGc+EDdqvnBjMJ7un1Ad5NriK5WrsjExtWavWscrDRdSk1xVomVzsbcF+vdgq09UanvV/SBv3X7X/MA9lj4iueZ927z+OVvsOvWaKoyBFXo8iFTiJqYKIOv1yNlm6u6U2u4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763490270; c=relaxed/simple;
	bh=LSlHntltsTV36A1h1K5uzQJTWSBBUVOJyg/Y2B5k0Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pAUXm7386kwQ/rT0++aAmEvDHlsc0O4PQRO6y5h2fbTzjAmWLvIg9oPPG9zxHQc/PMTKZ48Yrpgf9cfd7sWa+e70rbEHm4OH6NF2oVAOUj6Ffc4kLc1gK0ixNVaXdPhuYgKxbEYmU6lo2WXmK79c2ptFuPgABhZGZDnUsfW7wLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id B057CC0177;
	Tue, 18 Nov 2025 18:24:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 672A445;
	Tue, 18 Nov 2025 18:24:24 +0000 (UTC)
Date: Tue, 18 Nov 2025 13:24:51 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
 acme@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com,
 sumanthk@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com
Subject: Re: [PATCH Linux-next] perf test: Fix test case perf trace BTF
 general tests
Message-ID: <20251118132451.29a35127@gandalf.local.home>
In-Reply-To: <aRwVifZ_-7puFUVC@google.com>
References: <20251117124359.75604-1-tmricht@linux.ibm.com>
	<aRvSv03cqarM5dY9@google.com>
	<d60860b4-e84b-48e1-87dd-4bd8203a69ad@linux.ibm.com>
	<aRwVifZ_-7puFUVC@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 672A445
X-Stat-Signature: p7myfnwem55yoc514tzghwepch5ca7tj
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19tj3XR/by1M9LTk1T9jVObJN+GMLztGME=
X-HE-Tag: 1763490264-773014
X-HE-Meta: U2FsdGVkX19ONDLr6RVVLjhwI1idVWGXWh1Tgbi0kzLE9cXFXMyOWZRcfG17ySjurgHx4x4l0MykFX7ZhB7tXkVs8EJO+EMTH12lVWEBMEa8GizvGRtFWcpiwKtRy/XHhWxgLccFKczxvboDhMzMZnDJJ+9Laq98qIFBBSN2gO2XuJa7rDWnVD6Ba/3XFaoFXgEB2xxVxFZfBI/Zl47aD54uC6flpsC8PJWCHewb1YpVjAZfgotiGMWcazp1/NOwCcIP4AtShKzyaC5DbJOck1JXdhxLQJ4ZvTHVYCtYLUatUghVS2Gy8x15gigLurjavR/tmYzaaLxyr4zSyWBXT81Lq9b5WUa4

On Mon, 17 Nov 2025 22:43:21 -0800
Namhyung Kim <namhyung@kernel.org> wrote:

> > bash-5.3# uname -a
> > Linux f43 6.18.0-rc5-next-20251114tmr-n #1 SMP PREEMPT_DYNAMIC Mon Nov 17 11:24:02 CET 2025 x86_64 GNU/Linux
> > bash-5.3# cat /sys/kernel/tracing/events/syscalls/sys_enter_write/format
> > name: sys_enter_write
> > ID: 758
> > format:
> > 	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
> > 	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
> > 	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
> > 	field:int common_pid;	offset:4;	size:4;	signed:1;
> > 
> > 	field:int __syscall_nr;	offset:8;	size:4;	signed:1;
> > 	field:unsigned int fd;	offset:16;	size:8;	signed:0;
> > 	field:const char * buf;	offset:24;	size:8;	signed:0;
> > 	field:size_t count;	offset:32;	size:8;	signed:0;
> > 	field:__data_loc char[] __buf_val;	offset:40;	size:4;	signed:0;  
> 
> Indeed, I see this new field __buf_val.
> 
> Steve, is this what you added recently for taking user contents?

Yes.

> Hmm.. this makes perf trace confused wrt the syscall parameters.
> Is it always __buf_val or has any patterns?

Really? It still uses libtraceevent right? I made sure that this didn't
break trace-cmd and thought that perf would work too.

-- Steve
