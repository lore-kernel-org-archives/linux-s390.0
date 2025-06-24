Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853D712B17C
	for <linux-s390@vger.kernel.org>; Tue, 24 Jun 2025 14:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750777161; cv=none; b=uqwMcjnB1pxvOPw7JxTAN+x+colZGdmOw2Qes/XuPjw8dLiUTIdRsR/B/Gt7NOwPsdthKHgqRxpSFpf/P9FGKiL9NoZsdd87AhV6YTymKNpdh2X6Q+31V0CbojU6su5IMcPj9IMUFGeitwOqsCw3URS4zL0/MPpzJrN3vJKGNr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750777161; c=relaxed/simple;
	bh=0Hl8XMnJmwbvE6DPiHP4c9Fk8kiU07SohaT94Z5oxlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ktoiPVyblxHT25jKqsr4NTWLd+BL+M7TJE2UWjJ17WP2zeWTKJfqT38nsy5keuMO3FxLsLwxpP8VI6UqvYXUCe68M+Git0/tNL9K3e23PBF+Gy3jeOosgG2zbks8Tx65hPlyLw6xUFkAfu+riKg5vUmZ9QG2glw1KAipj8Ti/7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dvPlzOd9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dvPlzOd9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750777157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9IYpHnRdDBXO/RmLL4oynIxsLC+0Md1r0l8B+HD5gek=;
	b=dvPlzOd9qdFxsobsGXDQEtAJ2Q2bk5K0PtzrwgNIJe5iIemmQFhAHIsHYxXLX5ZnUXDAZj
	TDSoP99vd4FdEnkfjuXGIbhFA19cQ5iW2DrlElcrCursS+Y1gxwzhyoaNQARnFgoIYBOEP
	9an/PUBVRbYGhwzNlMc1J9lyZj+X4VQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-mgXb3sxIPDeJRQAX5OlOkA-1; Tue, 24 Jun 2025 10:59:16 -0400
X-MC-Unique: mgXb3sxIPDeJRQAX5OlOkA-1
X-Mimecast-MFC-AGG-ID: mgXb3sxIPDeJRQAX5OlOkA_1750777155
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a6df0c67a6so1960144f8f.3
        for <linux-s390@vger.kernel.org>; Tue, 24 Jun 2025 07:59:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750777155; x=1751381955;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9IYpHnRdDBXO/RmLL4oynIxsLC+0Md1r0l8B+HD5gek=;
        b=cEeq8yOsFf3Ob3B25TpwqzWehUznNRcTpAB+OCYRxZnuHttEB+/WhctzBb+fdfiKiD
         qGa0sxv1GM1avAD0RgtOXGJdUn1aAilU96tRy3INYnnjA847gxO/czTxUDD2NYMidqvj
         6WPLFNks4zqcAcxrbJUENRuZ67sN8YdOW/7U5MPHN9da/Xq7Z2uF6XsITR32KJ5D6ufp
         5P0ccWov7cO97/RfhXkOxkBStbvZRhjAM3+Pgi4XWFBlcgVy647aR1DosbC9114KyuZr
         THSD6t1i6J5LWi/NbZoB6zE5v02qMQGN+OhiCsaFig9xqshJ/xAamAjDmJ+KXcpbsiu9
         8MUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHWdlnaG5obK72RZOVwdd56K/OGTHr3PwWYnmnC0HXIFC0XnWJyXiru5imllYpBHpyMIdSg1Vpua+f@vger.kernel.org
X-Gm-Message-State: AOJu0YzfRD+NZZxlfzR+GcshEQEliQJcwuKpA+iM9EDn96T5wQ4EYJeG
	rCFQx+Ht1gwzkQPQ4cGDyhqAw6vvg8cYdBtRjwm0r0xHfFhliIYrwc9/dy/iQSNlLP5eFCl1yEl
	pL8kj1VeN+SYIzHQ2Aad9I3idxVuyuVtp66YM2fHXw/Srm/6NP/2BuQd8sGXlvHU=
X-Gm-Gg: ASbGncuO8KwdLr/N1lCeZEpj8lYQ4gxySbw+ytuHXB6sMsLhxj0QfxeSE5B0KjzFFBI
	li2UA17IhWRVd2eZZM4qXX/EXpWR6IypOqgvlQc5H/SkQOeeway6L3lJl8ywzNSMv8/YSlUzMnO
	PIQMcbxX00q0GLCX+9ou6PeHZN1E7+pH7E40IFBQ3I9wbF42w2dR+JDVhPdPyqTcv248HF73Ib/
	ClBG6ATu5aD1T7edEgYPxmOlKVyCLmOdxeHP1wBchXoUA5cSK7+T0/85GnELZjIsz7rNk8WrEvZ
	nuqnljbWaSGpOIw81DYX7/hqjumqHpWJi7ZbUv1OsiaOUT4AczPm17Q=
X-Received: by 2002:a05:6000:4911:b0:3a5:57b7:cd7b with SMTP id ffacd0b85a97d-3a6d12ead65mr13615230f8f.22.1750777154765;
        Tue, 24 Jun 2025 07:59:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKwIVzcjJCazIIu0ohX/SvUYh1eop3idNH1ksL6bEXmYBpaySkgaTPLvS2ANBBdf20cy0RDA==
X-Received: by 2002:a05:6000:4911:b0:3a5:57b7:cd7b with SMTP id ffacd0b85a97d-3a6d12ead65mr13615205f8f.22.1750777154321;
        Tue, 24 Jun 2025 07:59:14 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453647f29bdsm144717525e9.18.2025.06.24.07.59.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 07:59:13 -0700 (PDT)
Message-ID: <8844a429-917e-44df-a884-6704a41a7cc1@redhat.com>
Date: Tue, 24 Jun 2025 16:59:12 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] mm/ptdump: Take the memory hotplug lock inside
 ptdump_walk_pgd()
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: dev.jain@arm.com, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
References: <20250620052427.2092093-1-anshuman.khandual@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250620052427.2092093-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.06.25 07:24, Anshuman Khandual wrote:
> Memory hot remove unmaps and tears down various kernel page table regions
> as required. The ptdump code can race with concurrent modifications of the
> kernel page tables. When leaf entries are modified concurrently, the dump
> code may log stale or inconsistent information for a VA range, but this is
> otherwise not harmful.
> 
> But when intermediate levels of kernel page table are freed, the dump code
> will continue to use memory that has been freed and potentially reallocated
> for another purpose. In such cases, the ptdump code may dereference bogus
> addresses, leading to a number of potential problems.
> 
> To avoid the above mentioned race condition, platforms such as arm64, riscv
> and s390 take memory hotplug lock, while dumping kernel page table via the
> sysfs interface /sys/kernel/debug/kernel_page_tables.
> 
> Similar race condition exists while checking for pages that might have been
> marked W+X via /sys/kernel/debug/kernel_page_tables/check_wx_pages which in
> turn calls ptdump_check_wx(). Instead of solving this race condition again,
> let's just move the memory hotplug lock inside generic ptdump_check_wx()
> which will benefit both the scenarios.
> 
> Drop get_online_mems() and put_online_mems() combination from all existing
> platform ptdump code paths.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

