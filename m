Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E0128031D;
	Sun,  9 Nov 2025 11:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762689118; cv=none; b=cEVPZn8RpPgj6VqZq4HEePhZWQvuLJbgNmI+G2MHFMj7Sld85RBbUGtw6BLcsUYueCefWzCQCjohcfeNpa07066hUn2XulE+MYklvDfa2WeeDQ9CpG2raRcgJDrhotpo26ZyWXugxbg+73FV/sviAmCHEocHaG8dXQN3Wv4FTXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762689118; c=relaxed/simple;
	bh=GwX7wATpjr480wc0HrGspcx3uSzhsELZXlRALMshYOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PvKs5sEvDlReALwchxJMnp3Dxf8I2PmQTjBIfQbiFb0FeCwuhSwUEDapiaDSr+bHUN2+JGkTAybYrSLXgF+W12b3vlxU8lyyJj9z/8IwgQoQNkE4+4smDJnakP6JKWyqJANvJMIpeWmxwdITMSlFJL2MNZiWPMvRvVpLLsYyq+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PgWp5Gwh; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PgWp5Gwh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IrXO1X7s/FvF2yB8F6me169g9f36OJ6/LkVLYuvSSMo=; b=PgWp5Gwhf5GnRl3/BOaXaulpFA
	OXkZATs/SHRJQTUoZeROFDYov/No5gfPjlH8G2v8EEGgNilZ6QOHu9mAznoS8GJd6E3h4C7PFhTMn
	1ts50mxrAxcR+4Zn3jL7H7G4pNv/Otc5+OqQcBg4f19QnZnCctSTOM7VgRfZbhMg222rVxVk80vf6
	60Dk0k2rG/ywx0Tr+hAvzNJI1tXZMqvtksaTzMWp4+eJYnTy/OD6hZOFWuQyhm7hGFYbFM//7huaP
	ckkFEHallmLK9nH/GdN8okr5MMAkYhnYBrp7+gLK6QCUY6ybbSfqMzeJN3hKuhUJOJl57eTUNsOEO
	/hOSDBwA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vI35t-000000090QN-08Wu;
	Sun, 09 Nov 2025 10:56:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 968E9300230; Sun, 09 Nov 2025 12:51:52 +0100 (CET)
Date: Sun, 9 Nov 2025 12:51:52 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Xie Yuanbin <qq570070308@gmail.com>, david@redhat.com,
	tglx@linutronix.de, segher@kernel.crashing.org, riel@surriel.com,
	linux@armlinux.org.uk, mathieu.desnoyers@efficios.com,
	paulmck@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, hca@linux.ibm.com,
	gor@linux.ibm.com, agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com, svens@linux.ibm.com, davem@davemloft.net,
	andreas@gaisler.com, luto@kernel.org, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
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
Message-ID: <20251109115152.GD2545891@noisy.programming.kicks-ass.net>
References: <20251108172346.263590-1-qq570070308@gmail.com>
 <20251108172346.263590-4-qq570070308@gmail.com>
 <04CA2D22-4DE2-4DE1-A2BC-AACE666F5F93@zytor.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04CA2D22-4DE2-4DE1-A2BC-AACE666F5F93@zytor.com>

On Sat, Nov 08, 2025 at 02:14:44PM -0800, H. Peter Anvin wrote:

> >+static struct rq *finish_task_switch(struct task_struct *prev)
> >+{
> >+	return finish_task_switch_ainline(prev);
> >+}
> >+
> > /**
> >  * schedule_tail - first thing a freshly forked thread must call.
> >  * @prev: the thread we just switched away from.
> 
> There is, in fact: you have to have an always_inline version, and wrap it in a noinline version.

Yes, but all of this is particularly retarded, there are exactly _2_
callers of this function. Keeping an out-of-line copy for one while
inlineing the other makes 0 sense.

Also, the amount of crap he needs to mark __always_inline doesn't make
much sense to me, is he building with -Os or something?
