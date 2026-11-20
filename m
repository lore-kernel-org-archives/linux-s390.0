Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795191004;
	b=S1gRO8PBEQ0NiNzwhu7q9o0tO88fSysjpiaJsu4o1lFM3vcs7PeTwqfx2reKwfuu4jKu
	 ZmIpnrPvZZUbD4UqvKX1pqD5nVQ4e8nEEy//5qpUoScrpw16vsZI29J0tTJNLqWh/tlCo
	 ZiSdENbc97gkRktkiofybH++FLNVhKnD6MaQvTMaR54SssQDqdCfWuHCF0RCnLxBgs1kT
	 wKvCGolQM7w+nZpgyUHFn50S+Qsnjh23VB+rZAVWUadb4OHGiWoJZ+NaxmupX0ayNdL6G
	 5tnI/crb8tvRS2Y8/QBC+MT104p3zfhp1/7/kFdK4rwNpxIPyE1zwPnryklV8N3F5qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795191004;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=TzVetcAub0QiHQ6TPOMqLvoxfzTZ8kVoCfb7zrDA3uo=;
	b=Z+HJ0K76zU4cvwyhKQsvPBeamCs5b9KfYKyvRynYfj7oR8pnDcd/gWAJHeoBlBkZJrXh
	 s3wkGWj1sQ2TyT2AveK+vURg8edRoh7zkspAdrqzPCqJpikMf75UrQQyksPuwrj+CbiPZ
	 NxO2NHoPJIKNjv9j0W9+wqgVS4ATcaVvQg5lWx+N5K8eQNjTdUIZQ5i23J52NKHtGTnPX
	 NpjYmt4ASJhrW5+PYxRPaN4sW5WtRISwN4YuLx7iXwifeJMrpUFkbeLJth+FfBmiRK+Sv
	 FDqdiHtgMudVSGeO+r4MOXZ5OBAeDYyRZMuAFuwngp2fQuDarMOG26McyWnaUF2vdLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=dWEAbrYL;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC5E606A330;
	Fri, 20 Nov 2026 16:10:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFC5E606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=dWEAbrYL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TzVetcAub0QiHQ6TPOMqLvoxfzTZ8kVoCfb7zrDA3uo=; b=dWEAbrYLdnMeX8ZhtU5MG7Vq/5
	PJr98qyGH0CPQk8rToNtrNXnwTd8Zag+mlWAzXpNNyZeVI6VV9MHTfoX5egDKn0fvx2O3KNwYDPox
	Prr+HhHasM0Zd/ccLf2e58lg8dVof7ckYoqBQg4t2NkPnYMCC4Q6DVUL3fvvBLs2mteoNvzLfgiz8
	Jz/L4X6+q4IUI9zYw382sIERZDIqAwfp6zuPrHnv5prfAN8Edfkj64LViDzdA1bxUjJTDXceke1H6
	N4PdJt3Ku0gNnRdx8cs1i85+LCpkaPzjHJ9gL9+4LDrHOk507MWWImJwKw/qOsGeHHBHss/yh8lim
	7AL69L0A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xURBV-00000007bM4-3Ooc;
	Fri, 20 Nov 2026 16:09:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0DFFA301185; Fri, 20 Nov 2026 17:09:57 +0100 (CET)
Date: Fri, 20 Nov 2026 17:09:57 +0100
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
	Heiko Carstens <hca@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Johan Hovold <johan@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Maxim Kuvyrkov <maxim.kuvyrkov@grdncc.com>,
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
Subject: Re: [PATCH 7/7] cpu: make preferred CPU policy writers mutually
 exclusive
Message-ID: <20261120160957.GA2668564@noisy.programming.kicks-ass.net>
References: <20261113184257.621707-1-ynorov@nvidia.com>
 <20261113184257.621707-8-ynorov@nvidia.com>
 <20261120153851.GX2668564@noisy.programming.kicks-ass.net>
 <awBub4wgnTnsqL7i@yury>
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
In-Reply-To: <awBub4wgnTnsqL7i@yury>

On Fri, Nov 20, 2026 at 10:59:43AM -0500, Yury Norov wrote:
> On Fri, Nov 20, 2026 at 04:38:51PM +0100, Peter Zijlstra wrote:
> > On Fri, Nov 13, 2026 at 01:42:56PM -0500, Yury Norov wrote:
> > > Serializing preferred mask updates still lets competing policy drivers
> > > repeatedly override each other's selections.
> > 
> > Competing controllers is not going to happen.
> 
> That's the purpose of this patch. You can't stop people writing
> alternative controllers,

Why not? As I said last time; the whole scheme is co-operative, it
relies on all guests doing the same thing.

Alternative controllers make no sense.
