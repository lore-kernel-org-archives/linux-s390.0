Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A831DF75C
	for <linux-s390@vger.kernel.org>; Fri, 10 Oct 2025 08:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760084172; cv=none; b=ZbSeQETQhAIGV8Q/uJ5UoaFRHrfXocjSJ4JvQLugP9UMx24TKpJpZ9cTWfH0e5b+OtMEAq4Q0v1bonbB0ExThNdZDI8OSdVQ+1sDkuMiV/sBa/MLtPGBJ95f8LPGLR9BuXVdMCmfW1GHz/Ws9PNRzbaFicwj6PMIGOVcO64caQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760084172; c=relaxed/simple;
	bh=vPKkKHc48R6/RxvDyxYqF/rX1UF1oM5B2FC5RFznEbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EWYb8SMBavOvAV97cln7r77nC7naqNTgfxxiVncuX6PhSwWS65MuDi3QGhQYVi8RX/DBuAGXW77GTQM2P+VrD7o+ggim0jWIguEXTHrjMWfitE4yYjlVjFqm/ppS9cHqzH3186ScguUKSoDYLPcGtNyXOsy40J0NJX7uH2osIHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QoADCFkS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QoADCFkS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760084169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=53xZ5SArHYuTCDROMaQ5xZHxK4BghnPi+QrjXe7ILDQ=;
	b=QoADCFkSUrhAWQA64KbHSEUCDTGrqj4FpPdckgpg9jVPeukIVlyTQb6rp7Fi2ox/sH4luF
	yhZzPjH3yjijZungA38Eag/hhMoyHEJCqm2sYYoLNQh2gP/klcCCGSaMV8Bb6woiGqJgkB
	0piX9jmK7d7MZEo40Khktp2nGGhYecQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-Mv1S9uvLPAmJvMnd3QzbdA-1; Fri, 10 Oct 2025 04:16:08 -0400
X-MC-Unique: Mv1S9uvLPAmJvMnd3QzbdA-1
X-Mimecast-MFC-AGG-ID: Mv1S9uvLPAmJvMnd3QzbdA_1760084167
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ee888281c3so2113842f8f.3
        for <linux-s390@vger.kernel.org>; Fri, 10 Oct 2025 01:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760084167; x=1760688967;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=53xZ5SArHYuTCDROMaQ5xZHxK4BghnPi+QrjXe7ILDQ=;
        b=ruoivW/e6sM/ELaqh9RVNLEyKES2P/5HGusWfikZFgm/lQ+LJixur0FoHj4saTRx9v
         L4lLhhlw2uvqJmuzuuzwIcS3zST+o8fNb+zXU8TqHoJJndK1yCZ5rEdanTfOxHAwG8Kz
         gwrSdpz9PMbI7OG9AQ67U/5SXMTQlV2+7ImWXhJREKgJ9+3CkpuVGRhtNzG9CEM1Tq9Y
         MDCDZH82OVu4pntDm9M0JMx0bVy4WIEkQRlswQlHyni02gnt05LCtb1jdAAyrEyLmTPl
         p6Rr7XpCmX9inXd+BXyrdN850TtYLeGz1bPgNn87VRaQLSWNnLiUV5D5Fz5s831GX/nJ
         V5ow==
X-Forwarded-Encrypted: i=1; AJvYcCW5n9faoczFgbaYRexQ1v0H31cr+XfLsG4E1o7RBno0jkNYGaL6fz4I+gbMC1x4Jek2ufbjRPPT51FO@vger.kernel.org
X-Gm-Message-State: AOJu0YzUSQ7XPNKxenmoXI5LstFVrrByel/g4T1+gJUOBemkyh0Uhdg9
	sZEKQ1iAZEbO77pdooVAdbCfv4e/SnPjIGwNetvOWb2TchKcvQOae+4alXk9Bsv4xLlUQsOLKS5
	hKHokhNnqLiNr71rEB209E2q3iCYjiSQWYSiMlkh6rE3ICCvorlfbJtHZ410rkAY=
X-Gm-Gg: ASbGncs0Xu8XpPzPsPNl8VAkmkCg8wQ0UNq3pMlqjxXmFw5lrt3/JU4v8D89Ds04ljW
	WHeJuEKyM/xJGALugUoG8sdU8+daW+FMEnrccawUplpegLZx1263X0HGBO0aqS69iFnk0v2mnep
	boleUxKXDfVtzJkp0fqEEWqfuSe2u930KQW+oiFjgb66CGqmP05mkCDIUuEc4f3mOCXzM3cgQuY
	cech3+PD3u6JEPeZq0mrpi77LkPW8CzZsbhVjAKxqRd8Z8W3oRHTnxIQtadjSGGDZpodk1C8CjF
	/W2tfVoJLhspr540hm6sf8MmH8YwnvUpgHXkuSiUN2L/tZpVmWE9DHinJRZA3B8UFTZduPSq7EE
	eUqo=
X-Received: by 2002:a05:6000:2001:b0:3ec:ce37:3a6d with SMTP id ffacd0b85a97d-4266e8d8edfmr7245542f8f.47.1760084167068;
        Fri, 10 Oct 2025 01:16:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZ368MGuvWw1VsKC/pQLX3ZFh6T+mRMjmDTV41EqO6zVdB5WKORFNY6kUvdlLjMLs3z4adWg==
X-Received: by 2002:a05:6000:2001:b0:3ec:ce37:3a6d with SMTP id ffacd0b85a97d-4266e8d8edfmr7245519f8f.47.1760084166637;
        Fri, 10 Oct 2025 01:16:06 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e83e1sm2959842f8f.51.2025.10.10.01.16.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 01:16:06 -0700 (PDT)
Message-ID: <08baaace-3141-4ef0-869e-c80e216c55ca@redhat.com>
Date: Fri, 10 Oct 2025 10:16:04 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] s390/sclp: Add support for dynamic
 (de)configuration of memory
To: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-s390
 <linux-s390@vger.kernel.org>, Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>
References: <20251009131839.3739108-1-sumanthk@linux.ibm.com>
 <20251009131839.3739108-3-sumanthk@linux.ibm.com>
 <ed7db8b9-e828-420d-a8b2-3e1b8aa8c95c@redhat.com>
 <aOi_PL68QaY2YIAg@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aOi_PL68QaY2YIAg@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.10.25 10:09, Sumanth Korikkar wrote:
>>> +struct sclp_mem {
>>> +	struct kobject kobj;
>>> +	unsigned int id;
>>> +	unsigned int memmap_on_memory;
>>> +	unsigned int config;
>>> +};
>>> +
>>> +struct sclp_mem_arg {
>>> +	struct sclp_mem *sclp_mems;
>>> +	struct kset *kset;
>>> +};
>>
>> Just one thought: if you keep either as global variable you wouldn't need
>> this. (I would just keep both as globals, but whatever you prefer)
>>
>> Whatever you prefer.
> 

Feel free to add my

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb

