Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F068D1C84A0
	for <linux-s390@vger.kernel.org>; Mon, 15 Dec 2025 00:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765760006; cv=none; b=RUUXhbbAvKLXF9ruERRNLNgnwe064i+3n0ZjokoQWtCujfSSp67uHUlC68VpYtWMnO74yBgrj144rbczp0XxR6GWPhMf+d1AsqXHmYTZ0WzUP3wVsSo+i5BK7WT4C9VkQgcNsjdecEBoNXM/4C5qG0z0+MDvBWKVleRJl/3nnoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765760006; c=relaxed/simple;
	bh=WkyKiF5z3K+l681MxAijPXdfs2UqVwfJOs959vTVdl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SbHmgZF2f/1AAmLVI0cDtUT2YduhWHpNJZP0YfmNyDYV2yZHo8GwfTEBP2oPniiRXDEWD8xTa3snDA6ci2ejaMUgg/YudUJhztF4S/Yf5wHRulNorq4LLeb/3btyXGqWRoSLTn9YECuabKlcMI8zWtuECqfEICt02bwPPpVI1xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JaE9BmZo; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JaE9BmZo"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6446ba3d337so2139733d50.1
        for <linux-s390@vger.kernel.org>; Sun, 14 Dec 2025 16:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765760004; x=1766364804; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F9g3zA8+/SS364XH9Hr1y/D4AwnbgxagYZf00bypWxY=;
        b=JaE9BmZomcb8F0JmEgvmzCsyA8P7mwM9HHpNNmhWJZ6opit8xNIVn1W/ld03q2vDrV
         6kVN5fFD/XtqpiVPe3DeoXpil6NvcVwjWldzILt42YKi21fjn1T3gR8z2QobEDAyhiR4
         rfHZkEu/1Kn6EnvLh4BeDhKMSyPE3IpulzoZKSSDdlqQ2tyLhAFP8iTXBSAsLs/J4teb
         opdzurQ26JgVNxasI3izcSEGhvjILQQvvIFBQbxarUW6DCoMnITmPkCQyF1aVYnkZZcY
         P+4pCaonLNQ0Q/TqEKTR2/1bD8Sb2oHYp0iR1UtbRe//14O0RDiKDvrbTBZszov5Zaxc
         HPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765760004; x=1766364804;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F9g3zA8+/SS364XH9Hr1y/D4AwnbgxagYZf00bypWxY=;
        b=amZMvD4+Rw4ocIsZ5/RgP25n2ws9t2Teyxc5TCw4c/l5UVtK8DCC0nD5s9xMC9QMvA
         REIp52hkW+IO0mMwmfCNchsp/psyZTc8HD9k+QK/f7bZtzSouMNQ2z+VWgLuEnT+rAbr
         DcVv8LV8k+gxMbFQcSzGZiOfx0b+/6tLIsm2k7Afwo8O468pz7m9ZGuMa9tygkvQvRET
         lyxfLDOVg9qhW+IQYjQ7uE4ImlbGGwQNYtibaceAkM1VZu6fw2D1NG2D5KeQu877mKNh
         AzU4fhgL6A98XpPB1RaLrnI3ahicFqYGa7SUd3tB6xxg9/vpWGLUR69x9N5+wKAHWpP9
         KztA==
X-Forwarded-Encrypted: i=1; AJvYcCV84MKiiqMu9t1KIx+lvE5qcUhPMXH19KNbPGWYFYWc9/q5+uyNpjesu8BX90VxiY+vsm/02bUtCJti@vger.kernel.org
X-Gm-Message-State: AOJu0YwmS6xlBwDAippYEbTohS9Qgspn/BB7FAbu2tYEdeR7Who0fM3g
	jkIMtCIkn0/V04MA762dwsoM0Iqof4Rba1ArqyS7Ui6CXFEkEoH4UkU6
X-Gm-Gg: AY/fxX5AV7F34E0nS+kuBpNzBuqa0/ruOxpv2QtHEWelUUSVR+amJyy8juHtm+o2AOY
	v0TSlBne/OH/Tdv7Z7bVQPKWXPaK20/D+wmofVfmbXzpdeA1MysJmOi8SF1R06w+KsB4tNqUCoU
	MhvRDOBMiIPBqnNs6T1PgUZU0pz81trRDtGiQwF8vs873oe1t3OBwgtKZqU1pzf4FJi4nWttvAE
	hHWDojnpPI7MafDiiLzh3seM3eLglSOL8B/4wftut73fmoT4jcIUokuVbUtgR7+db17OiFLf4yY
	h2z1zgPp6lX8zhpLRmk55wJrTJw5N98TnOY1GyTN/kEqXTraufF+UUUud0IUXJkqKfRkp8AmSim
	5uEsqSeNvW7lI5ubI4du5UdJFMN3Q408KxmpJZb95gtQbCcHlEUg7pesCowgwcdNCOtGiW5/MvU
	Csr/tElJamIHPlplzZYb6do8XYTV1kcdFmQeqK7Q==
X-Google-Smtp-Source: AGHT+IGymE1URbEHDhw5BX1nzGOTECoWjlfm2zsVFVoPWPkTZrOWD3CnCtM5DT/uUKOVkJdBDZchkQ==
X-Received: by 2002:a05:690e:b8f:b0:641:f5bc:6950 with SMTP id 956f58d0204a3-6455567e9admr7325417d50.84.1765760003993;
        Sun, 14 Dec 2025 16:53:23 -0800 (PST)
Received: from [192.168.2.226] (104.194.78.75.16clouds.com. [104.194.78.75])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64477db6599sm5753649d50.21.2025.12.14.16.53.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Dec 2025 16:53:23 -0800 (PST)
Message-ID: <52e2c1eb-67cf-41ee-9088-760fb6258153@gmail.com>
Date: Mon, 15 Dec 2025 08:53:07 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] mm/pgtable: use ptdesc for pmd_huge_pte
To: alexs@kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S . Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Thomas Huth <thuth@redhat.com>,
 Will Deacon <will@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Magnus Lindholm <linmag7@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org
References: <20251214065546.156209-1-alexs@kernel.org>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <20251214065546.156209-1-alexs@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/12/14 14:55, alexs@kernel.org wrote:
> From: Alex Shi<alexs@kernel.org>
> 
> 'pmd_huge_pte' are pgtable variables, but used 'pgtable->lru'
> instead of pgtable->pt_list in pgtable_trans_huge_deposit/withdraw
> functions, That's a bit weird.
> 
> So let's convert the pgtable_t to precise 'struct ptdesc *' for
> ptdesc->pmd_huge_pte, and mm->pmd_huge_pte, then convert function
> pgtable_trans_huge_deposit() to use correct ptdesc.
> 
> This convertion works for most of arch, but failed on s390/sparc/powerpc
> since they use 'pte_t *' as pgtable_t. Is there any suggestion for these
> archs? If we could have a solution, we may remove the pgtable_t for other
> archs.

If s390/sparc/powerpc can't align pgtable_t with others, we have to keep 
the pgtable_t to bridge different types. But we could take step to 
change pgtable_t as 'struct ptdesc *' in other archs. That could 
simplify and clarify related code too, isn't it?
