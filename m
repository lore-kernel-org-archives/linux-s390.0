Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C185234D3B3;
	Sun,  9 Nov 2025 11:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762688139; cv=none; b=skZrgrg96jokfmbFcw7GGCVVEv/RfQovEIeTHGfcjBzIb4+oUq0soXMsorVWQTIcCQIzt3d8B+TorQQ+YeyiVyhxTVj8PXXBszH3fIEpd2MCTuDLuJACaIzg41TOPRneWofJxT5Uv27vGW7wtVTPsxUsTsO2Qrxps9n+bbEwPqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762688139; c=relaxed/simple;
	bh=v6SzpFNAHsw8vP25xbzhZPPkNDHfQko1gve7yuVtA08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5RckmVqXoiBZFIxD5yxTy0lSWrNcbpHUdijsQ3uAN1Griv7jS1Yeatqi3P05CjaINJIQ174PO8mlzMDOrG0/jU9iCilnNSroH+9WlLcczT/mcH6cGfXfqwHdxHUfXs6QQffZqJHGpBdCWpy2fkqUT5/xe8qQWbnSav3n4DPyTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=v//DKtfC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="v//DKtfC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=E7of+KRv5wtg04L0riOBm6jlSGoN8qeuSNDj0ONKyk8=; b=v//DKtfCaZRI9e4pBqXwSbKMej
	oWCDzCjkUmFRPg8JSGmmfuK3xTyilDXMwVK0ar294XzQFipwkQXHrh4hNjL/si8UBknNzXMBVFTOv
	/WtQyPfSMqTrtm0iisaAwvfug7nMfu/j/rAzQmmwJcC2HeXeYcsOl9DLOKyvZHQ3YFlo/Vku4om13
	GAf4Ud2TUeikWDwOOv36oKpt0CVL8CgDg1KKsG0q2B5xyqVXUBbWP5yyStdVMfCqEp0B9LtigB3gR
	VG+SgnhIaEEsLOWHJnrFmwc87Zo5zMu+/W+z59SxJppKAgU7LvUlrtHdOvXu0BzZ6GFr4PNi7TJE4
	bb8Idpow==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vI3hm-00000006Sil-0zub;
	Sun, 09 Nov 2025 11:35:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BB27B300230; Sun, 09 Nov 2025 12:35:33 +0100 (CET)
Date: Sun, 9 Nov 2025 12:35:33 +0100
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
Subject: Re: [PATCH v2 4/4] Make finish_task_switch and its subfuncs inline
 in context switching
Message-ID: <20251109113533.GB2545891@noisy.programming.kicks-ass.net>
References: <20251108172346.263590-1-qq570070308@gmail.com>
 <20251108172346.263590-5-qq570070308@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251108172346.263590-5-qq570070308@gmail.com>

On Sun, Nov 09, 2025 at 01:23:46AM +0800, Xie Yuanbin wrote:
> `finish_task_switch` is a hot path in context switching, and due to
> possible mitigations inside switch_mm, performance here is greatly
> affected by function calls and branch jumps. Make it inline to optimize
> the performance.
> 
> After `finish_task_switch` is changed to an inline function, the number of
> calls to the subfunctions (called by `finish_task_switch`) increases in
> this translation unit due to the inline expansion of `finish_task_switch`.
> Due to compiler optimization strategies, these functions may transition
> from inline functions to non inline functions, which can actually lead to
> performance degradation.
> 
> Make the subfunctions of finish_task_stwitch inline to prevent
> degradation.

Yeah, try again without that _ainline garbage.
