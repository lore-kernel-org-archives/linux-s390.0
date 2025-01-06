Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E969C1DE4C8
	for <linux-s390@vger.kernel.org>; Mon,  6 Jan 2025 13:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736169806; cv=none; b=PwZQEWFrgkf4rGHIiGTxtoryEidkp7AFLI8TUnrbLVmfL39Q8bKs0QUqx6nXk7g/izoVs2jK25Clz5F7bIK0KiW5w6iZZ+859d/wE/9CgBYuLD2fIHf0ULtQ3oVY3ZAXN7EVOF+LZBi/UfYqLlkN5WiNzF5yzLFWGvXAtHil1NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736169806; c=relaxed/simple;
	bh=AslleoXTRiRbWr13FtvX0Ckl/9sdreGxSQ4NH4wFg4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZOtIrpIx69MapvILi3AKNV3avLMRyCVxlPlh8JPkzwXGRoIQ3G0TCTjSZMbZZUkqZCq5iGJv/xQrGIjUX48TuL+YIL7mFzazdA68+mZlp9Y1KpjB2MeZR4F5qpmNRmP42yp/81wePlmQ7WXVPEJtp+Qib2oPKJnMTAIFEJUU5OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=iI74JgsW; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="iI74JgsW"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-216728b1836so186444735ad.0
        for <linux-s390@vger.kernel.org>; Mon, 06 Jan 2025 05:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736169803; x=1736774603; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=af8Jbj+kqP+p1W8uyVyt9V0YBDVs6Wu8XxDGXWv1rDo=;
        b=iI74JgsWTKG37DnW1YB/IMki+ScFHLvhEOk3vxDv9FgI6CI9jtlHtVi79I2xbSTyM0
         VdBztaV4PlDix6fx6Q3JW9PtPijrK1Ant99fgmA3is03DXu6hHX041PZwIdTpkeOjtKN
         LoDu7u38zHH64G1Ap/bFiO2Ul4iVjxZgRJ22LavyqnEuA4hlfThhKkPpKvqpm+Yl4HWd
         0Y10N6CsIor4KJg9gJ0tR5ljeF+yarKareNh75UOnmdOXB3oHayFxKL/nV0iYlWUDX2N
         n0o/oAxFwFOpZhIRnap5aLfCm/HwMLi3b9miICri0ljBKer+MO7weBR7HlkCSFvoh1c+
         NJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736169803; x=1736774603;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=af8Jbj+kqP+p1W8uyVyt9V0YBDVs6Wu8XxDGXWv1rDo=;
        b=h4g5ZFdn5EFDROgwp50pW6ozBbfFlckh02q9qKVliSSZYqHf5AgB0qX1+fAJvDsE0x
         7xfjXEQrh454XnG3DxfBsdnrsS3y3pas/hiG+UYO2pwBntmFUWznj8Y4BX81/mmnIwQV
         DxxLUKscLuOwxf8iV4fuLesn/BA1DH0DsV0nf7jxMNAexmbN03gD/s0NISQQ4BJUJBmp
         arNeeNJXzCnrtO6UAV/YGT4obKZG75dxM7uBwW/sCWptS/3pyxKZw1wibY/vuGSIjRSK
         kV7tT8ON9mUieClfmwTksk5DfFwGOyGhhY6Akarhg+Lmk8hrw8aQDFgvmEJEIhDqS9Ei
         KcpA==
X-Forwarded-Encrypted: i=1; AJvYcCUaddCoyf36h1PJv1PExZo0LXI5DNSioIAdy2XUK/CFQpXPpf63FiHMN2CCY6U7PzP/bplP908YjV5P@vger.kernel.org
X-Gm-Message-State: AOJu0YwCLqB9j2cqtoi4Ghq7LAtEZ3FjL4SQLKb56S/CWBgslL9B9wYG
	GfV90wiwgAGJjbnHqZb/2dCz3J2THRShH/FtIHVEyGM9hlAQU3axKyahyhWYqXs=
X-Gm-Gg: ASbGncsUuuX1lH9ktRWDm4WQpZPi4Ybx3BVb/xS6hZV9004Stql7x+GsZijGNK5jhEz
	UdX76GszbISnzEXMLKP6OLqdalls7fRQbSvQMS3L4I8DKepBsugln40CBLAadYfPlUacsVbSsS7
	5N57zroKpQ1Yu5bCHY7mot/eBDE6XQvZIuNtxNuTggLWbNKF4Kt7a6WxHPnqDl4s2GL6zShCko/
	DCUsNejXydI1a09iNkZtPiL0jrzpcHWAYyaMOjsCclbQQQAdXfT6TRwqxoXLEXUYL/hHWrwMP31
	Lb4xJ/GcN6k8xLZQ3JdhsbE8d6R8QFbpffJmANyTOxagmla4MtE9
X-Google-Smtp-Source: AGHT+IE/ZrXmD5LZyqp5+IF7XucHWltqSucrfnZMLD6UEt/qaBj6OXgwMq9je0lWMbXPRWlni+TKWA==
X-Received: by 2002:a05:6a20:2d07:b0:1e1:b44f:cff1 with SMTP id adf61e73a8af0-1e5e07f9c06mr81291446637.33.1736169803320;
        Mon, 06 Jan 2025 05:23:23 -0800 (PST)
Received: from ?IPV6:2409:8a28:f44:d64:296c:a8f3:f81e:f88b? ([2409:8a28:f44:d64:296c:a8f3:f81e:f88b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad90c149sm31371677b3a.191.2025.01.06.05.23.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 05:23:22 -0800 (PST)
Message-ID: <bce4bb4e-459a-44c8-945b-8889149377fd@bytedance.com>
Date: Mon, 6 Jan 2025 21:23:10 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/15] mm: pgtable: introduce pagetable_dtor()
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
 <8ada95453180c71b7fca92b9a9f11fa0f92d45a6.1735549103.git.zhengqi.arch@bytedance.com>
 <Z3uxwiEhYHDqdTh3@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <e1de887c-6193-48ee-a9b3-04c8a0cdda45@bytedance.com>
 <Z3vOZ18jcCpHIcPD@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <Z3vOZ18jcCpHIcPD@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/1/6 20:36, Alexander Gordeev wrote:
> On Mon, Jan 06, 2025 at 06:55:58PM +0800, Qi Zheng wrote:
>>>> +static inline void pagetable_dtor(struct ptdesc *ptdesc)
>>>> +{
>>>> +	struct folio *folio = ptdesc_folio(ptdesc);
>>>> +
>>>> +	ptlock_free(ptdesc);
>>>> +	__folio_clear_pgtable(folio);
>>>> +	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
>>>> +}
>>>> +
>>>
>>> If I am not mistaken, it is just pagetable_pte_dtor() rename.
>>> What is the point in moving the code around?
>>
>> No, this is to unify pagetable_p*_dtor() into pagetable_dtor(), so
>> that we can move pagetable_dtor() to __tlb_remove_table(), and then
>> ptlock and PTE page can be freed together through RCU, which is
>> also the main purpose of this patch series.
> 
> I am only talking about this patch. pagetable_dtor() code above is
> the same pagetable_pte_dtor() below - it is only the function name
> that changed. So why to move the function body? Anyway, that is

Ah, I just don't want to put pagetable_dtor() in between
pagetable_pte_ctor() and ___pte_offset_map(), so I moved it above
pagetable_pte_ctor(). No other special reason. ;)

Thanks!

> just a nit.
> 
>> Thanks!
> 
>>>> -static inline void pagetable_pte_dtor(struct ptdesc *ptdesc)
>>>> -{
>>>> -	struct folio *folio = ptdesc_folio(ptdesc);
>>>> -
>>>> -	ptlock_free(ptdesc);
>>>> -	__folio_clear_pgtable(folio);
>>>> -	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
>>>> -}
> 
> Thank you!
