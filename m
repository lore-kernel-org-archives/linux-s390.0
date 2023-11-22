Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f5NZzk70"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A851A8
	for <linux-s390@vger.kernel.org>; Wed, 22 Nov 2023 04:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700657374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eLnO7RKe/dgR2RJiPGezTaNLqYA/hbIF0TWqF/UBAZM=;
	b=f5NZzk703gmQ6z6UWZ920oT2Onej9umK7QFGYaPt9tru4Iu+H3ojnCVo3tp+JklI6+NxKm
	gStqANAY2gpSA1TlxjsqKgu8Wed7KkQRQy82f1vSYmvqgTlyAYDSn8LFDiV6LLmSnx1Vr+
	8AVch7TvqEuHNSN+t3ydwWxHYTWNWlY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-qo9gvEpkP-OPsZwQtluikQ-1; Wed, 22 Nov 2023 07:49:33 -0500
X-MC-Unique: qo9gvEpkP-OPsZwQtluikQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-778ac2308e6so982693385a.3
        for <linux-s390@vger.kernel.org>; Wed, 22 Nov 2023 04:49:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700657373; x=1701262173;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eLnO7RKe/dgR2RJiPGezTaNLqYA/hbIF0TWqF/UBAZM=;
        b=Tj7Zq3II0ftTxVjgwMvPtuqexU4q0XybQEQsor7Ze7lTXTSzIJXgXoYbS+v3YApNt1
         +Xy6oXXYejP9L4iVAyClWJkiHb65FpogIkybm2Hw1Fbx49bw1jK6VXWJ0QMr9PsGice0
         +ruW/Pdz08LteO0DSLTvVf1Dt/MEGc/h6DgR7qsOdWis/pAK2yjhifmsCSai719edZ3I
         q4Y4raebiHQGW3M8C5nFG38Ghafq7HiuRNQ9NgfnSw3z3GqcINcCOObpS83XJ+0qdgBT
         HTI5kNwcCLE4BkJRl8/tzI3XgowNpyGQJtVtkbSO1peNjOGRgK4Ge1kxCBj2kgQwFKk6
         ZaXA==
X-Gm-Message-State: AOJu0Yw25MiFj0j2AREG07IYqlMC0lW620QB7GsVX6r/+BDLoUSVYuju
	SwH7W94dffdcQiTFqj2hF4z+FlVK5ysgXMcMj5dkY+BFI6xyxJ9P8AbhLs/8a26m3pT3N1l1Ve4
	aVg+hZ1XzjuL5jA0srmwBPQ==
X-Received: by 2002:a05:620a:1909:b0:778:9341:6707 with SMTP id bj9-20020a05620a190900b0077893416707mr2449300qkb.22.1700657373125;
        Wed, 22 Nov 2023 04:49:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFqE9WUUVjzKnUDoYW1tbJtHkXEYrka+T+dUeGyXw/Hp+3dl1QOtcseNDkcc/8svMM//ShLBg==
X-Received: by 2002:a05:620a:1909:b0:778:9341:6707 with SMTP id bj9-20020a05620a190900b0077893416707mr2449289qkb.22.1700657372922;
        Wed, 22 Nov 2023 04:49:32 -0800 (PST)
Received: from [192.168.0.6] (ip-109-43-176-233.web.vodafone.de. [109.43.176.233])
        by smtp.gmail.com with ESMTPSA id v3-20020ae9e303000000b0076ceb5eb309sm4380010qkf.74.2023.11.22.04.49.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 04:49:32 -0800 (PST)
Message-ID: <55ec5b50-50fa-4fed-b9b7-095c86436c08@redhat.com>
Date: Wed, 22 Nov 2023 13:49:31 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v1 06/10] x86: properly format
 non-kernel-doc comments
Content-Language: en-US
To: Nico Boehr <nrb@linux.ibm.com>, frankja@linux.ibm.com,
 imbrenda@linux.ibm.com, david@redhat.com, pbonzini@redhat.com,
 andrew.jones@linux.dev, lvivier@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org
References: <20231106125352.859992-1-nrb@linux.ibm.com>
 <20231106125352.859992-7-nrb@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20231106125352.859992-7-nrb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/11/2023 13.51, Nico Boehr wrote:
> These comments do not follow the kernel-doc style, hence they should not
> start with /**.
> 
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> ---
>   x86/msr.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/x86/msr.c b/x86/msr.c
> index 789f23f8de78..3a041fab160a 100644
> --- a/x86/msr.c
> +++ b/x86/msr.c
> @@ -6,7 +6,7 @@
>   #include "msr.h"
>   #include <stdlib.h>
>   
> -/**
> +/*
>    * This test allows two modes:
>    * 1. Default: the `msr_info' array contains the default test configurations
>    * 2. Custom: by providing command line arguments it is possible to test any MSR and value

Reviewed-by: Thomas Huth <thuth@redhat.com>

