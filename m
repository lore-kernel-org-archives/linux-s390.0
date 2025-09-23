Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C363326D58
	for <linux-s390@vger.kernel.org>; Tue, 23 Sep 2025 13:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758634841; cv=none; b=fqoavlKv9Rhi6rF3bOaGlfpIVL0c2xt74DrGd1Jj4brCRvrT5APf/sLXYpQhvVzEm8vYPoKutSFZZhvMN4jM4vzck7uqERv8sRoajaEALp4EFml3LrY9OCFiJBqJwZDyFDa5U5uWMAnlCnlxuSqdQe7pjlCUt5do7zrqWABcMXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758634841; c=relaxed/simple;
	bh=jqiBUK9/mj3MBAI+kIAnz+rD1nKORVX6srf0Jf+a4hQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uiRjmfCYy6ImIAlpk1HKO6u9TMypKw+9KbYQJE8EtXqXHW3X23WlZ0dHECZxk38d6uhfAqXwT2O2xO8+vWDcoqpU4zklLuMpvxIT5a1xSIGDbB14Q8MfohhURIW1+XetUnB/9GGOr15oRwmpsjuPIChkOpYqhugWHwItcA3Vvk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OzjpRXqc; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OzjpRXqc"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2699ebc0319so59871665ad.3
        for <linux-s390@vger.kernel.org>; Tue, 23 Sep 2025 06:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758634839; x=1759239639; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+q1ANiVdqE4PLX6BxhbC6Ed2UomSL/7PeR7UsDBlsI=;
        b=OzjpRXqc+wPLui+uUjQxvQB/9bwrdmKQacZx4bg0CSx3kGi4sjkfejeoNg+CCUENSw
         PCSMQG1bVF9z1N0wjWWQF5bSJSjNHXtm4EkAVVwsPXcmuJt/oIygLyr52pJVoGIe7awL
         Foqr+5mTaJpipjOn0FND84xXDFnFEx2h6/hmYOVET1QXywopXUsIT4weOZJGePSDJRCH
         y32XhQJIfTnMa+YebFgU8D2mMEhlLt5+T87YMAtBvXo2nq8Gm6HAYp5bmzUxvGEgv7Tv
         IANGPZ6buFMf43hKQYuJRwHgO26BzqUhYf9Ef0RYVaUiSu3DmYia9hd0iBpWa6mseq84
         +0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758634839; x=1759239639;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+q1ANiVdqE4PLX6BxhbC6Ed2UomSL/7PeR7UsDBlsI=;
        b=tkR6QDPy9c52wT1YjbMFXF8BGXphuiayCzumCjTRIKKJD/MVuSk3wDEY68ORvKLjEa
         zxJymksuMXgXCx+GuPwu2mnoWFIdf+CGNRpyzRkay9RkIMQEEjUXJC45DoTOcp94MuJJ
         ggDTm84V42hGK0fryapplsC0z6QOWq04TI9GbxLkqtNKLDHAywM4pY+oaubVSbfekxQ6
         6AQBUcrVxt3mvsEO1e/4x7TSFsM6K+aEk6m/OiW8fl0j+AAce3m2/lbAsuq+jINgCj1W
         gjvK9tCT7gPm31aUgUJtYSqfFrTcQWiJiLI9LQURlN7R9i8gXjOMrMNZ5TJiBSWXXEsY
         8V9g==
X-Forwarded-Encrypted: i=1; AJvYcCVZXhlwDeDqYytXevrGbvCn/kQjz1GJ+c/J1kGHLjG1lf/z0HVIleYd2w9SW/cFo2B0oAfTrzFdeqho@vger.kernel.org
X-Gm-Message-State: AOJu0YzqjsY+vNP2RuPkP/bAkoYBuktmqQlfkb+CMntF+PGe3UDWturE
	yiuOEdYBOUGS/AZW8NC4FNDqn5GGccCydq27+lfuCO4LzD1BMrJfu50Qif/UIRaa9afGWiVxoaH
	vvYjYWg==
X-Google-Smtp-Source: AGHT+IH1umU0hviOHL6mfJrfC/KblA1ofkjZSfEzaisGwPHRVVBGNbnvXRYWg5KI7SU4qrTt9g98pjrjG4g=
X-Received: from pjbnd17.prod.google.com ([2002:a17:90b:4cd1:b0:32e:b34b:92eb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2446:b0:275:2328:5d3e
 with SMTP id d9443c01a7336-27cc3eee458mr34116465ad.18.1758634839306; Tue, 23
 Sep 2025 06:40:39 -0700 (PDT)
Date: Tue, 23 Sep 2025 06:40:36 -0700
In-Reply-To: <20250923012738.GA4102030@ax162>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919003303.1355064-1-seanjc@google.com> <20250919003303.1355064-3-seanjc@google.com>
 <20250923012738.GA4102030@ax162>
Message-ID: <aNKjVLpajXCKfqr_@google.com>
Subject: Re: [PATCH v2 2/5] KVM: Export KVM-internal symbols for sub-modules only
From: Sean Christopherson <seanjc@google.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, 
	Jason Herne <jjherne@linux.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>, 
	Holger Dengler <dengler@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 22, 2025, Nathan Chancellor wrote:
> Hi Sean,
> 
> On Thu, Sep 18, 2025 at 05:33:00PM -0700, Sean Christopherson wrote:
> > diff --git a/arch/powerpc/include/asm/kvm_types.h b/arch/powerpc/include/asm/kvm_types.h
> > new file mode 100644
> > index 000000000000..656b498ed3b6
> > --- /dev/null
> > +++ b/arch/powerpc/include/asm/kvm_types.h
> > @@ -0,0 +1,15 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _ASM_PPC_KVM_TYPES_H
> > +#define _ASM_PPC_KVM_TYPES_H
> > +
> > +#if IS_MODULE(CONFIG_KVM_BOOK3S_64_PR) && IS_MODULE(CONFIG_KVM_BOOK3S_64_HV)
> > +#define KVM_SUB_MODULES kvm-pr,kvm-hv
> > +#elif IS_MODULE(CONFIG_KVM_BOOK3S_64_PR)
> > +#define KVM_SUB_MODULES kvm-pr
> > +#elif IS_MODULE(CONFIG_KVM_INTEL)
> 
> Typo :) which obviously breaks the ppc64_guest_defconfig build.
> Changing that to CONFIG_KVM_BOOK3S_64_HV fixes it.

Argh, so many flavors of PPC KVM (says the x86 person :-D).

> > +#define KVM_SUB_MODULES kvm-hv
> > +#else
> > +#undef KVM_SUB_MODULES
> > +#endif
> > +
> > +#endif
> 
> Also, you'll want to drop kvm_types.h from generic-y to avoid
> 
>   scripts/Makefile.asm-headers:39: redundant generic-y found in arch/powerpc/include/asm/Kbuild: kvm_types.h
> 
> diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
> index e5fdc336c9b2..2e23533b67e3 100644
> --- a/arch/powerpc/include/asm/Kbuild
> +++ b/arch/powerpc/include/asm/Kbuild
> @@ -3,7 +3,6 @@ generated-y += syscall_table_32.h
>  generated-y += syscall_table_64.h
>  generated-y += syscall_table_spu.h
>  generic-y += agp.h
> -generic-y += kvm_types.h

Thanks much!

>  generic-y += mcs_spinlock.h
>  generic-y += qrwlock.h
>  generic-y += early_ioremap.h
> --
> 
> Cheers,
> Nathan
