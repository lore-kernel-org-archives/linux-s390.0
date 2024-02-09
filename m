Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB5374E33
	for <linux-s390@vger.kernel.org>; Fri,  9 Feb 2024 15:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707493490; cv=none; b=Uyh/YiUKo34wWpmVPnE3bodlVCPsXEsYd5BpdGQ+Qjt9RZmFEJsVljp4IQwhpkOcaSgntLnE9lU3EzXaclifBK8ZYlusAwOHIeE4b5zCOAIl3z9MkDu0QITsI0sCpNTOqAyXDzAa6NcHGfpjBkfy4btYqCA2JIE73cCqR9SCFds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707493490; c=relaxed/simple;
	bh=493cPVUswAD3A0KMwCRMuPp+OjiGkOhA+MISAXYoWFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d8V+r6aFQ2oK1sl2YmlXST2XgFU4WneG+ieiJTlLtkgnR0hq5bXKfPwbDB19PgAyyD7ma3nU3z3yBXY/UsF1Kqafqv+RgU97JHdggE1VED+0pt8OCj57gvM6503Omi/qcC95480cEIMu8WITrek5XvKRTJEMom+mwrgwKyNoQvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WNlaf5Km; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WNlaf5Km"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707493487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ediGnj2ZBdloK8ZzNwd0EGtkRfdSZ9P+sTwiRFCXJZQ=;
	b=WNlaf5KmsX/8xSclxstNvjHve7yNGNNtEsToQFNefHNcAM+0oUJUJSkCtQV0WYdqdpUm6Q
	4G1rhdBky0LF/P0MyplxCaEw8IRBR20l23Rwg3dp/KPXElBfKYXwBZOfqf6ziG/pK99t4p
	U3tDIRRZZxS8iMgaT5Bg8vLAXqhGIWw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-0CzMbznOMP--icqB2S7HEw-1; Fri, 09 Feb 2024 10:44:45 -0500
X-MC-Unique: 0CzMbznOMP--icqB2S7HEw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-68c80caa6ccso13640546d6.0
        for <linux-s390@vger.kernel.org>; Fri, 09 Feb 2024 07:44:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707493484; x=1708098284;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ediGnj2ZBdloK8ZzNwd0EGtkRfdSZ9P+sTwiRFCXJZQ=;
        b=DTRa+KNVqQu/AgYTR7STkCxe1oSF9iZnrysrorEX5yKi+Ix1gVVgnG3bO8Ns1Ob70D
         0qVZbEUw9/a+y4hNkXwYA+7KMkhEFWW0MosVQE5sXkpm9UdX2VrJuTz6N1zMzF5tL5Ve
         fiUlJ56b10SXDj3Op9EVapNxW9qOVutdPErsR3KtfjNKvf15xbLRbAnCiOqu3Cktv/IZ
         XRhuAK7UO2ir2Vi9mJ9pZ3M/WAEGuIohR0jIdJRedSQQ/F2osJVIcznynGVsNZOKZExE
         1ClUMdymenLFOcJgPEid0dUl3BMTkApxj6vL9MSTzx08xk8HKx/RbqwJt8aG8Ih+2Mkg
         Ma3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUuumue3zp54U5yqiFCa1pykJ59uYmPZnb9bi3MwozLvt6dwrE7A7jKNEr4Nm3PpA/gyTfzz6sqoitra6l7QLbJj+rmoIro+SM/Qw==
X-Gm-Message-State: AOJu0YypczbUQkfSxKvons7SldLKawVyJyCWu67ZiBmlTCRGI8rRAe8s
	2s2Rjb3GIGLY4bMDGEu1vl5ZqGrUtCYZz6QLU0OZWY8SnKld8Lu0XhyHeJLzSTwbxXK8fYjGJmu
	gtWEafx1+7jHAfwFXffwNRpcN4+bmmvEtVLCTv+yj3HYyqxfEeo8K7Vc6Asw=
X-Received: by 2002:a0c:f385:0:b0:68c:aa0e:95bc with SMTP id i5-20020a0cf385000000b0068caa0e95bcmr1591376qvk.45.1707493484676;
        Fri, 09 Feb 2024 07:44:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFg79+jcqpSwgnkDkg3V3d9JlqrGMAswNmZvWa9SxjPcRC0irrIkrkKB3kwbNK/19LlwrDing==
X-Received: by 2002:a0c:f385:0:b0:68c:aa0e:95bc with SMTP id i5-20020a0cf385000000b0068caa0e95bcmr1591353qvk.45.1707493484381;
        Fri, 09 Feb 2024 07:44:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXuNVdoX7LMFIKQAl/CiHbhwLn1hHYUATMz6lAXi7+QGrIXlB1BwD+w5eewfZJO9nemOMZKrVNX36XyPcwklIxo3Gr4SSR/hxDKaep3r1M7OH19vayuA5hstJDU6PF6u1AYeixG7ja//l1ynR1t0CkwJlUboR8kg/qzns4OKkZOz2RbIg+fHxp7LGjCC+++A+LJym6m3PEqtXDrcuumZW0q9PqoLkgrLvm1DG/xELEPYcu+qKluqgaxIblU6gOhQLjPJt2v4VJwL6EdRpehFSUHuCjPkepEbKsfY8BYqDnSazzmivrHd3bpmtUMNXSFY4tOU3DiVF8RFpHT5EGa9iEfzj1exwaGg7Vk23lQXm9VY4lWEPGrzkX23lZZWo8BR6uTQpD9Tig2O/8OCsTKGhEuG4gb/0hAsjK32+zwwJ0YRBPbXPKBqPWwyQgb+L2nijZYCsMFD2gpl2fiM5YwrLoFyBDxvHnrHNHKaOPYBcHlrkHUml21O9U+Rr9qrpp1q2QHsPes6lmXqOGABSjcyYzli+MN
Received: from [192.168.0.9] (ip-109-43-177-145.web.vodafone.de. [109.43.177.145])
        by smtp.gmail.com with ESMTPSA id r4-20020a0cf804000000b0068c7664112bsm932002qvn.52.2024.02.09.07.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 07:44:44 -0800 (PST)
Message-ID: <05d86794-0c1e-4395-bcde-15177469e1c4@redhat.com>
Date: Fri, 9 Feb 2024 16:44:38 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v4 2/8] arch-run: Clean up initrd cleanup
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>
Cc: kvm@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
 Shaoqin Huang <shahuang@redhat.com>, Andrew Jones <andrew.jones@linux.dev>,
 Nico Boehr <nrb@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Eric Auger <eric.auger@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Marc Hartmayer
 <mhartmay@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, kvmarm@lists.linux.dev,
 kvm-riscv@lists.infradead.org
References: <20240209091134.600228-1-npiggin@gmail.com>
 <20240209091134.600228-3-npiggin@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240209091134.600228-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/02/2024 10.11, Nicholas Piggin wrote:
> Rather than put a big script into the trap handler, have it call
> a function.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   scripts/arch-run.bash | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/arch-run.bash b/scripts/arch-run.bash
> index 11d47a85..c1dd67ab 100644
> --- a/scripts/arch-run.bash
> +++ b/scripts/arch-run.bash
> @@ -269,10 +269,21 @@ search_qemu_binary ()
>   	export PATH=$save_path
>   }
>   
> +initrd_cleanup ()
> +{
> +	rm -f $KVM_UNIT_TESTS_ENV
> +	if [ "$KVM_UNIT_TESTS_ENV_OLD" ]; then
> +		export KVM_UNIT_TESTS_ENV="$KVM_UNIT_TESTS_ENV_OLD"
> +	else
> +		unset KVM_UNIT_TESTS_ENV
> +	fi
> +	unset KVM_UNIT_TESTS_ENV_OLD
> +}
> +
>   initrd_create ()
>   {
>   	if [ "$ENVIRON_DEFAULT" = "yes" ]; then
> -		trap_exit_push 'rm -f $KVM_UNIT_TESTS_ENV; [ "$KVM_UNIT_TESTS_ENV_OLD" ] && export KVM_UNIT_TESTS_ENV="$KVM_UNIT_TESTS_ENV_OLD" || unset KVM_UNIT_TESTS_ENV; unset KVM_UNIT_TESTS_ENV_OLD'
> +		trap_exit_push 'initrd_cleanup'
>   		[ -f "$KVM_UNIT_TESTS_ENV" ] && export KVM_UNIT_TESTS_ENV_OLD="$KVM_UNIT_TESTS_ENV"
>   		export KVM_UNIT_TESTS_ENV=$(mktemp)
>   		env_params

Reviewed-by: Thomas Huth <thuth@redhat.com>

