Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8B34ED18E;
	Thu, 17 Sep 2026 21:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789680258; cv=none; b=sdlTcSkxnB8eeHFAGnUDpA+uAP8YF2d/6bvhVOij32EWgtjC8nfr7gkAPGw/5yyWS+SDFUHc74iikhpYiXiaOdviuGo/RNML398T2V5a+TKf3BOIZYdXolbVFk1Z53LORWhp1x5eWSufVzfwF4qeDShLCBEet27eAzAaik8b3aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789680258; c=relaxed/simple;
	bh=sSbcXjG5M7vBTEb7+nYI+22U+3VbmgzgG4sDQ38deqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R4Gq/+BHm0/XuqDxPEwvQpjXPKDquRwvvfLzg1pAVfhjahhhM1780DtHFwkp8FMELLbjCQXwyrXJSfy/Ab0n4JWAHFn2w7RP+5Ww1te1tqtFNkaI1tqA9x6H43+mg7bhHaERB4vpWQxb1nWd/BNZsDgnCaQFiVfoLEamVztGOrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=QuaBpeD6; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="QuaBpeD6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=RpWZdNHGYoV/6JCrVSKz8y6ytrZaFDnDxpAF1ip5BB0=; b=QuaBpeD6kNNs0NDL9br7Pv641+
	S1LZkytpjjX4zFGy6uQJmiFf53WqKEvJggJM9Fz0Vq+36RY9zXW2NWJYzHj9ZsLpqrZzVsDpXSdH1
	M+Towaj8mtbiLL0+vdO+FPmik3ZcIlfAnZgL7q5EH6726fbDQzmwrXoqMVI74blt8dUCv+Q57ZrPu
	4rcOwFBifSgHEfGQBKnGUDoZkjRL+BzXacQkSVMcZt0c+NBXHDgc8ssJdA/fkQk8/Il9NawvtfShs
	skfT8YFqmyOHLPBUHWRjguGnj7o8mYbFPSgnxL/4n0D9BFLG0mqU22x9Wb05mUh/0j21YtbvNsIRH
	J3LnpKUg==;
Received: from [177.172.123.214] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1x7JaO-003erL-DT; Thu, 17 Sep 2026 23:24:04 +0200
Message-ID: <e553953e-d784-4eb5-b3fc-6e847b2dfcd1@igalia.com>
Date: Thu, 17 Sep 2026 18:24:02 -0300
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
 <6fa4e1e3-c023-465c-9490-ce2f18ffaa91@igalia.com>
 <5aedf90f-d30d-4f55-b066-dd8fdf3ff8f9@app.fastmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <5aedf90f-d30d-4f55-b066-dd8fdf3ff8f9@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 17/09/2026 02:55, Arnd Bergmann escreveu:
> On Thu, Sep 17, 2026, at 00:19, André Almeida wrote:
>> Em 15/09/2026 04:45, Arnd Bergmann escreveu:
>>> On Sat, Aug 29, 2026, at 01:19, André Almeida wrote:
>>
>> Thanks for testing! I believe I found a simple solution for this. I
>> modified syscall_o32.tbl and can confirm it triggers a rebuild now:
>>
>> diff --git a/arch/mips/kernel/syscalls/Makefile
>> b/arch/mips/kernel/syscalls/Makefile
>> index aaa5443ea906..9e31d1ce5015 100644
>> --- a/arch/mips/kernel/syscalls/Makefile
>> +++ b/arch/mips/kernel/syscalls/Makefile
>> @@ -40,10 +40,10 @@ src_n32 := $(src)/syscall_n.tbl
>>    src_n64 := $(src)/syscall_n.tbl
>>    src_o32 := $(src)/syscall_o32.tbl
>>
>> -$(kapi)/unistd_nr_%.h: $(systbl_common) $(sysnr) FORCE
>> +$(kapi)/unistd_nr_%.h: $(systbl_common) $(src_%) $(sysnr) FORCE
>>           $(call if_changed,sysnr)
>>
>> -$(kapi)/syscall_table_%.h: $(systbl) $(systbl_common) FORCE
>> +$(kapi)/syscall_table_%.h: $(systbl) $(systbl_common) $(src_%) FORCE
>>           $(call if_changed,systbl)
> 
> I had tried the same thing already, but in my testing, it did
> not rebuild after changing the syscall_n.tbl file, only the
> syscall_o32.tbl file. Can you verify that your change rebuilds
> all nine files in the correct cases?
>
After a more careful look, I have found out a couple of issues:

- The first one, the one that the build bot originally warned as about 
this outdated rule:

  $(uapi)/unistd_%.h: $(src)/syscall_%.tbl $(syshdr) FORCE
  	$(call if_changed,syshdr)

$(src)/syscall_%.tbl doesn't make anymore for n32 and n64, and needed to 
be updated.

- Secondly, $(src_%) doesn't work as I expected. % only works like this 
for files (like syscall_%.tbl). For variables, the correct form is 
$(src_$*). Now the pattern matching started working and generating 
$(src_n32), $(src_n64), ...

- Finally, this wasn't enough either. Due to how make works[1], the 
variable was being generated but it wasn't being evaluated. So I had to 
add the .SECONDEXPANSION target to finally make it work, resulting on 
those rules:

.SECONDEXPANSION:

$(uapi)/unistd_%.h: $(systbl_common) $$(src_$$*) $(syshdr) FORCE
	$(call if_changed,syshdr)

$(kapi)/unistd_nr_%.h: $(systbl_common) $$(src_$$*) $(sysnr) FORCE
	$(call if_changed,sysnr)

$(kapi)/syscall_table_%.h: $(systbl) $(systbl_common) $$(src_$$*) FORCE
	$(call if_changed,systbl)

And now, testing updating the tables:

$ touch arch/mips/kernel/syscalls/syscall_o32.tbl
$ make -j31 W=1 O=mips ARCH=mips LLVM=1 prepare | grep SYS
   SYSHDR  arch/mips/include/generated/uapi/asm/unistd_o32.h
   SYSTBL  arch/mips/include/generated/asm/syscall_table_o32.h
   SYSNR   arch/mips/include/generated/asm/unistd_nr_o32.h

$ touch arch/mips/kernel/syscalls/syscall_n.tb
$ make -j31 W=1 O=mips ARCH=mips LLVM=1 prepare | grep SYS
   SYSHDR  arch/mips/include/generated/uapi/asm/unistd_n32.h
   SYSHDR  arch/mips/include/generated/uapi/asm/unistd_n64.h
   SYSTBL  arch/mips/include/generated/asm/syscall_table_n32.h
   SYSTBL  arch/mips/include/generated/asm/syscall_table_n64.h
   SYSNR   arch/mips/include/generated/asm/unistd_nr_n32.h
   SYSNR   arch/mips/include/generated/asm/unistd_nr_n64.h

$ touch scripts/syscall_common.tbl
$ make -j31 W=1 O=mips ARCH=mips LLVM=1 prepare | grep SYS
   SYSHDR  arch/mips/include/generated/uapi/asm/unistd_n32.h
   SYSHDR  arch/mips/include/generated/uapi/asm/unistd_n64.h
   SYSHDR  arch/mips/include/generated/uapi/asm/unistd_o32.h
   SYSTBL  arch/mips/include/generated/asm/syscall_table_n32.h
   SYSTBL  arch/mips/include/generated/asm/syscall_table_n64.h
   SYSTBL  arch/mips/include/generated/asm/syscall_table_o32.h
   SYSNR   arch/mips/include/generated/asm/unistd_nr_n32.h
   SYSNR   arch/mips/include/generated/asm/unistd_nr_n64.h
   SYSNR   arch/mips/include/generated/asm/unistd_nr_o32.h

I will send a v7 with this changes for mips.

Thanks!

[1] 
https://www.gnu.org/software/make/manual/html_node/Secondary-Expansion.html
