Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="URgiJM1t"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB026D71
	for <linux-s390@vger.kernel.org>; Wed, 22 Nov 2023 04:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700656075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kmeuOzatoB1VqjaoCkk5gWbxDgJvHLvoGt5Dq0KUC0Y=;
	b=URgiJM1t/v3ai9lB+Utp1rcXBm1bZGkWgEM7Zcjr1IfbN+M3LTPg/zyQLma/lCvpf5LLIl
	in/qHb2fj9y/aCCOLe9M9khn4kiJV6yn4w3dahUUCJG3CUi8ViURBq4CnH4bqUFfJ+8e0y
	ggmcu/QgBITr3jpc14YwhBjXIbrrmvQ=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-Dwbstd_bNfqdjCaVK_sBOg-1; Wed, 22 Nov 2023 07:27:53 -0500
X-MC-Unique: Dwbstd_bNfqdjCaVK_sBOg-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-58a1131ef74so7859872eaf.2
        for <linux-s390@vger.kernel.org>; Wed, 22 Nov 2023 04:27:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700656073; x=1701260873;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kmeuOzatoB1VqjaoCkk5gWbxDgJvHLvoGt5Dq0KUC0Y=;
        b=YuoY5/eavOywSpoU1b7vjzmmuQJLTRPdfm0rei3qiMa9aNla0Om/EeXOc6idyTceoM
         0e3kpo6DjxBnABW5jBRifFLsbk8IFbjlURkkQMz14qtmJ8MIILbqJleFWNIR1GEkIpU0
         blz0lgnLbZiWccLKgz/c86/ISiIuiCDAKAGln7NxOqdmzJl2EKJK528Uk31hfXmtMlDD
         f9qVYE6fmTLBEa5yKAYqBS0dIcrxL7XWgOifTRy/KeN1qMtRDTQXCRTLF2tJED4dZuug
         lHbhhSXsJFDGn2jnZwF9ty1rknJoQXd8eCDCsybuBziJT440lPfv2oGIwgZSbiMRzzO/
         q7bQ==
X-Gm-Message-State: AOJu0YxLfTK/t66HGvQSOvN+g8vLbPrtKTIJQDbwye7KlYIqkk5GbUeQ
	2ppy3PIg2451Y4D6Hu1y7O8kJi1VRzSMpa5vUHEwfSspglh6d9tSRmx/rlP+7mAqPUGGwKnwM/f
	mTMeoCyKo5Cm0BVam1s+kEVJvR/Ytuw==
X-Received: by 2002:a05:6358:e4a4:b0:168:e26c:e91 with SMTP id by36-20020a056358e4a400b00168e26c0e91mr1667627rwb.20.1700656072963;
        Wed, 22 Nov 2023 04:27:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcFakwmqelUwIBZ1frDhXsoJ5VQce3Al66w5TP0n7saU167RvBMhcY6Q2eMA3qnC87hhoOTA==
X-Received: by 2002:a05:6358:e4a4:b0:168:e26c:e91 with SMTP id by36-20020a056358e4a400b00168e26c0e91mr1667616rwb.20.1700656072690;
        Wed, 22 Nov 2023 04:27:52 -0800 (PST)
Received: from [192.168.0.6] (ip-109-43-176-233.web.vodafone.de. [109.43.176.233])
        by smtp.gmail.com with ESMTPSA id j1-20020ac874c1000000b0041eef6cacf4sm4384258qtr.81.2023.11.22.04.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 04:27:52 -0800 (PST)
Message-ID: <7e0e662f-7980-4986-9524-2853a0cf075d@redhat.com>
Date: Wed, 22 Nov 2023 13:27:49 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v1 01/10] make: add target to check
 kernel-doc comments
Content-Language: en-US
To: Nico Boehr <nrb@linux.ibm.com>, frankja@linux.ibm.com,
 imbrenda@linux.ibm.com, david@redhat.com, pbonzini@redhat.com,
 andrew.jones@linux.dev, lvivier@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org
References: <20231106125352.859992-1-nrb@linux.ibm.com>
 <20231106125352.859992-2-nrb@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20231106125352.859992-2-nrb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/11/2023 13.50, Nico Boehr wrote:
> When we have a kernel-doc comment, it should be properly formatted.
> Since this is a task that can be easily automated, add a new target
> which checks all comments for proper kernel-doc formatting.
> 
> The kernel-doc script is copied as-is from the Linux kernel.
> 
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> ---
>   Makefile           |    3 +
>   scripts/kernel-doc | 2526 ++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 2529 insertions(+)
>   create mode 100755 scripts/kernel-doc

Reviewed-by: Thomas Huth <thuth@redhat.com>

