Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171551B392C
	for <linux-s390@vger.kernel.org>; Fri, 20 Dec 2024 09:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734686538; cv=none; b=p/pENcSvyRP31s4pGnS91BJ5SOzw3hMbWgn37yH/1aSzsVOKV6HUvgZwOXuO09QD8QuW9PgFkF6pjSABti07tqQyAZjY43h/13GXGkrp2bPvw8zS8TyCBwZcg6D2PGF61WvEbVRaeVTDf0kmO/92AR61wJkkFEyS29i2XTcEuMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734686538; c=relaxed/simple;
	bh=1UH8jNztgQVOEtA8CPmxz6iWqlpbOtXkxvG2j0OJjqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IqkZHTbIH/KBXxENt0DEuDkUi3mcOFSAQnNuNOQw+74/K8mxwcBtgto/W0MT38wqMdZG0gDsJE9nhXCWmoImjk5KXYsmQCHEs8Dc6fhYX55XFrvkh+QHTQGcjt572nefQIMeu8bnnAbz6UbLai7Ogn1nR/RjmWn9F1nr3GEOixw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dyhsYFIu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dyhsYFIu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734686535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=63xEpvVaiActnojyuNFhcspi1D1rHZCBhltPENJ8FPA=;
	b=dyhsYFIuXQtyH7d+EbAWsSJTAs399g0rSG7uCDGjYTliZC05aedN4whohO5xdX+cU2KU+L
	diVPlIJ7InheCbjepvQEZ+dTnU79bVgEHIiUVO0oqp20t3l29a+oiLBRqRxBbns2+WX8Gd
	t5WYZefRnNlEzkaWgsFXHJ5rNMnVK2Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-F_TEA2ApNuuCG_hqLsT8LQ-1; Fri, 20 Dec 2024 04:22:13 -0500
X-MC-Unique: F_TEA2ApNuuCG_hqLsT8LQ-1
X-Mimecast-MFC-AGG-ID: F_TEA2ApNuuCG_hqLsT8LQ
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385e1fd40acso967263f8f.3
        for <linux-s390@vger.kernel.org>; Fri, 20 Dec 2024 01:22:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734686532; x=1735291332;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=63xEpvVaiActnojyuNFhcspi1D1rHZCBhltPENJ8FPA=;
        b=b2OiTjsDDf5NTjI4uSTsTz+XJ4SdlWPibWlOu/6oIkBG0+UCNMO/QfwMYUsAUSS4sH
         OWIP2+oMgsB7Unx5N5AnSwTBQmdOnm5EiVhGdsC/D5s6ez9+0RuEOxWI83B1+kdRz8Ci
         K6nzJIOAsLgEl8otiCn2OnCp0mJ/fWw1l9YOYUSv7njaV1ChEXofkaxt/npcIeD9PWlo
         gArCO3IQT4xWi62sVAXau45vUhAWA5drdaxT9V69sW2kb5hkUGmblzPhQ9HGvBsV1ZV9
         Njoi3qnuLiD8udqET96DtUVuIWHdX3/HsbedcBSXe3xvYg9wUBljtaPO1YrsL00Byp0J
         vBgg==
X-Forwarded-Encrypted: i=1; AJvYcCUexAkqxEu9OcRIw4tJ3wE711Sf1aFeSiQ7D4U29NfhngfVVZC4PLSuK0CayevfUwi4C0UjgxGwQQG8@vger.kernel.org
X-Gm-Message-State: AOJu0YzlUnglDybdcnXoDCz8WlnableUkPIB8ANjaElsZOROGN9PTY+6
	zvGF+Mnc1ipvS03dcgFOO2JeK0g39vW4b0MyRTliBpltBI1TkgD2hqbRObpN4Fu7wgOnzXVOxMx
	iZHbXhH2kdzTCw+NeHien+Uw0dbi5y79aB6CndriaiYgkADh4ZjrPixrhsDs=
X-Gm-Gg: ASbGncvr+b8aLjT044yWm+Dba0JITcoGTcA10jqck/hJfCQiq0wclW97ydyd5RgEhvJ
	G7AJvOQRfiSTBbdLXNsq7S/PJOgKg2LlwH5aMxIgHD6H3sllP09EqvTXhirtVl/TW5neTF2QacP
	16DHYd+mDP8YH/+6bhAd0bC/dLClBgly5QLpiQkTrlBwCT7MwEjdKF7cd1Wbl5nCXXsWrU5K81i
	CzNOSl0ivg6/WQi0Y30X1N6JgHetkfLO7afJPmZnQyBKK/ps+hUFKXphIsRm3ay6Eo33KvT42s3
	uGVb/zHjbJux9eSmy4Okp/ouPzzsIAjqbThYmgLZhxVJxoeaWBAPRZ/z5AHabeD69KAqhqtCUlf
	6LKo7/wRW
X-Received: by 2002:a5d:6d8b:0:b0:386:3356:f3ac with SMTP id ffacd0b85a97d-38a221f2dedmr2067817f8f.26.1734686532351;
        Fri, 20 Dec 2024 01:22:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuBjypd2IvpONGLHVLfR4t0/RICJsmbwGctuPcZ4gcdo14xzk+DlROivy4C2bH6Xy88C2srA==
X-Received: by 2002:a5d:6d8b:0:b0:386:3356:f3ac with SMTP id ffacd0b85a97d-38a221f2dedmr2067787f8f.26.1734686531997;
        Fri, 20 Dec 2024 01:22:11 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:9d00:edd9:835b:4bfb:2ce3? (p200300cbc7089d00edd9835b4bfb2ce3.dip0.t-ipconnect.de. [2003:cb:c708:9d00:edd9:835b:4bfb:2ce3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8acc02sm3527167f8f.104.2024.12.20.01.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 01:22:10 -0800 (PST)
Message-ID: <78662fe4-00ce-4927-ab62-4545bb6fc289@redhat.com>
Date: Fri, 20 Dec 2024 10:22:09 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] s390: Convert gmap code to use ptdesc
To: Matthew Wilcox <willy@infradead.org>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-mm@kvack.org, linux-s390@vger.kernel.org,
 "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
References: <20241219162252.1025317-1-willy@infradead.org>
 <20241219162252.1025317-2-willy@infradead.org>
 <Z2SO6p5MJuPBUwRf@casper.infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z2SO6p5MJuPBUwRf@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.12.24 22:23, Matthew Wilcox wrote:
> On Thu, Dec 19, 2024 at 04:22:49PM +0000, Matthew Wilcox (Oracle) wrote:
>> There was originally some doubt about whether these page tables
>> should be represented by a vanilla struct page or whether they
>> should be a ptdesc.  As we continue on our quest to shrink
>> struct page, we seem to have crossed the line into believing that
>> thse page tables should be a ptdesc.  At least for now.
> 
> Looking at this patch some more, I'm not sure that pt_index is really
> what we should be calling this.  Would pt_gmap_addr make sense?  If
> not, what's the right name?

Let me try to refresh my memory.

(1) Ordinary gmap for running virtual machines

We set it to the guest physical address that this page table is 
responsible for. So we can easily translate from a given gmap page table 
+ offset back to the guest physical address.

We set it for PGD/P4D/PUD/PMD page tables in gmap_alloc_table(), and to 
0 for the highest level (which logically corresponds to guest physical 
address 0: page->index = 0).

We really only use it for PMD page tables in __gmap_segment_gaddr(), to 
calculate the guest physical address.

(PTE page tables are shared with the process space page tables, which is 
why we don't maually allocate them or set/get page->index)


(2) Shadow gmaps for nested virtualization

We set it to the guest physical address of the page table we are 
shadowing. Meaning, this gmap page table shadows a page table in guest 
physical address space, and we have to

We set it for all page table levels when shadowing them (when marking 
the to-be-shadowed page table R/O in the gmap so we can catch 
modifications).

We use it in gmap_shadow_pgt_lookup() to translate from a nested guest 
physical address to a guest physical address, required to resolve faults 
for our nested guest.

We only used "ptdesc->pt_index" in gmap_shadow_pgt() so far, because 
there we allocate PTE page tables as a shadow page table (not for user 
space page tables, though!).



Long story short, they are "guest physical addresses", which we simply 
call "gaddr" in that code. So "pt_gaddr" or "pt_gmap_gaddr" make sense. 
(we should fixup that one pt_index user)

-- 
Cheers,

David / dhildenb

