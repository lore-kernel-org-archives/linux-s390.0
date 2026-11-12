Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794496381;
	b=hCcRdMxJ6xykwRuMxNv6LKiq1jMh5d4mUAc8z1/J9FUPOt+8MOBylb1KjhzSejCW3W/u
	 4qh4L2m0KlR3dDTeQOtESIoLaWXcHdvkJlqzAlvJbIG3yslze1VhESLj7ZSoO8as4Ks06
	 OkIrkQT9E5xmTz9pub//zbUgFkvZkkQVK5dTzl7Fc+yagg/zvv7ODpQ0gyIWbnCMH4AIy
	 7xwEaOxB9qCEB7y2iB8zhpQWrdvjEdEMJAyx0PzoYhOaTbIKy3phjRw7RRVeDqKuDgk6h
	 qQsu7G8uvmToyBK/C5ZFaihjmAHiWB/nI+Tj1BItSvk6TMQPFpgeY+I+hiXYvYDaGUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794496381;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=E/hBOzfT4wg2MIZkxfi2jfD1+u36ne/xi/GPYW2g2ew=;
	b=O+lWordTO7k4Yjqbzumyi0QYXZTj7VHP5qyL3SnZppFvGZeN2ecyf8WIVNhAs5JbsUE2
	 UXqoBK0f8yreKKHi3ALr61cGc5u4b+oHINQ4+tBRMem4j4hk073HsldwCL45x2yCAcSjy
	 xIZkidzuDmLe7X9ZyfSUtXD8DzX6U/FgwEryEw5jt/fa3sBuhRWxwd4HipS3Mk+kDzvmj
	 axbfcHIU9DZZLPg4o3yXm9DAsWTh+wSGJEl7jHP5Fs6m3OLj8XF8XcICh/yFfbV2pDbcB
	 AuMuYduEQLGnnLRNoqdAq0jPtcM0cyuwmwwbVW8G7zgE4F6GekcN97HvsrCQjSykYjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=Tm5lVcJy;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA40E606A31C;
	Thu, 12 Nov 2026 15:13:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA40E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=Tm5lVcJy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=E/hBOzfT4wg2MIZkxfi2jfD1+u36ne/xi/GPYW2g2ew=; t=1794496380; x=2109856380; 
	b=Tm5lVcJy2yjAlJLF7cCDI9HLnUCKakQ45IVd8lVeJ5sQe4kk/YUm6A54k32KsUe832Gy6lujDmJ
	/v7yifF22VGNWnDwxSvuqJsexK8e6W9NO/XtrpDj/NheM29lCH5ZmBTLz+WbQX1uN5b09d2tOceps
	vI4HBnJdD8R4kIJ5dQhJnY7lLS+LSd6Wz4aH9WGIDSIJ4eN9wkX2sJ1hR+3YbOMhVpPFUhXn4GASK
	LYoBvrp41KXxrBePk2+eHwa6C6Ra13Md2ism0uD2EtGBcDV8WEJimMvcbeC5NygSpFuJe39sevnZU
	+zdVi1SYPfWx+vSwgzb0ERWkHAo7FVh82qNQ==;
Received: from [177.172.124.218] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1xRWTu-009bF1-QY; Thu, 12 Nov 2026 16:12:55 +0100
Message-ID: <f0399f4d-ce4d-4b52-a280-affaf2ea8bd8@igalia.com>
Date: Thu, 12 Nov 2026 12:13:01 -0300
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 11/15] alpha: Remove alpha_ prefix from custom syscall
 entries
To: Magnus Lindholm <linmag7@gmail.com>, Arnd Bergmanon <arnd@arndb.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, kernel-dev@igalia.com,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 linux-alpha@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev,
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org
References: <20261105-tonyk-syscall_table-v9-0-8d1275885d9c@igalia.com>
 <20261105-tonyk-syscall_table-v9-11-8d1275885d9c@igalia.com>
 <CA+=Fv5Tm4-DV9KEKxO11ta84EvqigB-KDemhOML1hx9zoxx0cA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <CA+=Fv5Tm4-DV9KEKxO11ta84EvqigB-KDemhOML1hx9zoxx0cA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 11/11/2026 04:43, Magnus Lindholm escreveu:
> Hi André
> 
> On Thu, Nov 5, 2026 at 9:26 PM André Almeida <andrealmeid@igalia.com> wrote:
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
>> Changes from v7:
>> - Fix __clone3 entry
>> ---
>>   arch/alpha/kernel/entry.S              | 8 ++++----
>>   arch/alpha/kernel/syscalls/syscall.tbl | 8 ++++----
>>   2 files changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/alpha/kernel/entry.S b/arch/alpha/kernel/entry.S
>> index 790389a15c3c..25d05f45512d 100644
>> --- a/arch/alpha/kernel/entry.S
>> +++ b/arch/alpha/kernel/entry.S
>> @@ -729,9 +729,9 @@ ret_from_kernel_thread:
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
>> @@ -746,7 +746,7 @@ alpha_\name:
>>          ldq     $26, 56($sp)
>>          lda     $sp, SWITCH_STACK_SIZE($sp)
>>          ret
>> -.end   alpha_\name
>> +.end   __sys_\name
>>   .endm
>>
>>   fork_like fork
>> diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
>> index 8fc4701a6328..59eb066a40bf 100644
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
>> +545    common  clone3                          __sys__clone3
>>   546    common  close_range                     sys_close_range
>>   547    common  openat2                         sys_openat2
>>   548    common  pidfd_getfd                     sys_pidfd_getfd
>>
>> --
>> 2.56.0
>>
>>
> 
> This conflicts with my Alpha for-next:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/lindholm/alpha.git
>    branch: for-next
> 
> Commit d38895ba9330 ("alpha: dispatch system calls from C") removes
> the fork_like assembly wrappers and changes the table entries to
> sys_fork, sys_vfork, sys_clone and sys_clone3.
> 

Thanks for the review and testing! I will make my work depend on this 
commit then, I believe is the easiest way forward here.

> Consequently, this rename is no longer needed when integrating your
> series on top of that branch. I skipped this patch for my integration
> test and retained those existing entries.
> 
> My for-next is registered with linux-next, so this is an interaction
> we should account for when the trees are combined.
> 
> Thanks,
> Magnus

