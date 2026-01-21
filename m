Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22423A9621
	for <linux-s390@vger.kernel.org>; Wed, 21 Jan 2026 16:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769013795; cv=none; b=DB2yAAHKyfg9oalLjWuIzY2mpQZVnSH1XvNTrHDiG6FTyFm+fm/1jLGGnkzwpMlb8EgRYzWYI4B0IYJ0XRc4a7gJypZs9IYFGzhn5Osz7NW8RK+lK8ThEzCVeaWr+M/ElDVbOkU88KolmUEOq8p53mP+PoKbW8p7dQuuqGKmvow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769013795; c=relaxed/simple;
	bh=Jj/tYwdXEXUOg64lKr4IrDKHw613UPzJ/qBPeEVnSIo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DQN4If9va09ETjT7czruNNMbK6nJFC2X9puvknm9/ZEP4vaR7jNc1lIQWVEIgt3N7BqPYpW3FQ5iZI+v/iprTd3lDfNctgU7I6Xyt/EhzIa3Z0A9cRmF+nVjnySC8TeQN0FMg5SIFyb8ehmSEOasL4aPT8+yaCx3QTzv+jtK4Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdPan/cd; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdPan/cd"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b8718187eb6so1030943666b.2
        for <linux-s390@vger.kernel.org>; Wed, 21 Jan 2026 08:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769013791; x=1769618591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MFyGEBMKUH9OPAqYqwZCoqkE5S+eIGaZJE0/gf+bsI=;
        b=LdPan/cdXN00Y3miAAtCEHonQxPFegLpdQb+BhJd2yUjomiaS4zBNCePWub9QBZFy/
         KNpP1PD3i5LMXl0SrSqDZI/QeF7w1yqFdgIilxNFGDvbc3xHObNPCRLMarR4fiNE1mlX
         o6iIvV6yfgGXLTyGxqm4EunnsI2FICDDZOJmGuP0SyusUCN5VU+BdLMH8doY2eU2zbuo
         eHK3xjOR8c4UdLrELD6xZJZBG2WQxwAfrW/T5ZeJ0aEPk/9MpKrTmG8Bo0+UIO6hqY2N
         76V2O6Mo3OJhZkBbaHyp7KXvVQabmnXjJLwF/65ifzg9vcIWlTS35KJHQb135CL4/ltA
         saNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769013791; x=1769618591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7MFyGEBMKUH9OPAqYqwZCoqkE5S+eIGaZJE0/gf+bsI=;
        b=DXEXgM3pUzoFIGirFeyxvLRAt8ZtY3NG5hjVKQkL+/iARMjvSZGtCHEFOKQFzaa6GQ
         El8MukjmyWJjtvZVziP4Xa/Qj4C5gS3pa1SvHVk24tHpv+XUj2a11QnYFYQii+zkYDyJ
         fszaHaAuHnvI0Z+6EiC3YsxjVMNDg79++IJX4iVrbexu2DjXOA2RPWk1rvTEA4s+e7Jo
         fiSFseGdUujHdzgfL8Xih5/cXil90cANDluerlyFArJVLZH6jOQjlfw9lCl+1LPkM98p
         //Ny7c57pSuzWV9q0OQrynjc8/nyCD6t4qku50q03OaWBVKHDdl4ngBjUXyuDe0GImkr
         a2iQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVmX9dlBA+NHqgkZcyuuMU3GAx+N5hSLvMLr8TMdboY/Wb2jWLjhXgIHd/Z7AuNujpHJvYZmaT7cqw@vger.kernel.org
X-Gm-Message-State: AOJu0YzcTkh/tmUYAhxY3kEzVodfdUBNW3kDZ1JHWBuuKX67azO/19Y4
	a0h6aMBHrcaNXXrzL87skN3nCmx+EANaLHzFsR6jyqQsVWFTt1NZe37TsqPgLw==
X-Gm-Gg: AZuq6aLQFCwKUWNydaehicL8pdS0I7ZUC/gEP38/lyFcBtWnsrvDWf+BbWKcLpfY5L6
	YACj5eRZQ107Ps7+RwoHsEcdVdHjpqHadFdBkXJPzSk09A5xD60gCuSJBKvsxVb2otXkSS7QS9O
	Ktc4cQ0I/Oy/UFcX0NrtEiqYIwljB7WhXWqx1iP4vx2+eUZm6E5wzVx9yBYCrMV2jWi92DPhz2Z
	8uu077AGrx1JQgDqA8SWG4SaLnlnr6dGpAlS/w2+RRGF8+LEEVHrpAc1PotfCtNsdUdAWPDKxh1
	A8iaOIJWpBHgVL9eUwT6/ADyPF1I3fwYW6UYzEi4RA0uYxo062q0B4cciH3Q5leuDzE6bx3kNOQ
	zj9ML2EmS+srvsp/bm0S3hOW1BiOmkAcLFNi3QIwfVqREZzVrg2++t+tPC6xOS0gAStmcr7GgYo
	Te4Mi+2DyZfzytbtLQFsCTWloQm3tKsQnNlMqTEZHY0nnJSMaBzwSa
X-Received: by 2002:a05:600c:4fc7:b0:480:41f2:b212 with SMTP id 5b1f17b1804b1-48042f7e0e0mr38897745e9.25.1769006884109;
        Wed, 21 Jan 2026 06:48:04 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4802dc90068sm274897235e9.7.2026.01.21.06.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 06:48:03 -0800 (PST)
Date: Wed, 21 Jan 2026 14:48:02 +0000
From: David Laight <david.laight.linux@gmail.com>
To: kernel test robot <lkp@intel.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Huacai Chen
 <chenhuacai@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, Kees Cook <kees@kernel.org>, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland
 <mark.rutland@arm.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>, Ard
 Biesheuvel <ardb@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>,
 llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v4 3/3] randomize_kstack: Unify random source across
 arches
Message-ID: <20260121144802.1287ce3e@pumpkin>
In-Reply-To: <20260121102017.539b5531@pumpkin>
References: <20260119130122.1283821-4-ryan.roberts@arm.com>
	<202601210752.6Nsv9et9-lkp@intel.com>
	<20260121102017.539b5531@pumpkin>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Jan 2026 10:20:17 +0000
David Laight <david.laight.linux@gmail.com> wrote:

> On Wed, 21 Jan 2026 07:50:16 +0800
> kernel test robot <lkp@intel.com> wrote:
> 
> > Hi Ryan,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > [auto build test WARNING on akpm-mm/mm-everything]
> > [also build test WARNING on linus/master v6.19-rc6 next-20260119]
> > [cannot apply to tip/sched/core kees/for-next/hardening kees/for-next/execve]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Roberts/randomize_kstack-Maintain-kstack_offset-per-task/20260119-210329
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> > patch link:    https://lore.kernel.org/r/20260119130122.1283821-4-ryan.roberts%40arm.com
> > patch subject: [PATCH v4 3/3] randomize_kstack: Unify random source across arches
> > config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20260121/202601210752.6Nsv9et9-lkp@intel.com/config)
> > compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260121/202601210752.6Nsv9et9-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202601210752.6Nsv9et9-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> >   
> > >> vmlinux.o: warning: objtool: do_syscall_64+0x2c: call to preempt_count_add() leaves .noinstr.text section
> > >> vmlinux.o: warning: objtool: __do_fast_syscall_32+0x3d: call to preempt_count_add() leaves .noinstr.text section    
> >   
> 
> When CONFIG_DEBUG_PREEMPT or CONFIG_TRACE_PREEMP_TOGGLE is set
> the preempt_count_[en|dis]able() calls inside [put|get]_cpu_var()
> become real functions.
> 
> Maybe __preempt_count_[inc|dec]() can be called (with this_cpu_ptr()).

Or the code could just use the per-cpu data without disabling preemption.
Usually that isn't a good idea at all, but it can't matter in this case.
Might give a noticeable performance gain, disabling preemption is
non-trivial and/or an atomic operation on some architectures.

If anyone is worried about preemption causing the output be repeated, that
would be (mostly) mitigated by checking that s[1234] haven't changed prior
to writing the new values.
I think a 'not locked at all' compare of two of the four values will
stop everything except two threads doing system calls at the same time
getting the same output from the prng.

The whole thing is very unlikely and there will be much easier ways
to break the prng.
Provided s[1234] are only written with valid values (ie ones which aren't
effectively zero) it will continue generating numbers.

	David


> 
> 	David
> 

