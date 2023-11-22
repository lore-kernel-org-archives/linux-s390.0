Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IEMHDN0w"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A8DD8
	for <linux-s390@vger.kernel.org>; Wed, 22 Nov 2023 05:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700658570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AoK+zNaD6wE6lLzvjHrHS06wHZVWVDTptmMD3Gqkmd4=;
	b=IEMHDN0wE9540w4EE5zrDtIcaPbq8lykvGj1AVLpCMGGSozfxZevLtSJBzttytRQc9YcPQ
	y1RVBByptyJpoK/Cm1G+RPObgD6l8F2hRSEPfC+mwc1HaH5L6Y61k7O9HfaWgoFlR1/W3z
	niY+0Y6s+UB5+OHtc+epbspqf5KEn70=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-Xpk_oYC6MbObHL8YGglELg-1; Wed, 22 Nov 2023 08:09:29 -0500
X-MC-Unique: Xpk_oYC6MbObHL8YGglELg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-77bc720da87so853702885a.1
        for <linux-s390@vger.kernel.org>; Wed, 22 Nov 2023 05:09:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700658569; x=1701263369;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AoK+zNaD6wE6lLzvjHrHS06wHZVWVDTptmMD3Gqkmd4=;
        b=gX7MWCGEAqvpUd0M1vZV28ZASm00h/Ewe8TmWqnOtpIOOMdBeI3RQMmtgQnbBO74HM
         3DiaZKvsqrbK05PAVdGg+wUVHu4rZgsSA5iUL5SBss8RKy4oDAEK8sqxWDiVjIy7IqbZ
         l0fr/kJPwCihCy0pF4k6Dw3uKUKrLgo7FeHqchjxj5EvZQ8J9NtdWA2XPkZg9F03QYSZ
         J3eTKFLG1P+9CHWj4U9j/3UGz+kdOS132B1kX1nZ1MZpcDaUBxPqZLXZ7nRFnPUkIdv2
         +7/IX1M0hdozaO8FPa1XbsBIr+rbZwPjjcD6v6JnBVurkCrXhiINDLDNkIHFst/qynye
         uliw==
X-Gm-Message-State: AOJu0Yz2GBYV87UPxT+lxHGW1DFH8DsgizngZAuTDpuq8b23Zd+OolNy
	GxGicjb0m3YkGYVX6Tbx88+ej56qohAwE48OTaZESsDGIdM6INaQJqVFCy0VFRCEaiQ/V98VDch
	SfMW+x3IWIgcn5bDvt9rJvg==
X-Received: by 2002:a05:620a:271b:b0:77d:4b61:5549 with SMTP id b27-20020a05620a271b00b0077d4b615549mr2193702qkp.76.1700658569128;
        Wed, 22 Nov 2023 05:09:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEqnT2qkfz41BF69quGQSj2Y1r9WgS6K5zCs7raz4/FlMp7SCloEgkOqFJR6WoKt6p9GbL+Q==
X-Received: by 2002:a05:620a:271b:b0:77d:4b61:5549 with SMTP id b27-20020a05620a271b00b0077d4b615549mr2193678qkp.76.1700658568865;
        Wed, 22 Nov 2023 05:09:28 -0800 (PST)
Received: from [192.168.0.6] (ip-109-43-176-233.web.vodafone.de. [109.43.176.233])
        by smtp.gmail.com with ESMTPSA id w19-20020a05620a445300b0077891d2d12dsm4398716qkp.43.2023.11.22.05.09.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 05:09:28 -0800 (PST)
Message-ID: <9a0b366f-9bb2-43da-b5e9-da5829506364@redhat.com>
Date: Wed, 22 Nov 2023 14:09:25 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v1 00/10] RFC: Add clang-format and
 kerneldoc check
Content-Language: en-US
To: Nico Boehr <nrb@linux.ibm.com>, frankja@linux.ibm.com,
 imbrenda@linux.ibm.com, david@redhat.com, pbonzini@redhat.com,
 andrew.jones@linux.dev, lvivier@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org
References: <20231106125352.859992-1-nrb@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20231106125352.859992-1-nrb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/11/2023 13.50, Nico Boehr wrote:
> It is important that we have a consistent formatting of our source code and
> comments in kvm-unit-tests.
> 
> Yet, it's not always easy since tiny formatting mistakes are hard to spot
> for reviewers. Respinning patches because of these issues can also be
> frustrating for contributors.
> 
> This series is a RFC suggestion on how the situation could be improved
> for kvm-unit-tests.
> 
> It adds a clang-format file, mostly based on the one already present in the
> kernel. A new "make format" target makes it easy to properly format the
> source. If maintainers want, they could even re-format the source code of
> ther arch to ensure a consistent code formatting, but this is entirely
> optional. I am also happy to move the "make format" into arch-specific code
> if requested.
> 
> Additionally, I noticed that there is quite inconsistent use of kernel-doc
> comments in the code. Add a respective check command and fix the existing
> issues.

I think the kerneldoc patches are good to go, so I went ahead and pushed 
them to the repo now.

For the s390x beautification patches (patch 07 and 08), it would be good to 
get some other reviews first ... Claudio? Janosch?

  Thomas

