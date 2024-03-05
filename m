Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58E043AC5
	for <linux-s390@vger.kernel.org>; Tue,  5 Mar 2024 06:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709621558; cv=none; b=cK3NY6C7HbNfQk3pWnXT3T7uvZAOB15P0ocP5N3Ja4obXAnSfAh8gqSnzhRZ3d0N25+Fh01upeAUMnUHy/5a/LuG0s6mHDNKreqaMSXOjVP758zsCouVcK0IeeEbP2kb52PzVLjPaU8rTBpDT90fpDEg/Ya0FU6eP6SarPKH/sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709621558; c=relaxed/simple;
	bh=ymocqJc1f5kWMMreqMv5DLV3/0cLM8ClbEnLpTzgif8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qlazOJHUaF8ja+MYxrYrq7EYBgX2U2kfEJajwP3ZN3SpGKuyZJmz4t5BaaOhuDcUcShTRI24oN20Hpiv800U3mt5/blKY/EmqosLfdQs59wD9FszYNtm6pBNhi/SYbXlB+SMovL7TpbU8fFihvHFrtGSfchic4hhUUz143fYWwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vk/VRNmr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vk/VRNmr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709621555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=055i0Cw+qSF55YTg7cbDTnODJKfJ+o7mIN7GUyBDy/4=;
	b=Vk/VRNmr4zwPjTfmGAhHAwBdgQq73xx1snzUJhsYzuV5JV7+h8L42wehQHZkLzX2lhPwa9
	DIn2wpN/Qi4QB4G81T5Y90Bn6O7HXt7GLup0wko/++8k43foXX4LsocEV39QxA6DQuWGrm
	z+PiXZAS2T9b+zVnJPkasV+fMPhaWto=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-Y9UyTMZ4No-ytcVqe22bGg-1; Tue, 05 Mar 2024 01:52:33 -0500
X-MC-Unique: Y9UyTMZ4No-ytcVqe22bGg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a456c9d0717so89441166b.3
        for <linux-s390@vger.kernel.org>; Mon, 04 Mar 2024 22:52:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709621552; x=1710226352;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=055i0Cw+qSF55YTg7cbDTnODJKfJ+o7mIN7GUyBDy/4=;
        b=DjvnnrkBvX1VDrBZc+I8yxVeJQ/i0M0BGMfTq2m+6cguAoVeRpqMmn8QKv9F0zQ82A
         ObNy9kTU2S9yC8lq3rkSXFTD9zpCFggAy8P/mzcS4fJGrHgdIgRQj0q/VbX1X8gBHBSX
         Q6qs93oH2wjCr0e94gb7DdahMFJkOSYFkob5BMCb5gvddjqaNWJr0jX4dFNSltU6Tlx8
         9xWYJVFf2ZreVoFbEKMotjKnNxtIcBe8WzBFAc+8NVgECH5b2U50q9n88cusij0FwPxP
         1PTN04aSTX428oMCbabnl7hskK9qlWRjDhL7eL8pb8Q9xO2oJiZTYkZ0Ep2hUhy/9n5p
         68uA==
X-Forwarded-Encrypted: i=1; AJvYcCWxA+560AFaNjxJL500cPXpSAO+SgXBzeRW8IBWK/rlxN9ttwzdZK1Z3LivJKnOp/bd83k2T8jFDWMl7q5GmxRXYz0poTquLUzw1A==
X-Gm-Message-State: AOJu0YzVQ3kEU2OJLaQok9xeJClElJG4QCJce1W0JaVkBv4abxrddhah
	asHTwmI9nnFKx0G4NoOjhHzG9xBF8y6mHrPa1fZbRA99Lm8UM1OFnzmwS1EFkpC3iJ/w9Sz0GUZ
	S3NbECREhA0zzGI2xjp5noKXOC47TEXqLqe2Z+ahBREnPwQ+2zWZs93WylHE=
X-Received: by 2002:a17:906:475a:b0:a40:4711:da20 with SMTP id j26-20020a170906475a00b00a404711da20mr7932089ejs.34.1709621552522;
        Mon, 04 Mar 2024 22:52:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFajVdOaJs4uKX0LYrWLK+X2XMHvDfhEUWWpjcLyw7CAYFHHlfoPf9mDziaodNnuUxasFUVcg==
X-Received: by 2002:a17:906:475a:b0:a40:4711:da20 with SMTP id j26-20020a170906475a00b00a404711da20mr7932065ejs.34.1709621552193;
        Mon, 04 Mar 2024 22:52:32 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-178-243.web.vodafone.de. [109.43.178.243])
        by smtp.gmail.com with ESMTPSA id uz3-20020a170907118300b00a44bb63f29csm4007506ejb.47.2024.03.04.22.52.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 22:52:31 -0800 (PST)
Message-ID: <839ca22a-b6e6-4e53-9819-cf803fb18101@redhat.com>
Date: Tue, 5 Mar 2024 07:52:30 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH 7/7] common: add memory dirtying vs
 migration test
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
 linux-s390@vger.kernel.org
References: <20240226093832.1468383-1-npiggin@gmail.com>
 <20240226093832.1468383-8-npiggin@gmail.com>
 <e967e7a6-eb20-4b2b-ab7a-fc5052a3eb52@redhat.com>
 <CZLH3XUGU8Z8.2R73ILJ3ISWN8@wheely>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CZLH3XUGU8Z8.2R73ILJ3ISWN8@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/03/2024 03.50, Nicholas Piggin wrote:
> On Mon Mar 4, 2024 at 4:22 PM AEST, Thomas Huth wrote:
>> On 26/02/2024 10.38, Nicholas Piggin wrote:
>>> This test stores to a bunch of pages and verifies previous stores,
>>> while being continually migrated. This can fail due to a QEMU TCG
>>> physical memory dirty bitmap bug.
>>
>> Good idea, but could we then please drop "continuous" test from
>> selftest-migration.c again? ... having two common tests to exercise the
>> continuous migration that take quite a bunch of seconds to finish sounds
>> like a waste of time in the long run to me.
> 
> Yeah if you like. I could shorten them up a bit. I did want to have
> the selftests for just purely testing the harness with as little
> "test" code as possible.

Ok, but then please shorten the selftest to ~ 2 seconds if possible, please.

  Thomas


