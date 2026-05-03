Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D300E1F1932
	for <linux-s390@vger.kernel.org>; Sun,  3 May 2026 00:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777767783; cv=none; b=GpTiyqPmCdgJLL05NXM+G8MymwkQ1llQUa0DHBCOZmn6fVnQBhYDeUPLXWo3gSV17CgRCrx5gI/9p4a2Ewi867rgvoqI8UkjGDIOlX3ofdl6OJIm70WHe9mtIMf1XQb99xxm+2M6mwGtrGJ2v1f8xjWAnp7tKdI2jLeLyrx4soc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777767783; c=relaxed/simple;
	bh=PO3Yy8xeA9w2QKJ+hooEkIab7oMYSoY1HxvISsaH+tk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Zu+HsQPW2csklxUIUcTl3ILD4D/ELCRQsM84TdmfZ/3+XDfDT63sEjyMZjz9tv43Io4YFAJSFX1W4B3Pb67f80iqKdfLr1nsS+WncBe9hggKrCxLOfVPgb9NKUs8r2V5YC232xKe0es3YY9JDBCa0l3xzp7glHHa8ytbcLQaLHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NDGjgBn/; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NDGjgBn/"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c726f4019so4280704c88.1
        for <linux-s390@vger.kernel.org>; Sat, 02 May 2026 17:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777767781; x=1778372581; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MOjpSSG5hiDUctQJqaNUda8jZZzKwcMd5j3IEHpXIyM=;
        b=NDGjgBn/t9xKGRYvrkiuv+JZcAz093WPCsnqzst2OUBnSrkVqTKCjIqxVD8vo1ZTVF
         9CO0JqAagT8Vw2MO/UgspTxFAR3wAh1pZA1meRcpqya6EklTpqMnRZ6/9/kfmGMXKkb8
         8RQgC94qaM4wmIkM89OhmbLe+s8tUBJTb1M4BmvH5cDS+raFD21NjTr54X8uQovozwWU
         7L77j4AprDlUyfLhFAJagSKT9fjLad5szwa+OqgcgOCHrxJDKQWa/Xs3MlcXEyXCJnEr
         FNV8/dBydROrqyyS3Bj2uWfYhPcCHYii0/jWmeKpbmoRhv9YU5CeBCfmSc4c8g6dnBJ1
         jyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777767781; x=1778372581;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MOjpSSG5hiDUctQJqaNUda8jZZzKwcMd5j3IEHpXIyM=;
        b=i6DtYczLLXN1nXC4EkT7PEuQrIPDECx9iwcpaxd1e4Ex/uDf8ijVf1NZXZr4Ru2QR+
         PdLAk2Tu3Dgzb26iJdYqnlMEeywzFuuZCp4ng1NMj/xvun0ekDDdu2HKwFl2G+GahnmB
         Pfi6WqdDDrMwZXVQ6MRjycbsP17+q8PUvAcyZN+DTZ2tQ3A/76HCcKZ8WFxnWYNo/Dk4
         LhXDMOTFC3T4XYodtYXI/ag5J6KSTx2fwyXc/A6dNy1afo6ZJdL++dMeVye/0NRN/ik8
         R8yXSQysJpBmoj3MtcyRORKjDDXCFtyhCqDdO+i4Mlfygg5HakWuX2RVh5IFQ+5Nny2V
         LFzQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Uz8CBa/vO5iNWdTC/l+IKjVrtKQz6XO8iNpCR/EaucnrEK492qByjTammOSSl6gFNGS3/kyKV4PPL@vger.kernel.org
X-Gm-Message-State: AOJu0Yyof+oT+aLELcSFroQUEjTwvzM91PHjAzIu5KtDNtBps49mRvgQ
	AaLXJRC6WcBJhWS/JXDKiKei7KXCIOl4H1s8BvVAqyOJnwzwQCIc4pR/GxRXHfHxILlW8atGz6c
	kRzmLt3CJLg==
X-Received: from dlbcj12.prod.google.com ([2002:a05:7022:698c:b0:12d:b1c5:1596])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6725:b0:124:9fd8:4ba9
 with SMTP id a92af1059eb24-12dfd7ca4b5mr2124757c88.12.1777767780844; Sat, 02
 May 2026 17:23:00 -0700 (PDT)
Date: Sat,  2 May 2026 17:22:34 -0700
In-Reply-To: <20260503002248.1040791-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260502065935.291960-1-irogers@google.com> <20260503002248.1040791-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260503002248.1040791-5-irogers@google.com>
Subject: [PATCH v9 04/18] perf capstone: Determine architecture from e_machine
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Avoid the use of arch string that is imprecise and use the
e_machine. Do more e_machine to capstone machine translations adding
MIPS and RISCV. Remove unnecessary maybe_unused annotations.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/capstone.c | 129 ++++++++++++++++++++++++-------------
 1 file changed, 85 insertions(+), 44 deletions(-)

diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
index 25cf6e15ec27..870394b46911 100644
--- a/tools/perf/util/capstone.c
+++ b/tools/perf/util/capstone.c
@@ -1,7 +1,19 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "capstone.h"
-#include "annotate.h"
+
+#include <errno.h>
+#include <inttypes.h>
+#include <string.h>
+
+#include <dlfcn.h>
+#include <elf.h>
+#include <fcntl.h>
+#include <linux/ctype.h>
+
+#include <capstone/capstone.h>
+
 #include "addr_location.h"
+#include "annotate.h"
 #include "debug.h"
 #include "disasm.h"
 #include "dso.h"
@@ -11,13 +23,6 @@
 #include "print_insn.h"
 #include "symbol.h"
 #include "thread.h"
-#include <dlfcn.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <inttypes.h>
-#include <string.h>
-
-#include <capstone/capstone.h>
 
 #ifdef LIBCAPSTONE_DLOPEN
 static void *perf_cs_dll_handle(void)
@@ -137,37 +142,67 @@ static enum cs_err perf_cs_close(csh *handle)
 #endif
 }
 
-static int capstone_init(struct machine *machine, csh *cs_handle, bool is64,
+static bool e_machine_to_capstone(uint16_t e_machine, bool is64, bool is_big_endian,
+				  enum cs_arch *arch, enum cs_mode *mode)
+{
+	*mode = is_big_endian ? CS_MODE_BIG_ENDIAN : CS_MODE_LITTLE_ENDIAN;
+	*mode |= is64 ? CS_MODE_64 : CS_MODE_32;
+
+	switch (e_machine) {
+	case EM_X86_64:
+	case EM_386:
+		*arch = CS_ARCH_X86;
+		return true;
+	case EM_AARCH64:
+		*arch = CS_ARCH_ARM64;
+		*mode |= CS_MODE_ARM;
+		return true;
+	case EM_ARM:
+		*arch = CS_ARCH_ARM;
+		*mode |= CS_MODE_ARM | CS_MODE_V8;
+		return true;
+	case EM_S390:
+		*arch = CS_ARCH_SYSZ;
+		return true;
+	case EM_MIPS:
+		*arch = CS_ARCH_MIPS;
+		*mode |= is64 ? CS_MODE_MIPS64 : CS_MODE_MIPS32;
+		return true;
+	case EM_PPC:
+	case EM_PPC64:
+		*arch = CS_ARCH_PPC;
+		return true;
+	case EM_SPARC:
+		*arch = CS_ARCH_SPARC;
+		return true;
+	case EM_SPARCV9:
+		*arch = CS_ARCH_SPARC;
+		*mode |= CS_MODE_V9;
+		return true;
+	case EM_RISCV:
+		*arch = CS_ARCH_RISCV;
+		*mode |= is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32;
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int capstone_init(uint16_t e_machine, csh *cs_handle, bool is64, bool is_big_endian,
 			 bool disassembler_style)
 {
 	enum cs_arch arch;
 	enum cs_mode mode;
 
-	if (machine__is(machine, "x86_64") && is64) {
-		arch = CS_ARCH_X86;
-		mode = CS_MODE_64;
-	} else if (machine__normalized_is(machine, "x86")) {
-		arch = CS_ARCH_X86;
-		mode = CS_MODE_32;
-	} else if (machine__normalized_is(machine, "arm64")) {
-		arch = CS_ARCH_ARM64;
-		mode = CS_MODE_ARM;
-	} else if (machine__normalized_is(machine, "arm")) {
-		arch = CS_ARCH_ARM;
-		mode = CS_MODE_ARM + CS_MODE_V8;
-	} else if (machine__normalized_is(machine, "s390")) {
-		arch = CS_ARCH_SYSZ;
-		mode = CS_MODE_BIG_ENDIAN;
-	} else {
+	if (!e_machine_to_capstone(e_machine, is64, is_big_endian, &arch, &mode))
 		return -1;
-	}
 
 	if (perf_cs_open(arch, mode, cs_handle) != CS_ERR_OK) {
 		pr_warning_once("cs_open failed\n");
 		return -1;
 	}
 
-	if (machine__normalized_is(machine, "x86")) {
+	if (arch == CS_ARCH_X86) {
 		/*
 		 * In case of using capstone_init while symbol__disassemble
 		 * setting CS_OPT_SYNTAX_ATT depends if disassembler_style opts
@@ -211,29 +246,28 @@ static size_t print_insn_x86(struct thread *thread, u8 cpumode, struct cs_insn *
 	return printed;
 }
 
-
-ssize_t capstone__fprintf_insn_asm(struct machine *machine __maybe_unused,
-				   struct thread *thread __maybe_unused,
-				   u8 cpumode __maybe_unused, bool is64bit __maybe_unused,
-				   const uint8_t *code __maybe_unused,
-				   size_t code_size __maybe_unused,
-				   uint64_t ip __maybe_unused, int *lenp __maybe_unused,
-				   int print_opts __maybe_unused, FILE *fp __maybe_unused)
+ssize_t capstone__fprintf_insn_asm(struct machine *machine, struct thread *thread, u8 cpumode,
+				   bool is64bit, const uint8_t *code, size_t code_size, uint64_t ip,
+				   int *lenp, int print_opts, FILE *fp)
 {
 	size_t printed;
 	struct cs_insn *insn;
 	csh cs_handle;
 	size_t count;
+	bool is_big_endian = false;
+	uint16_t e_machine = thread__e_machine_endian(thread, machine,
+						      /*e_flags=*/NULL, &is_big_endian);
 	int ret;
 
 	/* TODO: Try to initiate capstone only once but need a proper place. */
-	ret = capstone_init(machine, &cs_handle, is64bit, true);
+	ret = capstone_init(e_machine, &cs_handle, is64bit, is_big_endian,
+			    /*disassembler_style=*/true);
 	if (ret < 0)
 		return ret;
 
 	count = perf_cs_disasm(cs_handle, code, code_size, ip, 1, &insn);
 	if (count > 0) {
-		if (machine__normalized_is(machine, "x86"))
+		if (e_machine == EM_X86_64 || e_machine == EM_386)
 			printed = print_insn_x86(thread, cpumode, &insn[0], print_opts, fp);
 		else
 			printed = fprintf(fp, "%s %s", insn[0].mnemonic, insn[0].op_str);
@@ -322,9 +356,8 @@ static int find_file_offset(u64 start, u64 len, u64 pgoff, void *arg)
 	return 0;
 }
 
-int symbol__disassemble_capstone(const char *filename __maybe_unused,
-				 struct symbol *sym __maybe_unused,
-				 struct annotate_args *args __maybe_unused)
+int symbol__disassemble_capstone(const char *filename, struct symbol *sym,
+				 struct annotate_args *args)
 {
 	struct annotation *notes = symbol__annotation(sym);
 	struct map *map = args->ms->map;
@@ -344,6 +377,8 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
 	char disasm_buf[512];
 	struct disasm_line *dl;
 	bool disassembler_style = false;
+	uint16_t e_machine;
+	bool is_big_endian = false;
 
 	if (args->options->objdump_path)
 		return -1;
@@ -373,8 +408,10 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
 	    !strcmp(args->options->disassembler_style, "att"))
 		disassembler_style = true;
 
-	if (capstone_init(maps__machine(thread__maps(args->ms->thread)), &handle, is_64bit,
-			  disassembler_style) < 0)
+	e_machine = thread__e_machine_endian(args->ms->thread,
+					     /*machine=*/NULL,
+					     /*e_flags=*/NULL, &is_big_endian);
+	if (capstone_init(e_machine, &handle, is_64bit, is_big_endian, disassembler_style) < 0)
 		goto err;
 
 	needs_cs_close = true;
@@ -466,6 +503,8 @@ int symbol__disassemble_capstone_powerpc(const char *filename __maybe_unused,
 	struct disasm_line *dl;
 	u32 *line;
 	bool disassembler_style = false;
+	uint16_t e_machine;
+	bool is_big_endian = false;
 
 	if (args->options->objdump_path)
 		return -1;
@@ -484,8 +523,10 @@ int symbol__disassemble_capstone_powerpc(const char *filename __maybe_unused,
 	    !strcmp(args->options->disassembler_style, "att"))
 		disassembler_style = true;
 
-	if (capstone_init(maps__machine(thread__maps(args->ms->thread)), &handle, is_64bit,
-			  disassembler_style) < 0)
+	e_machine = thread__e_machine_endian(args->ms->thread,
+					     /*machine=*/NULL,
+					     /*e_flags=*/NULL, &is_big_endian);
+	if (capstone_init(e_machine, &handle, is_64bit, is_big_endian, disassembler_style) < 0)
 		goto err;
 
 	needs_cs_close = true;
-- 
2.54.0.545.g6539524ca2-goog

