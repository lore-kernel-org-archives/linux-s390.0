Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97907182D9;
	Fri, 13 Dec 2024 01:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734053773; cv=none; b=uQfz6Q+tzLo47qQlj9/vF3WxxjgCOZ+WCi6NfVwL6XQgEWHPGMUdcEX+WIC8l3CHmExXe7o+rbgcLd6bWWwAu+gGL/oPnBLu4m3VO7R/pIvOGGcu3Cmg52C8BHXuPW/+MQmgbIBuPXZll9ZfL3F34dDayt4CjDpasjQZQuCV4l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734053773; c=relaxed/simple;
	bh=7f/5fqryMUGvRImZN3hfJmmlKUrLgbHGWnv+giipYko=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ohTsd3TkMhy0Kg18UdDMEXSKVUlPGvvUVSmyLO8/Ezmi7dRJX9jQ/KM33QgfhWUGV4H0iYobjdIYiRmX7kylM+d5HZnUVjPayqgIRcE3GPCcAB3zsAqXhBp/wi9GoCypoVTK90zIn8YLyrO9urch+H4NUYvcEQpS8Q/b8ozDuqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=pU24h8Qm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="pU24h8Qm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07DAC4CECE;
	Fri, 13 Dec 2024 01:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1734053771;
	bh=7f/5fqryMUGvRImZN3hfJmmlKUrLgbHGWnv+giipYko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pU24h8Qmf2l3dWmBoawfB733EGF8ZWmMJjrPI6B43pMJbMG4ZTBpTRzP1HUP8GzP4
	 1boZnf+GhhYVxYCiYxKJ0ZLRya4Nw9Vpsn1tw6iHWN3gws31ENEkqbfbQgsb2j17Bw
	 tbFaFZWjLH1q1pTGS9LCKFYhq+6kLBeOOeefROU4=
Date: Thu, 12 Dec 2024 17:36:09 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Kalesh Singh
 <kaleshsingh@google.com>, vbabka@suse.cz, yang@os.amperecomputing.com,
 riel@surriel.com, david@redhat.com, minchan@kernel.org, jyescas@google.com,
 linux@armlinux.org.uk, tsbogend@alpha.franken.de,
 James.Bottomley@hansenpartnership.com, ysato@users.sourceforge.jp,
 dalias@libc.org, glaubitz@physik.fu-berlin.de, davem@davemloft.net,
 andreas@gaisler.com, tglx@linutronix.de, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, chris@zankel.net,
 jcmvbkbc@gmail.com, bhelgaas@google.com, jason.andryuk@amd.com,
 leitao@debian.org, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-mm@kvack.org, kernel-team@android.com,
 android-mm@google.com, Jann Horn <jannh@google.com>
Subject: Re: [PATCH mm-unstable v2 00/16] mm: Introduce arch_mmap_hint()
Message-Id: <20241212173609.afd41d1dffbefe0d731ed4ed@linux-foundation.org>
In-Reply-To: <1818e2ea-f170-4a9c-8d93-2a24f2755a41@lucifer.local>
References: <20241211232754.1583023-1-kaleshsingh@google.com>
	<hmuzfspqjzb36xlj2x44keihacrrhzj5madqrfbcnhqouzredv@wo75achgkuh5>
	<1818e2ea-f170-4a9c-8d93-2a24f2755a41@lucifer.local>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Dec 2024 22:51:34 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> You've fundamentally violated kernel process and etiquette. I'd be more
> forgiving, but this is at v2 and you've not cc'd KEY people. Twice. This is
> totally unacceptable. See [0] if you are unsure of how to do so.

This feels excessive to me.  linux-mm averages a mere 140 mesages/day
and it seems reasonable to assume that key people are spending their 5
minutes to scroll through the email subjects.
