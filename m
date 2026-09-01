Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF683859E0;
	Tue,  1 Sep 2026 01:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788227747; cv=none; b=k37J+a8E3fcBplODf6Wj+RHeg2c4XyCHg1hkguuvCTmXRzkFuKwtlxG0Bv1ed6K8uA9aRWrULZJnOR8uW9RFSrNb6T6kY3u9YVw28aN3+K7SjEVx9qQ5UbCOkAb4oOBBbGl9xZQXXq+RgIW4OZUrRZHghUWFl9cT6j2+MEso5NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788227747; c=relaxed/simple;
	bh=D/eLKeXLpb9WCMIkK1oeyklyzAhsuCgiSxzpV5PyWxI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KkFMrFkYXvsPGV1OLMn9/AOU0jPjDDYupSpfXdcV+Yu8VNT5LFwChz/IA9bIsnQ6D+oFreEUJcLKI9Q8qxUqoL+kNQUt2sna4I1SX9LzgCejrOqP/zys3EXBb2AnXqrWywuuhwJRXHnxrt7AOVKV9q837qjvc9SlX7zW/Q39H/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QTvMOsLY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QTvMOsLY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FF81F000E9;
	Tue,  1 Sep 2026 01:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1788227720;
	bh=CbUFClJ4i3J7LjCwTB/35AHxIba4ym0JuMW7MLg9RkU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QTvMOsLY/HyZChL07OeBST7evAmOyQDdqEsNG8IojIx94RZcYBwP8DgxztrD6FxPx
	 UxNXGzD1L06crgm/t6O7u1Azv9jZngQt1/ls6DYB8X15tavuE8dNV9b/ojCvXtSt3F
	 /qmxq+B/hEDiFvYVf1+pwfxpoT/BJ9uJYAxsblw0=
Date: Mon, 31 Aug 2026 18:55:19 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, samuel.holland@sifive.com, David Hildenbrand
 <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, Lorenzo Stoakes
 <ljs@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] mm: Drop pxd_ERROR()
Message-Id: <20260831185519.66c6e6e83ce62d0fd9aee945@linux-foundation.org>
In-Reply-To: <20260831054331.625505-1-anshuman.khandual@arm.com>
References: <20260831054331.625505-1-anshuman.khandual@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 11:13:22 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:

> pxd_ERROR() macros have been provided by all platforms, which are very much
> identical and can be dropped off completely if these pgtable printing could
> be moved to callers in generic MM aka all pxd_clear_bad().
> 
> But first cleanups and re-organizations are required in some platforms that
> are using these macros internally. Afterwards [pte|pmd|pud|p4d|pgd]_ERROR()
> macros have been completely dropped from the entire tree.

All was going nicely until...

> This series is based on v7.3-rc1 after the following patch and has also been
> built tested on multiple platforms.

*what* following patch???

Oh well, I'll queue it all up and shall hope for the arch maintainer
acks to roll in.  Please.
