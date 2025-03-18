Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A935AF9DA
	for <linux-s390@vger.kernel.org>; Tue, 18 Mar 2025 22:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742336821; cv=none; b=UWXDpPV1iMWCGw+qN9jjdaLF2ztEFh8vRXMNN9MPwSVuD0GlordYP5ihoxK6GmXdapoLJbk3YLGQqZkGSR8O36JQIYC+E7byDmlZPoZ5Gj9u5Wf/nYywXgC4WFCNszHxqmMaFzx/EsJOXR4VtNitGPc7tDRTB2hopnZ0XrXnuxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742336821; c=relaxed/simple;
	bh=EPvTZvQhRHUGCEVFcynstiCefy/8+3K395i7ASRUf9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J9IbjCP79yNOXzSSkgNWWcRHNhieC9krnjoKBDHpzyJy6EIKTbw/9RmzED4kSwCO27KaJWwtSy2s434ejmmQEnJSRiAZBNmqmoA95IGWv88fQKMcTYdOf3m9KWxLtRrKEtbcXc326fxEg4RonPENkkMNxy7qNMSB+dDY87Arrjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FU6yTr7I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FU6yTr7I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742336817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BJVFLhRfFbH1bQJMOV/BNGlUJZXnijES874Ix3jfTjA=;
	b=FU6yTr7IaGzkinO99DrG1LAmzDG8O0LFRuiXC6cXRujBAQSlo7+rmxaSAdt0OyKq7YzyPD
	O0h0pF5yovdyoj2bURqetuwy919WdNSZwfsmj9MBab+LwHiSFqbaKhVAVqJ1FaOPe4sO1M
	OHIJuqC49OuT5/xrwpcaQCySwGgdp4I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-dRF-rZ4XO-CLqL1YfS9QSQ-1; Tue, 18 Mar 2025 18:26:53 -0400
X-MC-Unique: dRF-rZ4XO-CLqL1YfS9QSQ-1
X-Mimecast-MFC-AGG-ID: dRF-rZ4XO-CLqL1YfS9QSQ_1742336813
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-39126c3469fso2801760f8f.3
        for <linux-s390@vger.kernel.org>; Tue, 18 Mar 2025 15:26:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742336813; x=1742941613;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BJVFLhRfFbH1bQJMOV/BNGlUJZXnijES874Ix3jfTjA=;
        b=QRI36kCwnUVox6FNT5iFv8hIMjCkkWnqpPO2nSGZVwSkfqQLzcU3dkyZFnsAyvmZ0C
         /lPxdN/qRJgVnEPFOWkYPGhdCj572y0f2plVO9c75PexV4GZS1eTDtkHr1by/MMg47Jm
         bVZ7QY6aq55rMBMVETG3zJD0Xr/zrPcXH7rR5FYJqFCoE+8pH+jlP9Vc3oexpJmqRmRx
         GnUqnV23wgMT840hu5RQ9t7lCEAIrCc1eTTu7wzItcpK0cvW+OG5w6T2cUedwOWaZZz2
         IMfE7e6myr5yXzA7moA8ngG4fIQAe2NbCdYgpd5OCVPDWOYiXxllde+KeGMMluLWc2g4
         9TOw==
X-Forwarded-Encrypted: i=1; AJvYcCXdYET9/2rx1C4LGV9Tl331K11490aKBcHdR0T/vwrGtL91Q2AsjgPV9spAO10Ffky0G/nOYbUpNLuf@vger.kernel.org
X-Gm-Message-State: AOJu0Yynf7hIIIVbV3RMdf0qSs04OXY9PYsv11tyKhrCYiq3UzROGsDQ
	LztVhB186MCwtZAiQb6YqGn4U6Gew01+x05DuY3yRfeIYetsv7i/AYtQS2ewqg5O0IeR9zhGwJe
	/GZBzTe7nJKIVp/I1o9sn1yoc3W790pWoKQxiIB/j1BlER8uWJzRKBOD3A4A=
X-Gm-Gg: ASbGnctO62YT/pEtqObQHy8+nBkyGIWx/sOq2nShp91y/YypRpjkSsh9DOC6S3gZxs8
	dW4+EkblDreB9t3AtEacnW//UTGTGgKOCix69UD4nL3EhkEP/hGwptQSDr0M47CE9KnsHVYw+XI
	LsNzC+sYcIGR/llWspGMFbjLmsyknciykGgd82Ao+ZnYCwInpYFGZNRciioPRHEqBRnor6XHPLt
	eNQKTw5z+AEk1lNo148riIu+OzLFPHiUnPQMevzI6susa7jHSaLWP//mk1P1qj+X8ddw2usgl4P
	T+crJVyYONTxNIS3CRNSp34BTewBUXJGUXAO/u9JTI5YeklQjD0zcgGceI1vz8U2rs5JxUL3zoc
	AqlRs392/lX4n+a1+lh/j8XprirejoNA2KZ3Rl323/PQ=
X-Received: by 2002:a05:6000:1a8b:b0:391:6fd:bb65 with SMTP id ffacd0b85a97d-399739b4dbamr360369f8f.9.1742336812764;
        Tue, 18 Mar 2025 15:26:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2566PaXJziHXhYt8vU2N7wSpU6jLkXagpjvkPNdNzkOu5eNB/pkYy6bSTupr7UZPs+56uXQ==
X-Received: by 2002:a05:6000:1a8b:b0:391:6fd:bb65 with SMTP id ffacd0b85a97d-399739b4dbamr360359f8f.9.1742336812416;
        Tue, 18 Mar 2025 15:26:52 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72d:2500:94b5:4b7d:ad4a:fd0b? (p200300cbc72d250094b54b7dad4afd0b.dip0.t-ipconnect.de. [2003:cb:c72d:2500:94b5:4b7d:ad4a:fd0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8e43244sm19721471f8f.60.2025.03.18.15.26.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 15:26:52 -0700 (PDT)
Message-ID: <0a2e2784-7b5e-47b9-b7f3-59b0e471640d@redhat.com>
Date: Tue, 18 Mar 2025 23:26:51 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/5] KVM: s390: Add vsie_sigpif detection
To: Christoph Schlameuss <schlameuss@linux.ibm.com>, kvm@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Nico Boehr <nrb@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-s390@vger.kernel.org
References: <20250318-vsieie-v1-0-6461fcef3412@linux.ibm.com>
 <20250318-vsieie-v1-1-6461fcef3412@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250318-vsieie-v1-1-6461fcef3412@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.03.25 19:59, Christoph Schlameuss wrote:
> Add sensing of the VSIE Interpretation Extension Facility as vsie_sigpif
> from SCLP. This facility is introduced with IBM Z gen17.
> 
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

