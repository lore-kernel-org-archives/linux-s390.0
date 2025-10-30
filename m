Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A9E273F9
	for <linux-s390@vger.kernel.org>; Thu, 30 Oct 2025 15:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839156; cv=none; b=ATng3wwpUZ5hmaTucJ76GEalxuE5cUZK0NWyqjreOVqNFIUu1TkME3J0a+nvkK7UjUcAl6EAx8xRpdU4mFv83s3KxWUzkME32QSD1KxwW5QhmOdP//06yb7ioikKttGNdvxBBRrTZCBBbKyJytcqbdwA+c8Pr6aevCYNcUVaVFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839156; c=relaxed/simple;
	bh=bTnJj9/u9HbjQIPERYKZPQzCYlY07yc9541XDGI+R0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q8wSbdbRAvceNYWsTjf+clRfNhJwDe7ta3jB+Ngpemf4GqUV+W8to+bSv6bce/B7D2yXke0W7nqtfcJdeozF2y9tqUmvmO3fRgHnrARGqruZ/2y3KVlZ8qv5GS5aqdRekBwA3elGJje8fttRHCxZxCu9tKjMCO0Mpml+V3efjwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TwblnYxs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TwblnYxs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761839153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T13UVO1/yPlQk6T2PfurpgHZxHJlbT6OmTkCB8QWscE=;
	b=TwblnYxs17S14Fub6Z21eDwZVwSELZgpcy0h04DjAZHGHYvtfH6c2cCD0z/KcKPzuBP7SU
	9R3SueY7hhNGZAJE4nOOR+53WKfb2oMJ136A08xmSZ3Gg+O0632lisgGbS+IySJm1fLIBa
	EN3BrSGvGw4rx96zmpOjHPCu/O016wA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-ma94RnRAOdiKJGly5WqVLw-1; Thu, 30 Oct 2025 11:45:51 -0400
X-MC-Unique: ma94RnRAOdiKJGly5WqVLw-1
X-Mimecast-MFC-AGG-ID: ma94RnRAOdiKJGly5WqVLw_1761839151
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8a9b1fa8092so326786185a.2
        for <linux-s390@vger.kernel.org>; Thu, 30 Oct 2025 08:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761839151; x=1762443951;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T13UVO1/yPlQk6T2PfurpgHZxHJlbT6OmTkCB8QWscE=;
        b=F1d55hkD4mur/6ZXkJ3fIw3E/zZhNKj77FtT4O4663lpBz/re1xJhCmZM0dCWf03xK
         /h744PEOfBGHq0N+3wnOQS50gzYcIFw9O/aCcujZ5HdFYT8W1yC2B7BF1CD1yrUOz7Bx
         Qrwoc5LiAs42aFOPertR3SoM8eQt2m7zJTBwRhIYGlDfEAwcam7FtUJND02nhg3k4t3q
         T1Mpkz1JV+JbDjx6OCBSt8a39Rkhrlm6fzkqGq9+McbA+i5qhq7hb7MJNLwS0EekLaRN
         RMtGMTlzn48RGHTGlFFlusxXYhirfVzmBT48nqvcrzl7tOiByUQWuEz4ZeYRDW6FbLxM
         FsZw==
X-Forwarded-Encrypted: i=1; AJvYcCVf2BVkMW7VV4qf2JL3AXg5Uyr2ckrB0nPaBZY++8ZHUCOpClQ+4Mgf/dRZZEQjDoFbvIlc/OsyIRQg@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4nqeiFjRPj6rKVEIj0J1pfSeKTOHGVjRiWsMnnEidHfdA2fvl
	3D57gvuet5s9Y12CKJ1LNPIQb8BJEqVJbTwxxf+3y1bqj21cXI0XRWKe3afZ92kMz0JDgRcLjyM
	hXbSO9eapb/USjQNp2qKjTrbCqDSagFldQ3JgzkqxUZCgZclJqJkw0f98XqAKn4Y=
X-Gm-Gg: ASbGncvA79Jcup5lqRrBGz+tW5ONtmZfiS0b8j3xkL6SPZkjT0bOENX0QPOmyFwREIE
	1z4RdTY7nMTPcMKTHbX97TxPI1hberB6K7qF7KvdMWW/MbnywP2/KnSQBZHkuszeL2rRcdsSnIq
	gpBuEUO0Rx8Hfb7XUbVJO0xHtVxWfA1Vw17FHdUYhy+AX+irIvmSxSwTdrGsBk07UTBOfBzZ0hg
	UFJL0olnWanbmxITx3Dd115ljMX8GcHaKge152Ki5pLDoXhmBQocFz6VjN6KFFewOw3FuOUb0zL
	5iOUprOoOtsNCW9kE3XkW4nbmbu7gnef6gi921EHHzqQr5rLFrd0XWZo8OAuww9DN/w6GXVbofd
	MBw==
X-Received: by 2002:a05:620a:2a07:b0:8a3:e51d:63c9 with SMTP id af79cd13be357-8aa2c659146mr496985685a.25.1761839151196;
        Thu, 30 Oct 2025 08:45:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOqRO+7KOnHpcS7rPlmfWuNX0n6FxKFT+Lt8fIFSIFDsOADI0AQRhPYfD/wI22ZJMDrMWM8w==
X-Received: by 2002:a05:620a:2a07:b0:8a3:e51d:63c9 with SMTP id af79cd13be357-8aa2c659146mr496980385a.25.1761839150640;
        Thu, 30 Oct 2025 08:45:50 -0700 (PDT)
Received: from [192.168.2.110] ([70.49.125.126])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f2421fba6sm1289506585a.4.2025.10.30.08.45.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 08:45:50 -0700 (PDT)
Message-ID: <d491b540-8984-4ffa-9a79-ad6855e9c883@redhat.com>
Date: Thu, 30 Oct 2025 11:45:39 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390: Disable ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
To: Heiko Carstens <hca@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Joao Martins <joao.m.martins@oracle.com>,
 David Hildenbrand <david@redhat.com>, osalvador@suse.de,
 aneesh.kumar@kernel.org, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org
References: <20251030145505.2764038-1-hca@linux.ibm.com>
Content-Language: en-US, en-CA
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <20251030145505.2764038-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-10-30 10:55, Heiko Carstens wrote:
> As reported by Luiz Capitulino enabling HVO on s390 leads to reproducible
> crashes. The problem is that kernel page tables are modified without
> flushing corresponding TLB entries.
> 
> Even if it looks like the empty flush_tlb_all() implementation on s390 is
> the problem, it is actually a different problem: on s390 it is not allowed
> to replace an active/valid page table entry with another valid page table
> entry without the detour over an invalid entry. A direct replacement may
> lead to random crashes and/or data corruption.
> 
> In order to invalidate an entry special instructions have to be used
> (e.g. ipte or idte). Alternatively there are also special instructions
> available which allow to replace a valid entry with a different valid
> entry (e.g. crdte or cspg).
> 
> Given that the HVO code currently does not provide the hooks to allow for
> an implementation which is compliant with the s390 architecture
> requirements, disable ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP again, which is
> basically a revert of the original patch which enabled it.
> 
> Reported-by: Luiz Capitulino <luizcap@redhat.com>
> Closes: https://lore.kernel.org/all/20251028153930.37107-1-luizcap@redhat.com/
> Fixes: 00a34d5a99c0 ("s390: select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP")
> Cc: stable@vger.kernel.org
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Obvious enough change, but FWIW:

Tested-by: Luiz Capitulino <luizcap@redhat.com>

> ---
>   arch/s390/Kconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index c4145672ca34..df22b10d9141 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -158,7 +158,6 @@ config S390
>   	select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
>   	select ARCH_WANT_KERNEL_PMD_MKWRITE
>   	select ARCH_WANT_LD_ORPHAN_WARN
> -	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
>   	select ARCH_WANTS_THP_SWAP
>   	select BUILDTIME_TABLE_SORT
>   	select CLONE_BACKWARDS2

