Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFFE7494
	for <linux-s390@vger.kernel.org>; Mon, 27 Oct 2025 15:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761578581; cv=none; b=TNTKkXBdCe92cBvPH7eVTlDpCVa6sD2k6wVHn49KpHHcM/X9Jay6diRmVUBooE+CTkghybtoWOMQW2k0hw3ys0bPM1sidobfV91QME73q8rCuT+IqJ+yZtXrv9V3etykOVGaLnwANFjPFJRRLJOeWK9Fjvv2Mo65AosGnIemvNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761578581; c=relaxed/simple;
	bh=CL9LS5SQBrNhyOzXcZ/NXi1G5zR8QkmQybZr9cOP9k4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mv8YHqaiaz402jPB/Jsi4SFjiwR3LyLaZEfZKt8psEVVOImpTboMEfm0w4dO4z00ic2HatIVAy8oaiIfVQlxalmvJs2/SpogQEI3GFBL5RNK2uHZyNXNMaG+LzM+/pN41reRF7hF9g9oEJfDwL6WafWDPRihrOtxSL3afF9Zdwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hcyc4kZC; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hcyc4kZC"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-26e68904f0eso51990485ad.0
        for <linux-s390@vger.kernel.org>; Mon, 27 Oct 2025 08:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761578578; x=1762183378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aHOXCoUY12NaCbVox/Fqc7mibSLz8fzukDEwavmOJrA=;
        b=hcyc4kZCUJXd7GLAcEIUwCEdsx086B+CdUSZL/gEL4MqQMHhx25MgRZDd2V51jkphL
         2s/lnBrAUtPJ1tzRtZolyVtyfpVHMe+rVvJAKp4VpHJA1SdzYVmjrFt+duz6oodAu9lU
         QJab81lEDPJwWLdCspER4sCSPjFMo6oBhvShA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761578578; x=1762183378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aHOXCoUY12NaCbVox/Fqc7mibSLz8fzukDEwavmOJrA=;
        b=wTBfispsY+leUyD2224MJSyN1yJDsNWWKwcqrhVpthlbKb06YB1j/lidcA0UNKdsIT
         MK1OOhIXfdchTBITuNE1YjyE8qdJ1S/r4WyJxjuCK64jRjA1OPYLZOwj1y+YmvwZYQDh
         1EKJrIdcnJvB9XN3d6Yau4S3Dk3P1KdjqDIv03uT9QnD9lifSI/J2woJzzaceBnC4wjD
         sK1BEnu9KRQRCPOGFF98jKmhYhOdlGVTFg1ZSVppfrBDD18MGGnkujBtnrVVICKz4L1J
         JVFNNKpcuIcavo1IAoNBJ4JE8OR5IwjBXBP34JgdK+zkGLmq8gSFMgHTgBhPfBrM/O0/
         XiNw==
X-Forwarded-Encrypted: i=1; AJvYcCXaYjHtZLUup0e8gm59WlbGVPrcS+KsqDxlqSLW/9PSYZwUCpPmBmp+27UXPKqflm/vg0jSoPo0BCLa@vger.kernel.org
X-Gm-Message-State: AOJu0YzoxfSu8+Cej/b5oujfHSu4wHFYLrSY5iFUIfSNkIeblXwxlclI
	JqBAlODoeOZgSMOg5KErf7x9WavkYVY6EMmj9/1Nw0Uy+55OSCLektzvpCublAfeuw==
X-Gm-Gg: ASbGncsPJCf5AgbTl/0EH9muHEi8WrMDEqePspZnC0NsWf5BmsIx8JDj600zF72+g+k
	M4nATWQugDG2xWaF5OYGzrHhNJmJZi7lz56LwN6XDdkswHTNbfeMqMNR+AQAK91btvpLZnwOCzA
	eDWzee5b30R+bQbfhj/wQSSHMVLLJY9qPPqUIRSir31P9kOse2/UI1gNdJsrJqZ1OY5hT4XMcmH
	hUQq2WnCNPUHCqXXq+0O44ZwfwZBJOm+ZiNr5Jo3nKmX/aQ0FXRIw7FySXVQUZXtShTBX2Zp+F8
	QkcFnB+aroCOtwHqj3Fe72XvoYTswURRYApaC1iT6UUhVv86Atp46xYg14/8yoMvuFIFeyShbCB
	mZ7FQ9+JYhsdvrH0cQzon3+lRcLNvrpYy95+/CzVvne+gSFWfoDQrllnI5erRcTYOQU0PwpPRx+
	vKk3KdxgSF9MKAqZrjnzKtmzyMINgKIdwc/osCHU8/giezJxFAoYFk3S1p7Pk=
X-Google-Smtp-Source: AGHT+IFaaaXqvB5oJlw60jRrwhW3kz/s1caZI8mLNwKTsc/fRuGvUAaSMIFEJCWf9X7LHfwjt3EwYg==
X-Received: by 2002:a17:903:1c2:b0:28e:7841:d437 with SMTP id d9443c01a7336-294cb51090amr3108285ad.38.1761578578157;
        Mon, 27 Oct 2025 08:22:58 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:b36f:415b:67d1:c1e2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0987fsm84884795ad.25.2025.10.27.08.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 08:22:56 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: linux-kernel@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-s390 <linux-s390@vger.kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Andrew Chant <achant@google.com>,
	Douglas Anderson <dianders@chromium.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Brian Gerst <brgerst@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Francesco Valla <francesco@valla.it>,
	Guo Weikang <guoweikang.kernel@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Jeff Xu <jeffxu@chromium.org>,
	Kees Cook <kees@kernel.org>,
	Lillian Berry <lillian@star-ark.net>,
	Masahiro Yamada <masahiroy@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v4] init/main.c: Wrap long kernel cmdline when printing to logs
Date: Mon, 27 Oct 2025 08:22:13 -0700
Message-ID: <20251027082204.v4.1.I095f1e2c6c27f9f4de0b4841f725f356c643a13f@changeid>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel cmdline length is allowed to be longer than what printk can
handle. When this happens the cmdline that's printed to the kernel
ring buffer at bootup is cutoff and some kernel cmdline options are
"hidden" from the logs. This undercuts the usefulness of the log
message.

Specifically, grepping for COMMAND_LINE_SIZE shows that 2048 is common
and some architectures even define it as 4096. s390 allows a
CONFIG-based maximum up to 1MB (though it's not expected that anyone
will go over the default max of 4096 [1]).

The maximum message pr_notice() seems to be able to handle (based on
experiment) is 1021 characters. This appears to be based on the
current value of PRINTKRB_RECORD_MAX as 1024 and the fact that
pr_notice() spends 2 characters on the loglevel prefix and we have a
'\n' at the end.

While it would be possible to increase the limits of printk() (and
therefore pr_notice()) somewhat, it doesn't appear possible to
increase it enough to fully include a 2048-character cmdline without
breaking userspace. Specifically on at least two tested userspaces
(ChromeOS plus the Debian-based distro I'm typing this message on) the
`dmesg` tool reads lines from `/dev/kmsg` in 2047-byte chunks. As per
`Documentation/ABI/testing/dev-kmsg`:

  Every read() from the opened device node receives one record
  of the kernel's printk buffer.
  ...
  Messages in the record ring buffer get overwritten as whole,
  there are never partial messages received by read().

We simply can't fit a 2048-byte cmdline plus the "Kernel command
line:" prefix plus info about time/log_level/etc in a 2047-byte read.

The above means that if we want to avoid the truncation we need to do
some type of wrapping of the cmdline when printing.

Add wrapping to the printout of the kernel command line. By default,
the wrapping is set to 1021 characters to avoid breaking anyone, but
allow wrapping to be set lower by a Kconfig knob
"CONFIG_CMDLINE_LOG_WRAP_IDEAL_LEN". Any tools that are correctly
parsing the cmdline today (because it is less than 1021 characters)
will see no difference in their behavior. The format of wrapped output
is designed to be matched by anyone using "grep" to search for the
cmdline and also to be easy for tools to handle. Anyone who is sure
their tools (if any) handle the wrapped format can choose a lower
wrapping value and have prettier output.

Setting CONFIG_CMDLINE_LOG_WRAP_IDEAL_LEN to 0 fully disables the
wrapping logic. This means that long command lines will be truncated
again, but this config could be set if command lines are expected to
be long and userspace is known not to handle parsing logs with the
wrapping.

Wrapping is based on spaces, ignoring quotes. All lines are prefixed
with "Kernel command line: " and lines that are not the last line have
a " \" suffix added to them. The prefix and suffix count towards the
line length for wrapping purposes. The ideal length will be exceeded
if no appropriate place to wrap is found.

The wrapping function added here is fairly generic and could be made a
library function (somewhat like print_hex_dump()) if it's needed
elsewhere in the kernel. However, having printk() directly incorporate
this wrapping would be unlikely to be a good idea since it would break
printouts into more than one record without any obvious common line
prefix to tie lines together. It would also be extra overhead when, in
general, kernel log message should simply be kept smaller than 1021
bytes. For some discussion on this topic, see responses to the v1
posting of this patch [2].

[1] https://lore.kernel.org/r/20251021131633.26700Dd6-hca@linux.ibm.com
[2] https://lore.kernel.org/r/CAD=FV=VNyt1zG_8pS64wgV8VkZWiWJymnZ-XCfkrfaAhhFSKcA@mail.gmail.com

Tested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
- v1 link: https://lore.kernel.org/r/20251019100605.1.I095f1e2c6c27f9f4de0b4841f725f356c643a13f@changeid
- v2 link: https://lore.kernel.org/r/20251021173939.v2.1.I095f1e2c6c27f9f4de0b4841f725f356c643a13f@changeid
- v3 link: https://lore.kernel.org/r/20251023113257.v3.1.I095f1e2c6c27f9f4de0b4841f725f356c643a13f@changeid

NOTE: I _didn't_ add any "max characters printed" to try to handle
someone on s390 having an absurdly long cmdline after the discussoin
in v1. If someone truly puts a giant cmdline then it will all be
printed out to dmesg. If this truly turns out to be a problem for
someone then it's easy to add a maximum at a later time.

I kept Paul's Tested-by from v3 to v4 since changes were very
minor. Hope this is OK.

Changes in v4:
- Mark print_kernel_cmdline() as __init.
- Use 0 instead of -1 to disable wrapping.
- If COMMAND_LINE_SIZE makes wrapping impossible then help compiler optimize.

Changes in v3:
- Allow setting config to -1 to disable wrapping.
- Handle case where prefix len >= wrap len, which just means wrap ASAP.
- Update Kconfig description to talk about -1 and be more detailed.

Changes in v2:
- Much longer commit message after discussion in v1.

 init/Kconfig | 18 ++++++++++
 init/main.c  | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 114 insertions(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index cab3ad28ca49..56a5dec1fdfc 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1512,6 +1512,24 @@ config BOOT_CONFIG_EMBED_FILE
 	  This bootconfig will be used if there is no initrd or no other
 	  bootconfig in the initrd.
 
+config CMDLINE_LOG_WRAP_IDEAL_LEN
+	int "Length to try to wrap the cmdline when logged at boot"
+	default 1021
+	range 0 1021
+	help
+	  At boot time, the kernel command line is logged to the console.
+	  The log message will start with the prefix "Kernel command line: ".
+	  The log message will attempt to be wrapped (split into multiple log
+	  messages) at spaces based on CMDLINE_LOG_WRAP_IDEAL_LEN characters.
+	  If wrapping happens, each log message will start with the prefix and
+	  all but the last message will end with " \". Messages may exceed the
+	  ideal length if a place to wrap isn't found before the specified
+	  number of characters.
+
+	  A value of 0 disables wrapping, though be warned that the maximum
+	  length of a log message (1021 characters) may cause the cmdline to
+	  be truncated.
+
 config INITRAMFS_PRESERVE_MTIME
 	bool "Preserve cpio archive mtimes in initramfs"
 	depends on BLK_DEV_INITRD
diff --git a/init/main.c b/init/main.c
index 07a3116811c5..b84818ad9685 100644
--- a/init/main.c
+++ b/init/main.c
@@ -906,6 +906,101 @@ static void __init early_numa_node_init(void)
 #endif
 }
 
+#define KERNEL_CMDLINE_PREFIX		"Kernel command line: "
+#define KERNEL_CMDLINE_PREFIX_LEN	(sizeof(KERNEL_CMDLINE_PREFIX) - 1)
+#define KERNEL_CMDLINE_CONTINUATION	" \\"
+#define KERNEL_CMDLINE_CONTINUATION_LEN	(sizeof(KERNEL_CMDLINE_CONTINUATION) - 1)
+
+#define MIN_CMDLINE_LOG_WRAP_IDEAL_LEN	(KERNEL_CMDLINE_PREFIX_LEN + \
+					 KERNEL_CMDLINE_CONTINUATION_LEN)
+#define CMDLINE_LOG_WRAP_IDEAL_LEN	(CONFIG_CMDLINE_LOG_WRAP_IDEAL_LEN > \
+					 MIN_CMDLINE_LOG_WRAP_IDEAL_LEN ? \
+					 CONFIG_CMDLINE_LOG_WRAP_IDEAL_LEN : \
+					 MIN_CMDLINE_LOG_WRAP_IDEAL_LEN)
+
+#define IDEAL_CMDLINE_LEN		(CMDLINE_LOG_WRAP_IDEAL_LEN - KERNEL_CMDLINE_PREFIX_LEN)
+#define IDEAL_CMDLINE_SPLIT_LEN		(IDEAL_CMDLINE_LEN - KERNEL_CMDLINE_CONTINUATION_LEN)
+
+/**
+ * print_kernel_cmdline() - Print the kernel cmdline with wrapping.
+ * @cmdline: The cmdline to print.
+ *
+ * Print the kernel command line, trying to wrap based on the Kconfig knob
+ * CONFIG_CMDLINE_LOG_WRAP_IDEAL_LEN.
+ *
+ * Wrapping is based on spaces, ignoring quotes. All lines are prefixed
+ * with "Kernel command line: " and lines that are not the last line have
+ * a " \" suffix added to them. The prefix and suffix count towards the
+ * line length for wrapping purposes. The ideal length will be exceeded
+ * if no appropriate place to wrap is found.
+ *
+ * Example output if CONFIG_CMDLINE_LOG_WRAP_IDEAL_LEN is 40:
+ *   Kernel command line: loglevel=7 \
+ *   Kernel command line: init=/sbin/init \
+ *   Kernel command line: root=PARTUUID=8c3efc1a-768b-6642-8d0c-89eb782f19f0/PARTNROFF=1 \
+ *   Kernel command line: rootwait ro \
+ *   Kernel command line: my_quoted_arg="The \
+ *   Kernel command line: quick brown fox \
+ *   Kernel command line: jumps over the \
+ *   Kernel command line: lazy dog."
+ */
+static void __init print_kernel_cmdline(const char *cmdline)
+{
+	size_t len;
+
+	/* Config option of 0 or anything longer than the max disables wrapping */
+	if (CONFIG_CMDLINE_LOG_WRAP_IDEAL_LEN == 0 ||
+	    IDEAL_CMDLINE_LEN >= COMMAND_LINE_SIZE - 1) {
+		pr_notice("%s%s\n", KERNEL_CMDLINE_PREFIX, cmdline);
+		return;
+	}
+
+	len = strlen(cmdline);
+	while (len > IDEAL_CMDLINE_LEN) {
+		const char *first_space;
+		const char *prev_cutoff;
+		const char *cutoff;
+		int to_print;
+		size_t used;
+
+		/* Find the last ' ' that wouldn't make the line too long */
+		prev_cutoff = NULL;
+		cutoff = cmdline;
+		while (true) {
+			cutoff = strchr(cutoff + 1, ' ');
+			if (!cutoff || cutoff - cmdline > IDEAL_CMDLINE_SPLIT_LEN)
+				break;
+			prev_cutoff = cutoff;
+		}
+		if (prev_cutoff)
+			cutoff = prev_cutoff;
+		else if (!cutoff)
+			break;
+
+		/* Find the beginning and end of the string of spaces */
+		first_space = cutoff;
+		while (first_space > cmdline && first_space[-1] == ' ')
+			first_space--;
+		to_print = first_space - cmdline;
+		while (*cutoff == ' ')
+			cutoff++;
+		used = cutoff - cmdline;
+
+		/* If the whole string is used, break and do the final printout */
+		if (len == used)
+			break;
+
+		if (to_print)
+			pr_notice("%s%.*s%s\n", KERNEL_CMDLINE_PREFIX,
+				  to_print, cmdline, KERNEL_CMDLINE_CONTINUATION);
+
+		len -= used;
+		cmdline += used;
+	}
+	if (len)
+		pr_notice("%s%s\n", KERNEL_CMDLINE_PREFIX, cmdline);
+}
+
 asmlinkage __visible __init __no_sanitize_address __noreturn __no_stack_protector
 void start_kernel(void)
 {
@@ -942,7 +1037,7 @@ void start_kernel(void)
 	early_numa_node_init();
 	boot_cpu_hotplug_init();
 
-	pr_notice("Kernel command line: %s\n", saved_command_line);
+	print_kernel_cmdline(saved_command_line);
 	/* parameters may set static keys */
 	parse_early_param();
 	after_dashes = parse_args("Booting kernel",
-- 
2.51.1.821.gb6fe4d2222-goog

