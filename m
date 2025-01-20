Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FAE1DFDBB
	for <linux-s390@vger.kernel.org>; Mon, 20 Jan 2025 12:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737374865; cv=none; b=MYaAi3a/S3VCGYAS9rnb7YE8ff1lDR7o/QRUJjXwPyAnaz1mAkDY7xL3EBMuGgOhF9EemeXUMPgW7D6olek3SvySzuqo9R9JjGtHTVB3bMGjUqJS8LdWFHIBlxwxPV4TmPexzc5ISphS0kxJbuArwas8ZYAmH6WVwxTs2Nr/yKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737374865; c=relaxed/simple;
	bh=QUYHxT40mbwQGRn5kwSA/TizS2VWnnxFvv8E5Ki0ApI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qw8IrkYZNN3lMW0MlVsiTu6EK3kiUHkH/PbmuSpJZATnfFWIu/kCAaAvK75Zbt4F34PvMu0/ucXuTwrBFoEgp09C/qLT6pjSQ0sdMu8lu9aAs1z63i3ICGuMhRPnQTJHjklDnwH3pO1C/MPiZElqmI5k6Zl2Ihehmp5K5m7n/zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rt8kWv4a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rt8kWv4a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737374863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=noefFr5DPAf8uJvahy7JmLqUWiJUgQ1dlk/eUbIKrLY=;
	b=Rt8kWv4a6GbXYpMWJxtAEYYRWbKrQlTLqQKS8UqD3BP7YtVJNjr/nDmU9iqF5yqmaNUnLq
	7JXQAbUpYteHH4hgqZKlauba7s9g9s1Jp735ZI48vrLnHfzUD9GCr+3g0pbeO5a1wj2vBJ
	7YupiSTQgM+3Tu/jgDb+YnwTCbsbZTU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-H2n9aqb1O-CkBFJw5CgHew-1; Mon, 20 Jan 2025 07:07:41 -0500
X-MC-Unique: H2n9aqb1O-CkBFJw5CgHew-1
X-Mimecast-MFC-AGG-ID: H2n9aqb1O-CkBFJw5CgHew
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4361f371908so33518035e9.0
        for <linux-s390@vger.kernel.org>; Mon, 20 Jan 2025 04:07:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737374860; x=1737979660;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=noefFr5DPAf8uJvahy7JmLqUWiJUgQ1dlk/eUbIKrLY=;
        b=m8H1tpwGIj26IeKOEyzLNY/uhnzxbgKLnBOwdAX0MrnRneHrk8eSaWj2Y2m13uCemA
         0oBuyCDVqzGt8fLzPvrrBvPH8absFHqow4DOUDQzXxNqjAAjliVnU9kUF5TXDt6iBfCw
         mSACmYZhSuq8lECp4nfw0qsGyp6LpbVgV3vFNNfxJUG0adtmEdkppelQGIj5ETq389z1
         mr6zmm1QC1vzf3CyGVQtkYDtGyOWwVzVhdCycXAG0OWT9ma70rgthfYLXcFZ8ceFH+Ba
         HbOB9Q9n79rtA9lP7LC++1rcvrdh9RJMXVAZ9lY3a+16ntMUibtGSTRQk3EzpMAvEctV
         vE+g==
X-Gm-Message-State: AOJu0Ywj/mSEaNvImzb/x36bziVgXEUZXe07ew1lcYPAzZDp/GvQBICr
	0dCe2mNZTOECntFdNWrWGfoM5oo9EpP5r1IkwnqG02tKBRbyiLShOcaxLgMgr13Zuh4y2uRJpkf
	7G+g2bRQCN6tOjBRoP7KX1vM3zYvK8x67iwpCD5v/8C6o1bOydO4KFmWDRXc=
X-Gm-Gg: ASbGncuKfm/OZHjWb+xwfGttkZtwh2m7/g7fJqtkBbqkOoTshlW3TL4zklxjVppSIGV
	gml3MCboOcN60rctaLsd/BomexinR6kyI6ABiIFM/NaPrCXYAz69Cp63lYxLxMNgj799f3LSR9X
	1CEamgh42J0MVHF2w+A3N/IH3/7TBWyQy4Wprus4Tsa7NujlPGuM/fyBT10sRwWzhgYq7KMydML
	XV4M8nGPEnpaGxFDfz6j91yXG740CfXRSjAVoHZ+2jjVCZLu9Hg9aHZCiFpM04s7wmaxLHqTMRx
	8nGUy8NC3aRtzKGAol+q2L9YDJKAwlBeXxAMlRND7oREVxzUNxH5DFpwrwJfH5k7MYJp3eGLNQ2
	jCJN6YpGR9bUF7zJT0G1phg==
X-Received: by 2002:a05:600c:1d1d:b0:434:a815:2b5d with SMTP id 5b1f17b1804b1-4389141c211mr103039255e9.24.1737374860424;
        Mon, 20 Jan 2025 04:07:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyl1GDQ+PFz+T0p36CM6DJH9mNlBF+N6lydwQjW3GsBxIFVGLCEAiDuher4KfL95tNIjmFkQ==
X-Received: by 2002:a05:600c:1d1d:b0:434:a815:2b5d with SMTP id 5b1f17b1804b1-4389141c211mr103038935e9.24.1737374860025;
        Mon, 20 Jan 2025 04:07:40 -0800 (PST)
Received: from ?IPV6:2003:d8:2f22:1000:d72d:fd5f:4118:c70b? (p200300d82f221000d72dfd5f4118c70b.dip0.t-ipconnect.de. [2003:d8:2f22:1000:d72d:fd5f:4118:c70b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c7527fc4sm196648745e9.27.2025.01.20.04.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 04:07:39 -0800 (PST)
Message-ID: <ca7e9eb1-92d6-4b29-a9a7-502f1c78ab3d@redhat.com>
Date: Mon, 20 Jan 2025 13:07:37 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/15] KVM: s390: wrapper for KVM_BUG
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com,
 borntraeger@de.ibm.com, schlameuss@linux.ibm.com, willy@infradead.org,
 hca@linux.ibm.com, svens@linux.ibm.com, agordeev@linux.ibm.com,
 gor@linux.ibm.com, nrb@linux.ibm.com, nsg@linux.ibm.com, seanjc@google.com,
 seiden@linux.ibm.com
References: <20250117190938.93793-1-imbrenda@linux.ibm.com>
 <20250117190938.93793-3-imbrenda@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250117190938.93793-3-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.01.25 20:09, Claudio Imbrenda wrote:
> Wrap the call to KVM_BUG; this reduces code duplication and improves
> readability.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

