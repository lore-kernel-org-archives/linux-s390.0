Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820E524DCF9
	for <linux-s390@vger.kernel.org>; Mon,  1 Sep 2025 13:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756734578; cv=none; b=rthbaXhP85LK/mxpEzoOedMC8tVpwJzgY7kwV+1PE3kdGwa8XPUo4RXYdgoMl305ZGrfSAzi+GXW/v/fCF4y6EtgmVNHCnqRHMmGk4zKxdu08wffLQKBK9tKq4bGx24IkBScipjSJZnQCmPJlMSoBMt8qhkwAwWcz9Mr2YLLaJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756734578; c=relaxed/simple;
	bh=hHMV30eixdyQawKBi5cx4ewf2evKgv9LC+9ejI3b3ME=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VLjhteKh576UIgysD1VN0e1PP9jiLSequXo5+27xuILrYDwU8WtV83ADAi0tGIYUzp/whH+DWNs1j+Yh0zNSiL7xTlwKTadshIRTD0QTYQTGAoMogEOvIFPdsIU8/aAf7RHI9ZFFcPjqt2sip0G/Vvi1GgRdrqwA1AhEr/d3Vkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aIEZNv1p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aIEZNv1p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756734574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QeMaFkgVKLNhgkcf95y5bvTrYsmpJO9BxTkmeHvQCgg=;
	b=aIEZNv1pRCVjQbMX48RHbeJp2p3BATx0ZcCgiO1+WSAgsYkfi8UyYqcYpX6ApCmsDpyLa/
	yH+yHEvI33fA0gSAJgzw8mXcdtJ+VJeLuxpmlZu8wy04wyEkipiBcA88sPGw2YXG6T092l
	oOUqODSOul1c1fZe1Es+I7jwnccLZB8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-fXytsaTEOMO_xzLuLqRqAA-1; Mon, 01 Sep 2025 09:49:33 -0400
X-MC-Unique: fXytsaTEOMO_xzLuLqRqAA-1
X-Mimecast-MFC-AGG-ID: fXytsaTEOMO_xzLuLqRqAA_1756734572
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b8a307c12so6477725e9.2
        for <linux-s390@vger.kernel.org>; Mon, 01 Sep 2025 06:49:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756734572; x=1757339372;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QeMaFkgVKLNhgkcf95y5bvTrYsmpJO9BxTkmeHvQCgg=;
        b=YCiRXPOwgfOsGdJTW9abJ5dah+yKDysENkJDmrrhBqk79YFUNXnFaZsv4krECWpzVX
         5BZBrAZk5tu7WnEl+r2X+f3OA6KeExkZPF9ikk/VQyi0WY6x5NNSzNDFxRRf7COfyQqp
         HpwGr5GRVOHdBezrul0/2EGJyGl1W7IBrept2ssuvNwvDtQQwmEzo37plR4/ddwW9h2Q
         +sRblu19bE8R2E9KookYVMajfRsUrXGXtgXjWEG5m6L6fvMLlxfK72TuDNRkE7+ScQF1
         epxI/7ACiBuE2AA/aCGcHHt7E8dK/gHt+0GOuPwh6LcsdZbtSu09+DLH9h+l+zLMBrkJ
         ErEA==
X-Forwarded-Encrypted: i=1; AJvYcCWi0q4QSQ7yVVk5V4MUDwpkArUEx/fQd/x+jvw1XVd/D+Je3zH3NLhufiwvYUY/jdERVXpW1hIsOR4B@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1etj9wZ8s38Fw+Fzv+4f1UiHvPOpoD6lEi9/ifonG5+mx3+I6
	5O/YpgRzla/lJtPifpM6/GXUdXphiPUe+8sVOJ2qTmsh51if3o0NIX5daI65RuwPfc+RncbO7OU
	Bbw56iDLlCBM3+NMgQeQZ1OSLiYXGHe9CrM02AB0vivJfpnVkK0foeOt+P+c6xhI=
X-Gm-Gg: ASbGnctLUjbR3VzAoWVm8eGok0z0W579qoW/yDRJETBuUR9npx5Ku3KUS0CN1FLpN+D
	tbRwXRGs9vYltPPsuefIbJmTb0XiGqpf4BNWcQD0AXNTzzS5X+R0UCSsa/jN9VguXbk+L5OHth7
	G+ro1WANDkdoH/t9bcS1Wzt+TasRNEZd5GAFiVQNs6SB+NNXEbCLMoiHBOj/Rqj8jUkxCfe/BAn
	xHow+CZXn0NimFfqOqSYjCLRZUQAg3ijYYvm4JCixtoU/EAeTtEYRXxr5KZ0palzp9H+gU/whf7
	H/MmUBa58i5WOGmi0qej/nki21gsTGVLCmYCyxKMSeRZ2FIM8DK2ST2F8SPfm553d3v5F1rYFOb
	PqOXPLiyDc5+z70Qwd6uiuHdzhBix0pARNdyrTMo3bE5ahCcO20YdYUSppk5WuyhVW7U=
X-Received: by 2002:a7b:c3ce:0:b0:456:19be:5e8 with SMTP id 5b1f17b1804b1-45b855c980dmr39003895e9.20.1756734572240;
        Mon, 01 Sep 2025 06:49:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWVzIbyD9cL1iRjU4Tl8hKX3/L75O9ja6UC34f0938iMOqSuaIgC8oMfdKLbCOOEuv/sCMTw==
X-Received: by 2002:a7b:c3ce:0:b0:456:19be:5e8 with SMTP id 5b1f17b1804b1-45b855c980dmr39003225e9.20.1756734571705;
        Mon, 01 Sep 2025 06:49:31 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e88785bsm158072995e9.14.2025.09.01.06.49.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 06:49:31 -0700 (PDT)
Message-ID: <e509a5c4-f71b-4fcd-9776-6a3d39761b4b@redhat.com>
Date: Mon, 1 Sep 2025 15:49:28 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/12] mm: constify pagemap related test functions for
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
 <20250901123028.3383461-3-max.kellermann@ionos.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250901123028.3383461-3-max.kellermann@ionos.com>
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

Not only test functions but also some other "getters" in there.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb

