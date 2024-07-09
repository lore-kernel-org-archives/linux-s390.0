Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D60B5FB8A
	for <linux-s390@vger.kernel.org>; Tue,  9 Jul 2024 20:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720558562; cv=none; b=n0CbuJmBpDsMGGaOh5MUddwqXGsm1PY0ZZwcRzcIHcCxugDQcES9o6Hekl9RnpTHRVZNjfixWTFWqfObxdsOPqBq4Y17ecaO4QXKGoqEbHr+P6a9RQSUXNaQyaeGx7f6d8drd2yHAXyX/o2aI/E+HiG0rJ/jwPXZeqSFxFpiNEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720558562; c=relaxed/simple;
	bh=myoxpt3WUrYmzkm+PhsqyU9ucLITY36xgEDvfIKUv/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuoL6y9cn4416ShTs4ptRXbBSyDMCMa6Frd3CqW09swdvZxg1xetZ2UFIJQDl2+TvQ6wmtjrBL5es8W6MLc4xCk9zl12Huk+jHOnLujk55ZEJw+jxlQJVPELOD46sy8Tf/NCz7r/to2+jj4N/nXB6wPT9RrCV8A58pdnsZvAKJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=0SSTKofD; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="0SSTKofD"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70b0bc1ef81so2944488b3a.1
        for <linux-s390@vger.kernel.org>; Tue, 09 Jul 2024 13:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1720558560; x=1721163360; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/cRGd0Fbol5I9N8TsbKnY/79oZGZXnktf7kH1n94eLs=;
        b=0SSTKofDMJ/cuxdrR5mfFhlE2AiJ1PPsdrdBtE+lLnZly6oF4Uy4hgrSPlZvPTgubX
         LaTMqYtD+nTa0Fawv2E6vX1bemdczBQAcDJA4/71QUFtT093957BdRE3NUow4EKtgFy9
         sLBv4edDwYsFM9Gjx/YclRx4iO1QfDRNxK++E9aKF03KzgooEfdKu8ySd5QJg7hb20n9
         ANjFNyF4gxg7yylvmMWYwpBuVisoYW301EiMC83XpaHNc1XBAnZCc1BuFQIu+n5yZLsB
         C17MgndZGIcmDGsqCVpaAHWMgbs18W7MXtJysDJRCS4Ai4Vb63AkD8G4sdUwWuGK9OJS
         D6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720558560; x=1721163360;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/cRGd0Fbol5I9N8TsbKnY/79oZGZXnktf7kH1n94eLs=;
        b=v8QtQMxVFJwgpsiMaeZASU67rIEyo2tJoAPKx4I8CIC8wN8kwfhZ12ayW3xaRP0uOf
         ZoOyAJDG9sp2AetJmc01KZpLzLHB69QKVH6Ltq8JJFD7T6jnOErz+WPR1Jl9dqCcPvez
         vCAvwVdGcdmdBlttfhJnRkOQjFnsF67V41XdLKHvepni4xPKfM4MobfDTiWNV+Y/x0Ze
         tWiC/D711lmuhmrlBfAygRRInf3pzn7UO+rM/+BakOz1gY6o+JOeXDx7vh4zz/oW3h4l
         IeW71KBNeQQmZtDPCKn+IdVuwL5qbjlLzysLdbmVAT19jmANYn1IMzPOrQQ5mLrg8fFr
         5hbw==
X-Forwarded-Encrypted: i=1; AJvYcCWcYwnKy3ZrpvOtKIWpbg2/gMieX5CsnQxJvf39kBWh6vQF+G9g2wB8JH2mmEYV3eCktRDlvNExM/m6KIPtWJfczTuz1A2fvqJ3WQ==
X-Gm-Message-State: AOJu0YwFSkIjcMsBXJcePzlwvdGLmgtoCGfIGsKJleMZ0PBTB5pQe5xl
	wxxHMCvilIVAvI30PiJAClfJTkMG1foLrBEPm3lVazW3gc5oBS2/W6nwr9CUT2w=
X-Google-Smtp-Source: AGHT+IF1fkkyJUtNA3tuWbcczf85o6L1BjGemlpB924rPZ9ydwwbHQrdQ31WSQ4WXVCXGMKyXeBgKA==
X-Received: by 2002:a05:6a00:1acf:b0:70b:30ce:dfdb with SMTP id d2e1a72fcca58-70b4364fef6mr4306622b3a.24.1720558560137;
        Tue, 09 Jul 2024 13:56:00 -0700 (PDT)
Received: from telecaster.dhcp.thefacebook.com ([2620:10d:c090:400::5:7842])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b438c6e8dsm2289165b3a.68.2024.07.09.13.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 13:55:59 -0700 (PDT)
Date: Tue, 9 Jul 2024 13:55:58 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	linux-debuggers@vger.kernel.org
Subject: Re: Incorrect vmcoreinfo KERNELOFFSET after "s390/boot: Rework
 deployment of the kernel image"
Message-ID: <Zo2j3hgOhh9EQld1@telecaster.dhcp.thefacebook.com>
References: <ZnS8dycxhtXBZVky@telecaster.dhcp.thefacebook.com>
 <Zn1uTZdlYNaRFUqK@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <20240709212141.31160508@meshulam.tesarici.cz>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240709212141.31160508@meshulam.tesarici.cz>

On Tue, Jul 09, 2024 at 09:21:41PM +0200, Petr Tesařík wrote:
> On Thu, 27 Jun 2024 15:51:09 +0200
> Alexander Gordeev <agordeev@linux.ibm.com> wrote:
> 
> > On Thu, Jun 20, 2024 at 04:34:15PM -0700, Omar Sandoval wrote:
> > 
> > Hi Omar,
> > 
> > > Hi, Alexander and Sven,
> > > 
> > > I just got around to testing drgn on s390x on 6.10-rc4, and it appears
> > > to be broken. I bisected it to commit 56b1069c40c7 ("s390/boot: Rework
> > > deployment of the kernel image") and narrowed it down to an issue with
> > > the KERNELOFFSET value reported in vmcoreinfo.
> > > 
> > > On my test kernel, the ELF symbol for init_task is 0xc96f00:
> > > 
> > >   $ eu-readelf -s build/vmtest/s390x/kernel-6.10.0-rc4-vmtest30.1default/build/vmlinux | grep ' init_task$'
> > >   72273: 0000000000c96f00   4352 OBJECT  GLOBAL DEFAULT       18 init_task
> > > 
> > > And the address in the loaded kernel is 0x3ffffeaaf00:
> > > 
> > >   # grep ' init_task$' /proc/kallsyms
> > >   000003ffffeaaf00 D init_task
> > > 
> > > 0x3ffffeaaf00 - 0xc96f00 is 0x3ffff214000
> > > 
> > > However, this doesn't match the value of KERNELOFFSET in vmcoreinfo:
> > > 
> > >   # eu-readelf -n /proc/kcore | grep KERNELOFFSET
> > >     KERNELOFFSET=3ffff314000
> > > 
> > > It's off by 0x100000. This causes drgn to compute the wrong addresses
> > > for all global variables.
> > > 
> > > For context, I'm testing using QEMU emulation on an x86-64 host. Note
> > > that it logs "KASLR disabled: CPU has no PRNG" early during boot. My
> > > exact setup is:
> > > 
> > >   $ git clone https://github.com/osandov/drgn.git
> > >   $ cd drgn
> > >   $ python3 -m vmtest.rootfsbuild -a s390x --build-drgn
> > >   $ python3 -m vmtest.vm -k 's390x:6.10.*' bash -i
> > >   # python3 -m drgn  
> > >   >>> prog['init_task'].comm  
> > >   (char [16])""
> > > 
> > > That should be printing "swapper/0".
> > > 
> > > Any ideas what's going on here?  
> > 
> > On s390 no kernel symbol exists below 0x100000 offset within the
> > vmlinux image and thus this part is never mapped into the kernel
> > memory. That way KERNELOFFSET turns out to be off on value of
> > 0x100000 - and that is what you observe.
> > 
> > That breaks the way drgn finds a kernel symbol, but does not
> > exactly contradicts to the existing KERNELOFFSET description
> > (Documentation/admin-guide/kdump/vmcoreinfo.rst):
> > 
> > ===
> > KERNELOFFSET
> > ------------
> > 
> > The kernel randomization offset. Used to compute the page offset. If
> > KASLR is disabled, this value is zero.
> > ===
> > 
> > I would say to some degree there is also inconsisten with regard
> > to /proc/ files existence:
> > /proc/kcore    is enabled by CONFIG_PROC_KCORE option, while
> > /proc/kallsyms is enabled by CONFIG_KALLSYMS option.
> > I assume drgn expects both files exist and does not work otherwise.

drgn doesn't use kallsyms, partially because it's not guaranteed to
exist as you pointed out, and partially because it's slow.

> > Nevertheless, it is still possible to refer to only one file for
> > symbol resolution and use an always-present symbol. E.g _stext
> > could be leveraged like this:
> > 
> > # grep -w init_task /proc/kallsyms
> > 000003ffe13e9400 D init_task
> > # grep -w _stext /proc/kallsyms
> > 000003ffe0000000 T _stext
> > 
> > 0x3ffe13e9400 - 0x3ffe0000000 == 0x13e9400
> > 
> > # eu-readelf -s vmlinux | grep -w _stext
> > 178112: 0000000000100000      0 NOTYPE  GLOBAL DEFAULT        1 _stext
> > 
> > 0x13e9400 + 0x100000 == 0x14e9400
> > 
> > # eu-readelf -s vmlinux | grep -w init_task
> >   498: 0000000000000000      0 FILE    LOCAL  DEFAULT      ABS init_task.c
> > 182344: 00000000014e9400   8960 OBJECT  GLOBAL DEFAULT       28 init_task
> > 
> > I guess, the above holds true for all architectures.
> > If so, I would suggest consider using that approach.
> > 
> > Having said that, we will try to turn KERNELOFFSET from a synthetic
> > value "Used to compute the page offset" to what drgn expects it to be.
> 
> Thinking about it now, I'm not sure it makes life easier. Because then
> we'll have some old kernels with the current (unexpected) definition of
> KERNELOFFSET and some new kernels with a more standard definition of
> it, but if I read vmcoreinfo, how do I know if the value has the old or
> the new meaning?

I wasn't able to get real KASLR working on my s390x VM, but what I found
in testing without KASLR was:

- Before commit c98d2ecae08f ("s390/mm: Uncouple physical vs virtual
  address spaces"), KERNELOFFSET was not set at all (this is expected).
- After commit c98d2ecae08f ("s390/mm: Uncouple physical vs virtual
  address spaces"), but before commit 56b1069c40c7 ("s390/boot: Rework
  deployment of the kernel image"), KERNELOFFSET was set in a way that
  drgn understands even without KASLR (that's a little odd but fine with
  me).
- After commit 56b1069c40c7 ("s390/boot: Rework deployment of the kernel
  image"), KERNELOFFSET was set "incorrectly"

So at least for no KASLR, the breakage has been limited only to the 6.10
rcs, which isn't too late to fix. I'd be curious what the behavior was
with KASLR before 6.10, though.
