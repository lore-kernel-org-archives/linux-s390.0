Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795691722;
	b=Y1hFcKC63Qe1y+dSDlE1Qaznqs05WTBPfyiwLcc9GC93kxT9yMBstHnVN3eXxRWZXw0i
	 h4KuNIvdk1p/Pgn4DvxAwZssj4QBrhQIM3rjPsJngw8pgjtAS4heD2t8wVwYnReRWgIqq
	 aCUvJBm9pUqMcRziuzHNT2JGiFv9aNZ3mZFrRzL21QESIfVMiDvDPxIcQEC046q0ofeZ8
	 uP6jyFnGHT2o1OZe2snS3zGGLULlTVW8J+QQu4YzvKNKTyh2JkwMR7wzoFs/aRUHFNk44
	 w6rXiwxoUvrY+GGE+81m7NPO6cNXNHitxkRxSsho9zIQtJw4Ny9w0daw4qBW0pNn6ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691722;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=zImSfvTk7Ce9C0Ntm689zz11A7MeuyzdnAnXV7c96Hs=;
	b=w8Z1VWV0KTNPt+GSF6x+RRubiIDHelHdqZA69y6JKxh6kwqZ+0ITBqN7pTHTeOw7Myub
	 O4ePaiDd/TlcyWR5dzzxgSddq7cin8X8Ys80ZltjWaWuR5kVvtizxsyzPsOyPDG2EqiBX
	 h1jooR0VpiPxk5K6/YeZOLVQV8ibDguwz7uUeze8bWXXvWwNyN8XAaRzoFUNKLmkFXURG
	 GMpkzAFNFROGO7EBLqsIsjOt7OjJpWFA5+Yqjwrhb9LSyOto+xoFRZ2R0Z8dIcCts/tbM
	 sLUFt0F/JQdkW6Um40NhPTzpKkns5A5mnVxMSxq4soIRB2nm7fycbZSPjp4XHX6RyJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k3kFIR10;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654A8606A31E;
	Thu, 26 Nov 2026 11:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k3kFIR10
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FCDB1F00AE3;
	Thu, 26 Nov 2026 11:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691722;
	bh=zImSfvTk7Ce9C0Ntm689zz11A7MeuyzdnAnXV7c96Hs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=k3kFIR107EfL7OCOXCU8Gw8+wFHgYeB6pwLpvAtrtxNruSbP+IxmvekCmPdAtQpU6
	 UY9gwt+R1jj/XLJxRSkgFV/NN1dqYd2vaEiNbba2VGjRRqrndAy3W3NDIYMGpwGJdL
	 5I5xoLA6NN9oPGIT+cll+4qCT2QAsDrYc+8BocCiyQFLGSboxGfTEYTroUEdlDxo+c
	 GWTUcL/DyD6jX5uwq92MnSCE+qN75XIupuUympUcKEE9nsukylR8tAJqmagsFaNpi4
	 wqNpEf6O3v9v4sAEU0M1bRVvAdcO5ESPqGmgBJIygD3v50tp7Tk1xNsDGMbHsOcixL
	 hxaqNlHeGhMdg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:18 +0200
Subject: [PATCH RFC v2 05/54] s390/boot: treat dashes and underscores alike
 in parameter names
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-generic-set-memory-v0-1-v2-5-723f1e33c3d8@kernel.org>
References: <20261126-generic-set-memory-v0-1-v2-0-723f1e33c3d8@kernel.org>
In-Reply-To: <20261126-generic-set-memory-v0-1-v2-0-723f1e33c3d8@kernel.org>
To: linux-mm@kvack.org
Cc: =?utf-8?q?Adrian_Barna=C5=9B?= <abarnas@google.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Borislav Petkov <bp@alien8.de>, Brendan Jackman <brendan.jackman@linux.dev>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 David Hildenbrand <david@kernel.org>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Ingo Molnar <mingo@kernel.org>, Kevin Brodsky <kevin.brodsky@arm.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, Michal Hocko <mhocko@suse.com>, 
 Mike Rapoport <rppt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Paul Walmsley <pjw@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Russell King <linux@armlinux.org.uk>, 
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, x86@kernel.org
X-Mailer: b4 0.16.1-dev

Dashes and underscores are equivalent in the names of kernel parameters,
and the kernel compares the names with parameq(). The decompressor uses
strcmp(), so it ignores "relocate-lowcore" or "prot-virt=1".

Compare the names like parameq() does.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/s390/boot/ipl_parm.c | 51 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 16 deletions(-)

diff --git a/arch/s390/boot/ipl_parm.c b/arch/s390/boot/ipl_parm.c
index ed28ea2fc1d1..ac4cf1ced71d 100644
--- a/arch/s390/boot/ipl_parm.c
+++ b/arch/s390/boot/ipl_parm.c
@@ -255,6 +255,25 @@ static void modify_fac_list(char *str)
 	check_cleared_facilities();
 }
 
+static char dash2underscore(char c)
+{
+	if (c == '-')
+		return '_';
+	return c;
+}
+
+/* Dashes and underscores are equivalent in parameter names */
+static bool parameq(const char *a, const char *b)
+{
+	size_t i, n = strlen(a) + 1;
+
+	for (i = 0; i < n; i++) {
+		if (dash2underscore(a[i]) != dash2underscore(b[i]))
+			return false;
+	}
+	return true;
+}
+
 void parse_boot_command_line(void)
 {
 	char *param, *val;
@@ -272,15 +291,15 @@ void parse_boot_command_line(void)
 		if (!val && !strcmp(param, "--"))
 			break;
 
-		if (!strcmp(param, "mem") && val)
+		if (parameq(param, "mem") && val)
 			memory_limit = round_down(memparse(val, NULL), PAGE_SIZE);
 
-		if (!strcmp(param, "vmalloc") && val) {
+		if (parameq(param, "vmalloc") && val) {
 			vmalloc_size = round_up(memparse(val, NULL), _SEGMENT_SIZE);
 			vmalloc_size_set = 1;
 		}
 
-		if (!strcmp(param, "dfltcc") && val) {
+		if (parameq(param, "dfltcc") && val) {
 			if (!strcmp(val, "off"))
 				zlib_dfltcc_support = ZLIB_DFLTCC_DISABLED;
 			else if (!strcmp(val, "on"))
@@ -293,49 +312,49 @@ void parse_boot_command_line(void)
 				zlib_dfltcc_support = ZLIB_DFLTCC_FULL_DEBUG;
 		}
 
-		if (!strcmp(param, "facilities") && val)
+		if (parameq(param, "facilities") && val)
 			modify_fac_list(val);
 
-		if (!strcmp(param, "debug-alternative"))
+		if (parameq(param, "debug-alternative"))
 			alt_debug_setup(val);
 
-		if (!strcmp(param, "nokaslr"))
+		if (parameq(param, "nokaslr"))
 			__kaslr_enabled = 0;
 
-		if (!strcmp(param, "cmma")) {
+		if (parameq(param, "cmma")) {
 			rc = kstrtobool(val, &enabled);
 			if (!rc && !enabled)
 				cmma_flag = 0;
 		}
 
 #ifdef CONFIG_STACKPROTECTOR
-		if (!strcmp(param, "debug_stackprotector"))
+		if (parameq(param, "debug_stackprotector"))
 			stack_protector_debug = 1;
 #endif
 
 #if IS_ENABLED(CONFIG_KVM)
-		if (!strcmp(param, "prot_virt")) {
+		if (parameq(param, "prot_virt")) {
 			rc = kstrtobool(val, &enabled);
 			if (!rc && enabled)
 				prot_virt_host = 1;
 		}
 #endif
-		if (!strcmp(param, "relocate_lowcore") && test_facility(193))
+		if (parameq(param, "relocate_lowcore") && test_facility(193))
 			set_machine_feature(MFEATURE_LOWCORE);
-		if (!strcmp(param, "earlyprintk"))
+		if (parameq(param, "earlyprintk"))
 			boot_earlyprintk = true;
-		if (!strcmp(param, "debug"))
+		if (parameq(param, "debug"))
 			boot_console_loglevel = CONSOLE_LOGLEVEL_DEBUG;
-		if (!strcmp(param, "bootdebug")) {
+		if (parameq(param, "bootdebug")) {
 			bootdebug = true;
 			if (val)
 				strscpy(bootdebug_filter, val);
 		}
-		if (!strcmp(param, "quiet"))
+		if (parameq(param, "quiet"))
 			boot_console_loglevel = CONSOLE_LOGLEVEL_QUIET;
-		if (!strcmp(param, "ignore_loglevel"))
+		if (parameq(param, "ignore_loglevel"))
 			boot_ignore_loglevel = true;
-		if (!strcmp(param, "loglevel")) {
+		if (parameq(param, "loglevel")) {
 			boot_console_loglevel = simple_strtoull(val, NULL, 10);
 			if (boot_console_loglevel < CONSOLE_LOGLEVEL_MIN)
 				boot_console_loglevel = CONSOLE_LOGLEVEL_MIN;

-- 
2.53.0

