Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C2A84A2F
	for <linux-s390@vger.kernel.org>; Wed,  7 Aug 2024 14:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723041657; cv=none; b=jP+UmepUUnT3ANpVSny71c/ftrsVdx6NnZGmZRNBFWs02lZITSlXZ+dyvZV9aqVyg2AxiN2NeKueIIqc3kyqCT9F0XzZnmdCvKhd+uUVJ50rrV6KTAyVrXezbah53dmHorTWXU+JZ1e6og/DZ8RAAqgNQRUznzPELEUsxznTGlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723041657; c=relaxed/simple;
	bh=0sQ9CcuwNmnt4bKftEBHMaRCYgOPu5Lyc31KuvZDi60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hiNbThfad6vEGhigTPgjN6LaGnImuED25xBFR58UB9lVX8kaRFtZ7xzSwBxrjzHD68yfOGVKUfeKTsnniJM6h3zyK3CqbZoYHNq2+CS3vv6+44tFjX0pIsu+53qCRDWfGGsNfKKOdSJM8iXyJMiFAuLdu5P+eEILhWrlPXCk4LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=CTMgIKjA; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="CTMgIKjA"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3dc16d00ba6so1084220b6e.0
        for <linux-s390@vger.kernel.org>; Wed, 07 Aug 2024 07:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1723041655; x=1723646455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FCSeVm0zgIRrRlVAZ6M3ezYAgjYCe4IP6mmA4qsAbw=;
        b=CTMgIKjAoYTkbGmR10CaM9/t4OEe23W9CqG3xp33wUWeUDuk43oAYEZE9XZzm1SyAe
         LwJB4CzPR/aYTOV3qx2X1EthjLaeJ0fdOSSJKtS9uFjMRZ+OTzdHeiBl7yEGFQEiV2dS
         eZyCRxg/Q0p6armzqtnH+n33SJaJovgbURnnhevFMKIjljlpd6vfXwYHaSLg8IKvpke+
         6Qr4pn3ebBwFq9cqSw1MBZy3vEn4JciAI8m8U213aOlsodlGlOsVPSgiA4DeJComL90G
         N4JwaxitCQduZos4eCzalTg8zraByiiU7lYCLGbD6amrNwxAQQBhK/em4papJIzz8bWH
         qDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723041655; x=1723646455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3FCSeVm0zgIRrRlVAZ6M3ezYAgjYCe4IP6mmA4qsAbw=;
        b=KRI+w7UsZXTNxCfMIGbiUDW3W1g2kgDjwLrgqCNw+OiZ3ePRkQfpGC6pU8E9W3iLlX
         Z5ZlBeOsYu4SSmCcnA+ag2WOMQ4xcmO5spZKtmxJydy7cQfkqGu09J91JPlzIkrOh3KC
         zXEwf+RSWkxzw/ROxJAmCGWZZG/Ys95BH+NzcUdcaG/gubtXsSYGpthZNZ9tVCNNzDYE
         /615rL8d8Yg9kSPIxQFCdaEcEi7a0hU0Zz9c8Xwo1y2yGncg6BOirDnIJo5uco5kMtA1
         VDBpkH1vwCjMoKXt+3GImySEwYDNg94ivG7gTf67SUsvLduwupXvomm/s1yKV+7hMq5K
         gfpg==
X-Forwarded-Encrypted: i=1; AJvYcCWfFTcNbBgRhru7kq2+1rPPiRfK/BpoTCUAnG3xmnI1MCZSlEkdN+Y7cnKvulcDvzd7oWgYMRS588yTOHCYT9JPv97m3HsadYYMcg==
X-Gm-Message-State: AOJu0Yx34kJpn7zmCduYhvlSFKYhmsCT5+j+ErF5QHl1SMS0ufJKJBPZ
	nsuhsCfUK1MKtNusoQcXppWaImtPjC1v6ZlgyGFTCRtic33NUz3kRNCLIy8QvIDTYu68S4Zm5iW
	9B0R91gi718+3tK33s5b7Ah47WkfMUQeiqYfAzg==
X-Google-Smtp-Source: AGHT+IGOXQAzEiXp6xdPGUMTTnKI09YBOs1Vk6kj0LXvCI51MvBrgaaI5JzS3LcBWq8pGTljqab9RWCOjdJxV6Tr6zo=
X-Received: by 2002:a05:6808:130f:b0:3db:251b:c16 with SMTP id
 5614622812f47-3db558397b9mr20918330b6e.42.1723041654777; Wed, 07 Aug 2024
 07:40:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806221454.1971755-1-pasha.tatashin@soleen.com>
 <20240806221454.1971755-2-pasha.tatashin@soleen.com> <345ba221-e094-47e8-9481-562faf4acd85@redhat.com>
 <e780e9af-e23d-44ff-ae0f-a8f4ee098a1c@redhat.com>
In-Reply-To: <e780e9af-e23d-44ff-ae0f-a8f4ee098a1c@redhat.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 7 Aug 2024 10:40:17 -0400
Message-ID: <CA+CK2bBuDu-3XeeAsy4zggOrxTrp84bcZp9p6mQipzc3NqpcSg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: keep nid around during hot-remove
To: David Hildenbrand <david@redhat.com>
Cc: agordeev@linux.ibm.com, akpm@linux-foundation.org, alexghiti@rivosinc.com, 
	aou@eecs.berkeley.edu, ardb@kernel.org, arnd@arndb.de, bhe@redhat.com, 
	bjorn@rivosinc.com, borntraeger@linux.ibm.com, bp@alien8.de, 
	catalin.marinas@arm.com, chenhuacai@kernel.org, chenjiahao16@huawei.com, 
	christophe.leroy@csgroup.eu, dave.hansen@linux.intel.com, 
	dawei.li@shingroup.cn, gerald.schaefer@linux.ibm.com, gor@linux.ibm.com, 
	hca@linux.ibm.com, hpa@zytor.com, kent.overstreet@linux.dev, 
	kernel@xen0n.name, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, loongarch@lists.linux.dev, luto@kernel.org, 
	maobibo@loongson.cn, mark.rutland@arm.com, mcgrof@kernel.org, 
	mingo@redhat.com, mpe@ellerman.id.au, muchun.song@linux.dev, 
	namcao@linutronix.de, naveen@kernel.org, npiggin@gmail.com, osalvador@suse.de, 
	palmer@dabbelt.com, paul.walmsley@sifive.com, peterz@infradead.org, 
	philmd@linaro.org, rdunlap@infradead.org, rientjes@google.com, 
	rppt@kernel.org, ryan.roberts@arm.com, souravpanda@google.com, 
	svens@linux.ibm.com, tglx@linutronix.de, tzimmermann@suse.de, will@kernel.org, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 7:50=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 07.08.24 13:32, David Hildenbrand wrote:
> > On 07.08.24 00:14, Pasha Tatashin wrote:
> >> nid is needed during memory hot-remove in order to account the
> >> information about the memmap overhead that is being removed.
> >>
> >> In addition, we cannot use page_pgdat(pfn_to_page(pfn)) during
> >> hotremove after remove_pfn_range_from_zone().
> >>
> >> We also cannot determine nid from walking through memblocks after
> >> remove_memory_block_devices() is called.
> >>
> >> Therefore, pass nid down from the beginning of hotremove to where
> >> it is used for the accounting purposes.
> >
> > I was happy to finally remove that nid parameter for good in:
> >
> > commit 65a2aa5f482ed0c1b5afb9e6b0b9e0b16bb8b616
> > Author: David Hildenbrand <david@redhat.com>
> > Date:   Tue Sep 7 19:55:04 2021 -0700
> >
> >       mm/memory_hotplug: remove nid parameter from arch_remove_memory()
> >
> > To ask the real question: Do we really need this counter per-nid at all=
?
> >
> > Seems to over-complicate things.
>
> Case in point: I think the handling is wrong?
>
> Just because some memory belongs to a nid doesn't mean that the vmemmap
> was allocated from that nid?

I believe when we hot-add we use nid for the memory that is being
added to account vmemmap, and when we do hot-remove we also use nid of
the memory that is being removed. But, you are correct, this does not
guarantee that the actual vmemmap memory is being allocated or removed
from the given nid.

> Wouldn't we want to look at the actual nid the vmemmap page belongs to
> that we are removing?

I am now looking into converting this counter to be system wide, i.e.
vm_event, it is all done under hotplug lock, so there is no
contention.

Pasha
