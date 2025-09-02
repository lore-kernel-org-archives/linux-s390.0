Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7502D5948
	for <linux-s390@vger.kernel.org>; Tue,  2 Sep 2025 08:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756800733; cv=none; b=Wn4cxDNYDUhTZwxDzdd0dGPZq+rCRgUh2kQeiCWe6CT3IHKSlGgcEGpP0gpXwPcRdvINw7YWsXEA+ybc9NksiJ7NWpDXL8bx/mGsb9CydAwxcTB/yGaQppEmc7hRorGCyZlq6EgN1cNGpdY11N9kP24muOkuMawbSCHVooz9xS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756800733; c=relaxed/simple;
	bh=UdYo5EhZ3PMDCVcRYhDMGGjzEDk9Z7rvDGoYq+BHWe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ghwso8PvdbXRUIcKIHDgbmerggii73NxFtoIW5LlgN52mH2CRaO2yux9+dyHB/1DeEAY/zj2H7yMhz5IKSjHC7Llrv3SH0w1gArsGGBiQIC4xSlNDS08NP+gi0jaDt3JTgIuDHBDHi2+nKann330i2q6w3SphIvImYJIDxK1FCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SZRRxapQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SZRRxapQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756800731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2zb5t8Q6aRCCvAvoxx2JGukWZxS6Bp6/fazEsZZ+kHs=;
	b=SZRRxapQACkIhSQ2XEKlSYgxw46ISSxn8IRWNGBuynideaf+2GzesqNrTK8c4dajQXc368
	7QQ3vzMHqnFO/kkz17ul4QTjUR2gPSY8URdJ3r3zLr+jKcI+SQnKJpG/dqnk75LIGfgC+P
	Y6WbmdsZsYW3cMGIx21GwSBbrbvYm9s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593--RbAknSYP9y6r7oIM0Lg0A-1; Tue, 02 Sep 2025 04:12:09 -0400
X-MC-Unique: -RbAknSYP9y6r7oIM0Lg0A-1
X-Mimecast-MFC-AGG-ID: -RbAknSYP9y6r7oIM0Lg0A_1756800729
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b8f4c2f7fso11845535e9.1
        for <linux-s390@vger.kernel.org>; Tue, 02 Sep 2025 01:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756800729; x=1757405529;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2zb5t8Q6aRCCvAvoxx2JGukWZxS6Bp6/fazEsZZ+kHs=;
        b=OUD3P1MbAuGDIxi78Svr8UAJn5bQnPXI6mpjeGRHVt5yMFSmWOkJ6WbRm0l4jygkLz
         Z1aF4IPuhzCEC8N2NMf2YVX4ZjTeyZiqjkREc/muBiq1+xFMolUQntKIEwy6kBLSR9m3
         eNI9M/kOyj4UfZRFZNzVSfrwHCixDQxFEJmN8fv5O/CnraTrDi5JCm1BRWsvoyFWI5MQ
         h/DVBmGHsBuxTTHMh/yzpqWG6B4crOP9EOkPqWoM+R97XoPb34G7MCurNOR0Innsplg4
         e2ubWuL+cKyjrPm67F2DHK1f9yvi1i6Q+48H9xP8RcxTMLmttbNOsPhT3Iqkbw6oKLe7
         a8wQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/8iuDbEbtZYmolnvGQks6RFUUIRUYUYt10lNHor+DWntpONRlUYZ4ZZ6NYtVaZxNY3Mq2cYbCrjRr@vger.kernel.org
X-Gm-Message-State: AOJu0YwPTYHmxnQlSqjOjVqXeTaZrye/gRlWiSPcb5XsggZdaI8u/Xp/
	gGdhSWZXwduObuaqOzmM1m7Nd4s+RSdlBbXLrNaUotWDtCOld7wAXeyKE6gOwEmQzDgvpCH4YLW
	o1sl9CWQD6XfE7pMvEwFgAlA7f8OujCrlpeudXZEPrw6+uQhDtzuoVuTuCmy7ngo=
X-Gm-Gg: ASbGncsa0BiRvSMLt5Vk9w+C0QdtKHPA1xb8v32OY+U+paadvomL2UomSBxCABR4Fl3
	mck4RuIX5/43gBMjIAumJ/Q/h6asBI6pdwHYLPN0b74s/YYS3RfuNu9IuRgdgiTn4po+NOe8w8r
	Pt/0AAP+4rz5vmOOBcF5coNvY428IA/6+/o6OBBjYGobZpvcjgnc8i1G4FdEL/ZlZ+raEsy93mZ
	ROM/uaJOlVDh2DD2gSeJlVtjC/EIz+6xdpmPcUlfBVR3F12XEZR4C72M24utG+v1daY+UHja2VN
	ETb6pI4If6saVqCZSqVXHF7g+80Ase2GSM3NAZYR6OAirGjcG/Sfv/OfHeDw1AoY3r0OiT9lIrv
	DzUhWpIUwD0lzVaybQOvQOfleJKN8fc4CpFmJuNNPSbiEhiYQKU/s0GrMinZB0WXEA4E=
X-Received: by 2002:a05:600c:3507:b0:45b:8f5e:529a with SMTP id 5b1f17b1804b1-45b925314admr23500685e9.14.1756800728569;
        Tue, 02 Sep 2025 01:12:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMQKde6tuKuB2m2hPFengMNai3NoA7mhyO6qLDI4gze+ZpXVnDBYgp0JqNm1wzjYGnsylb7A==
X-Received: by 2002:a05:600c:3507:b0:45b:8f5e:529a with SMTP id 5b1f17b1804b1-45b925314admr23500275e9.14.1756800727994;
        Tue, 02 Sep 2025 01:12:07 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:3f00:731a:f5e5:774e:d40c? (p200300d82f1f3f00731af5e5774ed40c.dip0.t-ipconnect.de. [2003:d8:2f1f:3f00:731a:f5e5:774e:d40c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0d32a2sm290899325e9.9.2025.09.02.01.12.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 01:12:07 -0700 (PDT)
Message-ID: <d418e2ba-a3e7-48bf-9576-90fddde706f3@redhat.com>
Date: Tue, 2 Sep 2025 10:12:05 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/12] mm: establish const-correctness for pointer
 parameters
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, yuanchu@google.com,
 willy@infradead.org, hughd@google.com, mhocko@suse.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, vishal.moola@gmail.com,
 linux@armlinux.org.uk, James.Bottomley@hansenpartnership.com, deller@gmx.de,
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
 <76ec40af-d234-400a-af0f-faeb001c9182@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZoEEwEIAEQCGwMCF4ACGQEFCwkIBwICIgIG
 FQoJCAsCBBYCAwECHgcWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaJzangUJJlgIpAAKCRBN
 3hD3AP+DWhAxD/9wcL0A+2rtaAmutaKTfxhTP0b4AAp1r/eLxjrbfbCCmh4pqzBhmSX/4z11
 opn2KqcOsueRF1t2ENLOWzQu3Roiny2HOU7DajqB4dm1BVMaXQya5ae2ghzlJN9SIoopTWlR
 0Af3hPj5E2PYvQhlcqeoehKlBo9rROJv/rjmr2x0yOM8qeTroH/ZzNlCtJ56AsE6Tvl+r7cW
 3x7/Jq5WvWeudKrhFh7/yQ7eRvHCjd9bBrZTlgAfiHmX9AnCCPRPpNGNedV9Yty2Jnxhfmbv
 Pw37LA/jef8zlCDyUh2KCU1xVEOWqg15o1RtTyGV1nXV2O/mfuQJud5vIgzBvHhypc3p6VZJ
 lEf8YmT+Ol5P7SfCs5/uGdWUYQEMqOlg6w9R4Pe8d+mk8KGvfE9/zTwGg0nRgKqlQXrWRERv
 cuEwQbridlPAoQHrFWtwpgYMXx2TaZ3sihcIPo9uU5eBs0rf4mOERY75SK+Ekayv2ucTfjxr
 Kf014py2aoRJHuvy85ee/zIyLmve5hngZTTe3Wg3TInT9UTFzTPhItam6dZ1xqdTGHZYGU0O
 otRHcwLGt470grdiob6PfVTXoHlBvkWRadMhSuG4RORCDpq89vu5QralFNIf3EysNohoFy2A
 LYg2/D53xbU/aa4DDzBb5b1Rkg/udO1gZocVQWrDh6I2K3+cCs7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <76ec40af-d234-400a-af0f-faeb001c9182@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.09.25 08:19, Lorenzo Stoakes wrote:
> On Mon, Sep 01, 2025 at 10:50:09PM +0200, Max Kellermann wrote:
>> For improved const-correctness in the low-level memory-management
>> subsystem, which provides a basis for further const-ification further
>> up the call stack (e.g. filesystems).
> 
> Great, this succinctly expresses what you want!
> 
>>
>> This patch series splitted into smaller patches was initially posted
>> as a single large patch:
>>
>>   https://lore.kernel.org/lkml/20250827192233.447920-1-max.kellermann@ionos.com/
>>
>> I started this work when I tried to constify the Ceph filesystem code,
>> but found that to be impossible because many "mm" functions accept
>> non-const pointer, even though they modify nothing.
> 
> And as Vlasta said, this is great context.

Yes, that's valuable information, and the series is looking lovely now.

-- 
Cheers

David / dhildenb

