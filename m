Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A3C43CE63
	for <linux-s390@vger.kernel.org>; Tue,  4 Aug 2026 21:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785877738; cv=none; b=jEbUwiZtQMfiTtjVRV8lO8gOLlM0BjzPKZNvDLzPPQB9fDYzE6ZqTGHPnfd1AVUmdDib4xYdSMmOT1SlhvicHRY4E+RBCoVHpvcDBLd4PtXS0Ons5Xeb5UFyU1PL98bEbhJrMOyAfx+7KFytQKIcz1SOBTvbKsg0VWcq+u4uOkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785877738; c=relaxed/simple;
	bh=B43iZ28kyQuj/oVdK+ysKMvEqAmzWYTHNTxAOsjpuPs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p/fEcdiVJnXBJ6qF/DnOaW+4xiL8p1tP0H9ZS0/O9+I5aSVLZP1AVTgIuZGqO6Ti8BG5YUDjucnm4ItIc0NNSHS9l6wp/jMcfnFKkHdhQcz4x09wojjHYbjG8ZVaeeO8bGDx7fC4VR5XrFFdWYRnHMxljemezjVvBeLalNpKAr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SG3g0pGI; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SG3g0pGI"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38dc085b0a7so337968a91.2
        for <linux-s390@vger.kernel.org>; Tue, 04 Aug 2026 14:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785877736; x=1786482536; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nz3aCp4Uyw3qY+MX7Sv/bu2ByRkx6w/quCe3kJ8ANw0=;
        b=SG3g0pGIoyAD64YwDxeDpGN+p/yg/zWH8SnKSHba5X4kfDWsRJQ+uK3ZI596ljPxYW
         qDRG03x6tomX3jpXAfi1tiMeg8HfIxw07nnoWU71596tAGKTlr5w76QP8uz+7xQcTNzu
         HRYTNpilusueBIVwsjoP3vGN5twZCHZc/8nfKgokeQfP8BcRj0Q60Nem1s3e4Wym/mi5
         XqDzcuJw59lHT1KpP1z7lplDF50dJu6aOpnieUQRjset65b4RrEk5uKocTFFSYIAJYBB
         Bq/ztFWzIuR6fo2/xAf5OA92omhyCrCTknRwpLehSmQOp0Kzw7k/i+zQbRffPrNMevj5
         4x1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785877736; x=1786482536;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nz3aCp4Uyw3qY+MX7Sv/bu2ByRkx6w/quCe3kJ8ANw0=;
        b=DzWo/ksTwAmo2h7XsYsuGTJ1gmnDnexsV7TqkmA/C+SafWTvdhdeO09Unq/i8fM/Ve
         E4xKp8NWYs8+JDRtXhxnX+ZgI5gEd4sWQSd3Eto/qTYqC3XHoeDguSUMkBtkpHa0P1NU
         2EJ4UTjjrjn4vZRpOcRWHQ+tPObhrpG+r5h6wpY4sun+SQ870Dvvdk5wSXXyUBGohCg4
         4ddDO5RuI6OZCfniuS9sTjKDeVmT6LlM1JjEhh0PbGAqQsA7WDbL1MJR28XOlt3fB2p8
         t1f6losqtNEBUfocwdmh0e7N0CsBYN+ZgvwJvmJQrPH46HEE7TtBZ8RDYp6EVah0sxq8
         vGWQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqfw3vcnelEL0SkYWz6s8iIC4WVkAEXS5zuGDGAxydOkjWGcEcbE/SyAlR04cu+MD0ksHpLfyyAjV0b@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5F8aXJyxtiKEL9mMVOFJjDqczOpy8A4yECw9ZGFkRBNywncL7
	OZhkkryzJMigmZvKPDE2JV3CEgpOIcudG7baL/XknsY70xK2kmK6iYyv5xumGrrd0ot4lsIzxf/
	Y7sNDZQ==
X-Received: from pjsa12.prod.google.com ([2002:a17:90a:be0c:b0:38f:e6f2:5944])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d644:b0:38e:2860:253f
 with SMTP id 98e67ed59e1d1-3903c582511mr1841710a91.12.1785877735649; Tue, 04
 Aug 2026 14:08:55 -0700 (PDT)
Date: Tue, 4 Aug 2026 14:08:55 -0700
In-Reply-To: <20260804120529.1730187-7-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804120529.1730187-1-pbonzini@redhat.com> <20260804120529.1730187-7-pbonzini@redhat.com>
Message-ID: <anJU5-5xi3bcW0jf@google.com>
Subject: Re: [PATCH v2 6/6] kvm: return -EFAULT for writes to !VM_WRITE IO mappings
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Alex Williamson <alex@shazbot.org>, bcm-kernel-feedback-list@broadcom.com, 
	Boris Brezillon <boris.brezillon@collabora.com>, Christian Koenig <christian.koenig@amd.com>, 
	David Hildenbrand <david@kernel.org>, dri-devel@lists.freedesktop.org, 
	Fei Li <fei1.li@intel.com>, Huang Rui <ray.huang@amd.com>, linux-mm@kvack.org, 
	linux-s390@vger.kernel.org, Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>, 
	Sergio Lopez <slp@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: text/plain; charset="us-ascii"

I strongly prefer "KVM:" for the scope, and it's waaay more common.

 $ git log --pretty=oneline --after 2015.01.01 | grep "kvm:" | wc -l
 1298
 $ git log --pretty=oneline --after 2015.01.01 | grep "KVM:" | wc -l
 16249

On Tue, Aug 04, 2026, Paolo Bonzini wrote:
> KVM's behavior when the guest writes to a non-writable VMA is inconsistent.
> For regular, page-backed mappings it returns KVM_PFN_ERR_FAULT and thus
> returns -EFAULT to userspace (which is ABI, and relied upon by tests);
> for VM_IO/VM_PFNMAP mappings instead it returns KVM_PFN_ERR_RO_FAULT
> and thus exits to userspace with KVM_EXIT_MMIO.
> 
> This behavior for VM_{IO,PFNMAP} was added by commit bd2fae8da794 ("KVM:
> do not assume PTE is writable after follow_pfn"), and even if it has been
> in place for five years it is unlikely that it is relied upon by userspace,
> since it is inconsistent with KVM itself.  Change hva_to_pfn() to return
> KVM_PFN_ERR_FAULT for all non-writable VMAs, and restrict KVM_EXIT_MMIO
> to the case of an explicitly read-only memslot.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Shortlog nit aside,

Reviewed-by: Sean Christopherson <seanjc@google.com>
