Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC8C1D5ADE;
	Thu, 10 Apr 2025 22:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744325266; cv=none; b=YzxZ5U3ZmsbvVg3VwzU/NJYUQ9plyNhtqCtsphuhv8RNoG94QdnXkH++LwEJaQkDUpBbKqDIPo3Go4kZyygW2lRSzW3xf42v1KMbVdenI2tJbzRck8TN/MBGXasKJgQOR4eJ4vOKW1vFquPUems1cwqXsr5LHko9N41APqc1SAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744325266; c=relaxed/simple;
	bh=1tnfPuvkdBHhkMd126G0IxK9k3gsj3KHkqYbgp6rqwk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=t9VJB7dKsIqJ0fR3u5VO/GgfvMZXiTtgIulRHQBTRfTcBkvvq1B3VBSO1sWk60QvWpneBY3h4QknNWYr9lU0lHrf/rqu6IX7NDuA276YqQjhgrRA/6OENHkz6qYaqBiH0RN+cxlCIPmee0BamBXER1ak9ibAwwVjmn3NdsmOaUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=e6xef16q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="e6xef16q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72DF3C4CEDD;
	Thu, 10 Apr 2025 22:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1744325266;
	bh=1tnfPuvkdBHhkMd126G0IxK9k3gsj3KHkqYbgp6rqwk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e6xef16qlSCuaWmvesXMrxudpX3PdJoqdNQrXzsVNJrRRrc/hIgkchadNM34Ppb4j
	 YRP22ogIXwogTnAqDkh7D1n1YtKcQftorM0XAqg0S2/V4Yun6qCg+vGECTW9UKKua2
	 l9Tu9D3P64Os0dK/iz7clScFQuOJTR8wIZOF5Qj8=
Date: Thu, 10 Apr 2025 15:47:44 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Hugh Dickins
 <hughd@google.com>, Nicholas Piggin <npiggin@gmail.com>, Guenter Roeck
 <linux@roeck-us.net>, Juergen Gross <jgross@suse.com>, Jeremy Fitzhardinge
 <jeremy@goop.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kasan-dev@googlegroups.com, sparclinux@vger.kernel.org,
 xen-devel@lists.xenproject.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 3/3] mm: Protect kernel pgtables in
 apply_to_pte_range()
Message-Id: <20250410154744.44991b2abe5f842e34320917@linux-foundation.org>
In-Reply-To: <Z/fauW5hDSt+ciwr@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <cover.1744128123.git.agordeev@linux.ibm.com>
	<ef8f6538b83b7fc3372602f90375348f9b4f3596.1744128123.git.agordeev@linux.ibm.com>
	<Z/fauW5hDSt+ciwr@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Apr 2025 16:50:33 +0200 Alexander Gordeev <agordeev@linux.ibm.com> wrote:

> On Tue, Apr 08, 2025 at 06:07:32PM +0200, Alexander Gordeev wrote:
> 
> Hi Andrew,
> 
> > The lazy MMU mode can only be entered and left under the protection
> > of the page table locks for all page tables which may be modified.
> 
> Heiko Carstens noticed that the above claim is not valid, since
> v6.15-rc1 commit 691ee97e1a9d ("mm: fix lazy mmu docs and usage"),
> which restates it to:
> 
> "In the general case, no lock is guaranteed to be held between entry and exit
> of the lazy mode. So the implementation must assume preemption may be enabled"
> 
> That effectively invalidates this patch, so it needs to be dropped.
> 
> Patch 2 still could be fine, except -stable and Fixes tags and it does
> not need to aim 6.15-rcX. Do you want me to repost it?

I dropped the whole series - let's start again.
