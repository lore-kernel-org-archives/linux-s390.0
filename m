Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B92C335BB7
	for <linux-s390@vger.kernel.org>; Mon,  1 Sep 2025 13:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756734520; cv=none; b=st6gl3fZByrC8+bI3ibGGN1vHNp3HIxi+/3yx1bAzzi/k5cTfnPUMO/T8zUPRidOisI4EETnnkU3sYYMEESKuBtO5Gk/9od+aobQj+PMd4Ae2UsRv3GLKnLrErRkaSpEFtkDJ4J4nAz1ms9xW99yHYUTnLXOHy5sj0ZeWxYUsn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756734520; c=relaxed/simple;
	bh=E6hB4NnKzRLS/PDlBLgPh50qwjdaZ5ve6PPSFT6Yomo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nqN8zY8x/YGfSZC6+gDSZrmF8QiPXXnKr4gJgypvrlu4w8nYojF9mHqSVRoz1dAce3OSuoptE93V8Ll9Cl3x/qQikH5UJFhXcpWXuZ2rcxFnSvLOIflJep6bEp/LqzMHg+M5Ep9XuA8vT6s7DA/CRWG2hM0uXOwivxV1V3xDa9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AIK7HAMZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AIK7HAMZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756734518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hQXxZK+8L2C3hWSBdyN50IL5R99xW41D+fHSrVTbeg0=;
	b=AIK7HAMZ7hQU9F+NYTF32Fvnl72aibk2+z1X2YWbtdrQSRBOnmbXbjVwOYgPctrruiehCI
	viwZFtReDbTjcUdJXmfNV7KXc+SWlhxXyxp/b37SWYnqs6TLrA7cV7JqKr30jhcSw+8c1E
	Htt2TzVvA+itf/C04mR78065zS/QvXM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-mMbNrGGhNfWFp671Qx3QyQ-1; Mon, 01 Sep 2025 09:48:37 -0400
X-MC-Unique: mMbNrGGhNfWFp671Qx3QyQ-1
X-Mimecast-MFC-AGG-ID: mMbNrGGhNfWFp671Qx3QyQ_1756734516
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b883aa405so12393115e9.2
        for <linux-s390@vger.kernel.org>; Mon, 01 Sep 2025 06:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756734516; x=1757339316;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hQXxZK+8L2C3hWSBdyN50IL5R99xW41D+fHSrVTbeg0=;
        b=oeO0JdKfaxwZVGQtt6rILcnbHeKbm264u2e7u+ta/VSZv7WCjfjTRlIC9G1iwyNsOX
         D6RS4A3XBbc+HdR5dbrmh9iqx8wbDR6Zs6q0plmJu4no7OHlX82j5ZH9RrhWXg62BwlO
         TRlETJYpGpsEe8+ZOnORIq/3g9qH9QAebCSM9fdJH2Rvn9KRmpg0VVVNztsUU/EMaR7O
         H6IWr1MlFdnVk7nO2dfkGpCgzWS4AM2zMiuQq4N3REuY0XWqrCFYkQMZ/TGZNRVsmuGD
         EGv9E+MDgcp0w2NBp6R1fNOWuAam1jzVUe6FpP72NVujMcq6SVdaC3UMtwTQwhn2yQN/
         tojQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/tj7WNjK1nedH/6VIXaKrp+X4/CNXvYuFtX0ZaUA+kWu/EfGW7wcPui87xd62aM851QcC+4VgDWlO@vger.kernel.org
X-Gm-Message-State: AOJu0YwwN2ehmmEmpVNmA74p5DtYS1uyhDUGri4//qYkqhSvVk8SeTwF
	e3pwgvmVQeaqqCbm8bQYzoWL1VYUBOeePL+8D7vB6UuWnzNB9UyfdbJkjZ5HhPwsA0xgcCVZISJ
	j5NQNi7PFHvIvvSQV/PJGNjbGbtpghkq7ZiE6eBH4Q2/5uj3vXrbGcYa/67fCBUs=
X-Gm-Gg: ASbGnctqDwWRKIKSo0xXM1Jv1/jq/z8KHEG8Idg9ceWMgJwL+8uSpPLfoOy38CQ2mOY
	zYR+dBO6PZwZUwDk4ukPfAy4a98Y8nQZaF5A+3zfUV1sjxrlxa6iW7pgVc+wkpA6L6ki3lM3Cze
	1ZgzzZ4yeIQDWXztw/hkbJnoXQxkzV2uqVcMHI4eRLSvWsB9OySLCEpcomaKXdk1ysHSyxefdXw
	nQoancI2pj2GY5GkUpGArqO8zuv12iFCXM2r3o+/h/C/lAOmPqyzUi4be8vxWaiLGqQ3HzooTkc
	pfE4r1pn0tAs8rb+hlKkWp6KFX0jgb18Cp85KXci/voOgWfz5Ytw+ZUgZbeVY3+XTnXoe4XQQse
	gdbE/n3LeguFX2tS/4zc+BaWOJWOL+16gLP+Pgd6OKC0w8PnTDUg7xW6JcEhU34l1Ks0=
X-Received: by 2002:a05:600c:a47:b0:450:cabd:b4a9 with SMTP id 5b1f17b1804b1-45b8557ca38mr56455095e9.29.1756734515772;
        Mon, 01 Sep 2025 06:48:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGYU18Ux39mAw301hmA+r2EuvPPz5FrRLj6WAhAzZ8e/RC+hpi0j03A/urkuaUOvkYNjzyqA==
X-Received: by 2002:a05:600c:a47:b0:450:cabd:b4a9 with SMTP id 5b1f17b1804b1-45b8557ca38mr56454805e9.29.1756734515309;
        Mon, 01 Sep 2025 06:48:35 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e898b99sm157339905e9.19.2025.09.01.06.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 06:48:34 -0700 (PDT)
Message-ID: <1eb1ee06-1fc1-472b-b111-e9c824310cf9@redhat.com>
Date: Mon, 1 Sep 2025 15:48:31 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/12] mm: constify shmem related test functions for
 improved const-correctness
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
 <20250901123028.3383461-2-max.kellermann@ionos.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250901123028.3383461-2-max.kellermann@ionos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.09.25 14:30, Max Kellermann wrote:
> We select certain test functions which either invoke each other,
> functions that are already const-ified, or no further functions.
> 
> It is therefore relatively trivial to const-ify them, which
> provides a basis for further const-ification further up the call
> stack.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb

