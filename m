Received: from mta1.migadu.com (out-39.mta1.migadu.com [95.215.58.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8640F42FCA9
	for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2026 15:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786979669; cv=none; b=PEu4ZXUd84QJ3lIZlra8hXm757QAJ0Ld7VnLTfZLdKP6dUwLe8HBRL2tJ74m3IiupkIaxNaKCdO/RI1b74plmWQPnCkGe92knOv9ld3ZbE7wB7t18/4SWuRPdnGpuK1eedrIpa156CfQ3gMpmRKSDX7/4RkCDZ9fgM0y7vhd8LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786979669; c=relaxed/simple;
	bh=/kpJHgkNpi750FH/SGpyKpVgqGqCSp4Wcpe2Zcb2oTU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=d0rsIiXHHo8FMXL65+5fwLfYlRcmSEGOIvaQF0OHqfZ3ohiGLqulHRFKGajAYhRs6pZUww3fm/ax1ULYo53G4QpvQzmLYkK2uu9RX3CD9G2dh9uiIlZRwGVNhHD6gWNOG8wPlhHMYH8I0A1aZ+H51rgWHUhY7iReftQ2qqRv3e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uk6XiQ57; arc=none smtp.client-ip=95.215.58.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uk6XiQ57"
X-Envelope-To: linux-s390@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/kpJHgkNpi750FH/SGpyKpVgqGqCSp4Wcpe2Zcb2oTU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786979664; v=1; x=1787584464;
 b=uk6XiQ57o1D6iibPFn5TKPWCDhnmKhFXuHkfhwAfmPyXniTm8i72E8hoRSgSS6FxCFvtJatD
 kUmnfMkBx9oLsAHHiig6ksIVwQO3iIA/8ohr2/mwK3ZKLP8lPZNwYrmBTas2k/yJBioKWe+JgDx
 DjSVklLEX0StH/n1O0kQZ3Bc=
X-Envelope-To: linux-s390@vger.kernel.org
Received: from localhost (212.133.41.51)
	by smtp.migadu.com with ESMTPS id b6551f00886cde4e;
	Mon, 17 Aug 2026 15:14:23 +0000
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Aug 2026 17:14:19 +0200
Message-Id: <DKRBF6LQY1L7.13CIBHAU0A87D@linux.dev>
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
 <loongarch@lists.linux.dev>, <yosry@kernel.org>
Subject: Re: [PATCH 6/6] Revert "arch: introduce
 set_direct_map_valid_noflush()"
From: "Brendan Jackman" <brendan.jackman@linux.dev>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>, "Andrew Morton"
 <akpm@linux-foundation.org>
X-Mailer: aerc 0.21.0
References: <20260816-execmem-set-vm-perms-v0-2-v1-0-90944a3ad43f@kernel.org> <20260816-execmem-set-vm-perms-v0-2-v1-6-90944a3ad43f@kernel.org>
In-Reply-To: <20260816-execmem-set-vm-perms-v0-2-v1-6-90944a3ad43f@kernel.org>

On Sun Aug 16, 2026 at 12:59 PM CEST, Mike Rapoport (Microsoft) wrote:
> Commit 0c6378a71574 ("arch: introduce set_direct_map_valid_noflush()")
> added set_direct_map_valid_noflush() to allow updating the direct map
> for a physically contiguous range in execmem.
>
> As Brendan recently pointed out [1], this API is confusing because on
> arm64 it means that is sets VALID bit in ptes, while on other
> architectures it is an analog of set_direct_map_default_noflush().
>
> The only user of set_direct_map_valid_noflush() was execmem's ROX cache
> freeing path and it was switched to utilize VM_FLUSH_RESET_PERMS for
> resetting permissions of the direct map alias.
>
> With the last user gone and with set_direct_map_{invalid,default}_noflush=
()
> accepting number of pages as a parameter, set_direct_map_valid_noflush()
> become a copy of set_memory_valid() on arm64 and a duplicate of
> set_direct_map_{invalid,default}_noflush() on other architecture, it is
> safe to remove set_direct_map_valid_noflush().
>
> Also drop a stale comment in arm64::__kernel_map_pages() that Linus
> bothered to add when merging changes containing set_direct_map_valid_nofl=
ush()
> to his tree.
>
> This reverts commit 0c6378a71574daa6cd1534ad42a956e3262756c7.
>
> [1] https://lore.kernel.org/all/DJ69RCVRBO0Y.3JCYSW50IC4RC@linux.dev
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Quick dump of my understanding (ignoring the NG bit on arm64)

- set_direct_map_invalid_noflush():

    x86: clear P and RW (and DIRTY)
    arm64: clear VALID

  So these look out of sync to me

- set_direct_map_default_noflush():

    x86: set P and RW
    arm64: set VALID and WRITE, clear RDONLY

- set_direct_map_valid_noflush(..., true):

    x86: exactly the same as set_direct_map_default_noflush()
         (but with a `nr` arg)
    arm64: set VALID

- set_direct_map_valid_noflush(..., false):

    both archs: exactly the same as set_direct_map_invalid_noflush()
         (but with a `nr` arg)

So basically the big issue here is specifically that
set_direct_map_valid_noflush(..., true) is special on arm64 and not x86.

And we fix that by jut deleting the API. SGTM!

The other issue I can see here is that set_direct_map_invalid_noflush()
clears RW on x86 but doesn't set RDONLY on arm64. So if you unmap
something using set_direct_map_invalid_noflush(), then map it again
using something other than set_direct_map_default_noflush(), you get
different behaviour between the archs.

I think the answer to that is probably: doing that is a bug, i.e.
_invalid_noflush() and _default_noflush() are a pair that you have to
use together. But I haven't checked if this is currently the case. Maybe
it would still make sense to just align these fully?

Anyway, aside from all this yapping, getting rid of _valid_noflush()
seems like an unambiguous win here so thanks for the cleanup!

Reviewed-by: Brendan Jackman <brendan.jackman@linux.dev>
