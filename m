Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6FD1411DE
	for <linux-s390@vger.kernel.org>; Wed, 22 Oct 2025 00:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761093679; cv=none; b=KiRZlKnYLQAasXb4mJHRQ22mX3PhMvza2iM4Y5DSzvKxdjw7paG+ItcunsL0sym4n6yp7xUv/Hp99jYeO/nMp9rFpbEQSWDcmKhGlo7iImeiGeOqKZqACYKW3jPucPM2jqiao+ps3/b/5Yfk8QcPZO0mfHF01lOo+2tVJ++fBcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761093679; c=relaxed/simple;
	bh=TyGxxPZmvW7pzQW51SpvPF4+tI/TQ5YOSadbcuPIfDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lrTUxR2+9jbShY9jODVGSeZCgvVq2InMjCGi3zKmJwPfI2MfK06ZYtrhwk5QkCwxy5RXNbv0D4+AA3CYPwDvRGwWeNjj13TzyX+vgKVgsz3DMmcXixKAcBFDOhWS/5B8HasWI9d2SuY3ec/n1nyaFZHB7/Pe4nFUyyy9m08FMAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AE876gno; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AE876gno"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-33067909400so4794277a91.2
        for <linux-s390@vger.kernel.org>; Tue, 21 Oct 2025 17:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761093677; x=1761698477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J6dfzjaiaVtqKR1q20BH9Mi7/4Fk6B7qT1IK5wGL940=;
        b=AE876gno77uV/wKEIIu3gLHaGI60Un2iv6M2GjHeCvmzvxJHF6X3mj2AkZZhKJzYqb
         e+jZKRAIXCoPZWFexno5z4iiOTOW4x6Faww9ngrFFWtAHdtw1L9xA6lwVFNEenZZASuu
         YFdCJ6+A6TBf6x1rCTUIAgV8akCTB1AYqSk5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761093677; x=1761698477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J6dfzjaiaVtqKR1q20BH9Mi7/4Fk6B7qT1IK5wGL940=;
        b=rBCN8s1dmBEzA6dGq9emDljszxLSVNe7wMcIYj5YNBPeLTjCHxeRvG6HfL9EauR2ja
         s+U4ATf1P6NxSzlML4bqq0yL+LI3W8fbhCj9AccEK4Pp6TrfYY6+goD3qIQhIglQ6TKD
         zkot3hPTVigbE6pZw265dvbwDbiVXorG0aR04OE37FshI7D4Yd8YTeZqVjQ9VVT4RKgt
         CaOyqqKhTbtBfnnwjPoyoYuEJD6aEkpBKceh7WWemkizIMYKqDWDKZ6fOvL0qWcE/xpC
         JNG+7oUTnqx7TJWqyfmSKQ9LD7YAMx2+d/qMENOoXfb9t3ZEOuBWharTO9PoSrKqi659
         FHRg==
X-Forwarded-Encrypted: i=1; AJvYcCWVwcj009NA9yrxcm2GqFBNPsKUbpuHD8qaNlwA711BOlGNK/fZUYtvUoEd6Hw2MP+5qlklDLOSNhtF@vger.kernel.org
X-Gm-Message-State: AOJu0YyfmlWqnI4uSrmDogDzTHKSkLh/mfyx8jnpshoAjUvYS/KFXFxp
	23ea+LPlTY171oZJDwU8lBjN+T/z/ohupLzBRWSdlfbUXMWXazjm/+exTzqww4D8ZQ==
X-Gm-Gg: ASbGncvNnm/yO7loGhTpDJyBI6TFOrYL2zdK0JfFDh7PQqXcUKHonpUJ3lX2PlI/d5H
	VybLCZGVHkMcZfMii3OI5aa/OZMGBkvwM+ONGUVxklGfXsvtc/CYLqA2oDwpDZTFsY0ArczYK4x
	V8sFd53LeSX29QIj6LrnCOIew1f9/PCm8WEoIJGP6hjvxIoZRoZfstSqz6cbHWqonSiMZA/5yTN
	3RPSt8lwpjI/qn+aMPR93brojIzaWve8wDDqywVDYsbe01vtK+g3ZY5Je/XzkJyKvQ4tH1w+8ds
	x09UE1yn9rpPaPoaN/w3QzBDgYvHFL76rz8l43YDpCT1kyQUBP+LRFF3WBkKH5Mm8ofL3+lS8dQ
	KIyvRvoLl0cy4LD6vOgGBpocAQZQuED9MDmD4hixmaJz2a8uNq+bn3A6t4LidYdTCCsgFXXr2r4
	O5YHThkFCuq73+ndP5PiyCIuN6KJfvRjLGywqDYM2UQ3PydVdRGsSI1x8+iHmmHnw+qRyAIg==
X-Google-Smtp-Source: AGHT+IG7+QbrZey9RClgWh7UPMb8t6jNRdh/AFiPRfWiyRY8UfhUqIXJFg0hA4yGu9np4R40oShdYA==
X-Received: by 2002:a17:90b:2d8f:b0:32b:cafc:e339 with SMTP id 98e67ed59e1d1-33bcf9551e5mr20563152a91.36.1761093676997;
        Tue, 21 Oct 2025 17:41:16 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:3ee0:9b5f:66d7:dd23])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b33c7asm11600168a12.21.2025.10.21.17.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 17:41:16 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-s390 <linux-s390@vger.kernel.org>,
	Andrew Chant <achant@google.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Douglas Anderson <dianders@chromium.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Brian Gerst <brgerst@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Francesco Valla <francesco@valla.it>,
	Guo Weikang <guoweikang.kernel@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Jeff Xu <jeffxu@chromium.org>,
	Kees Cook <kees@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Subject: [PATCH v2] init/main.c: Wrap long kernel cmdline when printing to logs
Date: Tue, 21 Oct 2025 17:39:48 -0700
Message-ID: <20251021173939.v2.1.I095f1e2c6c27f9f4de0b4841f725f356c643a13f@changeid>
X-Mailer: git-send-email 2.51.0.915.g61a8936c21-goog
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

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
v1 link: https://lore.kernel.org/r/20251019100605.1.I095f1e2c6c27f9f4de0b4841f725f356c643a13f@changeid

NOTE: I _didn't_ add any "max characters printed" in v2 to try to
handle someone on s390 having an absurdly long cmdline after the
discussoin in v1. If someone truly puts a giant cmdline then it will
all be printed out to dmesg. If this truly turns out to be a problem
for someone then it's easy to add a maximum at a later time.

Changes in v2:
- Much longer commit message after discussion in v1.

 init/Kconfig | 10 +++++++
 init/main.c  | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index cab3ad28ca49..905b2ece4127 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1512,6 +1512,16 @@ config BOOT_CONFIG_EMBED_FILE
 	  This bootconfig will be used if there is no initrd or no other
 	  bootconfig in the initrd.
 
+config CMDLINE_LOG_WRAP_IDEAL_LEN
+	int "Length to try to wrap the cmdline when logged at boot"
+	default 1021
+	range 40 1021
+	help
+	  At boot time, the kernel command line is logged to the console.
+	  It will attempt to be wrapped at this many characters. If there
+	  are more than this many non-space characters in a row, log lines
+	  may exceed this ideal maximum length.
+
 config INITRAMFS_PRESERVE_MTIME
 	bool "Preserve cpio archive mtimes in initramfs"
 	depends on BLK_DEV_INITRD
diff --git a/init/main.c b/init/main.c
index 07a3116811c5..0adc1575a2cb 100644
--- a/init/main.c
+++ b/init/main.c
@@ -906,6 +906,87 @@ static void __init early_numa_node_init(void)
 #endif
 }
 
+#define KERNEL_CMDLINE_PREFIX		"Kernel command line: "
+#define KERNEL_CMDLINE_PREFIX_LEN	(sizeof(KERNEL_CMDLINE_PREFIX) - 1)
+#define KERNEL_CMDLINE_CONTINUATION	" \\"
+#define KERNEL_CMDLINE_CONTINUATION_LEN	(sizeof(KERNEL_CMDLINE_CONTINUATION) - 1)
+
+#define IDEAL_CMDLINE_LEN		(CONFIG_CMDLINE_LOG_WRAP_IDEAL_LEN - \
+					 KERNEL_CMDLINE_PREFIX_LEN)
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
+static void print_kernel_cmdline(const char *cmdline)
+{
+	size_t len = strlen(cmdline);
+
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
@@ -942,7 +1023,7 @@ void start_kernel(void)
 	early_numa_node_init();
 	boot_cpu_hotplug_init();
 
-	pr_notice("Kernel command line: %s\n", saved_command_line);
+	print_kernel_cmdline(saved_command_line);
 	/* parameters may set static keys */
 	parse_early_param();
 	after_dashes = parse_args("Booting kernel",
-- 
2.51.0.915.g61a8936c21-goog

