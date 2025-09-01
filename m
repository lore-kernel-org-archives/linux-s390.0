Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B405533EB0C
	for <linux-s390@vger.kernel.org>; Mon,  1 Sep 2025 13:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756735114; cv=none; b=lG8bAn0MUU8qLOVNbPFsIo5/0mIYfVStuk2l3SkEF68bggzU4JsxyjJ0DR2OUQS1reFZFMMsH9UY38raX0meKdLPxQ96O6Fhi9dL5pWedmzVQanXy95y0CENMsuMyUi5JVXXnRR/g1AUPr+0YANEhQr+RkmB+ts+h5s7wAo0CjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756735114; c=relaxed/simple;
	bh=BcXA+zRMUU3us2dPmusS9uKdoGlno2BlPUSlioMI+VY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rvWzpYKxmKCP/eoUXvj1/3FXUp7Axo9hwJjUbwO2LvIJLYT8mHMwdobX+Yay+PaCBugpeA+Sl6eyg2K6fmSSq24GfLTY1ur5SB9EDzT6QDpMwgJc5LCUCNvsRF8V+iBVfX9uNSOXqW1v8ovxf0HUuR8SeYkb/VmCeYC5IsMRExI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MQf6XXzN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MQf6XXzN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756735111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ouEgWBG9S9w8yO368Oo6KmFAlN0WSbR0WI/SVZscpXU=;
	b=MQf6XXzNGtBhtWHo/V3JYz4S6Cupf66RzXQl+a4/9pjscLBL2Jaf3+rMlkfKUZbS4SBY1m
	n+JTHWVx4EQGF44/ZPi9TugrLF8/RRGHaFyzyIZILHuTxlZLLZMKFGSuJog9K0DfjOajWJ
	c0b5FPoYGD9RftbTsQ75kN40UCrcpYo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-k_10X9Q_Pja40BClxeOIRg-1; Mon, 01 Sep 2025 09:58:30 -0400
X-MC-Unique: k_10X9Q_Pja40BClxeOIRg-1
X-Mimecast-MFC-AGG-ID: k_10X9Q_Pja40BClxeOIRg_1756735109
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ccd58af2bbso1907491f8f.0
        for <linux-s390@vger.kernel.org>; Mon, 01 Sep 2025 06:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756735109; x=1757339909;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ouEgWBG9S9w8yO368Oo6KmFAlN0WSbR0WI/SVZscpXU=;
        b=bTTA79SyvVhaPs0Ee7AbKL/aNxKt6Gnj4otLtuFa0YslkG7d+pR1ox35qErwOvE9bl
         5l4ZlQFH6OhMUZR+KJM82vYI3+QKyecnDEUEbyj5nIfzktRX1eRB5D1eukLe/7yfu73h
         f8MXvIl/QGg8FXiNkobED+xXUmAIlJiE/l/lsG5pe/wJ+G4PoPb5NcCHL6TxVPk2+Tl1
         PLorDafjRWEXJNpsJUg1lGCJK8O/HsC/h+VltZr06DgIZBzc9Q6SPlpk09ax6jzfrIuc
         x6wChx4VEFVFV21W3i83xfy4VIO+oPQERDGPl6z2e9wMd/kafr6QbXjs+r52xhgSWV1B
         0yYg==
X-Forwarded-Encrypted: i=1; AJvYcCV2AoYQVGHLAPBhdhGhR8GL2CjLvI5bb/xZkiBVKFZoiJ9Vcaw+MCC0opt82BYu2tj13ItBBYy/Wm1j@vger.kernel.org
X-Gm-Message-State: AOJu0Yw20O6+SmCpdSvWeTpbGG5G60+WfsPNDoNszsqtgSPi9cN1Jt3n
	NhG3qlH81nAw6IbTr9lN/cyqZmB3zyewITIJJxMXjbPT/aUC04f4YJD1n1iP4wt7sxh03Fsxsa0
	t3BEms4L9VyfJGQDY6EGi8/e7tGqMUriCB9RHncYFmFKZRPy5ApHEP0z5InN/MRk=
X-Gm-Gg: ASbGncu+THy7zFOZyEOsaLmr/i7g3rTlmg3hhdIqFT6e/NIF5LdGEc4e/lRwFTYn9+W
	PY781r9GJzjNuKXfzBnYGD3ZGqDiQZpKYEKSOp/VFR7I10880/Xv0CZ7P6zKL55mnNZ3Fwu+iRc
	hraNQkY2c1zIZTwBtV2CUj9i1nJIhLkNX8lwIsVLXeYudeRFRUo55VkSzMeyDh4Hm6wtuCAA56e
	BYQpvUyHdywZSrplw3EMpl2/WUWZOZDCOS/nUpNeCb8Q4GUP/51KJjh/vzkp48GLET00Vck9hfM
	Qc97xy/pzxfvMYiW77ICIM0kJMkR87GvQj1VPfgB7Z0YFskmrhmZMAG7TGyKrHxyX3S6arKc+Se
	ZESsC2+uw3x4iUQdRdy7VIRcvjp7q3QPM8Yl9GBf11OpWwJD+hIYmZKOmOaIlkmlI+WU=
X-Received: by 2002:a05:6000:40da:b0:3cd:b0c1:f9aa with SMTP id ffacd0b85a97d-3d1de992040mr5005452f8f.18.1756735109319;
        Mon, 01 Sep 2025 06:58:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRno0/4M5FVI51DPUT+NywmYwJkSgIjJ2gav2/NLIxgn/5SvMqgqXvkYf8AQzTH6ogoMO3qw==
X-Received: by 2002:a05:6000:40da:b0:3cd:b0c1:f9aa with SMTP id ffacd0b85a97d-3d1de992040mr5005405f8f.18.1756735108751;
        Mon, 01 Sep 2025 06:58:28 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf270fc496sm15630922f8f.1.2025.09.01.06.58.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 06:58:28 -0700 (PDT)
Message-ID: <b379e134-d946-4c11-b5ba-0344c852d49f@redhat.com>
Date: Mon, 1 Sep 2025 15:58:26 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/12] mm: constify ptdesc_pmd_pts_count() and
 folio_get_private()
To: Max Kellermann <max.kellermann@ionos.com>, akpm@linux-foundation.org,
 axelrasmussen@google.com, yuanchu@google.com, willy@infradead.org,
 hughd@google.com, mhocko@suse.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, vishal.moola@gmail.com,
 linux@armlinux.org.uk, James.Bottomley@HansenPartnership.com, deller@gmx.de,
 agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 davem@davemloft.net, andreas@gaisler.com, dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, x86@kernel.org, hpa@zytor.com, chris@zankel.net,
 jcmvbkbc@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, weixugc@google.com, baolin.wang@linux.alibaba.com,
 rientjes@google.com, shakeel.butt@linux.dev, thuth@redhat.com,
 broonie@kernel.org, osalvador@suse.de, jfalempe@redhat.com,
 mpe@ellerman.id.au, nysal@linux.ibm.com,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
 <20250901123028.3383461-10-max.kellermann@ionos.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250901123028.3383461-10-max.kellermann@ionos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.09.25 14:30, Max Kellermann wrote:
> These functions from mm_types.h are trivial getters that should never
> write to the given pointers.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb

