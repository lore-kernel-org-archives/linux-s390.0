Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF493A783D
	for <linux-s390@vger.kernel.org>; Tue,  2 Jun 2026 06:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780381522; cv=none; b=atwdvr/tj+qd4rfEhmOmyiZu0AlSvk+TQaZUmDy59U4zJOKBSBvq+xmHxvHz9d0auH4Xh9NThstMoE2eH9vh4cknKZYyk4VZ4CzIpKDFqS6dQocs+Zr+5xLqr43h7EdkUyqFtOspaUunnVzvyaV8IROC3fE4NjFIQ81P8ZXysaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780381522; c=relaxed/simple;
	bh=v2jPVgU7NcmbpJgeZh9blErLQKEVvFwnJwLEwzd0nZY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iK8Zbis5IWXnLV5HLx5BDS6WVjcxco84CgtpeneE5YfMKWv4rnoOxedwqPU2b9ZM+Kcx/higODvoxJI+TGTifGlYBuQSgf8n4Uo2xWvAOncf8BI71dgnL45jFfdUQrUcqrG4VUv+a9oucmDS7PPnaB7FbaC88hkyRSbk7ZomAbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QCdQqVSm; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QCdQqVSm"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304b8d0ee63so8931200eec.0
        for <linux-s390@vger.kernel.org>; Mon, 01 Jun 2026 23:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780381519; x=1780986319; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GulsNcduO8h3GBAwGX8U7EGxU2yFd28SwAXlNyW06wQ=;
        b=QCdQqVSm70jA43AKH9Il+6QwSvlj+w3N4CYX792i6EKDFsH6/Umr2ZVoN4qV3eQKT+
         pZoIa/wlI0WqbowabZwXkBu1ofoRw1VEsUkO2AByVm+2OggasUMoDJAdP4IJZo4tBg0x
         3JsLX0GyF4FLhK8REZvXGchWSD8DXj8RuWCqsjjh+YmXEc/9B4++WC39UPSikSXZ428/
         TMqgN5/8fM1iidnjay6CI6LgKZaIgE6Uwdvj+OUaA3jGetVt8XLagBoX/onyIG/PyEn4
         oli3z4GZpBQGP/s5c8DaV09A07o8mUQbuscwbF+z1og/Rs1X15F+JUEq1vmH5AM6VsdX
         Wf2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780381519; x=1780986319;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GulsNcduO8h3GBAwGX8U7EGxU2yFd28SwAXlNyW06wQ=;
        b=iWuIGIqKteDOt4z7camD2Jx0fk3b+3Iwbr58nycAg2I0ZVQLjM/RSqoUzZcTZumixD
         YT0BSqX5PaEF47yXpZI2O5IhvsEw1HjI6izriJum7XsGVv/DPuoFYbXvJln+dGQ37KBD
         Pg4wDxSNHLAJQtZlYGHQmGu2KGD8LTxL9/VapO157M3ma6pSpi27xYcEOxN9GVmqZo1o
         uj89nSIQlBpsGkIOdf7ch+idhpGHH0jUbBAvL7J3iaW0djlwpEnzAS/Zhl3MJVdXeN0Y
         N8W8esFh/GA68LmCoQmNVfNjCzgA2knB3p4pN9Ku/PDAYGK0ujjhOopdonV6A+GhpUd/
         YizA==
X-Forwarded-Encrypted: i=1; AFNElJ/w127F3VV0hgTpl1SIQbGsdeXmTq3ZBvYDZ+H79AU4W5FhkF5BVQ0OOq7DZYeki53Jj8MSm2Sp9M3x@vger.kernel.org
X-Gm-Message-State: AOJu0Ywid1gVLVaLAuMmQ7VUR8Zm6ny67N35BR4v8KovOBAC+WD948G2
	VLBm5m4mq3aNullC0Shq5MHA0n72OdOEnJjtipd6rb1wNAwSdIVrcDMrKP2M4xhEZ7bTU2eDPqv
	5hJpKePOLSg==
X-Received: from dycui22.prod.google.com ([2002:a05:693c:6016:b0:304:ddaa:acd5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e683:b0:304:d8e2:3c4d
 with SMTP id 5a478bee46e88-304fa61a258mr5764207eec.25.1780381519005; Mon, 01
 Jun 2026 23:25:19 -0700 (PDT)
Date: Mon,  1 Jun 2026 23:24:36 -0700
In-Reply-To: <20260602062452.2583619-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601065407.1597927-1-irogers@google.com> <20260602062452.2583619-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602062452.2583619-5-irogers@google.com>
Subject: [PATCH v11 04/19] perf capstone: Determine architecture from e_machine
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

