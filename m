Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85301B043A
	for <linux-s390@vger.kernel.org>; Wed, 14 May 2025 17:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747243729; cv=none; b=uXh1pxu+3V9Ob2KC3iktr7ue8tDOfRiY6sNYDPnTHDCjB24+TFRExLCtB58R4UT0msOX94/JSKsb2T15K7pO2b3r37XCYYYFoBee/EjqTA36kPR21Wkp1vOwRuGSOgPfc6659A8/xjv5HhVD3VV/w+kK8mR+Dda3fCGO3x8tvUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747243729; c=relaxed/simple;
	bh=R95sEw4qMzkRsfBwJrXEv8IusmnQhk8Qwej+7+Nhnxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cyBBC+N8CoTSifgYsrEO9FuG73WX9dYtbFvc76XRd7dAanqG3jHm/kKJ2tcfTCpKOhqtphbo0R/Zb3MOxdlkQxGpMSCtASI5hU2X+sX7Xh4GdctfYeENVSQYRJ6AoXqzQK4jOr5mNXaZftXdnA/qGXZ5wotCtmKknEga5ZrIaBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XZ8Fr1Ry; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XZ8Fr1Ry"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747243726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=x0NB9hHsfnvaqiaP0PTdvP3wQtEVBtbvcBvvonUuj7g=;
	b=XZ8Fr1RyuC7I2eoXygO0o8ZQsNEAzFPhAYcRY1/M/0QVcAyXFq8mHZMJMCdjWBdPNgre0+
	IJNc4nLwn+QnT5EZy6gBryFCPOO2vngML2YgybvNG1z5ISkwViZ4zlipiQMuHWDyWHkC2Y
	RYWdSjPkQd2eL3UO1YBN9dAoALX58Xk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-sT-vqIToMPuXSmi3crt3TQ-1; Wed, 14 May 2025 13:28:45 -0400
X-MC-Unique: sT-vqIToMPuXSmi3crt3TQ-1
X-Mimecast-MFC-AGG-ID: sT-vqIToMPuXSmi3crt3TQ_1747243724
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a0b63ca572so29371f8f.0
        for <linux-s390@vger.kernel.org>; Wed, 14 May 2025 10:28:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747243724; x=1747848524;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x0NB9hHsfnvaqiaP0PTdvP3wQtEVBtbvcBvvonUuj7g=;
        b=PghRof8AeQfMQjsrM+1Vw+UCtELeDQmlsR7GrN2h7IS/bPHDUfiU51ZAaD+hFjsdRm
         IcmCPvTm1yoWOxii/STL4d6DW3KvZVeno8ecey3iWZWbcLtdjUzLEJk+OF5LDUFWPK+P
         /NEhcXv1Qw3AMGqnODOfWniCVBSe0ckGKxV0/0wQOU9X0OVZCNACV7B6w88LYJYNYSe0
         YSwOGv93kHvs6zFgiBnXY3A72nA4BtvZbZBvESMqp+WXabHDrykyGMMX9jcOEJnleOHi
         veitcnzab/Z+ylOxv9Ey273cET4oIRS5J1d3F9KOydR59ZsspM+FC0G5Mk6NHAMKgic5
         B4vw==
X-Forwarded-Encrypted: i=1; AJvYcCUyq9xuEAyYLsI/KxdZ5TpCzET8E6X2RdYMGb6EVydhmGJ9ykZL7Vxh0nOEtl2pnHq8jKqwjyr76Cwv@vger.kernel.org
X-Gm-Message-State: AOJu0YzeKHwqdUdryGP/FFHvRJh3LW+dNe/6iddBaxUdgZo1jc2RvckZ
	me0rMpp5xCc27bTdt7K7QYb7eqpO1aVslJp4s0X+kHYXDWIdl0OcaiNm4ZQiYkRdI1QRjI2ZDRk
	bL52ZObEcn7iXqn4JTOID6aUjB5Riokz4vmJ0lOCeTdP4FIfp64Snzm0dECA=
X-Gm-Gg: ASbGncto3yJHs4ocSnhUQCqcomY9q+xWuWlhlGijYEMR0juhr862cqrTnQ/qPxd0OMm
	bt/PM0L5OgFk39cV+2vdhiPjCBkGNXfKs3KNv12B+Z4lfmM40qrJuDU85l42bOsdULOz67bgdpR
	sIQRelgYIyMl7iyCBMn/4CaSUONEOoHj4mpEeC8PbqYuI6+1Wk2lKpbWRt0ikX8Tna8nU6RE4Zn
	SKw+Cq8ADwUxZUPS2KaN553JdfvF8EeX48Hf6Eq0aHj8Neml1mKsSjCv831aZwKCN+/B31Lw2+d
	dyfVNqg+wfg1qC6Y6z1UQaCAqAXzJlGQMJDHTHIFbVgC7XbxVClot86vhPkRwCh6lDDrl0x7keg
	Ed19AqQffPsfd3syuk/Oy929DGvwZ1n5am4W70zA=
X-Received: by 2002:adf:fb03:0:b0:3a3:4a11:3377 with SMTP id ffacd0b85a97d-3a34a1134ccmr2884568f8f.38.1747243723739;
        Wed, 14 May 2025 10:28:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEILGSIK7ILwtvCfcdGj14dWXlSjZgp5iQOe3elG5M+F6AawgHo/Dw6MucQ5WANvMfSiqMc6A==
X-Received: by 2002:adf:fb03:0:b0:3a3:4a11:3377 with SMTP id ffacd0b85a97d-3a34a1134ccmr2884544f8f.38.1747243723319;
        Wed, 14 May 2025 10:28:43 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f15:6200:d485:1bcd:d708:f5df? (p200300d82f156200d4851bcdd708f5df.dip0.t-ipconnect.de. [2003:d8:2f15:6200:d485:1bcd:d708:f5df])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ecadfsm20175220f8f.22.2025.05.14.10.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 10:28:42 -0700 (PDT)
Message-ID: <8d23541c-0218-46e3-b865-8b12e5fe76e7@redhat.com>
Date: Wed, 14 May 2025 19:28:41 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: s390: rename PROT_NONE to PROT_TYPE_DUMMY
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ignacio Moreno Gonzalez <Ignacio.MorenoGonzalez@kuka.com>,
 linux-mm@kvack.org, Yang Shi <yang@os.amperecomputing.com>,
 Janosch Frank <frankja@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 kvm@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, pbonzini@redhat.com
References: <20250514163530.119582-1-lorenzo.stoakes@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250514163530.119582-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.05.25 18:35, Lorenzo Stoakes wrote:
> The enum type prot_type declared in arch/s390/kvm/gaccess.c declares an
> unfortunate identifier within it - PROT_NONE.
> 
> This clashes with the protection bit define from the uapi for mmap()
> declared in include/uapi/asm-generic/mman-common.h, which is indeed what
> those casually reading this code would assume this to refer to.
> 
> This means that any changes which subsequently alter headers in any way
> which results in the uapi header being imported here will cause build
> errors.
> 
> Resolve the issue by renaming PROT_NONE to PROT_TYPE_DUMMY.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Suggested-by: Ignacio Moreno Gonzalez <Ignacio.MorenoGonzalez@kuka.com>
> Fixes: b3cefd6bf16e ("KVM: s390: Pass initialized arg even if unused")
> Cc: stable@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202505140943.IgHDa9s7-lkp@intel.com/
> ---
> 
> Andrew - sorry to be a pain - this needs to land before
> https://lore.kernel.org/all/20250508-madvise-nohugepage-noop-without-thp-v1-1-e7ceffb197f3@kuka.com/
> 
> I can resend this as a series with it if that makes it easier for you? Let
> me know if there's anything I can do to make it easier to get the ordering right here.
> 
> Thanks!
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

