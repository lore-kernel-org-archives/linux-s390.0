Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6372494FE
	for <linux-s390@vger.kernel.org>; Thu, 21 May 2026 13:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369754; cv=none; b=t79uJyaeII1VmAEdtMvID0tBjFIFTDOF/smefRyRl+W2hy5FxR64nduN7nsjL1geb92Zm/9GsLNXr4ZCzniPPjvWwj8FtoHh3rcieZyD5z55QBz83A2byncQ5u5FMPp92fQLjTzU9zD8A5rigEMR5G0MY0Ptlln/jM8J7gXvaUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369754; c=relaxed/simple;
	bh=bwc6gNambKlQLzjbXSx2nZflTcxvVgvCPG29VSwBPEU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ENfaIFgBZPtKJ71bG8HY31PsCBO26AHOePcm4CtR/ZBuPTt8unsr4x4unePyvtsaZhJCAQ+/Z3k5L1ZaEQo9g5O8OZ8ARrg5HCtiyl1EohFrlOUWs5QACdHuPCzwr6HiE4J7zsfux4xUXpn1RH6hsiR5qBxhdeKYQVqZaa6xjzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tOdzsDAZ; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tOdzsDAZ"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8354503d9acso7976868b3a.1
        for <linux-s390@vger.kernel.org>; Thu, 21 May 2026 06:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779369753; x=1779974553; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tHNHTita1mRVOI1T5nHKymwnXa06ljRAcOEBdR3vfAc=;
        b=tOdzsDAZqRiUBh/x6OTiH+CmyHEj8kIC1VpBxxiwIpNVHLHXnRTRiZjPzUxEIjqMxm
         Z+I3NeJ/UwCblX8dVlc4lYNIwflbQLVE4mlxn53nOJylHqagbQPjdFrEbxGTmbXasXMl
         VjbwRaS2GhD0+izNS2s+TfqOTd2iLlqTQObdxrohgW/oZjQW+cRxWh1ZZjNJYFKXn4V0
         0Vkcza8s7dBNckYYu48e9CeqJHdvszRDCIsY6q4xhKhDS6ht4WDJEw178xmAReOBuAgi
         Ptb3cHnHfuOb9ADs9kFQRpzXP4rBtnW6jUQ8vk8MSMjf0FVJfKbK1tJrwWRmCTLXkN/A
         gUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779369753; x=1779974553;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tHNHTita1mRVOI1T5nHKymwnXa06ljRAcOEBdR3vfAc=;
        b=GNpMhX6EoFO66b3bVfup3hFQLcdWbFylnt0kklBDdcXywVovzM2eoWCTaMWS28w/MG
         dlYvxlRdjPYOPI6JKRxlEeobjWOifC2GakvLGljW1lQyTdcUAg7yR9OocxDVtahWarMJ
         bVIxpMYYj3UDDsOzwUXkI+zupYPpKB2DTIkhB9UduDACydYLT4Bdlr4fmZF18pZSgRng
         az+eNs0UZ6/mRju/d5v+4keKepfcLj93jQSC3mBI0Of9EjmTtDi9wowoV+BNneeDW1DB
         QMHZDQcaYvHcvdMfQWYYqQykp0vmL44QfvVpeYBNOpHrV8SivJTcqUuY0KIE+kT0Hy08
         fByg==
X-Forwarded-Encrypted: i=1; AFNElJ+o/cTtUOd4TEDg8epG/CEBOc5k/gNqM6UI/j4+tXkAlsONYkbsGsnSHJ9XQJZyzxLwBwRQqIA57bvH@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp4Xmoyerc9hTydbJly7ZH16xz+M2MVOhc5AIC3fbn8+5j84f6
	afMQvQELwgwuGJICL2LMyvcgm48iPGWI0z9cOVLFzf0T5tZIgo29kMnRlypRRRIpuxhiRSG0U1G
	Z+KEYBg==
X-Received: from pfbfj6.prod.google.com ([2002:a05:6a00:3a06:b0:83f:6418:aafc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:aa8c:b0:82c:6b46:271d
 with SMTP id d2e1a72fcca58-8414aead372mr3035263b3a.48.1779369752541; Thu, 21
 May 2026 06:22:32 -0700 (PDT)
Date: Thu, 21 May 2026 06:22:31 -0700
In-Reply-To: <20260521130533.156491-5-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260521130533.156491-1-imbrenda@linux.ibm.com> <20260521130533.156491-5-imbrenda@linux.ibm.com>
Message-ID: <ag8HF_49XPdmD7zh@google.com>
Subject: Re: [PATCH v2 4/5] KVM: selftests: Fix pre_fault_memory_test to run
 on s390
From: Sean Christopherson <seanjc@google.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com, 
	david@kernel.org, seiden@linux.ibm.com, nrb@linux.ibm.com, 
	schlameuss@linux.ibm.com, gra@linux.ibm.com, pbonzini@redhat.com, 
	yan.y.zhao@intel.com, isaku.yamahata@intel.com
Content-Type: text/plain; charset="us-ascii"

On Thu, May 21, 2026, Claudio Imbrenda wrote:
> Add a missing #include <ucall_common.h> which is needed and otherwise
> not included on s390.
> 
> Remove the assertion  vcpu->run->exit_reason == KVM_EXIT_IO  since it
> is x86-specific and redundant anyway.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>
