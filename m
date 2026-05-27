Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3A7264FBD;
	Wed, 27 May 2026 21:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779917443; cv=none; b=kkfuJHl0010YzdEMQuQ1COzs7tdmJ6XtJBDq4IdTMMSlRUNJr0aAyS5nQwp76sCt1p4uKYpY2KfBWvpwSNyC4cHsG06rL6UNWpE2H9GtSDwMW4Ebio9oZ+/XU8cyvkEc+Mp2kAIeZk72wOHlxswN+dN0/SQetBorPeQ4RI4mGsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779917443; c=relaxed/simple;
	bh=D5GFDrTp/CupsUZ3fV6a6tHaosPpCZ5vDA0L1xU/lM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Om8ZqSu9h4JMqWqCkCINdkptOmHKnDmocxSPslYLnx9cHYe/DbI94xlCS4lOX1uHXalQaSj0tA0MhnuXoUBOuk3TXtuT2IUARArbVrQuKc9f9jkD4/huU0oZtrK4Z4AhyrRBkos9/hzyL7KD+kR81dhEd7kxWRzcQqovf7VCNls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oM1PAq1p; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oM1PAq1p"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RL6dYw3426749;
	Wed, 27 May 2026 21:29:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=suyTKV
	/1JgCUQjudqdAWst2BX/tKYPWoFylI4WBEvSU=; b=oM1PAq1pCajfe+PezGwUgU
	KdndajHruuUMn83OuIoh52TcgG0I/aThh5XUorN6WzZk02D0QUmA+d7aaJW4jbeR
	UkHUBbZJ8h8wnwYJYabSXtuhNZJIjPrVgUZJco8dkGZv6K9eyDdU/NPTPLQbpI2z
	znMxoM+kcbSx6aAk19kWmT+62Pp/f3YAOv9RrfEsFDhhPPs19rb8Qg1TH8wX9TSL
	9O20uUTULQ4+gt2tWoJnuY5fX59psLJPOzSF4A4TxPUW7/I6OiVWfqipJp1o6vit
	BfWZ5ENYnXbIXiyiHH/Cq63U//8slg9BA6m4XUlO7ZbcW7hPXtw8fBornZmpEo3Q
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884g25b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 21:29:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64RKsDdJ029443;
	Wed, 27 May 2026 21:06:13 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrbw1ah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 21:06:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64RL69Nc36897054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 21:06:09 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9711F20043;
	Wed, 27 May 2026 21:06:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 446AC20040;
	Wed, 27 May 2026 21:06:08 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown [9.111.1.41])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 27 May 2026 21:06:08 +0000 (GMT)
Date: Wed, 27 May 2026 23:06:06 +0200
From: Jan Polensky <japo@linux.ibm.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        ojeda@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
        jbaron@akamai.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
        lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
        dakr@kernel.org, rostedt@goodmis.org, ardb@kernel.org,
        linux-s390@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] s390/jump_label: Implement
 ARCH_STATIC_BRANCH_JUMP_ASM and ARCH_STATIC_BRANCH_ASM macros
Message-ID: <ahdcvjZ7PTzlImEG@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20260521165622.279953-1-japo@linux.ibm.com>
 <20260521165622.279953-3-japo@linux.ibm.com>
 <ahaH5k0yKi9IFvv8@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="67Ci9XMUDsiZd1k+"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahaH5k0yKi9IFvv8@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=L4MtheT8 c=1 sm=1 tr=0 ts=6a176255 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8
 a=fHLg4gE9CpxF8oULZlMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=DQyPrcOMFmQVaJx41_0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: yZqWu2ESHyWKf5NhbrUWD3pulcZJsPxO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDIxMSBTYWx0ZWRfX+41/0gW39kTL
 dC3bD9D18V3ytAMeWXF0DXS2ImD24VowBDGD7iez83XFsFdd2H0fZYLZezGpaqBq70tKzFc29lF
 s3uDzQ1nldUi0VIIhh9OVgyhNVGsE7WDgMYh13gYYf0Zp4MTKtaltRshv0Ji4r6Aj1of5OJq425
 SwdjKF+BbJRStx/a9MX0lqj3qUD1jPHx+1LhwCsxtJz2InRrgbbfxICLNruC95RXxCm++nLvVgN
 zoVIgGjuqKgCLDPVEIi0KT57+5zZ9/U8egOWqIgEWRHrwrUurjnrsi4ZjHLc9EKui6sNnSh4gKI
 x1kzPsn7V/B14QSuZnTQZt835KTFebRFJbbZ7IAf8DUyyvEGeH/zgZLIIZZ0S17jdcbUwkzdGF8
 NGT8ZXSQZoJfZQRHK4Rx7mbyllYvEnxvIlwAHNjEiYyfsfh4KUYyvHto9jEItC0EbWvSNSDG5G/
 /vQmxyTjPdDpjPTlYdw==
X-Proofpoint-GUID: _sZcBgsNEZGNZRTb79qEiHldlRdjFcaZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605270211


--67Ci9XMUDsiZd1k+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, May 27, 2026 at 05:57:58AM +0000, Alice Ryhl wrote:
> On Thu, May 21, 2026 at 06:56:20PM +0200, Jan Polensky wrote:
> > Rust static branch support needs the s390 jump label instruction sequence
> > and __jump_table emission in a reusable form. The current implementation
> > embeds the sequence directly in the C asm goto blocks, which cannot be
> > shared with Rust.
> >
> > Introduce ARCH_STATIC_BRANCH_ASM and ARCH_STATIC_BRANCH_JUMP_ASM to
> > describe the brcl sequences for the likely-false and likely-true cases
> > and to emit the same __jump_table entries as before. Switch the existing
> > C helpers to use the new macros to avoid duplication without changing
> > the generated code.
> >
> > Signed-off-by: Jan Polensky <japo@linux.ibm.com>
>
> This looks right.
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>
> Did you test it?
>
> Alice

Hi Alice,

yes, I tested it.

I used a small Rust sample module to exercise and validate the
behavior on s390. The patch is attached for reference. I did not
include the sample in this series.

It was not only rust I've used, my samples are not part of this series
(attached):

    ❯ readelf -SW samples/rust/rust_jump_label.ko | egrep '__jump_table|text|rela'
      [ 2] .rela__ksymtab    RELA            0000000000000000 06c298 000048 18   I 46   1  8
      [ 5] __jump_table      PROGBITS        0000000000000000 000060 000010 00  WA  0   0  8
      [ 6] .rela__jump_table RELA            0000000000000000 06c2e0 000048 18   I 46   5  8
      [ 7] .text             PROGBITS        0000000000000000 000070 0001bc 00  AX  0   0 16
      [ 8] .rela.text        RELA            0000000000000000 06c328 000228 18   I 46   7  8
      [ 9] .exit.text        PROGBITS        0000000000000000 000230 00003c 00  AX  0   0 16
      [10] .rela.exit.text   RELA            0000000000000000 06c550 000060 18   I 46   9  8
      [11] .init.text        PROGBITS        0000000000000000 000270 000026 00  AX  0   0 16
      [12] .rela.init.text   RELA            0000000000000000 06c5b0 000018 18   I 46  11  8
      [16] .rela.gnu.linkonce.this_module RELA            0000000000000000 06c5c8 000030 18   I 46  15  8
      [20] .rela.init.data   RELA            0000000000000000 06c5f8 000018 18   I 46  19  8
      [22] .rela.exit.data   RELA            0000000000000000 06c610 000018 18   I 46  21  8
      [32] .rela.debug_aranges RELA            0000000000000000 06c628 000108 18   I 46  31  8
      [34] .rela.debug_info  RELA            0000000000000000 06c730 0573f0 18   I 46  33  8
      [37] .rela.debug_line  RELA            0000000000000000 0c3b20 000048 18   I 46  36  8
      [39] .rela.debug_frame RELA            0000000000000000 0c3b68 000120 18   I 46  38  8
      [42] .rela.debug_loc   RELA            0000000000000000 0c3c88 000150 18   I 46  41  8
      [44] .rela.debug_ranges RELA            0000000000000000 0c3dd8 000300 18   I 46  43  8

Best regards,
Jan


--67Ci9XMUDsiZd1k+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename=0001-samples-rust-Add-jump_label-sample-demonstrating-sta.patch

From 9703d2ff46c03ec8c006a9302c790c4103510718 Mon Sep 17 00:00:00 2001
From: Jan Polensky <japo@linux.ibm.com>
Date: Wed, 27 May 2026 21:28:26 +0200
Subject: [PATCH 1/1] samples/rust: Add jump_label sample demonstrating static
 branches on s390

This sample demonstrates the use of static branches (jump labels) in Rust
kernel modules on s390 architecture. It successfully generates __jump_table
entries and uses s390-specific jgnop instructions for runtime code patching.

Key components:
- C helper defining DEFINE_STATIC_KEY_FALSE(rust_sample_key)
- Rust module using kernel::jump_label::arch_static_branch! macro
- Composite module build (C + Rust) with proper symbol binding
- Generates real __jump_table section with relocations
- Uses s390 jgnop instruction (6-byte NOP) for branch patching

Verification shows:
- __jump_table section present in compiled module
- Three relocations: code location, target, and key pointer
- s390 jgnop instruction at offset 0x102

The module tests the static branch in a loop, demonstrating that Rust
can leverage the kernel's jump label infrastructure for optimized
conditional branches that can be patched at runtime.

Signed-off-by: Jan Polensky <polensky@linux.ibm.com>
Signed-off-by: Jan Polensky <japo@linux.ibm.com>
---
 rust/bindings/bindings_helper.h       |  5 ++
 samples/rust/Kconfig                  | 15 +++++
 samples/rust/Makefile                 |  4 +-
 samples/rust/rust_jump_label_core.rs  | 79 +++++++++++++++++++++++++++
 samples/rust/rust_jump_label_helper.c | 20 +++++++
 5 files changed, 122 insertions(+), 1 deletion(-)
 create mode 100644 samples/rust/rust_jump_label_core.rs
 create mode 100644 samples/rust/rust_jump_label_helper.c

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 446dbeaf0866..539c8d18a72c 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -164,3 +164,8 @@ const unsigned long RUST_CONST_HELPER_GPU_BUDDY_TRIM_DISABLE = GPU_BUDDY_TRIM_DI
 #include "../../drivers/android/binder/rust_binder.h"
 #include "../../drivers/android/binder/rust_binder_events.h"
 #endif
+
+/* Rust jump label sample - external static key */
+#if IS_ENABLED(CONFIG_SAMPLE_RUST_JUMP_LABEL)
+extern struct static_key_false rust_sample_key;
+#endif
diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index 10364db13872..8c579d861988 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -203,4 +203,19 @@ config SAMPLE_RUST_TRIGGER
 
 	  If unsure, say N.
 
+config SAMPLE_RUST_JUMP_LABEL
+	tristate "Jump label (static branch)"
+	depends on JUMP_LABEL
+	help
+	  This option builds the Rust jump label sample module.
+
+	  It demonstrates the use of static branches (jump labels) in Rust
+	  kernel modules, particularly testing ARCH_STATIC_BRANCH_ASM
+	  implementation on s390 architecture.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_jump_label.
+
+	  If unsure, say N.
+
 endif # SAMPLES_RUST
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index 037fd43f9878..f91d8a29802a 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -18,8 +18,10 @@ obj-$(CONFIG_SAMPLE_RUST_CONFIGFS)		+= rust_configfs.o
 obj-$(CONFIG_SAMPLE_RUST_SOC)			+= rust_soc.o
 obj-$(CONFIG_SAMPLE_RUST_BUG)			+= rust_bug.o
 obj-$(CONFIG_SAMPLE_RUST_TRIGGER)		+= rust_trigger.o
+obj-$(CONFIG_SAMPLE_RUST_JUMP_LABEL)		+= rust_jump_label.o
 
 rust_print-y := rust_print_main.o rust_print_events.o
 rust_trigger-y := rust_trigger_main.o rust_print_events.o
+rust_jump_label-y := rust_jump_label_helper.o rust_jump_label_core.o
 
-subdir-$(CONFIG_SAMPLE_RUST_HOSTPROGS)		+= hostprogs
+subdir-$(CONFIG_SAMPLE_RUST_HOSTPROGS)		+= hostprogs
\ No newline at end of file
diff --git a/samples/rust/rust_jump_label_core.rs b/samples/rust/rust_jump_label_core.rs
new file mode 100644
index 000000000000..af3efeb3c2a3
--- /dev/null
+++ b/samples/rust/rust_jump_label_core.rs
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust jump label sample.
+//!
+//! Demonstrates static branches (jump labels) using a C-defined static_key.
+//! Generates __jump_table entries and architecture-specific branch instructions.
+
+use kernel::prelude::*;
+use kernel::sync::atomic::{Atomic, Relaxed};
+
+module! {
+    type: RustJumpLabel,
+    name: "rust_jump_label",
+    authors: ["Jan Polensky"],
+    description: "Rust jump label sample",
+    license: "GPL",
+}
+
+struct RustJumpLabel;
+
+impl kernel::Module for RustJumpLabel {
+    fn init(_module: &'static ThisModule) -> Result<Self> {
+        pr_info!("Rust jump label sample (init)\n");
+
+        let counter = Atomic::new(0);
+        Self::test_jump_label(&counter)?;
+
+        Ok(RustJumpLabel)
+    }
+}
+
+impl RustJumpLabel {
+    fn test_jump_label(counter: &Atomic<u64>) -> Result {
+        for i in 0..10 {
+            counter.fetch_add(1, Relaxed);
+
+            // SAFETY: rust_sample_key is defined in C helper and exported.
+            let branch_taken = unsafe {
+                #[cfg(not(CONFIG_JUMP_LABEL))]
+                {
+                    let key_ptr: *const kernel::bindings::static_key_false =
+                        core::ptr::addr_of!(kernel::bindings::rust_sample_key);
+                    let static_key_ptr: *const kernel::bindings::static_key =
+                        core::ptr::addr_of!((*key_ptr).key);
+                    kernel::bindings::static_key_count(static_key_ptr.cast_mut()) > 0
+                }
+
+                #[cfg(CONFIG_JUMP_LABEL)]
+                {
+                    kernel::jump_label::arch_static_branch!(
+                        kernel::bindings::rust_sample_key,
+                        kernel::bindings::static_key_false,
+                        key,
+                        false
+                    )
+                }
+            };
+
+            if branch_taken {
+                pr_info!("Branch taken at iteration {}\n", i);
+            }
+        }
+
+        let final_count = counter.load(Relaxed);
+        if final_count != 10 {
+            pr_err!("Counter mismatch! Expected 10, got {}\n", final_count);
+            return Err(EINVAL);
+        }
+
+        pr_info!("Test completed. Counter: {}\n", final_count);
+        Ok(())
+    }
+}
+
+impl Drop for RustJumpLabel {
+    fn drop(&mut self) {
+        pr_info!("Rust jump label sample (exit)\n");
+    }
+}
diff --git a/samples/rust/rust_jump_label_helper.c b/samples/rust/rust_jump_label_helper.c
new file mode 100644
index 000000000000..a8e6ebb48846
--- /dev/null
+++ b/samples/rust/rust_jump_label_helper.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * C helper for Rust jump label sample.
+ * Provides a static key that can be used from Rust code.
+ */
+
+#include <linux/module.h>
+#include <linux/jump_label.h>
+
+/*
+ * Define a static key for the Rust module.
+ * This creates the necessary C infrastructure for jump labels.
+ */
+DEFINE_STATIC_KEY_FALSE(rust_sample_key);
+EXPORT_SYMBOL_GPL(rust_sample_key);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("C helper for Rust jump label sample");
+MODULE_AUTHOR("Jan Polensky");
-- 
2.51.0


--67Ci9XMUDsiZd1k+--

