Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259FA260567;
	Wed, 25 Jun 2025 12:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855555; cv=none; b=MrsMlEuMqMhKY4xv3gZ0A7pcLP6iyP2RansTSmJZe4HGEeFHWZ1MXy6AS+hvWFMHTlsNA6qg5JPWglSz4Pz/XZNjAzrniG+01CUNTX5gLvESmII6KcWMNYtzIjsjFT9VomTIPiA+eYjMpa2I6SWF0dfWQ2BW9YCkL0OZ828hMSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855555; c=relaxed/simple;
	bh=aeUHbst5u6uAyR1ycfeU07wkwThxzbqj2XsMrc/HWnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TGDQx2s8o9U76ExiU6VyG4ZZ/cbOsppqhBEuD7JFrq4CktUDlsK8bPIdiSIkD25KKgbQ/glJj7uzEyBFumesZ3FAvJwNDrBeVMBw+fdrbTEXf7wJ+VZC0nyW+JWXSQGN2HarWoxYjCz4ScX8LQl2STr01DU9+Ik94MlyyyGgzdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xax0JKeS; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xax0JKeS"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-553b60de463so7105732e87.3;
        Wed, 25 Jun 2025 05:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750855552; x=1751460352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aeUHbst5u6uAyR1ycfeU07wkwThxzbqj2XsMrc/HWnM=;
        b=Xax0JKeSGxE88hvWuvO4lIYb8pAGDKfLqzOC0P0PiKgL2F+Y2ki6OIrpxKIm1fgw0c
         QfApuUagqZVw4U+Gjl8KfpFIEl1175lSXz8fzqHzdPjesJz+Si+0ukTTbM1dpoZurvyl
         0kRdv7ewfOltY0o9ntH6xoLjLRjrd/0LoSKhK4DaEeaw1KvSB1DLiU5hp/yT7jylDxVE
         oETJU0GbSQv2dHLrJg5AHXqDLwbQZodyk4nNGEfJh2c+rckpS2hEWfVkV9VeHzEKivKK
         fSVK96iH0ksFSHeRwIh/dAidfmX0nE5jWvh2OtYvHLsbw6KgJ0vYtT6BrEVLenDN0mpe
         UK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750855552; x=1751460352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aeUHbst5u6uAyR1ycfeU07wkwThxzbqj2XsMrc/HWnM=;
        b=t5GV5d5C2J4YQKdwZqwqY5EDr5y2A+lhEfTShIKBwNvgbtAjx7SK8NNckLj5UsyUys
         HrTYFCBkGQpM5RInCyEqvenboQO8RFXWcCJoVFYnkwuMciAr/YDlF4neVNnOdiWkE7oz
         GjGkTtabxvstOZzlfaobEl8sGvUbefbAkwvuGIejzS7TnY6zfc38OVx+Qn1IPMziYIUy
         Y3015kiLVk7u3pMANyL41TawrZ8RYydMLbi+HA/b8/qEF+OqubRDB9Ve9tZ5R0vXH7a4
         juQPtuKUWZyRJTsmOkctYA5nJKpWYRF9vpyzbFpa86YaSe5XcTAt9ogAJp6COWUiDaFT
         hbhA==
X-Forwarded-Encrypted: i=1; AJvYcCUIuuhqOrmX3o6Unw90y0knmN7gdlLwLp6uxr0P1E0IafShYWs8S9LQuBGXyg8EKupoLM5tNzW8Mn/c5A==@vger.kernel.org, AJvYcCWvQPyntQ6SZH0DHarNCMs2dTdi9Tm8rhrpKaai/+ksRPEqadPw2L6kJ6+3CEHJGiL3mfLc+TY5bm+xVls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc4Gc0cRezlo0DZCWppEnYkRohKIs3KyL3PjV+/rxX7aP2RyOz
	kPjF4ufKDMAH0/3Y63ap3oif1Y99Nbx7F1/qgIOkeoGEwCYCDcTHUZgQUPj/dW00ccilShstBuE
	LGvDxRaZa7HO7rcYLIxPCjOS1XaCNZV8=
X-Gm-Gg: ASbGncsdyrI3LiW/kswrSBNp7zWzQAzSf2IRvc5pazhNYOAKV9Rc9FZTeuQpFKYTav/
	qjGk27Odf80Tx+mMlFWAg+uEi5rWOfuQ+RY3xn20FsOMx6Slp8ihHlNCFrh6XwrCSQ6gbIEo0jJ
	lEh8+9e95I4dQX9lxuarMH5ZZgr+c99ysUQT3WCj4ALA==
X-Google-Smtp-Source: AGHT+IGd+VQCTiJwy9G1ykD/0Nzx0GAzsfPqUCVqghBLVmwOBzPwEbsyyeyH2J2LllM1nMa0CK079KR9Ekpv1ITEkm8=
X-Received: by 2002:a05:6512:1591:b0:553:abe6:e3e7 with SMTP id
 2adb3069b0e04-554fdf5cefbmr869898e87.47.1750855551832; Wed, 25 Jun 2025
 05:45:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625095224.118679-1-snovitoll@gmail.com> <20250625095224.118679-10-snovitoll@gmail.com>
 <4d568111-9615-4fba-884a-f2ae629776fe@csgroup.eu>
In-Reply-To: <4d568111-9615-4fba-884a-f2ae629776fe@csgroup.eu>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Wed, 25 Jun 2025 17:45:34 +0500
X-Gm-Features: Ac12FXyn774raFC9M0P_m_Yp5o7tYNYYaJPlJbUzpj4u5O7z5JIOhc_ux4m2QSg
Message-ID: <CACzwLxgVj3YD5faPj=09Z9e4WSEe-sD7Sqn4jhaT7eiePaUUMw@mail.gmail.com>
Subject: Re: [PATCH 9/9] kasan/powerpc: call kasan_init_generic in kasan_init
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com, 
	dvyukov@google.com, vincenzo.frascino@arm.com, catalin.marinas@arm.com, 
	will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, hca@linux.ibm.com, 
	gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com, 
	svens@linux.ibm.com, richard@nod.at, anton.ivanov@cambridgegreys.com, 
	johannes@sipsolutions.net, dave.hansen@linux.intel.com, luto@kernel.org, 
	peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	x86@kernel.org, hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com, 
	akpm@linux-foundation.org, guoweikang.kernel@gmail.com, geert@linux-m68k.org, 
	rppt@kernel.org, tiwei.btw@antgroup.com, richard.weiyang@gmail.com, 
	benjamin.berg@intel.com, kevin.brodsky@arm.com, kasan-dev@googlegroups.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 3:33=E2=80=AFPM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 25/06/2025 =C3=A0 11:52, Sabyrzhan Tasbolatov a =C3=A9crit :
> > Call kasan_init_generic() which enables the static flag
> > to mark generic KASAN initialized, otherwise it's an inline stub.
> > Also prints the banner from the single place.
>
> What about:
>
> arch/powerpc/mm/kasan/init_32.c:void __init kasan_init(void)
> arch/powerpc/mm/kasan/init_book3e_64.c:void __init kasan_init(void)

Thanks, I've missed them. Will add in v2.
I've also found out that I've missed:
arch/arm/mm/kasan_init.c
arch/riscv/mm/kasan_init.c

>
> Christophe
>
