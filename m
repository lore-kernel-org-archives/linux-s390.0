Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B584653
	for <linux-s390@vger.kernel.org>; Mon, 19 Feb 2024 06:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708325792; cv=none; b=mQV7XjCXzIlsKO7BErwQAo5XpxnTj1KcrcyWkNwPppaY4zxpeSCIKZDg09wQ7DAG2c8T+CDnn8z05Avkwaxh5258bMarOXVnU0j5+iq4N/naDqNt5AQsVwOl5PsDSwhWW1EPLgj2m8UV/cPRwhq+2XDlnV1bnj1eKdA3ZnN/N1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708325792; c=relaxed/simple;
	bh=8+22TydQJilP2WbzZnUx+4i+iy512mDyjD49Ih9x9xI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z2lHcd4cjYnopEPzPuT0yvVhY0y29wsCE7jZkQlhBorvWI+wrt1i7NsUMU0But1gQH22gEZnDw+IblB+Kka2juEswO6vUlwW6MRSga5kBs6DuSrbFBxvptLkw3DhfyfJaa3uXT+QX8/8E7hPcSvPQTCmpI75zqoxKnawXozG7hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NrcYuW4y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NrcYuW4y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708325789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YE5SUQ6P85lCv9ueDPInmuqKDSZltz/dw8thQgaLw/U=;
	b=NrcYuW4ygG1Ht7dvPB7LQzxvrRKfF0M0ILWj1gWEavQcixq0Gp7lwwkcB9CAU/AHRo7qED
	FA3pL9K5ijbhu3ja9vnT9vbkrSR9fygXVsd/lxWvNf7LUqLXUxTrH1BqnvHaurFfAT6oi+
	7BDMXyh8YosinpeG1YyT8RSVFEMLWZU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-ovTnVQL4PpC6EG8z8vgkFQ-1; Mon, 19 Feb 2024 01:56:27 -0500
X-MC-Unique: ovTnVQL4PpC6EG8z8vgkFQ-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-42c7a807fd0so23158721cf.1
        for <linux-s390@vger.kernel.org>; Sun, 18 Feb 2024 22:56:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708325787; x=1708930587;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YE5SUQ6P85lCv9ueDPInmuqKDSZltz/dw8thQgaLw/U=;
        b=VKieVj5BJZGzuv19YxPGsLrGs5bKcqA4vZt674MmJq74D61GIl64fFUSVNz7YWqcqq
         R47RBibomDQqv6eBTOaCU3s2nZHXk/I+QwJ2tXRtOVwhIbM/EQX0TgPO/ga9nuxNRlZs
         gplphmXCI4CA0HRaesVFx+iE+qhO71XfN4JOX/DoZ1OPxKJtZEbpctCjpukGSpvoK5ZN
         75QG4pSM5mMjNXz2/cCd7HEsEfi38Dg19hdwhLkPM10YrXbwqxKIE91LS7gAFyQYhNbp
         hG1aR59HPnfeQbKJIifshLzUZUOLeMtTsI1xA77I8gDbDz9mcivFQ7eENZDp285UVBu2
         SKJA==
X-Forwarded-Encrypted: i=1; AJvYcCX4ldJkdIyRqysICRgXzd4Qn3CknZLUsg73KhXif/dxUCMdTzHRVKpAtK5/ONfLPUhGOSy7DV9vZ30usp/lpVeYaRly2UwCptefrA==
X-Gm-Message-State: AOJu0YybEz1Azc2QjutIdfO6xnNeVRZcTwHV5Lwa0mSTbqmpptnyrnya
	8ZiXvbVg541RLzRBQaUQIUj/HuBZvOXGiDwAfA87OjLYWEO7YXoMbZrPBNJ7KemmeeS7RIShtY0
	MeBSR//TUcmNWgL8KJFFHW+lGMtFguBAmBFDgY2T6cJzdDtkcjk/Uy24wwow=
X-Received: by 2002:ac8:5d8b:0:b0:42c:54d6:99fb with SMTP id d11-20020ac85d8b000000b0042c54d699fbmr15624793qtx.55.1708325787474;
        Sun, 18 Feb 2024 22:56:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTOW/vjFnoKRoExIXffu9pU0oDU4E/siRxT5/SvPfw5icjpuTChge/eWrQhyvNO1ncSWTERQ==
X-Received: by 2002:ac8:5d8b:0:b0:42c:54d6:99fb with SMTP id d11-20020ac85d8b000000b0042c54d699fbmr15624786qtx.55.1708325787202;
        Sun, 18 Feb 2024 22:56:27 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-177-48.web.vodafone.de. [109.43.177.48])
        by smtp.gmail.com with ESMTPSA id e7-20020ac85dc7000000b0042c50e1adf3sm2254061qtx.95.2024.02.18.22.56.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Feb 2024 22:56:26 -0800 (PST)
Message-ID: <4d73467d-2091-4342-87a1-822f4aeb8b70@redhat.com>
Date: Mon, 19 Feb 2024 07:56:20 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v4 8/8] migration: add a migration selftest
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
 <20240209091134.600228-9-npiggin@gmail.com>
 <abbcbb47-1ae7-4793-a918-dede8dcaf07f@redhat.com>
 <CZ7673PUQ853.DB10GSBEZ65Z@wheely>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CZ7673PUQ853.DB10GSBEZ65Z@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/02/2024 08.19, Nicholas Piggin wrote:
> On Fri Feb 16, 2024 at 9:15 PM AEST, Thomas Huth wrote:
>> On 09/02/2024 10.11, Nicholas Piggin wrote:
>>> Add a selftest for migration support in  guest library and test harness
>>> code. It performs migrations in a tight loop to irritate races and bugs
>>> in the test harness code.
>>>
>>> Include the test in arm, s390, powerpc.
>>>
>>> Acked-by: Claudio Imbrenda <imbrenda@linux.ibm.com> (s390x)
>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>> ---
>>>    arm/Makefile.common          |  1 +
>>>    arm/selftest-migration.c     |  1 +
>>>    arm/unittests.cfg            |  6 ++++++
>>
>>    Hi Nicholas,
>>
>> I just gave the patches a try, but the arm test seems to fail for me: Only
>> the first getchar() seems to wait for a character, all the subsequent ones
>> don't wait anymore and just continue immediately ... is this working for
>> you? Or do I need another patch on top?
> 
> Hey sorry missed this comment....
> 
> It does seem to work for me, I've mostly tested pseries but I did test
> others too (that's how I saw the arm getchar limit).
> 
> How are you observing it not waiting for migration?

According to you other mail, I think you figured it out already, but just 
for the records: You can see it when running the guest manually, e.g. 
something like:

  qemu-system-aarch64 -nodefaults -machine virt -accel tcg -cpu cortex-a57 \
    -device virtio-serial-device -device virtconsole,chardev=ctd \
    -chardev testdev,id=ctd -device pci-testdev -display none \
    -serial mon:stdio -kernel arm/selftest-migration.flat -smp 1

Without my "lib/arm/io: Fix calling getchar() multiple times" patch, the 
guest only waits during the first getchar(), all the others simply return 
immediately.

  Thomas

