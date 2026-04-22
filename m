Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B543C371CE3;
	Wed, 22 Apr 2026 21:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776893404; cv=none; b=lF4/OmToILHsqZaxOCZJOUrzpoHI2eJo2lR9zy7jBlHmDdcYQhEIHtwBey5qXKHq+bbf3W2DII6OMRmjtrqoWVD5PLIPxnTdi5zMbfuhBbneAYDH/4d5vR8K/3TqlcixvqVDZv+Ase3LYesgzoT7hHa94UaZc/ww+J85KRmWi8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776893404; c=relaxed/simple;
	bh=nCfpV38tDkErq2dm4COGsVUfPvmgJ2mgmn7P1SLsF2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jRiaGznUP5q7StbaZOK8D2tE9A2Q7U5OkREL6i4lSUmvdjmqi9YE1KvEjOnV+w38+pvpcCYPunBYCLxOdCfYxcDPw96DFeUgMe8VgtC2Vy3po7dipDISfGE0AGnDArRrxQKWoSTQHwZWnOnmIYebPcA33IW9+65gRVClt1F0OSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E88EDC19425;
	Wed, 22 Apr 2026 21:29:57 +0000 (UTC)
Message-ID: <92be54eb-b28c-474d-a107-bdb8c6c69820@linux-m68k.org>
Date: Thu, 23 Apr 2026 07:29:54 +1000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 10/19] mm: remove arch
 vma_alloc_zeroed_movable_folio overrides
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
 Brendan Jackman <jackmanb@google.com>, Michal Hocko <mhocko@suse.com>,
 Suren Baghdasaryan <surenb@google.com>, Jason Wang <jasowang@redhat.com>,
 Andrea Arcangeli <aarcange@redhat.com>, Gregory Price <gourry@gourry.net>,
 linux-mm@kvack.org, virtualization@lists.linux.dev,
 Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-alpha@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-s390@vger.kernel.org
References: <cover.1776808209.git.mst@redhat.com>
 <006f9142e591ba8c340c3b354aee76aec5c285b9.1776808210.git.mst@redhat.com>
Content-Language: en-US
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <006f9142e591ba8c340c3b354aee76aec5c285b9.1776808210.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/4/26 08:01, Michael S. Tsirkin wrote:
> Now that the generic vma_alloc_zeroed_movable_folio() uses
> __GFP_ZERO, the arch-specific macros on alpha, m68k, s390, and
> x86 that did the same thing are redundant.  Remove them.
> 
> arm64 is not affected: it has a real function override that
> handles MTE tag zeroing, not just __GFP_ZERO.
> 
> Suggested-by: David Hildenbrand <david@kernel.org>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   arch/alpha/include/asm/page.h   | 3 ---
>   arch/m68k/include/asm/page_no.h | 3 ---

For arch/m68k/include/asm/page_no.h:

Acked-by: Greg Ungerer <gerg@linux-m68k.org>


