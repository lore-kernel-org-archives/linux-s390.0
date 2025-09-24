Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D6730146E
	for <linux-s390@vger.kernel.org>; Wed, 24 Sep 2025 12:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758716535; cv=none; b=OIAKROFYXPvmYqg+/+qOjy1OX7OBZPLwBPR2Pe3CRiSdbegD1jV/MGKm22HP0LbbatQvdnhsvEdfsNGuknvXY0/cpuFhUR25fcn0ZeNaOs9FzfDehkW9Grsr+IIYS1SayE7WE1/zs8eoCAoznMi21+phVNq6kqKO1N3Gtjluqpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758716535; c=relaxed/simple;
	bh=F12QU4q8Qkjdx4foIaaaCsAMOffO02IlwUOMyao4sik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I2Mi8KU7OVWrSjdw9uXQXgNXNiY0lVvciinpEPpGgQeUzBasVlqvItqyGmJPANdtSP0gilNKxiQU8reNbq0qa26LYSm9RQgjZ286Mto2V1D4YwNgKrMsO8ynvF+6LMBiAYReJQLq8eXm+MmKrNKh1fD8IcIZLwwobX5K5Gezy7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JgTGj9Sr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JgTGj9Sr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758716532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Vmz9e9JSHdKEXdBu/pteycJ1iSIYc3poo80ZjdbrzKo=;
	b=JgTGj9SrNvM1b3TjdvfRc42DXfz8UW14pOycpNCJjd4QZE8C3MgD1Z3o32StmCqtkiLNQm
	grnX48rBiK1lWNKPrNOm2+okXXxyBJtuExiw124IhX4SSFPFo7vFQxNyNrnFBg8EXkrFn3
	I759CyYm8ea7Hv/fnhaBieBKdcQpuwg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-KmKRauGjO5yzsE930MDKYg-1; Wed, 24 Sep 2025 08:22:10 -0400
X-MC-Unique: KmKRauGjO5yzsE930MDKYg-1
X-Mimecast-MFC-AGG-ID: KmKRauGjO5yzsE930MDKYg_1758716530
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3efa77de998so3342265f8f.0
        for <linux-s390@vger.kernel.org>; Wed, 24 Sep 2025 05:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758716530; x=1759321330;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vmz9e9JSHdKEXdBu/pteycJ1iSIYc3poo80ZjdbrzKo=;
        b=YRn+9qofW+CLeAVzXJX2bxKRQH2kK7FIqrSbW96gMhVKN2rxk6uFs3R67eNV9Cdf+9
         T1KtngEixQrkLQqzGq4Ilnv2ekLdrJ2YWi5KCNgZuwtjMrJxFjAuX+Hyrusgju/Awk5Y
         gkiYYIMHwZy7CQnqIxSCtXSK5Xq6pr96lMJCePuwu9qchR8wGI8PvUu5KqFvbkzUATF2
         QetAqvddHT2KBYjTZvUycueKOzAHYIzyXNv08wLFPtC9EHm0+74D9DvT0oz4a9ku0uyA
         VKQDflCEnNbngAo6i2N4CRNJmqZ+slE9NnmczFzowVArK7liT/iqenPH855y61OCiWm0
         O6dA==
X-Gm-Message-State: AOJu0YwiwxLIMhRRdsnjChcHcqggsbRksGIOveSQpOc8dnkO4nn4Dc4Y
	K3B9ZPwgOiVGL1YZSmfePtCCYYCccv98uqirzvISf3r+XQxVlbg/TfqFWBugdOEEQ6eSWBAApzt
	LEDJ///jDqSe3TdYnFYEs4q/Hw3mDyVMJKas2mif7UhZMT9Tf0RZOMaphZZfiHzI=
X-Gm-Gg: ASbGncsLF1u0t5bwWtcPIJuKEIkSgHp1uf05Oiu8fKsyxlS2LEKMiGTi1r0Cre4UmgR
	ZAEmT5PWA37jV5e1qFDpFzNUkjYsBfOG6WnnXgyFm509GcmS8lpR6HcGZEp/413QYuzquyRiGkS
	C9iJK+T1hxx/fZU8thp1XCEg4ZhO4T72rnM6eusrgCaUIjqSe5HJY1NzUDREE0iGlrMZF70tNZy
	wKirpB7Ik5uOzlwx7biLi8tu4zCOlkZ/dwflcKSsgK++GFYle7O1leOrsRAEVnWewQ42evZVE7k
	FWFHEyyDaHc5k59kz8z5TIlMepNSd0NJ2PaAaDUoV11FL4d82TL4E7CLJceZVqf2Y4oELt0bK7N
	jcBVPNq1ll0AjCHgobDDU8qqvky01dXe5xcHsFwmSENDyKbLc6XUErkPWGnVHqfNoSQ==
X-Received: by 2002:a05:6000:4029:b0:3f9:e348:f70 with SMTP id ffacd0b85a97d-405cc9ed199mr4696071f8f.55.1758716529560;
        Wed, 24 Sep 2025 05:22:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5gZefcieEpNs9h9qe4+85WE47fFv6kBePDFTI4Qe2rs31B+VWsQMipVnDJxVutukKGr1/Fw==
X-Received: by 2002:a05:6000:4029:b0:3f9:e348:f70 with SMTP id ffacd0b85a97d-405cc9ed199mr4696056f8f.55.1758716529167;
        Wed, 24 Sep 2025 05:22:09 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f14:2400:afc:9797:137c:a25b? (p200300d82f1424000afc9797137ca25b.dip0.t-ipconnect.de. [2003:d8:2f14:2400:afc:9797:137c:a25b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab62233sm30548635e9.21.2025.09.24.05.22.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 05:22:08 -0700 (PDT)
Message-ID: <dfc83821-f2ff-4b9c-b9cf-9dda89e8eb77@redhat.com>
Date: Wed, 24 Sep 2025 14:22:05 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: s390: Fix to clear PTE when discarding a swapped
 page
To: Gautam Gala <ggala@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
References: <20250924121707.145350-1-ggala@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250924121707.145350-1-ggala@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.09.25 14:17, Gautam Gala wrote:
> KVM run fails when guests with 'cmm' cpu feature and host are
> under memory pressure and use swap heavily. This is because
> npages becomes ENOMEN (out of memory) in hva_to_pfn_slow()
> which inturn propagates as EFAULT to qemu. Clearing the page
> table entry when discarding an address that maps to a swap
> entry resolves the issue.
> 
> Suggested-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Signed-off-by: Gautam Gala <ggala@linux.ibm.com>
> ---

Sounds bad,

I assume we want Fixes: and CC: stable, right?

-- 
Cheers

David / dhildenb

