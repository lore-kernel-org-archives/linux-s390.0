Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3836D1B86C9;
	Tue,  9 Jul 2024 19:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720552906; cv=none; b=F/adwVnX1TJp0U0VHG55GXqiHo1N1X4Ri/7RaUDAjKnS5yoR4H0rtRaG+cgir/iidX7JUDZl57mT3Ix3ZMTKVK1HaN33cLZb+l25/YhfBRFEH9mSMWl8Fbj8T2G6sG46j6Rs1hTz4yj0kRjKdbluac5uHoyTgi+Aa3XYdYRs7Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720552906; c=relaxed/simple;
	bh=xAxthHKUEpQEvyQA9lDwqIGY+oN7H3FxlTghTd6iOec=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BH8JFyGBwOt8CDBdOKuYwaBm4gVos/F2Q32WYVnK2nqrsyrV1nefzBwM73St9mKmwnVcMVS0TV4AFZGyTmFznu3tuYBKtNQBkT40MugMlbf46x94X7/wuZsaqYvpLjbUmayHi/3i9YEakssWDXD36y5M5sHy4HRP9C7VArWI1WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=Qlp2C0Jk; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="Qlp2C0Jk"
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 2D03C1E2760;
	Tue,  9 Jul 2024 21:21:42 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1720552902; bh=hA5TZjqsgvNc3HE9SPpNCYB9xR+VakGRPgdr4ptP6KY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qlp2C0JkILOEGEVA4eGxXfG1+4gffl4KfsBdEwEkkLAr/5ovMcv0qB6p9cpMiklI7
	 mMm3uyJEfSweOhJOqQBpvspdPsdTjSuontbDvjI86sTxbcpAbO15Qvt+I21eQq5Fdh
	 +Fgu6uzXso/bDwXqEePlESShnyt3A/CSBE9yS6HniDrhrgvfzGsCp9NlBYsrMoeVeP
	 yxUuRUjmr47HlBMjfzeFxlufke3Kc3wt+fitKQr0h8+HjJBSFI+AFtxbHz0oZRTN2u
	 lXMuRCFJlNaSfUAIUkI9ZGZEKFZwsR9DFui6MWisQMoMMO9lEahcXATziAu0p6yOeM
	 ODizR1X/DqU8Q==
Date: Tue, 9 Jul 2024 21:21:41 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Omar Sandoval <osandov@osandov.com>, linux-s390@vger.kernel.org, Ilya
 Leoshkevich <iii@linux.ibm.com>, linux-debuggers@vger.kernel.org
Subject: Re: Incorrect vmcoreinfo KERNELOFFSET after "s390/boot: Rework
 deployment of the kernel image"
Message-ID: <20240709212141.31160508@meshulam.tesarici.cz>
In-Reply-To: <Zn1uTZdlYNaRFUqK@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <ZnS8dycxhtXBZVky@telecaster.dhcp.thefacebook.com>
	<Zn1uTZdlYNaRFUqK@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jun 2024 15:51:09 +0200
Alexander Gordeev <agordeev@linux.ibm.com> wrote:

> On Thu, Jun 20, 2024 at 04:34:15PM -0700, Omar Sandoval wrote:
> 
> Hi Omar,
> 
> > Hi, Alexander and Sven,
> > 
> > I just got around to testing drgn on s390x on 6.10-rc4, and it appears
> > to be broken. I bisected it to commit 56b1069c40c7 ("s390/boot: Rework
> > deployment of the kernel image") and narrowed it down to an issue with
> > the KERNELOFFSET value reported in vmcoreinfo.
> > 
> > On my test kernel, the ELF symbol for init_task is 0xc96f00:
> > 
> >   $ eu-readelf -s build/vmtest/s390x/kernel-6.10.0-rc4-vmtest30.1default/build/vmlinux | grep ' init_task$'
> >   72273: 0000000000c96f00   4352 OBJECT  GLOBAL DEFAULT       18 init_task
> > 
> > And the address in the loaded kernel is 0x3ffffeaaf00:
> > 
> >   # grep ' init_task$' /proc/kallsyms
> >   000003ffffeaaf00 D init_task
> > 
> > 0x3ffffeaaf00 - 0xc96f00 is 0x3ffff214000
> > 
> > However, this doesn't match the value of KERNELOFFSET in vmcoreinfo:
> > 
> >   # eu-readelf -n /proc/kcore | grep KERNELOFFSET
> >     KERNELOFFSET=3ffff314000
> > 
> > It's off by 0x100000. This causes drgn to compute the wrong addresses
> > for all global variables.
> > 
> > For context, I'm testing using QEMU emulation on an x86-64 host. Note
> > that it logs "KASLR disabled: CPU has no PRNG" early during boot. My
> > exact setup is:
> > 
> >   $ git clone https://github.com/osandov/drgn.git
> >   $ cd drgn
> >   $ python3 -m vmtest.rootfsbuild -a s390x --build-drgn
> >   $ python3 -m vmtest.vm -k 's390x:6.10.*' bash -i
> >   # python3 -m drgn  
> >   >>> prog['init_task'].comm  
> >   (char [16])""
> > 
> > That should be printing "swapper/0".
> > 
> > Any ideas what's going on here?  
> 
> On s390 no kernel symbol exists below 0x100000 offset within the
> vmlinux image and thus this part is never mapped into the kernel
> memory. That way KERNELOFFSET turns out to be off on value of
> 0x100000 - and that is what you observe.
> 
> That breaks the way drgn finds a kernel symbol, but does not
> exactly contradicts to the existing KERNELOFFSET description
> (Documentation/admin-guide/kdump/vmcoreinfo.rst):
> 
> ===
> KERNELOFFSET
> ------------
> 
> The kernel randomization offset. Used to compute the page offset. If
> KASLR is disabled, this value is zero.
> ===
> 
> I would say to some degree there is also inconsisten with regard
> to /proc/ files existence:
> /proc/kcore    is enabled by CONFIG_PROC_KCORE option, while
> /proc/kallsyms is enabled by CONFIG_KALLSYMS option.
> I assume drgn expects both files exist and does not work otherwise.
> 
> Nevertheless, it is still possible to refer to only one file for
> symbol resolution and use an always-present symbol. E.g _stext
> could be leveraged like this:
> 
> # grep -w init_task /proc/kallsyms
> 000003ffe13e9400 D init_task
> # grep -w _stext /proc/kallsyms
> 000003ffe0000000 T _stext
> 
> 0x3ffe13e9400 - 0x3ffe0000000 == 0x13e9400
> 
> # eu-readelf -s vmlinux | grep -w _stext
> 178112: 0000000000100000      0 NOTYPE  GLOBAL DEFAULT        1 _stext
> 
> 0x13e9400 + 0x100000 == 0x14e9400
> 
> # eu-readelf -s vmlinux | grep -w init_task
>   498: 0000000000000000      0 FILE    LOCAL  DEFAULT      ABS init_task.c
> 182344: 00000000014e9400   8960 OBJECT  GLOBAL DEFAULT       28 init_task
> 
> I guess, the above holds true for all architectures.
> If so, I would suggest consider using that approach.
> 
> Having said that, we will try to turn KERNELOFFSET from a synthetic
> value "Used to compute the page offset" to what drgn expects it to be.

Thinking about it now, I'm not sure it makes life easier. Because then
we'll have some old kernels with the current (unexpected) definition of
KERNELOFFSET and some new kernels with a more standard definition of
it, but if I read vmcoreinfo, how do I know if the value has the old or
the new meaning?

Petr T
