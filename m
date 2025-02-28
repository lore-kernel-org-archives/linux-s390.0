Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1AD23F390
	for <linux-s390@vger.kernel.org>; Fri, 28 Feb 2025 21:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740777313; cv=none; b=p/BLWnFKKJA5jiC6WmRFf+BPcyEofjx0qcLTUQKfq3FldpA0G5KccDaHBBEvHIRLp5/BmFfjdka2MJUPiR52cc6aBIMgG+NyvhsXfSxhrO6GAFscvJNtp2vaugwTxFypqlw5FFD3hBKwatyUppchlySYfFztF472waojOPdlW34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740777313; c=relaxed/simple;
	bh=wyc6gBDTrziydpuK61JRdtvkYp6zQV0x/t8ufLMZr4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V/KtLNTiS6db07+9GWYHEfi/Ym24HNXz6iZTZb0TtWTGREhUBM58Rd5tfxKd/arBJ8e1bvBdnj85vKqiWT1fxoKGrJrGiwwx0d2xB426O3yRNS6pokT9AELwdJBUH6avpIJG6sMkWMJqxQ/VPEMllYB+JRfk0a77djHOhKkADUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jJdc35tW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJdc35tW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740777310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mRmrDjDqYaNeAPcUDExcWiFekmRwtmxV95n5m+IeDe0=;
	b=jJdc35tWpCaxzODhDD12jEddYgTfs957zJ4/AMdQgVRHp5WZay/Pa4LeS+myPlc4AjUADN
	jCnFOVIZsgnEGoXc5xS2b921eXYTCSyhTWi8WZhvpARpxchT/iI6XVJoS9QjFGTjRg/ClJ
	9rLVYGnrI2meSdkIdzac2Laa7x2J5Dk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-oePUchqAMcS-EcA2luROLw-1; Fri, 28 Feb 2025 16:15:07 -0500
X-MC-Unique: oePUchqAMcS-EcA2luROLw-1
X-Mimecast-MFC-AGG-ID: oePUchqAMcS-EcA2luROLw_1740777306
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-390f3652842so477747f8f.1
        for <linux-s390@vger.kernel.org>; Fri, 28 Feb 2025 13:15:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740777306; x=1741382106;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mRmrDjDqYaNeAPcUDExcWiFekmRwtmxV95n5m+IeDe0=;
        b=fxXwcgSklxMhC/+mIyT6UzbURfr4nsWzhi9KW4Zj/LMs2QTzO7+L8VNIJsmjorU6fV
         w/V1TCkOqO89kFGaN7e8U35JXYjqnpt4OMxhIBb1sdu0QIzCR0qGuFp3kXE8GqLIeA3Z
         lFviTPgZH+OEafy/Uff+AdfuYK74pqEtTMCCaC83O7uUTlZE8km5gO51+IPG/lVBzJpa
         ul5x5LZSdqr163Jg/awBVb3U5zjSzFajHLwa1I/Tlx/JEmpL+VCrEbcCVVhzN4tBw54G
         NQPUMxJZlskvuSR5w3PoL4Ur7NpsS27IYHI0ShaRoQ1FhogPNswZ8sVlbEIbQSQZzoRe
         /YqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWy40jKhPmKvi+hXMz9YU3QyvqMpk318MRYyPBDYYo0StXbgZyTLGmKuJ4x9Sse3qGUnrz1kuM9TTSh@vger.kernel.org
X-Gm-Message-State: AOJu0YxQeSWCvi4+2mj9mn81WNam55kVvgmQ5yLTwDznM5mfPMCxsleQ
	UIMkknhWIHQTyolf7zpODfd75vkxutI8awQ64Nl5rfFPEz4fFu8kTZxoQPcHCVQz8sG4pPZ1i+l
	OFIU4oIXcLgZOpS3xua3n8xfBJJwPYgjQHMZa244lbsiEZswAidogf8bPMk4=
X-Gm-Gg: ASbGncu521s/XvY8ikPK6mkNrrCcurcVm0W+jJ7ygVc6w4qb+61YvrCrFD6ApXRVOGD
	dOr4QGe+hLkQCvs0DMi6GyJqQNNRPXYbtEVrZG3/Dkwx6fcLDAgBzg6QZMq1NqeLzz7XeS3o/yf
	PHAj443IoLDEm9YlUv3QFBgy4GwJV8xErn3Xf57F/KSCWHygFQbUR8zJYKZpQ6MsxDmi3dNNWgu
	LZhoD65KYcz7fOLxP11PHsMoRXbonokd6qZiYTPCAwKWgJpm/NTgA1a7/HKwrJz1pXwamXEcODY
	4jYUfdR1UO6VFliJXomNe8SQy6Dkw2h7iqTRIXE8W8ZZJEP0Di0Ad7dKEmfIKrWFSEmstb4yYDF
	RvnCkdZEEWVtcPmYFf7D/YVGwPv2Oak8XXxQQw9W2pXc=
X-Received: by 2002:a5d:47c3:0:b0:38d:ddf2:afe9 with SMTP id ffacd0b85a97d-390ec7c8ff5mr3640469f8f.1.1740777306490;
        Fri, 28 Feb 2025 13:15:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9gz1ryGr92P/e9/0BEkkAs09/gylzMPlvYgXn18P/ISKKMsbdwmGytpizF7wukm38O7pqFg==
X-Received: by 2002:a5d:47c3:0:b0:38d:ddf2:afe9 with SMTP id ffacd0b85a97d-390ec7c8ff5mr3640457f8f.1.1740777306123;
        Fri, 28 Feb 2025 13:15:06 -0800 (PST)
Received: from ?IPV6:2003:d8:2f36:d800:164f:7689:99fe:7f58? (p200300d82f36d800164f768999fe7f58.dip0.t-ipconnect.de. [2003:d8:2f36:d800:164f:7689:99fe:7f58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e484452asm6326697f8f.61.2025.02.28.13.15.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 13:15:05 -0800 (PST)
Message-ID: <370231a1-af36-46ca-a87c-ce1929473c1d@redhat.com>
Date: Fri, 28 Feb 2025 22:15:04 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] KVM: s390: pv: fix race when making a page secure
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 frankja@linux.ibm.com, borntraeger@de.ibm.com, nrb@linux.ibm.com,
 seiden@linux.ibm.com, nsg@linux.ibm.com, schlameuss@linux.ibm.com,
 hca@linux.ibm.com
References: <20250227130954.440821-1-imbrenda@linux.ibm.com>
 <20250227130954.440821-2-imbrenda@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250227130954.440821-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.02.25 14:09, Claudio Imbrenda wrote:
> Holding the pte lock for the page that is being converted to secure is
> needed to avoid races. A previous commit removed the locking, which
> caused issues. Fix by locking the pte again.
> 
> Fixes: 5cbe24350b7d ("KVM: s390: move pv gmap functions into kvm")
> Reported-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Tested with shmem / memory-backend-memfd that ends up using large folios 
/ THPs.

Tested-by: David Hildenbrand <david@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>

Two comments below.

[...]

> +
> +int make_hva_secure(struct mm_struct *mm, unsigned long hva, struct uv_cb_header *uvcb)
> +{
> +	struct folio *folio;
> +	spinlock_t *ptelock;
> +	pte_t *ptep;
> +	int rc;
> +
> +	ptep = get_locked_valid_pte(mm, hva, &ptelock);
> +	if (!ptep)
> +		return -ENXIO;
> +
> +	folio = page_folio(pte_page(*ptep));
> +	folio_get(folio);

Grabbing a folio reference is only required if you want to keep using 
the folio after the pte_unmap_unlock. While the PTL is locked it cannot 
vanish.

So consider grabbing a reference only before dropping the PTL and you 
inted to call kvm_s390_wiggle_split_folio(). Then, you would effectively 
not require these two atomics on the expected hot path.

(I recall that the old code did that)

> +	/*
> +	 * Secure pages cannot be huge and userspace should not combine both.
> +	 * In case userspace does it anyway this will result in an -EFAULT for
> +	 * the unpack. The guest is thus never reaching secure mode.
> +	 * If userspace plays dirty tricks and decides to map huge pages at a
> +	 * later point in time, it will receive a segmentation fault or
> +	 * KVM_RUN will return -EFAULT.
> +	 */
> +	if (folio_test_hugetlb(folio))
> +		rc =  -EFAULT;
> +	else if (folio_test_large(folio))
> +		rc = -E2BIG;
> +	else if (!pte_write(*ptep))
> +		rc = -ENXIO;
> +	else
> +		rc = make_folio_secure(mm, folio, uvcb);
> +	pte_unmap_unlock(ptep, ptelock);
> +
> +	if (rc == -E2BIG || rc == -EBUSY)
> +		rc = kvm_s390_wiggle_split_folio(mm, folio, rc == -E2BIG);
> +	folio_put(folio);
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(make_hva_secure);
>   
>   /*
>    * To be called with the folio locked or with an extra reference! This will
> diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
> index 02adf151d4de..c08950b4301c 100644


There is one remaining reference to __gmap_make_secure, which you remove:

$ git grep __gmap_make_secure
arch/s390/kvm/gmap.c: * Return: 0 on success, < 0 in case of error (see 
__gmap_make_secure()).



-- 
Cheers,

David / dhildenb

