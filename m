Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE1833436C;
	Tue, 26 Aug 2025 10:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756202435; cv=none; b=NL9aD0FI+7HW0iFmeY32swf3gtrbgOFY5gCsm4X3GKas9volwF7pUVan0WISRZLyoijY4kfDTIiyBLnZRoJVaXUkLnvJJx0oiAcedDe+IVhPGs/SzF5bh4leZCo3JDVPSstqLAdDMpm+pySmHe/0HO3vj9fN9WVOev4+xHxAGkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756202435; c=relaxed/simple;
	bh=IEQ9SKBYOe82CYg7Kw499Qi1OkwUtfFEjr9cZviAE3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lP3dvfHjKcrsWYPD1ibutd432ueCt2DxDbcITX2Xw5yRNg7EpVKGJpD+8J8UO0B0dlFF0208BC5zsiXXKSIvBP9VlwuZkgYnhOq4yhymppsxPkVOzXqH5v/Ura+6V6TdAet/noCO40B5hRAuHcWVBShKaCoBZ0WCFH0Hi9glsHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=n0kV5Wue; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n0kV5Wue"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RZH+TwBr6ueQMAaybKrZKRVrDtnXG+g8a3P12eZE8Z0=; b=n0kV5Wue5+lQyR4Jy72DEbGldq
	VXg3ka9QF87+d0Pz3thNNd5X9pb/WZUrN+hOyyQoS8nDllPli2pceHjzG19BqQqvKyBGiuBlWIgNZ
	ra25yhVychtVyjcS1314JePUcGb3SXpcI+lT7P7TkWO05fGvQ5vlHVeZqj0eR/uXGhvjLaAzL+XzX
	Y+mIKuNjRUG2b+XfCK4y8u3N289YbCji4OMwNRNqLBkLjxVvnuoWbvf6hmqlQpHFzXOU3FADb5iGs
	0Vj6QcqvEYS3loYSnyXMjgbbgr5PjQK6h52wvkADq+FCFvFs9a21yXUPQ1h84W9dA3K9/nG0wEvZI
	jZ9Ku3OQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqqT1-00000002Brt-33nE;
	Tue, 26 Aug 2025 09:59:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 87BEE300220; Tue, 26 Aug 2025 11:59:50 +0200 (CEST)
Date: Tue, 26 Aug 2025 11:59:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	thomas.weissschuh@linutronix.de, Li Chen <chenl311@chinatelecom.cn>,
	Bibo Mao <maobibo@loongson.cn>, Mete Durlu <meted@linux.ibm.com>,
	Tobias Huschle <huschle@linux.ibm.com>,
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>,
	Guo Weikang <guoweikang.kernel@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Brian Gerst <brgerst@gmail.com>,
	Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	"Yury Norov [NVIDIA]" <yury.norov@gmail.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andrea Righi <arighi@nvidia.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: Re: [PATCH v7 4/8] powerpc/smp: Introduce CONFIG_SCHED_MC to guard
 MC scheduling bits
Message-ID: <20250826095950.GI4068168@noisy.programming.kicks-ass.net>
References: <20250826041319.1284-1-kprateek.nayak@amd.com>
 <20250826041319.1284-5-kprateek.nayak@amd.com>
 <609a980b-cbe3-442b-a492-91722870b156@csgroup.eu>
 <20250826080706.GC3245006@noisy.programming.kicks-ass.net>
 <20250826094358.GG3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826094358.GG3245006@noisy.programming.kicks-ass.net>

On Tue, Aug 26, 2025 at 11:43:58AM +0200, Peter Zijlstra wrote:

> Now, when I look at unifying those config options (there's a metric ton
> of crap that's duplicated in the arch/*/Kconfig), I end up with something
> like the below.
> 
> And while that isn't exact, it is the closest I could make it without
> making a giant mess of things.
> 
> WDYT?

Anyway, enough tinkering with this for a little bit. Things are here:

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=sched/core

For to robots to provide feedback :-)
