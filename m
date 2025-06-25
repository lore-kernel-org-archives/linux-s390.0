Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040421E4AE;
	Wed, 25 Jun 2025 12:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855867; cv=none; b=rRt7IeH1ReAYxYnKf8WmVvcvciZMwwVLOKjWTSHQ77DDOiw+7kxnjGp5dvHHhzKWMqfygPKcyze/7965yFj9Do+CdnsKXgcGTkAZH7xYqBH6BrOYf3PcX059609GuFbsgbyunV+X/UoWjpWwf/dIn0IMvsYtLmwAWrm4EuWhixE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855867; c=relaxed/simple;
	bh=CRwRhM1MtMEUcOGQgquJfle4LDepcccXWla+ZKxsdwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jwaLVQdzNktI9jxw4zSlN1ssmyfwEVLDTp+vu9rxeHWi2rmC6uold47bGSXwLcaW0lfRraDEItjhpz/zF9MqgpsUhnpimE+nrf/BRTZqfyOuhkQqwlCiSdgq/VkJw1sfV5dG/zEh8tLxq5rb8DSEPKNakH5WPPtnNXkPwETRLCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChxHDxM0; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChxHDxM0"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-555024588b1so22054e87.1;
        Wed, 25 Jun 2025 05:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750855864; x=1751460664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRwRhM1MtMEUcOGQgquJfle4LDepcccXWla+ZKxsdwI=;
        b=ChxHDxM0oreHKDK8D8eoA5qosDZ9oozJ7EkiKDJPm9z1nBAZnJGldW6EpwSimFuleT
         d3iiN/BxAehuY2/4QaUIkaEdwuVTdAX7fkql9ZNi4FzheZOM1qbjXRTM/UGU+2vwejdn
         sJkw5zaJhm4cs2YhoHWICfjlP78aXY0SQP41kGr0LGmDwo2fVDCCGZBM+PfHn4Ih6wm3
         EqNWT1QlcUyyJpWddf23L4uIT+luWdsfHp5QIdi31CajZmflgzSqanZsLKoEZ7TBFswK
         Qi8PWEelbZc55oGxbCQfdqXstgmvfAGJLGr7l6fk91rnvDGGRxlcWGlWNIaRYpGo/eAQ
         KbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750855864; x=1751460664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CRwRhM1MtMEUcOGQgquJfle4LDepcccXWla+ZKxsdwI=;
        b=ujBcojSZbqbJ2688BFCZmX8y88Cpb6e2c1VxreoI0GluE9g0EFe1jLrCLdkW5lgLCq
         rZRs1GpQ7AbmA+rKK01LTRWH1qsWqFhNwESOx5wyAZ6PCQ5r8yPMR9lLH2FeCWXVRvvc
         RXTlSy6S0TfobwINu3G6EJJHu6u4nPJaGqFGzKgql8UiZ06TIFPDYhY/h7ybd3YmDgTa
         HMBTSvQcLN0aE5Ui38Ihve/bCQnwpawEvasxMfe4/sTqpiS3bG9WrO0zPYhyNEp7fQ6N
         wdGS6SlNscPGTQpj4JREp9S5xe3JRfpx9zge1hB+SURM28LImzXAMckKRciYt15Rj8bv
         nQ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXWSLoawUrTYAe26lmVw4fosk9b6JdZrl9tn9K9vILNtcV/rJ3/PdQylb4eAzuj2/EeE0ktkygA5QgRmxk=@vger.kernel.org, AJvYcCXZ0VCsFzN5XT2MOJ9rqIdo+/XCv42GAqDu5HaEtcOD1NToRDEnhFFZup4xvS86HaUhcevyuKcyFJ5baQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxL38bXNMi0wZegT1mdueJ6QFZjPCggGys7KLnfppsO7SssOPzv
	udsNx/1+YqOcb3AlNaMoGnbAFy0MdJGN5RcS6HNaG0BDigyWgWun0aTWONDrXsAKRLSI7e0jIgM
	ECKat+mgxCP3VQulEEvkJ4L3GisyojWw=
X-Gm-Gg: ASbGncu078D/ke3ylg+kAZmGVE2yc1n8V68+hmTnQSihBYAQtXpj8y7WQ+5yo9XNe5d
	mtvB1xyC6cqYr2xyshpBlj1U0Wpd9KMongAA+sZZ9T2b0QAtPbOCVep5U6qTO8hsS3NYuo8UtBI
	V48E5XkgANtzAQt73w4nrnYqju7dxGk2OXhTsLAkMLwQ==
X-Google-Smtp-Source: AGHT+IH4AdTi7obPWXsCps0Kqqd3RJ5D/he3Lezfcy1G4Eg5fA0HGJmj1VDSyHt6qyIqHAybfxlMpWZQjVgI2Xx3Mto=
X-Received: by 2002:a05:6512:4011:b0:553:297b:3d45 with SMTP id
 2adb3069b0e04-554fde58124mr1020525e87.43.1750855863865; Wed, 25 Jun 2025
 05:51:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625095224.118679-1-snovitoll@gmail.com> <20250625095224.118679-3-snovitoll@gmail.com>
 <750b6617-7abf-4adc-b3e6-6194ff10c547@csgroup.eu> <81a8b60be5b99ecd9b322d188738016376aff4aa.camel@sipsolutions.net>
In-Reply-To: <81a8b60be5b99ecd9b322d188738016376aff4aa.camel@sipsolutions.net>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Wed, 25 Jun 2025 17:50:46 +0500
X-Gm-Features: Ac12FXwt1iee6Yaba3PMavifTn-RFaMv0HhE7s3qnJv0p52DgpRl1n7RcMDkzZs
Message-ID: <CACzwLxgCH6KuVDRS3d9MrmA=wY_rMA6R5TPB_v37BkD8-A9yuw@mail.gmail.com>
Subject: Re: [PATCH 2/9] kasan: replace kasan_arch_is_ready with kasan_enabled
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, ryabinin.a.a@gmail.com, glider@google.com, 
	andreyknvl@gmail.com, dvyukov@google.com, vincenzo.frascino@arm.com, 
	catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org, 
	kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, dave.hansen@linux.intel.com, luto@kernel.org, 
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

On Wed, Jun 25, 2025 at 5:24=E2=80=AFPM Johannes Berg <johannes@sipsolution=
s.net> wrote:
>
> On Wed, 2025-06-25 at 12:27 +0200, Christophe Leroy wrote:
> >
> > Le 25/06/2025 =C3=A0 11:52, Sabyrzhan Tasbolatov a =C3=A9crit :
> > > Replace the existing kasan_arch_is_ready() calls with kasan_enabled()=
.
> > > Drop checks where the caller is already under kasan_enabled() conditi=
on.
> >
> > If I understand correctly, it means that KASAN won't work anymore
> > between patch 2 and 9, because until the arch calls kasan_init_generic(=
)
> > kasan_enabled() will return false.
> >
> > The transition should be smooth and your series should remain bisectabl=
e.
> >
> > Or am I missing something ?
> >
>
> Seems right to me, it won't work for architectures that define
> kasan_arch_is_ready themselves I think?
>
> But since they have to literally #define it, could #ifdef on that
> temporarily?

Thanks for catching it. You're right. I need to change the order of patches=
 :

- kasan: unify static kasan_flag_enabled across modes

, then we should apply arch specific changes
where we call kasan_init_generic in kasan_init.

- kasan: replace kasan_arch_is_ready with kasan_enabled

>
> johannes
