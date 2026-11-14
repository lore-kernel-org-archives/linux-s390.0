Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794678305;
	b=WVlH2U3bmfdTfzxmK/H4wIsZ9BLGWUEDNgaQXz7lJj/VB2sSVGVnWk9KKAsdIxe0s4z+
	 U/V5uEHN+60mhpmygjMd55uBpeHbajCaQ2B/DHTTAe3dmqiQ5X46hinlnm75XsOqmcB6i
	 P8frCgIKY7qQg/o+qfVCllLakRUAzNAIRZcu95x5lRyRfEe+tRPXqKZkqtFu+SYwz9ReS
	 ZzIZ4mJqlNnQ+LkKHSlU7N8EmSpER9k8jhnqyVKYM5xuYFTBU2papSMeLU+MyUW/qtc/v
	 69tApw4FP2IvzpfFVeQZqSv6vDrf8DNvdt1rlkpDvYk7GcKrPV7gViYlD42Gp1Tw0Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794678305;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=ZNcZMolhjI9akx8wnIcso6bAnFZ7LtMgZRZy+seyfFc=;
	b=T8OTwqD8FTx6kniL4rF5q3IICF9KgOjCr5+0yJsduPlIuL6PTkIZpdKV/fZBXCPe5vJZ
	 0j9mwi2zVGln36BjEJLrtqyklz21oncdsvZpC4txZxUz1PcwdaypMzPtOsuY3JQoPjSaJ
	 ac/CwlydWdDB5pXNiqQDz6qtrMaSvHDDy/H6a9LuQeEpUGp2vVRogHzOvO5gND5Weop91
	 C8fbaQoStdHFs7et/1scfAcal62DOvtg7hWU/JJCTXafHzHMfpDvoNdibY00aHYvgNnfm
	 F5jE5i7pPBb5I9TD8eWwOcj/unfQ987+gIHwJRxHvFkPEe3J6SMsUIKcoG1V03jgHpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b="MmWE3/tW";
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDA1606A333
	for <linux-s390@vger.kernel.org>; Sat, 14 Nov 2026 17:45:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEDA1606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=MmWE3/tW
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91c11468b5fso30764376d6.0
        for <linux-s390@vger.kernel.org>; Sat, 14 Nov 2026 09:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794678304; x=1795283104; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZNcZMolhjI9akx8wnIcso6bAnFZ7LtMgZRZy+seyfFc=;
        b=MmWE3/tWVbBtF8EcqqHy+PVeL5SSlcJKpP6VzS0tSTNZ2fAANN/mjeb2XKUMnYOGnt
         fS7SPnLre/soNOeedBOj6usNp+QZWktQVRGGddD5xas5spd/gD61hYWBXaHU1f7LSdPo
         bK8uKTvij0ptR88ShH5mhzY9iqEzp+SHQCjXzVtKMzPH8bnKh3tKLARb3tJTj5Xk84j+
         57zNzCJH2LXVTRHwrBigzqWgZ2tlkMTHXah/csAHOyHHZ2Qpn/t9n7Prea0qhwuAyV70
         tipj7gdjHgvDatjTm9WXPyj2RnA2biRVYdIFA6vArHMeWI3Lk1QNJoRZo1702R+InuiG
         Pc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794678304; x=1795283104;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZNcZMolhjI9akx8wnIcso6bAnFZ7LtMgZRZy+seyfFc=;
        b=SrsJ/a+RbW5DOP2dvBpH1hzP4/yh3zoN69WigqTUAJ1kk+nHDHMuV1yW51eawwAGln
         djtOC2XB6eNncsjXbigIYz01RlS3ubdZ2kqqqZ8GPKUSKtjrn9rOfWsboJBSFM93+BLj
         a9+5H4yO87ogx2anElrQW1g595bkANbdlCQFqcSMuOua9OnLN5NvzlYne538LJvDVNOR
         /c/upZqmMBx2IXR0OAhjSwx+ieIEPwSuK1+JVhVQsWIfWS3Jc5orYTKxB4iKRqZmzDnq
         7TQKxR68O6t+WvGhrPANxATCopLN76d6/S5kGukJUuCOWtlY92GyPej8c94FeTw02RbH
         ZS1Q==
X-Forwarded-Encrypted: i=1; AL+hErGy1VXou2EpDc8ZX74Q+VkhsC8796FvTay7/ExFUr//AG13Jm+cMTGcJF1wiZJhbesQLVxt+OD+dvwY@vger.kernel.org
X-Gm-Message-State: APuU4Z+ZTZ14y/MUGou+34dILbIZ1qFn9WU1YgrKuLC3NEHaQ9oVi5rg
	wxVtbBgjzTDEpMlUZHtwl1tYCisPCLA3pzmsZQBDkgzXnR/MUuaNWUV3M/yEfhseUEE=
X-Gm-Gg: AYBFou0jXZCaAAydsVjd98m0elhQ4igen2GRurllydgLGn25YYuDCc456hsp/Lyh4Gb
	tLnx9gnGSEKCLFGRmmYnLF8s9vgcajq1pE++EJPheuI2KHbeT1g/8tkSyxSfJMJHWjpN7JfbA7c
	xPk+4yG9hQVfta0wZzVI5tBzFBWCjZOEub/HlNETW/g7RyOIkKouN3KS3chuMN3SRRcSKfuJHRs
	KDNR2pdjLdkDSru9ueELE+Njb7xben6S5cx0UJOTjYfuU1oiIUU66ODMJsinEDqGgctEhlnKykR
	PNjIP/sBcuVbtOVHLPdWh/fwk1IStfRN6QH82hxtrduB0ad3NVKOZGaUi5Jn0ryGKjC90F45xPP
	8YQZypRvDW0VtzYniBiT/YBw4mc8JJSk0qHmDWJhcP4UAxTHLHsAhhkgQkxzDQruRai4GfJ8JFu
	81bGkVqkBcBs48sK7LmnEZLhjW23ZqnNWztqZGdmwP6XzSk//bVrrdcdvVbttBB1n8I12KAkQ1g
	QuCKdn26e0acC6HledFQBldhw/GLDO3d5Zt8tjt4Fv0K7q5/k13wbFriTE4RxkFZuGW0/De/fI5
	wbWa1Mv4OYAD6pDZmmHz67vjS5C4f7RluWsHj2K6UEdeVYQwLWvAyPQiYluNOnysrF6FoDd9z4N
	KqeHDhZI=
X-Received: by 2002:a0c:f409:0:b0:91e:747c:f833 with SMTP id 6a1803df08f44-91f2424b367mr92045736d6.46.1794678303872;
        Sat, 14 Nov 2026 09:45:03 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d73258sm47539586d6.24.2026.11.14.09.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 09:45:03 -0800 (PST)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 12/15] mm/hugetlb: keep surplus folios that are
 reserved
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>, 
 Andy Whitcroft <apw@canonical.com>, Miaohe Lin <linmiaohe@huawei.com>, 
 Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 Dave Airlie <airlied@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Peter Xu <peterx@redhat.com>, 
 Breno Leitao <leitao@debian.org>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Gerd Hoffmann <kraxel@redhat.com>, linux-doc@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, 
 Chris Mason <mason@kernel.org>, stable@kernel.org
In-Reply-To: <20261028-fixes_hugetlb-v1-12-a0a033db180f@kernel.org>
References: <20261028-fixes_hugetlb-v1-0-a0a033db180f@kernel.org>
 <20261028-fixes_hugetlb-v1-12-a0a033db180f@kernel.org>
Date: Sat, 14 Nov 2026 12:45:02 -0500
Message-Id: <179467830214.482102.2328406932805572650.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-28 21:13 +0100, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> free_huge_folio() may restore a reservation, but still returns the folio
> to the page allocator if its node has surplus huge pages.
> 
> For example, start with no hugetlb folios and allow one surplus 2 MiB
> folio:
> 
>   1. Mount hugetlbfs with pagesize=2M,min_size=2M. This allocates and
>      reserves one surplus folio: free=1, reserved=1.
>   2. Create a 2 MiB file and write to a shared mapping of it. The fault
>      consumes the folio and its reservation: free=0, reserved=0.
>   3. Unmap the file and truncate it to zero. The mount's reservation is
>      restored, but the surplus folio is freed: free=0, reserved=1.
> 
> Besides losing a hugetlb folio that is required for a reservation, this
> can also make available_huge_pages() underflow and cause other issues.
> 
> Keep the folio in the pool if it is needed to cover reservations,
> including any reservation we just restored.
> 
> Fix generated by an LLM and sent by Chris Mason in private.
> 
> Fixes: 07443a85ad90 ("mm, hugetlb: return a reserved page to a reserved pool if failed")
> Cc: stable@kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: simplify comment and description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Was able to reproduce the issue and demonstrate the patch resolves it.

LGTM

Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

