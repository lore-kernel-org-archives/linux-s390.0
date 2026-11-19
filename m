Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795073403;
	b=qTGzFtbwCxSoVFnyZQDI/VelSk9za76TYnRoLZHTpwxIvD2P+QvW6f7hHyjqlXmb5nIi
	 xcO2fzaOY2LiFxBJzXJqot3Q3H9sZdNz6nbxblbbKzkggHDEkQkngCSYv/ELu+4FOc3Nu
	 bzDkXDFxwBsadZ7jEfQd6+QvIOuwiTK2az1hUCNPnQrAXDem2Vxi9Kk07M62ihydCcfJD
	 ztwRII8UYC0qr5H8OhmKs6EOxnjMsJGGJ6ewffvUNeqEaCPAsQO/oEwImCxtGdbdUnPQk
	 zZ2CT1WdUI8NZd8+z1tOSaqJbYSJB3ALy0fn7ptN55x01y25UWSzF9YRQp3ugx/fDuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795073403;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=Klcqtq67J8++CxJ47wWJ4KmRtmeIU5oN8tRyALYYbAY=;
	b=VQycO0KS+x7tCkPI7NMtST00ay9qmtNOv/IroIHs2iMb5nPNNmp8Mofp9gL7r+mCX5Df
	 fp6ZYcsVBo8vd81kC1rbBeNGpZNa+IcoNtqlBT5Vc23cz8EsKbXdR8KP49s5eppcUvHlf
	 vkVn4ZBtW9kOO+N3nMxQM/pcdp+xalbu11Q87yDYx79aE3wjHEQE40IayVBrl6CFScpuN
	 Aj+tV4rz3/XFdjLGxP9GOstmO3aOKEZW0aY0EixKksWI0ELdia/K9+1xYwd5vI/I5vEht
	 igF0+HoRPir1CzAgcke+L4Djcjj98yn7By5S7XeazmdyZFpZh1p30u7C3b2UCmpl2UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.170
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46E3606A32A
	for <linux-s390@vger.kernel.org>; Thu, 19 Nov 2026 07:30:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D46E3606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5eae12762c9so695162e0c.1
        for <linux-s390@vger.kernel.org>; Wed, 18 Nov 2026 23:30:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795073402; x=1795678202;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Klcqtq67J8++CxJ47wWJ4KmRtmeIU5oN8tRyALYYbAY=;
        b=TORrw3Irw8zhYbVQCrw+9+2JDbyJyslq2YZFMdiWnz0WjS4/txRN/lcujQqYWLdK8k
         S2/WpiNVee3gTZmcsheLK5DqHiXdBiaxQ3ZSU+zgyCDa28inAc8zS9S/zdTzU2x9aWQ7
         2pBhuo7A29E1/hqg7pqCSPoogPF9WohyvBJ9TG7+dvmAl0Py/oSWurg+0xxtJX8LSXHM
         scuoT7C+IF29r5UW2/gVJl5p4Ti98faGohYxag+KIVbEUAo/eTEMEKKVJzLLZVPG0L/M
         T0e6oJH+awFihdioe2NBLAlZEUEbuWqiygNnr2d/6DGog4woh2ULO/lgtYYFZwSeU6Ai
         +zVg==
X-Forwarded-Encrypted: i=1; AL+hErHfJUxu4BHs5/etW1FlYOGLifUt0JSJIFW2uQACk81o62K5K/kLQ/V9BWbjVkim0E94bpsEO0f0LWXm@vger.kernel.org
X-Gm-Message-State: APuU4Z8CqMAgJA2Jyym1mnJUny6CaJyOMD84Rf0rp4J/AfwHXCSboMtJ
	2V2xCcH51/bFqoo/bdYS4KFsaVUPqqfprK7+mVHqMsbP1xJc5ZIqpMovuz8omq6W
X-Gm-Gg: AYBFou1alukq4CINoOncOo33WHc9hnC4zpOuUU7NNYoVgc7xvK5vz/ckFPflbOzNotg
	LurfrE6vV0g2/txVDUE6YfiL27T73umLm2OFRS7CqxA79TlveD62UPhvp/3S0tiKqYVIEjJvYT6
	US9JbDE80m/CPzx2VoMcRGzNz3nkYFs8iaemf1GMgpxucUfuF887Jpwg2VnhN4w0I4zRmCkJjBf
	plThgjKIzvmiLMJZhLzpDqAzKZW7L5PFiPfrwfe7bRgqWRLHT9eDMMWMAHas1hq1wNbCTh6Vo/D
	QaTXfOm4NET/UFYW1zQp6cBOxqoqyR5XRUBnvdXhBbY2h47heL3EKxv4UuJi9hWgFdf+Ogi5Zbm
	3soPcrT3IAbrgxRf9YElvFBLOzjamtCb5HDLAw4SSuly3gdIWizkP9ZYPsfmHM8zNEVlqTXF7DL
	8h4S32dsD9cMxzl6jd3BfQ9EJSH7TDN1KKcFy8YyRP7EjaBsDvxi9Ar6Zno2MP8cTlInOfz1NY5
	aP1z8nkPTbQ34EIhW3acZhXHhCpkDaHQIQX5UI4MOTSygOJ6JA84vqHxIs2ez3Mg6TiXy4uMwsv
	neu49fHOnjZilCJOz6jYp9gcNXATYfWMIsBs7I+Z1kj0YSpP0AALQkPReKbHM5hI/G4=
X-Received: by 2002:a05:6122:8b03:b0:5ea:c084:6f19 with SMTP id 71dfb90a1353d-5ee64c6d8e1mr2080706e0c.12.1795073401672;
        Wed, 18 Nov 2026 23:30:01 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee64e4d85csm3688657e0c.4.2026.11.18.23.30.01
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 23:30:01 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-9908c849564so559384241.3
        for <linux-s390@vger.kernel.org>; Wed, 18 Nov 2026 23:30:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGRwopwy3QGqY97DK1IYFWvvBcJfOQHWDU96sjKbLl2Xbm/71i9O46c9Q+cfRJI6E+O7EfEoDtO5xdJ@vger.kernel.org
X-Received: by 2002:a05:6102:e0c:b0:7b3:8f0a:f76c with SMTP id
 ada2fe7eead31-7d6ba35b7d8mr1806982137.13.1795073401089; Wed, 18 Nov 2026
 23:30:01 -0800 (PST)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119-arch-kconfig-v1-0-37c276fe4d26@kernel.org> <20261119-arch-kconfig-v1-2-37c276fe4d26@kernel.org>
In-Reply-To: <20261119-arch-kconfig-v1-2-37c276fe4d26@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 19 Nov 2026 08:29:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU2u9wDiqp+H-aDWSRcT8_VtDg1NS0gVmqYYm9rt2ZSrA@mail.gmail.com>
X-Gm-Features: Aa3M54rf5ygj8ORK3fy8Y6Bg5UcrfzvYekQ-eoJmIgxSYs0ZeBrecHV4-2jERSw
Message-ID: <CAMuHMdU2u9wDiqp+H-aDWSRcT8_VtDg1NS0gVmqYYm9rt2ZSrA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arch, kexec: declare kexec and crash capabilities in Kconfig.kexec
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <baoquan.he@linux.dev>, 
	Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Paul Walmsley <pjw@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Rich Felker <dalias@libc.org>, 
	Russell King <linux@armlinux.org.uk>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Thomas Gleixner <tglx@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, x86@kernel.org, 
	Alexandre Ghiti <alex@ghiti.fr>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Cong Wang <cwang@multikernel.io>, 
	Mark Rutland <mark.rutland@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, WANG Xuerui <kernel@xen0n.name>, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Nov 2026 at 07:17, Mike Rapoport (Microsoft) <rppt@kernel.org> wrote:
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

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be> # sh

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
