Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52F7259489;
	Fri, 10 Jan 2025 00:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736469797; cv=none; b=tvkB58gg885ScYXtUXTZm7MX9uyeEtiKrYRHJzySRO0Se+bpqSaHmBH8NzRfutzeOG75u7M67AKeltACzvoVmXRRDCFo1U9SKqmrnw/lE4+5wuGJI9UHEHKpQ93bR4xY0xui/j/SQT8wEs32Af1fXCeZJPdG4NefUpAFcLV9enM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736469797; c=relaxed/simple;
	bh=3GLm8hKeYpJFWLTM88qFWeC/Xe6YM0BmZ7p/eyKGnFI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=b/20dqU4x/Ykxfk2NyBkVPmkVXzjXqHaV6iD91limRCFtXJxWPVpIHsa70nrhAKbQYF3OOc+uM54LqBIScQAM2t+DGlGiAgOT0tFIwGGlzxTHIV8jZ2qJnaZTetwjdiHlar34/lEdF56AGnuM7WYCLqS6HRZnF2xwyU0rzq3N2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=F23eFjtG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="F23eFjtG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2576FC4CED2;
	Fri, 10 Jan 2025 00:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1736469796;
	bh=3GLm8hKeYpJFWLTM88qFWeC/Xe6YM0BmZ7p/eyKGnFI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F23eFjtGSMZcN2gyId5EbCf1IAtkUOHHc0uXlmVQKZ6S/ZqxIqlJeylapfnqYBgFr
	 gjIE+w4yYLqeI5X6s5WS9kQZ4uLkN/yLFTHyLl3zN3wL39HhrOckIlLnFYq8LsMxNc
	 eM4PXR7pyS7y9lAg5u7FymkyUiLXWRX3fyWvRrQY=
Date: Thu, 9 Jan 2025 16:43:15 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Weikang Guo <guoweikang.kernel@gmail.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, Mike Rapoport
 <rppt@linux.ibm.com>
Subject: Re: [PATCH] arch/s390: save_area_alloc default failure behavior
 changed to panic
Message-Id: <20250109164315.b21f40e1b757b1cf9eb7e042@linux-foundation.org>
In-Reply-To: <CAOm6qnnxvVfxfoKTj8eO3iqZ9oj__JMJ8o0cH2fZuKkk7gVZYQ@mail.gmail.com>
References: <20250109033136.2845676-1-guoweikang.kernel@gmail.com>
	<Z3+ECLf7LHQe+Mdq@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
	<CAOm6qnkoKjrUXCbhCiSYviuwCRVES1FYCy17fwATtyZ+M=Aw7g@mail.gmail.com>
	<Z3/VoAaSQF5Tcy4t@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
	<CAOm6qnnxvVfxfoKTj8eO3iqZ9oj__JMJ8o0cH2fZuKkk7gVZYQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Jan 2025 22:53:57 +0800 Weikang Guo <guoweikang.kernel@gmail.com> wrote:

> I understand your point, you want to modify directly based on the
> original patch.
> If we repost it,it may not  be v8  but  v9.
> 
> Last v8 patch: https://lkml.kernel.org/r/20250102072528.650926-1-guoweikang.kernel@gmail.com
> 
> I reduced the recipients for V8 because I remembered that the number
> of CCs might
> have exceeded the limit at the time, and there hadn't been any
> comments on V7 for a long time
> 
> > @Andrew, is that still possible?
> 
> @Andrew, I can cooperate if necessary, I could merge them into one
> patch and repost.

I'll fold this patch ("arch/s390: save_area_alloc default failure
behavior changed to panic") into
"mm-memblock-add-memblock_alloc_or_panic-interface.patch", v8 before
sending the latter upstream.

But I'm not sure that we've completed the review discussion of
"mm/memblock: add memblock_alloc_or_panic interface" with Mike?
