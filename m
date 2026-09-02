Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C844AA3F3
	for <linux-s390@vger.kernel.org>; Wed,  2 Sep 2026 16:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788365666; cv=none; b=TRWOQKWKgiMiGqqxYu53LI2VHrXDre4z+T7UaiRSwKmahTK+VA2w7TV18HV/TT4EEoN4xRfm4mKYKs71Of25mmyUeuR1m8d95tVEscQk7K75hHsXhuCNzYvnSjq/nIlKSw4y6hTeGgMLplXHHMxbdutLucu9dQE9O/3o88Pk4wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788365666; c=relaxed/simple;
	bh=E885aUWR/1a4ko/wiQKiwg3gRJSzW+4POWNHdH1VQB8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fCU3gbpW2irW9eL71yb99WGHMTX3d5oDKvPvQt+AMJkE7Yv8hn/4e+vLnrYY8AUjdgi9ILlGaQ3wZeJE07I8eNAwJUMNhnfYd36VPjSBSf+3/4aDqGBb05k7w7n1lV+EaTwSAPaeF9177CqVW8pBT2tesvFlETwt8inzSQQeiVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ghz7tfaM; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ghz7tfaM"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-85f1f3620bcso29481b3a.0
        for <linux-s390@vger.kernel.org>; Wed, 02 Sep 2026 09:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788365662; x=1788970462; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y0ov0jpnT3Hdfhq0upQmnF3hbkyRKxEOCtUzSgD0XVs=;
        b=ghz7tfaMsuSsByMHaoAEsvL/aJl5bEwOB3fOFI3bJfefuK+dHhS8SwRXw9TowT3iGi
         jiB8RdWQ60dHm/P4DlEgu7ij0RDjNb8rxZoAYvC1dHoFW7CuKhh0A6G+fKKmLhacmYMP
         OgHkCFmIKgfs9SyKwx4/8ikKAiyFQu55ADKlXykVYORHiiFuadUe8DMYkUGraySIJA6H
         xadojswFc9DjIcBX1aoN4aZltbn0y1w/rzfGSwdBifF+/kIsuzkzjTDZXSwzZbnI/GeB
         vvmW8NRGTMsUwNF6c0Rofj1EtXqb7uJYQRsE/GXv7D+bNDNJQ0faI8icKaawV4q24Epi
         JDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788365662; x=1788970462;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y0ov0jpnT3Hdfhq0upQmnF3hbkyRKxEOCtUzSgD0XVs=;
        b=IHo+1SuvocUzku1yHDcJq7Uc/ge38w5u+Q4vH5p7y6yP/37cespLcSK5KPnYZc3LiO
         W9T2CBAkY/UH1A3Sag0odMuOxN+gaPQZyVHRRaRWnTk4h6hSRdZXQhk3pjxAHnezC3eQ
         nyinX4R657WKkVh1ZkyGrGm9sKt2eEvXmGUg0HdbLUzxQO6pIC1d+3SY6/ir3sJ0nmFu
         FXzASJdEF/K78jVqyp5/2VQzNeKRw45H1bPqowEIYfGzPD1EDiXrpydbDf4++NHNRdKa
         Ao+LhSlp3PWSjDdQd8mo9ojol5fgRCu9C5lfs1Vj1r4XgnTmZhpxQsOZKdeIOYIl8tv0
         Be6w==
X-Forwarded-Encrypted: i=1; AKwUvByRKdsNIHYvSqV+9USr9fY6IAPZGZ38LQt9RhZ0psEbbRNxT51zgE8FpJOnELZ2c6yRp95heWnT0bU6@vger.kernel.org
X-Gm-Message-State: AFuF++kNkNBMx38gk/yiPTbSXbJzaOeLrX/BVCmbGofl0vm/AcPYQYwo
	I+ku7KRIxG0gxUZC9AvthNCUZPXWXLVY+iRs1Du4pJ+WttRwaq927eh4CAJ5y2MznuV6dCJ/VjI
	i/+GKMQ==
X-Received: from pgdu13.prod.google.com ([2002:a05:6a02:2f4d:b0:cc4:32d3:9186])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:517:b0:3d3:aed2:6f22
 with SMTP id adf61e73a8af0-3da216426c3mr267024637.22.1788365662108; Wed, 02
 Sep 2026 09:14:22 -0700 (PDT)
Date: Wed, 2 Sep 2026 09:14:21 -0700
In-Reply-To: <20260902075028.231001-D-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260831144802.834315-1-seiden@linux.ibm.com> <20260831144802.834315-3-seiden@linux.ibm.com>
 <apdweRfqt4dTxcU9@google.com> <20260902075028.231001-D-seiden@linux.ibm.com>
Message-ID: <aphLXQL1H2zYZgTi@google.com>
Subject: Re: [PATCH v7 02/23] KVM: Make device name configurable
From: Sean Christopherson <seanjc@google.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
	Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>, 
	Gautam Gala <ggala@linux.ibm.com>, Hariharan Mari <hari55@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Hendrik Brueckner <brueckner@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Joey Gouly <joey.gouly@arm.com>, Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>, 
	Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>, Oliver Upton <oupton@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 02, 2026, Steffen Eiden wrote:
> On Tue, Sep 01, 2026 at 05:40:25PM -0700, Sean Christopherson wrote:
> > On Mon, Aug 31, 2026, Steffen Eiden wrote:
> > > Allow KVM implementations to choose alternative device names. This is
> > > especially useful for architectures providing multiple KVM
> > > implementations simultaneously. Architectures providing multiple KVM
> > > implementations must compile the KVM common code once per
> > > implementation and mange symbols.
> > 
> > What about tracepoints?  Or do those show up as "kvm" and "kvm-arm64"?
> 
> Yes, I want them to show up as kvm and  kvm-arm64.
> 
> Thanks for pointing that out - I just noticed that I forgot to switch
> the trace system to kvm-arm64 for the common tracepoints in
> trace/events/kvm.h
> I only did it for the arch-local traces in PATCH 21.
> 
> I would just do the following:
> 
> diff --git a/include/trace/events/kvm.h b/include/trace/events/kvm.h
> index b282e3a86769..5d4f8a0693a3 100644
> --- a/include/trace/events/kvm.h
> +++ b/include/trace/events/kvm.h
> @@ -5,7 +5,11 @@
>  #include <linux/tracepoint.h>
> 
>  #undef TRACE_SYSTEM
> +#ifdef KVM_S390_ARM64

Side topic, I recommend choosing a macro name that doesn't have a near-collision
with CONFIG_KVM_S390_ARM64.  This *looks* like a typo, i.e. it looks like you
forgot the CONFIG_ prefix.  Especially since the macro is defined in the Makefile
and won't show up with e.g. "git grep -w KVM_S390_ARM64". E.g. KVM_S390_BUILD_ARM64
or something?

Side topic #2, this entire approach seems extremely brittle unless you make it
all but impossible for non-KVM code to get at KVM structure definitions.  Outside
of KVM, all compilation units will see the s390 version of KVM structures.  Which
is "fine", but obviously dangerous and IMO asking for maintenance issues down the
road.

> +#define TRACE_SYSTEM kvm-arm64
> +#else
>  #define TRACE_SYSTEM kvm
> +#endif /* KVM_S390_ARM64 */
> 
>  #define ERSN(x) { KVM_EXIT_##x, "KVM_EXIT_" #x }
> 
> 
> This would leak a bit of arm on s390 into common KVM but I do not see
> another way.

Morpheus: Stop trying to use macros, and use macros!

The most annoying thing is that macro shenanigans don't play well with hyphens,
but that can be handled either by using a different macro for the trace name, or
by creating /dev/kvm_arm64 instead of /dev/kvm-arm64.  My vote would be to have
the device be /dev/kvm_arm64, assuming that doesn't cause problems elsewhere.

And taking things a few steps further, we can solve the MMIO issue in a more
elegant way, and eliminate the runtime string building in this patch (after looking
more closely, that code needs to be jettisoned no matter what, there's simply no
reason to specify the names at runtime since they're separate compilation units).

Rather than splatter #defines throughout header files, deal with the bulk of the
pain in Makefile.kvm.  By feeding conditionals into Makefile.kvm, the s390+arm64
build can easily omit coalesced_mmio.o and async_pf.o, define __KVM_HAVE_ARCH_MMIO
programatically without having to change other architectures, and solve the naming
stuff.

Full diff relative to this series at the bottom.  Compile tested only (all
architectures, though I certainly didn't get every combination of PPC insanity).
Oh, and I also created an empty include/trace/events/kvm_arm64.h.

virt/kvm/Makefile.kvm

  KVM ?= ../../../virt/kvm
  
  KVM_WANT_MMIO ?= $(CONFIG_KVM_MMIO)
  KVM_WANT_ASYNC_PF ?= $(CONFIG_KVM_ASYNC_PF)
  
  KVM_DEV_NAME ?= kvm
  KVM_DEV_MINOR ?= KVM_MINOR
  
  ccflags-y += -DKVM_DEV_NAME=$(KVM_DEV_NAME) -DKVM_DEV_MINOR=$(KVM_DEV_MINOR)
  
  kvm-y := $(KVM)/kvm_main.o $(KVM)/eventfd.o $(KVM)/binary_stats.o
  kvm-$(CONFIG_KVM_VFIO) += $(KVM)/vfio.o
  ifeq ($(KVM_WANT_MMIO),y)
  ccflags-y += -D__KVM_HAVE_ARCH_MMIO
  kvm-$(CONFIG_KVM_MMIO) += $(KVM)/coalesced_mmio.o
  endif
  ifeq ($(KVM_WANT_ASYNC_PF),y)
  kvm-$(CONFIG_KVM_ASYNC_PF) += $(KVM)/async_pf.o
  endif
  kvm-$(CONFIG_HAVE_KVM_IRQ_ROUTING) += $(KVM)/irqchip.o
  kvm-$(CONFIG_HAVE_KVM_DIRTY_RING) += $(KVM)/dirty_ring.o
  kvm-$(CONFIG_HAVE_KVM_PFNCACHE) += $(KVM)/pfncache.o
  kvm-$(CONFIG_KVM_GUEST_MEMFD) += $(KVM)/guest_memfd.o


arch/s390/kvm/s390/Makefile:

  KVM := ../../../../virt/kvm
  KVM_WANT_MMIO := n
  include $(srctree)/virt/kvm/Makefile.kvm
  include $(srctree)/arch/s390/kvm/gmap/Makefile
  
  ccflags-y += -I$(src) -I$(srctree)/arch/s390/kvm/gmap
  
  kvm-y += s390.o intercept.o interrupt.o priv.o sigp.o
  kvm-y += diag.o gaccess.o guestdbg.o vsie.o pv.o
  kvm-y += $(gmap-y)
  
  kvm-$(CONFIG_VFIO_PCI_ZDEV_KVM) += pci.o
  obj-$(CONFIG_KVM) += kvm.o

arch/s390/kvm/arm64/Makefile (partial):

  KVM := ../../../../virt/kvm
  KVM_WANT_ASYNC_PF := n
  KVM_DEV_NAME := kvm_arm64
  KVM_DEV_MINOR := MISC_DYNAMIC_MINOR
  
  include $(srctree)/virt/kvm/Makefile.kvm
  include $(srctree)/arch/s390/kvm/gmap/Makefile
  include $(src)/Makefile.gen
  
  ccflags-y += -I $(src) -I $(objtree)/$(obj) -I$(srctree)/arch/s390/kvm/gmap -DKVM_S390_BUILD_ARM64

And the full diff (it's big because I literally reverted this patch):

diff --git a/arch/s390/include/asm/kvm.h b/arch/s390/include/asm/kvm.h
index aeb11dc631d5..ae9b7509a3c1 100644
--- a/arch/s390/include/asm/kvm.h
+++ b/arch/s390/include/asm/kvm.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifdef KVM_S390_ARM64
+#ifdef KVM_S390_BUILD_ARM64
 #include <uapi/arm64/kvm.h>
 #else
 #include <uapi/asm/kvm.h>
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index cd6d572883ab..2206c5791373 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -3,7 +3,7 @@
 #ifndef ASM_KVM_HOST_H
 #define ASM_KVM_HOST_H
 
-#ifdef KVM_S390_ARM64
+#ifdef KVM_S390_BUILD_ARM64
 #include <asm/kvm_host_arm64.h>
 #else
 #include <asm/kvm_host_s390.h>
diff --git a/arch/s390/include/asm/kvm_host_s390.h b/arch/s390/include/asm/kvm_host_s390.h
index 207f44cb86d9..cd692f8fb764 100644
--- a/arch/s390/include/asm/kvm_host_s390.h
+++ b/arch/s390/include/asm/kvm_host_s390.h
@@ -29,7 +29,6 @@
 
 #define KVM_HAVE_MMU_RWLOCK
 #define KVM_MAX_VCPUS 255
-#define KVM_NO_MMIO
 
 #define KVM_INTERNAL_MEM_SLOTS 1
 
diff --git a/arch/s390/include/asm/kvm_host_types.h b/arch/s390/include/asm/kvm_host_types.h
index d308739ebcf5..39da4ac5407c 100644
--- a/arch/s390/include/asm/kvm_host_types.h
+++ b/arch/s390/include/asm/kvm_host_types.h
@@ -3,10 +3,10 @@
 #ifndef ASM_KVM_HOST_TYPES_H
 #define ASM_KVM_HOST_TYPES_H
 
-#ifdef KVM_S390_ARM64
+#ifdef KVM_S390_BUILD_ARM64
 #include <asm/kvm_host_arm64_types.h>
 #else
 #include <asm/kvm_host_s390_types.h>
-#endif /* KVM_S390_ARM64 */
+#endif /* KVM_S390_BUILD_ARM64 */
 
 #endif /* ASM_KVM_HOST_TYPES_H */
diff --git a/arch/s390/kvm/arm64/Makefile b/arch/s390/kvm/arm64/Makefile
index ae614a62f7b5..1d744d4dfc06 100644
--- a/arch/s390/kvm/arm64/Makefile
+++ b/arch/s390/kvm/arm64/Makefile
@@ -1,11 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0
 
 KVM := ../../../../virt/kvm
+KVM_WANT_ASYNC_PF := n
+KVM_DEV_NAME := kvm_arm64
+KVM_DEV_MINOR := MISC_DYNAMIC_MINOR
+
 include $(srctree)/virt/kvm/Makefile.kvm
 include $(srctree)/arch/s390/kvm/gmap/Makefile
 include $(src)/Makefile.gen
 
-ccflags-y += -I $(src) -I $(objtree)/$(obj) -I$(srctree)/arch/s390/kvm/gmap -DKVM_S390_ARM64
+ccflags-y += -I $(src) -I $(objtree)/$(obj) -I$(srctree)/arch/s390/kvm/gmap -DKVM_S390_BUILD_ARM64
 
 kvm-arm64-obj := \
 	arm.o \
diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
index 3caa72f780a5..7cf62fa7b77b 100644
--- a/arch/s390/kvm/arm64/arm.c
+++ b/arch/s390/kvm/arm64/arm.c
@@ -745,8 +745,7 @@ static int __init kvm_s390_arm64_init(void)
 	if (!sclp.has_aef)
 		return -ENXIO;
 
-	return kvm_init_with_dev(sizeof(struct kvm_vcpu), 0, THIS_MODULE,
-				 KVM_DEV_NAME, MISC_DYNAMIC_MINOR);
+	return kvm_init(sizeof(struct kvm_vcpu), 0, THIS_MODULE);
 }
 
 static __exit void kvm_s390_arm64_exit(void)
diff --git a/arch/s390/kvm/arm64/arm.h b/arch/s390/kvm/arm64/arm.h
index 093a638e2cf9..e176bf403850 100644
--- a/arch/s390/kvm/arm64/arm.h
+++ b/arch/s390/kvm/arm64/arm.h
@@ -5,18 +5,17 @@
 #include <linux/compiler_attributes.h>
 #include <linux/kvm_host.h>
 
-#define KVM_DEV_NAME "kvm-arm64"
+#define VM_EVENT(d_kvm, d_loglevel, d_string, d_args...)	\
+	debug_sprintf_event((d_kvm)->arch.dbf, d_loglevel,	\
+			    __stringify(KVM_DEV_NAME) ": " d_string "\n", d_args)
 
-#define VM_EVENT(d_kvm, d_loglevel, d_string, d_args...) \
-	debug_sprintf_event((d_kvm)->arch.dbf, d_loglevel, KVM_DEV_NAME ": " d_string "\n", d_args)
-
-#define VCPU_EVENT(d_vcpu, d_loglevel, d_string, d_args...)			\
-	do {									\
-		debug_sprintf_event(						\
-			(d_vcpu)->kvm->arch.dbf, d_loglevel,			\
-			KVM_DEV_NAME " %02d[%016llx-%016llx]: " d_string "\n",	\
-			(d_vcpu)->vcpu_id, (d_vcpu)->arch.sae_block.pstate,	\
-			(d_vcpu)->arch.sae_block.pc, d_args);			\
+#define VCPU_EVENT(d_vcpu, d_loglevel, d_string, d_args...)					\
+	do {											\
+		debug_sprintf_event(								\
+			(d_vcpu)->kvm->arch.dbf, d_loglevel,					\
+			__stringify(KVM_DEV_NAME) " %02d[%016llx-%016llx]: " d_string "\n",	\
+			(d_vcpu)->vcpu_id, (d_vcpu)->arch.sae_block.pstate,			\
+			(d_vcpu)->arch.sae_block.pc, d_args);					\
 	} while (0)
 
 static __always_inline int kvm_is_ucontrol(struct kvm *kvm)
diff --git a/arch/s390/kvm/gmap/faultin.c b/arch/s390/kvm/gmap/faultin.c
index 2e93bd563d5c..f2d3779db2d4 100644
--- a/arch/s390/kvm/gmap/faultin.c
+++ b/arch/s390/kvm/gmap/faultin.c
@@ -10,7 +10,7 @@
 
 #include "gmap.h"
 #include "faultin.h"
-#ifdef KVM_S390_ARM64
+#ifdef KVM_S390_BUILD_ARM64
 #include "arm.h"
 #else
 #include "s390.h"
diff --git a/arch/s390/kvm/gmap/gmap.c b/arch/s390/kvm/gmap/gmap.c
index b7071f50f7ad..a75275be542e 100644
--- a/arch/s390/kvm/gmap/gmap.c
+++ b/arch/s390/kvm/gmap/gmap.c
@@ -21,7 +21,7 @@
 
 #include "dat.h"
 #include "gmap.h"
-#ifdef KVM_S390_ARM64
+#ifdef KVM_S390_BUILD_ARM64
 #include "arm.h"
 #else
 #include "s390.h"
diff --git a/arch/s390/kvm/gmap/kvm_mmu.c b/arch/s390/kvm/gmap/kvm_mmu.c
index a26a16193467..5536ae279aad 100644
--- a/arch/s390/kvm/gmap/kvm_mmu.c
+++ b/arch/s390/kvm/gmap/kvm_mmu.c
@@ -3,7 +3,7 @@
 #include <linux/kvm_types.h>
 #include <linux/kvm_host.h>
 
-#ifdef KVM_S390_ARM64
+#ifdef KVM_S390_BUILD_ARM64
 #include "arm.h"
 #else
 #include "s390.h"
diff --git a/arch/s390/kvm/gmap/trace_gmap.h b/arch/s390/kvm/gmap/trace_gmap.h
index 431c9442b10c..6ac0d4961b96 100644
--- a/arch/s390/kvm/gmap/trace_gmap.h
+++ b/arch/s390/kvm/gmap/trace_gmap.h
@@ -4,18 +4,16 @@
 
 #include <linux/tracepoint.h>
 
+#undef UNPACK_KVM
+#define UNPACK_KVM(name) name
 #undef TRACE_SYSTEM
-#ifdef KVM_S390_ARM64
-#define TRACE_SYSTEM kvm_arm64
-#else
-#define TRACE_SYSTEM kvm
-#endif
+#define TRACE_SYSTEM UNPACK_KVM(KVM_DEV_NAME)
 #undef TRACE_INCLUDE_PATH
 #define TRACE_INCLUDE_PATH ../gmap
 #undef TRACE_INCLUDE_FILE
 #define TRACE_INCLUDE_FILE trace_gmap
 
-#ifdef KVM_S390_ARM64
+#ifdef KVM_S390_BUILD_ARM64
 #define __KVM_FIELDS \
 	__field(unsigned long, pstate) \
 	__field(unsigned long, pc)
diff --git a/arch/s390/kvm/s390/Makefile b/arch/s390/kvm/s390/Makefile
index 762a63826423..56495321dbe8 100644
--- a/arch/s390/kvm/s390/Makefile
+++ b/arch/s390/kvm/s390/Makefile
@@ -1,10 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
 
 KVM := ../../../../virt/kvm
+KVM_WANT_MMIO := n
 include $(srctree)/virt/kvm/Makefile.kvm
 include $(srctree)/arch/s390/kvm/gmap/Makefile
 
-ccflags-y := -I$(src) -I$(srctree)/arch/s390/kvm/gmap
+ccflags-y += -I$(src) -I$(srctree)/arch/s390/kvm/gmap
 
 kvm-y += s390.o intercept.o interrupt.o priv.o sigp.o
 kvm-y += diag.o gaccess.o guestdbg.o vsie.o pv.o
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index ec294e419762..be76b79a1e26 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -45,6 +45,8 @@
 #include <asm/kvm_host.h>
 #include <linux/kvm_dirty_ring.h>
 
+#define KVM_DEV_STRING(x) __stringify(KVM_DEV_NAME ## _ ## x)
+
 #ifndef KVM_MAX_VCPU_IDS
 #define KVM_MAX_VCPU_IDS KVM_MAX_VCPUS
 #endif
@@ -1082,9 +1084,7 @@ static inline void kvm_irqfd_exit(void)
 {
 }
 #endif
-int kvm_init(unsigned int vcpu_size, unsigned int vcpu_align, struct module *module);
-int kvm_init_with_dev(unsigned int vcpu_size, unsigned int vcpu_align,
-		      struct module *module, const char *dev_name, int minor);
+int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module);
 void kvm_exit(void);
 
 void kvm_get_kvm(struct kvm *kvm);
diff --git a/include/trace/events/kvm.h b/include/trace/events/kvm.h
index b282e3a86769..23792ba49e83 100644
--- a/include/trace/events/kvm.h
+++ b/include/trace/events/kvm.h
@@ -4,8 +4,10 @@
 
 #include <linux/tracepoint.h>
 
+#undef UNPACK_KVM
+#define UNPACK_KVM(name) name
 #undef TRACE_SYSTEM
-#define TRACE_SYSTEM kvm
+#define TRACE_SYSTEM UNPACK_KVM(KVM_DEV_NAME)
 
 #define ERSN(x) { KVM_EXIT_##x, "KVM_EXIT_" #x }
 
diff --git a/virt/kvm/Makefile.kvm b/virt/kvm/Makefile.kvm
index d047d4cf58c9..2b64e6745d79 100644
--- a/virt/kvm/Makefile.kvm
+++ b/virt/kvm/Makefile.kvm
@@ -5,10 +5,23 @@
 
 KVM ?= ../../../virt/kvm
 
+KVM_WANT_MMIO ?= $(CONFIG_KVM_MMIO)
+KVM_WANT_ASYNC_PF ?= $(CONFIG_KVM_ASYNC_PF)
+
+KVM_DEV_NAME ?= kvm
+KVM_DEV_MINOR ?= KVM_MINOR
+
+ccflags-y += -DKVM_DEV_NAME=$(KVM_DEV_NAME) -DKVM_DEV_MINOR=$(KVM_DEV_MINOR)
+
 kvm-y := $(KVM)/kvm_main.o $(KVM)/eventfd.o $(KVM)/binary_stats.o
 kvm-$(CONFIG_KVM_VFIO) += $(KVM)/vfio.o
+ifeq ($(KVM_WANT_MMIO),y)
+ccflags-y += -D__KVM_HAVE_ARCH_MMIO
 kvm-$(CONFIG_KVM_MMIO) += $(KVM)/coalesced_mmio.o
+endif
+ifeq ($(KVM_WANT_ASYNC_PF),y)
 kvm-$(CONFIG_KVM_ASYNC_PF) += $(KVM)/async_pf.o
+endif
 kvm-$(CONFIG_HAVE_KVM_IRQ_ROUTING) += $(KVM)/irqchip.o
 kvm-$(CONFIG_HAVE_KVM_DIRTY_RING) += $(KVM)/dirty_ring.o
 kvm-$(CONFIG_HAVE_KVM_PFNCACHE) += $(KVM)/pfncache.o
diff --git a/virt/kvm/async_pf.c b/virt/kvm/async_pf.c
index 015761249107..de2d086d816f 100644
--- a/virt/kvm/async_pf.c
+++ b/virt/kvm/async_pf.c
@@ -19,19 +19,11 @@
 
 static struct kmem_cache *async_pf_cache;
 
-int kvm_async_pf_init(const char *cache_name)
+int kvm_async_pf_init(void)
 {
-	char *full_cache_name;
-
-	full_cache_name = kasprintf(GFP_KERNEL, "%s_async_pf", cache_name);
-	if (!full_cache_name)
-		return -ENOMEM;
-
-	async_pf_cache = kmem_cache_create(full_cache_name,
+	async_pf_cache = kmem_cache_create(KVM_DEV_STRING(async_pf),
 					   sizeof(struct kvm_async_pf), 0,
 					   SLAB_ACCOUNT, NULL);
-	kfree(full_cache_name);
-
 	if (!async_pf_cache)
 		return -ENOMEM;
 
diff --git a/virt/kvm/async_pf.h b/virt/kvm/async_pf.h
index 4a7b81743248..90d1a7d8c6de 100644
--- a/virt/kvm/async_pf.h
+++ b/virt/kvm/async_pf.h
@@ -12,11 +12,11 @@
 #define __KVM_ASYNC_PF_H__
 
 #ifdef CONFIG_KVM_ASYNC_PF
-int kvm_async_pf_init(const char *cache_name);
+int kvm_async_pf_init(void);
 void kvm_async_pf_deinit(void);
 void kvm_async_pf_vcpu_init(struct kvm_vcpu *vcpu);
 #else
-#define kvm_async_pf_init(_name) (0)
+#define kvm_async_pf_init() (0)
 #define kvm_async_pf_deinit() do {} while (0)
 #define kvm_async_pf_vcpu_init(C) do {} while (0)
 #endif
diff --git a/virt/kvm/coalesced_mmio.c b/virt/kvm/coalesced_mmio.c
index 8ff9d9a6f47a..6b1d90161099 100644
--- a/virt/kvm/coalesced_mmio.c
+++ b/virt/kvm/coalesced_mmio.c
@@ -15,8 +15,6 @@
 #include <linux/slab.h>
 #include <linux/kvm.h>
 
-#ifndef KVM_NO_MMIO
-
 #include "coalesced_mmio.h"
 
 static inline struct kvm_coalesced_mmio_dev *to_mmio(struct kvm_io_device *dev)
@@ -190,5 +188,3 @@ int kvm_vm_ioctl_unregister_coalesced_mmio(struct kvm *kvm,
 	 */
 	return 0;
 }
-
-#endif /* ifndef KVM_NO_MMIO */
diff --git a/virt/kvm/coalesced_mmio.h b/virt/kvm/coalesced_mmio.h
index 826af421a5be..b7ff8b009412 100644
--- a/virt/kvm/coalesced_mmio.h
+++ b/virt/kvm/coalesced_mmio.h
@@ -11,7 +11,7 @@
  *
  */
 
-#if defined(CONFIG_KVM_MMIO) && !defined(KVM_NO_MMIO)
+#ifdef __KVM_HAVE_ARCH_MMIO
 
 #include <linux/list.h>
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 7f37d3b5af48..85985663a4a5 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4061,7 +4061,7 @@ static vm_fault_t kvm_vcpu_fault(struct vm_fault *vmf)
 	else if (vmf->pgoff == KVM_PIO_PAGE_OFFSET)
 		page = virt_to_page(vcpu->arch.pio_data);
 #endif
-#if defined(CONFIG_KVM_MMIO) && !defined(KVM_NO_MMIO)
+#ifdef __KVM_HAVE_ARCH_MMIO
 	else if (vmf->pgoff == KVM_COALESCED_MMIO_PAGE_OFFSET)
 		page = virt_to_page(vcpu->kvm->coalesced_mmio_ring);
 #endif
@@ -4902,7 +4902,7 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 	case KVM_CAP_ENABLE_CAP_VM:
 	case KVM_CAP_HALT_POLL:
 		return 1;
-#if defined(CONFIG_KVM_MMIO) && !defined(KVM_NO_MMIO)
+#ifdef __KVM_HAVE_ARCH_MMIO
 	case KVM_CAP_COALESCED_MMIO:
 		return KVM_COALESCED_MMIO_PAGE_OFFSET;
 	case KVM_CAP_COALESCED_PIO:
@@ -5243,7 +5243,7 @@ static long kvm_vm_ioctl(struct file *filp,
 		break;
 	}
 #endif
-#if defined(CONFIG_KVM_MMIO) && !defined(KVM_NO_MMIO)
+#ifdef __KVM_HAVE_ARCH_MMIO
 	case KVM_REGISTER_COALESCED_MMIO: {
 		struct kvm_coalesced_mmio_zone zone;
 
@@ -5577,7 +5577,7 @@ static long kvm_dev_ioctl(struct file *filp,
 #ifdef CONFIG_X86
 		r += PAGE_SIZE;    /* pio data page */
 #endif
-#if defined(CONFIG_KVM_MMIO) && !defined(KVM_NO_MMIO)
+#ifdef __KVM_HAVE_ARCH_MMIO
 		r += PAGE_SIZE;    /* coalesced mmio ring page */
 #endif
 		break;
@@ -5595,7 +5595,9 @@ static struct file_operations kvm_chardev_ops = {
 };
 
 static struct miscdevice kvm_dev = {
-	.fops = &kvm_chardev_ops,
+	KVM_DEV_MINOR,
+	__stringify(KVM_DEV_NAME),
+	&kvm_chardev_ops,
 };
 
 #ifdef CONFIG_KVM_GENERIC_HARDWARE_ENABLING
@@ -6367,13 +6369,13 @@ static void kvm_uevent_notify_change(unsigned int type, struct kvm *kvm)
 	kfree(env);
 }
 
-static void kvm_init_debug(const char *dev_name)
+static void kvm_init_debug(void)
 {
 	const struct file_operations *fops;
 	const struct kvm_stats_desc *pdesc;
 	int i;
 
-	kvm_debugfs_dir = debugfs_create_dir(dev_name, NULL);
+	kvm_debugfs_dir = debugfs_create_dir("kvm", NULL);
 
 	for (i = 0; i < kvm_vm_stats_header.num_desc; ++i) {
 		pdesc = &kvm_vm_stats_desc[i];
@@ -6509,42 +6511,23 @@ void kvm_unregister_perf_callbacks(void)
 }
 #endif
 
-int kvm_init(unsigned int vcpu_size, unsigned int vcpu_align, struct module *module)
+int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 {
-	return kvm_init_with_dev(vcpu_size, vcpu_align, module, "kvm", KVM_MINOR);
-}
-
-int kvm_init_with_dev(unsigned int vcpu_size, unsigned int vcpu_align,
-		      struct module *module, const char *dev_name, int minor)
-{
-	char *cache_name;
 	int r;
 	int cpu;
 
-	kvm_dev.minor = minor;
-	kvm_dev.name = kstrdup_const(dev_name, GFP_KERNEL);
-	if (!kvm_dev.name)
-		return -ENOMEM;
-
 	/* A kmem cache lets us meet the alignment requirements of fx_save. */
 	if (!vcpu_align)
 		vcpu_align = __alignof__(struct kvm_vcpu);
-
-	r = -ENOMEM;
-	cache_name = kasprintf(GFP_KERNEL, "%s_vcpu", dev_name);
-	if (!cache_name)
-		goto err_dev_name;
 	kvm_vcpu_cache =
-		kmem_cache_create_usercopy(cache_name, vcpu_size, vcpu_align,
-					   SLAB_ACCOUNT,
+		kmem_cache_create_usercopy(KVM_DEV_STRING(vcpu),
+					   vcpu_size, vcpu_align, SLAB_ACCOUNT,
 					   offsetof(struct kvm_vcpu, arch),
 					   offsetofend(struct kvm_vcpu, stats_id)
 					   - offsetof(struct kvm_vcpu, arch),
 					   NULL);
-	kfree(cache_name);
-
 	if (!kvm_vcpu_cache)
-		goto err_dev_name;
+		return -ENOMEM;
 
 	for_each_possible_cpu(cpu) {
 		if (!alloc_cpumask_var_node(&per_cpu(cpu_kick_mask, cpu),
@@ -6558,7 +6541,7 @@ int kvm_init_with_dev(unsigned int vcpu_size, unsigned int vcpu_align,
 	if (r)
 		goto err_irqfd;
 
-	r = kvm_async_pf_init(dev_name);
+	r = kvm_async_pf_init();
 	if (r)
 		goto err_async_pf;
 
@@ -6570,7 +6553,7 @@ int kvm_init_with_dev(unsigned int vcpu_size, unsigned int vcpu_align,
 	kvm_preempt_ops.sched_in = kvm_sched_in;
 	kvm_preempt_ops.sched_out = kvm_sched_out;
 
-	kvm_init_debug(kvm_dev.name);
+	kvm_init_debug();
 
 	r = kvm_vfio_ops_init();
 	if (WARN_ON_ONCE(r))
@@ -6612,8 +6595,6 @@ int kvm_init_with_dev(unsigned int vcpu_size, unsigned int vcpu_align,
 	for_each_possible_cpu(cpu)
 		free_cpumask_var(per_cpu(cpu_kick_mask, cpu));
 	kmem_cache_destroy(kvm_vcpu_cache);
-err_dev_name:
-	kfree_const(kvm_dev.name);
 	return r;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_init);
@@ -6639,8 +6620,5 @@ void kvm_exit(void)
 	kvm_vfio_ops_exit();
 	kvm_async_pf_deinit();
 	kvm_irqfd_exit();
-
-	kfree_const(kvm_dev.name);
-	kvm_dev.name = NULL;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_exit);

