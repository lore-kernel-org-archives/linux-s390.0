Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052EE3019DC
	for <linux-s390@vger.kernel.org>; Sat,  2 May 2026 06:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777705200; cv=none; b=ZjvU/3+FKUFCvrBMsmp3kc7NrrKfAtB/u3Masv5QETztlZO5ROLy6SqbSGp5wsC4qT3d4H2RY98eATavCjAP72S93Oc0DwS/cLdUhLGfdjGVECYx9v4oy2rB0dOgl9YpiB8Y8rDcSEGmlygKqaNKIedkLUrIUYRsI9JdU4l6I8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777705200; c=relaxed/simple;
	bh=Ih3Q2eYIF9wFvgMWGsJmW93qVjkDo2mDZ0DTIg/LtdY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WxG49fariESHXMSqC69f3CoCPNNQ2WgpPrMrr/qCwQrh+MoG8+A54oLqAIgpVrUfW+HYZnOHTE01zDKu33ZxXNwyTWQlOjoFs98+IuR4WRr7esRP4DEwuqiYtvJsrFoIOliWzlzGbI7LH++JefD9Ntp0H3i23IDPbKU9KFy7OCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fTLbsZ0Z; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fTLbsZ0Z"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12df9e440d3so2131341c88.0
        for <linux-s390@vger.kernel.org>; Fri, 01 May 2026 23:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777705198; x=1778309998; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cGghryugrj5pfe+2ckovcxGulzRiLQqYShkhaYL4998=;
        b=fTLbsZ0ZHh5blRtAAfbeDJX2wTg8RlQ9VpLhwdCP4OH88YrDWtFy7TXRKp7AcWMX4I
         /WFhtRYljochEDAQc0o/wjjwz7uEtwhwLwincjrj4GJdAxJtPuCBCylbmBKwDeKQTuxv
         zKAYDRNPoitymZvU9mxB+2aPL/VVYyi2gWydQ1b+k4N9xKJ3wAvVS55cuWH+MpjgZXG5
         KF8hlQgGiE/9TKpYYoDH69JWE4MVQZ4NZML/lTCWW7/nFnlNcZDhRWI3RU2cvODhzDym
         /E+7XCjJ8OTb3GI9EBO2QdHOUr95hyZAqG0oMQekfPoBoUjRpcHlQzfB4ei06lN0l+d5
         NrKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777705198; x=1778309998;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cGghryugrj5pfe+2ckovcxGulzRiLQqYShkhaYL4998=;
        b=bSWdme2psCnDf++zjK5bUTk5QQqeYAWC2cRkpXBIBLERknfuBEdW8qieoqfs/mu7Dh
         56LGeT/iYfIVMiwd9hOMW41ehm5jrpN8ySIq2tgmcgLwDwY9/kqqNuYtqsCArBuKyqoY
         qpKCBNfYGqWpJeE0xCsYSuszWES6k90no/auNL0YOi4kGD1XqL0jetj8Y5lwmVJfDw7w
         52v+XN0nY0wPi361D80IGNCSV6m05Ejovqf4wbk0jgsipLaI2o2VRPvzkzOpRQweDPOI
         GPVLRVSHFYe/YYvweM+N0Xj7EVX5x34i+affrVVgY2RhDsa5e6PNhGBbWOgeq+MvgC6p
         hTBw==
X-Forwarded-Encrypted: i=1; AFNElJ/0JCmQlI+1OIPi38zLL49OWnxufZQNmUGtfKDhqzIMINpqyeqssHWn0PdhFjnbXkj/GT1NXU12bFPZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Z/RoItSJnx0g7FSFlgQsMzHv2n3SlBaZev6MfAn2TF68mOFP
	nyzmvmzFkDL2NpzpR1+H7+5znx9+8AtYVLgClqJuUPqtc9LFnlbjVtLmvC5s7lcc+kxYk1G4T3O
	rCl7ZC5WsHw==
X-Received: from dlbto8.prod.google.com ([2002:a05:7022:3b08:b0:12c:1fa5:ab7c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:608:b0:12b:f8f0:80c7
 with SMTP id a92af1059eb24-12dfd82435emr682325c88.21.1777705198041; Fri, 01
 May 2026 23:59:58 -0700 (PDT)
Date: Fri,  1 May 2026 23:59:21 -0700
In-Reply-To: <20260502065935.291960-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409230620.4176210-2-irogers@google.com> <20260502065935.291960-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260502065935.291960-4-irogers@google.com>
Subject: [PATCH v8 03/17] perf capstone: Determine architecture from e_machine
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
 tools/perf/util/capstone.c | 115 +++++++++++++++++++++++++------------
 1 file changed, 79 insertions(+), 36 deletions(-)

diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
index 25cf6e15ec27..e6226b751c36 100644
--- a/tools/perf/util/capstone.c
+++ b/tools/perf/util/capstone.c
@@ -16,6 +16,7 @@
 #include <fcntl.h>
 #include <inttypes.h>
 #include <string.h>
+#include <elf.h>
 
 #include <capstone/capstone.h>
 
@@ -137,37 +138,74 @@ static enum cs_err perf_cs_close(csh *handle)
 #endif
 }
 
-static int capstone_init(struct machine *machine, csh *cs_handle, bool is64,
-			 bool disassembler_style)
+static bool e_machine_to_capstone(uint16_t e_machine, bool is64,
+				  enum cs_arch *arch, enum cs_mode *mode)
+{
+        switch (e_machine) {
+        case EM_X86_64:
+		*arch = CS_ARCH_X86;
+		*mode = CS_MODE_64;
+		return true;
+        case EM_386:
+		*arch = CS_ARCH_X86;
+		*mode = CS_MODE_32;
+		return true;
+        case EM_AARCH64:
+		*arch = CS_ARCH_ARM64;
+		*mode = CS_MODE_ARM;
+		return true;
+        case EM_ARM:
+		*arch = CS_ARCH_ARM;
+		*mode = CS_MODE_ARM | CS_MODE_V8;
+		return true;
+        case EM_S390:
+		*arch = CS_ARCH_SYSZ;
+		*mode = CS_MODE_BIG_ENDIAN;
+		return true;
+        case EM_MIPS:
+		*arch = CS_ARCH_MIPS;
+		*mode = is64 ? CS_MODE_MIPS64 : CS_MODE_MIPS32;
+		*mode |= CS_MODE_BIG_ENDIAN;
+		return true;
+        case EM_PPC:
+		*arch = CS_ARCH_PPC;
+		*mode = CS_MODE_BIG_ENDIAN | CS_MODE_32;
+		return true;
+        case EM_PPC64:
+		*arch = CS_ARCH_PPC;
+		*mode = CS_MODE_BIG_ENDIAN | CS_MODE_64;
+		return true;
+        case EM_SPARC:
+		*arch = CS_ARCH_SPARC;
+		*mode = CS_MODE_BIG_ENDIAN | CS_MODE_32;
+		return true;
+        case EM_SPARCV9:
+		*arch = CS_ARCH_SPARC;
+		*mode = CS_MODE_BIG_ENDIAN | CS_MODE_V9 | CS_MODE_64;
+		return true;
+        case EM_RISCV:
+		*arch = CS_ARCH_RISCV;
+		*mode = is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32;
+		return true;
+        default:
+		return false;
+        }
+}
+
+static int capstone_init(uint16_t e_machine, csh *cs_handle, bool is64, bool disassembler_style)
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
+	if (!e_machine_to_capstone(e_machine, is64, &arch, &mode))
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
@@ -212,28 +250,31 @@ static size_t print_insn_x86(struct thread *thread, u8 cpumode, struct cs_insn *
 }
 
 
-ssize_t capstone__fprintf_insn_asm(struct machine *machine __maybe_unused,
-				   struct thread *thread __maybe_unused,
-				   u8 cpumode __maybe_unused, bool is64bit __maybe_unused,
-				   const uint8_t *code __maybe_unused,
-				   size_t code_size __maybe_unused,
-				   uint64_t ip __maybe_unused, int *lenp __maybe_unused,
-				   int print_opts __maybe_unused, FILE *fp __maybe_unused)
+ssize_t capstone__fprintf_insn_asm(struct machine *machine,
+				   struct thread *thread,
+				   u8 cpumode,
+				   bool is64bit,
+				   const uint8_t *code,
+				   size_t code_size,
+				   uint64_t ip, int *lenp,
+				   int print_opts,
+				   FILE *fp)
 {
 	size_t printed;
 	struct cs_insn *insn;
 	csh cs_handle;
 	size_t count;
+	uint16_t e_machine = thread__e_machine(thread, machine, /*e_flags=*/NULL);
 	int ret;
 
 	/* TODO: Try to initiate capstone only once but need a proper place. */
-	ret = capstone_init(machine, &cs_handle, is64bit, true);
+	ret = capstone_init(e_machine, &cs_handle, is64bit, /*disassembler_style=*/true);
 	if (ret < 0)
 		return ret;
 
 	count = perf_cs_disasm(cs_handle, code, code_size, ip, 1, &insn);
 	if (count > 0) {
-		if (machine__normalized_is(machine, "x86"))
+		if (e_machine == EM_X86_64 || e_machine == EM_386)
 			printed = print_insn_x86(thread, cpumode, &insn[0], print_opts, fp);
 		else
 			printed = fprintf(fp, "%s %s", insn[0].mnemonic, insn[0].op_str);
@@ -322,9 +363,9 @@ static int find_file_offset(u64 start, u64 len, u64 pgoff, void *arg)
 	return 0;
 }
 
-int symbol__disassemble_capstone(const char *filename __maybe_unused,
-				 struct symbol *sym __maybe_unused,
-				 struct annotate_args *args __maybe_unused)
+int symbol__disassemble_capstone(const char *filename,
+				 struct symbol *sym,
+				 struct annotate_args *args)
 {
 	struct annotation *notes = symbol__annotation(sym);
 	struct map *map = args->ms->map;
@@ -344,6 +385,7 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
 	char disasm_buf[512];
 	struct disasm_line *dl;
 	bool disassembler_style = false;
+	uint16_t e_machine;
 
 	if (args->options->objdump_path)
 		return -1;
@@ -373,8 +415,8 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
 	    !strcmp(args->options->disassembler_style, "att"))
 		disassembler_style = true;
 
-	if (capstone_init(maps__machine(thread__maps(args->ms->thread)), &handle, is_64bit,
-			  disassembler_style) < 0)
+	e_machine = thread__e_machine(args->ms->thread, /*machine=*/NULL, /*e_flags=*/NULL);
+	if (capstone_init(e_machine, &handle, is_64bit, disassembler_style) < 0)
 		goto err;
 
 	needs_cs_close = true;
@@ -466,6 +508,7 @@ int symbol__disassemble_capstone_powerpc(const char *filename __maybe_unused,
 	struct disasm_line *dl;
 	u32 *line;
 	bool disassembler_style = false;
+	uint16_t e_machine;
 
 	if (args->options->objdump_path)
 		return -1;
@@ -484,8 +527,8 @@ int symbol__disassemble_capstone_powerpc(const char *filename __maybe_unused,
 	    !strcmp(args->options->disassembler_style, "att"))
 		disassembler_style = true;
 
-	if (capstone_init(maps__machine(thread__maps(args->ms->thread)), &handle, is_64bit,
-			  disassembler_style) < 0)
+	e_machine = thread__e_machine(args->ms->thread, /*machine=*/NULL, /*e_flags=*/NULL);
+	if (capstone_init(e_machine, &handle, is_64bit, disassembler_style) < 0)
 		goto err;
 
 	needs_cs_close = true;
-- 
2.54.0.545.g6539524ca2-goog

