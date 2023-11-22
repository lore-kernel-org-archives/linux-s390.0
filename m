Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pg10GX2M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5860ED5C
	for <linux-s390@vger.kernel.org>; Wed, 22 Nov 2023 04:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700656094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Pp2Gl0KW/Z+RCwOCfi+t86YZ332edwSLaDVYN3g/iXw=;
	b=Pg10GX2MQkxvtevPotscnisOzUilPewWxfSZK2jFB1tY9e7dNTD42JxGShPYruh3qAca3e
	gYtczdr+wGiMCkZenuMedo8pzEfZwoqGMxa6bFU0F81csIhv/tXbW9eAeiUzkAf7ie3UYx
	9xFuQdOd7EM9LQdjblrUW5CobexDL7Y=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-rqgnLuxdODSS9518AQmAVw-1; Wed, 22 Nov 2023 07:28:12 -0500
X-MC-Unique: rqgnLuxdODSS9518AQmAVw-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-421b20c9893so92649111cf.0
        for <linux-s390@vger.kernel.org>; Wed, 22 Nov 2023 04:28:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700656092; x=1701260892;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pp2Gl0KW/Z+RCwOCfi+t86YZ332edwSLaDVYN3g/iXw=;
        b=AW63wmZEJkj/GBX9uuZA8pJtPUoSeN1Wcu5uQRK13YItwzgCtj9AdnHKETCVBBwlha
         AYz98SUWB4WepmXTzlILQHD8EUxOA9ilX6tHjiYsgZRXGt0hNLBs13x0sQD1hoWBomxA
         GVBUsLD9uy6DQP6RcC35FRAqnCH8DkP46CLO+FAV18Rie+iEL4yjZzycAGhNmr6KsyLC
         XGUExZVaN0Ek+6l6Aslg1UjzTXVkhjeWkwGWDB0o5CKGE+ARjGJ71Y7g7HAzO0Y+zpPu
         f//v40enVNTPBthQcOuA/RHhYMUvdV+1ElN90MX3Wew7oW8QVjeSE5usfoOLp1cNGWpb
         a18w==
X-Gm-Message-State: AOJu0YzigbXCxvsh5OOe2Tusn/1z6FWZuZ1sAxV4eLqbSK1mM2nlk4RZ
	EzpC9yoGyH3/ZdZanEggQoezpxnBk04T1v64LKOIKz/ODSQfl0xkTeiJnpovez6b2psauopGS3F
	B2sxrkguxS11bTJ1mJJgpCw==
X-Received: by 2002:a05:622a:182:b0:417:d1e7:5e9b with SMTP id s2-20020a05622a018200b00417d1e75e9bmr2519177qtw.26.1700656092300;
        Wed, 22 Nov 2023 04:28:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkWZVlwxpwbltKov8aew6gvbeG9Z+bN1qxoZu1nP6o4i5VCj8FFaTMnyX9iSu0lnbCDqaZqg==
X-Received: by 2002:a05:622a:182:b0:417:d1e7:5e9b with SMTP id s2-20020a05622a018200b00417d1e75e9bmr2519165qtw.26.1700656092090;
        Wed, 22 Nov 2023 04:28:12 -0800 (PST)
Received: from [192.168.0.6] (ip-109-43-176-233.web.vodafone.de. [109.43.176.233])
        by smtp.gmail.com with ESMTPSA id j1-20020ac874c1000000b0041eef6cacf4sm4384258qtr.81.2023.11.22.04.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 04:28:11 -0800 (PST)
Message-ID: <faea955a-5ef3-42ac-b39a-6e074dd296f4@redhat.com>
Date: Wed, 22 Nov 2023 13:28:09 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v1 02/10] powerpc: properly format
 non-kernel-doc comments
Content-Language: en-US
To: Nico Boehr <nrb@linux.ibm.com>, frankja@linux.ibm.com,
 imbrenda@linux.ibm.com, david@redhat.com, pbonzini@redhat.com,
 andrew.jones@linux.dev, lvivier@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org
References: <20231106125352.859992-1-nrb@linux.ibm.com>
 <20231106125352.859992-3-nrb@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20231106125352.859992-3-nrb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/11/2023 13.50, Nico Boehr wrote:
> These comments do not follow the kernel-doc style, hence they should not
> start with /**.
> 
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> ---
>   powerpc/emulator.c    | 2 +-
>   powerpc/spapr_hcall.c | 6 +++---
>   powerpc/spapr_vpa.c   | 4 ++--
>   3 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


