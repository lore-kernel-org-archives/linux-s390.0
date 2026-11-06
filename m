Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793974671;
	b=5KN7jGhsmb+ZHtiJOq4MM/R1OXStL8SRnzshsdyAaNphaNqJqqUkQfrWhXA0iKDGgjN2
	 P9RnCLNt3g+Ek/ruh9u2utzCejTOUgHaLCbqQDpkh85NcBJIhB/24ybTReE4a4SymmUKp
	 baJkIvrylvVJXszZUChi/7lLSIucIwoTkC9uBE1nS6JohjEyHw8AZwjDVfCsRRtquOfya
	 IbUlbJnoxk0/GuokD6hmuNQFbrx3fvvYFQJH3RsZH3CWC03C3vWrsaUe7BnLdV8xz5KxD
	 jUdrjmHlKUxXY5Q1fLv6E+kzvavl/Ssc2m3vnCEHOw42iKJNhAV4qFbOAJZLZIPrTOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793974671;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
	 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=cfkgwX+JUpucBEMRMXNCp7qzYju/oBKPyn0BC2hQAJ8=;
	b=xovKyfh+bgq3J6PAcVsUeoaM0JTWPUW/VNBF9DUp8kNo0otPTtyAep0OlDJyoIDkQkOF
	 pWKZPDCkVr0ALluGZ1YwQxiXdsqYKH5DHsDrMB2dOgqoP/uCZbZ5IZeySxObHdspgIzkt
	 BcUebi2imh+7RuptcW4xQvh23D3O6fEiNb3OZXT84p0gAWeTOm9eUBCxTcr3wcN5d/COz
	 X15q5nM+A39H4waetTL0z8D5dG14Woo9BcLPgR8+NtHxeUq/XrWtOXjPXhKerciCm1qPS
	 gIrJc6Sm2HlMWJ6M+rlOScV7NFvTj0hx8vEocoxk4norP5e7oqf/zBmLDjgfmNFMRXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mainlining.org;
	spf=pass smtp.mailfrom=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=PRfyFtAJ;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=EJOG05Mf;
	arc=none smtp.remote-ip=5.75.144.95
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3D3606A326;
	Fri,  6 Nov 2026 14:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F3D3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=PRfyFtAJ;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=EJOG05Mf
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1793974582; bh=cfkgwX+JUpucBEMRMXNCp7q
	zYju/oBKPyn0BC2hQAJ8=; b=PRfyFtAJmOt7pvxJzSuijDJYDCUJu+yGZBijxZ5MAnB5YKWcPx
	J6uz18/wTtM9bV0a0t335JAKhminuyFaAHbbbWEmqytuIWXLNIEZEbGOj85OgjtV7Y7hYmG3Yj8
	q4Cb+jR9pMpU+zd6tTar1Y3XjqphesY6+dDGV3/4qKogVBcdzqvsi2gaSs1nO1OfTVhs9DQf3Cq
	TinBPJRk0thXhx8rvC3oOANM/0fPis4wQDIWbQwf3uow7Y8TYbKX4c0YmfkUaVRpvxgiXpzE2Sy
	WmnEroeSf0cpwhf9u1Y6Fanf6Cm1nQFhDFcayE82GXz+ve/1dk+009K9lnDkRoAay5g==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1793974582; bh=cfkgwX+JUpucBEMRMXNCp7q
	zYju/oBKPyn0BC2hQAJ8=; b=EJOG05Mf7mgqOIXke6l7vMrTx/h3Frh4SrlcLSW5LJBEjqcc3K
	2gQSVA/PUCQcXGAjqDMuuMXxjI879QVRopDg==;
Date: Fri, 06 Nov 2026 14:16:23 +0000
From: Bradley Morgan <brads@mainlining.org>
To: Usama Arif <usama.arif@linux.dev>, Mikhail Zaslonko <zaslonko@linux.ibm.com>
CC: Andrew Morton <akpm@linux-foundation.org>, baoquan.he@linux.dev,
 rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org,
 ruirui.yang@linux.dev, jbohac@suse.cz, david@kernel.org,
 hbathini@linux.ibm.com, leitao@debian.org, kexec@lists.infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kas@kernel.org,
 hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev,
 kernel-team@meta.com, Vasily Gorbik <gor@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_crash=3A_keep_crashkernel_C?=
 =?US-ASCII?Q?MA_pages_reserved_if_activation_fails?=
In-Reply-To: <20261106140556.1667159-1-usama.arif@linux.dev>
References:  <20261106140556.1667159-1-usama.arif@linux.dev>
Message-ID: <91E33A6A-41C5-4AFC-9311-453066E631F1@mainlining.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 6 November 2026 14:05:54 GMT, Usama Arif <usama.arif@linux.dev> wrote:
>On Fri, 6 Nov 2026 12:21:12 +0100 Mikhail Zaslonko
><zaslonko@linux.ibm.com> wrote:
>
>> 
>> 
>> On 04-Nov-26 15:56, Usama Arif wrote:
>> > reserve_crashkernel_cma() adds each crashkernel CMA area to
>> > crashk_cma_ranges[] as soon as it is declared. If the area later fails
>> > activation, e.g. because movablecore= put the ZONE_MOVABLE boundary
>> > inside it, cma_activate_area() releases the pages to the buddy
>allocator
>> > as ordinary memory. The range is still handed to the crash kernel and
>> > excluded from the vmcore, so kernel data that lands there is
>overwritten
>> > by the crash kernel and missing from the dump.
>> > 
>> > Mark the areas with cma_reserve_pages_on_error(), so that a failed
>> > activation leaves the pages reserved: lost to the first kernel, but
>safe
>> > for the crash kernel to use.
>> > 
>> > Fixes: ab475510e042 ("kdump: implement reserve_crashkernel_cma")
>> > Signed-off-by: Usama Arif <usama.arif@linux.dev>
>> > ---
>> s390 hits this without movablecore= (adding the s390 maintainers and
>> linux-s390) since ZONE_DMA ends at 2G here.
>> CMA tries to reserve areas above 4G first, but falls back to lower
>> memory when it doesn't fit, so a cma area can end up across the 2G
>boundary.
>> I ran into this while adding crashkernel=,cma support for s390, which I
>> will post soon, and came up with the same fix.
>> 
>> About dropping the range instead, as you offered for v2: I'd keep this
>> version. With the range dropped, the kdump kernel gets less memory than
>> configured, and that only shows at crash time. With this patch, the
>> the first kernel 'loses' the memory as with a regular crashkernel=
>reservation
>> of the same size.
>
>Yes, I do agree with this. Losing memory in first kernel is preferrable
>and it will then force someone to fix whatever is broken rather than
>finding out when their kernel crashes.
>
>> 
>> There is a second problem in the same loop: all areas are named
>> "crashkernel", which breaks the CMA sysfs and debugfs entries when
>> there are several. I've sent a separate fix for that:
>> 
>>
>https://lore.kernel.org/r/20261106104309.3669583-1-zaslonko@linux.ibm.com
>> 
>
>Thanks! I reviewed this now.
>
>> Reviewed-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
>> Tested-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>

Well, now that that predicament arises, I see that this patch is a "hidden
gem" sort of thing

Reviewed-by: Bradley Morgan <brads@mainlining.org>

(Thanks for telling me about how you accounted for that bitmap_zalloc()
failure)

>> 
>
>Thanks for testing and reviewing!
>
>Usama

--- Thanks!
