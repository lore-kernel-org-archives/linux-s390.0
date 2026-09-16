Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82574A49B3;
	Wed, 16 Sep 2026 22:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789597197; cv=none; b=WozMF5NyCK9+jGNW3Qot3gt+mzrGWFi6IjeGqRwHaJHvNkkRHF+bE2NetHSpiZ8Y5X+5NjLHzViKhYSW5x9t/6yNKULP+JBpmZMCf/inih6iQsxI3+QOqx2XHcp7IecFz/RohmLvOemK31Ik0S9ZW23naafYZJWQ4AUphqgHPPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789597197; c=relaxed/simple;
	bh=PgYamMXCdi4VRyBf5DPb5l7tFDhJvPaxGoqF/5mIgS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tDhpMCp1CnXxoRLuHEWZY6UE2/mTB+65yL71c+Bo/DrvsFMnr4wu49lKfMtcTLsf3iaTAlzlnsotJYtl9R0PeRS/0lh6sgNCTSYNS8npejHZIbSMhbbVenso/Nq2ej55r1ZCczVKcZjSBMU8h7etA0bVNel51ZzN4mecDWMnvfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=FJ1GGUUq; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="FJ1GGUUq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=0jjaJqT+4yE26s3Gd2hr+zhg3vtd5fJJJh6Wg8rfPjg=; b=FJ1GGUUqC8SfggqGAFpM/dbaxC
	/6H9VEZaA7bVJZaF6Sg2vwo3NrVxh/g1JW0sKYJhxcuTnL/RXl43YgNKSRU/Jv12SMgzzJSKtji/p
	6E4O7hjbQPZ5Z/N3+N8dm/KYVyniukxbdWoj5z1gxViAVdzFiARjH0cDQ+XJ1mpYL/BOp3p0oiFMt
	v0bo5+CTx4t3QxIf+MCt1cGnhjPfYAf7SA9kuKysxpkdk9vIHJvhl6mFUmTIwgDsh9O511Wuh50cq
	vIG7Th5Vb/AeoCHTywm65bN4JdacomMltdgJfEpPL4xKm8tigNPoevpDdSQ/ypuIo3q79vjqvZYpF
	Bls852nQ==;
Received: from [177.172.123.214] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1x6xyb-0039Hm-2L; Thu, 17 Sep 2026 00:19:37 +0200
Message-ID: <6fa4e1e3-c023-465c-9490-ce2f18ffaa91@igalia.com>
Date: Wed, 16 Sep 2026 19:19:36 -0300
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/13] syscalls: Add a shared table for all archs
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, kernel-dev@igalia.com,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 linux-alpha@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev,
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org
References: <20260828-tonyk-syscall_table-v6-0-fdd358456cf1@igalia.com>
 <95b693c0-ca51-4355-99ba-2b37a1ab2169@app.fastmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <95b693c0-ca51-4355-99ba-2b37a1ab2169@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 15/09/2026 04:45, Arnd Bergmann escreveu:
> On Sat, Aug 29, 2026, at 01:19, André Almeida wrote:
>> While implementing a new syscall, we need to wire up it's number to the arch
>> table. Since syscall number 403, all architectures are on sync regarding the
>> number (except alpha), which make things a lot easier but more repetitive as
>> well. Have a look at commit b36d4b6aa88 ("arch: hookup listns() system call"),
>> with 15 lines of mostly:
>>
>>    +470    common  listns                          sys_listns
>>
>> There's already a "common" table shared with a bunch of archs at
>> `scripts/syscall.tbl`, but due to historical reasons some archs will never be
>> able to move to this table and share all the numbers.
>>
>> The generic table starts from 403 (clock_gettime64), the first common syscall.
>>
>> I've compile tested for arm32, arm64, s390, mips, sparc and alpha by comparing
>> the syscalls_*.h and unistd_*.h files generated before and after this patchset.
>> For most of cases the files are identical, for the few cases that they are not,
>> there's a note in the commit explaining why they are equivalent.
> 
> I've tried merging these for the asm-generic tree now, and would like to
> send them for 7.4.
> 
> Unfortunately, the build bot flagged problems on mips, see the patch below
> for my workarounds=, but I think we have to improve that still and didn't
> just fold it into your patch.
> 
> As you took out the dependencies on the syscall_*.tbl files, the
> output does not get rebuilt if changes are made to the table, and I
> have not come up with a good solution for mips. My hack just adds both
> input files to all outputs, which works but is not technically correct.
> 

Thanks for testing! I believe I found a simple solution for this. I 
modified syscall_o32.tbl and can confirm it triggers a rebuild now:

diff --git a/arch/mips/kernel/syscalls/Makefile 
b/arch/mips/kernel/syscalls/Makefile
index aaa5443ea906..9e31d1ce5015 100644
--- a/arch/mips/kernel/syscalls/Makefile
+++ b/arch/mips/kernel/syscalls/Makefile
@@ -40,10 +40,10 @@ src_n32 := $(src)/syscall_n.tbl
  src_n64 := $(src)/syscall_n.tbl
  src_o32 := $(src)/syscall_o32.tbl

-$(kapi)/unistd_nr_%.h: $(systbl_common) $(sysnr) FORCE
+$(kapi)/unistd_nr_%.h: $(systbl_common) $(src_%) $(sysnr) FORCE
         $(call if_changed,sysnr)

-$(kapi)/syscall_table_%.h: $(systbl) $(systbl_common) FORCE
+$(kapi)/syscall_table_%.h: $(systbl) $(systbl_common) $(src_%) FORCE
         $(call if_changed,systbl)

  uapisyshdr-y           += unistd_n32.h                 \

> The rt_sigtimedwait and ustat entries had a typo that caused a link
> error, but I did not check if there were any additional mistakes that
> caused incorrect output data without causing a link failure.
> 

Ops, my bad. I had another round comparing the tables, and I found 
another case that needed a fix:

diff --git a/arch/mips/kernel/syscalls/syscall_n.tbl 
b/arch/mips/kernel/syscalls/syscall_n.tbl
index e3d278f715b7..1882527053af 100644
--- a/arch/mips/kernel/syscalls/syscall_n.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n.tbl
@@ -43,7 +43,7 @@
  33     common  pause                           sys_pause
  34     common  nanosleep                       sys_nanosleep 
sys_nanosleep_time32
  35     common  getitimer                       sys_getitimer 
compat_sys_getitimer
-36     common  setitimer                       sys_setitimer 
compat_setitimer
+36     common  setitimer                       sys_setitimer 
compat_sys_setitimer
  37     common  alarm                           sys_alarm
  38     common  getpid                          sys_getpid
  39     common  sendfile                        sys_sendfile64 
compat_sys_sendfile

Let me know if both diffs look good to you, and then I can send a v7.

Thanks!

>         Arnd
> 
> diff --git a/arch/mips/kernel/syscalls/Makefile b/arch/mips/kernel/syscalls/Makefile
> index aaa5443ea906..51b9939ecff0 100644
> --- a/arch/mips/kernel/syscalls/Makefile
> +++ b/arch/mips/kernel/syscalls/Makefile
> @@ -40,10 +40,10 @@ src_n32 := $(src)/syscall_n.tbl
>   src_n64 := $(src)/syscall_n.tbl
>   src_o32 := $(src)/syscall_o32.tbl
>   
> -$(kapi)/unistd_nr_%.h: $(systbl_common) $(sysnr) FORCE
> +$(kapi)/unistd_nr_%.h: $(src_o32) $(src_n64) $(systbl_common) $(sysnr) FORCE
>          $(call if_changed,sysnr)
>   
> -$(kapi)/syscall_table_%.h: $(systbl) $(systbl_common) FORCE
> +$(kapi)/syscall_table_%.h: $(src_o32) $(src_n64) $(systbl) $(systbl_common) FORCE
>          $(call if_changed,systbl)
>   
>   uapisyshdr-y           += unistd_n32.h                 \
> diff --git a/arch/mips/kernel/syscalls/syscall_n.tbl b/arch/mips/kernel/syscalls/syscall_n.tbl
> index e3d278f715b7..84c35c1f0c3e 100644
> --- a/arch/mips/kernel/syscalls/syscall_n.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n.tbl
> @@ -133,14 +133,14 @@
>   123    common  capget                          sys_capget
>   124    common  capset                          sys_capset
>   125    common  rt_sigpending                   sys_rt_sigpending       compat_sys_rt_sigpending
> -126    common  rt_sigtimedwait                 sys_rt_sigtimedwait_time        compat_sys_rt_sigtimedwait_time32
> +126    common  rt_sigtimedwait                 sys_rt_sigtimedwait     compat_sys_rt_sigtimedwait_time32
>   127    common  rt_sigqueueinfo                 sys_rt_sigqueueinfo     compat_sys_rt_sigqueueinfo
>   128    common  rt_sigsuspend                   sys_rt_sigsuspend       compat_sys_rt_sigsuspend
>   129    common  sigaltstack                     sys_sigaltstack         compat_sys_sigaltstack
>   130    common  utime                           sys_utime               sys_utime32
>   131    common  mknod                           sys_mknod
>   132    common  personality                     sys_personality         sys_32_personality
> -133    common  ustat                           sys_usta                compat_sys_usta
> +133    common  ustat                           sys_ustat               compat_sys_ustat
>   134    common  statfs                          sys_statfs              compat_sys_statfs
>   135    common  fstatfs                         sys_fstatfs             compat_sys_fstatfs
>   136    common  sysfs                           sys_sysfs

