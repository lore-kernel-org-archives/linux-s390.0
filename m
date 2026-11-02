Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793609233;
	b=bJ/x2JrKVpzdsoGmtcckKv6bKMitXDTlUbVG9l+t9d+jmV7fSiD4Gdw6fOnRkMrbpXK/
	 ODraWyHF9qtOZiUvMt2giivn4xcobUhBSaWbHo5tTIGNcCrdK2pwXb8vn3rWNYLAEtkHW
	 IjH/00rMq44c8rOBerg16dL2hqEeDO4HDnCpC3u2cw/p7+Cqt8K8vmHsX0v9p18uiHt2D
	 o8J63TS9XWwsDNJUXoxr5gZKocsqNwOSDx3hq9HhsX2rfRsvTj0j6h77+UkIKRhT4ndMs
	 Nwu/j/rI8Eg8tPR0PE8O26KZIPmQYlevRNqUAfi7WV/FXVeEnWX04sINTK1Kb5C4ThA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793609233;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=O6XkqYJ4LCtg+uTN40dEnOg33yY3/MM80Et9d1AnyoQ=;
	b=xZKOE0XHA3zQ7wNd5iKl7A9//yFMQs8hK0D3/V7WWxnjmTrCYuThcIE07jzGPAyN+Qv+
	 yviaxbp4aHHKilddXiOAvMTgGtk/zZtwScJggcs0HPomg9EG7fSJkGr8z4IsgpKaWdwHC
	 +gbBrdTZYqmdZAXh+DT+i6mFrODAKEOtrYOi3ZzLeHqt1YGQxAY6Jefsn5/ofutKjNipk
	 ulSZC6QqLUCHZpV3tyXzZQQRBNqlXlaJAQ9JElwdrUcl8LpP/c3ao06khTSO6VLkAQ2hv
	 +k7uQXZ9AVQ/bK3vsiJ8eBG5czi/z+2PhflR3YFiPHGev4lwLvCygdqm/S2HGjDjcyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=J33ugY7P;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B622606A329;
	Mon,  2 Nov 2026 08:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B622606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=J33ugY7P
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=O6XkqYJ4LCtg+uTN40dEnOg33yY3/MM80Et9d1AnyoQ=; b=J33ugY7PgrW7DnzIWE9Xn7D5Jh
	anvIDvyIleo64jYgJrJRfmEXWTJtvut4yTs3nlMiV0T/8WOcATAFr6Jac2ORjQjOY/VQgnFrd5voQ
	+o/D/yg978HQ/N6QCiq6p1y9ZajKCnteMxYNCn5fRI3OKoT0QyghbeyIv3Z4R1RBJ6eQEkKqB8KRi
	6Rg4mn51QJmE062vd/ufQhftAxLXW39yWSrOxhFt0kUp3whIxdR6DPw++1iim36iaeTKRhdX6WWGo
	B8PoJ75tfXQ7Nq793Et3J5UP5gvTJ+UR/Z4CEcqnf8aZixxgvk1zgPSAYECCxl0TCK8ODQbaN2TMG
	bhjfzeFg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNnh4-00000001Yrx-0VPY;
	Mon, 02 Nov 2026 08:47:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E0D62300312; Mon, 02 Nov 2026 09:47:04 +0100 (CET)
Date: Mon, 2 Nov 2026 09:47:04 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Yury Norov <ynorov@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
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
	Mel Gorman <mgorman@suse.de>, Mete Durlu <meted@linux.ibm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
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
Message-ID: <20261102084704.GQ1779021@noisy.programming.kicks-ass.net>
References: <20261101192203.6979-1-ynorov@nvidia.com>
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
In-Reply-To: <20261101192203.6979-1-ynorov@nvidia.com>

On Sun, Nov 01, 2026 at 02:21:56PM -0500, Yury Norov wrote:
> The preferred CPU mask currently lets the steal governor reduce vCPU
> demand when physical CPUs are contended. This series adds manual control,
> opening more use cases.

Sceptical, I am.

> For example, setting CPUs aside for selected fair tasks at runtime while
> steering other fair tasks toward the remaining CPUs.

That's exactly the kind of nonsense we don't need and makes me want to
stop reading right here.

We already have cpusets that is more than capable of doing this.

> A user can mark a CPU non-preferred and pin a workload to it. Fair tasks
> whose affinity includes preferred CPUs are steered away, while tasks
> whose allowed CPUs contain no preferred CPU can still run there. The CPU
> stays online, task affinity is preserved, and the selection can be
> reversed without rebooting:
> 
>     # rmmod steal_governor
>     # echo 0 > /sys/devices/system/cpu/cpu3/preferred
>     # taskset -c 3 ./my_workload
>     # echo 1 > /sys/devices/system/cpu/cpu3/preferred
> 
> The current preferred list is still readable from:
> 
>     /sys/devices/system/cpu/preferred
> 
> This provides task-placement isolation similar to a use of
> isolcpus=domain, with a runtime interface. Scheduling domains remain
> intact, tick suppression, RCU offloading, and managed-IRQ avoidance
> can be configured separately when needed.
> 
> Different preferred cpumask governors may coexist; all update the
> same mask under common locking. Manual settings are not privileged,
> and later governor updates may override them.

That is a recipe for disaster.

Don't bother trying again, this isn't happening.
