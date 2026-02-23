Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE18633B6C6;
	Mon, 23 Feb 2026 18:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771870416; cv=none; b=HPh77ZnQrKJtB+dEKxKqEArNUJDkv6H2gWeLYdJU6x/higwdoHmOAP2UdcDBy05du3++IkCvaBYcYROq5rWtEW3WxdvB664Y/xSsWgBFnil/Hagqd9tEgOO3VJm4JuSVYLXNicXzB8vGyg0bk3G5j/X2NAA1DFjo0o0yMQJ3Vww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771870416; c=relaxed/simple;
	bh=pQshwKNqTCLj/FvhtbZgOYNC+VNMTBvEaSSSD2wSuHE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FUNKekZcaawKTkkvlGJ4KUBkwnPL+kCnKJOcW4U4v/6WuFGf04iVGGts+kU+vRH5sA7Zw3qBj2YtjUtOG9PfeyHnDpFZq7e4713IDs4Sx8ebL0eQvoK5XDfIU+jbIibNZRLegEkwYlcQeXkk4njP5eIWgOoUtqI4VEThmTp/qqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=B3HQ7V1C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="B3HQ7V1C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378FAC116C6;
	Mon, 23 Feb 2026 18:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1771870416;
	bh=pQshwKNqTCLj/FvhtbZgOYNC+VNMTBvEaSSSD2wSuHE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B3HQ7V1CoKgaBIoteEnZFo//C1eOjQmBzA363dlSZJSPGnKwrPagzWWRWHEyGkx/1
	 6MhwDWWeaCOz0KllZsOTIWSRv2FTaTTuUgO3maOmVNlVD3xKMqbal2bskvscPZ+Bhx
	 31nhkKYtbH0jAtANiQoO7gCBg3ymcBqFZCfessdQ=
Date: Mon, 23 Feb 2026 10:13:35 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, linux-s390@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org
Subject: Re: [PATCH 1/4] mm/page_table_check: Pass mm_struct to
 pxx_user_accessible_page()
Message-Id: <20260223101335.aa3696d86341260e03989ac0@linux-foundation.org>
In-Reply-To: <68c2f6df2955033cbf1ccbd2b5c2816e72ac345c.1771845678.git.agordeev@linux.ibm.com>
References: <cover.1771845678.git.agordeev@linux.ibm.com>
	<68c2f6df2955033cbf1ccbd2b5c2816e72ac345c.1771845678.git.agordeev@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Feb 2026 12:53:13 +0100 Alexander Gordeev <agordeev@linux.ibm.com> wrote:

> From: Tobias Huschle <huschle@linux.ibm.com>
> 
> Unlike other architectures, s390 does not have means to
> distinguish kernel vs user page table entries - neither
> an entry itself, nor the address could be used for that.
> It is only the mm_struct that indicates whether an entry
> in question is mapped to a user space. So pass mm_struct
> to pxx_user_accessible_page() callbacks.
> 
> ...
>
>  arch/arm64/include/asm/pgtable.h |  6 +++---
>  arch/riscv/include/asm/pgtable.h |  6 +++---
>  arch/x86/include/asm/pgtable.h   |  6 +++---
>  mm/page_table_check.c            | 15 ++++++---------
>  4 files changed, 15 insertions(+), 18 deletions(-)

Reviewed-by: Andrew Morton <akpm@linux-foundation.org>

I assume this can go into the s390 tree?
