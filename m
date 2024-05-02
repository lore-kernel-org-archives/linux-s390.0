Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7249B33CFC
	for <linux-s390@vger.kernel.org>; Thu,  2 May 2024 08:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714638213; cv=none; b=js8F9LVbBNgc8KqJWO14GFAas5RUDRGAENv3+UTfj2fTkq23TAqTPj8KL89ffknLY21H/Np6HX46qtlwbq3kmSfv6UENimxB+mWRm42EFz7Dzb7oE5QENVlD9cMPn+/6E6woaIBI5BDHMt0fHgKvosyHZc4gE7OyF8IgYii2DXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714638213; c=relaxed/simple;
	bh=ZE+ngAnTCcsMSeiqF7e9PkuEtQy1o+nImccEUeE4khQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Go5gxgbOGYeD1/R1J8VMGPHkjfYBTGbbrinFcYw3ROHfKQrVBvBegc0fvPzVFPk8OT7yzU7FJJ+kn+SsqvZrPO8dZPII7D63RkFu+9OyO/5LaBZ2ibaHaiwmhjVBr9UHiitq9xjQIg1nI5w2dipJUhA0XMnk9GS9pv8CL1SmPFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SPUwWpr9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SPUwWpr9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714638207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=w5km4/BthBCY3+a3KkxvTt8Ci9HCPSEYsYp2lASqktk=;
	b=SPUwWpr9Va0kUWv28ib3Lz4l3pGcfPwGOsNo4Q1xN8gbBktcCNFokjQFpDCwgFxvphD4eg
	OdVuvsurCV7uk6Thb0NY8vpV1PXIRM1WNLN8ofQVq3nZz0vFdneRy6T14qVMKHStb8LIgh
	DnrILrRmS0EP2DyZSCirpaUbXEmvuOk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-L69ZFPkpPGW1xPP0RGH0nA-1; Thu, 02 May 2024 04:23:25 -0400
X-MC-Unique: L69ZFPkpPGW1xPP0RGH0nA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-41895b0a62cso53814555e9.2
        for <linux-s390@vger.kernel.org>; Thu, 02 May 2024 01:23:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714638204; x=1715243004;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w5km4/BthBCY3+a3KkxvTt8Ci9HCPSEYsYp2lASqktk=;
        b=R6mJLXq2gtn5HLpXJcNOYv3aIjKOFus2thgEYfnnDgr9Qsx7hSFjI+lDI/ZhzEMGJm
         F/TrWqLx7C1CyhN84V+IcGlEamKuoytv4StGBPxzHy5WQynAGxzifSj1qRhLmEX+voKL
         hLPG42eXQAsY0bWC3naaV4pS3qhcxAoMQtlqj2RFHc+Vt/VZ+nYnIy1u06LcKE29Q1fz
         v4oCzB4YUbpECSU1He7VcwrkJXkQXEafQyvD4GO85wSxUFEXUyHYTNtZkCiUCTxT1xHk
         Fny/xok7dtPhADptUqphKRL06GFiXUZXXjqVuZ5VpVbiJxC5q0TRTs+jgH1qgyWmEC8y
         9KfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQ7FIBNOQ/mwVf+XCXAhYZalXQXYY+HgylEKbmQ2Qxih+Xryh6vL+ZeYhMACCSQZ0GrzeErbzp/pZylp8RzvMDRLdi4Ve5zTq65Q==
X-Gm-Message-State: AOJu0YwpEHw/tZu80ISU7yolASDOMCgBzqnBoC905OUsdZGHoo1zF1Vr
	9xlJbIVWZa+fZuZ8Un6vg/lek0QvqnZai9l/o368DuY1C7TIS+mDLNSOnZl7PQZvnEyIgbsH+4r
	vvERsrhGughl55rvXD8vASZ+BASK9TUpEI8xrdXxO0ryyOzs0QrSzgCIp7Xw=
X-Received: by 2002:a05:600c:3d0a:b0:418:e7b6:21de with SMTP id bh10-20020a05600c3d0a00b00418e7b621demr3971472wmb.23.1714638204785;
        Thu, 02 May 2024 01:23:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPgGlTEo2U9DPytMcpxxfhGvFdTayJOWEviyctdTbnI07tu/xfP/RLwUzgzjLL8wvtBjYeCQ==
X-Received: by 2002:a05:600c:3d0a:b0:418:e7b6:21de with SMTP id bh10-20020a05600c3d0a00b00418e7b621demr3971445wmb.23.1714638204428;
        Thu, 02 May 2024 01:23:24 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-179-34.web.vodafone.de. [109.43.179.34])
        by smtp.gmail.com with ESMTPSA id bd13-20020a05600c1f0d00b0041c012ca327sm1083150wmb.45.2024.05.02.01.23.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 01:23:24 -0700 (PDT)
Message-ID: <2be99a78-878c-4819-8c42-1b795019af2f@redhat.com>
Date: Thu, 2 May 2024 10:23:22 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v3 0/5] add shellcheck support
To: Nicholas Piggin <npiggin@gmail.com>, Andrew Jones <andrew.jones@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Eric Auger <eric.auger@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, =?UTF-8?Q?Nico_B=C3=B6hr?=
 <nrb@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Shaoqin Huang <shahuang@redhat.com>,
 Nikos Nikoleris <nikos.nikoleris@arm.com>,
 David Woodhouse <dwmw@amazon.co.uk>, Ricardo Koller <ricarkol@google.com>,
 rminmin <renmm6@chinaunicom.cn>, Gavin Shan <gshan@redhat.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org
References: <20240501112938.931452-1-npiggin@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240501112938.931452-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/05/2024 13.29, Nicholas Piggin wrote:
> This is based on upstream directly now, not ahead of the powerpc
> series.

Thanks! ... maybe you could also rebase the powerpc series on this now? (I 
haven't forgotten about it, just did not find enough spare time for more 
reviewing yet)

> Since v2:
> - Rebased to upstream with some patches merged.
> - Just a few comment typos and small issues (e.g., quoting
>    `make shellcheck` in docs) that people picked up from the
>    last round.

When I now run "make shellcheck", I'm still getting an error:

In config.mak line 16:
AR=ar
^-- SC2209 (warning): Use var=$(command) to assign output (or quote to 
assign string).

Not sure why it's complaining about "ar" but not about the other lines in there?

Also, it only seems to work for in-tree builds. If I run it from an 
out-of-tree build directory, I get:

*/efi/run: */efi/run: openBinaryFile: does not exist (No such file or directory)

  Thomas

