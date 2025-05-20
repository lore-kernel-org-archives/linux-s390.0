Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94B8BE49
	for <linux-s390@vger.kernel.org>; Tue, 20 May 2025 05:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747719790; cv=none; b=dbIcpPCMa7qsrQ0rgCsXWU25tomG+peNaFQupuySG/eeBaPwT1KL3hUV6wzG8Zk1zveh9oOV4l4Q+gQCIiY7cd1d9pegSH9wdUu5omyUI3NU5dY41vX9bCx74Z35fUSdGEwekmnd0iauJN8u7D0D4OKTYvJWS3K/ZxU8hyXqFXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747719790; c=relaxed/simple;
	bh=wGLA9UW3i8e2fUmOovywO53VpSW0/b5aC1FAzfOEWiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a2eR9NEqL6hJBQ7/wzdRCFRcgotHMHx0cokqrpP4k8KTmxV60PrI/KfzoGh6CFH+sZrCLo+hYK0jAn0UHVQ7CpQTOMH3CMu+sUN/H8jkyC5EU8RKcnP/HIVRyPtXlcpXgLDDblh9egxLg86pVZB/dWAA7zTYqFKOQEznh3YPnmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bxCATRYk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bxCATRYk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747719787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IXgKREbXw8JOX7wRebCRg043QolDwSg2zAUdVPK1KQ0=;
	b=bxCATRYkGbTgWv+V2rUsQIAuZhQOkOPdCUZLTMsbQ594so9cAVdPXSutbUXo7AfSMjeUvf
	3+w+/8tUAVrt6eJfwNf/n7T7GBOWVeS+gSx4uuPYTgz9CRjMAVSU48MuIA6OWE4YSvCS9U
	M4yDIilRfq0mPetBTMf7sIlON11QZ8Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-tK8-94peNF-UOVRZXwZe_g-1; Tue, 20 May 2025 01:43:06 -0400
X-MC-Unique: tK8-94peNF-UOVRZXwZe_g-1
X-Mimecast-MFC-AGG-ID: tK8-94peNF-UOVRZXwZe_g_1747719785
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cf172ffe1so39292915e9.3
        for <linux-s390@vger.kernel.org>; Mon, 19 May 2025 22:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747719785; x=1748324585;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IXgKREbXw8JOX7wRebCRg043QolDwSg2zAUdVPK1KQ0=;
        b=fSYnxglcEpm5U8gGwT32DfcmCR8FP82ReKqxQYSAlS4U+Y1r0WZCwAExZld+Nqutum
         XidgUW5Tvo+1LCn30Mr37QXt25Qyw85aK12XF7F/MTWM1xgF3POwGJ9ERSw1HZItkIz+
         /I4Je2s7i0/jXDsKFlgGmtpwJKv4yl3UxfFgYdhYfEb+W/KfiUqn6FwsDC+aUJIWANYE
         CbV7q4KetVMZW8vdtaRWLmozq16+3ZpP+SHc78+E5KnynHr+JRl2itYbjkOEMMRgHnSI
         UOhbLhoKof5GlGsx3FvPvuYVjO9FCkQ26wKHr2Xl3XWwt36SAwFS6hsEZ4ot/NCXVRv5
         dENg==
X-Gm-Message-State: AOJu0Yz1LlYxcYkTtuOfpdyeKH/BXSbYnV0/4R23EK2QwQyuHJ0ezbJ6
	EWKA8xCXEBQr1bZTC8LVDxTuDNDsold+8bmlS9OKxrN7zK8fIsvAZ+Uz4dd5SffTCIyTPIjSEIr
	wd9tnWoAJEJUWC9JDe6yfNAkKHlTGYpKgLw47aR4allD+l8YztuzyUnBWfCPUp5o=
X-Gm-Gg: ASbGnctSJa8PvOhuwz6+wtyrg7gaFAJ6hN6TXLu0285Qxhyn5aZqOhSYbXAYnHSYfKP
	6ubaw8H/SUw4uBcl691XLnMEIrDh8H7S8G1Efyb1rmbrN0JcRDF727dxOIf1X6Hnd25KiD7OSvk
	NBmMZPPWg0pHfdxcYKQbXdSFRSETTLt4xClPK6e01o1p8+GqVDMpjr+oOLGuWc4EtvM6Z3z4aJr
	K20aN3140l8GV4csj/R4mRkgWMqVXkYRCCOnGEIIrDaUI0WEeeOWpuwH+CSNh1WHb+1/Kkc31gb
	zqGm5begwXs1ljX3Ktfn6ga7ANYFEu5DtLQroup0J9E=
X-Received: by 2002:a05:600c:548e:b0:442:cd03:3e2 with SMTP id 5b1f17b1804b1-442fefd77a2mr146509175e9.2.1747719784958;
        Mon, 19 May 2025 22:43:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHd8GGWSj0p7IGH/FLOhkyp6Q8E4hyCeidUKsb74iDDbO1SfEAhR2sP0lZfWY9LlxVamb9kDQ==
X-Received: by 2002:a05:600c:548e:b0:442:cd03:3e2 with SMTP id 5b1f17b1804b1-442fefd77a2mr146509055e9.2.1747719784641;
        Mon, 19 May 2025 22:43:04 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-201.web.vodafone.de. [109.42.49.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f1825193sm16679705e9.5.2025.05.19.22.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 22:43:04 -0700 (PDT)
Message-ID: <afdc34e0-2dbe-4c5c-ac59-61530c45827d@redhat.com>
Date: Tue, 20 May 2025 07:43:02 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] KVM: s390: Specify kvm->arch.sca as esca_block
To: Christoph Schlameuss <schlameuss@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>
References: <20250519-rm-bsca-v2-0-e3ea53dd0394@linux.ibm.com>
 <20250519-rm-bsca-v2-3-e3ea53dd0394@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250519-rm-bsca-v2-3-e3ea53dd0394@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/05/2025 13.36, Christoph Schlameuss wrote:
> We are no longer referencing a bsca_block in kvm->arch.sca. This will
> always be esca_block instead.
> By specifying the type of the sca as esca_block we can simplify access
> to the sca and get rid of some helpers while making the code clearer.
> 
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> ---
>   arch/s390/include/asm/kvm_host.h |  4 ++--
>   arch/s390/kvm/gaccess.c          | 10 +++++-----
>   arch/s390/kvm/kvm-s390.c         |  4 ++--
>   arch/s390/kvm/kvm-s390.h         |  7 -------
>   4 files changed, 9 insertions(+), 16 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>

