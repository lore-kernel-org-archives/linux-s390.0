Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794477652;
	b=iasRsRobioPQ90iZHw/SxaUo4z7eWKmUJnt72yqhDrUKmubgqp0dAnX9C3Xy85Cffce5
	 3rUtiqMYQEU8xXo4AI8jAe5pnWzsUdWcSKn4sbiD081B+Yzp768M+mI4XgcMFrUp7WYNK
	 uOLoly/Sp4mRKTajOv+XrTDDjpXvxvN39CZaTohULa7qBuCbmilVgC+UTrpG32tqu8JIW
	 ad+lYyclm5GY1pecLAbQMXPldqGFWfbFvsHaU1c4BamYKNWV1mGafFysbdm47UIjQAtMm
	 0OsCNSpzSHuJj8RSX9sLlIpH+frkN2zI0ApegDSX3CxEenEZEGGo+HRX91FW5whkx5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794477652;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=pZPruizCw8dZqJF6tmAQF+xof9USD+Yx7Epz9rMt5m8=;
	b=GyOElY9ptMwfLa9cZA5cTjtq3xv54EfZB80sTUq7WVFeXL2HaqdZMWFsKoRjYR987b4H
	 W0NC8g05l6AN1syqPtizqA3CQYztMwtq6Mj+NJNmPnA7y8K1YD16HCibTJdluZucFtRkJ
	 9En7aKyq8p0RDE043fkMSgEZLYBJGPsQFgPc8HhwZQsyK58Rqlg0I8w7zSnGZ9c/gatwi
	 rwn+zE6QD3+RHugiWsrncEX+4tVubUQ2Vta/iPEZSaLP48DCQ/kgxAUqkxAWv0GgMMlzQ
	 1qbJYhTUeB58tOSpu1GukbelnCEfK2Q7CoM5AmU7JqOZaM16lHQfyVta9gCKj5xqbUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=ZR1nyB6r;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0437E606A31C;
	Thu, 12 Nov 2026 10:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0437E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=ZR1nyB6r
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pZPruizCw8dZqJF6tmAQF+xof9USD+Yx7Epz9rMt5m8=; b=ZR1nyB6r0GiR5wJO5ZQipIuWrk
	/rDZtxw0swz2Lrj1gaXASkQECt1bEWlYkQp00JBi5uCB5IpzKp42wcmx71jdE6waeJ7ZuqIJ/0ovo
	/YSmXKn39YyPr0mm8gH/cEG6IZewx6che0vf17c2Pzyv/wYqCuvoCbAsgqjkr6qCnA9ZMPj8KtR3/
	nLdY7OjfgNeUTSS7D+QlpyZq2j1dYmjBaC5czbHzmbSddRn4+RkjOUZoPWn7KMz72xujt95vtWFAX
	DmwRO7m750WXn6qdKLtMgdyuKNlAU4VCSjWhzDBfTWnITMYsHSDlVz5x/orhvjZF/K4nqSR0gzyDI
	W+jqPR1g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRRbp-0000000AANe-1EMj;
	Thu, 12 Nov 2026 10:00:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A28F630066A; Thu, 12 Nov 2026 11:00:43 +0100 (CET)
Date: Thu, 12 Nov 2026 11:00:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mete Durlu <meted@linux.ibm.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, Yury Norov <ynorov@nvidia.com>,
	Maxim Kuvyrkov <maxim.kuvyrkov@grdncc.com>,
	Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Yury Norov <yury.norov@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andrea Righi <arighi@nvidia.com>, Ben Segall <bsegall@google.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heiko Carstens <hca@linux.ibm.com>, Johan Hovold <johan@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Mel Gorman <mgorman@suse.de>, Randy Dunlap <rdunlap@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, driver-core@lists.linux.dev,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/6] sched: Expose writable interface for preferred CPUs
 mask
Message-ID: <20261112100043.GR2668200@noisy.programming.kicks-ass.net>
References: <20261101192203.6979-1-ynorov@nvidia.com>
 <A2B09626-39F0-4EC3-B57D-CD83D77DD208@grdncc.com>
 <avTSC2r61uht9oFK@yury>
 <ef8dcbd9-61e9-467a-88da-3d159a5df9df@linux.ibm.com>
 <91823f62-57fe-44ad-9dab-ba91ba3d26d3@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91823f62-57fe-44ad-9dab-ba91ba3d26d3@linux.ibm.com>

On Thu, Nov 12, 2026 at 10:56:36AM +0100, Mete Durlu wrote:
> > Did you mean pin to preferred CPUs? Why would anyone want to run their
> > workload only on non-preferred CPUs? By definition, they are not meant to
> > be used as much as possible. and It is benchmarking.
> 
> I think they want to prevent anything else *besides* their workload
> from running on these CPUs by marking them non-preferred and then
> pinning their workload there.
> Sort of like like dynamically configurable isolated CPUs.
> 
> IMO this fits 1-1 with what Yury is describing with this patchset.

That's what we have cpusets for. It can do configurable isolated CPUs
just fine, in fact, it was made for that.
