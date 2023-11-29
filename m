Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M95ovZ7T"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546A11735
	for <linux-s390@vger.kernel.org>; Tue, 28 Nov 2023 18:21:45 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5cb92becbf6so92867877b3.2
        for <linux-s390@vger.kernel.org>; Tue, 28 Nov 2023 18:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701224504; x=1701829304; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mJUgPg47d4/pgx8Qlc5dU8QTKw0KSk/PtK3yQegaG7g=;
        b=M95ovZ7TNLzmq+j5+IX1g1ZfHxFQKjk+ewHZaDL1W5UFtAYOvqRozjKJwR1/lbE7cH
         /WsodU+DtntTZUjSlxODDW1U9Yd/UuaGhJuIeYv3uSj1g6vlBao9kPqOuglriCwBokWA
         e3fat/T/JnqmxevNvygyBZ+Opd7JjnE7KWmKhDpRdtxDTzP4b3q5Zf1MhHUgMr3ka+8o
         vgLKhQ23JKbx6pnrvylqW8cVBdIafqJgC0e5ZFoFMgcIuruyKbnjyLiplxH6CitnCi/H
         DbrEuCy4xSbkLrVm1NUT1cuBifLfJ5K4laDHd+i8qHkO4M0Hl+gdUoNuGrg/PwggEB8E
         nteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701224504; x=1701829304;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mJUgPg47d4/pgx8Qlc5dU8QTKw0KSk/PtK3yQegaG7g=;
        b=fZ44eHkmkqlHBUrYWK1iowmeoQ7eH5ODaqShsNOLYNmD5kJrD0cGggE5zuGCo9SzXC
         zLRBzS6HTMnzd36to80OAonc8qtXTtHr3AiIVZCW8HC2eBOH9SrOiAv+bvzQZZU3rti6
         BI8fJWSVnPbQ0VMR1uKkqzh0V6jvg4OAA2sfMKlUDsii+BNjeYk7qrWvSwqfkd42Mg+V
         +GwgPABOGrDR1ewBOSWDhOaowclT+yvm2z0fnZh407ADrLdU4kaIc3tKV2yO62Dl4NGq
         672vTuxPNr00MFX7Lzkxw9yGGlIOv9uMOnv45vyKtBO3k0NHDWowdHCB8Kuoitc6l6Me
         tYZA==
X-Gm-Message-State: AOJu0YyAu40JQH9wKx92UFW0Mc4pAsr5uT51lic4lUH1s1dQtEMS0kP9
	scM54peK2t0IJNTIuOQGisBVOIRum1E=
X-Google-Smtp-Source: AGHT+IEzvdnB4YF3ag5ypaUivwQ+a/1gSiOiue26Vf+Kzl2dkVc1+0BYVi7jXds4GjyyxEfKmNI6Cd+a9DA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:ff05:0:b0:5cd:c47d:d89a with SMTP id
 k5-20020a81ff05000000b005cdc47dd89amr593254ywn.2.1701224504362; Tue, 28 Nov
 2023 18:21:44 -0800 (PST)
Date: Tue, 28 Nov 2023 18:21:42 -0800
In-Reply-To: <87edgy87ig.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <0-v1-08396538817d+13c5-vfio_kvm_kconfig_jgg@nvidia.com> <87edgy87ig.fsf@mail.lhotse>
Message-ID: <ZWagNsu1XQIqk5z9@google.com>
Subject: Re: Ping? Re: [PATCH rc] kvm: Prevent compiling virt/kvm/vfio.c
 unless VFIO is selected
From: Sean Christopherson <seanjc@google.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, James Morse <james.morse@arm.com>, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, 
	x86@kernel.org, Zenghui Yu <yuzenghui@huawei.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Nov 10, 2023, Michael Ellerman wrote:
> Jason Gunthorpe <jgg@nvidia.com> writes:
> > There are a bunch of reported randconfig failures now because of this,
> > something like:
> >
> >>> arch/powerpc/kvm/../../../virt/kvm/vfio.c:89:7: warning: attribute declaration must precede definition [-Wignored-attributes]
> >            fn = symbol_get(vfio_file_iommu_group);
> >                 ^
> >    include/linux/module.h:805:60: note: expanded from macro 'symbol_get'
> >    #define symbol_get(x) ({ extern typeof(x) x __attribute__((weak,visibility("hidden"))); &(x); })
> >
> > It happens because the arch forces KVM_VFIO without knowing if VFIO is
> > even enabled.
> 
> This is still breaking some builds. Can we get this fix in please?
> 
> cheers
> 
> > Split the kconfig so the arch selects the usual HAVE_KVM_ARCH_VFIO and
> > then KVM_VFIO is only enabled if the arch wants it and VFIO is turned on.

Heh, so I was trying to figure out why things like vfio_file_set_kvm() aren't
problematic, i.e. why the existing mess didn't cause failures.  I can't repro the
warning (requires clang-16?), but IIUC the reason only the group code is problematic
is that vfio.h creates a stub for vfio_file_iommu_group() and thus there's no symbol,
whereas vfio.h declares vfio_file_set_kvm() unconditionally.

Because KVM is doing symbol_get() and not taking a direct dependency, the lack of
an exported symbol doesn't cause problems, i.e. simply declaring the symbol makes
the compiler happy.

Given that the vfio_file_iommu_group() stub shouldn't exist (KVM is the only user,
and so if I'm correct the stub is worthless), what about this as a temporary "fix"?

I'm 100% on-board with fixing KVM properly, my motivation is purely to minimize
the total amount of churn.  E.g. if this works, then the only extra churn is to
move the declaration of vfio_file_iommu_group() back under the #if, versus having
to churn all of the KVM Kconfigs twice (once now, and again for the full cleanup).

diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 454e9295970c..a65b2513f8cd 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -289,16 +289,12 @@ void vfio_combine_iova_ranges(struct rb_root_cached *root, u32 cur_nodes,
 /*
  * External user API
  */
-#if IS_ENABLED(CONFIG_VFIO_GROUP)
 struct iommu_group *vfio_file_iommu_group(struct file *file);
+
+#if IS_ENABLED(CONFIG_VFIO_GROUP)
 bool vfio_file_is_group(struct file *file);
 bool vfio_file_has_dev(struct file *file, struct vfio_device *device);
 #else
-static inline struct iommu_group *vfio_file_iommu_group(struct file *file)
-{
-       return NULL;
-}
-
 static inline bool vfio_file_is_group(struct file *file)
 {
        return false;

