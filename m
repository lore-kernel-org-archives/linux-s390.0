Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD3019644B;
	Fri, 12 Sep 2025 23:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757718761; cv=none; b=uQKiGzGnmEocJetkdBtPUhr1mcSMDOPBwbN0a4A3jMB2cwbKr9EgM465L7gzsuBgyVKZoduHqNtzK1e038Q3xFhtG3yo7Bh6DrgZlT1qOmtG1pWll3Aj82zayRsd1CSnVA/PM4UITECtsVOyXfEMaGuffSs3nMrKLdH8XtKXyvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757718761; c=relaxed/simple;
	bh=thLvIl+wvhNHd/h+/PMgcFZYDNKs/se5pXZ8NvBGink=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZDWeopZExbtgmHnx9f+60pOZyCrVq5K5gnGSGwLXL/3crPq275YmIWPtOxxTXaZXjk4VpN0lSe9PZpAaNYGXl/0KKkOQLbySvTWHbqiNXBPJtPWLUJ+dTC6riTD3qIvj1oE7kNUdQ/ORNYTqzZ0meLbwhFy+XYBS6nbJIaQ5YFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=uPvN51zy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="uPvN51zy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0316C4CEF1;
	Fri, 12 Sep 2025 23:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1757718761;
	bh=thLvIl+wvhNHd/h+/PMgcFZYDNKs/se5pXZ8NvBGink=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uPvN51zyf0Gk16PKadXMueozooisxs0w/wRwX29tBoqJBTo4x5gLEZpsOMl3SAiZ8
	 toWs4v4s+Isvs0SZ9f6cZt+BntkInj1O5MG9ejH/dcfWaJNIEJiJCuhLdTEqG5LxpN
	 hvsFbObfpXYXO9VjF+Ym6Y3HlQutUmpGWu0QAL64=
Date: Fri, 12 Sep 2025 16:12:40 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, kasan-dev
 <kasan-dev@googlegroups.com>, linux-mm <linux-mm@kvack.org>, open list
 <linux-kernel@vger.kernel.org>, linux-riscv
 <linux-riscv@lists.infradead.org>, linux-s390@vger.kernel.org,
 lkft-triage@lists.linaro.org, Linux Regressions
 <regressions@lists.linux.dev>, Andrew Morton <akpm@linuxfoundation.org>,
 Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Ryabinin
 <ryabinin.a.a@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>, Arnd
 Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>, Ben
 Copeland <benjamin.copeland@linaro.org>
Subject: Re: next-20250912: riscv: s390: mm/kasan/shadow.c
 'kasan_populate_vmalloc_pte' pgtable.h:247:41: error: statement with no
 effect [-Werror=unused-value]
Message-Id: <20250912161240.0a5fac78fed5ed8ddc32450a@linux-foundation.org>
In-Reply-To: <d7a03a2b-d950-4645-80f2-63830bd84f76@redhat.com>
References: <CA+G9fYvQekqNdZpOeibBf0DZNjqR+ZGHRw1yHq6uh0OROZ9sRw@mail.gmail.com>
	<d7a03a2b-d950-4645-80f2-63830bd84f76@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Sep 2025 13:34:37 +0200 David Hildenbrand <david@redhat.com> wrote:

> > [-Werror=unused-value]
> >    247 | #define arch_enter_lazy_mmu_mode()      (LAZY_MMU_DEFAULT)
> >        |                                         ^
> > mm/kasan/shadow.c:322:9: note: in expansion of macro 'arch_enter_lazy_mmu_mode'
> >    322 |         arch_enter_lazy_mmu_mode();
> >        |         ^~~~~~~~~~~~~~~~~~~~~~~~
> > mm/kasan/shadow.c: In function 'kasan_depopulate_vmalloc_pte':
> > include/linux/pgtable.h:247:41: error: statement with no effect
> > [-Werror=unused-value]
> >    247 | #define arch_enter_lazy_mmu_mode()      (LAZY_MMU_DEFAULT)
> >        |                                         ^
> > mm/kasan/shadow.c:497:9: note: in expansion of macro 'arch_enter_lazy_mmu_mode'
> >    497 |         arch_enter_lazy_mmu_mode();
> >        |         ^~~~~~~~~~~~~~~~~~~~~~~~
> > cc1: all warnings being treated as errors
> > 
> 
> 
> I'm afraid these changes landed in -mm-unstable a bit too early.
> 

OK, I'll drop Patch series "Nesting support for lazy MMU mode", v2.

