Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A8637C90D;
	Tue, 31 Mar 2026 18:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774981764; cv=none; b=Lfevhil0njSI3CppK7x5Povg+AnjG3s17TfH1PHoveBOencMxQj9oVVP/rTp08GjKt3qN8zkjv4QpswvumplbT1y++ca8MJUMZsCJ9/PSl0riBH6cunfewr/JVG6xkLZUoDiuMcxfteDqCaHeYV5shSfUwPgnjcYAHq2Ax+YTyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774981764; c=relaxed/simple;
	bh=F+p+n3x+VzyufNJY9nXy/ifCuLJFzInK3nA+2woKvxI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Ee40sRn9y1iNh96eI8ipbHqiJOeDR/sRb/K0n9GxFBYnJaBDpseF+jWDMteFUPNEwdKyLX0OSM38FN2FYf0wqmcIRN5/pMifhtyDhVnEk4Co1HtcWouZT8TESD5JmB+LGhglsqotUfOxKelEJeT0+aN7D8VLmzB9HHFLElW1c2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=psWL4NZu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="psWL4NZu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF9FC19423;
	Tue, 31 Mar 2026 18:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774981763;
	bh=F+p+n3x+VzyufNJY9nXy/ifCuLJFzInK3nA+2woKvxI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=psWL4NZu9ag0FPb5FMERi89uk3vAYSdwJ6Jr11ixC6/8u6RxEisHJvG4oMZ0ss1wa
	 h0dqxH5s2StJz2k2ac1CKvcdQ53N1oEowBsSLP/n5D8dDYwwFkfqAo6gZliPYRZnJi
	 fs/N0xEVjUD6NdlZrzBZLQz+El5FY7Bxd/dn0oVM=
Date: Tue, 31 Mar 2026 11:29:21 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>, willy@infradead.org,
 david@kernel.org, ziy@nvidia.com, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
 gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 lance.yang@linux.dev, vbabka@suse.cz, jannh@google.com, rppt@kernel.org,
 mhocko@suse.com, pfalcato@suse.de, kees@kernel.org, maddy@linux.ibm.com,
 npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org,
 borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v6 2/6] mm: use vma_start_write_killable() in mm
 syscalls
Message-Id: <20260331112921.854d4f6cc793dba0972ee9f1@linux-foundation.org>
In-Reply-To: <CAJuCfpE5w8r_6Ss=5ZPrEb1RQOTG6HyY8Pivac=iiyqFRZvD4g@mail.gmail.com>
References: <20260327205457.604224-1-surenb@google.com>
	<20260327205457.604224-3-surenb@google.com>
	<5d90d998-9b8d-435c-b684-260600311797@lucifer.local>
	<CAJuCfpE5w8r_6Ss=5ZPrEb1RQOTG6HyY8Pivac=iiyqFRZvD4g@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 31 Mar 2026 08:01:11 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> > Instead? That is, assuming we really need to care about this at all.
> >
> > But I think I don't like this change at all?
> 
> Yeah, this was the part I wasn't sure if it's worth adding. With your
> vote confirming my scepticism I'll go ahead and remove the parts I
> added to avoid extra vma_start_write_killable() call (3 instances in
> all) and will post v7.

Thanks.  I'll remove v6 from mm.git and shall await Lorenzo's advice on
v7.

