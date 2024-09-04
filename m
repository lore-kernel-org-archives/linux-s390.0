Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170811E0B8A
	for <linux-s390@vger.kernel.org>; Wed,  4 Sep 2024 18:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725475920; cv=none; b=JbjCL37kdV+DhpeUbxnbMO4pyvg9FDDLBmLIpud3AAh5xuznJLi9Ew+3es0+iDkj0VnW8/iQBN6talGTuX+hq6PngqcyXRQsezx1nRWdMC+XASYQ/nl16/t+W14xofafTZNR8MSzlheo1sDrVsGei8kyPGi2EaZ1sQ5M4efY/ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725475920; c=relaxed/simple;
	bh=eoj+VLOqGJa6LbdWtGkk6SXvNIMddi3dJ20lVqlAgkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2AHuXZ2m5XNmCYokker6SYiAAC8iO5rgarnuh49kEEGxHDXkoXA9QNTKJwQKRgjbZMy1Rhi2RfT8jBoF7braJQumerUZzyCXsObvf7kNJZDYuRW1ffl+LGnnsYUAm2l4xpCoiP/QKxVtRbFvaVNKNnBTsYQ7eqrD4X7WXks0fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=IzEmcNyK; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="IzEmcNyK"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7cd8d2731d1so4558229a12.3
        for <linux-s390@vger.kernel.org>; Wed, 04 Sep 2024 11:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1725475918; x=1726080718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O6ZVaLfTmncaiFC3xCMQJd5Si2uYtr9Mg2hPai6p2Zs=;
        b=IzEmcNyK1v9vlTdaK4RPuV6wC1TlHPRAFRKHo/3OXzA3xD4sTLudbsYe5ZmMsoeKAa
         HqYz7zKizlvCocbvqVirQtVcJHjhqdkHX5jbjyi7mEjPNmTw2CtZAChH9tsIGnr31W34
         mUb+81c1cyLJMcCyiYr54F1PtE68RrLS+7b+Moblb2axPGonufIgAiJ7I+m/LCSV5g4g
         G7XEuW8Wa3xnHZcXkVfcY/tzbCZj0sQRsuBz2NUn+Jfc/0+xojqv3DPOXe2lOrKuwTaO
         9/caw2ck37/3nFwELF/atx00pKlQnXm75R3f3//3PPQsyHsNRB8XTKadJ2DHafShOzJg
         DAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725475918; x=1726080718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6ZVaLfTmncaiFC3xCMQJd5Si2uYtr9Mg2hPai6p2Zs=;
        b=f4q1ozdGEF8bTrjmC6aO2lt/3cWHGtiFK2CrokGMpj11qytJdJdxfH5KrvLK+aD8j0
         txwWXyWWonRIH2AcGXNRj/f/dcWNe7H0hTVvJAU+lF7h0FH4fUZ35dFFm1YeeOaSnlHr
         r+OAS99GiHzpWg94ASPa5QXxw/Z7TZ5BpjDDM80QPgbzdd2RzVeOpnFc2DUgAukxIrAP
         gX5R3g4voRno6/bum0lZ/r2UTIn4QO3ZmWFrNraK84qQJQ6aP6itMZqdBXvEwKvQcIMR
         adQzA+e/03FW6/+Cg04ALoW0T1jurPYO4XyFWmekS/xMYuORmfc8iUo4V1BMc3uab9CY
         AvnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPX7qHP773+EfKWGpQUnmnLRLbRp/Ip8Wks756sJR5aDXeCIfDSJ/0oHM9tQ/JLtiaV6TtxCXJwvlS@vger.kernel.org
X-Gm-Message-State: AOJu0YzPkfR1t9QQSLm3+sqRmDp8XitutsrjGWeEI9uN9eEKftPIoGOq
	/O6sc+WEpSwvjOhPNJEajDSGiSDiJw6Wpu0v1wn1EOZq/mcFGiC3t1ZzX9s3R3k=
X-Google-Smtp-Source: AGHT+IGxM6h9S0OM8htpvDl1qRKbi0apkGb/RUsvutqrVBDacyDPb7hJbcL2mjRY0/SNPdo0kubr6w==
X-Received: by 2002:a17:90b:3903:b0:2d8:8430:8a91 with SMTP id 98e67ed59e1d1-2d89728b29emr15224775a91.10.1725475918042;
        Wed, 04 Sep 2024 11:51:58 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8e1ae1b3fsm6674555a91.33.2024.09.04.11.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 11:51:57 -0700 (PDT)
Date: Wed, 4 Sep 2024 11:51:53 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Mark Brown <broonie@kernel.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>, Guo Ren <guoren@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org, linux-csky@vger.kernel.org,
	loongarch@lists.linux.dev, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-mm@kvack.org, Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH 3/3] mm: Care about shadow stack guard gap when getting
 an unmapped area
Message-ID: <ZtisSerxbnDaWr5l@debug.ba.rivosinc.com>
References: <20240902-mm-generic-shadow-stack-guard-v1-0-9acda38b3dd3@kernel.org>
 <20240902-mm-generic-shadow-stack-guard-v1-3-9acda38b3dd3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240902-mm-generic-shadow-stack-guard-v1-3-9acda38b3dd3@kernel.org>

On Mon, Sep 02, 2024 at 08:08:15PM +0100, Mark Brown wrote:
>As covered in the commit log for c44357c2e76b ("x86/mm: care about shadow
>stack guard gap during placement") our current mmap() implementation does
>not take care to ensure that a new mapping isn't placed with existing
>mappings inside it's own guard gaps. This is particularly important for
>shadow stacks since if two shadow stacks end up getting placed adjacent to
>each other then they can overflow into each other which weakens the
>protection offered by the feature.
>
>On x86 there is a custom arch_get_unmapped_area() which was updated by the
>above commit to cover this case by specifying a start_gap for allocations
>with VM_SHADOW_STACK. Both arm64 and RISC-V have equivalent features and
>use the generic implementation of arch_get_unmapped_area() so let's make
>the equivalent change there so they also don't get shadow stack pages
>placed without guard pages.
>
>Architectures which do not have this feature will define VM_SHADOW_STACK
>to VM_NONE and hence be unaffected.
>
>Suggested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
>Signed-off-by: Mark Brown <broonie@kernel.org>
>---
> mm/mmap.c | 10 ++++++++++
> 1 file changed, 10 insertions(+)
>
>diff --git a/mm/mmap.c b/mm/mmap.c
>index b06ba847c96e..902c482b6084 100644
>--- a/mm/mmap.c
>+++ b/mm/mmap.c
>@@ -1753,6 +1753,14 @@ static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
> 	return gap;
> }
>
>+static inline unsigned long stack_guard_placement(vm_flags_t vm_flags)
>+{
>+	if (vm_flags & VM_SHADOW_STACK)
>+		return PAGE_SIZE;
>+
>+	return 0;
>+}
>+
> /*
>  * Search for an unmapped address range.
>  *
>@@ -1814,6 +1822,7 @@ generic_get_unmapped_area(struct file *filp, unsigned long addr,
> 	info.length = len;
> 	info.low_limit = mm->mmap_base;
> 	info.high_limit = mmap_end;
>+	info.start_gap = stack_guard_placement(vm_flags);
> 	return vm_unmapped_area(&info);
> }
>
>@@ -1863,6 +1872,7 @@ generic_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
> 	info.length = len;
> 	info.low_limit = PAGE_SIZE;
> 	info.high_limit = arch_get_mmap_base(addr, mm->mmap_base);
>+	info.start_gap = stack_guard_placement(vm_flags);
> 	addr = vm_unmapped_area(&info);
>
> 	/*
>

lgtm

Reviewed-by: Deepak Gupta <debug@rivosinc.com>

>-- 
>2.39.2
>
