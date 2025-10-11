Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A757F2AD3E;
	Sat, 11 Oct 2025 18:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760208267; cv=none; b=COiyrRwo6GPTIYf72rPM4MHOVIhHfDJ3wsIrMNvrASg6TAsFel6QysIBggfiduhdifwTeBEic5HBC6RJW84r0ulmYSxOprIQpDNQg2yhTrMTU2EVc5J9AF40fOkLuZOmJHapOfvgu6a84H9Dc6nfg2kj9QyTR0cDs5Mn+hS13Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760208267; c=relaxed/simple;
	bh=1p8xeKkByaFAhzoZotQIc5TBKhsxRGdNh53mRIgRCcY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Sjvw6bGjuuBF/7y8CU0t95TVyjS6jzkb+3udm36TbL9mxy+0pwQFCEZzZ7fRBAnE1QwuU0Xt1tBB1Df6xyLETtFIsqPxc/Ryzr/1X0ZBbFKjfo03zBPrTGGVtxpPadeG30MQYQppJrc5mo1hqxX1tY6fWENLN2qPYUvZPuWp6TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=zFYmH1VC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="zFYmH1VC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23738C4CEF4;
	Sat, 11 Oct 2025 18:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1760208267;
	bh=1p8xeKkByaFAhzoZotQIc5TBKhsxRGdNh53mRIgRCcY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=zFYmH1VCQ/IBqhPNUa6SXH6vlSm9qm7zALTXxZycHwKXH8zMFEqqzNZsDPcJlBmIo
	 36bmMJbb6vw6mmTeR/OIryN3IU5jInqbZQWf9gEp3myog6tlv+X2nAu4zkPAVOgxCX
	 yqN2HWe7/17Of/QgMGb0aprUKGer7RSAQeurSMWA=
Date: Sat, 11 Oct 2025 11:44:26 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-s390
 <linux-s390@vger.kernel.org>, Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v3 0/4] Support dynamic (de)configuration of memory
Message-Id: <20251011114426.5313b7cb6951618c20ab62ca@linux-foundation.org>
In-Reply-To: <20251010085147.2175918-1-sumanthk@linux.ibm.com>
References: <20251010085147.2175918-1-sumanthk@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Oct 2025 10:51:43 +0200 Sumanth Korikkar <sumanthk@linux.ibm.com> wrote:

> Hi,
> 
> Patchset provides a new interface for dynamic configuration and
> deconfiguration of hotplug memory on s390, allowing with/without
> memmap_on_memory support. It is a follow up on the discussion with David
> when introducing memmap_on_memory support for s390 and support dynamic
> (de)configuration of memory:
> 
> ...
>
>  arch/s390/mm/pgalloc.c         |   2 +
>  arch/s390/mm/vmem.c            |  21 +--
>  drivers/base/memory.c          |  23 +--
>  drivers/s390/char/sclp_mem.c   | 288 +++++++++++++++++++++++----------
>  include/linux/memory.h         |   9 --
>  include/linux/memory_hotplug.h |  18 +--
>  include/linux/memremap.h       |   1 -
>  mm/memory_hotplug.c            |  17 +-
>  mm/sparse.c                    |   3 +-
>  9 files changed, 225 insertions(+), 157 deletions(-)

I can add this to mm.git in the usual fashion, but the s390 tree would
be a better place from a testing point of view?
