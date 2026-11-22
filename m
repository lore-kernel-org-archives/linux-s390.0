Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795316692;
	b=LhmQU8VMEKcJc93dmMcsBchMiQTSKqT4NMZp44q+FGJhs9VCrEPQHE81dBH46IZpsi+O
	 CZABJvI8PsS9aJaNu53bZ6VOzpIaRwHvjRULYwQYgod40Ox1/SvySCy/kgZLlLBRXGRPj
	 f15/Ojr3clX5R94Ze/gztT58Zdc+Mf+TQbU2R5k4ZhaG0pHgrNlzHPthGzESsSoC3PdiK
	 X6o6k8sVsGMk4vVUmYB0957tpnbwxvathB+M/gu8VN1zcxYpn5gOKt1NbE+lPrudcOMG8
	 eDlbLc3SmjCYs6LOcVAJeOwIudfQiV3UuDNka0v0hozp9UbRMrBoiV8V7KqPGK5tuEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795316692;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type;
	bh=NieCLCvG+gDw8VjVQsEmj+Xb3Nuvde1xSdj6TYYBmIA=;
	b=M+N/byLkb3GB+zurUt35tKd2rdnnbveSBgg0G80dVfYTwk6USSX0Y8cAsGB2m1to1Abe
	 fhahCUDGOKV5Pkl5paw3tAoDKwL+bm44X/Lh7WAGxmNKSLSAbJarWr1wWwE/7bCTwxFRG
	 BlS1zQJDll6fbN6XOFrgXaST7Wjlb3PrwFL21JaHaC5UJ/n21/qgJBdAThwxDeGwM0/iI
	 K2p0Wv/wr6WR38dK8zliASZiuwEXjf8vhSfT84c7glQskRmYMi+4ClYpFro7e8Ja8tkAd
	 1qnvZ3nBh5ltVTGwAdgDZFWajt6oLla7xTU8mjVLXlbbmkht7WAR02FxUuSTzURqyMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lQMapLMR;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDA0606A330
	for <linux-s390@vger.kernel.org>; Sun, 22 Nov 2026 03:04:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BDA0606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lQMapLMR
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-38564b4b017so2258387eec.0
        for <linux-s390@vger.kernel.org>; Sat, 21 Nov 2026 19:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795316691; x=1795921491; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NieCLCvG+gDw8VjVQsEmj+Xb3Nuvde1xSdj6TYYBmIA=;
        b=lQMapLMRecxhRuMkTSymbForunIxX0OPXsGQ1CXe025r/577yULQNYi3TNrBG53/Qv
         zYU80ixAjK16x1kduXUqa1QZW9W/3ti9d/2xwfANhvwcppx94XY1wfu52uKp1wNIi+xo
         0BbROgPXyu0B62JpFc4+zEJIoiLBcGXeP+W6/munvXDcClY8J5U7eqCSCyRjBp3WeH4+
         q1p1SE27fCRmjWxB4WY3p9l7b9yn5x1FejoLmUjB8Y+BhmVh9oZGKVtoBu6VvuhXecB+
         kqHQVq97TpxJ2ylXI5iv8vW2n/kYW3PMkK+9IBmWOkrDx9AQECQxv8quTTJlItW+6/Cb
         tThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795316691; x=1795921491;
        h=content-type:mime-version:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NieCLCvG+gDw8VjVQsEmj+Xb3Nuvde1xSdj6TYYBmIA=;
        b=T/ptdWXgU9kTZ3sMZyL/BeS8T2OuIUyzGeqDPIJphOBVBVgvFcvE4bAVN3H2yfamgi
         A1fdR2tbtoxsN1S5BXKLpTYQ2KjS4109WJXTPLNq3eVGV3xYJe7KMwWmkrnfnz4a3box
         3Mlpw/ESGy5pT7Hn30xGRl1QKWbZk43BU0jqjhK7qS9eky3Z6NMnhj7fs5qy0Zr44Ffx
         Q3GnxBHdyCiM7KlnPC7hvBKNpKy0uS6hrYH68Sh4hy7D988JObpbIVDmKOyikrvsJgI4
         DBr1/kMn7dJMpb6L515Nn7cgW7AySJAjmdM0Zt0VRQceR0z/ywRXCQYSmNYf4e9X77Kr
         gQIQ==
X-Forwarded-Encrypted: i=1; AL+hErECytLXX1GzqrgfAEMyWrV3qQu+VNqNulPCgmsKARQywzVxnZzkzDRu7Bt5SFyX72HgeQJZewQ2JtMi@vger.kernel.org
X-Gm-Message-State: APuU4Z+5I2PVYKoeEocMUDXSw98UOj2Pak5DwFgxE9uaGjY+2SrXESPt
	EPkLF4vLgH9QRAPhDdydODrgAd1unsdkCHAE/7nhcSD8HKSZIeqC8w3F
X-Gm-Gg: AZFdTZcfeGvoq6/y6HZQF3flFOjMP4fRG8PX1p1us4j3VE/92klUJCbJhj7VAJ7dcbx
	N+ZrwCaBQDX6dTvlMVO5GuxXn//WoD4lDT06XRo4FG8mmdWMIVtwBE24mD/nZaeAEgxlfQokJei
	rlEl1wMMsOuDZ4M9hha3CB4PeIb9bMpf06+yY7uMF2HZNuQyDGrv0qswg/uSx5HS/maSjs2sqws
	GIiSbBCABtgxX/d6856UmzsteIQRM1jYMnMmgpygypdCFk2MG84QBjPOZa7CX4JBu+HxK1DdjAg
	o3Z+4hx376RyvCe/YDVCQHQL1kYhxOi6N4Vf98PP9csU/fCe0VjSS2UR+dgFQ0uwtxbODQO2giC
	V4bpU6Ve3MwwTSEY5nYw8rY0BRbgcKgXCXpUEiGZ3kh4R8pcBsnJUKOu5DxtgpiIkIoKWsUDplx
	1jwGHBWv7La8+EW5ZFYPukwD2Gcg8k66zKxORRK8I9zVN+gTY6NRenGR3GC1b3YT57R/cUlXsMl
	AZD4bnXL03Lb4K0OrACV+pHqgLBfxSmo/WxuE83+TvqjAYsI0adE+eYD0LbdqRhf5hgees4RBGL
	1lJkAbEIIhstjN9cVBYgNNgXsbN0Sx2Ov0VAKRJWF+pAQe7v
X-Received: by 2002:a05:7300:50fa:b0:383:9f52:e54d with SMTP id 5a478bee46e88-3856ff52e83mr8869235eec.8.1795316691531;
        Sat, 21 Nov 2026 19:04:51 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567da4f85sm24302948eec.27.2026.11.21.19.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 19:04:50 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <baoquan.he@linux.dev>, Borislav Petkov <bp@alien8.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, 
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Paul Walmsley <pjw@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Rich Felker <dalias@libc.org>, 
	Russell King <linux@armlinux.org.uk>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Thomas Gleixner <tglx@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, x86@kernel.org
Cc: Alexandre Ghiti <alex@ghiti.fr>, Christian Borntraeger <borntraeger@linux.ibm.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Cong Wang <cwang@multikernel.io>, Mark Rutland <mark.rutland@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Mike Rapoport <rppt@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, WANG Xuerui <kernel@xen0n.name>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev
Subject: Re: [PATCH 2/2] arch, kexec: declare kexec and crash capabilities in Kconfig.kexec
In-Reply-To: <20261119-arch-kconfig-v1-2-37c276fe4d26@kernel.org>
Date: Sun, 22 Nov 2026 08:33:10 +0530
Message-ID: <wlq5k1ox.ritesh.list@gmail.com>
References: <20261119-arch-kconfig-v1-0-37c276fe4d26@kernel.org> <20261119-arch-kconfig-v1-2-37c276fe4d26@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"Mike Rapoport (Microsoft)" <rppt@kernel.org> writes:

> The options that let an architecture opt in to kexec and crash dump
> features, like ARCH_SUPPORTS_KEXEC or ARCH_SUPPORTS_CRASH_DUMP, are
> defined in each architecture's Kconfig as def_bool, and most of them are
> copied over several architectures.
>
> Declare these options once in kernel/Kconfig.kexec next to the options
> that depend on them, similarly to how mm/Kconfig does it, and make the
> architectures select them instead.
>
> Selection conditions are preserved, so there is no functional change.
>
> Acked-by: Baoquan He <baoquan.he@linux.dev>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

No function change observed in this patch (as described in the commit msg).

LGTM, feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com> #powerpc

