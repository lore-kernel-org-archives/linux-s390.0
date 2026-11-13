Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794571273;
	b=IdDG735Vpq3rxJG4XTVwudbzDogi4zdkBISq93wqLpg6QXJwYoVGyyyxHXqaYN4z6G+k
	 Am+hC1uwMz6ZGbNMQdDKcRcWPuQnw1xZOfXEfR5UdU/mreu2OFKy638Bk6IVcZOMEm7DV
	 JLzp8SbuMOG42iVdUlWUXZVQLXnMIvAeuto3D3a++MvSFDIDfwiTQgArWr+TSSXVfxfOx
	 h79MEOsRhsn7zUzzrY3ETgOT/b9nT4dQSKtrMdRwITQ1QqSmqnsF4aNy64OQXOgYpfB9k
	 sEKWZeSuUEKkOyPgxI0kyugEmbVJXZ9QLmqRZdjIBDF2ynn/jXHz9kX2ZCxNpFUCWiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794571273;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Transfer-Encoding:X-Scanned-By;
	bh=QuDGTGEuVvl3MPiP6Lxh0kED44wnv1RS4KyW/3v5QR0=;
	b=4/YsF4M5MxCnPO+wELFrAU0l+B+THfUc8/RCxfIGOKcoYZ3gmMkTbSPU21/9HIzWkO4r
	 COr0c+TSjzcLwADwvFezlb/BlKGLViG/I2TwRifvXpgNB8pbzee3NSXuv+neCImFHTuPV
	 K4TyVr62EGJBfKMdconaxpw72hpGScfSy6/c2uuR1imbGfl9wGGDXv7dSk2s9YowH7fNK
	 sp22hIO2ZfrqD81GfIZ5JFvqd97mKRqb6xGwJWsl4mvc6uAJ+zc5WXJ6hgMepb0eLtKqY
	 NhGXJpbJxMdEjptKL5G3ru8pzI34rEuOy2uLiqs1bPcg/j3vnUIgrqtnynH+EaKiPNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H3gcFsb3;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93E060A6F6D
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 12:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E93E060A6F6D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H3gcFsb3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794571271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QuDGTGEuVvl3MPiP6Lxh0kED44wnv1RS4KyW/3v5QR0=;
	b=H3gcFsb3l7KBSA77Cv13pBq7TyAhwAXhhU/J4SU8I1ZAG5/40qZEf3uBaaFTfBwdmgU4/d
	1Um8vMGy2Fjpu3aki3kVMdmmKXCX0Oq/uXmclfwfw/kIM0onMYF4yMsWTU7lVnP9ciE/fh
	H5AEhTj0jVZ+S8oJi0N0xbHa0g+Ctjo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-A7ZsTMK1NMyLP5Xu2r78Mg-1; Fri,
 13 Nov 2026 07:01:10 -0500
X-MC-Unique: A7ZsTMK1NMyLP5Xu2r78Mg-1
X-Mimecast-MFC-AGG-ID: A7ZsTMK1NMyLP5Xu2r78Mg_1794571268
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4329E1800607;
	Fri, 13 Nov 2026 12:01:07 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.21])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B092418004FC;
	Fri, 13 Nov 2026 12:01:02 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Andrew Jones <andrew.jones@linux.dev>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Cc: Laurent Vivier <lvivier@redhat.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	=?UTF-8?q?Nico=20B=C3=B6hr?= <nrb@linux.ibm.com>,
	Chinmay Rath <rathc@linux.ibm.com>,
	kvmarm@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	kvm-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: [kvm-unit-tests PATCH] Move position-independant code flags into the target specific Makefiles
Date: Fri, 13 Nov 2026 13:01:01 +0100
Message-ID: <20261113120101.145183-1-thuth@redhat.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The settings for position-independant code are currently quite a mess:
It depends on the target whether we need the flags or rather should even
disable PIC / PIE, but currently the settings are spread between the
main Makefile (-fno-pic is the default, unless CONFIG_EFI has been set)
and the target specific Makefiles.
This leads to some weird situations where we have -fno-pic in the CFLAGS,
but link with -pie in the LDFLAGS since we still want to get a relocation
table, but then again need to add a "-z notext" to the linker flags to
avoid warnings about relocation entries in the text segment.
Let's face it: Always adding -fno-pic / -no-pie in the main Makefile is
a bad idea. Move the settings to the target specific Makefiles instead
where we know what we really want, and then we can finally drop the
"-z notext" settings, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Makefile            | 6 +-----
 arm/Makefile.arm    | 2 ++
 arm/Makefile.arm64  | 3 +--
 powerpc/Makefile    | 5 ++++-
 riscv/Makefile      | 1 +
 s390x/Makefile      | 3 +++
 x86/Makefile.common | 5 +++++
 7 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 8e002043..b0a0b89f 100644
--- a/Makefile
+++ b/Makefile
@@ -70,8 +70,6 @@ fomit_frame_pointer := $(call cc-option, $(frame-pointer-flag), "")
 fno_stack_protector := $(call cc-option, -fno-stack-protector, "")
 fno_stack_protector_all := $(call cc-option, -fno-stack-protector-all, "")
 wno_frame_address := $(call cc-option, -Wno-frame-address, "")
-fno_pic := $(call cc-option, -fno-pic, "")
-no_pie := $(call cc-option, -no-pie, "")
 wclobbered := $(call cc-option, -Wclobbered, "")
 wunused_but_set_parameter := $(call cc-option, -Wunused-but-set-parameter, "")
 wmissing_parameter_type := $(call cc-option, -Wmissing-parameter-type, "")
@@ -85,8 +83,6 @@ COMMON_CFLAGS += $(wno_frame_address)
 COMMON_CFLAGS += $(if $(U32_LONG_FMT),-D__U32_LONG_FMT__,)
 ifeq ($(CONFIG_EFI),y)
 COMMON_CFLAGS += $(EFI_CFLAGS)
-else
-COMMON_CFLAGS += $(fno_pic)
 endif
 COMMON_CFLAGS += $(wclobbered)
 COMMON_CFLAGS += $(wunused_but_set_parameter)
@@ -103,7 +99,7 @@ CFLAGS += $(LATE_CFLAGS)
 
 autodepend-flags = -MMD -MP -MF $(dir $*).$(notdir $*).d
 
-LDFLAGS += -nostdlib $(no_pie) -z noexecstack
+LDFLAGS += -nostdlib -z noexecstack
 
 $(libcflat): $(cflatobjs)
 	$(AR) rcs $@ $^
diff --git a/arm/Makefile.arm b/arm/Makefile.arm
index 7734e17f..7313c843 100644
--- a/arm/Makefile.arm
+++ b/arm/Makefile.arm
@@ -13,6 +13,8 @@ endif
 
 CFLAGS += $(machine)
 CFLAGS += -mno-unaligned-access
+CFLAGS += -fno-pic
+LDFLAGS += -no-pie
 
 ifeq ($(TARGET),qemu)
 arch_LDFLAGS = -Ttext=40010000
diff --git a/arm/Makefile.arm64 b/arm/Makefile.arm64
index a40c830d..ea0202eb 100644
--- a/arm/Makefile.arm64
+++ b/arm/Makefile.arm64
@@ -7,8 +7,7 @@ bits = 64
 ldarch = elf64-littleaarch64
 
 arch_LDFLAGS = -pie -n
-arch_LDFLAGS += -z notext
-CFLAGS += -mstrict-align
+CFLAGS += -fpie -mstrict-align
 
 sve_flag := $(call cc-option, -march=armv8.5-a+sve, "")
 ifneq ($(strip $(sve_flag)),)
diff --git a/powerpc/Makefile b/powerpc/Makefile
index 41e752b0..eff129b0 100644
--- a/powerpc/Makefile
+++ b/powerpc/Makefile
@@ -66,6 +66,9 @@ CFLAGS += -ffreestanding
 CFLAGS += -O2 -msoft-float -mno-altivec $(mabi_no_altivec)
 CFLAGS += -I $(SRCDIR)/lib -I $(SRCDIR)/lib/libfdt -I lib
 CFLAGS += -Wa,-mregnames
+CFLAGS += -fpie
+
+LDFLAGS += -pie
 
 # We want to keep intermediate files
 .PRECIOUS: %.o
@@ -78,7 +81,7 @@ include $(SRCDIR)/scripts/asm-offsets.mak
 
 FLATLIBS = $(libcflat) $(LIBFDT_archive)
 %.elf: CFLAGS += $(arch_CFLAGS)
-%.elf: LDFLAGS += $(arch_LDFLAGS) -pie -n
+%.elf: LDFLAGS += $(arch_LDFLAGS) -n
 %.elf: %.o $(FLATLIBS) $(SRCDIR)/powerpc/flat.lds $(cstart.o) $(reloc.o) %.aux.o
 	$(LD) $(LDFLAGS) -o $@ \
 		-T $(SRCDIR)/powerpc/flat.lds --build-id=none \
diff --git a/riscv/Makefile b/riscv/Makefile
index 348a30a7..79a9c1ad 100644
--- a/riscv/Makefile
+++ b/riscv/Makefile
@@ -93,6 +93,7 @@ CFLAGS += -std=gnu99
 CFLAGS += -ffreestanding
 CFLAGS += -O2
 CFLAGS += -I $(SRCDIR)/lib -I $(SRCDIR)/lib/libfdt -I lib -I $(SRCDIR)/riscv
+CFLAGS += -fno-pic
 
 asm-offsets = lib/riscv/asm-offsets.h riscv/sbi-asm-offsets.h
 include $(SRCDIR)/scripts/asm-offsets.mak
diff --git a/s390x/Makefile b/s390x/Makefile
index 97ed0b47..29bea5cc 100644
--- a/s390x/Makefile
+++ b/s390x/Makefile
@@ -88,7 +88,10 @@ CFLAGS += -O2
 CFLAGS += -march=zEC12
 CFLAGS += -mbackchain
 CFLAGS += -fno-delete-null-pointer-checks
+CFLAGS += -fno-pic
+
 LDFLAGS += -Wl,--build-id=none
+LDFLAGS += -no-pie
 
 # We want to keep intermediate files
 .PRECIOUS: %.o %.lds
diff --git a/x86/Makefile.common b/x86/Makefile.common
index 054e2391..a0201fcd 100644
--- a/x86/Makefile.common
+++ b/x86/Makefile.common
@@ -40,6 +40,11 @@ COMMON_CFLAGS += -Wa,--divide
 endif
 COMMON_CFLAGS += -O1
 
+ifneq ($(CONFIG_EFI),y)
+CFLAGS += -fno-pic
+LDFLAGS += -no-pie
+endif
+
 # stack.o relies on frame pointers.
 KEEP_FRAME_POINTER := y
 
-- 
2.56.0

