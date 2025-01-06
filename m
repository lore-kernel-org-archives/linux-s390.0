Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3018617E0
	for <linux-s390@vger.kernel.org>; Mon,  6 Jan 2025 05:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736140079; cv=none; b=aXmtJld7C5mSyfW7NbtLyJWnL4a1J8Jyi9Ti7+MooF63irxdjibns+csQa6D/XJmr+7j9H66zok+O7azWyFi5juciTEjYT4QOYs0kHqSyINkIlSzWLblIFdm4uWhdMrRO0ey7S3YTfioYk8OamyVvB4HpmbjQmVt3HcIHHOKQ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736140079; c=relaxed/simple;
	bh=blhIGNloNLsFDpwhkBW+XtwhtdlDgMDwe0vXGOqOmsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VmSq3OI0Ogg/rM3iX2ny0K7yYPkuC+cFdR9o6i3MxBxaZGm0lV1cEaJU43jXZFLNRdUY/bQFN1UtEzaKmd26a+E5xgtrj/oh0yd50GhgQeGBqkECU/ZWpqIazAWUE9gZpc6SuPj0EAgtKIZwAjB26Lhuqbe5rkCvqHYUdpJBywk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=R4FsrfUo; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="R4FsrfUo"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21654fdd5daso184685335ad.1
        for <linux-s390@vger.kernel.org>; Sun, 05 Jan 2025 21:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736140077; x=1736744877; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LuPI2QoCWSGABhNaHmyyQbTaoQ2qivKcvMjG9VSzHt4=;
        b=R4FsrfUoGQuqZPFk53P2ki+smTKfQXhFntjCps/DGPTm/mh4XdpVdePnrEBAyMLa/i
         mlRPwcduqYysRGCram3ELBIAo9i0f4C65HCEXhH1/UGmNg7KYhCfW5auCJL7IaeCWurq
         iHNzLINTre0zFwTFq1odEKrKrcg7tcWrnoqBY3l69mA4l+jL6W8JeKBo3p8k7c6Lw9MX
         uMbBehTADtNpiS2QoOfo9L+tcOA65xkBY7m7b1hIlEKsi2Dq76ZkWOruKTqm7QuyClBz
         sj7F1vgdoCNRfC902Nf+l88L4nV/2YvV+vB5eML2eyhMBRbSLkNjtv05NRh/jKBFjcGK
         SQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736140077; x=1736744877;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LuPI2QoCWSGABhNaHmyyQbTaoQ2qivKcvMjG9VSzHt4=;
        b=jQIONT//btM0hwQVQAiNbpgyv/UrV5gi8NpkyNA+VPYF5OVRgt8tnoBXt8gWgAwA0S
         lsRZhQrmVfDazo7fID3pe9fflgjDpaoEd6as2/n2XwUap4k2Fhw4GrpY9Dps9nuPCnIC
         ouFQnmuzWZM8s+VFJxZCZ+Zx1U1wtFLkCJazzYHqbk+TKFSZl6Fv13d097qpu/r2RhuC
         XM8QyKkvDk8LvFx5Da0/PVGtWC996J3Z9DyD4EoLdxtX30qvMVGrcQR1BH+gw3ER+W1r
         LEAShu6NEHMdeHG1L9UsZpByk1r+7RvLGJzgz5eO7u6tPZ5/wsbhREeHvwEaEHFcjCE3
         4kiw==
X-Forwarded-Encrypted: i=1; AJvYcCXX43phhm3fXsHE3wOtDzxomYsJmAIh4VTZ3ni2zSkBYMd3E1/9lz75aURf9GN5UqQoWO4p8MlknHxJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwcWnUTwd9U/phNoCgogl0mSWRk/Jh0yQrvo6xV/b0BY3b9k91E
	wM8OZtNmbORWsZqFYAYSdbw46cRXCWjGdc/+bcYuPTyhVj1EKVFmTzVUOJK2KoA=
X-Gm-Gg: ASbGncuOtRt2Z4iBWMjgYSa+q2U1vxcBUVhmPSDwx+CpJQoPdTsuNVJbAsXNSFqCwrg
	+Fw82yR/AGL0pWVOjqwxgeTp8EuT2ZSdzac3v7zg6JHKOvDrNsSM9d3twsuuHq5iq27R1S9GxZW
	H4/kbYTtS4wFvzZYRWlruBm/lHFtilgVfiTz8RaWWwIMF6/HXp6s4Zr+z4iqwWQIktOIWuawLyh
	W81FzBxaLThlrg4Elub7uoJkBoF/yPD17RTTJIHL4fwWdWe49WwhDxhQRWTOTby
X-Google-Smtp-Source: AGHT+IHO9h+H3nQtpCAylHi4N1tDhCEXwfFp2Ug4YvZcEwI3J7mIrB866g5t/GIXJEMR5ZJQFBtNMg==
X-Received: by 2002:a17:903:1209:b0:216:36ff:ba33 with SMTP id d9443c01a7336-219e6ebcfc7mr750060565ad.26.1736140077545;
        Sun, 05 Jan 2025 21:07:57 -0800 (PST)
Received: from [10.100.1.231] ([157.82.128.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc96e94dsm285208985ad.67.2025.01.05.21.07.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jan 2025 21:07:57 -0800 (PST)
Message-ID: <70daf544-f59f-404b-bec0-0d60e892a9e9@daynix.com>
Date: Mon, 6 Jan 2025 14:07:47 +0900
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] elf: Define note name macros
To: Baoquan He <bhe@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>,
 Dave Martin <Dave.Martin@arm.com>, Vivek Goyal <vgoyal@redhat.com>,
 Dave Young <dyoung@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, kexec@lists.infradead.org, devel@daynix.com
References: <20250104-elf-v2-0-77dc2e06db4e@daynix.com>
 <20250104-elf-v2-1-77dc2e06db4e@daynix.com> <Z3s+QeMv8AaGbMGs@MiWiFi-R3L-srv>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <Z3s+QeMv8AaGbMGs@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/01/06 11:21, Baoquan He wrote:
> On 01/04/25 at 11:38pm, Akihiko Odaki wrote:
>> elf.h had a comment saying:
>>> Notes used in ET_CORE. Architectures export some of the arch register
>>> sets using the corresponding note types via the PTRACE_GETREGSET and
>>> PTRACE_SETREGSET requests.
>>> The note name for these types is "LINUX", except NT_PRFPREG that is
>>> named "CORE".
>>
>> However, NT_PRSTATUS is also named "CORE". It is also unclear what
>> "these types" refers to.
>>
>> To fix these problems, define a name for each note type. The added
>> definitions are macros so the kernel and userspace can directly refer to
>> them.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   include/uapi/linux/elf.h | 86 ++++++++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 83 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
>> index b44069d29cec..014b705b97d7 100644
>> --- a/include/uapi/linux/elf.h
>> +++ b/include/uapi/linux/elf.h
>> @@ -372,8 +372,6 @@ typedef struct elf64_shdr {
>>    * Notes used in ET_CORE. Architectures export some of the arch register sets
>>    * using the corresponding note types via the PTRACE_GETREGSET and
>>    * PTRACE_SETREGSET requests.
>> - * The note name for these types is "LINUX", except NT_PRFPREG that is named
>> - * "CORE".
>>    */
>>   #define NT_PRSTATUS	1
>>   #define NT_PRFPREG	2
>> @@ -460,9 +458,91 @@ typedef struct elf64_shdr {
>>   #define NT_LOONGARCH_HW_BREAK	0xa05   /* LoongArch hardware breakpoint registers */
>>   #define NT_LOONGARCH_HW_WATCH	0xa06   /* LoongArch hardware watchpoint registers */
>>   
>> -/* Note types with note name "GNU" */
>> +/* Note used in ET_EXEC and ET_DYN. */
>>   #define NT_GNU_PROPERTY_TYPE_0	5
>>   
>> +/* Note names */
>> +#define NN_PRSTATUS	"CORE"
>> +#define NN_PRFPREG	"CORE"
>> +#define NN_PRPSINFO	"CORE"
>> +#define NN_TASKSTRUCT	"CORE"
>> +#define NN_AUXV	"CORE"
>> +#define NN_SIGINFO	"CORE"
>> +#define NN_FILE	"CORE"
>> +#define NN_PRXFPREG	"LINUX"
> 
> No objection to make them clearer. Thanks for the effort.
> 
> Wondering where below arch specific macros are used. So you just
> added all NN_xxx for the corresponding NT_xxx? Not sure if this is
> needed if we don't use them at all in the current kernel.

Indeed I just added all NN_xxx. The kernel won't use the macros that are 
defined as "LINUX"; fs/binfmt_elf.c uses "LINUX" by default as the notes 
named "CORE" or "GNU" are exceptional.

Userspace applications may still be interested in these macros as 
demonstrated in:
https://lore.kernel.org/r/Z3f7zJwu8bu8HYln@e133380.arm.com

These macros also serve as documentation; correcting and clarifying the 
documentation is the main purpose of this series.

> 
>> +#define NN_PPC_VMX	"LINUX"
>> +#define NN_PPC_SPE	"LINUX"
>> +#define NN_PPC_VSX	"LINUX"
>> +#define NN_PPC_TAR	"LINUX"
>> +#define NN_PPC_PPR	"LINUX"
>> +#define NN_PPC_DSCR	"LINUX"
>> +#define NN_PPC_EBB	"LINUX"
>> +#define NN_PPC_PMU	"LINUX"
>> +#define NN_PPC_TM_CGPR	"LINUX"
>> +#define NN_PPC_TM_CFPR	"LINUX"
>> +#define NN_PPC_TM_CVMX	"LINUX"
>> +#define NN_PPC_TM_CVSX	"LINUX"
>> +#define NN_PPC_TM_SPR	"LINUX"
>> +#define NN_PPC_TM_CTAR	"LINUX"
>> +#define NN_PPC_TM_CPPR	"LINUX"
>> +#define NN_PPC_TM_CDSCR	"LINUX"
>> +#define NN_PPC_PKEY	"LINUX"
>> +#define NN_PPC_DEXCR	"LINUX"
>> +#define NN_PPC_HASHKEYR	"LINUX"
>> +#define NN_386_TLS	"LINUX"
>> +#define NN_386_IOPERM	"LINUX"
>> +#define NN_X86_XSTATE	"LINUX"
>> +#define NN_X86_SHSTK	"LINUX"
>> +#define NN_X86_XSAVE_LAYOUT	"LINUX"
>> +#define NN_S390_HIGH_GPRS	"LINUX"
>> +#define NN_S390_TIMER	"LINUX"
>> +#define NN_S390_TODCMP	"LINUX"
>> +#define NN_S390_TODPREG	"LINUX"
>> +#define NN_S390_CTRS	"LINUX"
>> +#define NN_S390_PREFIX	"LINUX"
>> +#define NN_S390_LAST_BREAK	"LINUX"
>> +#define NN_S390_SYSTEM_CALL	"LINUX"
>> +#define NN_S390_TDB	"LINUX"
>> +#define NN_S390_VXRS_LOW	"LINUX"
>> +#define NN_S390_VXRS_HIGH	"LINUX"
>> +#define NN_S390_GS_CB	"LINUX"
>> +#define NN_S390_GS_BC	"LINUX"
>> +#define NN_S390_RI_CB	"LINUX"
>> +#define NN_S390_PV_CPU_DATA	"LINUX"
>> +#define NN_ARM_VFP	"LINUX"
>> +#define NN_ARM_TLS	"LINUX"
>> +#define NN_ARM_HW_BREAK	"LINUX"
>> +#define NN_ARM_HW_WATCH	"LINUX"
>> +#define NN_ARM_SYSTEM_CALL	"LINUX"
>> +#define NN_ARM_SVE	"LINUX"
>> +#define NN_ARM_PAC_MASK	"LINUX"
>> +#define NN_ARM_PACA_KEYS	"LINUX"
>> +#define NN_ARM_PACG_KEYS	"LINUX"
>> +#define NN_ARM_TAGGED_ADDR_CTRL	"LINUX"
>> +#define NN_ARM_PAC_ENABLED_KEYS	"LINUX"
>> +#define NN_ARM_SSVE	"LINUX"
>> +#define NN_ARM_ZA	"LINUX"
>> +#define NN_ARM_ZT	"LINUX"
>> +#define NN_ARM_FPMR	"LINUX"
>> +#define NN_ARM_POE	"LINUX"
>> +#define NN_ARM_GCS	"LINUX"
>> +#define NN_ARC_V2	"LINUX"
>> +#define NN_VMCOREDD	"LINUX"
>> +#define NN_MIPS_DSP	"LINUX"
>> +#define NN_MIPS_FP_MODE	"LINUX"
>> +#define NN_MIPS_MSA	"LINUX"
>> +#define NN_RISCV_CSR	"LINUX"
>> +#define NN_RISCV_VECTOR	"LINUX"
>> +#define NN_RISCV_TAGGED_ADDR_CTRL	"LINUX"
>> +#define NN_LOONGARCH_CPUCFG	"LINUX"
>> +#define NN_LOONGARCH_CSR	"LINUX"
>> +#define NN_LOONGARCH_LSX	"LINUX"
>> +#define NN_LOONGARCH_LASX	"LINUX"
>> +#define NN_LOONGARCH_LBT	"LINUX"
>> +#define NN_LOONGARCH_HW_BREAK	"LINUX"
>> +#define NN_LOONGARCH_HW_WATCH	"LINUX"
>> +#define NN_GNU_PROPERTY_TYPE_0	"GNU"
>> +
>>   /* Note header in a PT_NOTE section */
>>   typedef struct elf32_note {
>>     Elf32_Word	n_namesz;	/* Name size */
>>
>> -- 
>> 2.47.1
>>
> 

