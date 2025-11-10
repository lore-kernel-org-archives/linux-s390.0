Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4FF286405;
	Mon, 10 Nov 2025 20:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762807956; cv=none; b=j7cR7ZbRVa8KrEKv9vwExy2fWLYWxlS51D+1Wa/5n/TXLUmhAU6uwB4FH/JqJj0N+qroMqNToM0XR6MnIyo2vTZ5ONyV7BFiD+XpdEd9QHao5KNkRfF3mZzfR5bZc88asQZAGT6inD5yt4ycyFZzKu8EX3b/zBWrYQSMxlhKCDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762807956; c=relaxed/simple;
	bh=oJEomwA4h/k8618bRef7n045vNsSkpM6C9ZqkfHVxvo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=TJxPBn+E96zWSUQMr/Mvyb8w/lh/KtdYV5NOGsx2JIp4y082z3GwD4MOmyw8W/BT3rO8HBTXsm9yrlJAOgmHlWi0FCxIu3jketE9RsHa8OeGq+Z2oRk1S4pXhZyKdt4uYkxsQx+S0N6TQfW0zjPW0VRNaAfdh6PgBOZ0RhIwRoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=NSpt4WjH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lII1Vsyh; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="NSpt4WjH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lII1Vsyh"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 58FA5140011C;
	Mon, 10 Nov 2025 15:52:32 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 10 Nov 2025 15:52:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762807952;
	 x=1762894352; bh=02T9CV6FzxtQCVORxlgGvtmrENd/kFc0JCKIODyEpvc=; b=
	NSpt4WjHgHnZ2ozF6XrWegnPasjSA8QB1NH+U0B+dLhH4rbHH6JTuyeQsz5Q+pVu
	NOG6oKt2y9++706RlPWlGZ9Jej949kvULtBT52/cG9znpNQiwE3a9u34pP/1OnU9
	767A3pjvhVWGXOVuPrBYe6/ZCDZ4p+9sKqSdlo/wmgDfgMdg/ehdQcsjiMK/Co/X
	4KEOOiMKz2airJ+smOdZtTd9o9b7MFjq8sEaijuiUyMuxnS5Czwd8GrPStAR8GZe
	9GwniPG+tMytrgkBKi1e3x1jTTWwhjmfNaDRBMcv4hQBB0PSSRy8CNjng9H8NsbA
	dbAbf4Scu4v0ZUqXwESLjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762807952; x=
	1762894352; bh=02T9CV6FzxtQCVORxlgGvtmrENd/kFc0JCKIODyEpvc=; b=l
	II1VsyhHVp2SbgZAJeXfn6pyYQJNAlgT1x6Df9YVj+OZCLSgQ7/icqOeNWFK9ccq
	FHEY29KDQwpmrTDl3kiZ5WRhqRO374/xs6mZeLC2CMESy/Bt9Qhdn0N+4GNpAeQj
	9Y3FXP40EtF0oE2GxD73Sah5kn31O8rRSJU6VesrxPpA1uMN0IyJDBh+lsCSrbAb
	Qg65VH7xG2zGzLo7hcna15vLZ0G1e/xcJAOMSPL8Ips9KqGUxiAWB2FtDSYgNtSp
	voKHEterSBVzFar8edOJH67gLsaeGuXnzT6AQe6fAd6UtnBExt77pbeKIYFzrVCm
	s6nBY7INbfxrRKAhmmn4Q==
X-ME-Sender: <xms:j1ASafFlwgE4pjHHcppW-qVfCARjf6dDTg8ADtXfxgZMcBvXYiAK3Q>
    <xme:j1ASaXLBFjstjH1-gwrAU90z2f_l1fj5FuDhzMILR3nFXs23aeKJ-DE7hSsDAqL3Y
    GsmIWGhgxeHJc1utRlCsyS7ejR3Yq3CGDfiGU8L9MAmiyz28RA8pA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleelfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepthhorhhvrghlughssehlihhnuhigqdhfohhunhgurghtihhonhdroh
    hrghdprhgtphhtthhopegrghhorhguvggvvheslhhinhhugidrihgsmhdrtghomhdprhgt
    phhtthhopegsohhrnhhtrhgrvghgvghrsehlihhnuhigrdhisghmrdgtohhmpdhrtghpth
    htohepghhorheslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehhtggrsehlihhn
    uhigrdhisghmrdgtohhmpdhrtghpthhtohepkhhrvggssggvlheslhhinhhugidrihgsmh
    drtghomhdprhgtphhtthhopehsvhgvnhhssehlihhnuhigrdhisghmrdgtohhmpdhrtghp
    thhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqshefledtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:j1ASaeqIOnjN0xND9fKlrDqgYLCwTTGnVrfL6r-Zun0mKn4G0MEGyQ>
    <xmx:j1ASaYhai-Kh4ZAWpMMOaXrn4aNnfeSv2YdS18ZYlmj9hRsdF3k9Qg>
    <xmx:j1ASaQPX1t23SZ9_ico71aRrRa9t7PEAuvbMhLUsNef_2D5CXsXseQ>
    <xmx:j1ASaSypmweJ2vMLS3-8TeyDm-Z8AbUY1Js4re5SGIR1YsdKON0H4A>
    <xmx:kFASabM7PCr0YVACgM8RD5Ynh5kLc1qIw-ly1juzMIePPeUZhaNpuDaS>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AECEB700063; Mon, 10 Nov 2025 15:52:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ahf7rWlW2DAV
Date: Mon, 10 Nov 2025 21:51:53 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Heiko Carstens" <hca@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>,
 "Andreas Krebbel" <krebbel@linux.ibm.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Message-Id: <f4531526-e981-4160-8369-50a8c8d86e36@app.fastmail.com>
In-Reply-To: <20251110185440.2667511-9-hca@linux.ibm.com>
References: <20251110185440.2667511-1-hca@linux.ibm.com>
 <20251110185440.2667511-9-hca@linux.ibm.com>
Subject: Re: [RFC PATCH 8/8] s390/syscalls: Switch to generic system call table
 generation
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Nov 10, 2025, at 19:54, Heiko Carstens wrote:
> The s390 syscall.tbl format differs slightly from most others, and
> therefore requires an s390 specific system call table generation
> script.
> 
> With compat support gone use the opportunity to switch to generic
> system call table generation. The abi for all 64 bit system calls is
> now common, since there is no need to specify if system call entry
> points are only for 64 bit anymore.
> 
> Furthermore create the system call table in C instead of assembler
> code in order to get type checking for all system call functions
> contained within the table.

Thanks a lot for taking care of this!

I had a good look at the patch and checked that there are no
stale syscalls that are no longer needed, the formatting,
and the way this interfaces with the perf code that parses
the same table. Everything looks good as far as I can see.

> +161	common	sched_rr_get_interval		sys_sched_rr_get_interval
> +162	common	nanosleep			sys_nanosleep
> +163	common	mremap				sys_mremap
> +167	common	query_module
> +168	common	poll				sys_poll
> +169	common	nfsservctl
> +172	common	prctl				sys_prctl

Nothing wrong with your patch, but while reading through this, I noticed
that we are somewhat inconsistent about syscalls that are gone, with
three possible methods:

# 167 was query_module
167	common	query_module                  sys_ni_syscall
167	common	query_module

You use the third one now, which is the same as x86 but nothing
else. The second one using an explicit 'sys_ni_syscall' is the
most common and has the same effect, so maybe use that as well.

Eventually we may want to convert everything to the first method
and drop the syscall macros, but that would be visible in
user-space and might cause regression, so it should be a
separate series across all architectures if we want to go there.

I believe we just chickened out when we did the conversion to
syscall.tbl format originally and just left whatever was
in the unistd.h headers at the time.

    Arnd
