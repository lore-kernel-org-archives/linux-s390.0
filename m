Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0175F18AE2
	for <linux-s390@vger.kernel.org>; Thu, 12 Feb 2026 01:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770859831; cv=none; b=K9/JIEilJw3wQe2lFvWJAoGAKNvLmlEvWU/DvGewHdu4fGMkMWTwRl6Ks4huhRUTE/RFnPSBNX+Q5YK3xm+yTH2+trS/jm1Gydx2t5f9qEf1I7eWKu+wFU1wbPs2xon7vAmjYe6gY+XwbCxdmnR1a5v+gctsBIzQ+VnwnSjrbzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770859831; c=relaxed/simple;
	bh=KgiA3wWySdtu27emmfFx9TmT091bq+yUVCdDCtZD06E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAyuUzKtt+zt6Z9cbTPvZ/rONfzPX1t/SMdrFhPxTepP6nrGjXf60F8aA+O3lEUvIsQ8zoiLaT498QhgentWmkVF/ZDVnYa5dcm+J4NpbPgBol3s0l9DAfCiX7zfdO/BkZHFAlC6aBAC5le6jrQEBkj14Ee6QkEn4v2IuOOhD0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AstQJRbp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rW3cyGYT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AstQJRbp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rW3cyGYT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770859828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bY4z6uuO6pRuPz5GN5A8CgMrwxk/puAYj4i3AjMGr9s=;
	b=AstQJRbpgZMBDfedPSvIG3Xnm5M2B//WLIDQk+TQjtOT3E6HivpB5auxwSEoGzSe4NadKB
	4VX0yKUdUPfE+Bo5cB8Zvun30ncCADH3u1Nmka9q4M8pdlDxKVaJGgVOJpoBiAOn5fAxAe
	d9b0KsQkGsIPO7slZKuV4rPPHflHXtk=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-8u1Ta9gbOFKUyrYfOpUkpQ-1; Wed, 11 Feb 2026 20:30:26 -0500
X-MC-Unique: 8u1Ta9gbOFKUyrYfOpUkpQ-1
X-Mimecast-MFC-AGG-ID: 8u1Ta9gbOFKUyrYfOpUkpQ_1770859826
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2aad5fec176so51835945ad.2
        for <linux-s390@vger.kernel.org>; Wed, 11 Feb 2026 17:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770859826; x=1771464626; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bY4z6uuO6pRuPz5GN5A8CgMrwxk/puAYj4i3AjMGr9s=;
        b=rW3cyGYT80WHyfuMp1w5TJpBjPoWv61mDG4ZtpmQeZl2acJA5jaI/fsrzopYwdluq6
         eceo7h06g/zyKxIR3gnA3FmHV14L92jOoHBPE19+OqwlLBuN1uwEXM4QaDz0+yzTaLU/
         PbDeycOK7fHUH0q5tPT+CFWkjMQWUPUfQhaVof4qWIiPF8QpGPt1Fj/3mvlW4XZNfVuS
         1RTou6toE4yMxBi30ggY0JpJhP45wqzfYZMxlfcG3noTczxcrpwCjeDDiR4PKBKZc5Bi
         2S7KsXxXt3YJ92nXBhb10aHZkbUOV+zgWu+PLZnr4h0a0QrJZeXeGxEKGad7AETFmnV2
         jQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770859826; x=1771464626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bY4z6uuO6pRuPz5GN5A8CgMrwxk/puAYj4i3AjMGr9s=;
        b=dSAYa1YoQro2Hp/zjRWhKtXTOdvHxHDju2F2fw/gxtDc7datQSsLd00rSOPe0q+Vc3
         jiIG3b+aPz2IPMrTqIszWGljpeCVqSv+uv3KoOvLSK7omFcZDbkUG0lbtI8TMLpLYEZ9
         yKpvSYDKKzwi4IlIHxhIwcA982sRRRnvQhYd2Eb/5ABhn1jVGTfUFGmw5/udy/e6h3mx
         Y+8J5JVe9PRV5xOaPLqg+Z5tI0F4UogXynzij6BvR0MalHW+t74flbS/zkfV/XHIfNlS
         P2CQ2hd3lgEkPmgydTLLHQ1KZruCxMmmdYxBjR+LalyRlDRysOQl9zC6iN3tm8CnGUPd
         kSCQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2YWYpL4YetIBICpNScvTOJ96s1U3GoFd7wYjpxNcG0seCwGTAvqZr3cipqDouPISPqQxrH3Qh7xpf@vger.kernel.org
X-Gm-Message-State: AOJu0YwGSPAMutI1Hj/OIqwd0TaU7bG9ja3aVwSNAgAW3xAQt+GHKBEZ
	O9cf/Znud0Vnb7Id1i6tPrcpA+c/bvbbzE54dk7RUwIwx1zgs6i5ld90wFv7OCwK/4y6o5bXP4q
	YCrWWRp9AlN7I8yCFP1JhcmlQRfkkcd8PjLiZlErK9fQrGJidTHgl/u+72fVZuaU=
X-Gm-Gg: AZuq6aJ25Lfnk00ddfaUXyhT475GoJt9EicHUDyfNs40Yvamm32Bh6Q5Kj13YkRqC2/
	jMx38V+zEhonIJ65hYX5xtDs/5etLB1Ynb11b1eL3chX+EHWEnaBupWtCyFGlc6n+OCJrSE9abe
	hJ2NS1PPVjEkds6LJ+HrSSN/ARS4JrTJXfFr7Kuf/uFxgDOPKapK0uNEqr+qwgatxDQ03b2Ub2e
	VnFZ8JdMizXaqcSzo3E8/axO+sOXCIG1FbaZ3+Oq69c4gGN2MJien44QpgEhLBjgC5OnnnMraIr
	WP7Vd1SOkV2SPruQJZcc5jh4SRRODYYVRri+ZdC6gTZQsRefjc16IouyNB7gZ+ug3ZrIKlYeaDe
	cjVlZXr/q+Dqb
X-Received: by 2002:a05:6a20:e20d:b0:38d:fc34:c88d with SMTP id adf61e73a8af0-3944887601cmr937868637.55.1770859825463;
        Wed, 11 Feb 2026 17:30:25 -0800 (PST)
X-Received: by 2002:a05:6a20:e20d:b0:38d:fc34:c88d with SMTP id adf61e73a8af0-3944887601cmr937804637.55.1770859824883;
        Wed, 11 Feb 2026 17:30:24 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e197f7e0bsm3248413a12.27.2026.02.11.17.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 17:30:24 -0800 (PST)
Date: Thu, 12 Feb 2026 09:28:43 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, 
	Alexander Egorenkov <egorenar@linux.ibm.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Dave Hansen <dave.hansen@intel.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>, "open list:S390 ARCHITECTURE" <linux-s390@vger.kernel.org>, 
	"open list:EXTENSIBLE FIRMWARE INTERFACE (EFI)" <linux-efi@vger.kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, "open list:KEYS/KEYRINGS_INTEGRITY" <keyrings@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] integrity: Make arch_ima_get_secureboot
 integrity-wide
Message-ID: <aY0rZp9ROwfjPgD8@Rk>
References: <20260203041434.872784-1-coxu@redhat.com>
 <20260203041434.872784-2-coxu@redhat.com>
 <66f9d13875e81a965984e2a661e992a3fe43c516.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <66f9d13875e81a965984e2a661e992a3fe43c516.camel@linux.ibm.com>

On Mon, Feb 09, 2026 at 03:43:08PM -0500, Mimi Zohar wrote:
>On Tue, 2026-02-03 at 12:14 +0800, Coiby Xu wrote:
>> EVM and other LSMs need the ability to query the secure boot status of
>> the system, without directly calling the IMA arch_ima_get_secureboot
>> function. Refactor the secure boot status check into a general function
>> named arch_get_secureboot.
>>
>> Reported-and-suggested-by: Mimi Zohar <zohar@linux.ibm.com>
>> Suggested-by: Roberto Sassu <roberto.sassu@huawei.com>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>
>Thanks, Coiby.  Other than unnecessarily splitting a line, the patch set looks
>good.  As soon as the open window closes, I'll queue these patches for linux-
>next.

Hi Mimi, thanks for reviewing the patch set! Would you like me to send a
new version with the line splitting issue fixed?

>
>> diff --git a/security/integrity/ima/ima_efi.c b/security/integrity/ima/ima_efi.c
>> index 138029bfcce1..27521d665d33 100644
>> --- a/security/integrity/ima/ima_efi.c
>> +++ b/security/integrity/ima/ima_efi.c
[...]
>>  {
>> -	if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) && arch_ima_get_secureboot()) {
>> +	if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) &&
>> +	    arch_get_secureboot()) {
>
>No need to split the line here or below.
>
>
>>  		if (IS_ENABLED(CONFIG_MODULE_SIG))
>>  			set_module_sig_enforced();
>>  		if (IS_ENABLED(CONFIG_KEXEC_SIG))
>> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
>> index 5770cf691912..6d093ac82a45 100644
>> --- a/security/integrity/ima/ima_main.c
>> +++ b/security/integrity/ima/ima_main.c
>> @@ -949,8 +949,8 @@ static int ima_load_data(enum kernel_load_data_id id, bool contents)
>>
>>  	switch (id) {
>>  	case LOADING_KEXEC_IMAGE:
>> -		if (IS_ENABLED(CONFIG_KEXEC_SIG)
>> -		    && arch_ima_get_secureboot()) {
>> +		if (IS_ENABLED(CONFIG_KEXEC_SIG) &&
>> +		    arch_get_secureboot()) {
>
>===>
>
>Mimi
>
>>  			pr_err("impossible to appraise a kernel image without a file descriptor; try using kexec_file_load syscall.\n");
>>  			return -EACCES;
>>  		}
>

-- 
Best regards,
Coiby

