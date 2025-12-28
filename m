Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBF4289824;
	Sun, 28 Dec 2025 22:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766961335; cv=none; b=BMh2C0btJlwRG/YinHy4IzmMc/pvyhot0shjsWilNfrZd+TXs6vXfPzUtNrZSAB0trkiXlnILBNcnx/fCiDp1LgQ1UDilfC+IMBp3fRMc3G1e1jUc5PFGMtd2wCocfbmocdIYQQaYYL3enxQAakl5GJ75FHtOVcppecplZEbaUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766961335; c=relaxed/simple;
	bh=CCaq+l+K6wsYD/FHpHvOEK+EvLHkFgdijLHqm1YV+20=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HU4Y/4O9RtM0N7FR1Mf10DSG1DXZGowNw4zSKYlQlf8oE+sPJEUidreQiMabezxwMvUeZTTnhfSf9rtjxmoqOa3LH8Bq1KnxOElnp07xsX/OdbHAD0+Xkkj8Dox4GBf1v1bUzttWCB2Vz8ufaZam4RVS1tuA9BdJ7aQR0a/f+/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=nOPuJZfl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="nOPuJZfl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A93BC4CEFB;
	Sun, 28 Dec 2025 22:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1766961335;
	bh=CCaq+l+K6wsYD/FHpHvOEK+EvLHkFgdijLHqm1YV+20=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nOPuJZfl2av023bRQoktGLNCM+COk5pIMCL3h5ynU6rPF27c4c3qUu5AOfYvG7vuD
	 XUd0EqFI/LwVzvFi4U2RqsdgzyWfl4udZmt5/fIM8f5wWAzzZTy33cyo/WkHWrmA3m
	 dygVpmyLfSYEdyA81KLsG4iO0eh6iw9YBanxpO3E=
Date: Sun, 28 Dec 2025 14:35:33 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Heiko Carstens <hca@linux.ibm.com>,
 Ingo Molnar <mingo@redhat.com>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
 Vasily Gorbik <gor@linux.ibm.com>, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, x86@kernel.org,
 linux-riscv@lists.infradead.org, "David Hildenbrand (Red Hat)"
 <david@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: Re: [PATCH v7] mm/hugetlb: ignore hugepage kernel args if hugepages
 are unsupported
Message-Id: <20251228143533.33e2be2d6282d036f55e12cb@linux-foundation.org>
In-Reply-To: <20251224115524.1272010-1-sourabhjain@linux.ibm.com>
References: <20251224115524.1272010-1-sourabhjain@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Dec 2025 17:25:24 +0530 Sourabh Jain <sourabhjain@linux.ibm.com> wrote:

> Note for backporting: This fix is a partial retrieval of the commit
> mentioned in the Fixes tag. It is only valid once the change referenced
> by the Depends-on tag is present. When backporting this patch, the
> commit mentioned in the Depends-on tag must be included first.
> 
> Link: https://lore.kernel.org/all/20250121150419.1342794-1-sourabhjain@linux.ibm.com/ [1]
> Link: https://lore.kernel.org/all/20250128043358.163372-1-sourabhjain@linux.ibm.com/ [2]
> Fixes: c2833a5bf75b ("hugetlbfs: fix changes to command line processing")
> Depends-on: 2354ad252b66 ("powerpc/mm: Update default hugetlb size early")

This will be the first "Depends-on:" in history.  Which is a hint that
we're doing something wrong.  This innovation will surely fool any
downstream automation.  Let's use existing tools if possible.

What if we just said "Fixes: 2354ad252b66"?  That would tell people
that 2354ad252b66 is required for use of this patch.

Is there any kernel which has 2354ad252b66 but which doesn't have
c2833a5bf75b?  Probably there is, as neither had cc:stable.

2354ad252b66 is from 2020 and c2833a5bf75b is from 2022.  I'm thinking
the reliable thing to do here is to simply use Fixes:c2833a5bf75b. 
This will tell the world "please add this patch to any kernel which
contains c2833a5bf75b", which I suspect will be good enough?
