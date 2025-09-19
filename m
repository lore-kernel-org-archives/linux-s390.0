Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C28254848
	for <linux-s390@vger.kernel.org>; Fri, 19 Sep 2025 00:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758242004; cv=none; b=ddddue0AQVVA6uV+eLYrgWcMIDwSMJT+l+Sas7ukuM6pPFYBouoN7Rz9px/Qp/x1gjeXiIKsfWwLgka31eu4HsD+NEKjz39CBmfK3a8ynbsBXWY0wKoHlbBoybqMQy/LQeeSThaNnM7gGiO7K8C2EQsz2TcOB/ORfXAm7fSMHtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758242004; c=relaxed/simple;
	bh=beOA7yeMJ2oVmvwypx6LdP1/laar+mcAGIBojfsH2oY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IILtd6EHCEfyaH5QRgneJQaKzY2Fko5KQQ5GbBSgL5ZHUyg3eRFwY5/ZdxmYAYkXlX2Ao50lzICKNj7vlGMOIpbcVinRrTrpYpcNOV3w5egibkD6tDJS1Cw2YCdkcIXc9s3AkpViggSy2ZLK6o0anxQup1O4C28R+RsF3MRjow0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wual1gXE; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wual1gXE"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32ec67fcb88so1353985a91.3
        for <linux-s390@vger.kernel.org>; Thu, 18 Sep 2025 17:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758242001; x=1758846801; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=RD/DK6kAG0c67mN/7HOpwDxU9lDZGk0fnKN4zAB6ORM=;
        b=wual1gXEO/qW/KcZbwpbjI0sfoehgcUGLD9x5H5IssZtwVGw1NDTs0m/FavAeb0uWd
         hJezfbf4ec0ve+CJ8ri6xoPdmbJhNd43fHRSqAky+UdLoM2+OMQVkRc3Cb3X3PJLbfI4
         8C3KMBbIY+54TStHLijE8z1Ov0x2jdnnoIP5hcyos0ofFhya0/ZIy+OoS+yimlrlM/Ge
         TbZ++UWriWCVW2aOhubu4sAgGGxWOsQfaWG1Vg8u3QszBVt5oshCh9zuBgASzj1kIanL
         /FgadlFwL0mzQsHkmJxMQcTn4i+/LucAJ5ylSCG1fu9waaPgXjZ5tKrYnrCNGG+4VYnV
         YdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758242001; x=1758846801;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RD/DK6kAG0c67mN/7HOpwDxU9lDZGk0fnKN4zAB6ORM=;
        b=heAztusOtGiDwjUHDQgWnm2KxpvxxAiuj4TkxGy2PxyQHYz/fBE7O1fM2KWacCYjO5
         v2Qn17ovy57J+8ik1ERzbDI4uv7ZfaVvc3mzc1Py4ezcV2JlbNOb0Ggl/2lCYL2Ci69d
         adszgn5w0O/pAxABulg2Qu+rmWJoN2/FMq4do4+nDj6kYSd8YFL1lWITytHYxtduX6mu
         mD0PHW+GMBainrb+VuVWpe56e68ahehtSGeNT1ucZf2V0m/BF8SOEkB9Gfkx6Y23RG4N
         N0I5XVNIMnd6wZnoTOPIl9ALscCs0uOb+ZQvzEzi5g7VqRyTVpm8fntMX2GRU31iiFJC
         ePmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDcW1SdIkSjKJQEfbd5y/x5xIKBV55OesiJcGvJX2j+7VpqTIvPoIsx/yy3jwEcuy6Y6sHM7HIpAac@vger.kernel.org
X-Gm-Message-State: AOJu0YzOZd00SVargZ5J5OyGIewiBkpj+3mrgyNcuDFJKaYkccufvhlK
	dN7hh6Q3hxVd/WUbU25CMUVDRboNl8G5P8/YbK7I0J+f2C2oZ9vFlIVOkahjeDvgFNqTRzDDW7O
	K6vWKkw==
X-Google-Smtp-Source: AGHT+IEhgM6vmYfPOslFAinl0W4DEpXPFYuyJm2Gwrf0Sw+W4NYJijAe6YZgNnvs4sWIJBhjxXbmqFTMuoE=
X-Received: from pjbpw5.prod.google.com ([2002:a17:90b:2785:b0:330:7dd8:2dc2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c88:b0:32e:b36b:3711
 with SMTP id 98e67ed59e1d1-3309836d7c3mr1410096a91.28.1758242001517; Thu, 18
 Sep 2025 17:33:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 18 Sep 2025 17:33:02 -0700
In-Reply-To: <20250919003303.1355064-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919003303.1355064-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919003303.1355064-5-seanjc@google.com>
Subject: [PATCH v2 4/5] KVM: x86: Drop pointless exports of kvm_arch_xxx() hooks
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Tony Krowiak <akrowiak@linux.ibm.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, 
	Harald Freudenberger <freude@linux.ibm.com>, Holger Dengler <dengler@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Drop the exporting of several kvm_arch_xxx() hooks that are only called
from arch-neutral code, i.e. that are only called from kvm.ko.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e07936efacd4..ea0fffb24d4d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13542,14 +13542,12 @@ void kvm_arch_register_noncoherent_dma(struct kvm *kvm)
 	if (atomic_inc_return(&kvm->arch.noncoherent_dma_count) == 1)
 		kvm_noncoherent_dma_assignment_start_or_stop(kvm);
 }
-EXPORT_SYMBOL_GPL(kvm_arch_register_noncoherent_dma);
 
 void kvm_arch_unregister_noncoherent_dma(struct kvm *kvm)
 {
 	if (!atomic_dec_return(&kvm->arch.noncoherent_dma_count))
 		kvm_noncoherent_dma_assignment_start_or_stop(kvm);
 }
-EXPORT_SYMBOL_GPL(kvm_arch_unregister_noncoherent_dma);
 
 bool kvm_arch_has_noncoherent_dma(struct kvm *kvm)
 {
@@ -13561,7 +13559,6 @@ bool kvm_arch_no_poll(struct kvm_vcpu *vcpu)
 {
 	return (vcpu->arch.msr_kvm_poll_control & 1) == 0;
 }
-EXPORT_SYMBOL_GPL(kvm_arch_no_poll);
 
 #ifdef CONFIG_KVM_GUEST_MEMFD
 /*
-- 
2.51.0.470.ga7dc726c21-goog

