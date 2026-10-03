Received: from mta1.migadu.com (out-39.mta1.migadu.com [95.215.58.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319F2346ADC
	for <linux-s390@vger.kernel.org>; Sat,  3 Oct 2026 08:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791016030; cv=none; b=K5/LWXpaVHTulaZVScbY3jG8rgk9dk/eCACZzbj+n+I98PrDroEVfltGiHqch4xrTo1MzWPkO1Relx3WLpvb1CJ8GV41M1QjydW9a3IKmiV79IhPqCF2DUWle2loLTl7/y9LYgPYp7Mreog2gvLSI1J7/y8xM5q3pSBnfBr3YOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791016030; c=relaxed/simple;
	bh=qTDcL7ZGZXpqyBImCymnV5HwYb1medCgU94t18ZKIYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0NvhhFFiYWxrcExlZ+81E+9iZmoy/RAzzaxYuhCkO8B3cIopFXhzcDJfusjKMXABFzgH2JIJvd8L5KOFhQPKbXgoxTYCk0m3ff3XbklNJ6Jp/zxIqQb8gw5IQ3QZjt07eMstYteO3zt4lWWTyKp+s9GA+E2sHs4CvHQsCYhSgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ro55FjU9; arc=none smtp.client-ip=95.215.58.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ro55FjU9"
X-Envelope-To: linux-s390@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=qTDcL7ZGZXpqyBImCymnV5HwYb1medCgU94t18ZKIYQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791016026; v=1; x=1791620826;
 b=Ro55FjU9eeo2D0bxe928BZCuk86eYPwp0remRwVEfjL0NlyNiE4s4ulIYkAixtuXqZL2bHsa
 C5WpIBwuwX8NKmOvjiYIHOkaDBbncws84vHuePqLEFtzNJC08iR9CWU9nWbs0aAF9mUsoDfmCB7
 RO2dMmIBMa9CdeufPMzClmK4=
X-Envelope-To: linux-s390@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2a8746d844f124a8;
	Sat, 03 Oct 2026 08:27:05 +0000
X-Mizu-Trace-ID: 2a8746d844f124a8
X-Migadu-Flow: FLOW_OUT
Date: Sat, 3 Oct 2026 16:27:26 +0800
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
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH v3 09/13] x86/cpu/topology: Initialize sbm topology
 after topology parsing
Message-ID: <asC8bgvYsVkkcVlO@three-body>
References: <20261001192849.74788-1-kprateek.nayak@amd.com>
 <20261001192849.74788-10-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001192849.74788-10-kprateek.nayak@amd.com>

Hello Prateek,

On Thu, Oct 01, 2026 at 07:28:45PM +0000, K Prateek Nayak wrote:

[ snip ]

> +static __init void init_sbm_topology(u32 max_apicid)
> +{
> +	u32 sbm_shift = x86_topo_system.dom_shifts[TOPO_DIE_DOMAIN] - 1;

As sashiko reported, and also mentioned here:
https://lore.kernel.org/lkml/20260510155920.2587431-2-yu.c.chen@intel.com/
Maybe x86_topo_system.dom_shifts[TOPO_DIE_DOMAIN - 1] ?

> +	int num_sbm_instances, max_threads_per_instance;
> +
> +	/*
> +	 * On Intel systems, memory controllers are present at TOPO_DIE_DOMAIN.
> +	 * On newer AMD and Hygon systems, LLC is at TOPO_TILE_DOMAIN so use
> +	 * that instead.
> +	 */
> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
> +	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
> +		sbm_shift = x86_topo_system.dom_shifts[TOPO_TILE_DOMAIN] - 1;

Ditto.

thanks,
Chenyu
