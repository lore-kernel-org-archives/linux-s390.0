Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB162594B6
	for <linux-s390@vger.kernel.org>; Wed,  8 Jan 2025 04:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736310873; cv=none; b=ZkOWzmTmH+5P8REEAH7+GQWbuf+tNIeTsScFR+xhcxPepAi603fjr3SQ2MqP157CFaRb8a6oDTlW5NFLlwr7h81m+i+6UvmChAjZGDZD6uw3pDDczBfj61tA2vnhP66P2UJpUyQ1Zp4MSDPJMIml1dUsoKhFhZYaWInp4c4P6xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736310873; c=relaxed/simple;
	bh=7V6JWRfMe2YRHgN0cvVhNfilOVqdetz0ehJc/OcedDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZnLorzx9/GjVx3BKfHXT5QmUx8RNyRNzdN8LjBa1plk4gIRvwQuJTD1z3TSMOnPWqbWBi4xWslA7odsmH4WpFGidvTobqaBhSoKZdRQ2sEdrfBsX8g00eAT17HeN3LEUoiIlBHTl20F5J0Sg2wRdjJaUyhW7/PQ5epf6zGHghRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=rUX8V8fL; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="rUX8V8fL"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ef748105deso18423850a91.1
        for <linux-s390@vger.kernel.org>; Tue, 07 Jan 2025 20:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736310871; x=1736915671; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l5qyePdTQsadGlhhkm88UTLOJyB05IwMsFPhm2KKy5k=;
        b=rUX8V8fLWu02Zq/GmPWDRo3naBb8VY7uymTXm1e7xyxY98iSAwTBWcEl8MbcPoJSkp
         T0Ro/SZ/R1KJGzmChaceLhgWDx0WfXvDhH5hVW/dz9TUu+2VViZ9UVo0Pf4q4r8Ov7K0
         L5XM/y9BgShFkHFvx/RZ+HU/Ni9qR26zg+XM33N6DEzGRKzJnNfzsQEtXhxQdy3rjLjl
         RBAyuoZDUcgFmIHqO4TqVfxmiSu3tmi9yEErnmO/Sg+Zj5a9r9b+noQWNoiQnKOdwu/I
         yexa7gP6uadnr28uflZQBPbdQhwzdsv0P6fJ2P/mop6rJrODrXZU7PAWMJkPTJI68yYd
         jRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736310871; x=1736915671;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l5qyePdTQsadGlhhkm88UTLOJyB05IwMsFPhm2KKy5k=;
        b=vIieBC9oUv5HwwY2nVuMTHX3R4ol6nME8m3/11BP8iW6HRmjLJWs5ht5ejCPCa/goX
         G6aNFnMyNoM6cwo3ghRsH42R2guXkK997nYa4D0y/KI9jw3Wy8VlgRCOSAREKyGHE+BE
         wyJtR+hEQgSECt5cnur+9NdEm2k0/x5g4G+BtKX2F38jXI2kYszIdRO9h1XeBG4I5E/L
         tyF+dNY7bjrCAw29OQ5cFbHkq6P9pNZ8qyvo2UK6iQ7yrGifESQYWVwqqOD8SpHjzIvN
         VBiuk7/Rpav78jiACewa9QjgRaJtNwrxIaLzhmlMqmbEXBDIazYIFStzvFUQhHoWZaUQ
         G9/A==
X-Forwarded-Encrypted: i=1; AJvYcCUGS7SzDNM7zKkpeVUAgtzVP/zJWy4GanQNnLjc0Idt/RmrY1V8hthkco7dfM7I0ZgCpyN3PSGdlGdX@vger.kernel.org
X-Gm-Message-State: AOJu0Yy34jPU6iGYLORtA/GdNnMcjaA0LIyIU/k8KWpCufE7fVNYJKnV
	L4FRu/4+R1hh1atRXBOQztdFVZO55SmR1d28EuWftwbgpw7HFQV11UJtogIYgz8=
X-Gm-Gg: ASbGnct6HuDdGSorNiYwugpV55YpnrcLXHLTs/YEf+iicRJ0yc9RSljC5r5aXDxtPo5
	YZdWFuwKRP5apOJDlYnXHmF1KbxYABY6J6ww7d9sAzmF/D0zqNjOKxlbRJRHEyTxH/zAQHss982
	mex1R7J42UNUmWwYvyd6WMIQAQuaZJeWTUhb/Cph7waVbPJ7DWCzKHojv4H1618KTMcXXkNd628
	44/I1iLlbyqNFWathYhDRNc5J6OCcZOR4fg1f1aMD8gFklWF1ax18+NRRSonF/g1Dc=
X-Google-Smtp-Source: AGHT+IGQRKZLowOpLDJxDKDC4Zdlnk/imeV0cILJj+G12S7tUJ9/SfK9Sf0wRtST8EIlv//HMUuIqA==
X-Received: by 2002:a17:90b:3bc4:b0:2f4:43ce:dcea with SMTP id 98e67ed59e1d1-2f548f1edafmr2196020a91.25.1736310871016;
        Tue, 07 Jan 2025 20:34:31 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f54a34d91bsm448853a91.32.2025.01.07.20.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 20:34:30 -0800 (PST)
Message-ID: <2c6f2c95-b2fc-46e0-91ce-1b9f14b28d3d@daynix.com>
Date: Wed, 8 Jan 2025 13:34:24 +0900
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] binfmt_elf: Use note name macros
To: Dave Martin <Dave.Martin@arm.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>,
 Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Dave Young <dyoung@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, kexec@lists.infradead.org,
 binutils@sourceware.org, devel@daynix.com
References: <20250107-elf-v3-0-99cb505b1ab2@daynix.com>
 <20250107-elf-v3-2-99cb505b1ab2@daynix.com>
 <Z31T0dMgMucke5KS@e133380.arm.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <Z31T0dMgMucke5KS@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/01/08 1:18, Dave Martin wrote:
> On Tue, Jan 07, 2025 at 09:45:53PM +0900, Akihiko Odaki wrote:
>> Use note name macros to match with the userspace's expectation.
> 
> Also (and more importantly) get rid of duplicated knowledge about the
> mapping of note types to note names, so that elf.h is the authoritative
> source of this information?
> 
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Acked-by: Baoquan He <bhe@redhat.com>
>> ---
>>   fs/binfmt_elf.c       | 21 ++++++++++-----------
>>   fs/binfmt_elf_fdpic.c |  8 ++++----
>>   2 files changed, 14 insertions(+), 15 deletions(-)
>>
>> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
>> index 106f0e8af177..5b4a92e5e508 100644
>> --- a/fs/binfmt_elf.c
>> +++ b/fs/binfmt_elf.c
> 
> [...]
> 
>> @@ -1538,7 +1538,7 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
>>   	do
>>   		i += 2;
>>   	while (auxv[i - 2] != AT_NULL);
>> -	fill_note(&auxv_note, "CORE", NT_AUXV, i * sizeof(elf_addr_t), auxv);
>> +	fill_note(&auxv_note, NN_AUXV, NT_AUXV, i * sizeof(elf_addr_t), auxv);
>>   	thread_status_size += notesize(&auxv_note);
>>   
>>   	offset = sizeof(*elf);				/* ELF header */
> 
> Looking at this code, it appears that the right name is explicitly
> taken from elf.h for a few specific notes, but for those that are
> specified by the arch code (e.g., in struct user_regset entries) the
> name is still guessed locally:
> 
> static int fill_thread_core_info(...) {
> 
> ...
> 
> 	fill_note(&t->notes[note_iter], is_fpreg ? "CORE" : "LINUX",
> 		note_type, ret, data);
> 
> 
> It would be preferable to clean this up if we want elf.h to be the
> authoritative source for the names.

If we want elf.h to be the authoritative source, yes, but I like the 
current form as it ensures nobody adds a note with a name different from 
"LINUX" and it is also simpler. There is a trade-off so I'd like to keep 
the current form unless anyone has a strong preference for one option.

Regards,
Akihiko Odaki

> 
> It would be possible to add a .core_note_name entry in struct
> user_regset, and define a helper macro to populate the note type and
> name, something like the following:
> 
> struct user_regset {
> 	...
> 	unsigned int core_note_type;
> +	unsigned int core_note_name;
> };
> 
> #define USER_REGSET_NOTE_TYPE(type) \
> 	.core_note_type = NT_ ## type, \
> 	.core_note_name = NN_ ## name,
> 
> ...and then replace every .core_note_type assignment with an invocation
> of this macro.  A quick git grep should easily find all the affected
> cases.
> 
> 
> Alternatively, as discussed in the last review round, a helper could
> be defined to get the name for a note type:
> 
> const char *elf_note_name(int Elf32_Word n_type)
> {
> 	switch (n_type) {
> 	case NT_PRSTATUS:	return NN_PRSTATUS;
> 	case NT_PRFPREG:	return NN_PRFPREG;
> 	/* ...and all the rest..., then: */
> 
> 	default:
> 		WARN();
> 		return "LINUX";
> 	}
> }
> 
> This avoids the caller having to specify the name explicitly, but only
> works if all the n_type values are unique for the note types that Linux
> knows about (currently true).
> 
> Experimenting with this shows that GCC 11.4.0 (for example) doesn't do
> a very good job with this switch, though, and it requires building
> knowledge about irrelevant arch-specific note types into every kernel.
> I think that extending struct user_regset is probably the better
> approach -- though other people may disagree.
> 
> Cheers
> ---Dave

