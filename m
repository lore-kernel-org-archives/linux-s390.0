Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419631A2C30
	for <linux-s390@vger.kernel.org>; Wed,  8 May 2024 18:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715191694; cv=none; b=C8lD7w7WHi+5bRBlwYrjJUyyKs5oKb2O/UxcGRMIzT3p9+EP4Rv8bXXxXSItnhwGUS8xLwmobncESyWGKishA9Rxwyf0k3B6TMN9XNti5KNl9qLkfSfFMUqjiVqYw2KlaCNp0DQRGVIWBeSDpReVbodc41LWlcC3IXshtpOQ59M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715191694; c=relaxed/simple;
	bh=/g1u15oOdNeFPTLT+J2ODVuGYEFAh/uIBtEy3H10phM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ido6i6tM1jcTEdR9wTHA3heqSez1nHLr5Fcv0aZLbr1goXEmMlF5Sqd1xMPZSCEeeduayhq5SCfrnPTwHXwvrWANcVAKX+avVdeZFsgRCbiq55L1AIUi43Y0gzEnPT1ftn8Pa6JittSJfB7iT/+swR+bTlI3JWpKsScx4IKQMs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jb4Z/Nz5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jb4Z/Nz5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715191692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=X8wOFbwhsmhzNzV8004TdLUtLR0yKta3vANNtnMqK4A=;
	b=Jb4Z/Nz5Gl3tqzjLeQo0S8Yf6x6+yurmYXmtuydnaj8xT9EEVxsHOkLMUSs8eNUQWtBapB
	MiWPLkwfo6BzHgK0/2Po64rKW3jKYMf3nwZPQLk+ZoUDMXBMqASZe48NSPVskmslnHdoV+
	64bxJoS6xxLJDeCYEGkTXi+5TubX0nY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-yFYHC7dDP2uw8_y0BxlthA-1; Wed, 08 May 2024 14:08:10 -0400
X-MC-Unique: yFYHC7dDP2uw8_y0BxlthA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-41f43083640so15283965e9.2
        for <linux-s390@vger.kernel.org>; Wed, 08 May 2024 11:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715191689; x=1715796489;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X8wOFbwhsmhzNzV8004TdLUtLR0yKta3vANNtnMqK4A=;
        b=I2KZJPGFyWHOUowP9dOh4KstWZXwfGdGBfnAvAkKSARBdJJp1u8B+9/Kx6d+tTqS+K
         t4W8xv3kyLSacNifyt3DVhCzoL7KET+DnfKCMC/6+thwUWsSgUI8cQFRG/5oySTKFo/g
         iENkHX2GEY9tB/gtPGRAuda4+JbIsN3kbT2ns4pGWp5gzwi8AOS4q0/VlM9pBlOJ7mQw
         W/tUnz7BN+rHcWcPRnE215MUSnkGMkyQcDnLNVB/DVQ/BnLNDKs4IE4wQHXhsmmXvkOX
         UIqPX2qWU7P35URlyDy9sG/0zHukPD2u4KK1dkM7osZE7iNdQMCRJwa1GOsCw1kQQseH
         M7LA==
X-Forwarded-Encrypted: i=1; AJvYcCWzoKCwuAyMVTtUKYYZyZs0r8gkZg7tl16YyEDWsyephqg2hgKo3O3VPcHMWG7308tLeXbowiNh1gzQllpDxFn2BLbC1xi8/UI7+w==
X-Gm-Message-State: AOJu0YxDwhmX6DPDTh7KU00JcAfDCEWIh6N1vxY+gwIMkvRKJ9MXOSZP
	XCXjWpBUiikD47MFuslrVBsPxF21RlV4htnCJCLxH+VaUjlOsgjhKyKbyJbHMNkJ33CMIzC8Nm7
	ELbMTXzQ+ZvmcBwZE81lbbQCQGIf+iCb41Dn2QtBI4s1Hy3gl9nCxjWzXWKQ=
X-Received: by 2002:adf:e689:0:b0:34c:2d1c:21c0 with SMTP id ffacd0b85a97d-34fca24122fmr3148843f8f.16.1715191689454;
        Wed, 08 May 2024 11:08:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0lsiS+rZLeLzk+T8lJl6tkDYFVxXA6BpElgZcDl2/1hiaeqv9wIVz88rsEOUXLiTs0+PdtQ==
X-Received: by 2002:adf:e689:0:b0:34c:2d1c:21c0 with SMTP id ffacd0b85a97d-34fca24122fmr3148827f8f.16.1715191689002;
        Wed, 08 May 2024 11:08:09 -0700 (PDT)
Received: from [192.168.3.108] (p5b0c6bc3.dip0.t-ipconnect.de. [91.12.107.195])
        by smtp.gmail.com with ESMTPSA id a7-20020adfed07000000b0034d839bed92sm15853496wro.64.2024.05.08.11.08.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 11:08:08 -0700 (PDT)
Message-ID: <36c6bdd3-b010-4b58-b358-395462d8765b@redhat.com>
Date: Wed, 8 May 2024 20:08:07 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] s390/hugetlb: convert PG_arch_1 code to work on
 folio->flags
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Matthew Wilcox <willy@infradead.org>, Thomas Huth <thuth@redhat.com>
References: <20240412142120.220087-1-david@redhat.com>
 <20240412142120.220087-11-david@redhat.com>
 <20240507183307.3336dabc@p-imbrenda.boeblingen.de.ibm.com>
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
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240507183307.3336dabc@p-imbrenda.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.05.24 18:33, Claudio Imbrenda wrote:
> On Fri, 12 Apr 2024 16:21:20 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> Let's make it clearer that we are always working on folio flags and
>> never page flags of tail pages.
> 
> please be a little more verbose, and explain what you are doing (i.e.
> converting usages of page flags to folio flags), not just why.
> 
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> with a few extra words in the description:

     Let's make it clearer that we are always working on folio flags and
     never page flags of tail pages by converting remaining PG_arch_1 users
     that modify page->flags to modify folio->flags instead.
     
     No functional change intended, because we would always have worked with
     the head page (where page->flags corresponds to folio->flags) and never
     with tail pages.


> 
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Thanks for all the review!

-- 
Cheers,

David / dhildenb

