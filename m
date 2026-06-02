Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7493F1656
	for <linux-s390@vger.kernel.org>; Tue,  2 Jun 2026 15:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780413940; cv=none; b=aC01LtdYiPRhHjXqX2KJ4dYpA+NcCWxM2qbKPGyfWC4906C0jzwQmzanDSfcNdeOLHuBaZ+s3jCoY/BOni3zH2C/yneMs1s2bTQ+/iyydpHyTotKSWHdT+cgRUFlxxQFyzNqReRP6UdR9o8FUixCo7wIJ6YEyb5wTVSER1zYb10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780413940; c=relaxed/simple;
	bh=v2jPVgU7NcmbpJgeZh9blErLQKEVvFwnJwLEwzd0nZY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L7zPkMKcK5ef2TN3iLpE2OuRALs8bSzsF0VslBCRnhO/+JCikh+ZWVRwI2LO1YZDohBnS50GFgPPJEl4bzum/MLIXPfPLTP39PV+X8ycgaZ3H1Tm1qL3EIZCfUgxvtyAL1YuxHrME56jE7ADsqa53q+XBKGhlWFFOwLHbPUg4BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G1wLqWxW; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G1wLqWxW"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304ec73b015so6544938eec.1
        for <linux-s390@vger.kernel.org>; Tue, 02 Jun 2026 08:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780413937; x=1781018737; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GulsNcduO8h3GBAwGX8U7EGxU2yFd28SwAXlNyW06wQ=;
        b=G1wLqWxWbkz5Y53IWFiQzk5mf4UxFG0NYS2L7pWeIz0jWBGoG55F2L+AUaPeUhV+f/
         VKcSetci7hM9CCVQ1zPMT5R0Xq2lqf5jaaQ13s7D/kMlXRLPtAcmIWLzXm2TKSsZbjnm
         EA0sl+r3aiipjWBYs25x2LUJ1k+TUEXGfoD1UQAULMxhi0fjHyebOgQK5WZq3n8pJLIt
         MJEeKlNeTEx0+pTUo48d7MHf+PGB3XhHglPr5euSU6VoBMXpWQGPHjYKx6PbD+FDCLR4
         i6rGLtmhJcWjOENAybAwhon6RoveGfJUDZux6L2EOkc8Qd7nnlQsn9ekaGo2OmHFo2EJ
         Lasg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780413937; x=1781018737;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GulsNcduO8h3GBAwGX8U7EGxU2yFd28SwAXlNyW06wQ=;
        b=EaSkfOiy9Cplc44mLU6txLABs6oHlPPwhUfvmv7dXipYAkmSi8FLdGtzEcN1AdjhHp
         Ywq1rzLU0S2ltTVUbRHZDrrWgWu3EU7Ks0Y7mXMNCveD/BDSE/eakpZL+I/dTl8Hxqvw
         JLiNVWkDTldFTHN2WoM8uzNX82jy1BU3uNUMoZ3FYOJGzaWEU6HCes471Iq3LSn88eBV
         eHVN9SE3bXhGRZcrKOE8K66JrlPW1uxIdc8Uyi9+xKiPtSvufkRCVsiS4M9+tB81XTkE
         jGIo9ugGZjPzo7gQmvcTKQ8Z2eYM3EnuiX3K1+3Uwm6WWma164Xs5G3fs3vQ/ruDcwz7
         JFOQ==
X-Forwarded-Encrypted: i=1; AFNElJ+PsOVkxYDhkvYGX/RggctjioP0h/9/P1KEXDfDVnfwzsHcubvVjdAZox7GWifTEMxT7nYTjhhVpRKn@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Nx3WvTMSUkRhF05xPMLLJWfnl1UEIlGbhVRkj40XWbh1u/RP
	piecXCTU0xHJeHheuMbVShmdG88WOPcII3FpfCjXjsNe79lpv6Q94Z8tzxlzns1lxN/VlMaZGDf
	JaJhzdWUM+Q==
X-Received: from dyng38.prod.google.com ([2002:a05:7300:7f26:b0:304:ba41:e879])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:5714:b0:304:1fb6:88fd
 with SMTP id 5a478bee46e88-304fa693196mr8262550eec.29.1780413936861; Tue, 02
 Jun 2026 08:25:36 -0700 (PDT)
Date: Tue,  2 Jun 2026 08:25:01 -0700
In-Reply-To: <20260602152516.2831152-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602062452.2583619-1-irogers@google.com> <20260602152516.2831152-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602152516.2831152-5-irogers@google.com>
Subject: [PATCH v12 04/19] perf capstone: Determine architecture from e_machine
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Avoid the use of arch string that is imprecise and use the
e_machine. Do more e_machine to capstone machine translations adding
MIPS and RISCV. Remove unnecessary maybe_unused annotations.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/capstone.c | 132 ++++++++++++++++++++++++-------------
 1 file changed, 88 insertions(+), 44 deletions(-)

diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
index 25cf6e15ec27..5ad537fea436 100644
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
@@ -137,37 +142,70 @@ static enum cs_err perf_cs_close(csh *handle)
 #endif
 }
 
-static int capstone_init(struct machine *machine, csh *cs_handle, bool is64,
+static bool e_machine_to_capstone(uint16_t e_machine, bool is64, bool is_big_endian,
+				  enum cs_arch *arch, enum cs_mode *mode)
+{
+	*mode = is_big_endian ? CS_MODE_BIG_ENDIAN : CS_MODE_LITTLE_ENDIAN;
+
+	switch (e_machine) {
+	case EM_X86_64:
+	case EM_386:
+		*arch = CS_ARCH_X86;
+		*mode |= is64 ? CS_MODE_64 : CS_MODE_32;
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
+		*arch = CS_ARCH_PPC;
+		return true;
+	case EM_PPC64:
+		*arch = CS_ARCH_PPC;
+		*mode |= CS_MODE_64;
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
+		*mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
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
@@ -211,29 +249,28 @@ static size_t print_insn_x86(struct thread *thread, u8 cpumode, struct cs_insn *
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
@@ -322,9 +359,8 @@ static int find_file_offset(u64 start, u64 len, u64 pgoff, void *arg)
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
@@ -344,6 +380,8 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
 	char disasm_buf[512];
 	struct disasm_line *dl;
 	bool disassembler_style = false;
+	uint16_t e_machine;
+	bool is_big_endian = false;
 
 	if (args->options->objdump_path)
 		return -1;
@@ -373,8 +411,10 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
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
@@ -466,6 +506,8 @@ int symbol__disassemble_capstone_powerpc(const char *filename __maybe_unused,
 	struct disasm_line *dl;
 	u32 *line;
 	bool disassembler_style = false;
+	uint16_t e_machine;
+	bool is_big_endian = false;
 
 	if (args->options->objdump_path)
 		return -1;
@@ -484,8 +526,10 @@ int symbol__disassemble_capstone_powerpc(const char *filename __maybe_unused,
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
2.54.0.929.g9b7fa37559-goog

