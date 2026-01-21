Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065823ACA71
	for <linux-s390@vger.kernel.org>; Wed, 21 Jan 2026 12:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768998021; cv=none; b=HABVH9RTNem+teBR4RQNTs4h5WqOHeu6udrJcyJLPN8UevYMIHb+RczBn++AzcujWO4cmR+n8H+kXrtyV94jG9pkFkEChMS31Icwn5tog43tl6srPf8Y4qW8o4R+QoC7duwI8ihJDiB8t6qwjFQdSnMrS4UCkPxAAso5xv9TGhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768998021; c=relaxed/simple;
	bh=5BvH3tNtf3yGwclgsloqehSCFnzEUkv3zWGQ5+wTvn8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LbVP458pehyz7RvPd9sx6EoiBpr3ZaqcAbT62BFSVqH9kLnM62QGXr0fLlAFVNn9xNiVDsJmd6AjMnmuGtMshpxT1487zbXuV1Q0ZNacKij8RX/+VYyOdq0CS6sonTK049zva7JiDhqllW7bXau5Hngnm1QeXXmYcv74vaY3bIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IdsPIUAq; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdsPIUAq"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59b67388c9cso7948784e87.2
        for <linux-s390@vger.kernel.org>; Wed, 21 Jan 2026 04:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768998017; x=1769602817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2DGCZ8EIP3Ii+3jUlQj/U+neLJaf8YM5JLMcsfoSkko=;
        b=IdsPIUAqTkuJs5SQvYYLCMM4w6LZRRM04+vhEOZPl2MFaR3u1FgSWOAwDDi1vdH+tH
         BdGVHFEIogUwSn0PBqFd+FxaJyOqvKaBleFahqPRyeRuo0ecjnh3oQD3N3FpzgH63+cX
         GmDJnUpxiAXVs4plCrIswbSJCiNTSdsTdvuuVxtrWDsu3JDykIXUqg/nBEioNfv3d5+4
         ZdyqXCmbJ/Zbl7V+o0m6FOOZErx7tlGKeLKCWSuBH7MbW4KlgzKhS281shxRTojOVH82
         S1Q3/8NIB1HED/pEzTKJ3fNiG0OkWjG+rpdZwPD/89+A9Or/3zajV82ZFYRJfC7xSfcV
         Khzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768998017; x=1769602817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2DGCZ8EIP3Ii+3jUlQj/U+neLJaf8YM5JLMcsfoSkko=;
        b=QEN9OKBxvgGUQ2ZiWagBdKhvrat6/f6Cyo6WpOuoapZBgJ/d3FhC4mepne4nG/XMs+
         Cabnd3erWYdHgZ8nuOeuZqIu6iVHkdZhhTZRS0P1FrCthGSjYxfrQPqURbM5rlfxEPwy
         AO4cWfEM3hldzlNkMdQqk0MEfAHyc/6msJK93e1S9klWVcfhkya5XJpevMu1gUxK+oN3
         7lLEqcpbGKzJdaYQgkngyN0zJDPKj1NVAW3izGm8gukqzVLhY+kKQVhItXyluXpOQz32
         9PpLkkUTUE9rfqo1QkEHhJdIfNoJUY6lnAKxib+5cd6nKeEnQj18ceyRuGg8RjkkP2po
         TZWA==
X-Forwarded-Encrypted: i=1; AJvYcCWg1uPZajMpSx4uGsWmyG/XGpVmB4QDpNrM8MBK+PX91Fd3MSy34ToFIWepnq+RSEvGFQSukrDGRLtl@vger.kernel.org
X-Gm-Message-State: AOJu0YzLnp1F3OwiboaQUJJRpRBVvkejQi73R5o1lLcC7G3wQiOEJbm/
	KzSf10Y6zvEwaTpasEno7JzJ0O06PPs58MKJ3RwBhqBMfJsKLfbPNGtT0lNAKw==
X-Gm-Gg: AZuq6aJfwH6+IvVxErW6pDbrOTZFRfKDJkjpF5WHv4iIZAYcWSvTxVaMnDuezdV3shX
	S0p+WvDNR5Ol+zpKU/EGuG+gcfeSu1jeL9sECN7aIoONfUi7K17VIr6yWrKAmu1on4L4xf0PWiY
	8t8bgznj3lpohMdQxtnk7ZNPc0DGB1AgtCRtcmJxpieSI5mVTW6/miIpf6n6UPY5pX3RefQArjR
	YnzAv8+5/Ndqdz9cShxHhZkI84QIapd8ARSbmFV1/85fRMyYEhSnSFmjn4Wi6zpUFcccFb1Fo9z
	6aBahngUhCsFAqYoPjyxt9zB8OSOhJzdl1eV3FpmLct/q7je7oo64KYFiwqYTM8MhzRww/nUs0m
	wTPZMFGtGr4F4q8wQblyBa7cmeMS3Mwv1AlV8ZVYlMEwB4PsXS7mFZgzvnYA8+2Wh2WZr22v7KT
	rEaSfpXj54DIKG2y4A8coLcOM+zeA3eDfvbFZNveL8CeLf8tk5fcDccPGBEvgNMss=
X-Received: by 2002:a05:600c:8b55:b0:477:9f34:17b8 with SMTP id 5b1f17b1804b1-4801e2fbd61mr238692885e9.1.1768990819461;
        Wed, 21 Jan 2026 02:20:19 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e8d77besm306630785e9.14.2026.01.21.02.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 02:20:19 -0800 (PST)
Date: Wed, 21 Jan 2026 10:20:17 +0000
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
Message-ID: <20260121102017.539b5531@pumpkin>
In-Reply-To: <202601210752.6Nsv9et9-lkp@intel.com>
References: <20260119130122.1283821-4-ryan.roberts@arm.com>
	<202601210752.6Nsv9et9-lkp@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Jan 2026 07:50:16 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Ryan,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on akpm-mm/mm-everything]
> [also build test WARNING on linus/master v6.19-rc6 next-20260119]
> [cannot apply to tip/sched/core kees/for-next/hardening kees/for-next/execve]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Roberts/randomize_kstack-Maintain-kstack_offset-per-task/20260119-210329
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20260119130122.1283821-4-ryan.roberts%40arm.com
> patch subject: [PATCH v4 3/3] randomize_kstack: Unify random source across arches
> config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20260121/202601210752.6Nsv9et9-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260121/202601210752.6Nsv9et9-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202601210752.6Nsv9et9-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> vmlinux.o: warning: objtool: do_syscall_64+0x2c: call to preempt_count_add() leaves .noinstr.text section
> >> vmlinux.o: warning: objtool: __do_fast_syscall_32+0x3d: call to preempt_count_add() leaves .noinstr.text section  
> 

When CONFIG_DEBUG_PREEMPT or CONFIG_TRACE_PREEMP_TOGGLE is set
the preempt_count_[en|dis]able() calls inside [put|get]_cpu_var()
become real functions.

Maybe __preempt_count_[inc|dec]() can be called (with this_cpu_ptr()).

	David
