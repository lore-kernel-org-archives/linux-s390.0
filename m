Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364EB4FB9C3
	for <linux-s390@vger.kernel.org>; Fri,  4 Sep 2026 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788536214; cv=pass; b=jcyPGO4Mkwa6i3Z5Rtk71Tok2CJvwRf7zfkebs8p4yO85G+w0kVWOTH4ppGr4jNDBjSma00hJdGxc98J2/V9l8tpWnlFsiWs2YB/9Aslo692XCo7047wJyoFREO3NpWdIfyjAHQY17e180vDAqd6BXraXHUUwjGUDjCLV/uGKWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788536214; c=relaxed/simple;
	bh=o8HNsLeZzORg+lffL2AzJCaTytWq6/qRqD0NFejzqwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lqLZ8AIUYUo3KSfJnmp04mIqS41GItQeim3g7MtyEIIEXoOo8YLdL896KM+7s+DbpvepmE3TXAf7tAQ/IzXNadsKARRhFLDAv6OTL/zHNYwnLjTHaX6MtsU793rv2LQ9IHadMNyYI5YxghGMwQliber85i6cAu+bMJxX9lgjwxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GgB1wlPy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eO/wWNUt; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GgB1wlPy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eO/wWNUt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788536210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UhUfCEAvWX3HQ4TKnpOsQaNeGPkBhU8moeSBLrDZbeE=;
	b=GgB1wlPyIaIpkceMHTqOvhYO+dD8Lp/X4w+oxck3pp5grmcsiI65bmKZvwhnul0N1niwCG
	9H7RURxeT/j/TabAqUTJeJmkdNQqMhKEbQWrJ0iGgaIOuKxwYxfjamn/7nUKP2EkeuvTpF
	LvRF8/mc2Pl16Q44XVx8UdmcNb9X/7E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-QEuCFqdDMLGxEPh7kYE-5A-1; Fri, 04 Sep 2026 11:36:49 -0400
X-MC-Unique: QEuCFqdDMLGxEPh7kYE-5A-1
X-Mimecast-MFC-AGG-ID: QEuCFqdDMLGxEPh7kYE-5A_1788536208
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-482e2541c30so809956f8f.1
        for <linux-s390@vger.kernel.org>; Fri, 04 Sep 2026 08:36:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788536208; cv=none;
        d=google.com; s=arc-20260327;
        b=CQxcLM6XQOVCOAagMKTAv3OAZ4F2MHukJWmMkjuRNfjdLeApLRX2XGMYf3Jv+N0bdB
         +8LGdlLGM6HbZzo1RMKoVN2ifHSEXwGQS2BSqkwQVkDla7WRppD/hWqImIae0pEHBtbC
         87+DDk5D08rANs5XCmjEwjlMmmTq71LadRlRwrA2p9m/uoWpKg9hIAeSrs2KQwjLnQP1
         cb9hDl2Lgmrtlw1j/XLdwGCuvDLtIkV2sU4RIhb5pgqTKiltghB+FsZ1rLew0Zok+fcD
         +DjgrP0n06utcROI5iHwYEM6UB1UtWrmF/jvBBY8giLTMdpHzTcVKcSASHWyKx/MONMu
         OuUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UhUfCEAvWX3HQ4TKnpOsQaNeGPkBhU8moeSBLrDZbeE=;
        fh=09+E+jVb/UzNURJga2qLmmPiPiwc9oC/5NyjM7MS11I=;
        b=RSZvfzkNNN52ZV8jhumTuguIoRg3s1X27qFKb2ed0dCRk9eGrh+6B287B3UI444hjT
         ScDKFQvw/UzoBU/qj3YZS+aRjLuL6ntzttT71OM/XGX7l84+P8UsfJ68wPXDZ1TwlN+x
         su37lLRG1huJeNo9mT8jfA+Avy0RKM/KdcqY8lM7p81NlY5ywspLZBHyilBXB1Htrvtp
         4HJul5UihpxLyF+jw9+12WtPZF4Pkc+bOalj153Iroc7NOGXQTka11B0RLGCHBPRykvU
         GrsB57PgjYg7A6QA72G5jUf8TjXHtniomU367gumy2rj6+mQMGyrEsOgWNB7N3epFrNo
         x0zg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788536208; x=1789141008; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UhUfCEAvWX3HQ4TKnpOsQaNeGPkBhU8moeSBLrDZbeE=;
        b=eO/wWNUtNTyaAQsu4ON53RQOyGfTC7N3dEhhsJmLvvUxr/nyjJtd9XcAWiFARKdKqq
         iQbcaUKGE3su/Z9vddix+Zl4kQtB8uoPlx9dLWDT5NWzj3sYuFKPYJma3C+2emX98jat
         BUiyeO+FCYGi407GzDuAwk1ZEFrMdHCfsneUDq7ViaWq9+rv8qVVTVQt00Lc1fWZ3yjf
         QEphYiKXQurHdghIPRstOzzupt1O3iiXKWfGbFUeloxCOn5/NgfkrwQcd4cD/0vpcNwP
         uhw9l/ctYEzo3dJkjzTuXPhsgJcIpc79N6lFYbwDXxz8ULs9MG6V7WltZYzshvFUfRP0
         Dh0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788536208; x=1789141008;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UhUfCEAvWX3HQ4TKnpOsQaNeGPkBhU8moeSBLrDZbeE=;
        b=eXZQxZKdwEAiBdDrwFDExUJ5evdLhbkq7VJHVPV4ArC7D3iibDzFrkjA8/ByCco1OW
         n/LUywlT5A6WQP3/Wa28cp7+g6h+ysIc9YyBG7rLn+ZolnhRiLWlR9jz2ZaTNvGBMXIr
         Nm6GRHt4afwfsNm5ZWgh2Fh9UEYWTGBdyjU5NLJymmb91+wyHv3bp2VBuBaTjxpQeLgx
         fcf52q4DBtV/C3MIH1tFSG8OSn1d3U1IrW59HnagTAkAkukiJ0MADJCRYEPWPxbmdMeS
         0EoilYmr3teh9LCdColyMMc0K0f8qxiniHVRf2DOXOnTs4pUw9XnlScVztUidridTrdb
         SEiA==
X-Forwarded-Encrypted: i=1; AKwUvBwo3Lr2EecEAneEly15b+mCE10HP+oYxm9k/fiYHQHc8sBr68NHfHelL88XRRq46YB7mezm/naeAOVp@vger.kernel.org
X-Gm-Message-State: AFuF++ly1S4h7GRe9TouWGDHQCBWwv9wV7hVVM//o2wCfZEthuv71D/3
	+fZr6tHc3wBPhkuFsGfTMNn7U8YhpTCPnlDBUYVuaKUaAztUhXbYb1E7pcobsdlJaW7TSfjVZkJ
	z64xxManD7Bq0GlzfUYasITmgg9zBfhvD9Lxtx4EJwbDP7W8ouhl7o7qVoDqpjEEw/BFOrZqaSd
	oXYH5bN6LxALmRNt2nplBW7qz1g94n9CvWJWj7ig==
X-Gm-Gg: AYBFou093E6d2iCIADwGj9S7QwaVBK7wHxaqPBZvr9/XAvf/ppWxi0osCF3Er/nJbFP
	B7B5dA1G+AjsyeTaIJyJS8EcE+W4N0Sv7h3lHzJLDp7Ade4pfA7kCkVaW235mAF7h3hqYuBS+o0
	/XJZRbReHKpdIAC3lqo8uOULpf6Ra/ieabfUZrGwWslKnfSzBmHzvfiu0HBMsj2ZUt2OhUcv2W+
	IeicU9xY+38SISeVqusHDvYzJ+Ncf9I95O2q0JI71XJImBdC+EVSd7LSMEqDA==
X-Received: by 2002:a05:6000:4105:b0:485:8226:c694 with SMTP id ffacd0b85a97d-4858226c967mr11829104f8f.19.1788536208231;
        Fri, 04 Sep 2026 08:36:48 -0700 (PDT)
X-Received: by 2002:a05:6000:4105:b0:485:8226:c694 with SMTP id
 ffacd0b85a97d-4858226c967mr11829033f8f.19.1788536207632; Fri, 04 Sep 2026
 08:36:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904060647.562443-1-imbrenda@linux.ibm.com>
In-Reply-To: <20260904060647.562443-1-imbrenda@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 4 Sep 2026 17:36:28 +0200
X-Gm-Features: AcwNN1UM7o-vZcW8Wc3wn3D5DYydTSSdA81i2MBw2kUOwZogbcxlqjZ4yCZ7sPI
Message-ID: <CABgObfZ1E2+-KmM=dGm8S=jLX1vWb_qrFg00xt4u3VB94EzmRA@mail.gmail.com>
Subject: Re: [GIT PULL v1 00/11] KVM: s390: Misc fixes
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, 
	borntraeger@de.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 8:07=E2=80=AFAM Claudio Imbrenda <imbrenda@linux.ibm=
.com> wrote:
>
> Ciao Paolo,
>
> Here you have a bunch of fixes to bugs found in the past few weeks.

Pulled, thanks.

Paolo

>
>
> Anthony Krowiak (1):
>   s390/vfio-ap: fix KVM GISC and page leak when queue removed from host
>     config
>
> Claudio Imbrenda (8):
>   KVM: s390: Fix dirty marking in adapter_indicators_set*()
>   KVM: s390: Fix compile warning for kvm_s390_update_cmma_dirty()
>   KVM: s390: Fix _gaccess_shadow_fault()
>   KVM: s390: Refactor dat_set_slot()
>   KVM: s390: Move all code into s390_kvm_mmu_prepare_memory_region()
>   KVM: s390: Add missing srcu in kvm_s390_set_irq_state()
>   KVM: s390: Fix potential races in dat skey functions
>   KVM: s390: Fix race in _destroy_pages_crste()
>
> Steffen Eiden (2):
>   s390/uv: Fix loop condition in uv_find_secrets
>   s390/uv: Prevent potential out-of-bounds read
>
>  arch/s390/kernel/uv.c             |  8 ++-
>  arch/s390/kvm/gmap/dat.c          | 65 ++++++++++++----------
>  arch/s390/kvm/gmap/dat.h          | 10 ++--
>  arch/s390/kvm/gmap/gmap.c         |  6 +-
>  arch/s390/kvm/gmap/kvm_mmu.c      | 91 +++++++++++++------------------
>  arch/s390/kvm/gmap/kvm_mmu.h      |  4 --
>  arch/s390/kvm/s390/gaccess.c      | 13 +++++
>  arch/s390/kvm/s390/interrupt.c    | 79 ++++++++++++++-------------
>  arch/s390/kvm/s390/s390.c         |  3 +-
>  arch/s390/kvm/s390/s390.h         |  2 +-
>  drivers/s390/crypto/vfio_ap_ops.c | 18 ++++--
>  11 files changed, 156 insertions(+), 143 deletions(-)
>
> --
> 2.55.0
>
> The following changes since commit 786262be6048deab760f68c8acc2c856071658=
94:
>
>   Merge tag 'edac_updates_for_v7.3_rc2' of git://git.kernel.org/pub/scm/l=
inux/kernel/git/ras/ras (2026-08-31 20:10:39 -0700)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/=
kvm-s390-master-7.3-1
>
> for you to fetch changes up to f47190b08b71e8482072978373ee88cb2dfbdaf4:
>
>   s390/uv: Prevent potential out-of-bounds read (2026-09-02 18:50:42 +020=
0)
>
> ----------------------------------------------------------------
> KVM: s390: Misc fixes
>
> A bunch of fixes to bugs found in the past weeks.
>
> ----------------------------------------------------------------
> Anthony Krowiak (1):
>       s390/vfio-ap: fix KVM GISC and page leak when queue removed from ho=
st config
>
> Claudio Imbrenda (8):
>       KVM: s390: Fix dirty marking in adapter_indicators_set*()
>       KVM: s390: Fix compile warning for kvm_s390_update_cmma_dirty()
>       KVM: s390: Fix _gaccess_shadow_fault()
>       KVM: s390: Refactor dat_set_slot()
>       KVM: s390: Move all code into s390_kvm_mmu_prepare_memory_region()
>       KVM: s390: Add missing srcu in kvm_s390_set_irq_state()
>       KVM: s390: Fix potential races in dat skey functions
>       KVM: s390: Fix race in _destroy_pages_crste()
>
> Steffen Eiden (2):
>       s390/uv: Fix loop condition in uv_find_secrets
>       s390/uv: Prevent potential out-of-bounds read
>
>  arch/s390/kernel/uv.c             |  8 ++--
>  arch/s390/kvm/gmap/dat.c          | 65 ++++++++++++++++------------
>  arch/s390/kvm/gmap/dat.h          | 10 ++---
>  arch/s390/kvm/gmap/gmap.c         |  6 ++-
>  arch/s390/kvm/gmap/kvm_mmu.c      | 91 ++++++++++++++++-----------------=
------
>  arch/s390/kvm/gmap/kvm_mmu.h      |  4 --
>  arch/s390/kvm/s390/gaccess.c      | 13 ++++++
>  arch/s390/kvm/s390/interrupt.c    | 79 ++++++++++++++++-----------------
>  arch/s390/kvm/s390/s390.c         |  3 +-
>  arch/s390/kvm/s390/s390.h         |  2 +-
>  drivers/s390/crypto/vfio_ap_ops.c | 18 ++++++--
>  11 files changed, 156 insertions(+), 143 deletions(-)
>

