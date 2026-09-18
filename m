Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161363AE6E6;
	Fri, 18 Sep 2026 20:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789762278; cv=none; b=r6RmRBF2IdrRuizvzc3IaDvjdTPu9+1W+Bt7GhjXMJRk1kL5A9fUUbqUAsjveDo8noMkYq7tc7FE0Hs3UoCYVXhTgtrXJR/cSe3/kBCBd/DzDx9XNUCpwNcKq7eyBNkxFOY8ue3sw8jALng3H6r+RONy1TWe0Uf3EW34c/CfVDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789762278; c=relaxed/simple;
	bh=A74UHZ/H680cd+7x9l+p9oF2r9lADuMuT5YtM1Klt4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CfYy+PRJt+oVVDJKXdURneCb4YAg30z07r5oTXlvG0bOuMqF/1tQW2ZPSxNlGG+wFW+oql1aUfTtHNkHUwdxvFqzg/kNqP/xny945EO6izenkvbWJskiVvXRdEe8BVG/vVrUfiv+RuGjVC1NUAXL8hLaNuczf1ZPXkLV44C8wz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=XyQWnNp/; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="XyQWnNp/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=KndHA8Fg8PGGhxgGB/nvI09JTenc+zETXOyEGocxMv8=; b=XyQWnNp/GpmK3Gevj1BLk6XeOD
	q6WiVOnxx+QG61IA8LQBELDkks4zJkuioqrdBaX/yddr7NF6HYTkHLBfuxZcz90FcSfa/Xd0NYfJj
	FQJoFaYxhWz7sbLGJwVBmWdL94thDKPNWPSp72nqgJICAMJnP5kHfsLbqFU+eBE2n+O+g5lBNuJjI
	P/CAZUjIW0f2c9W9F1OUjLzQmkASjmKjgvt1lLPs/0GkTaBdx71wVyV+8EiHwuXFqkOWWEg5SLKdp
	rOUyi5JEkurTLT2P+K3Twir0wmqc0wCvzfN18L9fIRa75+9NIVf2388nG4yYL31WNUnF4qzC5a5XB
	RfsGXJMQ==;
Received: from [177.172.123.214] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1x7evL-0046up-OM; Fri, 18 Sep 2026 22:11:07 +0200
Message-ID: <a2627927-7526-40b7-8464-fecb0e04ecad@igalia.com>
Date: Fri, 18 Sep 2026 17:11:06 -0300
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/13] alpha: Remove alpha_ prefix from custom syscall
 entries
To: Magnus Lindholm <linmag7@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Arnd Bergmanon <arnd@arndb.de>,
 Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, kernel-dev@igalia.com,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 linux-alpha@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev,
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org
References: <20260917-tonyk-syscall_table-v7-0-f4cd8f8e3265@igalia.com>
 <20260917-tonyk-syscall_table-v7-12-f4cd8f8e3265@igalia.com>
 <CA+=Fv5Q+sOLmT0Wf3OGdKw=mBt_EoS8ZQDF3wwGrm2-2vnOYgg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <CA+=Fv5Q+sOLmT0Wf3OGdKw=mBt_EoS8ZQDF3wwGrm2-2vnOYgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 18/09/2026 07:54, Magnus Lindholm escreveu:
> Hi André,
> 
> On Fri, Sep 18, 2026 at 1:48 AM André Almeida <andrealmeid@igalia.com> wrote:
>>
>> Some architectures need special entry points for some syscalls (like
>> clone3). The current approach is, instead of having a special name like
>> arch_syscall, to name if as __syscall. This is enough to different the
>> common entry point to the architecture specific entry point.
>>
>> Change alpha special syscall entries to do the same. This makes easier to
>> join the syscall tables. Leave alpha_syscall_zero because this syscall only
>> exists in alpha anyway.
>>
>> Signed-off-by: André Almeida <andrealmeid@igalia.com>
>> ---
>>   arch/alpha/kernel/entry.S              | 8 ++++----
>>   arch/alpha/kernel/syscalls/syscall.tbl | 8 ++++----
>>   2 files changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/alpha/kernel/entry.S b/arch/alpha/kernel/entry.S
>> index 9f2608de2544..8a85fcf117cb 100644
>> --- a/arch/alpha/kernel/entry.S
>> +++ b/arch/alpha/kernel/entry.S
>> @@ -879,9 +879,9 @@ ret_from_kernel_thread:
>>
>>   .macro fork_like name
>>          .align  4
>> -       .globl  alpha_\name
>> -       .ent    alpha_\name
>> -alpha_\name:
>> +       .globl  __sys_\name
>> +       .ent    __sys_\name
>> +__sys_\name:
>>          .prologue 0
>>          bsr     $1, do_switch_stack
>>          // NB: if anyone adds preemption, this block will need to be protected
>> @@ -896,7 +896,7 @@ alpha_\name:
>>          ldq     $26, 56($sp)
>>          lda     $sp, SWITCH_STACK_SIZE($sp)
>>          ret
>> -.end   alpha_\name
>> +.end   __sys_\name
>>   .endm
>>
>>   fork_like fork
>> diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
>> index 8fc4701a6328..a41276634923 100644
>> --- a/arch/alpha/kernel/syscalls/syscall.tbl
>> +++ b/arch/alpha/kernel/syscalls/syscall.tbl
>> @@ -9,7 +9,7 @@
>>   #
>>   0      common  osf_syscall                     alpha_syscall_zero
>>   1      common  exit                            sys_exit
>> -2      common  fork                            alpha_fork
>> +2      common  fork                            __sys_fork
>>   3      common  read                            sys_read
>>   4      common  write                           sys_write
>>   5      common  osf_old_open                    sys_ni_syscall
>> @@ -72,7 +72,7 @@
>>   63     common  getpgrp                         sys_getpgrp
>>   64     common  getpagesize                     sys_getpagesize
>>   65     common  osf_mremap                      sys_ni_syscall
>> -66     common  vfork                           alpha_vfork
>> +66     common  vfork                           __sys_vfork
>>   67     common  stat                            sys_newstat
>>   68     common  lstat                           sys_newlstat
>>   69     common  osf_sbrk                        sys_ni_syscall
>> @@ -242,7 +242,7 @@
>>   309    common  get_kernel_syms                 sys_ni_syscall
>>   310    common  syslog                          sys_syslog
>>   311    common  reboot                          sys_reboot
>> -312    common  clone                           alpha_clone
>> +312    common  clone                           __sys_clone
>>   313    common  uselib                          sys_uselib
>>   314    common  mlock                           sys_mlock
>>   315    common  munlock                         sys_munlock
>> @@ -474,7 +474,7 @@
>>   542    common  fsmount                         sys_fsmount
>>   543    common  fspick                          sys_fspick
>>   544    common  pidfd_open                      sys_pidfd_open
>> -545    common  clone3                          alpha_clone3
>> +545    common  clone3                          __clone3
>>   546    common  close_range                     sys_close_range
>>   547    common  openat2                         sys_openat2
>>   548    common  pidfd_getfd                     sys_pidfd_getfd
>>
>> --
>> 2.55.0
>>
>>
> 
> The fork_like macro now defines __sys_clone3, but the syscall table
> entry is changed from alpha_clone3 to __clone3.
> 
> This should be __sys_clone3, like the other custom entry points.
> 
> I also confirmed this by building the tree at this patch, before applying
> patch 13:
> 
> LD      .tmp_vmlinux1
> alpha-unknown-linux-gnu-ld: arch/alpha/kernel/systbls.o:
> in function `sys_call_table':
> (.data+0x1108): undefined reference to `__clone3'
> 
> Patch 13 hides the issue because the common table uses __clone3 as the
> ABI tag but correctly selects __sys_clone3 as the syscall entry point.
Thank you very much for testing this work! I've applied a fix for this 
for the next version.
