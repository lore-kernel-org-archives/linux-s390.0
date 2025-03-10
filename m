Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22D6158D94
	for <linux-s390@vger.kernel.org>; Mon, 10 Mar 2025 12:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741608859; cv=none; b=DSefIU/Y4ARKkqkGJKJdYSKhh8iq8z0IUPsgMOAKzqbntUj82xwk7gv81Jkn14sVAm7xm5aBRz5Nm+eUeei/AX/NnliGlxROYRTqGs3SmCaXFgG379/QUb63V2WmEdZhEpQOTDYJx4APsX7mKxcQupDUfmPx+CpNmgfRhkKB4hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741608859; c=relaxed/simple;
	bh=nPGOcSA5g/f+JDgzg1rOF9U0pDLMs2VjAObvG6jFU1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J/pDzb/xPaOjNeTzKYnhs8yMoqHL9gEdGWZ5yqSBfYTELnibULSakLz8ZnuR5cWAU5PNiDOzPLO9enPWvBmk5FcIWS28w7PkVFbgGe+nCibSWBUYzJXcFXLg8z7U3SSNDS4nQB34uTSUNYyK23S4dIL2FXRf6sjUe88ZYzuTX/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bi9dNjAv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bi9dNjAv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741608856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eryV+FUMI6b8m/5Vlnl0pDjjdupScr4/owQrghOZCsc=;
	b=Bi9dNjAvK0yL2FQopBi+3uEKYi87ZzoeoISHrIq84NAsH9GVw55iVHcBsIDRDfsJBsaRFs
	GJ9L7M2LDVD4EvCOwnxIKPRR+cSxeXy0blnGB0MvEgQG3zg1CjYsjHLL+cvyNK/NsgS3Ba
	NrTa8pfb3VDxYl0baUL/0Wjai9SjxZE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-FsdZRyklNym3exSICJvvVw-1; Mon, 10 Mar 2025 08:14:15 -0400
X-MC-Unique: FsdZRyklNym3exSICJvvVw-1
X-Mimecast-MFC-AGG-ID: FsdZRyklNym3exSICJvvVw_1741608854
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3913d8d7c3eso927142f8f.0
        for <linux-s390@vger.kernel.org>; Mon, 10 Mar 2025 05:14:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741608854; x=1742213654;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eryV+FUMI6b8m/5Vlnl0pDjjdupScr4/owQrghOZCsc=;
        b=CroD7OBenssAIKBZfjV6cUa8KwogPUITvBAF/1pi2RIC5t5Rvr0Uto1CQ/s0tGXwKE
         QRt/jjek85FV6Z4el4a4Qz+CXI5ncDWZOMhhGHtAQtfvpvaPRbWDUGZvlRDuFbMAyh7C
         B2IphD9HJ0LHnR5XrFQ1gIihZLkPqyvwfJnyfGBmI/BJzKUEO7qF9eGc0q/ND8uLhSmf
         pJFsVzynsh8ZRnpNxXbc/Rt+chStrdPyyS6oV+WHUceUMC6KQOQFcDqwwejb3xoM9c5W
         nSLDwZmgobT/eSEFdmD9qwR3YWtBsXdMy5Hi1iCt2I8rqOgdpn86DVRdAlZuyDhUA38/
         i80g==
X-Forwarded-Encrypted: i=1; AJvYcCVWzOg13UPZlFmId/nhorK+uj+6FbdQ0LGzYsquva6xND1sYl9Ir62dwjt3SAW6SIxqyalrO70Dx0Fu@vger.kernel.org
X-Gm-Message-State: AOJu0YzEVhcM6+B3zQ/szMxeDmU5CDU5K9qLQ5cYvGVEWnpMaeckzdWg
	8KCxAWTT/OT4NgQR94+gF88Vs9WmDSXTd1lssgIF146NhxnvNXea4O/gyKzKNKs66I5tBJIS2jY
	voJyXklJN50a7GtTqTSRGEHwY9rjguwR4uPW2tY01DLh2S4nMElGbU+ahuXU=
X-Gm-Gg: ASbGncusFlkYPbhrf7j31g+lD92uqjnG6cF0t+4hMTYWvDQnJ3MEKSQrA/MnTZbHbbc
	YQ1Ngv7mAXGfSvFsHusncIQJe17cLpYw9q13iQuE3Q801k9ssLmxC1mF222Dwv7p1mnQH24U9wr
	YsZ7rUDiDYrelMHbGm6jl5F4x1nue8PALLc4k4PAiVo7LI71LjV0KSVhoO7LFK/FIS0IfokIxXI
	AA7W5nbmUyXDDc4L7AxtJihVfG7eChXB5eZXoeKtKNzu98P06xw1Jpysyb0gyPKf3gf11fpHbQU
	qri+tt24DcQrRtnqkUr3dwHgspIs/l/m2EyPX614nUOxLJk=
X-Received: by 2002:a5d:64ae:0:b0:391:3cf6:95fd with SMTP id ffacd0b85a97d-3913cf6996amr5557441f8f.30.1741608852696;
        Mon, 10 Mar 2025 05:14:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzaQkC6x6aMdKZuim/zrdQO7lM6MLsCgjcq/5tL+T/E948p79/UPbtXj6c+NA6eVwCb7S11g==
X-Received: by 2002:a5d:64ae:0:b0:391:3cf6:95fd with SMTP id ffacd0b85a97d-3913cf6996amr5557413f8f.30.1741608852334;
        Mon, 10 Mar 2025 05:14:12 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-231.web.vodafone.de. [109.42.51.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba888sm14926378f8f.16.2025.03.10.05.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 05:14:10 -0700 (PDT)
Message-ID: <7eed4668-9352-45d6-8116-235c8be43bfa@redhat.com>
Date: Mon, 10 Mar 2025 13:14:08 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/uapi: Replace __ASSEMBLY__ with __ASSEMBLER__ in
 uapi headers
To: Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, linux-kernel@vger.kernel.org
References: <20250310102657.54557-1-thuth@redhat.com>
 <20250310104910.27210B18-hca@linux.ibm.com>
 <ab1ab15a-89e1-4c26-b7a2-6147a10a2fca@app.fastmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <ab1ab15a-89e1-4c26-b7a2-6147a10a2fca@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/03/2025 12.07, Arnd Bergmann wrote:
> On Mon, Mar 10, 2025, at 11:49, Heiko Carstens wrote:
>> On Mon, Mar 10, 2025 at 11:26:57AM +0100, Thomas Huth wrote:
>>
>> Did this cause any sorts of problems? I can see this pattern all over
>> the place, so why is this now a problem?
>>
>> Also, wouldn't it be better to fix this with an sed statement in
>> scripts/headers_install.sh instead? Otherwise this is going to be a
>> never ending story since those things will be re-introduced all the
>> time.
> 
> It should certainly be done in a consistent way across all
> architectures and architecture-independent headers. I see that
> all uapi headers use __ASSEMBLY__ consistently, while a few non-uapi
> headers use __ASSEMBLER__.
> 
> glibc obviously defines __ASSEMBLY__ whenever it includes one
> of the kernel headers that need this from a .S file. Unless
> there is a known problem with the current code, leaving this
> unchanged is probably the least risky way.

Well, this seems to be constant source of confusion. It got my attention by 
Sean's recent patch for kvm-unit-tests here:

  https://lore.kernel.org/kvm/20250222014526.2302653-1-seanjc@google.com/

Quoting: "This is essentially a "rage" patch after spending
way, way too much time trying to understand why I couldn't include some
__ASSEMBLY__ protected headers in x86 assembly files."

But also if you search the net for this, there are lots of other spots where 
people get it wrong, e.g.:

  https://stackoverflow.com/questions/28924355/gcc-assembler-preprocessor-not-compatible-with-standard-headers
  https://forums.raspberrypi.com/viewtopic.php?p=1652944#p1653834
  https://github.com/riscv-software-src/opensbi/issues/199

So I thought it would be a good idea to standardize on the #define that is 
set by the compiler already. IMHO it would be great to get it replaced in 
the whole kernel, but that's a little bit bold for one patch. So the obvious 
first step towards that direction is to replace it in the uapi header files 
first, where it hopefully will help to reduce the confusion in userspace. 
So unless you really don't like this idea at all, I could continue with the 
uapi headers for the other architectures, too?

  Thomas

