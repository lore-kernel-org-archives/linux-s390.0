Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=96.67.55.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794870153;
	b=TkF9CV/AWA0UwwLsnHuf/3MAvlru4j1BK/KaKQgtfbt9EGWk8i9ZadW46uCWmuvv5q/7
	 FUbR1vdaoIukRzaz9CBlSECrEISR12fcmEMxzXlx/fqdHsNlcGK5GNC/LF4EpwdPyvYDO
	 cR7kdVCiGFRioIhn/EiyLGdZNXUdpWI/uB0hWQ71bKpIMeQOwF6fiDXaX0Lrr5GpXgpeu
	 V2LQrSdM1ASquWauf5CjKls+gFVBLnEbmguW7oGWaVZGaljePJIKeyJpjQN1kcXRQtYRp
	 MJKTx5FRF7OxfpXPwtmzb05oH3SC2FiT0RHg/81P4FrRJwWfVfW2/qzF/t4D8JF2yOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794870153;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=5WThR+UqE34o3lpC1ytNuiTjImnwIUnQa1repMccPxg=;
	b=iRL4nRgr2TGL4+NkZKjCyl7T/dA+28c+3/GCsl7IIuSujRZm4os1ClF943s3DS6B/lK1
	 8ujsTCW8y3xb1WrUIGe/YFyFy0ysQhYGJv3C6I5I85qqucdmRcnfVJdFmQ4B7SzHSUFqo
	 6t5g8u9EzYmziJwUEvaWteirEZM0L9yWxRVYxmd3dq3Bq/jYkTDsArWyY8tshNltjWSPI
	 hWDUYWbulmz7cvwd9VXn8UHehCGgXR3nbrV+Wb7dTsw6grcVdsb3ESFijMwzUaZFJE2al
	 PYKfHXnRwM0Rc+kbj3eG7THfwmgNOW/gn5nEO7HIKY09J5lNgpreWep+ynVPVZuXgcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=surriel.com;
	spf=pass smtp.mailfrom=surriel.com;
	dkim=pass header.d=surriel.com header.i=@surriel.com header.a=rsa-sha256 header.s=mail header.b=RmszHc0C;
	arc=none smtp.remote-ip=96.67.55.147
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475B7606A33F;
	Mon, 16 Nov 2026 23:02:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 475B7606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.a=rsa-sha256 header.s=mail header.b=RmszHc0C
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=5WThR+UqE34o3lpC1ytNuiTjImnwIUnQa1repMccPxg=; b=RmszHc
	0CnOPJyqg+tKPcBjBhz42YOx3X1P8KCM7qlREN/a2q0VePJ6bbwZ1XDxOMA+O3vEMeR5SpSV57ef0
	rQ+EoIPicylm5jWyeIlqJWCrf1koFnPGUflTUl2VxKWaaXokosqmEamc85QY5RMdjkXoaY9LN77Gh
	EZzUnQFmYrfzWalegBAAo3FNepH1iapFTh+8StCMtGkWYiRLlLlR5+xpqJYjFmqWnQHUQ2aell1PX
	yxs95QLzbQofCYE0Uw54aJpcA6padqu7/yqPdz6LHSCbXxwd9jIesHqHgCoWykqOA8e1fqmLyBeeK
	7daeliVGFLW0sTbeXP3XtYph3cBg==;
Received: from [2601:18c:8100:a0e0:5a47:caff:fe78:8708]
	by shelob.surriel.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <riel@surriel.com>)
	id 1xT57N-00000007mDE-0p4b;
	Mon, 16 Nov 2026 22:24:05 +0000
Message-ID: <b2262da0652b467673109d12b5e244c15255a925.camel@surriel.com>
Subject: Re: [PATCH v2 02/15] mm/hugetlb: compare against persistent count
 when freeing lowmem folios
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
 	linux-s390@vger.kernel.org, stable@kernel.org
Date: Mon, 16 Nov 2026 17:24:04 -0500
In-Reply-To: <20261116-fixes_hugetlb-v2-2-4dd9e94ea9ac@kernel.org>
References: <20261116-fixes_hugetlb-v2-0-4dd9e94ea9ac@kernel.org>
	 <20261116-fixes_hugetlb-v2-2-4dd9e94ea9ac@kernel.org>
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
> try_to_free_low() gets a target number of persistent folios, but
> compares it with "nr_huge_pages", which includes surplus folios. As a
> result, it can free lowmem folios below that target.
>=20
> For example, with two persistent folios and one surplus folio, a
> target
> of two can still end up freeing one persistent folio.
>=20
> Compare against persistent_huge_pages() instead. Convert the macro to
> a
> helper function and place it before try_to_free_low().
>=20
> Fixes: 7893d1d505d5 ("hugetlb: Try to grow hugetlb pool for
> MAP_PRIVATE mappings")
> Cc: stable@kernel.org
> Acked-by: Muchun Song <muchun.song@linux.dev>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.
