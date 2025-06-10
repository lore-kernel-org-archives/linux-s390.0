Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0AA2918F1
	for <linux-s390@vger.kernel.org>; Tue, 10 Jun 2025 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749563767; cv=none; b=BMgdokKGoydHCsrVEWK0dgFmKEpuxq8ecr2waNW8Zfa+v1zTMmTOOK6pCTaHMh1fW1KkEZLIJxcdDxIm0TzBsnV3hj1y8arCDLfKXvQtv1s/ikMW0GXFO7B56dacFkJwyvXw4iGQKZ4lURR9MSjMuYxqOtvjGGkZ6SGdzVuTA6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749563767; c=relaxed/simple;
	bh=JKwJX9Zf9neB3fBz9oZayEpOcOA5ARWO67UpRj6yp5A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FRDtvgjTanwgUnc17wPFJ/Jw0rKvSRcY6bKrkPujyNqhW1dXd5YdZAB5P+8T0HIrFymCJnkeSRDIbeWwZ3nksGvW4nrrdNkyBRJFqyj0LrZxSLkUracUtbtmSLz6g0nC9qI9UdrqDEFg1Ags4IMEviKxzQ0GzAZMJa8fAdgnAIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZAqHms4w; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZAqHms4w"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-235842baba4so46732605ad.3
        for <linux-s390@vger.kernel.org>; Tue, 10 Jun 2025 06:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749563765; x=1750168565; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x3KVVoKoPgb7czEnOr1ErvqynWAnhwXrGnn4+KyAYR4=;
        b=ZAqHms4wnyqX99ecUjs96ygSAUKnnphdx3P5nIcDcfXIh6TfU0SOExlDZHQWwW2kS+
         9mYTi8mkS8qt7Xkm96tOXU2iJY2Gmnqx+yyJ2SpLTU6Wjuw9ciWzjFesYwzd/BGYC7zG
         zpD3zcePeY7yUQm+MKZB2bL7gyPQWpeD7unScO9V10BweZuOuwfDb3Rl7v4ksCvtb4rB
         Vb1NPmwL1brz+Kykw9ZQlRRldxo/MQ1TanjDTNEKvbvKdMPeruBCOT1ugzsweyRIUBm/
         c8/5DvLAt1vjbO/mjliAEVzW30r1ouV2ehhBPe2HQtywnD+2Cqu0AY2HaB4bP/Ty1A6W
         KG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749563765; x=1750168565;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x3KVVoKoPgb7czEnOr1ErvqynWAnhwXrGnn4+KyAYR4=;
        b=g+HlqzhFABMCH5zc5WOf4ynOdtPp9zKEYcuJ+d3CZEFNxRTJea3WfBN0tZQticT4ao
         EJQfVcvEe9t42OnCjkOcJDjboOG4QtfcRmQ9n4eoiVfsCysUPAdmFkVoH2VWEU4kRLLV
         iabQN/VVD3NFvfFij9c8JqAmNtUPZ4KALEFxMA60nDb3Az1FXzjYKneow+1DslCft8TY
         NijWdPHGOs44IonwnmuiXo6OSykw21/XJ5LyxLpoBdCSSHx2tYeUtChPWbdxDrLnRBXb
         yWNtAEwirIh5golG/mGgXyqPSsxBblxWx1+O7kyjSgOdF2+GbrXZ5Dwx0oSx1ggrnu9W
         fBbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSaIYRxWffWs3IrdVzpAbpvvkA5AbxkYS22JQNRvipPY8ajD0avtQ2joeRC9TZ0mgG0Vj3bRzBTkfI@vger.kernel.org
X-Gm-Message-State: AOJu0YwETFuzsWYnxT1KiceqGg2HSHWzLGp0g3vriKePC4HX+icgatpS
	MvQtyzgTCTj08znOlxKDPIerbXbVfUAHjc3FxpRSmZkOWB762WYxgmElBxWYCgSvZvG7W0jXwFO
	/j37umw==
X-Google-Smtp-Source: AGHT+IF5iWO+Sp3cyEnRYuhYT7CW/Xfid4XVEYLemf3GthWwx71VVskqhGeToz1gNCmRF8eGLZ45Y+Wg+lg=
X-Received: from plbmo12.prod.google.com ([2002:a17:903:a8c:b0:235:895:2564])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c952:b0:22e:421b:49b1
 with SMTP id d9443c01a7336-236383b08f1mr41011285ad.48.1749563764685; Tue, 10
 Jun 2025 06:56:04 -0700 (PDT)
Date: Tue, 10 Jun 2025 06:56:02 -0700
In-Reply-To: <27a6c2fe-8bdf-414f-a49c-19ad626cd131@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250529221929.3807680-1-seanjc@google.com> <20250529221929.3807680-3-seanjc@google.com>
 <27a6c2fe-8bdf-414f-a49c-19ad626cd131@linux.intel.com>
Message-ID: <aEg5ckEXzQnF8PkH@google.com>
Subject: Re: [kvm-unit-tests PATCH 02/16] x86: Encode X86_FEATURE_*
 definitions using a structure
From: Sean Christopherson <seanjc@google.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Andrew Jones <andrew.jones@linux.dev>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, "Nico =?utf-8?B?QsO2aHI=?=" <nrb@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jun 10, 2025, Dapeng Mi wrote:
> On 5/30/2025 6:19 AM, Sean Christopherson wrote:
> > +#define	X86_FEATURE_SVM			X86_CPU_FEATURE(0x80000001, 0, ECX, 2)
> > +#define	X86_FEATURE_PERFCTR_CORE	X86_CPU_FEATURE(0x80000001, 0, ECX, 23)
> > +#define	X86_FEATURE_NX			X86_CPU_FEATURE(0x80000001, 0, EDX, 20)
> > +#define	X86_FEATURE_GBPAGES		X86_CPU_FEATURE(0x80000001, 0, EDX, 26)
> > +#define	X86_FEATURE_RDTSCP		X86_CPU_FEATURE(0x80000001, 0, EDX, 27)
> > +#define	X86_FEATURE_LM			X86_CPU_FEATURE(0x80000001, 0, EDX, 29)
> > +#define	X86_FEATURE_RDPRU		X86_CPU_FEATURE(0x80000008, 0, EBX, 4)
> > +#define	X86_FEATURE_AMD_IBPB		X86_CPU_FEATURE(0x80000008, 0, EBX, 12)
> > +#define	X86_FEATURE_NPT			X86_CPU_FEATURE(0x8000000A, 0, EDX, 0)
> > +#define	X86_FEATURE_LBRV		X86_CPU_FEATURE(0x8000000A, 0, EDX, 1)
> > +#define	X86_FEATURE_NRIPS		X86_CPU_FEATURE(0x8000000A, 0, EDX, 3)
> > +#define X86_FEATURE_TSCRATEMSR		X86_CPU_FEATURE(0x8000000A, 0, EDX, 4)
> > +#define X86_FEATURE_PAUSEFILTER		X86_CPU_FEATURE(0x8000000A, 0, EDX, 10)
> > +#define X86_FEATURE_PFTHRESHOLD		X86_CPU_FEATURE(0x8000000A, 0, EDX, 12)
> > +#define	X86_FEATURE_VGIF		X86_CPU_FEATURE(0x8000000A, 0, EDX, 16)
> > +#define X86_FEATURE_VNMI		X86_CPU_FEATURE(0x8000000A, 0, EDX, 25)
> 
> The code looks good to me except the indent style (mixed tab and space).
> Although it's not introduced by this patch, we'd better make them identical
> by this chance.

Agreed, that is weird.  I didn't notice it in the code, but looking at this diff
again, it really stands out.
