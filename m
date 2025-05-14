Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CAF280CDC
	for <linux-s390@vger.kernel.org>; Wed, 14 May 2025 17:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747244071; cv=none; b=tlo5Y43oFKE6Ap/x4JJ8MgzfH/GvjF4Bsr2iytcgxRtIlApmP+xiywuQiwLk/H2mnobq30K9E+xMHpS8fkPhiXa4BvCmLyoPyyPOy/ruTYYuwIOBHteoXGYB8RbANER0/AJtBgHS3vFBWPrcumfaJWeYIMgQZEmOEJK4ohXBUZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747244071; c=relaxed/simple;
	bh=kVRO3G/4PNVYlIlAQRXqbDnSY+k6vJJXhBt+6U/6DIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fXHA9Qe/Zxaws96WX2/JduBad5cP3vMW99Obaw1LVDcc88FfqKwc2oVF2guBSUk1w6ZZfJ/vnvKqjNIVAhfMu7dPiN3WvMDYCIB9apfS74iedQJlzwsml+9JKVORBTXO0Fl5rmWvuEVtiedyUsgXoFy/H5pl2N5qOq/pMVRZ6dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W9GOeWDx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W9GOeWDx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747244067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Mi+ZyIRicg0MtDqlOGNscgLfMwwnzViispwL1nSnpp0=;
	b=W9GOeWDxgE+5Wg+CoSnraRPp9pNcAu+wygC3HoO/faUVV235RA0X99D6Ue45EyQsxDWABR
	3wJzGkd1sYrQqBB/+FNSpBuLsK49Hqsm8+FYIzeJY+TI/BMO1P1O8XDdPWK5MYSrARlxis
	qFTOi6rGc/J5f2nxJEZGs2wntEMlK+c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-aC2dqwXENIK_q10wWbNLdg-1; Wed, 14 May 2025 13:34:24 -0400
X-MC-Unique: aC2dqwXENIK_q10wWbNLdg-1
X-Mimecast-MFC-AGG-ID: aC2dqwXENIK_q10wWbNLdg_1747244063
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a0b7124b5fso19686f8f.2
        for <linux-s390@vger.kernel.org>; Wed, 14 May 2025 10:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747244063; x=1747848863;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mi+ZyIRicg0MtDqlOGNscgLfMwwnzViispwL1nSnpp0=;
        b=aj4FdfZqSy9ytLEz11glImKFgmUOPhkPVUs/lSbm7sY/nSsEwWNdiEuqhn1H28WlDG
         guVIEwrWVyJt46QUu5wAbrodhI1I+FD//5ORuRS/OeLM/wMPNCfVR5PRWqyFW/NhRe1K
         2lL9pcHFTQ2psxH48mYL8YMCnUY6JTh45GcebXCMmGkpooHD7ex33rtOahpdDHV5EeCJ
         kC2fT7BfpD/9hfDfN11lm00PvrkfSOU1QM43qFuREZp+rcRPVP7viYoUNjU+cgVSIiuW
         BfY82/qIK2kbDwPAt0osHV+YCWYT216M6sfIH53GO+M6QAp6M6EwwCcf9GRY6T9z/Cu4
         BnrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqGcGYDwQK5InKeb8tG7RQAUWyCjPJyYg4ymHsiTKeIE6di6lweb+cHFAbNGDcDFiep+yz6l4Qzj0O@vger.kernel.org
X-Gm-Message-State: AOJu0YydZP2HalLFrKOcuUDZ/rohDdX2mUA9N6kLhNWFgwyfCvt1qpZv
	dVkSadbntfFSbUO11jjirdwMSu7I5hm+zgXFFI9efSWlgHc1MxD24cefRJMCGHF7JJDDu8qLWSG
	yLTGDnyTKKvne7dMKAfEsnPK13aLkBmnCLRXgvQRRK2I6NNeBeahc0IULzqg=
X-Gm-Gg: ASbGncvuZHJ3b85TPQgLZb7xr/JLnR7fPCSGFhTMaVUrZKbTGJRBsfCfi+4+80tps8Q
	PX59hK340piAYeMUimFM45sgCy3svnbFxBb7WDpenVdaIbgLdSswmbjUOhTLCpxYfnvYahMNBZU
	KWW9ExtWFLXm52bRVqhTw16wbLXIu9zxPfLxZHYIFxkSyxeV3D1DDg/SXAYmSLzUMiQDpa6asNh
	KSLy5W8n9x7LJsODIf3V5U9xEMhOuxNOSKx8ymI2HIOdQrLPgLdghoM37fujGHsv7pMFD4e2FiF
	vY1kaIGVsP7HqEA8t1uduccfeQ1OEtBhJEw3k88b4PgG/eugtVDxK4Vwpf0msyLlCYAJPJXpxTr
	zNLqotTw7wDokuB+A4ifx1FMziSyUqPjZJKEuwl0=
X-Received: by 2002:a05:6000:2aa:b0:3a3:4bb4:8464 with SMTP id ffacd0b85a97d-3a34bb48467mr2686873f8f.8.1747244063465;
        Wed, 14 May 2025 10:34:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFa3g3LP+U+uSfcYupSsUHt9Zkl25zLjBPUACeKrUZx2gS4O4Cucoe5dqK//Bex5xxb0o9t3g==
X-Received: by 2002:a05:6000:2aa:b0:3a3:4bb4:8464 with SMTP id ffacd0b85a97d-3a34bb48467mr2686856f8f.8.1747244063070;
        Wed, 14 May 2025 10:34:23 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f15:6200:d485:1bcd:d708:f5df? (p200300d82f156200d4851bcdd708f5df.dip0.t-ipconnect.de. [2003:d8:2f15:6200:d485:1bcd:d708:f5df])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f2b02sm20677344f8f.51.2025.05.14.10.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 10:34:22 -0700 (PDT)
Message-ID: <2a46072c-ef97-40a4-9bb4-fe521232dea1@redhat.com>
Date: Wed, 14 May 2025 19:34:21 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] KVM: s390: Use ESCA instead of BSCA at VM init
To: Christoph Schlameuss <schlameuss@linux.ibm.com>, kvm@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
References: <20250514-rm-bsca-v1-0-6c2b065a8680@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250514-rm-bsca-v1-0-6c2b065a8680@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.05.25 18:34, Christoph Schlameuss wrote:
> All modern IBM Z and Linux One machines do offer support for the
> Extended System Control Area (ESCA). The ESCA is available since the
> z114/z196 released in 2010.
> KVM needs to allocate and manage the SCA for guest VMs. Prior to this
> change the SCA was setup as Basic SCA only supporting a maximum of 64
> vCPUs when initializing the VM. With addition of the 65th vCPU the SCA
> was needed to be converted to a ESCA.
> 
> Instead we will now allocate the ESCA directly upon VM creation
> simplifying the code in multiple places as well as completely removing
> the need to convert an existing SCA.
> 
> In cases where the ESCA is not supported (z10 and earlier) the use of
> the SCA entries and with that SIGP interpretation are disabled for VMs.
> This increases the number of exits from the VM in multiprocessor
> scenarios and thus decreases performance.

Trying to remember vsie details ... I recall that for the vsie we never 
cared about the layout, because we simply pin+forward the given block, 
but disable any facility that would try de-referencing the vcpu 
pointers. So we only pin a single page.

pin_blocks() documents: "As we reuse the sca, the vcpu pointers 
contained in it are invalid. We must therefore not enable any facilities 
that access these pointers (e.g. SIGPIF)."


So I assume this change here will not affect (degrade) when being run as 
a nested hypervisor, right?

-- 
Cheers,

David / dhildenb

