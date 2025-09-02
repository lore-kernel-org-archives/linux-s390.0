Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265E32E7F0D
	for <linux-s390@vger.kernel.org>; Tue,  2 Sep 2025 08:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756800673; cv=none; b=ouIaP2UOE0YocIKrdiRqgseWZhguf8bmP+QH9eWacQyhkTShrsgoC7h7Fq7A/KgOrMpm0DF9yksdRiBeZVQbNR2vSGDk5f3KgHeugkqrW1lPzMCBxELKt+TGQXS/nSeZIN6dJGTw5vEvUGam0S6ja9se5Tg80HIp2F60IgIeyFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756800673; c=relaxed/simple;
	bh=arfEnnFWdf6Tk7LHYUgPjFzHGxjCDtLm42H/zx3Bins=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bUfHDnAXJlmqxyibr5Pcr+7ze7Kmb0hpUU2SO4QU1LkvK8unYUrc0R3/d3XeTIAh9Lo165ZoG9HZinCTFGsXVb5ZMH6SCqtjassfcu2NrajpRqT2sRIm+Sc9ZOfmXMnB9+HUvVM41evUU0DAcJTQ72MGenLiDCysIzooeG39IMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cOtDZtiH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cOtDZtiH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756800671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=w4MWf5Tj42XyG4g8ZZ+nHXLySkFy5Z+t+SpLs9FN6OQ=;
	b=cOtDZtiHArld1qfZVKyzv7vcPqUS8Kkt3fQpoBUc6uG7GaDPwFtN/n2oytKB3cBwLKK9gC
	/S+6jMcz6RF1VBv1oE0aRE7bhUe8Sk09laxPL5mjc52gCluTLBoAI7WMBPzOCW8O+Bangf
	89RdQybBBcmNXKvTcsx9WvIyCG5WVik=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-Hp6RYq_HOaGF8MdDsRaHpg-1; Tue, 02 Sep 2025 04:11:09 -0400
X-MC-Unique: Hp6RYq_HOaGF8MdDsRaHpg-1
X-Mimecast-MFC-AGG-ID: Hp6RYq_HOaGF8MdDsRaHpg_1756800669
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45b87609663so13636275e9.3
        for <linux-s390@vger.kernel.org>; Tue, 02 Sep 2025 01:11:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756800668; x=1757405468;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w4MWf5Tj42XyG4g8ZZ+nHXLySkFy5Z+t+SpLs9FN6OQ=;
        b=pkSCiM4N1fat1z6uINJ3HK8iE7FyHdV7UOgPXVDbpqnJMZjm5KmtpY1lEj9d8+J6l4
         afj1+2nLfrOhuD0kzi9bfMhZmdNoZdymgkbP7+IjCG1tIsfcGoLG+vyWRprYbUVj0Y5h
         1LderVpM2kJpowx6j8HBG62v/5MpY+VsLATbv/20HU277f2VjJi4TGFu8HJdM/IMcRPy
         mxTVdUDQDsixZJ9wP27yUyuMQbBMaY7aTjVywwaTUBOaG1tZTXXuGiHgXIOOoK0d39Pz
         WZg7EEwJVuTAvfMwNV+hMhFo+jEaJmaNvC97P0t+o9xFUgWk57HlGtPMMfI0o1P2MIjK
         w3eA==
X-Forwarded-Encrypted: i=1; AJvYcCWj93O/3GdQ+MgF5CyaTY0dYZYV981JzibscPgwcYfnOXnsZ/6bMjHhTrWeDgXZuLEYGb31C0cVGwFx@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf26UZq6CK5VYKPg5bSC2CInsalz9zuRHbJYJdj5BfxL3fsM6s
	V6/1NOlNPlq5mFIkaMufMieHa2BygwQnd8DCbaGoxAi/hPg7joYAdLg+fU51ZufXLUfu+Js4RqO
	fmsR7akZSMq6Uw5NKaXbd14eVY3pze4U3G3WmeeSHfqjgl/VkNcj7TuzvwEaa6ik=
X-Gm-Gg: ASbGncukQZIstqn3a9kFITyw6iD9RF/+cIxV9dovYs739v9LzNqkswXnFvce0A9Nzme
	C7VPYlwqIa0EtUc2kuUWWr1imWuhgfvrJIzkGtLF6X1sY3hjuzxwn12PhFUIdsQJyU1NSYt96cy
	Psi3mHJNjLZ4u/qF/dEjNJhzdPIdogiHg8pV3A6f/tSDyeJETb+7cfAdf/CjfWvH0yL+Lgr1Q7y
	sHy2KMTZjh5wMg922vtHiVQK5w6bztuvlWf3MfiJbPtYET/ayUpTysb1aKFZDMMJKpXs4FHOhSG
	qeMmlf60DiWnwA30thQzcPm8hrKO55He6T6Q6AQkJYRYa2BdQzmdUS2L41mYrYYPd3AHeZkUSxD
	Msn5AbnkzztsNjmtlX4yeg/DADsG1T5GFFe8JnyZfQu2Ml6cm2EAzjMO3QbYvFswoly4=
X-Received: by 2002:a05:600c:1e89:b0:45b:88c6:70a2 with SMTP id 5b1f17b1804b1-45b88c67360mr71590305e9.1.1756800668335;
        Tue, 02 Sep 2025 01:11:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1u/GPZRrAk5+4OF8Grl0TirFQTXJJs3FiBdxsp7971JurAJnmwDEqUWzkf0hTf7n/W9m6vg==
X-Received: by 2002:a05:600c:1e89:b0:45b:88c6:70a2 with SMTP id 5b1f17b1804b1-45b88c67360mr71589695e9.1.1756800667854;
        Tue, 02 Sep 2025 01:11:07 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:3f00:731a:f5e5:774e:d40c? (p200300d82f1f3f00731af5e5774ed40c.dip0.t-ipconnect.de. [2003:d8:2f1f:3f00:731a:f5e5:774e:d40c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b98c95c77sm10525715e9.7.2025.09.02.01.11.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 01:11:07 -0700 (PDT)
Message-ID: <12bb3414-2ca8-4384-80e5-81889f2bd35f@redhat.com>
Date: Tue, 2 Sep 2025 10:11:04 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/12] mm: constify highmem related functions for
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
References: <20250901205021.3573313-1-max.kellermann@ionos.com>
 <20250901205021.3573313-13-max.kellermann@ionos.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250901205021.3573313-13-max.kellermann@ionos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.09.25 22:50, Max Kellermann wrote:
> Lots of functions in mm/highmem.c do not write to the given pointers
> and do not call functions that take non-const pointers and can
> therefore be constified.
> 
> This includes functions like kunmap() which might be implemented in a
> way that writes to the pointer (e.g. to update reference counters or
> mapping fields), but currently are not.
> 
> kmap() on the other hand cannot be made const because it calls
> set_page_address() which is non-const in some
> architectures/configurations.

Right, we store the address in page->virtual.

It's interesting that kumap() won't set that field to NULL. That seems 
to happen in flush_all_zero_pkmaps(). And we seem to flush during kmap() 
in case we have to empty slots.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb

