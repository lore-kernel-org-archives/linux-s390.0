Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3367F1B87EE
	for <linux-s390@vger.kernel.org>; Mon, 20 Jan 2025 12:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737374958; cv=none; b=py8I1vnyA/Fpi4feZ5o3B5UC5KOz9n7fSvfFioNkbDDhSnR2mREURwfUKSbGgGZu2QpUt1VIrEOKVfI8uothsh9yy1uW9HJ222Va2Gs7+I56wxbzoi8MD1IvAg1g1lZLzBkzn2aqfHGeLxSspT9zjLs+3bQvC9iOEMTahoKBL8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737374958; c=relaxed/simple;
	bh=wyYZHXMjCW6fDQgo56Nnb0Lbnh4xIdOtvsRvRVfIyw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BstQRLJPBMO+qadgCeQplQ5jZAADTAyZrXIPHPV9TFzqoH1+YyPHiPd7CjF+K6nDPjzV77me7Cdnv8I+7336oT021f+2xo8RfvK7ppOFWAyQTqBlqduytDfH841nT+fjXjYr2IPw4EmE0O+STxG+DNdUo309jHzKuv1k1pxF9Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W/Dhtgll; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W/Dhtgll"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737374955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PWZtPfFombM1GwcMhSbDl1k/MneBnq4+qv0QUQPibv8=;
	b=W/DhtgllxMX+qs9lnC0lbORjhppT7W/zL6SkRkzGuRkqwo63ebALz/BG3fRz0Za0x0nTze
	T4+l5+xBzRtUl9kETSOv9l4++Fzip9t6Xil5JvEyi8Re1fGzK2AIVHqbQWveDLLIR8h8e7
	PxvufQ1NEpCXOs8262HT41zgO5LmUTo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-s41it2LBOB2Bd5LWz5Z8Lw-1; Mon, 20 Jan 2025 07:09:13 -0500
X-MC-Unique: s41it2LBOB2Bd5LWz5Z8Lw-1
X-Mimecast-MFC-AGG-ID: s41it2LBOB2Bd5LWz5Z8Lw
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38bee9ae3b7so2992617f8f.1
        for <linux-s390@vger.kernel.org>; Mon, 20 Jan 2025 04:09:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737374952; x=1737979752;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PWZtPfFombM1GwcMhSbDl1k/MneBnq4+qv0QUQPibv8=;
        b=CY+E2IqvtYrMbYRX1gBDP2Boiwz20F1qHInEyG4MM7YSJJ93NRuB+KdDAm8embMyq9
         /xgRNQ3vag1TItsJaGKjJMG+Vhvv4HqiOcecEv6a9HyTs2wiS0BdMqvsvasqdK7uVl0W
         EOINoxNQBJo356rZ8vTBuKgRSS211iC/8+t9duf3Au/b+lKqHSg9uw9cxXKkcx0MQp+r
         WSjykmJMvZlBQt+BAbr1gj5FUgaQtvxIyTZFCFS9S37Y7Q6KuP4lDft/4DZWtPyvX3FU
         gqZ12weoMfI8YLO056mmMq1zOhmur88dVpNXrVqIE+TjeQvJ8GiH85WAZSzT6hB/svEL
         hHng==
X-Gm-Message-State: AOJu0YwaWE7egh1R/nMC3SXQdD6Um/UQ51o26Iyue+OzLh+G0bj8bSHQ
	6g7aVgL9nlrs+VraAqO+2e83dqmg6msiXq6RoZUv3HMzF1bosbTyFmK60SjBqQN0SHqVAC/domR
	XT4+Iz2g32Sbyc7TaNr1kPbaTebGsRnKPTkRjcAjlL4xPLlFU2ROCnpHlD1Y=
X-Gm-Gg: ASbGncs8+iCXaMoTgj0PvP+ZY/rLQ2Kwpu5MWtcZEq0qYjxvgr749eONbozJQ0R1RNU
	vvG8C5wCOhGcW6zgPwlEqxQb5x+MN5PfUxsRheiiMahws0T0ErsMmofy0sLOVtC4ezqIa8jJqwd
	ccVG/vdC8zQevqEWPZB2OTgFtlQrVxQhG1vNi2/1qHK6OUh7YKmuJnyU4ULhpidPbwwUPFM80Ng
	P6AOcYt9r6DHfFrLP7H4otbvOkb9eHsTEuKI7hdk9uRFqCyv3A71ByORpyZ6TFh0l8IhEjPeEzu
	6ppjxFpmAzDSSMNXzagjpJDnodIp2Ih0k/vJ5+KEq8D2EYEtcKeGoworDwDxJ94R9TGnqBbo2xA
	2J8kr6zZ9mwZ1BQDNJjF49Q==
X-Received: by 2002:a5d:64a1:0:b0:385:ddd2:6ab7 with SMTP id ffacd0b85a97d-38bf57d3802mr11435108f8f.52.1737374952597;
        Mon, 20 Jan 2025 04:09:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFF9ZJSyFUcZ5+rv6O8fJppajvMveGSZDssR9ikLBpfoeYYgOuSmnlQ2tSrqo+FORUxOGEa0A==
X-Received: by 2002:a5d:64a1:0:b0:385:ddd2:6ab7 with SMTP id ffacd0b85a97d-38bf57d3802mr11435071f8f.52.1737374952244;
        Mon, 20 Jan 2025 04:09:12 -0800 (PST)
Received: from ?IPV6:2003:d8:2f22:1000:d72d:fd5f:4118:c70b? (p200300d82f221000d72dfd5f4118c70b.dip0.t-ipconnect.de. [2003:d8:2f22:1000:d72d:fd5f:4118:c70b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf327574asm10308237f8f.68.2025.01.20.04.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 04:09:11 -0800 (PST)
Message-ID: <ad68a346-6027-4b5b-a68c-85b8898582dd@redhat.com>
Date: Mon, 20 Jan 2025 13:09:09 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/15] KVM: s390: fake memslot for ucontrol VMs
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com,
 borntraeger@de.ibm.com, schlameuss@linux.ibm.com, willy@infradead.org,
 hca@linux.ibm.com, svens@linux.ibm.com, agordeev@linux.ibm.com,
 gor@linux.ibm.com, nrb@linux.ibm.com, nsg@linux.ibm.com, seanjc@google.com,
 seiden@linux.ibm.com
References: <20250117190938.93793-1-imbrenda@linux.ibm.com>
 <20250117190938.93793-4-imbrenda@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250117190938.93793-4-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.01.25 20:09, Claudio Imbrenda wrote:
> Create a fake memslot for ucontrol VMs. The fake memslot identity-maps
> userspace.
> 
> Now memslots will always be present, and ucontrol is not a special case
> anymore.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

