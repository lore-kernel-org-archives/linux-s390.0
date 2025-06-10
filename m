Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B499126462E
	for <linux-s390@vger.kernel.org>; Tue, 10 Jun 2025 19:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749584579; cv=none; b=S3Tqg4f6t6/B6t2yB5ctW9/4v4uyKGTQm+JUweEOQMstKM2+fVYvuxHiCX5JeKBecWenborpvJpSr1ynGAiTA9pUTC+QR7TFQGUK6VTJoTUXHXn56mrrtG6n/ZihnYfFtWUce19719+mw/wlnGH4lHSM7O3j1YJw4UWHjdwzY68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749584579; c=relaxed/simple;
	bh=9YkBVxUtVEzf2g1l+3bgcHOa0H7naeg11KxKDKi9ITM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SMZ7eAuEYj4ht7R/vWx7TUGeX0v1sOwlIAB+2eY/Y+IAwPSJVclclBoqg8Q8YJGDfLo7TMSvmlQL0UdPjfnmnDirosReHJmRlxtWqc0l55gJjTgI8R7ru4BcngIEP1eovr58nhdxRxR+a8iHO86ZkXs5GEe26GU+zmdWelGbnrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lm/HMCf7; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lm/HMCf7"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74841f2aee2so1510592b3a.2
        for <linux-s390@vger.kernel.org>; Tue, 10 Jun 2025 12:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749584577; x=1750189377; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oDALznD/3c9MVqTY3u+MwmZHInHphiU0CPL0RvaHEeA=;
        b=Lm/HMCf78V4tnhNLad87rPhOl+vMHJIhrwdUz28m3EYTlCrvPz1FXt/BOVVB9W84ts
         9kNfnLGj11T0y9LAYxY4TIYYWAsZFbVFy6olP4urmx6VPDvasI9vJjODZACraJT+OlrM
         J1fWMjRLwyCd2B+6A5tk1/QVQoV+f8nWhn5nyu2k5iWfCd4dBpVx8haOFr3MfPFVTZPT
         YxsxtN+g7JJhGkInAbXUYKl/k5G9XeZNlknKN/js4wZuDhkgg1Ciiv7oJEUFFcAh9CIs
         2bCAnweAAXJirVH91jPKgE9DS0trw0zkfImkayyTM/ezp5cUb4c6V39hBXbk2Uo8DfVK
         erHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749584577; x=1750189377;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oDALznD/3c9MVqTY3u+MwmZHInHphiU0CPL0RvaHEeA=;
        b=fRfbwKtBAYyaYfX9kllrejS9n5ouu6Z8yzwqD0tQd+d8dN8i0kB07kM8Kg6EBDdF3U
         vhdYHbX1hgNrqUAta09XEr4JUvivZsPrD0zEavD7xKr+qoAjm2u2OLF4aJjuP8lDICIt
         py6x16CpwTNKMaEoy14L5ZGraZV2+nRV0NdPbODh9d3X8Qx1DFOAo9sVsCanXarQkxTl
         Je5MAdBYKbwWTxRRZ6D7BHkP0AR2t6e5as9vSzdbvl//GLdZ/X5morswZG7hQevOz0Gq
         JhwPVLb/m933KC4UV06otFRoy3yUghOCXL/6KbtM5HcU3JQqvkwPajY3Vwd6gQKEXI6m
         CpwA==
X-Forwarded-Encrypted: i=1; AJvYcCVhPOgER196OI2kiR0g+P93KbZTXF2KeWNCy90Wp1csXfaqrOZXUgo5u0zNchyE+nnIpwyLlzEsj2ha@vger.kernel.org
X-Gm-Message-State: AOJu0YxxfpmSC/uG3xZhDvxRmbW4/CFkrJNDLPv52X04g8RUGsELXFyh
	cBAxrBGvEhN/FVxTyjvPY+DCdsX/rkw9JcmBPHP0G+lzM6gCwWeJWiheWEFjQXpvNGLUHuNjuaJ
	/vXdacA==
X-Google-Smtp-Source: AGHT+IFcAOO3RSRtE5/jK1DkybZihifw/RBRr2CZFZLIL3K3lAfdD4oPG0LZgY/dzFkx0SmxXZyKAYsG10A=
X-Received: from pfbhe19.prod.google.com ([2002:a05:6a00:6613:b0:746:19fc:f077])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1703:b0:736:6ecd:8e32
 with SMTP id d2e1a72fcca58-7486cdfcc3amr980353b3a.21.1749584576971; Tue, 10
 Jun 2025 12:42:56 -0700 (PDT)
Date: Tue, 10 Jun 2025 12:42:18 -0700
In-Reply-To: <20250529221929.3807680-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250529221929.3807680-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.0.rc0.642.g800a2b2222-goog
Message-ID: <174958127087.101429.2266783610076724411.b4-ty@google.com>
Subject: Re: [kvm-unit-tests PATCH 00/16] x86: Add CPUID properties, clean up
 related code
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Andrew Jones <andrew.jones@linux.dev>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	"=?UTF-8?q?Nico=20B=C3=B6hr?=" <nrb@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, 29 May 2025 15:19:13 -0700, Sean Christopherson wrote:
> Copy KVM selftests' X86_PROPERTY_* infrastructure (multi-bit CPUID
> fields), and use the properties to clean up various warts.  The SEV code
> is particular makes things much harder than they need to be (I went down
> this rabbit hole purely because the stupid MSR_SEV_STATUS definition was
> buried behind CONFIG_EFI=y, *sigh*).
> 
> The first patch is a common change to add static_assert() as a wrapper
> to _Static_assert().  Forcing code to provide an error message just leads
> to useless error messages.
> 
> [...]

To avoid spamming non-x86 folks with noise, applied patch 1 to kvm-x86 next.
I'll send a v2 for the rest.

[01/16] lib: Add and use static_assert() convenience wrappers
        https://github.com/kvm-x86/kvm-unit-tests/commit/863e0b90fb88

--
https://github.com/kvm-x86/kvm-unit-tests/tree/next
