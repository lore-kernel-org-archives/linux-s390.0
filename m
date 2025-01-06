Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3948A1DC98D
	for <linux-s390@vger.kernel.org>; Mon,  6 Jan 2025 13:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736170510; cv=none; b=UVh4O1KdovyYcuCzd7fFFwkclBEJLy5SuyrgvgNMSC7uRTWTRJyxVV93x4TJZpBlRjM9i/XaRUn3vBqjnnsRhia39TI26u/98f/nRD3vMECqndARvwFwfvFEk2fOb7Zn8c+P8c7kUrBmT6QtrjCz4OgYUneAcEae7oDcvwwZQTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736170510; c=relaxed/simple;
	bh=rzubnT0gas16PzeOBWAv24OQZ7te5xw5qxzCAysoAMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A6G9PZ3xRfeaMExvuuDInSlkm/KAyFvrT2v4p2R3DSTs4rnJQdtGZXnGze0XLX6mzMBimrfeHN5RtwJzDqd2iRoarKr7A+TVp8xR5gxBrstGdHYXa83kefcD1545t4V1dfPNkfZRm9HJoTQNNB5SSroJ9ZJWo5EbPqYcTl4IWPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=F8yWxxpn; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="F8yWxxpn"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21636268e43so22626355ad.2
        for <linux-s390@vger.kernel.org>; Mon, 06 Jan 2025 05:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736170508; x=1736775308; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dSl9CiTNSQwE0RKlCdBtogvBaV/TE9/iFGVUzDM7I3Y=;
        b=F8yWxxpn99xl6RSYcERdON6gNNnB5asuoZxu9+IiKhnbHtzVBKmaMwFOzzQbvYhySj
         nh6VUUrLeDq6AAXMXq/jAJ2VQolB9McY5VZE0rbL5jcDDdnEFC46jw/4AhXX7aen6Ty0
         UNa2mEJlz1X9sq5S+X9LBViB3JGYE2nlUvFICMDM6UWb6v2sF4soUCtUVwnWBF5Z/TWe
         Cd1G0zka+EO70usIOt9JQR75ipBZxl2Uz8loGmmPvNgXkiKeYK4/PpzvaxxzLEOLJcUj
         Z41cGVJP9D2tjsC373FIWLE0htTiClZQVQ6GqdjjSBFlJ3uLdhUpZgLJYNc+e0KD9w7m
         97mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736170508; x=1736775308;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dSl9CiTNSQwE0RKlCdBtogvBaV/TE9/iFGVUzDM7I3Y=;
        b=c19ZOp8+YWH44MsTYTBQgU3anFQLsx4jC2OBSb5hQV1ZptKdNCahSVxlTmSo4gXItM
         gRgv5Z/eu/HgqS93mJK70oRSYsakPNgyuumgV/BbY/MJ08CljdKr/pRdyqCw2k4zJO9l
         yvAUF4okYZ6LSo3R488NGgu/BTSsDJPYPfG77xcsupKzUeaYvJYREUuXIsle9nEvDHsh
         T+qfAB7JxVdDbta/rV8Ng2NuMHMCyiVtnCQPFkxvwrFqxfYmqyX162tdn6TPOCh09BYh
         ynIS1MjshNFAmMvu9ZLZBhgEzgJStV+KKRbtSuCUBG/H1uw3BVAtNEezGz9F5NhVVXFG
         36pw==
X-Forwarded-Encrypted: i=1; AJvYcCWhCZSL6UzgRnG7izEsUYQRZfVv50ndqFrdbkBwmaqw8bnJ4Ga/OGPEd7ogOz1wi3a+pJzjP0U3v8kP@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+iJc+o1Ql7HtzGAH3g4UF8VzqW9VfrkAV1So3W4pKbhew1UZG
	ToelqGq1PZgtXxVBuhy2uOER/apPiBSGv/Y2lIsEs1S7eMtOYOmvyzrED1Zvbx0=
X-Gm-Gg: ASbGncvox5BwiTqRFxLTZez07Ek/OkJRLxRelze7KZYAkcHuRW749qxYtSiIj0gKImW
	NugY3l/kyC8sIOM8QDDMvZ6RjEP7Vxgf7XtVHiPkTdYockLmN3mmYHIj7X1paFRVTalUk2mQKYr
	ps+u4L/TlEBhWo4QvGvPFOR1aqlBZQGxE2eSKcDXGpUvi8rOYh4mmT2Kd7oVRiaPh+kJTz2LYld
	/nWg4EBC+9esqbWBXuMXVjyUaxxBLF2JXWsewpdIdBZiWA0DQRsLjPSj1rSrlTKp+kg7JL+uPwY
	+r6eVPjZCmBFVKWKmPbUgL9bTg4bTsaEy88xfxcNumvg+/Meq9+X
X-Google-Smtp-Source: AGHT+IFuxfmftFbdw6fO4bIMnZYJ/q+si7Sq93AxF4PGQarIeYtLJTB7gRBGy3tWc8bUzZwj1LueBQ==
X-Received: by 2002:a17:902:e844:b0:216:3083:d03d with SMTP id d9443c01a7336-219e6f13c50mr852868805ad.44.1736170508636;
        Mon, 06 Jan 2025 05:35:08 -0800 (PST)
Received: from ?IPV6:2409:8a28:f44:d64:296c:a8f3:f81e:f88b? ([2409:8a28:f44:d64:296c:a8f3:f81e:f88b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9cdf02sm292469725ad.151.2025.01.06.05.34.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 05:35:08 -0800 (PST)
Message-ID: <57ea8193-2fd9-41a9-85b4-7af924f900f4@bytedance.com>
Date: Mon, 6 Jan 2025 21:34:55 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/15] s390: pgtable: also move pagetable_dtor() of PxD
 to __tlb_remove_table()
Content-Language: en-US
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: peterz@infradead.org, kevin.brodsky@arm.com, palmer@dabbelt.com,
 tglx@linutronix.de, david@redhat.com, jannh@google.com, hughd@google.com,
 yuzhao@google.com, willy@infradead.org, muchun.song@linux.dev,
 vbabka@kernel.org, lorenzo.stoakes@oracle.com, akpm@linux-foundation.org,
 rientjes@google.com, vishal.moola@gmail.com, arnd@arndb.de, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, dave.hansen@linux.intel.com,
 rppt@kernel.org, ryan.roberts@arm.com, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
 <ad21b9392096336cf15aee46f68f9989a9cf877e.1735549103.git.zhengqi.arch@bytedance.com>
 <Z3uyJ2BjslzsjkZI@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <2d16f0fe-9c7f-4229-b7b5-ffa3ab1b1143@bytedance.com>
 <Z3vQHplZqtHf6Td8@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <Z3vQHplZqtHf6Td8@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/1/6 20:44, Alexander Gordeev wrote:
> On Mon, Jan 06, 2025 at 07:02:17PM +0800, Qi Zheng wrote:
>>> On Mon, Dec 30, 2024 at 05:07:47PM +0800, Qi Zheng wrote:
>>>> To unify the PxD and PTE TLB free path, also move the pagetable_dtor() of
>>>> PMD|PUD|P4D to __tlb_remove_table().
>>>
>>> The above and Subject are still incorrect: pagetable_dtor() is
>>> called from pagetable_dtor_free(), not from __tlb_remove_table().
>>
>> Hmm, __tlb_remove_table() calls pagetable_dtor_free(), so moving to
>> pagetable_dtor_free() means moving to __tlb_remove_table(). Right?
> 
> Right. But you Subject and description claim "... also move the
> pagetable_dtor()" not to pagetable_dtor_free() - which is another
> function.

OK, will change the subject and description to:

s390: pgtable: also move pagetable_dtor() of PxD to pagetable_dtor_free()

To unify the PxD and PTE TLB free path, also move the pagetable_dtor() of
PMD|PUD|P4D to pagetable_dtor_free().

But pagetable_dtor_free() is newly introduced in this patch, should it
be changed to 'move ... to pagetable_pte_dtor_free()'? But this seems
strange. :(

> 
>> And the main purpose of this patch is also to move pagetable_dtor()
>> to __tlb_remove_table(). So I think this description makes sense?
> 
> The patch makes sense, but the description it is incorrect ;)
> 
> Thanks!

Thanks!
