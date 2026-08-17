Received: from mta0.migadu.com (out-162.mta0.migadu.com [91.218.175.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2353EC6B5
	for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2026 12:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786968660; cv=none; b=DXNtzQS15Xva7/RvqyVq/yhtQ25JXIly60NdqW8r6F0TyJ43o49RYn/c31DLXPFnAe+jmiKKPzp/WgV1ff42LaICx1SvlbqFnitGm9Z17DBBA+/00uP3jC9AkMZR1AQkK0jNNQ7BX5pyNZcymc194K2+ZO91oS/c+J97Mgtx5Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786968660; c=relaxed/simple;
	bh=HixNdaF24ntDEuguIuhpK7haYmS/JSSrlBPi1Y1tptI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=fuIQUJTpNpYbje8QWmy6/SEV+/M4/avKZhj14GaxuyyUvNLVzxRHepcRx6Y6Gg7ogmQz6s+vSQAfSIf4sYwkP5oQlyByy11xx9Fs3nMEPivHsfZy4SB/XdhfmkXhbACzOrkmRG1Dn/OObQ9mg8JQzktyC4DTZZ0V0pb7uXeptEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QeEsg/dq; arc=none smtp.client-ip=91.218.175.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QeEsg/dq"
X-Envelope-To: linux-s390@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HixNdaF24ntDEuguIuhpK7haYmS/JSSrlBPi1Y1tptI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786968655; v=1; x=1787573455;
 b=QeEsg/dqo1TZKqifzrBNzsykZmrFrlTHIwqmU/NfoUZuilMqfjcwRFQWsUqqIc1hgw0/A0kg
 JvEop+e9FDiowsS/ZKpFBBgvwCfaYypnG3Eq7CzMxKIlFsxztHVZ7HgwayE3nz2eXd+UkW0TJqe
 HoN2VbcomdRbSPmB6Q4EDzfU=
X-Envelope-To: linux-s390@vger.kernel.org
Received: from localhost (185.201.63.253)
	by smtp.migadu.com with ESMTPS id f0badc6dc42a8a86;
	Mon, 17 Aug 2026 12:10:55 +0000
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Aug 2026 14:10:39 +0200
Message-Id: <DKR7IK0VAERF.3ALVHRNQMSXZU@linux.dev>
Cc: =?utf-8?q?Adrian_Barna=C5=9B?= <abarnas@google.com>, "Albert Ou"
 <aou@eecs.berkeley.edu>, "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Alexandre Ghiti" <alex@ghiti.fr>, "Andy Lutomirski" <luto@kernel.org>,
 "Borislav Petkov" <bp@alien8.de>, "Brendan Jackman"
 <brendan.jackman@linux.dev>, "Catalin Marinas" <catalin.marinas@arm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, "David Hildenbrand" <david@kernel.org>,
 "Gerald Schaefer" <gerald.schaefer@linux.ibm.com>, "Heiko Carstens"
 <hca@linux.ibm.com>, "Huacai Chen" <chenhuacai@kernel.org>, "Ingo Molnar"
 <mingo@redhat.com>, "Len Brown" <lenb@kernel.org>, "Palmer Dabbelt"
 <palmer@dabbelt.com>, "Paul Walmsley" <pjw@kernel.org>, "Pavel Machek"
 <pavel@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "H. Peter
 Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Ryan
 Roberts" <ryan.roberts@arm.com>, "Sven Schnelle" <svens@linux.ibm.com>,
 "Thomas Gleixner" <tglx@kernel.org>, "Uladzislau Rezki" <urezki@gmail.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>, "WANG Xuerui" <kernel@xen0n.name>,
 "Will Deacon" <will@kernel.org>, <x86@kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-pm@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <linux-s390@vger.kernel.org>,
 <loongarch@lists.linux.dev>
Subject: Re: [PATCH 1/6] set_memory: add number of pages parameter to
 set_direct_map APIs
From: "Brendan Jackman" <brendan.jackman@linux.dev>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>, "Andrew Morton"
 <akpm@linux-foundation.org>
X-Mailer: aerc 0.21.0
References: <20260816-execmem-set-vm-perms-v0-2-v1-0-90944a3ad43f@kernel.org> <20260816-execmem-set-vm-perms-v0-2-v1-1-90944a3ad43f@kernel.org>
In-Reply-To: <20260816-execmem-set-vm-perms-v0-2-v1-1-90944a3ad43f@kernel.org>

On Sun Aug 16, 2026 at 12:59 PM CEST, Mike Rapoport (Microsoft) wrote:
> When set_direct_map APIs were introduced by the commit d253ca0c3865
> ("x86/mm/cpa: Add set_direct_map_*() functions") the single page
> parameter made sense because the initial callers (vmalloc and
> hibernation) had sets of unsorted struct pages that required changes of
> their mappings in the direct map.
>
> Since there is an increasing demand for direct map manipulation and it
> is also desirable to be able to update larger physically contiguous
> mappings, for example an entire large folio, extend set_direct_map APIs
> to receive number of pages parameter.
>
> As there is still only a handful of callers, change the existing
> functions directly and update all the call sites rather than adding
> wrappers for single page case.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

I think if we add this arg we also need to specify how the
implementations are supposed to behave when they fail midway?

IIUC the incumbent answer for stuff like this is:

- The implementation might leave partial modifications behind when it
  fails. The caller needs to deal with that.

- ... But, that's gonna be due to allocation failure. So the caller can
  just do the inverse operation in the failure path as a cleanup, and
  assume that inverse operation succeeds since the pagetables are
  already allocated up to the failure point.

I guess it's worth making that a sort of explicit contract since it
makes certain implementation details load-bearing, e.g. I think...

- It forces the pagetable update algorithm to work in a fixed order.

- it forbids us to e.g. merge PTEs into a PMD if the region might be
  pending such a cleanup, since it would force that cleanup to
  reallocate a PTE table.
