Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7392D0C89
	for <linux-s390@vger.kernel.org>; Thu, 11 Jun 2026 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781189147; cv=pass; b=ROeBsI6DGH4S158Ly6wjnCIfHEgRx/XMMniVklR3AvcNmFVWTvz8Cfls/q+coM4GbyFXD0Z1Dv2iwPfI4Z5eNtAyv2GYtWP0uuaZAiSLU4sNZ4Fb+f1hQroYQfFMEJFf49sB7pz45lT9EHzXlDAuy/RVok6AY+9Ebj3gbsLckfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781189147; c=relaxed/simple;
	bh=ZwBSIB66d1tL230+mKEjlH+JNTqmf3KSiuoOfRL20sg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DEOehORnhbjFeb65AtBtKULI6hi07E02OAVb91j9hgcJz+xa5zKfcJqfpHHxxaO8kjWSIdSJ8xz6Dgkg2aOigPEL7A9Z1F33zyac6/M/g59HpsMI02lW9/OQtyXAcpxNN33I5trzh2MBnOI9fD1VDd3qZxI8QHsNDgtgSc/foDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oKTF1xRk; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oKTF1xRk"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bec43ee8ff0so150142566b.1
        for <linux-s390@vger.kernel.org>; Thu, 11 Jun 2026 07:45:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781189144; cv=none;
        d=google.com; s=arc-20240605;
        b=EClK5EFGDO8a05juxdjwtRSgsooMMyqvQcH/BeY/VmNKLVylYp415Kd6CU+i8uzCRy
         DRgCP5Km08XsowXF/xLxYNYDSCd/5C++kSbQyEhPEcg6/mS+EqUOyJpOjZrqgoz96MVf
         1jguu1T9cjXBn3/X23LM1CW4D4ezjL3w4llQGVKKrwLmkRMhbuIIEE2SVgaoSYtsfqn7
         +OqJa6++bKao1Otj5r12ac/sG2f5e1xN9G36SUfXVAYVq+lalqkOEKBCtfslFipsFfq/
         HzQK+Y0FLg35KLd7eyipOA/5aZUaEwAarCL7s/505ZSytz34PZK1UlWtXd9GxWgXBDoM
         XzvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=d1Q6VrmJUx+o7NgXdFZxExU41NgoiFIjQElz0CF6684=;
        fh=pXIxXJQKFcxHGCPpLtNQW4FInC89NlfTPo5EURrzsM0=;
        b=NrDWi78r4ACasjMY5yYDzg5CfvcnaFOmlbb1mmCuDBgCCEj4RR/yo1s9otIB27ietN
         8Ct5UoJd2gZoWPw+I9GNIwSomK20SYdQDFUKup/jexvKVp9YTyb9I6qEbeLVjS6NdejP
         jwJBjPuIU6M9zlYRhIO8KyO+MMXHTXm+/btias+8CU3gueOF67wrpUOhr0MR6n3W1WG0
         A8q88/cN8lkuQxcVzseQhc3gPVKQTaufRNvGeI1cS513CaB23hDDttE7YVKZLHGQtiT0
         wvzAs0PuYW6CF7GElyMuAzQJFlf3lyIPgTl1uJ2g9XuJMGxqGT4toATfFqIV5P0XfevR
         4xFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781189144; x=1781793944; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d1Q6VrmJUx+o7NgXdFZxExU41NgoiFIjQElz0CF6684=;
        b=oKTF1xRkGsnpLk64bMT7Of1ScwuLfP2HoSZUImbFDHaOIM7jrZ3vAxGbuIORM6uAQe
         kE5Swb551sovL0ik3GX5PbqyoHeNc//xeY5idvrcdwvf6gSeYeUiqgCNT6yemDqW0qBE
         tjI+kIWj+xE4NWVxrFmqjpINnAtTsgnD5odgG38Z5WFtpmwv9fkrgdp2Xr+gyIMUAQnk
         EOceaM8DLDcCj3u9saT4LWxrhPNU/NA5c1NIT9TIOIh4STIR1yC54AwV00ugBcrhnpHk
         XIg3NBWZhE8ZxGgLQ3p0BGadefN2Mc3HaP3k1ZDGFeoDbI6UfwGqLlI5KWHK5gleEI5i
         X9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781189144; x=1781793944;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1Q6VrmJUx+o7NgXdFZxExU41NgoiFIjQElz0CF6684=;
        b=OdXaBtqg0v2gQTBQYYp5BY4twc9axK9s86wIjLx9fihNNmlPQoUyvXNEaL0idsy2AG
         /dKrZPcGkeh4vEwJy4jr9V72USsr82AlTD/WWOfSmrEeAC0gh9SSTYq2OiRijCPCDGDf
         1D/M0nw9a1AF5G2/nulVYlT4CkJKuA1/T8AWnifAqR1DjSvvYLrwA3aK6fwHxdrkZz81
         kDtW6kFolUWtcCTfOvdFHNeS3Cq6ufvFoadgyiTKQRqClB0zo/cgRmnvhLVjT6j9PSH7
         exMnpq3jy7lSRaT3G1tGxFmf3D3KosO22B5FrolukkpN6FlWGuJ3Nqfbi/wYwtrWjxO2
         7Utg==
X-Forwarded-Encrypted: i=1; AFNElJ+avUVlLKbXyB7uj0VaLwjLCnXen4vNzBMxUgKbXLC7oIy/AeYvO+Pfqkw5+e44/DPu8QoMlpxdGpHg@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+bTrWEqYN6acQeZjBHlb+xPcKJrkw3ykf9a1zmfIGZf4GOGei
	EHL/YcqhKIbp/uAlANXskZGJzPq+TA/P3ctcqqKBd9uFHlTsGu9BdAP9HGJgAY7dlTEriiUtJqh
	Bu/It2LRpgMilnn+V9Oyd7dlXggQFIWMmeUsgBP7FlA==
X-Gm-Gg: Acq92OHI2nGZqdUICm/Fwx54LtqqJZszJqP5Q0cDWSudOZODbzunntvFLk5b4YaDDBG
	pw+TkIV+e98N29Bszn/tTXz6RUJ+jPA/1jphQRNGoBSRUoPha9YRAu5yU1yRyfG0fBrCGr447pu
	t1wGgnqXW0PbVFSSgXM8WzQ0u6rjTVrfBOs8B/sQpOMliHMqdK+mF+hbRcCu9s+bjYj3Svqe1re
	LtvxsxpBhT3EXavq7u8rJyHIDdwW+QmN7qn9rZQsrMN/feB29z2MkT/Es6F1gmLFjBBn8wvnVy3
	5caOeTmtehvlEeGPaplU1HN+T/joBpmb7OIFrWUM07LWtt9lvMHcQmzKMA==
X-Received: by 2002:a17:906:4fd1:b0:bee:a39b:ab7b with SMTP id
 a640c23a62f3a-bfc78ed6c4fmr158181366b.31.1781189144237; Thu, 11 Jun 2026
 07:45:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610142329.3836808-1-sumit.semwal@linaro.org> <aiqLJUrJ1dnKhsJn@FV6GYCPJ69>
In-Reply-To: <aiqLJUrJ1dnKhsJn@FV6GYCPJ69>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Thu, 11 Jun 2026 20:15:32 +0530
X-Gm-Features: AVVi8CeA1CWJ3Tf7y-K-ZwxKVWTsZOKhQeXrR2LoMbjQ-zl-nOkzKd4bOJvB8OA
Message-ID: <CAO_48GHEfq7wpvM_4OXcMhgdASgH9J96nhEd0QFh2Rg8aPxpfw@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: move system_cc_shared heap under separate Kconfig
To: Jiri Pirko <jiri@resnulli.us>
Cc: christian.koenig@amd.com, jgg@ziepe.ca, hch@infradead.org, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org, lkp@intel.com, 
	agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	linux-s390@vger.kernel.org, djbw@kernel.org, thomas.lendacky@amd.com, 
	x86@kernel.org, arnd@linaro.org, benjamin.gaignard@collabora.com, 
	Brian.Starkey@arm.com, jstultz@google.com, tjmercier@google.com, 
	mripard@kernel.org, afd@ti.com, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

Hi Jiri,

On Thu, 11 Jun 2026 at 15:51, Jiri Pirko <jiri@resnulli.us> wrote:
>
> Wed, Jun 10, 2026 at 04:23:29PM +0200, sumit.semwal@linaro.org wrote:
> >From: Arnd Bergmann <arnd@arndb.de>
> >
> >While system heap and system_cc_shared heap share a lot of code
> >and hence the same source file, their users have different needs.
> >
> >system heap users need it to be a loadable module, while
> >system_cc_shared heap users don't.
> >
> >Building as a loadable module breaks system_cc_shared heap on
> >powerpc and s390 due to un-exported set_memory_encrypted /
> >set_memory_decrypted functions.
> >
> >Fix these by reorganising code to put the system_cc_shared heap
> >under a new Kconfig symbol, which allows either building both
> >into the kernel, or leave encryption up to the consumers of the
> >system heap.
> >
> >Fixes: fd55edff8a0a ("dma-buf: heaps: system: Turn the heap into a module")
> >Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
> >---
> > drivers/dma-buf/heaps/Kconfig       |  8 ++++++++
> > drivers/dma-buf/heaps/system_heap.c | 16 ++++++++++------
> > 2 files changed, 18 insertions(+), 6 deletions(-)
> >
> >diff --git a/drivers/dma-buf/heaps/Kconfig b/drivers/dma-buf/heaps/Kconfig
> >index e273fb18feca..a39decdcf067 100644
> >--- a/drivers/dma-buf/heaps/Kconfig
> >+++ b/drivers/dma-buf/heaps/Kconfig
> >@@ -5,6 +5,14 @@ config DMABUF_HEAPS_SYSTEM
> >         Choose this option to enable the system dmabuf heap. The system heap
> >         is backed by pages from the buddy allocator. If in doubt, say Y.
> >
> >+config DMABUF_HEAPS_CC_SYSTEM
>
> Nit: "DMABUF_HEAPS_SYSTEM_CC_SHARED" to be consistent with the heap
> name?
>
> With or without it:
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>
Thanks for catching this; I'll fix this while pushing to
drm-misc-next-fixes in a few minutes.

Best,
Sumit.
