Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E46E16D9B2
	for <linux-s390@vger.kernel.org>; Thu, 11 Jul 2024 23:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720742132; cv=none; b=YzVlH1dm9krE8GyxVDlCYn3botGxxbrcYzZGnmZFZMCGfWxj1Jgyr284oLSbPiQZHn6g/xC/t1GIICXoXygmtXAx/OvBLdUElKQzF8xa1m6fXO/cacFY3quyLZM2GRvM7nV6dTNq3A94ZmqyfpgpLB34j5+3yXwwOolnW429Jas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720742132; c=relaxed/simple;
	bh=VeNd6sW9INFQQoe/NItGfdsDnKezHeQ2OIWwVma23xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXPkY61qNyhqCoCsu8W2YPCwz5S0CNDQ0Bl4y2O6hC9WBjRhFtXhP6saYJ9v1rlkRhSEwbC6nP+RWtSUDP4xWDSYKu+K5NcB1T003O/bQXnSTQmFIuZWE60iLZqVpSDNxkxYn7d2hW518a1tukRHSMG7tpNacYaKs6R0pC0BkBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=Rh+LJ8Cn; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="Rh+LJ8Cn"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fb3cf78fcaso10391925ad.1
        for <linux-s390@vger.kernel.org>; Thu, 11 Jul 2024 16:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1720742131; x=1721346931; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oMWa/uIupM7TGzZSYVFDZYRJSR0tRO+8ADTFG/NzhUE=;
        b=Rh+LJ8Cn7+snQyKVhdus/mj9EFHIKX5WoWZ0qVp7WzHKibaZZ66o3RrT52RwnJ5jTt
         p7pCrWbOxVsjuupZOo7LbiGGUqCB6WWa93y1pcG+garJJkQahqG/A4I2aSjR9S59s+TZ
         t5t6mm9ihDdadeEIN7XvsvwAlT17lVDlVvhkFq2d6vG5i5u33n23FxtmmCGIAiiHsaE6
         cPBxALKSP6Jvy31YEVpGt+tcphKo/5f8bG1ROtSviCDzItR1ied55rxRnx+idi4hXD2v
         9ehOzhZu9h5zHIeAE9SuG3fsu/GmHgZfILmW+gTfS2vYHdRneQ/gkLxnu1kVNIN/Omya
         gdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720742131; x=1721346931;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMWa/uIupM7TGzZSYVFDZYRJSR0tRO+8ADTFG/NzhUE=;
        b=BeM7m24nvbZjSmzRqKivwRno8xV4SJTqx/gQ/OFS5Gf+c/ofJnsVc2IKX3XHACu7qQ
         dJrGGKQiwrQTQ37i53LqOhoxCgXShCqWjbbNjOAO224YtOls61NKaU9pf5gSidn70SnZ
         Ih3nXrCh0RKLG3bBT92O9pnhZiZjXBOpp6H2yT2iJVKCZItTbnY7ZnnTOd63F00dVhwz
         9L9sKfvKT7d4EamicfqQ0r64SZIFBDWVYZf3I0uJsuS2RKKAM9rzAOhNFBgJ5STrFzce
         UE2nqjBynIOm8d1X3jRZUjqTkDkIk9jDv333VonFvLmamGAMsaa1yIcLnFx8Ij8dbjni
         xAMg==
X-Forwarded-Encrypted: i=1; AJvYcCUOU8DNBzifvepJWJuaZbgtVsV7d/qxD0J0jcOFRIXvc1T1h/kP3kMuue5+qj26nJaKPr6azVlizxrP+AkV6TDoHJxdwTzFxiazbA==
X-Gm-Message-State: AOJu0Yyvlg0n2V6JTS+K0NRRk+kSf4fASBbAtGzYLsbGQE4vjwo/dVEQ
	rqlY7QBz8o/HGc36PcgbbbzRX+RJE+7Wq0AgEbLmflSQ8WwH1gUVGOafV17Xyzw=
X-Google-Smtp-Source: AGHT+IGWFPa8ke5HVmwTbYX2AMk/oJkluGq0ZJT0Ijy5yVMqIvh2jrZ0uz/YMdxouZJLRznJjxevOA==
X-Received: by 2002:a17:902:cec5:b0:1fb:7d20:f040 with SMTP id d9443c01a7336-1fbb6f0abbamr98665265ad.64.1720742130608;
        Thu, 11 Jul 2024 16:55:30 -0700 (PDT)
Received: from telecaster ([2601:602:8980:9170::7a8e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ac29f2sm55745365ad.218.2024.07.11.16.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 16:55:29 -0700 (PDT)
Date: Thu, 11 Jul 2024 16:55:29 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	linux-debuggers@vger.kernel.org
Subject: Re: Incorrect vmcoreinfo KERNELOFFSET after "s390/boot: Rework
 deployment of the kernel image"
Message-ID: <ZpBw8VsM-_W8gxN9@telecaster>
References: <ZnS8dycxhtXBZVky@telecaster.dhcp.thefacebook.com>
 <Zn1uTZdlYNaRFUqK@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <20240709212141.31160508@meshulam.tesarici.cz>
 <Zo2j3hgOhh9EQld1@telecaster.dhcp.thefacebook.com>
 <20240710070246.001873c4@meshulam.tesarici.cz>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240710070246.001873c4@meshulam.tesarici.cz>

On Wed, Jul 10, 2024 at 07:02:46AM +0200, Petr Tesařík wrote:
> On Tue, 9 Jul 2024 13:55:58 -0700
> Omar Sandoval <osandov@osandov.com> wrote:
> 
> > On Tue, Jul 09, 2024 at 09:21:41PM +0200, Petr Tesařík wrote:
> > > On Thu, 27 Jun 2024 15:51:09 +0200
> > > Alexander Gordeev <agordeev@linux.ibm.com> wrote:
> > >   
> > > > On Thu, Jun 20, 2024 at 04:34:15PM -0700, Omar Sandoval wrote:
> > > > 
> > > > Hi Omar,
> > > >   
> > > > > Hi, Alexander and Sven,
> > > > > 
> > > > > I just got around to testing drgn on s390x on 6.10-rc4, and it appears
> > > > > to be broken. I bisected it to commit 56b1069c40c7 ("s390/boot: Rework
> > > > > deployment of the kernel image") and narrowed it down to an issue with
> > > > > the KERNELOFFSET value reported in vmcoreinfo.
> > > > > 
> > > > > On my test kernel, the ELF symbol for init_task is 0xc96f00:
> > > > > 
> > > > >   $ eu-readelf -s build/vmtest/s390x/kernel-6.10.0-rc4-vmtest30.1default/build/vmlinux | grep ' init_task$'
> > > > >   72273: 0000000000c96f00   4352 OBJECT  GLOBAL DEFAULT       18 init_task
> > > > > 
> > > > > And the address in the loaded kernel is 0x3ffffeaaf00:
> > > > > 
> > > > >   # grep ' init_task$' /proc/kallsyms
> > > > >   000003ffffeaaf00 D init_task
> > > > > 
> > > > > 0x3ffffeaaf00 - 0xc96f00 is 0x3ffff214000
> > > > > 
> > > > > However, this doesn't match the value of KERNELOFFSET in vmcoreinfo:
> > > > > 
> > > > >   # eu-readelf -n /proc/kcore | grep KERNELOFFSET
> > > > >     KERNELOFFSET=3ffff314000
> > > > > 
> > > > > It's off by 0x100000. This causes drgn to compute the wrong addresses
> > > > > for all global variables.
> > > > > 
> > > > > For context, I'm testing using QEMU emulation on an x86-64 host. Note
> > > > > that it logs "KASLR disabled: CPU has no PRNG" early during boot. My
> > > > > exact setup is:
> > > > > 
> > > > >   $ git clone https://github.com/osandov/drgn.git
> > > > >   $ cd drgn
> > > > >   $ python3 -m vmtest.rootfsbuild -a s390x --build-drgn
> > > > >   $ python3 -m vmtest.vm -k 's390x:6.10.*' bash -i
> > > > >   # python3 -m drgn    
> > > > >   >>> prog['init_task'].comm    
> > > > >   (char [16])""
> > > > > 
> > > > > That should be printing "swapper/0".
> > > > > 
> > > > > Any ideas what's going on here?    
> > > > 
> > > > On s390 no kernel symbol exists below 0x100000 offset within the
> > > > vmlinux image and thus this part is never mapped into the kernel
> > > > memory. That way KERNELOFFSET turns out to be off on value of
> > > > 0x100000 - and that is what you observe.
> > > > 
> > > > That breaks the way drgn finds a kernel symbol, but does not
> > > > exactly contradicts to the existing KERNELOFFSET description
> > > > (Documentation/admin-guide/kdump/vmcoreinfo.rst):
> > > > 
> > > > ===
> > > > KERNELOFFSET
> > > > ------------
> > > > 
> > > > The kernel randomization offset. Used to compute the page offset. If
> > > > KASLR is disabled, this value is zero.
> > > > ===
> > > > 
> > > > I would say to some degree there is also inconsisten with regard
> > > > to /proc/ files existence:
> > > > /proc/kcore    is enabled by CONFIG_PROC_KCORE option, while
> > > > /proc/kallsyms is enabled by CONFIG_KALLSYMS option.
> > > > I assume drgn expects both files exist and does not work otherwise.  
> > 
> > drgn doesn't use kallsyms, partially because it's not guaranteed to
> > exist as you pointed out, and partially because it's slow.
> > 
> > > > Nevertheless, it is still possible to refer to only one file for
> > > > symbol resolution and use an always-present symbol. E.g _stext
> > > > could be leveraged like this:
> > > > 
> > > > # grep -w init_task /proc/kallsyms
> > > > 000003ffe13e9400 D init_task
> > > > # grep -w _stext /proc/kallsyms
> > > > 000003ffe0000000 T _stext
> > > > 
> > > > 0x3ffe13e9400 - 0x3ffe0000000 == 0x13e9400
> > > > 
> > > > # eu-readelf -s vmlinux | grep -w _stext
> > > > 178112: 0000000000100000      0 NOTYPE  GLOBAL DEFAULT        1 _stext
> > > > 
> > > > 0x13e9400 + 0x100000 == 0x14e9400
> > > > 
> > > > # eu-readelf -s vmlinux | grep -w init_task
> > > >   498: 0000000000000000      0 FILE    LOCAL  DEFAULT      ABS init_task.c
> > > > 182344: 00000000014e9400   8960 OBJECT  GLOBAL DEFAULT       28 init_task
> > > > 
> > > > I guess, the above holds true for all architectures.
> > > > If so, I would suggest consider using that approach.
> > > > 
> > > > Having said that, we will try to turn KERNELOFFSET from a synthetic
> > > > value "Used to compute the page offset" to what drgn expects it to be.  
> > > 
> > > Thinking about it now, I'm not sure it makes life easier. Because then
> > > we'll have some old kernels with the current (unexpected) definition of
> > > KERNELOFFSET and some new kernels with a more standard definition of
> > > it, but if I read vmcoreinfo, how do I know if the value has the old or
> > > the new meaning?  
> > 
> > I wasn't able to get real KASLR working on my s390x VM, but what I found
> > in testing without KASLR was:
> > 
> > - Before commit c98d2ecae08f ("s390/mm: Uncouple physical vs virtual
> >   address spaces"), KERNELOFFSET was not set at all (this is expected).
> > - After commit c98d2ecae08f ("s390/mm: Uncouple physical vs virtual
> >   address spaces"), but before commit 56b1069c40c7 ("s390/boot: Rework
> >   deployment of the kernel image"), KERNELOFFSET was set in a way that
> >   drgn understands even without KASLR (that's a little odd but fine with
> >   me).
> > - After commit 56b1069c40c7 ("s390/boot: Rework deployment of the kernel
> >   image"), KERNELOFFSET was set "incorrectly"
> > 
> > So at least for no KASLR, the breakage has been limited only to the 6.10
> > rcs, which isn't too late to fix. I'd be curious what the behavior was
> > with KASLR before 6.10, though.
> 
> OK, I'll check SLES 15 SP5 (kernel 5.14) and SP6 (kernel 6.4). Both
> enable KASLR, but it can be turned off on the command line (or I can
> even rebuild the kernel without CONFIG_RANDOMIZE_BASE if that makes a
> difference).

The case I'm interested here is with KASLR enabled. In those kernel
versions, is KERNELOFFSET the difference between the addresses in
vmlinux and the actual addresses in memory?

Thanks,
Omar
