Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FAA27EFFA;
	Tue, 28 Oct 2025 21:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761688416; cv=none; b=D4RFoLPqPPd2cpwR2iWd+p87dB0IIwIxIxBELpqcxsAz+OhDR83OIbHxM49jU3iFOu45v6AH7O483I/9ZZUKXVofK2hUGFPEynMsd22lAumLBfq/G6udHDR1lvzUKGmxPS/k+nln/961XzBH0dZEtVWmjRhuCmK+38rAXLFTGqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761688416; c=relaxed/simple;
	bh=JPCaK8/B5tsYDz94pQe8nGhHm3auqtQ3gChlHg2P/bM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cUyCYSeKqRE+sg8mjvnsRHeCwD7ke+n1d3pmZLFKAdBucggnZfEalxdhOTk628bqCMg3uhMb+YkFRNJx0+8WmQ2NVOvWhlI+XbWjhomAct9vy+C8b2KF8ZjpOUlJR53/niihRnM3nFOKOGHdLNkJqubo3gOyXVjDGUPixH4TV04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=jUDfUc7m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="jUDfUc7m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86EE0C4CEE7;
	Tue, 28 Oct 2025 21:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1761688416;
	bh=JPCaK8/B5tsYDz94pQe8nGhHm3auqtQ3gChlHg2P/bM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jUDfUc7mEFZUX45qomM6RsYqoM/5CDi75b7/yyE4Z73kJovnvDmd/C8y4u1uj24dF
	 ipBJjGLGPtR53JWmGj6U0tOIvgXHUDnwdse8EQsjVQofHFVhizI4f1CQnepNrgthao
	 2O7U1frt90PzjaFvpfA68R420ut+CTY5fKNVrsy8=
Date: Tue, 28 Oct 2025 14:53:34 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Luiz Capitulino <luizcap@redhat.com>
Cc: hca@linux.ibm.com, borntraeger@linux.ibm.com, joao.m.martins@oracle.com,
 mike.kravetz@oracle.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-s390@vger.kernel.org, gor@linux.ibm.com,
 gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com, osalvador@suse.de,
 david@redhat.com, aneesh.kumar@kernel.org
Subject: Re: [PATCH v2] s390: fix HugeTLB vmemmap optimization crash
Message-Id: <20251028145334.5a97211e0e46ca42fe2fa0d0@linux-foundation.org>
In-Reply-To: <20251028211533.47694-1-luizcap@redhat.com>
References: <20251028211533.47694-1-luizcap@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Oct 2025 17:15:33 -0400 Luiz Capitulino <luizcap@redhat.com> wrote:

> A reproducible crash occurs when enabling HugeTLB vmemmap optimization (HVO)
> on s390. The crash and the proposed fix were worked on an s390 KVM guest
> running on an older hypervisor, as I don't have access to an LPAR. However,
> the same issue should occur on bare-metal.
> 
> Reproducer (it may take a few runs to trigger):
> 
>  # sysctl vm.hugetlb_optimize_vmemmap=1
>  # echo 1 > /proc/sys/vm/nr_hugepages
>  # echo 0 > /proc/sys/vm/nr_hugepages
> 
> ...
> 
> This commit fixes this by implementing flush_tlb_all() on s390 as an
> alias to __tlb_flush_global(). This should cause a flush on all TLB
> entries on all CPUs as expected by the flush_tlb_all() semantics.
> 
> ...
>
>  arch/s390/include/asm/tlbflush.h | 6 +++++-

Thanks, I'll add this to mm.git.  If s390 people prefer to merge it
(or nack it!) then please do so and I'll drop the mm.git copy.

