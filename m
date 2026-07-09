Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D57243B492
	for <linux-s390@vger.kernel.org>; Thu,  9 Jul 2026 18:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622489; cv=none; b=FLB0a21vJ6yn4HRh9sNX2PUprLeYhPqUCpmzuIZYCuKK1+FCepcNj8iSSASZEK5o664dqnkfECxj+C9BeqleGlyL8TBibFnzJzhy/VOa4Ntj1yAJ+I6XKZ9ETGnTrOIr4Nk70NYtfyWYrk9RfMAr/1rCLP+Ezi5E4CntvabgwrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622489; c=relaxed/simple;
	bh=x/B73ZAx/OZvPWDOjgMBsyCuVlSuIzuC3lusVvx1Is4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tavuu8X24XjO59De0MIH3ctzG7m0OxOxMSVNIh/BTgGJ46ELsjMJ4LmFBMhMxzzJWD8SLBzLARXb4K6bvXcd0BibDyRD1BdqcpAg1HfJQkMlzspzttYgx3z3OQH7WFBVO13CaPQgWCO7zW46ZA/im4L2JnYht+eRXMZEicUyWs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVAXJFFm; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVAXJFFm"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8484f229529so67307b3a.2
        for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 11:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783622485; x=1784227285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aq4oHRjffhbqNLpraCJHXQbfXmiONMD/vVc6qcgWJtk=;
        b=AVAXJFFmK0nNQhIep2Zx7bQdFMVddMSEs+L4Gx9GRroa0HtOoGG79MHkpkbb+yGdq9
         mMa24LFtE6V2hXx+q5AovfFeAZSs/VC6/AeG9dU48X7N3xSCHS4uqGNtj17QWFTJdJSe
         JB1/zywZB5SQMADKuoiUUPLFcYWeOOFBCpUjBEr3aGMRxM3D4MNpkS+ANOiGWTtXyZkC
         if6xGjcnc8pBFlVWHJb9XXQOdHLeb2JwsQH4YA+0ivE+gjgRfvDY2hsDr0jpUu6miCVx
         yVF1GgWIDOlyJipWCi8tIkQKFScHFAiDOIXyB8qnWiDKSR3Uw3k6deV1NZVpP7BL0p10
         mCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783622485; x=1784227285;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aq4oHRjffhbqNLpraCJHXQbfXmiONMD/vVc6qcgWJtk=;
        b=Tm6GmLoHiHeD1l4wBzXjoSqpQIb95UGsmFlO6f3O0QkFVoYNNTfx7K4Y6vWKbxWU6y
         IKz5H+bpA+rmACZzHpWfdovZVpeakCynYGU5um4BMlBR5Hqmkg7xr3qtEnH773LS7Pib
         yW3A4Q3WRxPxxMlJ2WiFWa5aI1fHFAmsMREX/njVnhZ1/0kPDBNjvfKcAGcyvWTAMJeV
         RMzG8Nd3CXXTIcIS11fOAgqNUkmzWCV8tJmJ4ivQVF5JvDBfjy67fKKU/WSgmlRwTCJZ
         OlIhZqBNV5+IZ4cnsmFVW4t1h77jH37s50rHl1ilwkLmolTv4g7IjhTFkbhScfw26Znk
         OIZA==
X-Forwarded-Encrypted: i=1; AHgh+RqoQGBEc2VllpquIm/CQ5lfLurpSqmJcQIEr5LxX1krvly/K1fRMr0bcSlf1qCncuPCL50IbroUO3IU@vger.kernel.org
X-Gm-Message-State: AOJu0YwcPOvujTpR7lmK7rjxi4lJL35RFin5fr2o9AuaaFeqTTLDHuj1
	taMO57r08opHZgLuw8KHnjl9XedtgNhezefXdd5PY2i1/BvXqvq6OfDp
X-Gm-Gg: AfdE7cnPKUdmUz9XJFuL9oJoE3GccWkKGOR92L+9s+ZfJ3yxkPW3TaqBRao+qAIjTUP
	6NgMbkhwxKpJHtBE084F1S0UE5itG+dHzrBtAtOX/vk1Jse2gQvXumrcVoqJrxV/NxHGK2Q+rOQ
	MvRQmihKZKdhty7oTP2vcH/87EA0v8D1MnAj7qjjQ70PVQ8nKXvcm1W8sL+8wGbm+59yLGITR9c
	fWybr7Gnx2uK2SX3oTVVq9LVErRnNcVH2LXDrOiuAD07K84XRryt3/fgp+zMgByMahGPhzPOiwC
	vvG/WYjsXshXbI8T9+br0z7ler92+V//RjziW3rn73102GzSFEUM+BQV+pg0adQQFk27KbxSCEF
	ljFKYu7KVFG/tilbbGBIpO8SQUOnvBxDadswGcuciCjbwK1toe3+jxe6oD4IIfeiJh7pAzRy481
	d1E8gliFXIU7xRrg99blv2C/FaaexawFyW9LkJIOeKMMroNt+zxr7NotriUzt9
X-Received: by 2002:a05:6a20:3d0c:b0:3bf:80b8:9c8a with SMTP id adf61e73a8af0-3c0bcead1e2mr9967332637.6.1783622485265;
        Thu, 09 Jul 2026 11:41:25 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d7c8bsm35321002c88.12.2026.07.09.11.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:41:24 -0700 (PDT)
Date: Fri, 10 Jul 2026 00:11:04 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Helge Deller <deller@gmx.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>, 
	linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-um@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, 
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, 
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [patch 05/18] powerpc/syscall: Use
 syscall_enter_from_user_mode_randomize_stack()
Message-ID: <ak_rL1RfdQVJ6zeq@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190253.918861529@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707190253.918861529@kernel.org>

On Tue, Jul 07, 2026 at 09:06:15PM +0200, Thomas Gleixner wrote:
> syscall_enter_from_user_mode_randomize_stack() replaces
> syscall_enter_from_user_mode() and the subsequent invocation of
> add_random_kstack_offset().
> 
> The advantage is that it applies the stack randomization right after
> enter_from_user_mode() and thereby avoids the overhead of get/put_cpu_var()
> as that code is invoked with interrupts disabled.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  arch/powerpc/kernel/syscall.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> --- a/arch/powerpc/kernel/syscall.c
> +++ b/arch/powerpc/kernel/syscall.c
> @@ -2,7 +2,6 @@
>  
>  #include <linux/compat.h>
>  #include <linux/context_tracking.h>
> -#include <linux/randomize_kstack.h>
>  #include <linux/entry-common.h>
>  
>  #include <asm/interrupt.h>
> @@ -19,8 +18,7 @@ notrace long system_call_exception(struc
>  	long ret;
>  	syscall_fn f;
>  
> -	r0 = syscall_enter_from_user_mode(regs, r0);
> -	add_random_kstack_offset();
> +	r0 = syscall_enter_from_user_mode_randomize_stack(regs, r0);
>  
>  	if (unlikely(r0 >= NR_syscalls)) {
>  		if (unlikely(trap_is_unsupported_scv(regs))) {
> 
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
