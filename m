Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625C379FE
	for <linux-s390@vger.kernel.org>; Wed,  8 Jan 2025 04:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736312043; cv=none; b=QiXJVSd/jzA+QgKCb7dUgP9FBWhrohGfNOrRz08jN1V/lNzy3ji9yxdW5J9slXdKmzd8iJvnCJfXhvOSGJxGkrZydm6AjE5O+3J+mDGqdNPWHtEbt1ZnhC1lcd2Iva3x2eVRhGf1itkcwUAnTH8p+Bd+4QyqrGS3NmOzBq0Ocx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736312043; c=relaxed/simple;
	bh=uyuDNtIOBYqDnWryQRHZ5qBgToQ3gandNYmtpBPm+rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TeKdyIt0taqBKhlgwZrwBdrzoYM/0Qk88OEbv2PEqQBzGoP8FZgtNu4xUoIMjz4yAKg/Q20El3b09o06ajw2TllBZYKlH7T83Bkf5j1kcfNVZOSQtflIBtBs9C8Je92gxQj31aJ5fJZQkXa1Hw6ekyZ4QZ/t0lBz89vO+8FYCU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=T9UM9MYn; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="T9UM9MYn"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2efb17478adso23670635a91.1
        for <linux-s390@vger.kernel.org>; Tue, 07 Jan 2025 20:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736312040; x=1736916840; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NTAeASi7vVObUDW8V2zM5ksK3/uTU7NPiyOQuEofviY=;
        b=T9UM9MYnJAYDup3XaXKe6FaHMEqXE6bUv5D1cJocXi0GJsyeArPdMbZHAg0CBAcGxh
         PuVoL7QmyBFDp22EV21u8R8765Mun1IKil1uYvidEK6q/OwtMrZOp9zICYsTyxZOF9S4
         MsERuJ+5AtQQHYKDqAlUJypCmvxgToWiuAJPnC3pCcB05zSUHUq86xg7oak+JLp4XQj5
         lw3qyNc+TNMsOjZ0H0l+/tw72ROdlMbxyyeG5HQiN6OfX+sgoFlhCbQZJxstUCFq7vty
         ebCv3kkuCh2hvHmvbvmDVohkiKIU8lPO9QIWVgjzYLjc7NXtBAqa2B1swWPfpX2UCUfs
         Sh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736312040; x=1736916840;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NTAeASi7vVObUDW8V2zM5ksK3/uTU7NPiyOQuEofviY=;
        b=ECB0QO7nlcVQ8k6kkXlzw8ki0MuzeB87RxYwf7in8aSPLnMjmxmu5a0nttKJXuD2pm
         zUAzW0jvHBiZuflBPbN9mwGKENGe1AQu3YVZnji8ZFuAWp1FIA6PvAaAa9cgIoJqjA5H
         d1nygy7H0AGemxdeuMPS/gI3sWAR3hpogz5uslkp76+t6ruJ/hWFcR1VuLIwIUu9Kdf0
         VLMTLoni5zfht2tbfiwjlgkbcAWWje8gI/4ZrN+obtg+tyezH+JKpNa63wfdta9t1ko9
         UGGIUkv8ANM4pMIjNxd19vAGAbLRqyZiLe9UoLoo7qIhxjMdiM5tTcUnP3MsYfRS1e/6
         Qshw==
X-Forwarded-Encrypted: i=1; AJvYcCWtN2qxUihAabARYbmbRFMDseMs2EGy7MxuuLYiCjJxpdLJEm6bPJ0pwHVvzxSOJvExIXHKI+iJVGwH@vger.kernel.org
X-Gm-Message-State: AOJu0YxgiktOYksMyiAeok9NVQ5yoVFAKo9pnuYo6ppECw3jPSNaidKY
	JH+v6v3qhnWwdHZCRTgQduTBJoMCEnH5yo6UQKs/pgwqtLPgocsk6YozOvwn6N8=
X-Gm-Gg: ASbGncsQHHf5NgEfpIIH6JTgeh1kW9nvlTJrns+RLvUFZdQXi6YWp0c3CAAqXTF1rxO
	C4/fAubdlEDqHSXm7+lmWzaddctccDeq50Chu44c2OFXCu63+ixAJWRSTcT9/bkSXrUEd7k6YVQ
	qSTN5SI1TNfzhvq5CNBfGlKiPeuiQYm4gSlNNgpTaVtzgnVe8PdI9IJy7A6e2S+flpn2BdPu0+E
	7cRb9W+5ri0s5fW+uGdRd94piGdmrtH6Kaa7knDqg9nml6in1ht9ydJ0hKIOfEd+lY=
X-Google-Smtp-Source: AGHT+IGF/lDnmbVBM65O0BZ//6tKBYkr4Hn46ySNw0SXEM+WKDuSN4ZlNc368YPeAlJVvXi3c8brJg==
X-Received: by 2002:a05:6a00:1385:b0:72a:aa0f:c86e with SMTP id d2e1a72fcca58-72d21f17738mr1884512b3a.4.1736312039609;
        Tue, 07 Jan 2025 20:53:59 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d012b1de0sm4918303b3a.80.2025.01.07.20.53.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 20:53:59 -0800 (PST)
Message-ID: <965b73e7-d0a3-4fae-b0ec-70b5497cb6c4@daynix.com>
Date: Wed, 8 Jan 2025 13:53:51 +0900
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] s390/crash: Use note name macros
To: Dave Martin <Dave.Martin@arm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>,
 Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Dave Young <dyoung@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, kexec@lists.infradead.org,
 binutils@sourceware.org, devel@daynix.com
References: <20250107-elf-v3-0-99cb505b1ab2@daynix.com>
 <20250107-elf-v3-5-99cb505b1ab2@daynix.com>
 <Z31Tp0nMhb/ntUW0@e133380.arm.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <Z31Tp0nMhb/ntUW0@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/01/08 1:17, Dave Martin wrote:
> Hi,
> 
> On Tue, Jan 07, 2025 at 09:45:56PM +0900, Akihiko Odaki wrote:
>> Use note name macros to match with the userspace's expectation.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   arch/s390/kernel/crash_dump.c | 62 ++++++++++++++++---------------------------
>>   1 file changed, 23 insertions(+), 39 deletions(-)
>>
>> diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
> 
> [...]
> 
>> @@ -281,10 +272,8 @@ static void *nt_init_name(void *buf, Elf64_Word type, void *desc, int d_len,
>>   	return PTR_ADD(buf, len);
>>   }
>>   
>> -static inline void *nt_init(void *buf, Elf64_Word type, void *desc, int d_len)
>> -{
>> -	return nt_init_name(buf, type, desc, d_len, nt_name(type));
>> -}
>> +#define NT_INIT(buf, type, desc) \
>> +	(nt_init_name((buf), NT_ ## type, &(desc), sizeof(desc), NN_ ## type))
> 
> Nit: this macro name clashes with the naming scheme in elf.h.
> 
> I think that there is a (weak) convention that macros with upper-case
> names don't expand to a C function call; thus, a macro with an upper-
> case name can be invoked in places where a C function call would not be
> allowed.  (This convention is not followed everywhere, though -- it's
> up to the maintainer what they prefer here.)

I wanted to clarify it is a macro as it concatenates tokens with ##, but 
I also find there are many macros that are named lower-case and performs 
token concatenation.

S390 maintainers, please tell usr your opinion.

> 
> (Note also, the outer parentheses and the parentheses around (buf)
> appear redundant -- although harmless?)

They only make a difference in trivial corner cases and may look 
needlessly verbose.

> 
>>   
>>   /*
>>    * Calculate the size of ELF note
>> @@ -300,10 +289,7 @@ static size_t nt_size_name(int d_len, const char *name)
>>   	return size;
>>   }
>>   
>> -static inline size_t nt_size(Elf64_Word type, int d_len)
>> -{
>> -	return nt_size_name(d_len, nt_name(type));
>> -}
>> +#define NT_SIZE(type, desc) (nt_size_name(sizeof(desc), NN_ ## type))
> 
> Nit: name prefix clash (again); possibly redundant parentheses.
> 
> [...]
> 
>> @@ -348,16 +332,16 @@ static size_t get_cpu_elf_notes_size(void)
>>   	struct save_area *sa = NULL;
>>   	size_t size;
>>   
>> -	size =	nt_size(NT_PRSTATUS, sizeof(struct elf_prstatus));
>> -	size +=  nt_size(NT_PRFPREG, sizeof(elf_fpregset_t));
>> -	size +=  nt_size(NT_S390_TIMER, sizeof(sa->timer));
>> -	size +=  nt_size(NT_S390_TODCMP, sizeof(sa->todcmp));
>> -	size +=  nt_size(NT_S390_TODPREG, sizeof(sa->todpreg));
>> -	size +=  nt_size(NT_S390_CTRS, sizeof(sa->ctrs));
>> -	size +=  nt_size(NT_S390_PREFIX, sizeof(sa->prefix));
>> +	size =	NT_SIZE(PRSTATUS, struct elf_prstatus);
>> +	size +=  NT_SIZE(PRFPREG, elf_fpregset_t);
>> +	size +=  NT_SIZE(S390_TIMER, sa->timer);
>> +	size +=  NT_SIZE(S390_TODCMP, sa->todcmp);
>> +	size +=  NT_SIZE(S390_TODPREG, sa->todpreg);
>> +	size +=  NT_SIZE(S390_CTRS, sa->ctrs);
>> +	size +=  NT_SIZE(S390_PREFIX, sa->prefix);
> 
> It might be worth fixing the funny spacing on these lines, since all
> the affected lines are being replaced.
> 
>>   	if (cpu_has_vx()) {
>> -		size += nt_size(NT_S390_VXRS_HIGH, sizeof(sa->vxrs_high));
>> -		size += nt_size(NT_S390_VXRS_LOW, sizeof(sa->vxrs_low));
>> +		size += NT_SIZE(S390_VXRS_HIGH, sa->vxrs_high);
>> +		size += NT_SIZE(S390_VXRS_LOW, sa->vxrs_low);
>>   	}
>>   
>>   	return size;
>> @@ -373,7 +357,7 @@ static void *nt_prpsinfo(void *ptr)
>>   	memset(&prpsinfo, 0, sizeof(prpsinfo));
>>   	prpsinfo.pr_sname = 'R';
>>   	strcpy(prpsinfo.pr_fname, "vmlinux");
>> -	return nt_init(ptr, NT_PRPSINFO, &prpsinfo, sizeof(prpsinfo));
>> +	return NT_INIT(ptr, PRPSINFO, prpsinfo);
>>   }
>>   
>>   /*
>> @@ -589,7 +573,7 @@ static size_t get_elfcorehdr_size(int phdr_count)
>>   	/* PT_NOTES */
>>   	size += sizeof(Elf64_Phdr);
>>   	/* nt_prpsinfo */
>> -	size += nt_size(NT_PRPSINFO, sizeof(struct elf_prpsinfo));
>> +	size += NT_SIZE(PRPSINFO, struct elf_prpsinfo);
>>   	/* regsets */
>>   	size += get_cpu_cnt() * get_cpu_elf_notes_size();
>>   	/* nt_vmcoreinfo */
> 
> Otherwise, this looks sensible to me.
> 
> Cheers
> ---Dave

