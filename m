Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0F7168DC
	for <linux-s390@vger.kernel.org>; Wed, 10 Apr 2024 18:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712772497; cv=none; b=pQMmzGfujZdCylk5TwL9RfIWtGVTGq1Prq+/PlmVFzT+ppdYSV5I30u1GrPZqNPXqh+Xkj8mc4w/CdRuU1cSsDcHlWAvvYppViF4UTZuGnme0oxkm8ckWqBNVAzvLeMqk2CJNEL2InOcpxWK29Dijc10q+5O0NSlBfOxDqKCHWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712772497; c=relaxed/simple;
	bh=tlQOUyqwZCCGO+a0LSWUCAzWINcC2ww3/hTkEPpmXDw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qnqTVm/nabDNhuGWG+7K0pLtuqRtIGkG6suDKDfyFV5/5QGK5z09xXqaPrpJARAX/FfvksgBo7lwBr7oW6TZkAmjlgsDvd829uDnTuD9/6mt4dXa/3BwXttEyeVQfzTI4toG6CFykajHQtf3aIeELVO/fqsxPdKzJfiuV9Bus3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gDJFOgFu; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gDJFOgFu"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a20c33f06so83426387b3.2
        for <linux-s390@vger.kernel.org>; Wed, 10 Apr 2024 11:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712772495; x=1713377295; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xZflpisHc+9oeh7nBvZbuK3Tx2t0csxEA3Vaxd3rpg8=;
        b=gDJFOgFusBDMiA1Juc/151fTp4sFT1YWV7JGKwC7zKmzlPMAuCGVC0Rnydux/66hzQ
         URP1hA7C4828z1qAIXClSfq6XwMAnkvDMavbvQmf0CiVYPrffZBSHM5Qw4kDJXcCVrR8
         19gg51z071Nt6j2e0H5O8MmLS3nFOzsBjt1c4cNITR4ckofiUBTZVC6KSaFyMRPBeljR
         MAAIninMOWGfvCyRs99N5Xnj7mJc0p7SEvwIqyUC+lwqZXezeoVnCIHCAPZ+5Etfwvsp
         ZfVcCEns/vMzeDaJ0B7XehHVGaODZ2dxUJxeRx4cg3afSQ1LnqQsv6gVk8Ft3PupZcOp
         c6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712772495; x=1713377295;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xZflpisHc+9oeh7nBvZbuK3Tx2t0csxEA3Vaxd3rpg8=;
        b=t+yN5YrOQkHAZEWQOSP68ThDEH7UBSrIro1wk5Sen/q57BiCzzQqxb+3SPJuVh4iyl
         P8xmNYSNKaMOeQkqnt6DC+DNoER5YhucOEr4zxo/uUD6Ynz2Ck6P+uMQObr3MRG7mPLL
         DL4ybKLRXcRSeCVNftBSmxyFO5dYEPAixD48Wd0JVTbZkRuDR7EZ11/hTykmPiaX7bOx
         Y99s0s000UNsqHzqfw37fahy8XForuqY5Ms4pLwe0GmrbKvthHQG+lJCm4eaXxPAHSbX
         +AMaZ2TSG4P937i3wwFgTzmD83CCJ/8zR7GSDbyFdKEmG8gfzL5zweKN2f8N2cX/g6bE
         zeoA==
X-Forwarded-Encrypted: i=1; AJvYcCUcT8lc7lhyWq7V0KeRBfuGivUZhlkBGI7+0neRpIk2UXZLfP3wMeNB7brsxFxWI7H3oT7UxAvh3HNq7ZjgAkv1JoxE5SvAuv6wiw==
X-Gm-Message-State: AOJu0YwFTLCR4L0gIfxSO6bgQI/xmdCsLuHGGCc4ujpN+VutG78l6SfX
	BEEiSMp6UKnOsDK5eWQFLwAY8E1j6xbFSIB8dFW0MTqtQftjTnJ2enxh5NdlMzvkbeRqC9nB+J7
	cSA==
X-Google-Smtp-Source: AGHT+IFhos74HCvbkwq8iBv8vYHsZl4wRFyLhDRmwIqukp0Eu+fKSsgjADRfj3OZlGVnDlRBwuYnPN82INw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:10c3:b0:de1:21b4:76a5 with SMTP id
 w3-20020a05690210c300b00de121b476a5mr290201ybu.13.1712772495155; Wed, 10 Apr
 2024 11:08:15 -0700 (PDT)
Date: Wed, 10 Apr 2024 11:08:13 -0700
In-Reply-To: <20240410155527.474777-3-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240410155527.474777-1-david@redhat.com> <20240410155527.474777-3-david@redhat.com>
Message-ID: <ZhbVjVRoa70IwgfA@google.com>
Subject: Re: [PATCH v1 2/3] mm: pass VMA instead of MM to follow_pte()
From: Sean Christopherson <seanjc@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, 
	linux-s390@vger.kernel.org, kvm@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Yonghua Huang <yonghua.huang@intel.com>, 
	Fei Li <fei1.li@intel.com>, Christoph Hellwig <hch@lst.de>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Ingo Molnar <mingo@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Apr 10, 2024, David Hildenbrand wrote:
> ... and centralize the VM_IO/VM_PFNMAP sanity check in there. We'll
> now also perform these sanity checks for direct follow_pte()
> invocations.

Nice!

> For generic_access_phys(), we might now check multiple times: nothing to
> worry about, really.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

For KVM, a very hearty

Acked-by: Sean Christopherson <seanjc@google.com>
