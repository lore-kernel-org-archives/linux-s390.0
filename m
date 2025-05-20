Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70A629A0
	for <linux-s390@vger.kernel.org>; Tue, 20 May 2025 05:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747719073; cv=none; b=lo2+gm0nqzbnwCBpdwe0QM/WuM3ick6jn9hh3lCZmIoNPHgDK7Ofo8II/AWyPfEUZg8JiAJjx3O0K/Wj/WHgi2i7Fe7SPhg4TMNfO2LHm4Gcr1sKMW/x7i7g4qE+NZZfllvgk5sjPUHk/piFZKXdmvIY+mocnyWsgeXPYGt2nJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747719073; c=relaxed/simple;
	bh=ubVOdsZhts8GALuRYWKRnYBe847+zLQoctpXZA/1YEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H7xJ7KMx/JyjoeWnF5pk68BhxQOtx6UKHxMCib1FoEz0xq5TOeqZYFGn0ySQpnC+GLUUhAMfvm6UZGmAWT9ATa0s6KSK9OeLF2t/KfkhiHlCvvZrWOhqveUWoR3P6/qc1wRASTGkBi6H42loo9FCY42w8AhZCI+nLHGk+4zhaSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XQ9Avn+U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XQ9Avn+U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747719069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GVKkcno9p26a+ewrPEs8zuPwnUGlqJrw02ZZV1EftGU=;
	b=XQ9Avn+U9HOQH+mDp2LxMtoHV/m3lZN/yobFkgn0tmLs6/cs0zk/EoWkXoDoXIhmsfG39z
	YIEToooKZgRotJ3F5CLymt9VsxCGX+zs6iGiI0tdI+ThNIPaWM6MrkYaVZSpoYw/HX9RrX
	6gGwppMtKMgfnR7mJoZWmB2L2Ouq90o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-cP1dDBEhMn-BucVchNLoVA-1; Tue, 20 May 2025 01:31:08 -0400
X-MC-Unique: cP1dDBEhMn-BucVchNLoVA-1
X-Mimecast-MFC-AGG-ID: cP1dDBEhMn-BucVchNLoVA_1747719067
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-445135eb689so14925075e9.2
        for <linux-s390@vger.kernel.org>; Mon, 19 May 2025 22:31:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747719067; x=1748323867;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GVKkcno9p26a+ewrPEs8zuPwnUGlqJrw02ZZV1EftGU=;
        b=G/aqJebkZrYaePSXyuB3dqEjTWJXMVjlU5nzh6BxbEZ+kRIfsvr9aP3Nd1OeAZspU7
         /3dSyhknnwURtVrecV/PjhJiLjMqzHenqVhkcn5DIuJMzso1BJ0pROuhGSHvdgTs4k6O
         T2lqfhFSVVvWThnY1EbvbWOZoHRlA/EgMaPnlf4ibMTumOOguYJtEM6sPuKFwhgZG9TA
         K7S7mmjGVaWJfvzwRnhHLlI7AqmQPC91cermapu3khlk9O+v4E6XoQiopp+evdL0kRjs
         pTcVGpc16syvB2Br8a8a+xPfJZLJiEJriSxZXd/pL4HRGcWzSZHTK2yv+SoBytdoCTAC
         SZjw==
X-Gm-Message-State: AOJu0YxyBEKeWFdQ6TTmk7pJj+gQbPokBCGQPsNcx2FAFZMaCX7HsqI6
	jasgVDmuyGjV36LlBEiPNaflOF+iW3jIBNs3H/iKTDX99N4OAzoHhgP38IuTwmCQ4xOa5c2+P6k
	u+IjIz1AF6z3pvHyEmWTCp9qym0V6EqucZuECVUi61SD+mHfGGLduSYfT2rAOxyt0Yk1BfHASxw
	==
X-Gm-Gg: ASbGnctHFkN0f/VDUQVUnnd4eM/VYlP8RuWSxG8luPKOl2ThI7EOhaxfrqND+Vo4y8D
	KopubyFNhOAnLOS6uHfyqMNx7km7KiTo7Tr3bcL0bwK+WhNFG3hdYtICIg2iU3YkAfhj2u2nSxE
	IVxfnbb3cmSf4j26R3NPVU0AvchlMAMbbpnYec/wl+p3lONiTqBqvIZs6kz8fiGqvvNnqJ5E6FP
	fqroyHz4ZfXQlxJ5fJad1m+zZ2luKiTjbr89U3faxhnmPXyZ5uAkCY0vcSo0wYcnEITFgt+xsX5
	GA8Voqfru+MDSFBSfi1QyDN/7wTaosQ/BNyc9ysNRms=
X-Received: by 2002:a05:600c:3588:b0:442:d5dd:5b4b with SMTP id 5b1f17b1804b1-442fd67861amr153166075e9.31.1747719066946;
        Mon, 19 May 2025 22:31:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAFa2IC/lG7oLV6XJ2W5wOhiQejVFDTE5WpqeFqIeOSQz+TQVtfrmQQHVNh9NCND4LG/ti/g==
X-Received: by 2002:a05:600c:3588:b0:442:d5dd:5b4b with SMTP id 5b1f17b1804b1-442fd67861amr153165845e9.31.1747719066593;
        Mon, 19 May 2025 22:31:06 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-201.web.vodafone.de. [109.42.49.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f1ef0b20sm16181065e9.14.2025.05.19.22.31.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 22:31:05 -0700 (PDT)
Message-ID: <253bb086-972e-4908-a006-4429232e8dcf@redhat.com>
Date: Tue, 20 May 2025 07:31:03 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] KVM: s390: Set KVM_MAX_VCPUS to 256
To: Christoph Schlameuss <schlameuss@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>
References: <20250519-rm-bsca-v2-0-e3ea53dd0394@linux.ibm.com>
 <20250519-rm-bsca-v2-1-e3ea53dd0394@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250519-rm-bsca-v2-1-e3ea53dd0394@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/05/2025 13.36, Christoph Schlameuss wrote:
> The s390x architecture allows for 256 vCPUs with a max CPUID of 255.
> The current KVM implementation limits this to 248 when using the
> extended system control area (ESCA). So this correction should not cause
> any real world problems but actually correct the values returned by the
> ioctls:
> 
> * KVM_CAP_NR_VCPUS
> * KVM_CAP_MAX_VCPUS
> * KVM_CAP_MAX_VCPU_ID
> 
> KVM_MAX_VCPUS is also moved to kvm_host_types to allow using this in
> future type definitions.
> 
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> ---
>   arch/s390/include/asm/kvm_host.h       | 2 --
>   arch/s390/include/asm/kvm_host_types.h | 2 ++
>   arch/s390/kvm/kvm-s390.c               | 2 ++
>   3 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index cb89e54ada257eb4fdfe840ff37b2ea639c2d1cb..f51bac835260f562eaf4bbfd373a24bfdbc43834 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -27,8 +27,6 @@
>   #include <asm/isc.h>
>   #include <asm/guarded_storage.h>
>   
> -#define KVM_MAX_VCPUS 255
> -
>   #define KVM_INTERNAL_MEM_SLOTS 1
>   
>   /*
> diff --git a/arch/s390/include/asm/kvm_host_types.h b/arch/s390/include/asm/kvm_host_types.h
> index 1394d3fb648f1e46dba2c513ed26e5dfd275fad4..9697db9576f6c39a6689251f85b4b974c344769a 100644
> --- a/arch/s390/include/asm/kvm_host_types.h
> +++ b/arch/s390/include/asm/kvm_host_types.h
> @@ -6,6 +6,8 @@
>   #include <linux/atomic.h>
>   #include <linux/types.h>
>   
> +#define KVM_MAX_VCPUS 256
> +
>   #define KVM_S390_BSCA_CPU_SLOTS 64
>   #define KVM_S390_ESCA_CPU_SLOTS 248
>   
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 3f3175193fd7a7a26658eb2e2533d8037447a0b4..b65e4cbe67cf70a7d614607ebdd679060e7d31f4 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -638,6 +638,8 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>   			r = KVM_S390_ESCA_CPU_SLOTS;
>   		if (ext == KVM_CAP_NR_VCPUS)
>   			r = min_t(unsigned int, num_online_cpus(), r);
> +		else if (ext == KVM_CAP_MAX_VCPU_ID)
> +			r -= 1;
>   		break;
>   	case KVM_CAP_S390_COW:
>   		r = machine_has_esop();
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>

