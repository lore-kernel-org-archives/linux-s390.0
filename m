Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3B213AD3F
	for <linux-s390@vger.kernel.org>; Wed,  4 Sep 2024 06:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725432736; cv=none; b=JABlguNg3n1MCIsuMKIV2uXF3XiPOPm1sYSo8AWgiRFJaV/slbKa0uCuZ6cx/bPbfsO/F6Ejiz/DKhX24/XQZunTetagb1i/WP2WI2bARsTRaFw4/hc7CISnQLyOzyX1ndGnYASmg0vo0fgBSNK8vAFrc2fGMDM5Tj0tMyxaes4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725432736; c=relaxed/simple;
	bh=IDiZgIow9HfJnlN7tmIwbxlf8Hr93+SVIRR4CnaFmeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WzjkHt4sevMOm6uqdFyR/ex0WIb/X7hmgElHxchfI8/Qb0LVoYhyjhFfBUg9hQ3AkhSC9DTta+hvTqhb/S3KARqNw0PFOJfC/gNrTp7W6dw6eqApvCiG95A8jAt98hHT5lu0HyqOGsKpN2SqaQni6PKKoQQM63tTtmhvywS5pvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fO1mzXZG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fO1mzXZG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725432732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VABDIikbxbAbTSQHLomHWS+MkknfvcB6H0xPs5zD4TI=;
	b=fO1mzXZG4CowBhhNYqV59URI69yJd2B9/vBq+Ie0/OnCShNZ5kJuKMde4rDWhbFxcSUPUF
	IiArMP7lnXWavcuMPDb/xBXkSMCcNIRODFdkjCY/zh1YgFEpYJJN6YMNbvEIMTiFeGWuJh
	JkKzvYcSuGPv5+1qnFFAASwKCbS2kqI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-UQFiuT7PMg6hdXX1ROxYMg-1; Wed, 04 Sep 2024 02:12:12 -0400
X-MC-Unique: UQFiuT7PMg6hdXX1ROxYMg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a870cad2633so548796966b.1
        for <linux-s390@vger.kernel.org>; Tue, 03 Sep 2024 23:12:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725430331; x=1726035131;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VABDIikbxbAbTSQHLomHWS+MkknfvcB6H0xPs5zD4TI=;
        b=hWqSaOB0Y82RkbYCi7mH8VXdPBdw7wtrmqA2YHisOvwNAtPtGdmRi4CbIb/wRfsJXN
         P+5OwD1F5aQNXSLfGJWdNwLSrKK8rhYrmzDsg3QtEPLn0serLrDEWE+6AIJxUsCu5sIw
         MmMTjaNjws+JKnCHvJno5wB9Y/IIVyUSESazwys1qkty8fvtIJ5HdCdt9jtMXqbR+GI3
         rAfNW24vXzEwGPBIYY6WUQ0VfiBnUoB3rBTNGFf0uygfKfRX+41RZWONsuv4HnYzreHc
         7WO9mPonBFJhhDv3ooz+hIo3s44YHqj+Q5HTNjG0HRgAyA4nqEIWwj3U582Ke7RQ4QEW
         hX/A==
X-Forwarded-Encrypted: i=1; AJvYcCXjb4fxUibWe/YMQ42WloBkDER26/OnKqr4yQh4qk5liIMhWe7xNHsN4KAocsWvQ0VwISRhgBBJksLE@vger.kernel.org
X-Gm-Message-State: AOJu0YzGWiN/jsJtaSHYuno8Asmwn3mSo4ERL2OH7gLCPyvGztGxbsrg
	hiUzHd/xnDFdKJGVX8k44VxCu0EdIZBJinG1I5plB0dLNGNG1mSrEi05U8VHxnmxVDDHm0DSz1F
	nYoIksmm5RqbfCa4qmm1lhVEmfDXXXk2qcyyAgNoUeG16CHwO5Mv5N/6/pjw=
X-Received: by 2002:a17:907:7295:b0:a86:9d3d:edef with SMTP id a640c23a62f3a-a897f77fa48mr1566625566b.12.1725430330835;
        Tue, 03 Sep 2024 23:12:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG45AYewg6tNE9To3cLQhgrRQm9CNbEwFJ8DttrdeygyFtBgrMme2ZadeOub7a84GejgI9cug==
X-Received: by 2002:a17:907:7295:b0:a86:9d3d:edef with SMTP id a640c23a62f3a-a897f77fa48mr1566623066b.12.1725430330337;
        Tue, 03 Sep 2024 23:12:10 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-176-181.web.vodafone.de. [109.43.176.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989215cb5sm762841866b.191.2024.09.03.23.12.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 23:12:09 -0700 (PDT)
Message-ID: <425f68ae-5d63-412d-a677-82d91b2d9935@redhat.com>
Date: Wed, 4 Sep 2024 08:12:08 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH 3/3] riscv: gitlab-ci: Add clang build
 tests
To: Andrew Jones <andrew.jones@linux.dev>, kvm@vger.kernel.org,
 kvm-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org
Cc: pbonzini@redhat.com, lvivier@redhat.com, frankja@linux.ibm.com,
 imbrenda@linux.ibm.com, nrb@linux.ibm.com, atishp@rivosinc.com,
 cade.richard@berkeley.edu, jamestiotio@gmail.com
References: <20240903163046.869262-5-andrew.jones@linux.dev>
 <20240903163046.869262-8-andrew.jones@linux.dev>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240903163046.869262-8-andrew.jones@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/09/2024 18.30, Andrew Jones wrote:
> Test building 32 and 64-bit with clang. Throw a test of in- and out-
> of-tree building in too by swapping which is done to which (32-bit
> vs. 64-bit) with respect to the gcc build tests.
> 
> Signed-off-by: Andrew Jones <andrew.jones@linux.dev>
> ---
>   .gitlab-ci.yml | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)

Acked-by: Thomas Huth <thuth@redhat.com>

