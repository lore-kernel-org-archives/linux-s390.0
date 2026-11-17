Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904948;
	b=3NJ3Rld8kpe3ZJqP4wM60eJWFCmdMIslG/EbU0I99ugGgzpn8cOYF017pcB4MzCcy9Vc
	 S3vq+aNQRbdpStta8s9uU0N0vPK4i0Cege6hjwGdWhX0Viw5bh5gwiqV4KDno7j3w5/iX
	 NY6bqknbqbegZHnKlMYKFs5qeSIZ8G8nrPDOzmthZ+z63axERPdM1NG1kpf8n4TLVmcCI
	 0dcGTKHWLZ7RACrzKBv+Gz8Oy5qyJ/Ytr5BGesYLZ5lnqAcwfkeHsxXdv8sB7EAFfXQ8j
	 QCVhaN2s3zKAaVjmSq28czOijcjCPZMeQJcHnO5TTFMlfHnjPb+iWc67UDLBvTHqnXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904948;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=beHv4RWKzAGXqCj9AQIheRdqq9/SqD5ToQS6bWhTNyw=;
	b=m+F3cNAlZ6TS8v+Tqnd7v9+sFoTELuDicP4PW+HG67jvnUM2aja8QhfrfPFCK0TlWeQi
	 mx7PSsVTFlzG0zAXpmULVwPvb2RXwS2umJRVRS8S17OU6wicZtuctEf2fHrHSgkk8Gd5b
	 bmA0IA0t3NnWNmCXmBKr4BcV577PvoEHrRhomyBxst4vFgqqfcoTM44BqvyO1LviPQgdx
	 5R8eDWxzvO6LKK+xkskIBpAPSL3o6JiZirqlrMJflKR1uYLRlIfEWMlo+HFETpNHJFbF9
	 ck06jSVG6UuISXAGwU1iq77am+fSgJqMUe3F+5zq0GFZZ/uL/B+lAbFpXGjlNJT+SlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=iz47Vl8v;
	arc=none smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97C7606A88C
	for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 08:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E97C7606A88C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=iz47Vl8v
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91f0274f88cso71057986d6.0
        for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 00:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794904943; x=1795509743; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=beHv4RWKzAGXqCj9AQIheRdqq9/SqD5ToQS6bWhTNyw=;
        b=iz47Vl8v6JkIKZg9UYfyENByJGkp8YiAPJZj5aT+ZIWJtz26JLkljfdgVeOeTUHKpi
         fD+WdtGKspa4q2AxzmQeXoGQQk32iqFWo6zZZR3yDrVQ1vK/HbB3xBejTJBvr/T16oNW
         P1H614T3EMYfwy+o6FHrygopJOeOGa1XEaxFCJNqvbCTcx8I1gaWn0iBhdTWEqp6pW7I
         k8fPNOjH1RutKyHx2SDDsKfQoQn9h0StyHhNNC2VqNR0bEmdsDQA7kQxJTrh/gxuZqR+
         kfMtR0Yh9a2YiCZc6WHAGleSyiuHDgem22R+ssBXM/t8XJBZxYGh+Byyuv/RtLwZWCxo
         W/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904943; x=1795509743;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=beHv4RWKzAGXqCj9AQIheRdqq9/SqD5ToQS6bWhTNyw=;
        b=JSjkkyk5xjwyn8tBQ9UzvYPypMFqaWTAGrirTkBlvaen9Loj4ugCTqvDk/xkrboUy5
         S5BPWgAvyg70iW7wE2gclpmYnHDqt533JMM08JAFwfR2qUwe0KaORqfg1ksSFJJAQZda
         j4eWCTP8HrC/ChFeQSF22qJyE/EqI2uvjcX5/julNJ25CAxobXfA0b3PXgEfCKBjnoV1
         m7eq9OakgzHx2RHmb6lTzpBE4RUpDIFMF2q6YGJgwMTq2OoBVeKhaGRf1Orc32mU4B/l
         6lX60imwjj8TB8iBZ11rGfgAAtRFIfKBDgOM9HIGI3R9vzzBZJEKkmrMf8hblV9EuZZi
         NhqQ==
X-Forwarded-Encrypted: i=1; AL+hErHiK6y/hmd0iWtbcFwo3PV3GYj5uUWXmAaAOLie7MuKj3xh7YYvg/n4rFBwuoM6pwEaRDXqjqJQKhwQ@vger.kernel.org
X-Gm-Message-State: APuU4Z/uDjA9K5ZBmBjQlL5TqN/GpCsH8BjnvgnLEeav8qkpLaVr/+Xx
	qzMHLAbSJTmndVkLZeFG2TJFQrViI5e3I2zMgFRkSNVEUSCIUeULste4N1KtpeaA/VQ=
X-Gm-Gg: AYBFou3oaZSaJejG0wAihiUr0VRmPDL3bEyM7DavUZ12kH1KmWSMvUi9xuHFzed/qdX
	ZZQBTJZUZktHiWI6MyyKU8m+euryDvsSALJdl+YLsUlXe33lxBeyVGJpNJpUaLOUzh+cVifCQjI
	WgcPxgb7lAbqjKEkHF2BQbHfsSUYf7pQuaWGh4Szzg8BVqPvZEbqirLiq3D9fez6kbZw0o5pIFX
	XqMTF2PHe1sZlotw/07fvN/XuCUcWIB5pGEUNJ9kTe6MktXI1IeTrzntizAYfH0ujhNEfe7frSE
	NwLGbqVzHvk9jjFY3evXSrb+E4SoMnGxvx6NROb1YbdTlRABCB9qYuiFQHpmRdiKRedsajgtY/5
	cetJOwSfzvQ1hOk+VkwCDC3uKO7DOQ5g/QOXH8eo8eXRzK2NtAdLX1Leaf8z2zy72FkE33SCZEX
	ZzS03PYKkh/7prsbJAYO1qTfBDUewHjOM9LuKVFGJjOekZpLDXpgX+XrnOPHDsubzKMwylyssL+
	eRi+j2ncbGirS1RdzcK33AhAYfJlfGyGMVgqP6tGhj9ijrM4sdPVYVJfO26IjJWk0tkZ6oxZxm+
	t5qzc+gOrJIj1IK5vVKFe1yBiPK7CV4Dut5cSG54e2Q7tWRrNtRIdYFlYTPjOBtYvaqMTYUPPl2
	ed52iDZi6a49c4YUpqViORYydfcbK
X-Received: by 2002:a05:622a:758e:b0:55c:5ebd:8823 with SMTP id d75a77b69052e-55c5ebd936dmr138487931cf.66.1794904942797;
        Tue, 17 Nov 2026 00:42:22 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d37daf422sm44268211cf.15.2026.11.17.00.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:42:22 -0800 (PST)
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
Subject: Re: [PATCH v2 06/15] mm/hugetlb: fix mremap() racing with page
 migration
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
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, stable@kernel.org, 
 Chris Mason <mason@kernel.org>
In-Reply-To: <20261116-fixes_hugetlb-v2-6-4dd9e94ea9ac@kernel.org>
References: <20261116-fixes_hugetlb-v2-0-4dd9e94ea9ac@kernel.org>
 <20261116-fixes_hugetlb-v2-6-4dd9e94ea9ac@kernel.org>
Date: Tue, 17 Nov 2026 03:42:20 -0500
Message-Id: <179490494079.482102.4618915344813254218.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-16 19:29 +0100, David Hildenbrand (Arm) wrote:
> Migration of anon hugetlb folios walks the anon_vma, so the file's
> i_mmap_rwsem does not serialize it against move_hugetlb_page_tables().
> 
> There are various issues with that. Most importantly, move_huge_pte()
> releases both page table locks before the TLB is flushed. Migration can
> then find the destination entry and finish migration, reusing the old
> folio while the TLB still has entries cached.
> 
> Hold the anon_vma write lock across the move and the final TLB flush.
> This also prevents concurrent rmap walks from missing entries moved
> during rollback.
> 
> When we must allocate a destination page table, flush the TLB before
> dropping the anon_vma lock, then reacquire it after allocation.
> 
> Dropping the lock only works around lockdep: hugetlb folios are not
> reclaimed or migrated by allocation compaction, but their anon_vmas
> share the lock class used by ordinary anonymous memory. Having a
> separate lock class for hugetlb's anon_vma (like already done for
> i_mmap_rwsem via hugetlbfs_i_mmap_rwsem_key) requires more thought.
> 
> There is a concern that this can block page migration of anonymous
> folios quite a while ... which is not really different to what happens
> to page-cache folios today. If ever a problem, we can temporarily
> release the lock.
> 
> So let's keep it simple for now.
> 
> It is a shame that hugetlb has to implement everything core-mm implements
> in a different way that just screams for problems.
> 
> Fixes: 550a7d60bd5e ("mm, hugepages: add mremap() support for hugepage backed vma")
> Cc: stable@kernel.org
> Reported-by: Chris Mason <mason@kernel.org>
> Acked-by: Muchun Song <muchun.song@linux.dev>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

