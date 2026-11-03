Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793718214;
	b=mSDObXcx7DfdJ2XstgEprwewpfD5wk+LCQr2ODfIvbgdwzzq2kicZ9o8lZuhtOJycVvk
	 bSeIqhrzkp4dcOKtP7/TLRlItu8/d2xE13w9knu8E6c+0nvUVqQlA+RgCAtWtEqD9pDQL
	 IsuGa+bJ8XhJEf/HX8K+HxYih6AZlWM97xzweFbU/04eM+g89KykNjUZ5vpZac4zDxJFr
	 w3uFo3KmUGpTx9QhYbhSj/AtNjRQVh9f67qyssI7Dk4+K70OuCGSy1TKqxAQ0zvEOaGPF
	 3psMnBfI1+MCxWV3q2haHaI6Qc59xPkugWuD9jtEjUVfS4c+fXMSt1FynpOnP0mUyDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793718214;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=U1cgiMD/xdrAAoWIqAxeQiqT29OTjecADPn89igAbnA=;
	b=1eSt/dW5KSBkl964RuOFgFEMdNFvx6p2LW7Rgv7TCMAYOW6LRfStx/5pRp0RPLXVlLdE
	 zdk0Fv6yoYQ8TFWy5if2D5Qv2/mFMN7usIh61sYJpgCfXBT3FhYmbP2ydHvGUbb9OtHoJ
	 z/w+wlU1zcMrSv7fRTJzXTa6yTx2g6of4ZZNv6S/PntdRJztBH+1izgAvMkYnDvYPWp9/
	 fPD3+SNKBu4S5XNLcXci8gVKqCjOKm+sbcY/YJe9VC29972lc0fTFRZCPYYVpvvnJXbMC
	 HHbw8aEVRYbBAPyePGeBRbrzkXNIwQsL7N/XWvG7B+5mti9IXuWP3k3b9Unzw2Hz+Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WYSLWugz;
	arc=none smtp.remote-ip=209.85.215.199
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BA8606B271
	for <linux-s390@vger.kernel.org>; Tue,  3 Nov 2026 15:03:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31BA8606B271
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WYSLWugz
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cdaf2a74482so2220097a12.3
        for <linux-s390@vger.kernel.org>; Tue, 03 Nov 2026 07:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793718213; x=1794323013; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=U1cgiMD/xdrAAoWIqAxeQiqT29OTjecADPn89igAbnA=;
        b=WYSLWugzFuNm4Kq224vW+Mtkvsl2neSTgZBMrPgSmEKac3ov2ufcElfcvoyepJJn6f
         JxnkQBp8SHxk8VB+L0keiYB1AMoFJ5f9ba1S8NanI1pf6f4huAEPxuLXeTJgl2gQ60a+
         HQhmM5JqlPBt8lVUK8hIOVtUdNfOWTZvu8F5RWqWzRLAhu0TcdpXLYqO6fNF2oREz7k3
         XryMJ/6DA3O6a1N/l8ybWr85Ta3prQYffWP0qlmXpH+hrTSSzsilEM/FEcVJ7On+Y9zh
         3VAKC5vThgpSeJT17ky9XTa3Ll3OdZ5oakw8OkcxH7BQzM+uqaA5T97fOsetveJ1XdD/
         oQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793718213; x=1794323013;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U1cgiMD/xdrAAoWIqAxeQiqT29OTjecADPn89igAbnA=;
        b=oi/vWwGxGs4oITRQov/vy+QkYQPEILcUKJpFzDDYyOl6QYh/IzZCjIxhCrJJdWJE6G
         EzIVjx2LAR+gjp+wMtNh8OP9u0LRYVLpYnfw5XYQ/cOU8Ye+euqpHOQSzljPzNCYxaOc
         +l0cCYLlHASAioCsvWK2omBWuGrk4V8qact9MI+wzdAnDnhN21GZszJ31+dXfeFr9rUc
         q/QtexdH3yUHDld0aQiCAH0RMAlA9GY+6TSZzis3SCD1muXSSf+lL5R8HElKG54ZuYQ1
         5wlRNocRc+xyJtLRe5qiDhntmVfH3SgLB8L7Z5r9ytzIPO2rzPZwXZdSocjPtU1+FxQy
         UGrQ==
X-Forwarded-Encrypted: i=1; AKwUvBz8LG4jD687fPH2GUZgbxgKZtFk6eQyjMCc4XJ9v+Y52zfDhrJCHUvDfc762nr8Ie9l2t+f1ygMlaqc@vger.kernel.org
X-Gm-Message-State: APuU4Z8z3UTZr/neuq0QjuRU6/JAr8kt6gCAcXlNgJCcuMqrRGaBZdx3
	Yo7ZvSjgn0gOv4Pi3EuaKqoLdllr51WpjsHMy0nzdM51aZGFsJih0W+VJq3bC8sBo6SEnHeQzL/
	rgQVUWw==
X-Received: from pjdn32.prod.google.com ([2002:a17:90a:2ca3:b0:3a8:837d:95c7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:52c5:b0:3ac:a11a:7c79
 with SMTP id 98e67ed59e1d1-3ae89776aebmr10680806a91.16.1793718213083; Tue, 03
 Nov 2026 07:03:33 -0800 (PST)
Date: Tue, 3 Nov 2026 07:03:31 -0800
In-Reply-To: <b9ed9dd4-a1d0-466b-a6cd-89a4e70abed0@suse.de>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261029143336.390231-3-clopez@suse.de> <20261029175203.5bdd51d7@p-imbrenda>
 <df9dc526-4275-4784-8a0c-2e4fa8e96402@suse.de> <20261030133939.630e29af@p-imbrenda>
 <auis0SaMkRB6odsK@google.com> <b9ed9dd4-a1d0-466b-a6cd-89a4e70abed0@suse.de>
Message-ID: <aun3w8gxwlmRy-GW@google.com>
Subject: Re: [RFC PATCH 0/4] KVM: x86/mmu: don't zap secondary MMU on
 permission upgrade
From: Sean Christopherson <seanjc@google.com>
To: "Carlos =?utf-8?B?TMOzcGV6?=" <clopez@suse.de>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, linux-mm@kvack.org, 
	pbonzini@redhat.com, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2026, Carlos L=C3=B3pez wrote:
> On 11/2/26 4:31 PM, Sean Christopherson wrote:
> > On Fri, Oct 30, 2026, Claudio Imbrenda wrote:
> >> On Fri, 30 Oct 2026 12:11:07 +0100
> >> Carlos L=C3=B3pez <clopez@suse.de> wrote:
> >>
> >> [...]
> >>
> >>>> regarding this series:
> >>>>
> >>>> on x86 you don't care what the new permissions are, because you're
> >>>> updating when re-faulting (if I understood correctly). =20
> >>>
> >>> Correct.
> >>>
> >>>> for s390 it might be beneficial to know what the new permissions are=
;
> >>>> of course we could look up the vma and find out, but since you are
> >>>> already checking the permissions, maybe you can find a way to also
> >>>> convey the new permission bits?
> >>>>
> >>>> that would make our life on s390 easier :) =20
> >>>
> >>> Right, getting the new bits from vma->flags should be trivially done
> >>> from the MMU_NOTIFY_PROTECTION_VMA callsites. There'd be no users in
> >>> this series though.  The rest of architectures still need the notifie=
r to
> >>> tell them if the change is an upgrade, since they don't have an easy =
way
> >>> to grab the old RWX bits. Passing the old RWX bits from the MMU notif=
ier
> >>> does not seem trivial to me either.
> >=20
> > But why is core MM even doing mmu_notifier_invalidate_range_{start,end}=
() in the
> > first place?  I.e. why add MMU_NOTIFIER_RANGE_PERM_UPGRADE?  Just skip =
the
> > "invalidation".
>=20
> I briefly mention this in the cover letter, but in short, denying other
> users the notification seems like an overly intrusive change for KVM's
> benefit.=20

There are all of two other users:

  $ git grep -w "\.invalidate_range_start"
  drivers/gpu/drm/nouveau/nouveau_svm.c:  .invalidate_range_start =3D nouve=
au_svmm_invalidate_range_start,
  drivers/infiniband/hw/hfi1/mmu_rb.c:    .invalidate_range_start =3D mmu_n=
otifier_range_start,
  virt/kvm/kvm_main.c:    .invalidate_range_start =3D kvm_mmu_notifier_inva=
lidate_range_start,

and AFAICT neither of them wants an invalidation even for protection upgrad=
es
either.

> A flag allows users to opt in instead.
>=20
> It is also not clear to me that secondary MMUs are not relying on the
> notification in some subtle way. In fact, Sashiko points out in reply to
> patch 4 that the notification lets KVM retry the APIC access page reload
> in case userspace shoots itself in the foot by calling
> mprotect(PROT_READ) on it. This would require a really weird VMM,

s/weird/misbehaving

> as it would need to go looking for the page's address, but breaking this
> would be a "regression" nonetheless. I will address this in v2.

Nah, there's zero chance any real VMM is doing mprotect() on the APIC acces=
s page.

More importantly, doing nothing if updating the mapping fails and APICv is =
enabled
is wrong.  KVM needs to ensure vmcs.APIC_ACCESS_ADDR is fresh when running =
a vCPU
with APICv enabled, even if that means putting the vCPU into an infinite lo=
op.
VMX doesn't support "inhibiting" the APIC access page, i.e. the memslot can=
't
disappear while the VM is alive, and if userspace mucks with the VMA, then =
KVM
needs to prevent running the vCPU until the mapping is restored, irrespecti=
ve of
mmu_notifiers.

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 464d6ed862d5..11b24a42e482 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6928,8 +6928,10 @@ void vmx_set_apic_access_page_addr(struct kvm_vcpu *=
vcpu)
 	 * APICv is enabled, but paranoia won't hurt in this case.
 	 */
 	slot =3D id_to_memslot(slots, APIC_ACCESS_PAGE_PRIVATE_MEMSLOT);
-	if (!slot || slot->flags & KVM_MEMSLOT_INVALID)
+	if (WARN_ON_ONCE(!slot || slot->flags & KVM_MEMSLOT_INVALID)) {
+		kvm_make_request(KVM_REQ_APIC_PAGE_RELOAD, vcpu);
 		return;
+	}
=20
 	/*
 	 * Ensure that the mmu_notifier sequence count is read before KVM
@@ -6946,8 +6948,10 @@ void vmx_set_apic_access_page_addr(struct kvm_vcpu *=
vcpu)
 	 * if APICv is permanently inhibited, i.e. the memslot won't reappear.
 	 */
 	pfn =3D __kvm_faultin_pfn(slot, gfn, FOLL_WRITE, &writable, &refcounted_p=
age);
-	if (is_error_noslot_pfn(pfn))
+	if (is_error_noslot_pfn(pfn)) {
+		kvm_make_request(KVM_REQ_APIC_PAGE_RELOAD, vcpu);
 		return;
+	}
=20
 	read_lock(&vcpu->kvm->mmu_lock);
 	if (mmu_invalidate_retry_gfn(kvm, mmu_seq, gfn))
