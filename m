Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499D1143723
	for <linux-s390@vger.kernel.org>; Wed, 23 Oct 2024 07:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729669524; cv=none; b=R61Mp/RSvIo9xSkPwU5tzyaYKhDRyERxR5InhacocugRpebV/b+oZG8sUws2e/mBMOWA8fIkfnNMudG9nipxsgHmR/dj8RSjFdCj6JXVw/Ij384xNKngOTDu2tqtZ56Hk6ig7m8+zuRBkghZO6t1Ug54dLYQAaCoJ2bNEgqxSUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729669524; c=relaxed/simple;
	bh=7ZN85fbj+bV1NKRv7JVYGYgGFTPRqyqGN7eli11rNII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e+vketu5fRqrBwH84G+3YX1x7M4UdUifLnc+4fAdVQwD7Q3+AEanBJEtHk6ObRcHOVj/M9N/Mi+UbO7hDZIYo1GKK08vDzsIeiM8fqGf+P4+H/AigEH89k4zWCP00WIteIoV3JT6uyqnd2dAZhMMEXn+miGPxFsfYLBzwwwbG9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QLHbDYhE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QLHbDYhE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729669522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PRhyft7OV+xImgYU9toOVKehXn7IFWtNH0kZLXCKbw0=;
	b=QLHbDYhEWvqOUFGeXgrmK3V5NM2bH7GmJ/3Vj1s8krRsDhjUlXnHR3s+KF8S9cIRFjKRnn
	Bk6yXgirl8Nx0FggUtgFs0FGyS2cQDCelorDgBP9cuHksjjuruIalRVJELYfZYducKd4Nn
	pMuoE7UdeLNGhZ3MR/sXYQnif1rdH5s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-hV6JrejbMnCxn5igIxyFQA-1; Wed, 23 Oct 2024 03:45:21 -0400
X-MC-Unique: hV6JrejbMnCxn5igIxyFQA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4314f1e0f2bso45645705e9.1
        for <linux-s390@vger.kernel.org>; Wed, 23 Oct 2024 00:45:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729669520; x=1730274320;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PRhyft7OV+xImgYU9toOVKehXn7IFWtNH0kZLXCKbw0=;
        b=rvfDFUXhfRJxdnhU98FcYYbygRGIoDhMtPk4PYP6r9i+VnNhhnRYdI0oqcGEvSKI8z
         qHwnU/NjoS2X5d0HRsZv9q/7sSz15KPjP1jg/6yy9ZhBWP5fcrq6dETbUsKc4MaNG5WX
         FYZ0QrnLOI9lBM+0b5wLUJa0BESe0/diVaRGLXETxvWWT859aaezXP0olZ1RwjWj+Blb
         otuEtYyKzFF2eiugSnO1LtZuJlVb18qCJ9RZ94+NeCHodeHbK8EBH76jU+Rm7Ginos3X
         EG6kz6iuMiMu/6Q4qL/aNR1n2ap0Ufx8dJdC/oidxbdZwV2vfk9mrRcQqnItE12LRdD6
         QEQw==
X-Forwarded-Encrypted: i=1; AJvYcCVRTzprwiEPBrFdBJid64glhP+cCK+TPmCWKj3+cRwPLScGS171jZS0w+7b0QWNI5QR8Z7qC5Q9xbzi@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp3v7wTS+WIKPPrb1kF/Iemoi+6Apot+2pvUBcmeoCFQJCsn7J
	4NQc1Z3dYxDl8oWM8QH+JhALldmUIhB8FYEB75zzKLQH8MCrajOQulkNHG/QdhYGeFxu4zMz2S2
	5Mu3/iJIazW/rJKE/ItSIeYwz6Mn0gRBmHy5uYdtuZEMclC5sbe8SF0+V1Us=
X-Received: by 2002:a05:600c:1d22:b0:431:52a3:d9ea with SMTP id 5b1f17b1804b1-4318414298cmr14409015e9.0.1729669519886;
        Wed, 23 Oct 2024 00:45:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKkBSnYGhbyqJBhbjw3xX7pJtL4HaYA3IrXCrgntZVKqGfpTYqI6qi5iFyJA8xNnEEoRcBYA==
X-Received: by 2002:a05:600c:1d22:b0:431:52a3:d9ea with SMTP id 5b1f17b1804b1-4318414298cmr14408735e9.0.1729669519485;
        Wed, 23 Oct 2024 00:45:19 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70c:cd00:c139:924e:3595:3b5? (p200300cbc70ccd00c139924e359503b5.dip0.t-ipconnect.de. [2003:cb:c70c:cd00:c139:924e:3595:3b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c1e961sm8476525e9.44.2024.10.23.00.45.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 00:45:18 -0700 (PDT)
Message-ID: <5b2b6528-ee48-4daf-9311-41323018064b@redhat.com>
Date: Wed, 23 Oct 2024 09:45:16 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] s390/kdump: implement is_kdump_kernel()
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Egorenkov <egorenar@linux.ibm.com>, agordeev@linux.ibm.com,
 akpm@linux-foundation.org, borntraeger@linux.ibm.com, cohuck@redhat.com,
 corbet@lwn.net, eperezma@redhat.com, frankja@linux.ibm.com,
 gor@linux.ibm.com, imbrenda@linux.ibm.com, jasowang@redhat.com,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-s390@vger.kernel.org, mcasquer@redhat.com, mst@redhat.com,
 svens@linux.ibm.com, thuth@redhat.com, virtualization@lists.linux.dev,
 xuanzhuo@linux.alibaba.com, zaslonko@linux.ibm.com
References: <87ed4g5fwk.fsf@li-0ccc18cc-2c67-11b2-a85c-a193851e4c5d.ibm.com>
 <76f4ed45-5a40-4ac4-af24-a40effe7725c@redhat.com>
 <87sespfwtt.fsf@li-0ccc18cc-2c67-11b2-a85c-a193851e4c5d.ibm.com>
 <64db4a88-4f2d-4d1d-8f7c-37c797d15529@redhat.com>
 <20241023074237.8013-B-hca@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241023074237.8013-B-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.10.24 09:42, Heiko Carstens wrote:
> On Mon, Oct 21, 2024 at 04:45:59PM +0200, David Hildenbrand wrote:
>> For my purpose (virtio-mem), it's sufficient to only support "kexec
>> triggered kdump" either way, so I don't care.
>>
>> So for me it's good enough to have
>>
>> bool is_kdump_kernel(void)
>> {
>> 	return oldmem_data.start;
>> }
>>
>> And trying to document the situation in a comment like powerpc does :)
> 
> Then let's go forward with this, since as Alexander wrote, this is returning
> what is actually happening. If this is not sufficient or something breaks we
> can still address this.
> 

Yes, I'll send this change separately from the other virtio-mem stuff 
out today.

-- 
Cheers,

David / dhildenb

