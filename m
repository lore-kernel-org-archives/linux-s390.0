Received: from mta1.migadu.com (out-76.mta1.migadu.com [95.215.58.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4683537E8
	for <linux-s390@vger.kernel.org>; Sat,  3 Oct 2026 09:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791018588; cv=none; b=GnLkZzOwoQYS/C8+AgOHM963t8LTSN2Uu9314w2SG3AkCrEeJmZKt60JHi8803xTRsOuMsOXFOAwyhc6CZu8Z44ih+H3GXkuWNWiz5pgUPfxYJV7GUp8lt0PKGBc7cDXwhlNWcr5ySCHapRfqv3woHarcbGRroHs760qAcHFPRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791018588; c=relaxed/simple;
	bh=FSHH2lxVQ7W/7ZcDn6MGkBGZpq4xldC6pMHimCeppLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkUcaJXL//wTfR+2xHcva6isj4HzM7Z8n/ZeH/eLMzdUZOo1ATqj0wUjbYtsQ8J5BYISpSb0rMDbF5sIZbbJBsYp/dsUoCx+kvl/oxE4xafSUL8g9Q2ltE1NTXsUuZLwrdjfpZNMRO/kw+CW2hlyFijXIB4Y95vOI1pn5bYm97o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NfrGPrpy; arc=none smtp.client-ip=95.215.58.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NfrGPrpy"
X-Envelope-To: linux-s390@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=FSHH2lxVQ7W/7ZcDn6MGkBGZpq4xldC6pMHimCeppLE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791018584; v=1; x=1791623384;
 b=NfrGPrpynlfLGKKORwxbqUJ9jWekm+WhjRX1N2s2hao7SjcpaAeK2noOCaX0NLjgWfPunq2h
 RWP6+EQsQnVKK5BQXIA3e1fyZBYiGMq23N2ycS6ztlgwzYu0jAevs/xitss7nAXiVcmGE6qQkXG
 c+T/RSTvjEIus7/mxlYtNBfI=
X-Envelope-To: linux-s390@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2747b1746997b9b8;
	Sat, 03 Oct 2026 09:09:43 +0000
X-Mizu-Trace-ID: 2747b1746997b9b8
X-Migadu-Flow: FLOW_OUT
Date: Sat, 3 Oct 2026 17:10:04 +0800
From: Chen Yu <chen.yu@linux.dev>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Chen Yu <yu.c.chen@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org,
	loongarch@lists.linux.dev, driver-core@lists.linux.dev,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	WANG Xuerui <kernel@xen0n.name>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH v3 00/13] lib, sched: Introduce sparsebitmap (sbm)
Message-ID: <asDGbBEHkDouWOwC@three-body>
References: <20261001192849.74788-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001192849.74788-1-kprateek.nayak@amd.com>

Hello Prateek!

Thanks for bringing this interesting topic,

On Thu, Oct 01, 2026 at 07:28:36PM +0000, K Prateek Nayak wrote:
> 
> Problem
> =======
> 
>                                             %cycles vs global mask operation
> 
> global mask                                     : 100.0000%  (var: 3.28%)
> per-NUMA mask                                   :  32.9209%  (var: 7.77%)
> per-LLC mask                                    :   1.2977%  (var: 4.85%)
> per-LLC mask (u8 operation; no LOCK prefix)     :   0.4930%  (var: 0.83%)
> 

This shows a significant latency improvement, especially in the per-LLC (u64, u8) case.
May I know if schbench / sched-messaging were used?

> 
> Future work
> ===========
> 
> o Interoperability with cpumaks since sbm lose the crucial optimizations
>   that come naturally from for_each_cpu_and() iterations.
>
> o Different data representation - using the u8 variant for updates and
>   then perform a "gather" operation to build a dense mask.
> 
> o Extending sbm work to help in wakeup (and possibly resurrect Mel's
>   optimization from [4] in some form). The current sbm is still far away
>   from being used for wakeups since  updates  to sbm leaf, even on a
>   16CPUs per LLC system is visible in benchmark performance (~8-10%).
> 

If we leverage sbm for the wakeup path, it is a per-LLC mask, there seems to be
no much difference from Mel Gorman's proposal of allocating per sd_share
unsigned long idle_cpus_span[]? The frequent update to this mask might still cause
c2c latency within 1 LLC. A wild guess is that maybe the u8 version is more suitable,
because it has only max-to-8 CPUs touching the mask at the same time?

My understanding is that the major case that sbm could fit is turning the global bitmask
into a per-LLC bitmask, because it mainly avoids CPUs on different LLC/node writing the
same cache line frequently (nohz.idle_cpus_mask set via nohz_balance_enter_idle() on
many CPUs, etc), which might cause a costly cache RFO event storm. Meanwhile, with sbm,
at the reader side, _nohz_idle_balance() could start scanning from the current CPU to find
an idle CPU, so as to avoid the costly HITM event - the reader is on LLC1, while the writer
is on LLC0 - so maybe:

for_each_cpu_wrap(balance_cpu, nohz.idle_cpus_mask, this_cpu+1)

could start from this_cpu's LLC sibling first, rather than this_cpu + 1, because this_cpu+1
might not always be the LLC sibling of this_cpu.

I found that in the current code, there are also other global mask:
rd->rto_mask(mentioned by Pan Deng when running ffmpeg[1])
rd->dlo_mask
tick_broadcast_**mask
maybe they can also be converted into sbm.

[1] https://lore.kernel.org/lkml/a3207ebf537bbe5605ff5454f63b5604d83a04a0.1753076363.git.pan.deng@intel.com/

thanks,
Chenyu 
