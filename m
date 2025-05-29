Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A50E21D5A4
	for <linux-s390@vger.kernel.org>; Thu, 29 May 2025 22:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748557187; cv=none; b=QXu+2tRswy/qLMS9nJDk0KLnje3WqGvC0JV9M7CLNCRWntOGgL5YmLhdp3Aq1hOON6ZegtbzU7EzHpMivbQRBzhtalbwFniiyKTKRsM1JVJcvZU4xCk929abj+QHg78atPsrGgeLnE95/W5KSFhLkD8MVzRQBIPfOLX8GTGxFws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748557187; c=relaxed/simple;
	bh=88sHu9dXYdQx8HCgs2uDBPizga3f4r49hwzbtHYDrCM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mon/m8RAC8shiElA6ujCPgkFrNdqDcUiBdq+2UHp/ggDiUXVpq6HbfuHGd9G6bNGm7Jt2FSWGSk+jQXBY76YHhET7QqKpJqJ2rqxv6h3sV+aQjrYQ9AHS72+WXZGEyIaxBW1THN3PW67GcQa92ealgGi7oOnWuXFQj2NWhdhU5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3Bd3gI3j; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3Bd3gI3j"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2326a6d667eso13349865ad.1
        for <linux-s390@vger.kernel.org>; Thu, 29 May 2025 15:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748557185; x=1749161985; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=4p/1kmWiRyp+7Os+63Z9VcctJJrswAn8XSplAjfBM7Q=;
        b=3Bd3gI3jmEnb3AOjqAEofc4Iv2A/RR36MYo7GxgaAHYVzdI7JEUZ/TSE5wThfpwPgf
         kahZlQayDn60GnaSjWnp57LtbIwCWLMqqAuFo2oBnCoBOJQ8MWNBrTTM95Dvs1FQCJ/T
         nTDfuF5sFcso8BoipjIjVoqnJt2+ssj46IhNST9tUmAN+ZE8ko3XSsdiNBJzUbtqph8X
         VEeinW5kcRZSXt+UbtbrmR/ocgBWVR/XGm0N+Ebs3arPA6QhizWpgWKyYCqfLYuBXvt+
         aEyE/dK0qNl/3eMiSDiIWZDfp5AK9atR72WucVUE+Cwl7D1g8AmdcsBPwxBrFcctsrvn
         ZaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748557185; x=1749161985;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4p/1kmWiRyp+7Os+63Z9VcctJJrswAn8XSplAjfBM7Q=;
        b=hcy9Pd2Np21JmOITWaadcy7dkl1l2SZJ12rziGqMRh4lAJuWYZ1IUSvBkrf3TQIlVP
         JH4R/kBm3VKBpJaiDySuZTvjZ0wW/r/UdF7bUsJlduabMCWm1vdWuGPQkM2zcMtxQHfh
         3QlgjMGfjILSqb58obUUelzc96cTqG0wEHbe6hdJuYYluSHxLhcuVUq6V7c5v4lHyV/9
         +Ovpqxu+yqDKjn9q8Kcyn+3RA7+Cfq4rJ9y0pcs21kK4NBmcQFKz2IYB5+vjFfKu2VhQ
         8rs2vuvZGo8aThb38UjJ5IokTegZdP1u9OX8572q1xSZol+VPWLV+2OLTg/VFlucJ+hy
         jj7g==
X-Forwarded-Encrypted: i=1; AJvYcCXlDgD1KUEV5YAGStpX8ZrH6g+uKYg1B4wEvhNMEPEl/6m97bzX2LOo9knpDmGsFjkQXYE5A/j2M0wH@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjm0WkQ4RNz1o2fMcL/ilQtvGNYEhjqK4iaGpuvuEkSwa5k/5+
	XF1eFmwwtMHQI1n0v/7jc0JsVkgceXZ/305pKwk7wBH6IJHP9Bkegy4W8lwyshQbmjFuPYjn4LR
	cmch5rw==
X-Google-Smtp-Source: AGHT+IFXNSXg+8D9lEWdatr1QLsM7ddqiFyaZCdJAHYIj0LYqIW7eMgV61Z0Am2ItpUnNaFhrVXuA51YgQQ=
X-Received: from plrd21.prod.google.com ([2002:a17:902:aa95:b0:234:e3a2:5b21])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2312:b0:234:9656:7db9
 with SMTP id d9443c01a7336-2352990511fmr17903355ad.32.1748557185478; Thu, 29
 May 2025 15:19:45 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 29 May 2025 15:19:16 -0700
In-Reply-To: <20250529221929.3807680-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250529221929.3807680-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250529221929.3807680-4-seanjc@google.com>
Subject: [kvm-unit-tests PATCH 03/16] x86: Add X86_PROPERTY_* framework to
 retrieve CPUID values
From: Sean Christopherson <seanjc@google.com>
To: Andrew Jones <andrew.jones@linux.dev>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, "=?UTF-8?q?Nico=20B=C3=B6hr?=" <nrb@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce X86_PROPERTY_* to allow retrieving values/properties from CPUID
leafs, e.g. MAXPHYADDR from CPUID.0x80000008.  Use the same core code as
X86_FEATURE_*, the primary difference is that properties are multi-bit
values, whereas features enumerate a single bit.

Add this_cpu_has_p() to allow querying whether or not a property exists
based on the maximum leaf associated with the property, e.g. MAXPHYADDR
doesn't exist if the max leaf for 0x8000_xxxx is less than 0x8000_0008.

Use the new property infrastructure in cpuid_maxphyaddr() to prove that
the code works as intended.  Future patches will convert additional code.

Note, the code, nomenclature, changelog, etc. are all stolen from KVM
selftests.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 lib/x86/processor.h | 109 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 102 insertions(+), 7 deletions(-)

diff --git a/lib/x86/processor.h b/lib/x86/processor.h
index 3ac6711d..6b61a38b 100644
--- a/lib/x86/processor.h
+++ b/lib/x86/processor.h
@@ -218,13 +218,6 @@ static inline struct cpuid cpuid(u32 function)
 	return cpuid_indexed(function, 0);
 }
 
-static inline u8 cpuid_maxphyaddr(void)
-{
-	if (raw_cpuid(0x80000000, 0).a < 0x80000008)
-	return 36;
-	return raw_cpuid(0x80000008, 0).a & 0xff;
-}
-
 static inline bool is_intel(void)
 {
 	struct cpuid c = cpuid(0);
@@ -329,6 +322,74 @@ struct x86_cpu_feature {
 #define X86_FEATURE_VNMI		X86_CPU_FEATURE(0x8000000A, 0, EDX, 25)
 #define	X86_FEATURE_AMD_PMU_V2		X86_CPU_FEATURE(0x80000022, 0, EAX, 0)
 
+/*
+ * Same idea as X86_FEATURE_XXX, but X86_PROPERTY_XXX retrieves a multi-bit
+ * value/property as opposed to a single-bit feature.  Again, pack the info
+ * into a 64-bit value to pass by value with no overhead on 64-bit builds.
+ */
+struct x86_cpu_property {
+	u32	function;
+	u8	index;
+	u8	reg;
+	u8	lo_bit;
+	u8	hi_bit;
+};
+#define	X86_CPU_PROPERTY(fn, idx, gpr, low_bit, high_bit)			\
+({										\
+	struct x86_cpu_property property = {					\
+		.function = fn,							\
+		.index = idx,							\
+		.reg = gpr,							\
+		.lo_bit = low_bit,						\
+		.hi_bit = high_bit,						\
+	};									\
+										\
+	static_assert(low_bit < high_bit);					\
+	static_assert((fn & 0xc0000000) == 0 ||					\
+		      (fn & 0xc0000000) == 0x40000000 ||			\
+		      (fn & 0xc0000000) == 0x80000000 ||			\
+		      (fn & 0xc0000000) == 0xc0000000);				\
+	static_assert(idx < BIT(sizeof(property.index) * BITS_PER_BYTE));	\
+	property;								\
+})
+
+#define X86_PROPERTY_MAX_BASIC_LEAF		X86_CPU_PROPERTY(0, 0, EAX, 0, 31)
+#define X86_PROPERTY_PMU_VERSION		X86_CPU_PROPERTY(0xa, 0, EAX, 0, 7)
+#define X86_PROPERTY_PMU_NR_GP_COUNTERS		X86_CPU_PROPERTY(0xa, 0, EAX, 8, 15)
+#define X86_PROPERTY_PMU_GP_COUNTERS_BIT_WIDTH	X86_CPU_PROPERTY(0xa, 0, EAX, 16, 23)
+#define X86_PROPERTY_PMU_EBX_BIT_VECTOR_LENGTH	X86_CPU_PROPERTY(0xa, 0, EAX, 24, 31)
+#define X86_PROPERTY_PMU_EVENTS_MASK		X86_CPU_PROPERTY(0xa, 0, EBX, 0, 7)
+#define X86_PROPERTY_PMU_FIXED_COUNTERS_BITMASK	X86_CPU_PROPERTY(0xa, 0, ECX, 0, 31)
+#define X86_PROPERTY_PMU_NR_FIXED_COUNTERS	X86_CPU_PROPERTY(0xa, 0, EDX, 0, 4)
+#define X86_PROPERTY_PMU_FIXED_COUNTERS_BIT_WIDTH	X86_CPU_PROPERTY(0xa, 0, EDX, 5, 12)
+
+#define X86_PROPERTY_SUPPORTED_XCR0_LO		X86_CPU_PROPERTY(0xd,  0, EAX,  0, 31)
+#define X86_PROPERTY_XSTATE_MAX_SIZE_XCR0	X86_CPU_PROPERTY(0xd,  0, EBX,  0, 31)
+#define X86_PROPERTY_XSTATE_MAX_SIZE		X86_CPU_PROPERTY(0xd,  0, ECX,  0, 31)
+#define X86_PROPERTY_SUPPORTED_XCR0_HI		X86_CPU_PROPERTY(0xd,  0, EDX,  0, 31)
+
+#define X86_PROPERTY_XSTATE_TILE_SIZE		X86_CPU_PROPERTY(0xd, 18, EAX,  0, 31)
+#define X86_PROPERTY_XSTATE_TILE_OFFSET		X86_CPU_PROPERTY(0xd, 18, EBX,  0, 31)
+#define X86_PROPERTY_AMX_MAX_PALETTE_TABLES	X86_CPU_PROPERTY(0x1d, 0, EAX,  0, 31)
+#define X86_PROPERTY_AMX_TOTAL_TILE_BYTES	X86_CPU_PROPERTY(0x1d, 1, EAX,  0, 15)
+#define X86_PROPERTY_AMX_BYTES_PER_TILE		X86_CPU_PROPERTY(0x1d, 1, EAX, 16, 31)
+#define X86_PROPERTY_AMX_BYTES_PER_ROW		X86_CPU_PROPERTY(0x1d, 1, EBX, 0,  15)
+#define X86_PROPERTY_AMX_NR_TILE_REGS		X86_CPU_PROPERTY(0x1d, 1, EBX, 16, 31)
+#define X86_PROPERTY_AMX_MAX_ROWS		X86_CPU_PROPERTY(0x1d, 1, ECX, 0,  15)
+
+#define X86_PROPERTY_MAX_KVM_LEAF		X86_CPU_PROPERTY(0x40000000, 0, EAX, 0, 31)
+
+#define X86_PROPERTY_MAX_EXT_LEAF		X86_CPU_PROPERTY(0x80000000, 0, EAX, 0, 31)
+#define X86_PROPERTY_MAX_PHY_ADDR		X86_CPU_PROPERTY(0x80000008, 0, EAX, 0, 7)
+#define X86_PROPERTY_MAX_VIRT_ADDR		X86_CPU_PROPERTY(0x80000008, 0, EAX, 8, 15)
+#define X86_PROPERTY_GUEST_MAX_PHY_ADDR		X86_CPU_PROPERTY(0x80000008, 0, EAX, 16, 23)
+#define X86_PROPERTY_SEV_C_BIT			X86_CPU_PROPERTY(0x8000001F, 0, EBX, 0, 5)
+#define X86_PROPERTY_PHYS_ADDR_REDUCTION	X86_CPU_PROPERTY(0x8000001F, 0, EBX, 6, 11)
+#define X86_PROPERTY_NR_PERFCTR_CORE		X86_CPU_PROPERTY(0x80000022, 0, EBX, 0, 3)
+#define X86_PROPERTY_NR_PERFCTR_NB		X86_CPU_PROPERTY(0x80000022, 0, EBX, 10, 15)
+
+#define X86_PROPERTY_MAX_CENTAUR_LEAF		X86_CPU_PROPERTY(0xC0000000, 0, EAX, 0, 31)
+
 static inline u32 __this_cpu_has(u32 function, u32 index, u8 reg, u8 lo, u8 hi)
 {
 	union {
@@ -347,6 +408,40 @@ static inline bool this_cpu_has(struct x86_cpu_feature feature)
 			      feature.reg, feature.bit, feature.bit);
 }
 
+static inline uint32_t this_cpu_property(struct x86_cpu_property property)
+{
+	return __this_cpu_has(property.function, property.index,
+			      property.reg, property.lo_bit, property.hi_bit);
+}
+
+static __always_inline bool this_cpu_has_p(struct x86_cpu_property property)
+{
+	uint32_t max_leaf;
+
+	switch (property.function & 0xc0000000) {
+	case 0:
+		max_leaf = this_cpu_property(X86_PROPERTY_MAX_BASIC_LEAF);
+		break;
+	case 0x40000000:
+		max_leaf = this_cpu_property(X86_PROPERTY_MAX_KVM_LEAF);
+		break;
+	case 0x80000000:
+		max_leaf = this_cpu_property(X86_PROPERTY_MAX_EXT_LEAF);
+		break;
+	case 0xc0000000:
+		max_leaf = this_cpu_property(X86_PROPERTY_MAX_CENTAUR_LEAF);
+	}
+	return max_leaf >= property.function;
+}
+
+static inline u8 cpuid_maxphyaddr(void)
+{
+	if (!this_cpu_has_p(X86_PROPERTY_MAX_PHY_ADDR))
+		return 36;
+
+	return this_cpu_property(X86_PROPERTY_MAX_PHY_ADDR);
+}
+
 struct far_pointer32 {
 	u32 offset;
 	u16 selector;
-- 
2.49.0.1204.g71687c7c1d-goog

