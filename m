Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904455;
	b=cyTjsoYl0vIkfb1y78qfAm9KK1aORFX7rugERpjO4+9xqMlOEuAEY4X2EixFwiHxbdha
	 2APMW8Pw69JNZeAPj1Sa4Caq1RnZ7TcSY6vsV0GZT0n9IKlpNUWBRTpY0F2Bx6QcfHEoa
	 LOtcJJnUAtbjf/NUonebwU0t9RclQvuNps+UDwbJjAS1PjfoPkn1e8ir5bFNvsPUwHLWe
	 UyzVojK5iVLipYIunkTekL5iZl3UawVvnUt2UylSLkN8RZWqOjYAQ4rWDinJjYSF8nrhX
	 udw68OFMftcrEQXMFlCSMUE86SuIppYKRSr8bz0mtBwUdB8gqP3SLJgtnxBWnXkZNTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904455;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=GlfPsRE+i3fF5U75sAmCvXCcdyZhOwjsZrTZwssWtpI=;
	b=F0JIMBQ0iB0BlIz4ebEW8T7D92oYPtxbUHECbY1xaPg7UrjRQIli0fA/Ik1Agak5eV2i
	 ft8h/yo1mNFLGiq8Y2veYN3MsvOf1KIrZJLczwMPsHjE/D1v6h7CJ1zULo5YYEPU/RZIL
	 gkxPJgUoGKhd0fNqK7oZekeP72iEo+++Nq46g8RxtrU/EQ5LzyoWlxGb5YJmSGicQDwha
	 SRBll9WEKCrz/zQqJXDcToXxiSJdud1CiF/aBv5IfaOE0pg8g3biu+DVGVCrI/FjdoQ9W
	 1OVQMgG3DwBfu89hF0fsm3BO/VLpQFFM2nZ874un8marZ7vFXpeBgFIaok4HwFSKQKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Ajp9T7xx;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39A2606A8A5
	for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 08:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D39A2606A8A5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Ajp9T7xx
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-53644ab1f7bso43487781cf.3
        for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 00:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794904452; x=1795509252; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GlfPsRE+i3fF5U75sAmCvXCcdyZhOwjsZrTZwssWtpI=;
        b=Ajp9T7xxRJnckbguTgRPsP4gP7ggcnMM2Non8C+yfW5N1NAn2O0Q/Op51B10esi8KO
         cT1QYNfljSecakvsb1tR/hbp5ii+N2C1SQRO5eg/t2RsutoaVZEBO63zdqgbyDS5QRZm
         ilg7WysjeJtFO3ioc4r+QSX3DSDXEujufPRNTgaethlsDC0AKr9+o3fWAovz72E0sL8q
         Yx8yRjXW9Qm4H7uIShTpYdjiG8t/jzEAMZsJrxdGZ4Zf3udWcZX/D3Ul54fwpj6boYBy
         Fr7x5iY0EgzeW9DGxrXqMZIa3hxvoh5Ea3aHbyrHezwcgi997p7vTuXIwrmzmze6/thw
         GHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904452; x=1795509252;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GlfPsRE+i3fF5U75sAmCvXCcdyZhOwjsZrTZwssWtpI=;
        b=ns9bd9b/AErZdtlPcr+LSAfivBe7LbwSjpu9l+SSNHuIRrUjToLXgS75cK34xcQdZf
         /YqqLm+cDFQL6U9isyhXv7Cb2q35ny7BXEXlDWfyuTqp5QokEU/7eBxryvG+rttC2Gt1
         tEaoOT9nNwNlgoZwbtUpl7YPgnK5vkMgyjJxMdyvuyrp98drcB+0mFRfEj/dg3GYVNzY
         BF6HQ1KVa2aGgB2sMjSNQpVc5CUvHl5EARQKeU1YJ1hWTXUyGNWnsMnIXPy5Ue5VieiI
         8Vp/S7oh6YYV+pUt7oyX+YKGZLGZMPQPaUVJEnNkyoiHZQ9mw+4vp5JN3gkCf0iIoBVg
         gnvw==
X-Forwarded-Encrypted: i=1; AL+hErE26GYvYwqDGxpjtJO2ocE7A5S6XYonmjBAunqJ2JKjfKHbR6bNvANw/WZ9BsTTNY7nJP93Mk1QctJU@vger.kernel.org
X-Gm-Message-State: APuU4Z+RZXbF+ouQIYPekLuyplGLKFpHxBVKMnyLGUfFDxiaW8ZHcS5J
	l03LVzVoO2jM8qZeCfJAgeH1fDhrn19hyoTzM6bz1NU3ljIfAPeup2+OsvZjIe7HOCY=
X-Gm-Gg: AYBFou27UY9Kjrkt9FNMVXSGk0hx4PXD76b6GxA4heu09eCAxTLDl9YRdaabk3E7lxa
	8o/NlY3IoA0o9hjGNAWIHd/ww8Xb28BjshAzuQONdelktfGRgpV6I2qA5fiyWcpKpNHrhzVZ2w2
	87w2I2kVkhPKRcixJH+1E0i9kJFwClTysU8sarhT17ypgGhEhNy+8ZASaimYxdVlqLyZdV6pE5Q
	8cbvv8G2fI66KfaN05cTmUIFuHIRBK7bRBpObitZZ03ove6xUnMvU4QnR5ybl41rpqGP/ac+x4P
	mOI5JrVa6zzRhp12ElTlTH8daHr6Bwa8df09QIFIgbwmGyzm89E25Co+Lhm9kSBMNgnl5l/8Fvg
	xwDQ7wGhggt6E7Mn5lKD55GuHCJZIBYIenW/z0QaijDdBvqETG30ToNf1nsjtIvo2y7+oyTwY38
	ZihhMjYA/Lt8EvvA0r9gWTOngO2D4Y23pxvIjWByi250VayZSVJOWaFnegosq4msgmRmdszGT2b
	YY61rbo3FYWR+xzVn/10xaIQAiV3e0kBLee1F9r6Lvfqbaj+ioXhXdqna4sAhxKQJBAJ5Im9iTG
	4iHY3Ige/1EDB01ThrP1VUMAtCAH6Vez62mrqx9xBHjwZq8G6p4sdVJUhpf+bavrJ/X/+wIniKd
	QAfJfuYo=
X-Received: by 2002:a05:622a:654:b0:55c:b6e8:bb92 with SMTP id d75a77b69052e-55cb6e8c1e8mr144922231cf.61.1794904451796;
        Tue, 17 Nov 2026 00:34:11 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ace15ce7csm100171991cf.1.2026.11.17.00.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:34:11 -0800 (PST)
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
Subject: Re: [PATCH v2 09/15] mm/memfd: recheck the page cache before
 allocating a hugetlb folio
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
 Josef Bacik <josef@toxicpanda.com>
In-Reply-To: <20261116-fixes_hugetlb-v2-9-4dd9e94ea9ac@kernel.org>
References: <20261116-fixes_hugetlb-v2-0-4dd9e94ea9ac@kernel.org>
 <20261116-fixes_hugetlb-v2-9-4dd9e94ea9ac@kernel.org>
Date: Tue, 17 Nov 2026 03:34:09 -0500
Message-Id: <179490444979.482102.6690559604747930966.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-16 19:29 +0100, David Hildenbrand (Arm) wrote:
> A concurrent fault or PIN request can populate the page cache
> after memfd_pin_folios() misses it in the page cache but before
> memfd_alloc_folio() takes the fault mutex. The latter still tries to
> allocate another folio and can return -ENOMEM even though the requested
> folio is already cached.
> 
> In particular, hugetlb_reserve_pages() finds the existing reservation-map
> entry and reserves nothing. If no global reservations remain,
> alloc_hugetlb_folio_reserve() fails even when the pool has free pages,
> effectively failing memfd_pin_folios().
> 
> Recheck the page cache before reserving or allocating. If the folio is
> present, drop the lookup reference and return -EEXIST so
> memfd_pin_folios() retries its lookup.
> 
> This is probably not worth backporting to stable.
> 
> Fixes: 89c1905d9c14 ("mm/gup: introduce memfd_pin_folios() for pinning memfd folios")
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Acked-by: Muchun Song <muchun.song@linux.dev>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reproduced using udmabuf to race and generated very consistent failures.

Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

