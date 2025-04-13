Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5961C1D5AB5
	for <linux-s390@vger.kernel.org>; Sun, 13 Apr 2025 20:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744574752; cv=none; b=ZXrMi38eqKc8sH74eOpGVdWDWU7Y8ZVRDWdoVbmKLo+3PY2+gcccO0TH+hX/d7UF5qJeMmYlqEmgW5m3+rEELx5RMVm/VV52Kz4d3dxybJDj9txt4DntwySGuP8C+c0cSZIG+hCcau7ZINde/8NziyINAzhe14HLxBLyMSvkbIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744574752; c=relaxed/simple;
	bh=2mdYX/2GVIgDd+Po4gWQNViRS76n/C4qNnW05RfESvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WzsDLZKBnKzd0zstfxW8F45oBD+Pqp63QsOYs2HObr6XedTpkDTmvzQklJ9JXRKjgY7+cGbzS5PZBecnCQCFdarikDv3M7NjFcHOwPwWgj/OABX5bcGSmgkMdbKoQge9nr1iotBgMnFqvuJdDqVz+OVehfgK1FUYvTiveyhAluM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BWCV7/gf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BWCV7/gf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744574750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=26kQaqxmClrkmqimyK/pAn0V/eLIFLyRyoGwKGCOpj0=;
	b=BWCV7/gf+01ePG9hHR7OXIm556zanibNap8ulCE7FVqofE+TmqYPshdEVPuIeTvdI5xYAM
	X47IIZUF+xw7kT5NM5/Irh5+ZDId/LirE64Nb9xv7qEq+L4agH2LI1xjCoJqbMNeI6fJW5
	EGasV2mnKY7sTJgleFZms9E+2Q4eSV8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-ZaLdnhHHPimY3581-qfTEw-1; Sun, 13 Apr 2025 16:05:48 -0400
X-MC-Unique: ZaLdnhHHPimY3581-qfTEw-1
X-Mimecast-MFC-AGG-ID: ZaLdnhHHPimY3581-qfTEw_1744574747
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43947a0919aso25326325e9.0
        for <linux-s390@vger.kernel.org>; Sun, 13 Apr 2025 13:05:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744574747; x=1745179547;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=26kQaqxmClrkmqimyK/pAn0V/eLIFLyRyoGwKGCOpj0=;
        b=g7LHmbCqsUpJiVn3uwsuyi1zEZzhXTkUYOEUyURx8NbCkL5+IG7kF1qtu4wGaX9pNT
         XAFT8/bK0TuuBT+uIO440o7DNaL3Bi/SjA3UxPN0Hr53uawoDxk7LQvFFJlodwFg2eLF
         sJBYPg3vwm9Da/n/BWa01/MiLadl1jrLglPtSZPG/zyEBX/4ujRDUoNkunoxGkmHuaxS
         +VPuvvPpEc3AYpJg2zkShbZKPhN9KxnvZ4Ls5ai00MPkuTRbXPLB/QTUBViKJxRwvwxM
         uzyt5cnr3u73qlGsGLnH9t7YFK0hqkZdnqoAuJxnoWOWoYTGP2tljoVtW3Spg+9Vqc+A
         vzUA==
X-Forwarded-Encrypted: i=1; AJvYcCXgS4rd+kLVXdtGGOpy2E2L+AVGvn1i8KMSfkatCj1biObG794iFSk5nqDwbCBW7Yy2rRUKZOvLf8xT@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+d4Smd5jsZszyRCnWDkKM8KOIH0riwSNUz2wz9y4uBcKZU0Eu
	W0wddGfmOTbq/8d2em9bk7wkMQM9Yy4RIJeyQiuyxHBfQRB8DSUwa3rVuJ5DLG87dIxBQydpMqL
	dAh8/xRJGoHCD3IfDjPvzEUTyT0mFpFBkyUnbWxL8n1e0H8gjNdBu093ZCM4=
X-Gm-Gg: ASbGnctT3DyNrvzmzZZ1KOeLnostNfTdI+4Rlrd6MWyo6hNpb0cEWKyC3WNjvY1QX9r
	uVRuUBv+ZYQnujvT2C8FeFAzy4V68stSxYiI1KlsCIg2tmesJCe/1DEkSlWcsS0i1utxbml0BZm
	IQdteBjeTssOe4mu3CTqqjvHbHgipdSZ3A23qnoXI8+rBgprQxXTzqiDTrpPXn5AxE+AbpIp8Ey
	cXqQIPbRvDGJ2AAP29Gj2c38j4P5pBLhzJ4KWaKFBRXyQmncJP8tT8/p7VsT2PUyn30Maz0sxnT
	aIJ/GwVQ+6EdYn4hteQ9IDIf6rq7Ut8RLGnjvtn29kEYJzLiRI+f6STDHT3YzkDZ9uFtGXTTx8t
	lHt31zoxXtvHI+X2QN/yNWrPVP4SSnLdcsXy1dYg=
X-Received: by 2002:a5d:5989:0:b0:391:3915:cffb with SMTP id ffacd0b85a97d-39eaaec7870mr8568034f8f.43.1744574747469;
        Sun, 13 Apr 2025 13:05:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEj0NxM0N0abRhomL8K4YcFkTrVF5uys1Aj1DUWE1g435wGfrkYysdjnFb/nCc5L8Ln6JHViw==
X-Received: by 2002:a5d:5989:0:b0:391:3915:cffb with SMTP id ffacd0b85a97d-39eaaec7870mr8568027f8f.43.1744574747090;
        Sun, 13 Apr 2025 13:05:47 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f02:2900:f54f:bad7:c5f4:9404? (p200300d82f022900f54fbad7c5f49404.dip0.t-ipconnect.de. [2003:d8:2f02:2900:f54f:bad7:c5f4:9404])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2338dc13sm159877575e9.3.2025.04.13.13.05.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Apr 2025 13:05:46 -0700 (PDT)
Message-ID: <c7aee943-2802-4a41-8e3e-e80f45e80dec@redhat.com>
Date: Sun, 13 Apr 2025 22:05:45 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: Introduce free_folio_and_swap_cache() to replace
 free_page_and_swap_cache()
To: nifan.cxl@gmail.com, willy@infradead.org
Cc: mcgrof@kernel.org, a.manzanares@samsung.com, dave@stgolabs.net,
 akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 will@kernel.org, aneesh.kumar@kernel.org, hca@linux.ibm.com,
 gor@linux.ibm.com, linux-s390@vger.kernel.org, ziy@nvidia.com,
 Fan Ni <fan.ni@samsung.com>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
References: <20250413042316.533763-1-nifan.cxl@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250413042316.533763-1-nifan.cxl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.04.25 06:22, nifan.cxl@gmail.com wrote:
> From: Fan Ni <fan.ni@samsung.com>
> 
> The function free_page_and_swap_cache() takes a struct page pointer as
> input parameter, but it will immediately convert it to folio and all
> operations following within use folio instead of page.  It makes more
> sense to pass in folio directly.
> 
> Introduce free_folio_and_swap_cache(), which takes folio as input to
> replace free_page_and_swap_cache().  And apply it to all occurrences
> where free_page_and_swap_cache() was used.

Patch title should better be

"mm: convert free_page_and_swap_cache() to free_folio_and_swap_cache()"

and similarly adjust the patch description. Thanks!

Acked-by: David Hildenbrand <david@redhat.com>


-- 
Cheers,

David / dhildenb

