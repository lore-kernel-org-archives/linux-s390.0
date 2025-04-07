Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3AE227EAE
	for <linux-s390@vger.kernel.org>; Mon,  7 Apr 2025 08:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744015763; cv=none; b=uhLAGLd3TuIUHsYNKmxybWvEfzzfMmdNSvPsK7aZlKidOxkdluLRj0soTbleBzh9FxSw8ep7xebpdl/979081xXEwcrxDj7R9tro8PpP491oZcnI0Ihm5N77r4Ei1zc19F29s75lm6ov+uwI/opLAfjR0dXr4WlbgBu3RU9bBZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744015763; c=relaxed/simple;
	bh=IZtLDURYDTq0b32MVRHTcY8RDwEllmanE9uQZcvW3gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkDmRHpBRyeEp4pVWeSyLNToFkg5OWnk0L4sUPUtgr79kC0eRtgRx5RenpmRmiUpUJrw8Vg7rYC3gqww+n4lujJWoTX97T/fJbObWQdo0UOhwXDlEAkivL7zjVX1zhSeP2YRSnQ8PbZGH1g21BGc+Zz37Bh77DmvLj8tABatVjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EPh2MDY2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EPh2MDY2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744015760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hpu5KqbXEO7FQHIb0ETZFO78MX8aCe7lEYNvf8XqmxY=;
	b=EPh2MDY295e/BmrhhJRCOQ0326XjOmpeysTfkGxk/ZLFfM9a1XYWS2j6P45SFr7wz/DHsQ
	Wxuo7XbOf66qAxyN6Ld6iq1tSpGFw/rv1KgZaeYDNh7otX4hPvq/my1UynsfkNYu5YCDEG
	AN33p+zTJuK1iU18rTdybczgFpTTRAg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-wLPuK5IfOpO1i-bEWTXJ5g-1; Mon, 07 Apr 2025 04:49:19 -0400
X-MC-Unique: wLPuK5IfOpO1i-bEWTXJ5g-1
X-Mimecast-MFC-AGG-ID: wLPuK5IfOpO1i-bEWTXJ5g_1744015758
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43d01024089so34896695e9.1
        for <linux-s390@vger.kernel.org>; Mon, 07 Apr 2025 01:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744015758; x=1744620558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hpu5KqbXEO7FQHIb0ETZFO78MX8aCe7lEYNvf8XqmxY=;
        b=BsLTfrNW+DQHa3Cp5iNiuBT4JYhNYD7If0IWjCU2dUKRrQkM/NT+bZi0BlUwTlA67y
         tUK8cfbzRekjUhMLMkKyXe4Geg+UnN8//psdV+LY9XeuLgByx8GMzf00CrfdX0i7mMXm
         bJs8kIUlv2RX4sEDhGn8ABzbp74BinCaORolyQRBVvimDZzUDFDZvrKxNQz1WD0rSV8l
         QAr9rx6TwiBNpwNRkKYZFiVlNRnpIyInikNZtMVQxmX/EKxt3vWFEwBX3aOB8POWcfPm
         /lyz3e7GSHTtD2h5LjawukRCL2c2inSH+y4buRY/1Aqnj1egF51V7RdPf+WPrVpalfOE
         Qzng==
X-Forwarded-Encrypted: i=1; AJvYcCUphprfyhniC0ONaOcBHGSTkpdeH087T5NbgW7G3ziZU57uq18s1q+i3YRdvn3AN7jNV5kIS/M8Phen@vger.kernel.org
X-Gm-Message-State: AOJu0YwsRLFvo92E59voaJGcXYeIcF+Wd5m5RmL0OTqBhesIVwKNxaGZ
	2i1WvfDRYGfLazK4asHX/hsZje5IpagT+TZZQy9AhZSJISDBSHO/IbFi6PY390v5/h1GEYmgs+C
	fDzhcWSGLA4qynVx92ekkdyQySEu56zLO55MCoZDTMI5lP1aojv4rr8pojIU=
X-Gm-Gg: ASbGncs/zEdkt8/NYr8M0HebKQhqaR12OWXBtTY8qaAAhhpnJ7LWyRQOkS0cC99DAa6
	OZalbWIUuKsR/26LIj5bpDomtL4oUdnCFreJh5etWid+pc8onTdhRF6duYo5IK2o+z9v3xf9Tth
	jBfsbFBMSRNiOdvj3+XS22h7ITqpcxonZbBCA7B9o+izZFy52UHit6KyIlbbHX4kPITNbLpQQNm
	/cpSoX7zXREXonCYnY0Kw7ZDok2p6g+CcmfTCtlUciuZJo14FQ79vey5Wd6UYVfCVAhw7Q8Adsu
	WHi/8ZguTw==
X-Received: by 2002:a05:600c:3306:b0:43d:fa59:be38 with SMTP id 5b1f17b1804b1-43ee2aff1a0mr38130135e9.32.1744015758298;
        Mon, 07 Apr 2025 01:49:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNYPVVGEAhzNqS2UPVe5mcCou0C3HnRif0zA9AGHI8Xqo5GZ7Z22p9jJeCaR5blASlwYtuCg==
X-Received: by 2002:a05:600c:3306:b0:43d:fa59:be38 with SMTP id 5b1f17b1804b1-43ee2aff1a0mr38129915e9.32.1744015757955;
        Mon, 07 Apr 2025 01:49:17 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301a7586sm11552495f8f.38.2025.04.07.01.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 01:49:17 -0700 (PDT)
Date: Mon, 7 Apr 2025 04:49:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, Chandra Merla <cmerla@redhat.com>,
	Stable@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v1] s390/virtio_ccw: don't allocate/assign airqs for
 non-existing queues
Message-ID: <20250407044743-mutt-send-email-mst@kernel.org>
References: <d54fbf56-b462-4eea-a86e-3a0defb6298b@redhat.com>
 <20250404153620.04d2df05.pasic@linux.ibm.com>
 <d6f5f854-1294-4afa-b02a-657713435435@redhat.com>
 <20250404160025.3ab56f60.pasic@linux.ibm.com>
 <6f548b8b-8c6e-4221-a5d5-8e7a9013f9c3@redhat.com>
 <20250404173910.6581706a.pasic@linux.ibm.com>
 <20250407034901-mutt-send-email-mst@kernel.org>
 <2b187710-329d-4d36-b2e7-158709ea60d6@redhat.com>
 <20250407042058-mutt-send-email-mst@kernel.org>
 <0c221abf-de20-4ce3-917d-0375c1ec9140@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c221abf-de20-4ce3-917d-0375c1ec9140@redhat.com>

On Mon, Apr 07, 2025 at 10:44:21AM +0200, David Hildenbrand wrote:
> > 
> > 
> > 
> > > Whoever adds new feat_X *must be aware* about all previous features,
> > > otherwise we'd be reusing feature bits and everything falls to pieces.
> > 
> > 
> > The knowledge is supposed be limited to which feature bit to use.
> 
> I think we also have to know which virtqueue bits can be used, right?
> 

what are virtqueue bits? vq number?


-- 
MST

