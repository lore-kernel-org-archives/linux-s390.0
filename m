Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB051990A2
	for <linux-s390@vger.kernel.org>; Mon, 20 Jan 2025 09:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737366206; cv=none; b=mFEBk29B7fNIk6MqY0DU8q/8uI25E+HoK0C1iYyYi74paH4ImemUOZYQa4yjK4WlC/ASwTxQiVU++If1rmi0CeNvstZhV7XYeWTonX6NBy/Drt3WkzDJhOqHjaxFsKyBlXQF9W+c5N1MZkwSLC8ilCreEOdUtByA7PdkFN/yqdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737366206; c=relaxed/simple;
	bh=7yltDO0cCW6P3inmuAW/5blxL9oNGVe9nJKoJIqmk9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qAbX7iZkXTOQCUxGbNGz3wl/aOBGLyXSTHRgTsjmGI+CI0h+mw5/kwI1Og5+al7/dtH8+zDcJXBazEdwMZaZAWsXz8DkF4FeEJlzJqVvHeX/rKmIQV1I4gxL0L0+jzBEboL5rOGye8nYEyPUjHursCHP8hO+7xHEKpkME+8jVjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LE3ZKPiE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LE3ZKPiE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737366203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PhYutTSI9XXCWgW2e4khwQgLNBYz4a4Eki2ijAbaXfo=;
	b=LE3ZKPiEvJQRDQ6uR3hgMwiRyfd01EGfeAzmcpDicHaEaOJ9OPqlO+2QS8lY8D+1hraCKw
	Z1hSJe0Ktz/ngtLonBwD03biQynfWKpbAlODwqcTYfP6PzluLkCxzlg/vFc815hx6IKbKE
	sXZujVfchL9BLNXi64Y05w6GGRN71uU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-OENKCrLnNu6OC8J6Z_jvyg-1; Mon, 20 Jan 2025 04:43:19 -0500
X-MC-Unique: OENKCrLnNu6OC8J6Z_jvyg-1
X-Mimecast-MFC-AGG-ID: OENKCrLnNu6OC8J6Z_jvyg
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4362153dcd6so22060195e9.2
        for <linux-s390@vger.kernel.org>; Mon, 20 Jan 2025 01:43:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737366198; x=1737970998;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PhYutTSI9XXCWgW2e4khwQgLNBYz4a4Eki2ijAbaXfo=;
        b=Y/X4UmELxrrghEsg/RvptxLgOxaA7W8EEeWXlcsBywsjekny+92MjgSm4BgrfHN0E8
         zqjRAR1x41CQbPxgquOdXJ3GN5STY0FgozFWW/5zzWCMFDC60R4CoOaMlTAkMzyCItk1
         6OI1nW2EkeP38piuFAL+4puwPN3aXLVbDEJaiSxMFEqqo31qEBFFn9Iu6STeFkTH+gJJ
         UBYS/LEREzYTBRPAKDOtYGlBUnsXS+xd3zWBpGUDdECsPkzFR0zcQ3ykA0vDm471KwaQ
         GJidhtBwXCct1WtVHckc80+llHrLDEoiQ1g9ORU9vCrjN4sfNXYDGpcKAFRGXWlhYIAr
         Ek6g==
X-Gm-Message-State: AOJu0YwsDHhMk8luAERPIbeiDhTgA9KWldO0tJZIiXOGYC+D16p5cvCG
	+CcWKk4RB8qSi9hG9iYmlqf1J56pXS+Ndvc2DthCDBNo3md9H1Vg+2qAX0I65Sn42LmLgpk/wxh
	9BNcql/mECmxMwHkw8OqGMKM97NA25ceZpYi+svCTSI1CJxpBO1T8Xiydz70=
X-Gm-Gg: ASbGncsKeN/fMEyOAsvr6FEboUV08ySyI/t3Qp2M+GQlJLh+GAbJkim+pDds6GYLEBr
	X0oKUh4lpcBq22/oT0xH/3gwOTBjnZv9diKU+PkN03mP4aJFqF3GVm2e+hwP8hQsxZVMQKGJ+0z
	FwC/octsK2wLek5TQIaPgy8dV09DAOKUxfhJweVTwsUj/qdwMm6pKX1JY0x6jrZAxfoY6sAgc0u
	FVKFwxE8qPLq/k0RuJXhCKb+fKfEvwRfcnVkqeSza07OzPmLwqplojC8Kaw5mBipLsFMMPNqEzU
	+T5iOHNXAHDcnh+oLOSum6PstGdNhwEGjUhInz0GybxInp8usgr4Y+5ZIkcFlF+Pm/Mg+mEuhzP
	79Kl5FajtEYjEcfb5R26gSw==
X-Received: by 2002:a05:600c:8717:b0:434:fbcd:1382 with SMTP id 5b1f17b1804b1-438913ca6acmr128681625e9.11.1737366198566;
        Mon, 20 Jan 2025 01:43:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFumHjK+xQrL/A4BICtnpxvtA9GEVVijT4kYARyMsPcMOjeN0CPpzBzaSl5CD4cAJ/B/4q5Tg==
X-Received: by 2002:a05:600c:8717:b0:434:fbcd:1382 with SMTP id 5b1f17b1804b1-438913ca6acmr128681205e9.11.1737366198167;
        Mon, 20 Jan 2025 01:43:18 -0800 (PST)
Received: from ?IPV6:2003:d8:2f22:1000:d72d:fd5f:4118:c70b? (p200300d82f221000d72dfd5f4118c70b.dip0.t-ipconnect.de. [2003:d8:2f22:1000:d72d:fd5f:4118:c70b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c0f026c0sm104503495e9.0.2025.01.20.01.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 01:43:16 -0800 (PST)
Message-ID: <e548aa1e-d954-4fab-8b74-302c140c04f7@redhat.com>
Date: Mon, 20 Jan 2025 10:43:15 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 13/13] KVM: s390: remove the last user of page->index
To: Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
 schlameuss@linux.ibm.com, willy@infradead.org, hca@linux.ibm.com,
 svens@linux.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
 nrb@linux.ibm.com, nsg@linux.ibm.com
References: <20250108181451.74383-1-imbrenda@linux.ibm.com>
 <20250108181451.74383-14-imbrenda@linux.ibm.com>
 <4175795f-9323-4a2c-acef-d387c104f8b3@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <4175795f-9323-4a2c-acef-d387c104f8b3@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>> +static inline unsigned long gmap_pgste_get_index(unsigned long *pgt)
>> +{
>> +	unsigned long *pgstes, res;
>> +
>> +	pgstes = pgt + _PAGE_ENTRIES;
>> +
>> +	res = (pgstes[0] & PGSTE_ST2_MASK) << 16;
>> +	res |= pgstes[1] & PGSTE_ST2_MASK;
>> +	res |= (pgstes[2] & PGSTE_ST2_MASK) >> 16;
>> +	res |= (pgstes[3] & PGSTE_ST2_MASK) >> 32;
>> +
>> +	return res;
>> +}
> 
> I have to think about that change for a bit before I post an opinion.

I'm wondering if we should just do what Willy suggested and use ptdesc 
-> pt_index instead?

It's not like we must "force" this removal here. If we'll simply 
allocate a ptdesc memdesc in the future for these page tables (just like 
for any other page table), we have that extra space easily available.

The important part is getting rid of page->index now, but not 
necessarily ptdesc->pt_index.

-- 
Cheers,

David / dhildenb

