Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=96.67.55.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794870223;
	b=B9ATCpPjCtWGKFFYnS/l7Uv7jTbZGd2Nt/TdDUagc9YxH3RYkAgC0RpqbSo/MgGYlxTU
	 On3lOkcTkeSUxVi9JE3J9KS+tm4zNsmPvY5z+ipcGPDP+ikcoRWC8mA9rTjgNC8zNsGtH
	 /wFDvzxFk1iLJSphKfem++qOemtqFy+XBtyFkiIjRWY5OmE6B2nXncuhToEszhBuQdeoR
	 vY7MOwgMqNM73/4M6nMQxY0QxGKsMCMsSZX1lgwKtnMk4sAduQw1SGvlNa4/FhRXA75MH
	 w0cIvFdH7fPJJMM2AmGDg29h1H7iCzS9aCQt7kbZWI1pWqxDZPyXnC5FvpjSgxY1Bpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794870223;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=IVgWDrzcdGHN1y6Zshz3gk11ql+dGTvhjArhMrYEQ6w=;
	b=V8Bfa2eU5e+OTwNFXbqxhZLXKMxfgKVPMtmBln52WYhEQM/aZn9+rL6rDj9iScE1gf08
	 5COrZ9+mgf/uTuhZo0rl49ucM4y3+Wnsv/ndV4mGr/OT4FiA3cptbEG/UnLyGdhNnaC67
	 eT1fsri7SO/v4TGEJsSuJg6ajKsuhzhhlfa1IQg0nOU4B+APQSsQoV7TbQzFTN20flzL6
	 vsf6ArdGqT3KDgOwPz2VAbbCU5KHRq387hqZLNFAIqBmpxY6WVDaKvDi3FUvmo2Tv8YjZ
	 pF2eZQQqSCPMvVvZqbr+I2FWdwAF3oD/gW+tE33ZA00HX9HZacsZjY6gL7bST+sRp6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=surriel.com;
	spf=pass smtp.mailfrom=surriel.com;
	dkim=pass header.d=surriel.com header.i=@surriel.com header.a=rsa-sha256 header.s=mail header.b=Dxk+QBhb;
	arc=none smtp.remote-ip=96.67.55.147
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE89606A31C;
	Mon, 16 Nov 2026 23:03:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CE89606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.a=rsa-sha256 header.s=mail header.b=Dxk+QBhb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=IVgWDrzcdGHN1y6Zshz3gk11ql+dGTvhjArhMrYEQ6w=; b=Dxk+QB
	hb6dZ6KmZa+hJakYWtYDdfO+tvoDqaBizMEnCmzLyhwBVwVYz+qkFYQbhbHuESub90ch9ATj9p92m
	r41oe75ZGsnVznINep8+F60I+PKMXgR0cZjivLzb7YY/G35qq/spOd4dNeypHy1K1bQJiOj/kXD8V
	BPApD/wz7RdeWQirTBxhAOhkr0XYCwwH55GJ5WxqOGh2tAnIGTbaTtl3riTso8KQ+yx4/U8WSc6OB
	gjtsTpszWWcDn/VVkAIF1rJRitJLJEdz5u5WFfbam2Fq1PTMnO8co6cmPhUUvlf+XA+gtxG0QhedO
	oZLGtUnKo9W2UEdMhnrH2A4fv8fQ==;
Received: from [2601:18c:8100:a0e0:5a47:caff:fe78:8708]
	by shelob.surriel.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <riel@surriel.com>)
	id 1xT5Q5-00000007pj3-04ju;
	Mon, 16 Nov 2026 22:43:25 +0000
Message-ID: <4243e7f0873529106634ef3f720b7c7035750599.camel@surriel.com>
Subject: Re: [PATCH v2 03/15] mm/hugetlb: preserve reservations when
 shrinking on HIGHMEM
From: Rik van Riel <riel@surriel.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>, Muchun Song	
 <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, Naoya
 Horiguchi	 <nao.horiguchi@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>, Andy Whitcroft
 <apw@canonical.com>, Miaohe Lin <linmiaohe@huawei.com>,  Michal Hocko
 <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>,  Vivek Kasireddy
 <vivek.kasireddy@intel.com>, Dave Airlie <airlied@redhat.com>, Jason
 Gunthorpe <jgg@ziepe.ca>,  Lorenzo Stoakes	 <ljs@kernel.org>, "Liam R.
 Howlett" <liam@infradead.org>, Vlastimil Babka	 <vbabka@kernel.org>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan	 <surenb@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan	 <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Peter Xu	 <peterx@redhat.com>, Breno
 Leitao <leitao@debian.org>, Will Deacon	 <will@kernel.org>, "Aneesh Kumar
 K.V" <aneesh.kumar@kernel.org>, Nick Piggin	 <npiggin@gmail.com>, Peter
 Zijlstra <peterz@infradead.org>, Heiko Carstens	 <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev	
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>,  Sven Schnelle <svens@linux.ibm.com>, Arnd
 Bergmann <arnd@arndb.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Gerd Hoffmann	
 <kraxel@redhat.com>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
 	linux-s390@vger.kernel.org
Date: Mon, 16 Nov 2026 17:43:23 -0500
In-Reply-To: <20261116-fixes_hugetlb-v2-3-4dd9e94ea9ac@kernel.org>
References: <20261116-fixes_hugetlb-v2-0-4dd9e94ea9ac@kernel.org>
	 <20261116-fixes_hugetlb-v2-3-4dd9e94ea9ac@kernel.org>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33A
 eo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47
 Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/
 lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdY
 dIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gU
 mllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986o
 gEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/
 r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHV
 WjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o
 6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635
 Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE
 +BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTe
 g4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/jddPx
 KRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/Ne
 fO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z
 3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0Mm
 G1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tP
 okBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznneko
 TE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44N
 cQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhI
 omYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0Ip
 QrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkE
 c4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, 2026-11-16 at 19:29 +0100, David Hildenbrand (Arm) wrote:
> try_to_free_low() drops the hugetlb_lock while freeing lowmem folios.
> set_max_huge_pages() then resumes freeing folios using the
> min_count computed before that unlock. Reservations created in
> between
> can consequently lose their backing.
>=20
> Collect lowmem folios on the caller's existing page_list instead.
> Keep
> the hugetlb_lock held through both selection passes, and free the
> combined
> list at the caller's existing unlock point.
>=20
> Likely not stable-worthy.
>=20
> Fixes: 1121828a0c21 ("hugetlb: call update_and_free_page without
> hugetlb_lock")
> Acked-by: Muchun Song <muchun.song@linux.dev>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.
