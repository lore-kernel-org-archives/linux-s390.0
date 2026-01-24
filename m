Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A56199385
	for <linux-s390@vger.kernel.org>; Sat, 24 Jan 2026 00:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769214060; cv=none; b=QMNq9rEDTqjPIEdB6CdBzVOuhsds5JP1pFX7kMHNRtY3FjoFbokEXVA0pNL4IsxOhCRc/BIH/VaQ8LZ42asOgmFz68JgY2X8YuyXLdM36oeJO3WGYKhOJgLyg+amQs8OZkyZOsRH5ziNVpnFd6BtokEy/kNRth8oDLmu/biOt2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769214060; c=relaxed/simple;
	bh=j2cnf66j7Tyeo03Ht3nxIfKsvE0nQ1mv6D7kqhjkBJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIQOXC22fE47Z7lDvoNKeCOcP1ivrEckHhFNgq/nIqJaG7CuXBUPI2Ns5cYX4Bg9PTcsjfg3/HZI0X1bYb5QNaZjdezW8zN+0zRG9eKY9Y4QYxqGC6a3Owxh0aiXPyHL59DbpZT9b4X2h8H30dU4v2Tb74v0684cFW066M1ewe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nh1jvGaU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=M9E2uMmr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nh1jvGaU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="M9E2uMmr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769214057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xhgLPiYR6xEsxXnQ/SeaMjXXghHvMuOe7YsndhfrobA=;
	b=Nh1jvGaUjRm0atvydNlFFcW0SGiWwOYFpOdTr4FsomtL9qdYU+lsoKPYZQ/oTEFfdVlIFN
	N+bjUvd+u6NUv4R012H2KaeQ6qtKfPv98GcgZHcSau+9q456oOuIes5Ywj7Z67w+zv8VdE
	jxe3YXmMkcgTLM5xpkflhgGfV4Frk5c=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-Zeyqb7DqP3uLRB0PLA3UFw-1; Fri, 23 Jan 2026 19:20:55 -0500
X-MC-Unique: Zeyqb7DqP3uLRB0PLA3UFw-1
X-Mimecast-MFC-AGG-ID: Zeyqb7DqP3uLRB0PLA3UFw_1769214055
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a78c094ad6so24961155ad.1
        for <linux-s390@vger.kernel.org>; Fri, 23 Jan 2026 16:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769214055; x=1769818855; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xhgLPiYR6xEsxXnQ/SeaMjXXghHvMuOe7YsndhfrobA=;
        b=M9E2uMmrBsQzGPqqCCdAcOKF8GqJoCk5ounUMhUSjiNg+2Pv66u2bgnSSgR+X/K7LA
         J5xRj63g/g40BSIo1dK9UUGNON7DepvQkjaVAktwmT+VmdWjUBclOGmf8Ea2YRHXaXIx
         XhK9Dq+5M6NZlsghGT++Ep5sTDWUBwLSdyKCAbwGGQGOtjskG2XcSpA/r+IL7yRdlGFK
         UP9ixpn2LrK2xaBGo55mxwIx1XxsRFKiYrkLi8V41h9DyxM1HtmJNjW5zzMk/ZMflzWe
         6rzOjlSQfAfZ/Zr6E3n/qehhM32/DgUIrt8/inuo+syrj66zTbP8dkXQTRriiQkgpbGC
         2EOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769214055; x=1769818855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xhgLPiYR6xEsxXnQ/SeaMjXXghHvMuOe7YsndhfrobA=;
        b=MxmwA8o8u7eVs/tgogF3Vq8dYQw+XjMrUxMt5FkB0NRC7e1QoZ6vGoxx+aCUdaRHgh
         b7h92vI5AQIQWvhIE+SEl2bf6HjuPdzScIzV6kMbwWw07suwznmWtZtwHOG+rW7ecqIb
         qrJcs/6/TJK91csl5lFo0mB5e22E7PhRP1ePB4yMM4lwKFAIQU5TuTUKa1cK10PHKIIE
         /uN0OnveXtJcASwaFI5kmpOOmFJrCMG7jgA0VwwE3yI3UWxQ4HQIGV0+eHTIhmfrg8se
         VCx5Gdj1n45zQZmPe7qWcbdxZb/NR3JSQHvKAAqysAgUMzvmy0J8Nj1CWZAa+4+u1Pzf
         3s8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWpaCPpJAiJA2/55a82oa4xJrpslFZHUo9icA/iZyFBCkIRLrn7TOHjLdd6U7Dx9uxX5wqXXaXSoUwE@vger.kernel.org
X-Gm-Message-State: AOJu0YwbknojjL4QYP7ixw9/rKqt+h08l3h/jbCcSdv43kvbgupYy2Ob
	u5hJiIJyf+HiVts8JeWvvWzkqK28hi8LaWSGRvktgbuEzv9P8Jh665P4fnWfa2yx7LeWj0ykGfy
	Y91n+5WngALDTaYR/Du4rs9rdgGAm2tioHoLLyZL9jwOqusBnC8GnDAMjhX5Y1GE=
X-Gm-Gg: AZuq6aIrRO2TT61hKlJv2bITV2QkyyTwuoIqy3VWQbhKDILMujq8zhmZz3bTF2cS5Dm
	F8ZXBUMrrgMZzo/1xCP5gwQF3PfilXn1JhmwIIjBpdFG6hc6MMo+VxyA4LpAca/daJUBnTFrR9u
	DKb726dTNZULSAusub9ChrtOMqfs5oZ8o6HNPYuzx6oo2HO1ViLW4E2fIuarFtEBiMpJr8EBg6O
	x06Mn6vYZM1M7ClrG2JQ50Yx3BnhUq2PwoFtv1sG+E8BioqeuqiagQ3huEjUC/PDKsNP7Q0mRpM
	7D1SrfQfd68b1m1LKAiyBy5T7tcFrG2u4oY9xujiZAdwFPnPoCqbX1VFW2R5NSgZ53ABzFOCF0q
	e
X-Received: by 2002:a17:902:e54d:b0:2a7:682b:50ac with SMTP id d9443c01a7336-2a7fe625118mr44257565ad.28.1769214054356;
        Fri, 23 Jan 2026 16:20:54 -0800 (PST)
X-Received: by 2002:a17:902:e54d:b0:2a7:682b:50ac with SMTP id d9443c01a7336-2a7fe625118mr44257045ad.28.1769214053812;
        Fri, 23 Jan 2026 16:20:53 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802faf6f9sm29695045ad.71.2026.01.23.16.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 16:20:53 -0800 (PST)
Date: Sat, 24 Jan 2026 08:18:46 +0800
From: Coiby Xu <coxu@redhat.com>
To: Ard Biesheuvel <ardb@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>
Cc: Dave Hansen <dave.hansen@intel.com>, linux-integrity@vger.kernel.org, 
	Heiko Carstens <hca@linux.ibm.com>, Roberto Sassu <roberto.sassu@huaweicloud.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, 
	"moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>, "open list:S390 ARCHITECTURE" <linux-s390@vger.kernel.org>, 
	"open list:EXTENSIBLE FIRMWARE INTERFACE (EFI)" <linux-efi@vger.kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, "open list:KEYS/KEYRINGS_INTEGRITY" <keyrings@vger.kernel.org>
Subject: Re: [PATCH 1/3] integrity: Make arch_ima_get_secureboot
 integrity-wide
Message-ID: <aXQN-ZNhT5olbf6X@Rk>
References: <20260115004328.194142-2-coxu@redhat.com>
 <CAMj1kXFXNo1-pMbo-VZrjQ3TYe1tufebrLr_avL12A0nHMSGnA@mail.gmail.com>
 <8bfa859ed3a4f1cf0db0ab64d8c1c3b24684582a.camel@linux.ibm.com>
 <CAMj1kXHsJNZoUEnbD1y=v4Ftuv9d2c08VckRV7ru4k4P83vZbQ@mail.gmail.com>
 <97b69bc79a5d9246f7a399510908c7b95b2e95e7.camel@linux.ibm.com>
 <CAMj1kXGx4ebaK87W7k0SNUNQnO9+=z1nmYxXC7retmp3OqRRFg@mail.gmail.com>
 <ac5e5e45c12e9b0bda19807e60b06057d74be0b3.camel@linux.ibm.com>
 <aW2i3yacr5TvWU-m@Rk>
 <1a0b6e5601a673a81f8823de0815f92b7afbeb60.camel@linux.ibm.com>
 <CAMj1kXFBMSEdRL8FotASbQO3dcfNG0bpp9Vnm5JPn-yjyDr=GA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAMj1kXFBMSEdRL8FotASbQO3dcfNG0bpp9Vnm5JPn-yjyDr=GA@mail.gmail.com>

On Wed, Jan 21, 2026 at 05:25:39PM +0100, Ard Biesheuvel wrote:
>On Wed, 21 Jan 2026 at 16:41, Mimi Zohar <zohar@linux.ibm.com> wrote:
>>
>> On Mon, 2026-01-19 at 12:04 +0800, Coiby Xu wrote:
>>
>> > diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
>> > index 976e75f9b9ba..5dce572192d6 100644
>> > --- a/security/integrity/ima/Kconfig
>> > +++ b/security/integrity/ima/Kconfig
>> > @@ -311,6 +311,7 @@ config IMA_QUEUE_EARLY_BOOT_KEYS
>> >   config IMA_SECURE_AND_OR_TRUSTED_BOOT
>> >          bool
>> >          depends on IMA_ARCH_POLICY
>> > +       depends on INTEGRITY_SECURE_BOOT
>> >
>> >
>> > Another idea is make a tree-wide arch_get_secureboot i.e. to move
>> > current arch_ima_get_secureboot code to arch-specific secure boot
>> > implementation. By this way, there will no need for a new Kconfig option
>> > INTEGRITY_SECURE_BOOT. But I'm not sure if there is any unforeseen
>> > concern.
>>
>> Originally basing IMA policy on the secure boot mode was an exception.  As long
>> as making it public isn't an issue any longer, this sounds to me.  Ard, Dave, do
>> you have any issues with replacing arch_ima_get_secureboot() with
>> arch_get_secureboot()?
>
>I don't see an issue with that. If there is a legitimate need to
>determine this even if IMA is not enabled, then this makes sense.

Thanks for the confirmation! Here's the updated patch
https://github.com/coiby/linux/commit/c222c1d08d90ef1ec85ef81ece90afc9efde7937.patch

If there is no objection, I'll send v2.

-- 
Best regards,
Coiby

