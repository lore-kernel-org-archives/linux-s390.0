Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C7D212D94
	for <linux-s390@vger.kernel.org>; Fri, 10 Jan 2025 16:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736526136; cv=none; b=O+rZnS5RdP/awIiUWYkiUGi5Qjzi/9r7Ey+bPjAhrWKapdfvXt/v8Rax7rESIeqjPiZc3+vR9xXpCdJ6t2bc6CGKQEkP3a3QSVxspQkWduVuNDgGcOURSTEH2KF8jU9lwSfFgdVhVgm00eo+7I8VeNDJ2ruOtSEvPHUfVK8LiQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736526136; c=relaxed/simple;
	bh=7tbE1EknafufIeEOfWECJVmfp6qzGewDpbJyjqfT8mU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TIEhgHL7inzfUcF/tt8O9v8LhS0mexxU0UzbLZfQxIHQEQX6tdfcDHDT6nBz3utUy1G9jP93Dye6+MSnMbnN4BCLcaCZRjVOLSr//KMCgkN/WOqIRJuxEDKFAF4B32kADAWABcHP73Hv/Bo5INvZMhm3mwTaEsFF2sbPN61m+Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ndqW78ov; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ndqW78ov"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ef79d9c692so5907324a91.0
        for <linux-s390@vger.kernel.org>; Fri, 10 Jan 2025 08:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736526134; x=1737130934; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J5zfXZBz0Ie4r2+B7dw46PzN47vIdY5aKU5O9HCHZcg=;
        b=ndqW78ov71twlRciKdNVp71UtGCn1IhvlQJmpjvbxcc+pjVfPbvoQdwEUcQ0U/aIbI
         ausSdTRk/GlzkHvaR3BKCq6WH+Xy3t4AZmrJZs8JDl7JJz8bDPb/QFb0ZAEYoN/XlSWw
         JDAq1sgcjJeS/UymMBJGRg4Kxvq+1bKoEtMOljXlH5d3BN2yvU4TgX0UCJwZXiOthIwk
         +6/o/j4DrlF5ItmvEhqLQbAIKgtHs52eWwORI4w9Z/G47HdSq67YROJUqLdtr6VINLNx
         rpgSj9RzIqjtDwI4JgFRSODLiSM9abKpPZ9rGIF2GLSu9DGz1heOY347oCvrI9goUx7G
         /FdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736526134; x=1737130934;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J5zfXZBz0Ie4r2+B7dw46PzN47vIdY5aKU5O9HCHZcg=;
        b=QKZAPPx0scniFEtz00d477g91o/C5vstLic9ROCYKEhhtk7WUKLOSE8al8ZZFhrrHn
         KtWGIi9C7v0tji5spbFgPEcYj/w2cHK3SWvvKeElxW++Lwphv1MhjK+t5+2FC/3DN5+w
         kSzoy79ngOWW59laO5oSo6Ndeo+OkG9OoWflQT+Uqvu7iPL6zymmbnoVkpO0jwA5euYU
         gs4wrS+5YfPsmQfZr26H9Oc41zg6XFR2tMqT2HtigW5D20n5Fvi0gCZY4b61XGogZujA
         yseriVQcahaIubTyAVcg85HYuCujKlet3RUPgbJwoMqryvEKhDPstWBYvbJvBnkeuDLy
         gHHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsVLeWk1TwsqcKYZfnDv4NXo16x5UHA79DU8TPZbD1HpD8m4WH+MSdf79JWRO3ev8aBo8UYFp5G2SX@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo0PQQMO71Ri09aakgnw+jv2ZKIDmJr5eQkrlb48iuksdtlVUr
	MHkTgRKkx5HGS6evKhfN84Eprb6Z1HvwYgy/blto2bWdfI2PhOIMJWmRNp4xwXRXh819SDqMHe9
	QYQ==
X-Google-Smtp-Source: AGHT+IFPS5y+JBvCkBzcYIXPkk5pS6485cthrEIztbH/inEP1QyHqKFondqAMfQ8VCTShXc5QagGXx4q+lI=
X-Received: from pjyd8.prod.google.com ([2002:a17:90a:dfc8:b0:2ef:973a:3caf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:fc4f:b0:2ee:6d04:9dac
 with SMTP id 98e67ed59e1d1-2f548f7ed36mr14219063a91.32.1736526133962; Fri, 10
 Jan 2025 08:22:13 -0800 (PST)
Date: Fri, 10 Jan 2025 08:22:12 -0800
In-Reply-To: <20250110124705.74db01be@p-imbrenda>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250108181451.74383-1-imbrenda@linux.ibm.com>
 <20250108181451.74383-3-imbrenda@linux.ibm.com> <12a4155f-9d09-4af9-8556-ba32f7f639e6@de.ibm.com>
 <20250110124705.74db01be@p-imbrenda>
Message-ID: <Z4FJNJ3UND8LSJZz@google.com>
Subject: Re: [PATCH v1 02/13] KVM: s390: fake memslots for ucontrol VMs
From: Sean Christopherson <seanjc@google.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, 
	frankja@linux.ibm.com, schlameuss@linux.ibm.com, david@redhat.com, 
	willy@infradead.org, hca@linux.ibm.com, svens@linux.ibm.com, 
	agordeev@linux.ibm.com, gor@linux.ibm.com, nrb@linux.ibm.com, 
	nsg@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Jan 10, 2025, Claudio Imbrenda wrote:
> On Fri, 10 Jan 2025 10:31:38 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
> > Am 08.01.25 um 19:14 schrieb Claudio Imbrenda:
> > > +static void kvm_s390_ucontrol_ensure_memslot(struct kvm *kvm, unsigned long addr)
> > > +{
> > > +	struct kvm_userspace_memory_region2 region = {
> > > +		.slot = addr / UCONTROL_SLOT_SIZE,
> > > +		.memory_size = UCONTROL_SLOT_SIZE,
> > > +		.guest_phys_addr = ALIGN_DOWN(addr, UCONTROL_SLOT_SIZE),
> > > +		.userspace_addr = ALIGN_DOWN(addr, UCONTROL_SLOT_SIZE),
> > > +	};
> > > +	struct kvm_memory_slot *slot;
> > > +
> > > +	mutex_lock(&kvm->slots_lock);
> > > +	slot = gfn_to_memslot(kvm, addr);
> > > +	if (!slot)
> > > +		__kvm_set_memory_region(kvm, &region);

The return value definitely should be checked, especially if the memory regions
are not KVM-internal, i.e. if userspace is allowed to create memslots.

> > > +	mutex_unlock(&kvm->slots_lock);
> > > +}
> > > +  
> > 
> > Would simply having one slot from 0 to TASK_SIZE also work? This could avoid the
> > construction of the fake slots during runtime.
> 
> unfortunately memslots are limited to 4TiB.
> having bigger ones would require even more changes all across KVM (and
> maybe qemu too)

AFAIK, that limitation exists purely because of dirty bitmaps.  IIUC, these "fake"
memslots are not intended to be visible to userspace, or at the very least don't
*need* to be visible to userspace.

Assuming that's true, they/it can/should be KVM-internal memslots, and those
should never be dirty-logged.  x86 allocates metadata based on slot size, so in
practice creating a mega-slot will never succeed on x86, but the only size
limitation I see in s390 is on arch.mem_limit, but for ucontrol that's set to -1ull,
i.e. is a non-issue.

I have a series (that I need to refresh) to provide a dedicated API for creating
internal memslots, and to also enforce that flags == 0 for internal memslots,
i.e. to enforce that dirty logging is never enabled (see Link below).  With that
I mind, I can't think of any reason to disallow a 0 => TASK_SIZE memslot so long
as it's KVM-defined.

Using a single memslot would hopefully allow s390 to unconditionally carve out a
KVM-internal memslot, i.e. not have to condition the logic on the type of VM.  E.g.

  #define KVM_INTERNAL_MEM_SLOTS 1

  #define KVM_S390_UCONTROL_MEMSLOT (KVM_USER_MEM_SLOTS + 0)

And then I think just this?

---
From: Sean Christopherson <seanjc@google.com>
Date: Fri, 10 Jan 2025 08:05:09 -0800
Subject: [PATCH] KVM: Do not restrict the size of KVM-internal memory regions

Exempt KVM-internal memslots from the KVM_MEM_MAX_NR_PAGES restriction, as
the limit on the number of pages exists purely to play nice with dirty
bitmap operations, which use 32-bit values to index the bitmaps, and dirty
logging isn't supported for KVM-internal memslots.

Link: https://lore.kernel.org/all/20240802205003.353672-6-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 8a0d0d37fb17..3cea406c34db 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1972,7 +1972,15 @@ int __kvm_set_memory_region(struct kvm *kvm,
 		return -EINVAL;
 	if (mem->guest_phys_addr + mem->memory_size < mem->guest_phys_addr)
 		return -EINVAL;
-	if ((mem->memory_size >> PAGE_SHIFT) > KVM_MEM_MAX_NR_PAGES)
+
+	/*
+	 * The size of userspace-defined memory regions is restricted in order
+	 * to play nice with dirty bitmap operations, which are indexed with an
+	 * "unsigned int".  KVM's internal memory regions don't support dirty
+	 * logging, and so are exempt.
+	 */
+	if (id < KVM_USER_MEM_SLOTS &&
+	    (mem->memory_size >> PAGE_SHIFT) > KVM_MEM_MAX_NR_PAGES)
 		return -EINVAL;
 
 	slots = __kvm_memslots(kvm, as_id);

base-commit: 1aadfba8419606d447d1961f25e2d312011ad45a
-- 
