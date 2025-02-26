Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C52190665
	for <linux-s390@vger.kernel.org>; Wed, 26 Feb 2025 15:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740582318; cv=none; b=eFHJWZJDZskz3tg3VPYkcD9I7xeEaPkFNFrFyLN8iGYoAMqTNdJGb0MMZKTTCxrergdDuHVH7ueSb9VyoFfpWEb9wz9aD2nLhKmVxOXURdqKWqc2lMsGOBPvqq1UmE8t9UsQs71SvpO2R2k7iOyoCK3RGYHXJHLR9yNI+HetYrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740582318; c=relaxed/simple;
	bh=UbsznBB7Ta4OOWxE6Q76ciArrmMaaUYgQLE2J5Bd0ok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DFiqIWQNenh7s4uad3HRaN5gRzsKVPkrgHjPNwgrIdp5Xf+JUse//oPvmLh5Gv6Pi/qE7OkOmd38tYSuCBIz3nHmTFjVELhuL8gmGjScPSLplbHzCCF64SrYBENZ1nonlJmV2OrVuU/t1G7QgB6HIeZ49cDRuBYwQYtL3zQrAGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c0sVXWdg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c0sVXWdg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740582316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DtaKuouL0Y3pv+96Ex3YwJXMFO8jE7lmxjvjb5LQJDY=;
	b=c0sVXWdgsSSrRxSALZtJ05GZrQnhSd6BNeu49l3y5Mx1r1+M/YAdNDokgWMIew6Z00SKRK
	PSHPFT2GFRgbYlpOBI1FVsN6gSlss95w9m3etUPW6SpNIm3ww5fyzgyHORMzupBv3GICWn
	KLWALrXXCT+DYnXpLUCqexg9IMPeghk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-V2vRdsGaN0iMH611QSKuTw-1; Wed, 26 Feb 2025 10:05:14 -0500
X-MC-Unique: V2vRdsGaN0iMH611QSKuTw-1
X-Mimecast-MFC-AGG-ID: V2vRdsGaN0iMH611QSKuTw_1740582313
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4394c0a58e7so52895705e9.0
        for <linux-s390@vger.kernel.org>; Wed, 26 Feb 2025 07:05:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740582313; x=1741187113;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DtaKuouL0Y3pv+96Ex3YwJXMFO8jE7lmxjvjb5LQJDY=;
        b=pm0A9N+MvVfw5NJX3r9XqbiYtwUAf8OpM1m7OCbwZmdcVCZDssD9SgKay5Cnouidu6
         qS2GTFQyWJNEGgPiBfZny+J25vnz1RaTMEXyVl5IqDewPRBiYmoH1yTtCoMz9rcFWA5c
         LJls2M7fXet/HxzlV7sr1Gyxa1PDDCKBraU2kmlubXHt2GLwRJyOP30r+S0giPLsyCrU
         WjZE5GJ2gyF4UiaULjhx6aHaaKoExihCbv7poQB53rXCB7STHcJfs2Na/1Gar+3dVyE/
         fXoElCUOGE7OhDDL5BhzJWNIGdr/I83hTtYRgpRQnrtwTmGFeMzOxbbmlrKLUhYhpl4E
         4ifw==
X-Forwarded-Encrypted: i=1; AJvYcCVSJzsXuk8aOU7dWEIh8AXYkOgD21WVcgkSkUy6O3pA1nVWET0m0HgUG683d3psGO7ydFpWjyZUQIDh@vger.kernel.org
X-Gm-Message-State: AOJu0YylvD9gv+Fd+N20K/XdGzy0fPLKlY5VCKkMmHw8VY55b0RgE2N+
	7X6KNlY8bRk2IAc97w0Yuomn8FJeIKnpvGEr/quS017oK9T8s9lRc+doYHGGU4qXQOjT9DjVb7A
	e1UNVmT2w4j//3gsvOfEyaLW8VQHRlO+t0YZN8Z8sUgf1x4WdKPxlnaNH7OA=
X-Gm-Gg: ASbGncui4jyyOyMADhv6Pcp3D0YbvEgebc0EYHFTvfconf0eEl8xmcq0v8Ry+2CSUSw
	+IH904vPjw1posLzqG5sXkIF1Y/TlLnVT/xIzOAR2qfpN5Q/+oq9L4Jj7fjXOh1D/N/awhLl26p
	vZEVMk1//v0q4XRBYCu3OqlnlwJuphUQxKywYovLGJC1W0TyDuEmTBohyr9oAV6J6tWX7DnZeHW
	0SVj4s6oBaBHeW6F/blN0A499kZMhmUKrS79LF9gjAJ2PKixw3gB3vea+lSJ/louyQU9CLVJ5Ju
	A6nnsciRok8s/i0jq02kMS1pywGyxm4FYbRWEjXgKkjd
X-Received: by 2002:a05:600c:3506:b0:439:9f97:7d6c with SMTP id 5b1f17b1804b1-439aebcfc40mr173325265e9.29.1740582313021;
        Wed, 26 Feb 2025 07:05:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3bcYNh8Rp+gjnHI+8lWknh+fmKRrB7o51AAIckCXQu2kuHMMgbo940KVzsy6o7t0A+oKQMQ==
X-Received: by 2002:a05:600c:3506:b0:439:9f97:7d6c with SMTP id 5b1f17b1804b1-439aebcfc40mr173324475e9.29.1740582312582;
        Wed, 26 Feb 2025 07:05:12 -0800 (PST)
Received: from [192.168.3.141] (p5b0c6611.dip0.t-ipconnect.de. [91.12.102.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5442c0sm24142145e9.32.2025.02.26.07.05.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 07:05:12 -0800 (PST)
Message-ID: <0dfeabca-5c41-4555-a43b-341a54096036@redhat.com>
Date: Wed, 26 Feb 2025 16:05:11 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] KVM: s390: pv: fix race when making a page secure
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 frankja@linux.ibm.com, borntraeger@de.ibm.com, nrb@linux.ibm.com,
 seiden@linux.ibm.com, nsg@linux.ibm.com, schlameuss@linux.ibm.com,
 hca@linux.ibm.com
References: <20250226123725.247578-1-imbrenda@linux.ibm.com>
 <20250226123725.247578-2-imbrenda@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250226123725.247578-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

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

You very likely need a pte_write() check we had there before, as you 
might effectively modify page content by clearing the page.

-- 
Cheers,

David / dhildenb

