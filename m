Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849602EC081
	for <linux-s390@vger.kernel.org>; Thu,  4 Sep 2025 23:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757030287; cv=none; b=tDsT1PEzt0TTg2VMlPQXsoQR0Chi5Sa0zOyncVFzQZbCFf2dky6+n/temmoDrUYm4v/soMm8dUI/YIeLuC5shm/tKrjji5RmgsxZYKTkfZVLenvhsOpO6W5/OrOigozShuW2Qpx21WOD3BZiZpjSqpJDxpJMKnSQUQnynSbOxpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757030287; c=relaxed/simple;
	bh=LTpvAMDx3l9YQ4vjyMBE5VmJ/wSw9l3B25wX8G92ELE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6iBVg7do5nphz6AHPX+zQ/nj1GYCsfYvXpeIHIEjcdQJQ8R46cw/x+X6e3OdEBlcBu4vd38PHy68172J7qV1xkGyV9bc8+lYgyVEUDOohXqC1im1MFbvgOQzENk6bIbmOZzr49QLa8+xPNuMG78//1RLwBOYOezDB3AuJh9GKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IP0RW6nO; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IP0RW6nO"
Date: Thu, 4 Sep 2025 16:57:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757030273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+1JF9ABm23/crB5M2qXk95TNoGCZqy9JAAct0jdXudM=;
	b=IP0RW6nOGMgFPd9nXUCLLw0ahXL7zYDkVP5hnRPsxGQbC8r6JZ+o1Mki8k8IcUbBMSSfVP
	xY8GEJOkCrT/t5Yv8dVOu0RgPaxIbveuBbRwhK8/wNymTsDGEyJCvlxxw9KVMEtAQMbhqn
	6n6bXsZWN1E+SIRU+boROe3lY/qrCas=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, david@redhat.com, axelrasmussen@google.com, 
	yuanchu@google.com, willy@infradead.org, hughd@google.com, mhocko@suse.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	vishal.moola@gmail.com, linux@armlinux.org.uk, James.Bottomley@hansenpartnership.com, 
	deller@gmx.de, agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com, 
	svens@linux.ibm.com, davem@davemloft.net, andreas@gaisler.com, 
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, chris@zankel.net, 
	jcmvbkbc@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	weixugc@google.com, baolin.wang@linux.alibaba.com, rientjes@google.com, 
	thuth@redhat.com, broonie@kernel.org, osalvador@suse.de, jfalempe@redhat.com, 
	mpe@ellerman.id.au, nysal@linux.ibm.com, linux-arm-kernel@lists.infradead.org, 
	linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 00/12] mm: establish const-correctness for pointer
 parameters
Message-ID: <ue3oriedwzzfhvnobtetuyjvcypbvl4dboqmpvdededzaj3amq@5k6vk44ae3fu>
References: <20250901205021.3573313-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901205021.3573313-1-max.kellermann@ionos.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Sep 01, 2025 at 10:50:09PM +0200, Max Kellermann wrote:
> For improved const-correctness in the low-level memory-management
> subsystem, which provides a basis for further const-ification further
> up the call stack (e.g. filesystems).
> 
> This patch series splitted into smaller patches was initially posted
> as a single large patch:
> 
>  https://lore.kernel.org/lkml/20250827192233.447920-1-max.kellermann@ionos.com/
> 
> I started this work when I tried to constify the Ceph filesystem code,
> but found that to be impossible because many "mm" functions accept
> non-const pointer, even though they modify nothing.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

For the series:

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
