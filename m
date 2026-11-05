Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793869530;
	b=t/kHkqAzRVHBXJK9Ac+0Iqp0vBAgLB76dWvIQeZPMIXH9qLRIub4LwAMoRAR/3WDtURd
	 UDfU10hTj5MlhmvlCGp4sMlvdKaeq9R9iFYj8GS/Fp0c4ZyBFHReC3PgFaXv5cp70YT3G
	 g2VpIFzBLFdps8rYAy8tu5zGp7mZvf85JE9JgaKACMU0ekoevk+apRwe0Ksv5eJxewpez
	 yDJu5rjbBav6LdN5IWEyKPZUbsayF5Ct7ERoaYQDDtlCH4O9M+6GG4aE3G2Qz3WwVBQyA
	 fFL8mFdANIPGDl1nBCwRF2oJYZ59P9P6fzbFaFzbpo+VwCx8xPLxLbTJRGFXdUxRlrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793869530;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tyXT3V1giPULzTli43gvYizMlTh6ps7zNGmY3FWZQOM=;
	b=RDbplUj/tMjDkUf1Q4QuNuqpb3f9/I+hJBejRRunKegZk5P0hTpxpQRJCkie2ZrSOdgA
	 V0mwnKPzPCA1/A+XpovxqBq62/aiGl9Jjs6KDPeAQeRWTfqUaKFGHFo9AJaiV3vzrjIY1
	 5TOPlwxCaDEtz+ZXM6mHwVBDZtdHwDQlzRL2gfZ3L7BFy16kkknX3+VBkHGo9c4SAzHfU
	 /Q2nXB8E4QMBhTcDv6oYVmfSb5FanYXK714cf0RtdOqyE2br0LX1tAS3qW8Py41dSebsD
	 knNNtSCF9Ly3vpGLXTBPFV9kIccrWktgUUtRQmZgjXEdvfCwd9aGCydefJwH3Alt7Rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qY34eDtB;
	arc=none smtp.remote-ip=95.215.58.71
Received: from mta1.migadu.com (out-71.mta1.migadu.com [95.215.58.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65018606A329
	for <linux-s390@vger.kernel.org>; Thu,  5 Nov 2026 09:05:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65018606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qY34eDtB
X-Envelope-To: linux-s390@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=UGrLw7tJ8SzIUnajBIKmwWZs/FFny8I1ZQMJWZrsm+Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793869527; v=1; x=1794474327;
 b=qY34eDtBCoilLCZIJiq80fsu1gPfsFBQG27FvmZzI06rKmYEiwavIahg8NOvEwSj3tg5Hh2g
 1UHGG2IiHA/Mwdk4fmOVCpjSta3Zr4PlY3wdjlWycjT81xSV7bp+rzOWvMFYde8KO/DlikGlATn
 +qZE51nysgXk2Mb/XVPiF2uI=
X-Envelope-To: linux-s390@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 8f2b4df41c8b103c;
	Thu, 05 Nov 2026 09:05:17 +0000
X-Mizu-Trace-ID: 8f2b4df41c8b103c
X-Migadu-Flow: FLOW_OUT
From: Fushuai Wang <fushuai.wang@linux.dev>
To: ynorov@nvidia.com
Cc: agordeev@linux.ibm.com,
	arighi@nvidia.com,
	borntraeger@linux.ibm.com,
	bsegall@google.com,
	corbet@lwn.net,
	dakr@kernel.org,
	dietmar.eggemann@arm.com,
	driver-core@lists.linux.dev,
	gor@linux.ibm.com,
	gregkh@linuxfoundation.org,
	hca@linux.ibm.com,
	johan@kernel.org,
	juri.lelli@redhat.com,
	kprateek.nayak@amd.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux@rasmusvillemoes.dk,
	meted@linux.ibm.com,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	rafael@kernel.org,
	rdunlap@infradead.org,
	rostedt@goodmis.org,
	skhan@linuxfoundation.org,
	sshegde@linux.ibm.com,
	svens@linux.ibm.com,
	tglx@kernel.org,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	yury.norov@gmail.com
Subject: Re: [PATCH 3/6] sched: Restore preferred CPUs when hotplug removes the last one
Date: Thu,  5 Nov 2026 17:05:05 +0800
Message-Id: <20261105090505.93940-1-fushuai.wang@linux.dev>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20261101192203.6979-4-ynorov@nvidia.com>
References: <20261101192203.6979-4-ynorov@nvidia.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 04b62c16fa8c..98f4f9434965 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8712,6 +8712,14 @@ int sched_cpu_deactivate(unsigned int cpu)
>  
>  	set_cpu_active(cpu, false);
>  
> +#ifdef CONFIG_PREFERRED_CPU
> +	if (cpumask_empty(cpu_preferred_mask)) {
> +		pr_notice("sched: last preferred CPU%u offlined; make all active CPUs preferred\n",
> +			  cpu);
> +		reset_preferred_cpumask();

Hi, Yury

If the CPU being offlined is the only preferred CPU, after
reset_preferred_cpumask(), the steal governor may still need
some time to tighten the mask again, and eventually only one
preferred CPU may remain. Would this introduce additional
task migration overhead?

Regards,
Fushuai.
> +	}
> +#endif
> +
>  	/*
>  	 * From this point forward, this CPU will refuse to run any task that
>  	 * is not: migrate_disable() or KTHREAD_IS_PER_CPU, and will actively
