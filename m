Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EB51D2F5E
	for <linux-s390@vger.kernel.org>; Tue,  6 Aug 2024 13:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722950103; cv=none; b=N8SI/sYfPB3HhFXa2k2ons8GLKuaAAsHX0VNUtTxt1cOOLdV0OIydv1ltcFD9W0Oveg65Mvgs0ccZJ8AtVL15XH04dS2DhSDku/Z1ssbQqJ5RkUScnAx4biS6Fd8RQsS2rOkp156vCFrAltaI3ginfLlVjNa8HN6oYYji65U61c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722950103; c=relaxed/simple;
	bh=QsHF589vatmELWtHbADH1FBmEtHqOFAgvPgCHcyZYhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=it80bKdiguaBxgkaAUy0ssLHJOjkKPaE+b6hw5J1JjGBa5i9QL6tNDVFruuHIl0jjAsONU8PO6m0L+GNUPpqsZHYQIuJ2UmfOv7KxCENJKEylkcXJLLFpno8ubIvveimp8ZnS1L8IOBoT6TQqwoWnv4Gej/9iRl/NJ6FC8EW3as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IqUBv6bC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IqUBv6bC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722950100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gav+WgTfYsxeeh1+Er9Vd3yZJQcnmu7WI7/O0+JeoYw=;
	b=IqUBv6bCjT3oEoj5VEhnk8AYqmqEZ9K4CJN3iL39BxI7yz0z4gkTrAoVnoNhyf7PvCTbFc
	IcfCJmk81huHviBuRNqn4oxlWHQs+HhhuxcWNKpRQ0JWYChNtbka8BU+MPYX6PRUc77+cP
	nBmObAIyUil5lUSmFLJn2LQbTe3VQXk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-UQEy9leBN0KW3qD3wR0cqw-1; Tue, 06 Aug 2024 09:14:57 -0400
X-MC-Unique: UQEy9leBN0KW3qD3wR0cqw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4282164fcbcso4731735e9.2
        for <linux-s390@vger.kernel.org>; Tue, 06 Aug 2024 06:14:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722950096; x=1723554896;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gav+WgTfYsxeeh1+Er9Vd3yZJQcnmu7WI7/O0+JeoYw=;
        b=DDx2Rx92NzaMqp2AnG2rUE/6q9CXW730XPRz13Uw9ZJBrYLmTonszoLvE7T5RGAm+8
         InL7HgqYFOd4XhAOylvovR5GSa3apP1drtkHdj2SdJGCdOOnb5LiyZP6zrIfYBQzKbQn
         awOfiSK1lqRuQJH2jpcehABYSjMu8MJp8f8zbIJUHTu0meCf55cmUku1yHE935Gey1aU
         mqBGHUcpJeWWLkyuV6BNe2KBk+Q6J1j6fE0czF2sNkCw95AVjOzHDEiAx3djUYI/uddi
         lK8UjP+ZZAQ9NymirEEh5ghEGIdzp4PUap2ELuRfOlU+NTVMzWyNRG9cto1zGprEaOWm
         zYLA==
X-Forwarded-Encrypted: i=1; AJvYcCWUDxyx3FDWhnMBfdna70ueuxbaRpjl+3ANt7CdlXJma7fuSQCvEFZiAtBaL9vd1ZBuhzBMtzYstpYKNuxIYk/G1u5nZrZzfDosTg==
X-Gm-Message-State: AOJu0YyRIidkCxwH1f3e0oL1K29vog6T6gBFlCAA2u9BDHXc39kLAiDA
	pTotDXjCJULHIfVKMjuCjXl1r5Aw726+AB4+SFgc7wMQiEFQ5mAtevioxppHBULYy8ETmM8jeOh
	LQxfp/5UFncsScCeD90lqGLiUrGJBmnBAZGhHeBopNIwvj7+cX3OIPSXA5WQ=
X-Received: by 2002:a05:600c:4fcb:b0:427:9a8f:9717 with SMTP id 5b1f17b1804b1-428e6a5afc3mr126859705e9.0.1722950096313;
        Tue, 06 Aug 2024 06:14:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6jHrb53H6IDJztgeIGS31y125eDKjP789FcxpVkwCrI28w6A/fVody5PYRBfVSpT6cV7Inw==
X-Received: by 2002:a05:600c:4fcb:b0:427:9a8f:9717 with SMTP id 5b1f17b1804b1-428e6a5afc3mr126859115e9.0.1722950095740;
        Tue, 06 Aug 2024 06:14:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73f:8500:f83c:3602:5300:88af? (p200300cbc73f8500f83c3602530088af.dip0.t-ipconnect.de. [2003:cb:c73f:8500:f83c:3602:5300:88af])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd26f9c2sm12920846f8f.116.2024.08.06.06.14.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 06:14:55 -0700 (PDT)
Message-ID: <8f9afa5b-0a89-4adf-b532-3fb7a5f5f681@redhat.com>
Date: Tue, 6 Aug 2024 15:14:52 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/26] x86/numa: numa_{add,remove}_cpu: make cpu
 parameter unsigned
To: Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
 Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Dan Williams <dan.j.williams@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>, Davidlohr Bueso
 <dave@stgolabs.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Heiko Carstens <hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Jonathan Corbet <corbet@lwn.net>, Michael Ellerman <mpe@ellerman.id.au>,
 Palmer Dabbelt <palmer@dabbelt.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
 Samuel Holland <samuel.holland@sifive.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>,
 Will Deacon <will@kernel.org>, Zi Yan <ziy@nvidia.com>,
 devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 loongarch@lists.linux.dev, nvdimm@lists.linux.dev,
 sparclinux@vger.kernel.org, x86@kernel.org
References: <20240801060826.559858-1-rppt@kernel.org>
 <20240801060826.559858-17-rppt@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240801060826.559858-17-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.08.24 08:08, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> CPU id cannot be negative.
> 
> Making it unsigned also aligns with declarations in
> include/asm-generic/numa.h used by arm64 and riscv and allows sharing
> numa emulation code with these architectures.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Tested-by: Zi Yan <ziy@nvidia.com> # for x86_64 and arm64
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

