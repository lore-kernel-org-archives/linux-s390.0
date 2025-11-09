Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C9B1F5433;
	Sun,  9 Nov 2025 11:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762687928; cv=none; b=JYGcFgPhB3Z49YyqAYy19Lc5inTyEuZ2ZsK4oboozbFrhhMdFAmJqzXPJMIHnDZFhISI5itP20JoV+piECBAzxDOTDQEe/FPMxryO0uSBSJ+DIGbgud/eSCL4SLOB1JzYuIP68LhTDXvxZMWax9fyb/NN4id4b/d6h+3Oi6eaQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762687928; c=relaxed/simple;
	bh=X1DCq2snWvTIr7PNvE+F+fgkQO0WS1CO77oTidPJI78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+aR0IwDQsc9oW1sdieh3K0+YVLd6EQuBTcQtpSu3OOhlSt71u2XKn5FcZpdAZV+uxQ2/pqAHYqX9V9XZ97nyjqNZVwhQv1+yD6TKpFdUMmIVDsvyCBMiM+HpSOjrKCN3fZm0LDASKah9fSiUqPat+FE69PiOtsthkn9zByiM6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=c4ZDBlUN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c4ZDBlUN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sj3yBmlxQ4W38p/wAx0e8hgiWkvWvoSbutcbd+syeP0=; b=c4ZDBlUNMfG/ytvuBBlTq0qm8S
	MlKl4d9JFxUzGKZpIZOMpx0+JgdVe/RmU1yMEU452I9Vnniqav6Pr7VhJm/Z+IIa52V8Ekij4WRYL
	B7uVz/Z+d+SAaxw3HmtziAoj52Vd2kU9m20p5mhVCJhPJKt5VrZuJm7doI5DyKqpS51TID5MgUeIr
	IEN6VtLEcJ/WpbaRg28JXhBFV+8G9Z6VeTFfpNNLq+wrB72dH9ZiZk6/fvGRCNrmoLUSp4dhYuvBr
	T8YxnjBsPLj5B6NBjr03Nz34bcnXmjZDwdSWsWre059/mkuo/SM+FbHID0xz0HrbVNlU+6DtFi7VK
	+C8gMYKQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vI3eE-00000006OuP-0q3c;
	Sun, 09 Nov 2025 11:31:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C96F9300230; Sun, 09 Nov 2025 12:31:52 +0100 (CET)
Date: Sun, 9 Nov 2025 12:31:52 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Xie Yuanbin <qq570070308@gmail.com>
Cc: david@redhat.com, tglx@linutronix.de, segher@kernel.crashing.org,
	riel@surriel.com, linux@armlinux.org.uk,
	mathieu.desnoyers@efficios.com, paulmck@kernel.org, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com, svens@linux.ibm.com, davem@davemloft.net,
	andreas@gaisler.com, luto@kernel.org, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
	anna-maria@linutronix.de, frederic@kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com, morbo@google.com,
	justinstitt@google.com, thuth@redhat.com, brauner@kernel.org,
	arnd@arndb.de, jlayton@kernel.org, aalbersh@redhat.com,
	akpm@linux-foundation.org, david@kernel.org,
	lorenzo.stoakes@oracle.com, max.kellermann@ionos.com,
	ryan.roberts@arm.com, nysal@linux.ibm.com, urezki@gmail.com,
	x86@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev,
	will@kernel.org
Subject: Re: [PATCH v2 3/4] Provide the always inline version of some
 functions
Message-ID: <20251109113152.GA2545891@noisy.programming.kicks-ass.net>
References: <20251108172346.263590-1-qq570070308@gmail.com>
 <20251108172346.263590-4-qq570070308@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251108172346.263590-4-qq570070308@gmail.com>

On Sun, Nov 09, 2025 at 01:23:45AM +0800, Xie Yuanbin wrote:
> On critical hot code paths, inline functions can optimize performance.
> However, for current compilers, there is no way to request them to inline
> at a specific calling point of a function.
> 
> Add a always inline version to some functions, so that they can be chosen
> when called in hot paths.

There isn't a single function in the entire kernel with an _ainline
suffix, while there are a ton of _inline suffixed functions.

On top of that, this function was already marked inline, and your
compiler just chose to not inline them for raisins. Just make the thing
__always_inline and forget, dont make thing extra ugly for no reason.
