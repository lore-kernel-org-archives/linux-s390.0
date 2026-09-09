Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B80D3DA5AA
	for <linux-s390@vger.kernel.org>; Wed,  9 Sep 2026 19:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788982709; cv=pass; b=rrgo2PynklzIR5aZ51zmZRYPAEid+HD7kU74dKsi6app5iZGN7OxmzHqKYrYsDuxRRX5KzhWT8nWfBRlo1++umDrK0VQI9VBi3JeMzB8JFre67xZK+P7HhIHfXNAWHyh5kNJKS8CG694u4asnRiZfJhGWqfMqNoyqKtY63vA11Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788982709; c=relaxed/simple;
	bh=1ydOjuoTgA1JS+qa07cHIVSm0i9RHzfwwnuAwNBt4m4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ROnuLeTdhT4niFNo/yqVejEEZH56SiM/RHE50LnksSn69sZMX75KxJSfstwZbvDGU/uLtUQiNJpeFSp9XljhaX5E+1G7uFedbdtKtZ4Kuz5djYXb874Xqzqz2vhh5UKf2vu4X7cvyTrW4WUJIndK3MQ88EYMb4M1FtAE16gbqEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9V1mn82; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9V1mn82"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39666bed444so704844a91.1
        for <linux-s390@vger.kernel.org>; Wed, 09 Sep 2026 12:38:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788982705; cv=none;
        d=google.com; s=arc-20260327;
        b=jflvB3U173dUpume9X+U0EXEKATuI5zdSIdF8PRhd6mGvG0lrlD9XyLVN82ZPkzASW
         zpyg/P9zfLcnp2Pj3vFBOwuDLpvFvUpU/fLBi7tbtqrCViKdYGMkJ/4LAOTD3UppzA3X
         NM9IsGPCRiLddxeKTe1HK1bTNx0n7KcKkP4q23Kk7ZQyj/Fo/BG5SHRdPOhwdecZucL2
         G512Ei++/hKBHtVdmqG1DtljCHGYXGz3Vqt7r8b4rvHAF/xC+VstvJI+zsLtb2Q1ZAXw
         928WsDEfV6rTEj46GEo24rGWQz4zSVoEITfMBnUoJ+t63nNLFHlQ1RlxhBWS3p4h6ax6
         WJIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1ydOjuoTgA1JS+qa07cHIVSm0i9RHzfwwnuAwNBt4m4=;
        fh=j+EHw1EfwPCPC6kXF+cwFsSLoXCRKaOLY9sKUNZmizY=;
        b=Y/2aTyjXHiQW5YdQXuk06N5GtZyBel75ON+JRYF83SClDAR+mFFbeN8ho5GSY50og2
         qlNq1I/IGP4WcpVLquAjqw1hylavqR3FQjnYiAGV+l14zfjlOX2yeHHIhiMNloeEFNWj
         ya/hlLXUp2TTmFB9krOwEnd4sCSeinRjhhOssgEKA/AVuW/MpuYLLPEAsy/u/uFTCfCH
         7n8QSMBwUKP9p3feB+50HFCZtEJ/5q1Mwj450I+QL+b4PHaiXBsaefDLdV52KlUBcU2Z
         Xii0xw+hqEsqBhSLhsL53pFYWYEgJntqGmwj30gHD4TicyviCQ+GdkX26YHgKIOqaov6
         pEQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788982705; x=1789587505; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1ydOjuoTgA1JS+qa07cHIVSm0i9RHzfwwnuAwNBt4m4=;
        b=O9V1mn82dLJDJpoWkpJ3uIqIF6FnMmw8HKITWUuf0+5gF9tsWFQvJeqtuvXWVufZ6M
         WV9sS6d8PY3FlMamLDg2/HWYu2ToFT5hITdCpWxDuCc+cL4fMdLCp5VGqvUOnJ6dXJ8C
         8hPDf0onGOvKjlaqh834XmZcICJPaGL6gkNzUTEND5TaAJdRp8B3DRjO8U5MgUy+VG/i
         vNUxzIuRGbgs/dQsoZjiOkN7PDRGh1JoMmOGgnGAj/YKMASmOnNmAK7yaZfExInbXu5a
         EyCvSXz88ovLxnHrYgc7y7jmMl60j4R55wVeecNSwYBDDPcZ8AeLU6oDoA0MRQqGMd3d
         95Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788982705; x=1789587505;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1ydOjuoTgA1JS+qa07cHIVSm0i9RHzfwwnuAwNBt4m4=;
        b=hbEzEWs2wPsgJszWM6805G0MqOOO3PZmUzGHwykQQp4vt9AnwojN2WbXRcOnkhbEEd
         gXiKYSfmf2n85tkDCOSuMWlvScH7G+A5KhR9k9N6x8EvvJ/aUGefyJ0S43UvUuBmACYv
         ZqKeruzki8zXOfU2PYDX2jA1PksR8r2RkLRIg+9Dw++JVlEfS7VZB6DHuZadZDgnYugb
         sCQi3VGkVxxtbEiru0J2I4PzIvOK4DMNZKtLYB8tZQAVhQNCuC0hpkQoFV7oPtZ1Drny
         cz+rCuHemvYvQnU2EC+ucpoRKEZ17Lg/EChnUp2sgoOqegl5ZeYuhF6i+8QXrmSLG5u/
         gnfA==
X-Forwarded-Encrypted: i=1; AKwUvBzNtW3shdrvwfoa9Zn8dxTBoDi7PE6wowsoiXa1CFd2/ssJlLimFUSJ1C6z+6+T1iHJ7w+jvsT7kUPK@vger.kernel.org
X-Gm-Message-State: AFuF++k4dUvZ6Zo7BGf085SqdkefGl9bKteTK3d5RjiFom61jdMbaIE3
	D6/yHzMTIPyfuukXU2TR4L5HakzbWQhkk+ZXOH0p48k+8J2D35CR/lb6ZZ1QZInd45mX+jSt1tR
	B4ukoaGpfkpAdSDsV0eetXfqhaEvNH1w=
X-Gm-Gg: AYBFou0yOWjqJQdT2eCk3xOuEHnLDfI3K6nzG7MTlu1hs1R6+Pv5yy2FnXkoOA8A6in
	Ud8jGqqYiylN+H6cdF+21thy4ph+kJ0y5SahFJjxV0jsXILpoPrI570qTDlvT/Q2bVptiD5oiiE
	vtB1n+KFxsitR3WqmGVsO00ovOBAYKknF+zx0ZMgL+lxJp7uiCkfneNQ3YoJMCeIGsgMOhexMx1
	+/dll7RYgc7qLNJcjMlVy3eEBbV349GilQjBVXVQklOx4h+BRctUb9R1KTCe7mwzgz5Np6Pj4YK
	NLEK7+n5GT3KyNCmxYQTfSoCWwnWkRmw+w7iR6PJX7GYSFLgscnH9Bu5gQcvKM13pMvrVhE7ZWC
	AE7Cai2I+1TGg/BicasDR5gJPIiuZPvlyCdqliTE/aDnqcR9nsq02m+2DkRb8tsHKe2CKO5REq3
	Yv1GyAXDPRXk5XuKeTE2iUcSGzn0w9bPFEDYQ/uYwXxYalGZZcXzY=
X-Received: by 2002:a17:90b:3fcc:b0:39b:3505:c72f with SMTP id
 98e67ed59e1d1-39d77b83048mr824934a91.6.1788982705356; Wed, 09 Sep 2026
 12:38:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-12-3a93791af1cf@linutronix.de>
 <20260908071911.GU4120091@noisy.programming.kicks-ass.net> <ABBC0C50-847F-406A-B426-55D0C2BE15EA@zytor.com>
In-Reply-To: <ABBC0C50-847F-406A-B426-55D0C2BE15EA@zytor.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 9 Sep 2026 21:38:11 +0200
X-Gm-Features: AcwNN1V9A4D3jn7pum7crGv8bcA9jfLyy60O95H9hOe-jZGhQ7AzCwKSAv7z5Dg
Message-ID: <CANiq72=T1487Y7TpAa4c2eTJFMLHoe5Qc7+tRkbkmvrDjfmuvw@mail.gmail.com>
Subject: Re: [PATCH v5 12/24] vdso: Add the vdsocheck tool
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Andy Lutomirski <luto@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Kees Cook <kees@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Christophe Leroy <chleroy@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Nicolas Schier <nsc@kernel.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, linux-mm@kvack.org, 
	linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
	linux-s390@vger.kernel.org, linux-mips@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Jan Stancek <jstancek@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 9:33=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wrote=
:
>
> It was going to happen, and now we'll have to suffer the instability of r=
ust...

What instability?

Cheers,
Miguel
