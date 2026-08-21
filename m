Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B1C353A91;
	Fri, 21 Aug 2026 19:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787342077; cv=none; b=uyYQkyKtDxYdVt10ZPTTJ2VsDieV7qx9Ixp6ZncH7gWsX0LMaJ4kSFQJd3De/sSNYTrdSHgKcjKHmUYJj68bB4DudI5tv71Rosfx+DGA/9IHoN9Di0EsfXl5XjKCTKbAkmVb7l5yNnBMdzlNb65I4EtjDZqT/s0DyLY2xrvBs9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787342077; c=relaxed/simple;
	bh=+Z9miNuw66BzYd2CkMiywvYw35N8qAwEFDJwozK58T0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a/I7bq1rrDXcn8Eky89opIKf12vWXbOF5/qfT84Rye0wjszsFGDzlwkdAFRV7uuShkKfgE4iOCC9/sG5dwJ3x9SvvOjS3VOpzrsr91POUZKPEJgbdiRq+0iJVFvllHiVky81GrTpVAkhD32IUn1Q5WlkYqiWiEIcLZNx2JmdYAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GZxBnqcG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GZxBnqcG"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LIVfLR1237389;
	Fri, 21 Aug 2026 19:53:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9ug5wA5UefrH1rkFi
	jmEW+AkmRi6rwLJHFRpVtdIb08=; b=GZxBnqcGu5ki0eu9/8vzFyTX7cC+I4Pdj
	FxUCCsOsIrDdY0zdasLQdujForlV29m9D7YO1CNdrHJMF6UKcZDiBi80qjmRsAUE
	ni4XQ27yhCagUqHZBlyrPQl3JuzcWyZ8SRJyM2jAYRF+dlrvRiLLKw0Yg+4wzr7U
	jnioCCZrlW3/S4R2VjCp6jxJznk9Fs9w5WZjG4xtTWv5KFdtbI/YjT4LxFHw0r1N
	hxEvr9URaWLEXOK44ODCLbQYU/gZb2mmDDBlrx9lhM5OABs45VW39VC7vZaMmBMW
	1Jwsz+IDR9ZhCmw49NA8xxOFfM+O1sOQuYYM4yL3kGEe3guTR4e1A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu2kr0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:53:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LJfIqt008710;
	Fri, 21 Aug 2026 19:53:13 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354yxdwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:53:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LJr9tR45679052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 19:53:09 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25BC020040;
	Fri, 21 Aug 2026 19:53:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD26B20043;
	Fri, 21 Aug 2026 19:53:08 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 19:53:08 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Indu Bhagat <ibhagatgnu@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Namhyung Kim <namhyung@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, Kees Cook <kees@kernel.org>,
        Sam James <sam@gentoo.org>, Fangrui Song <i@maskray.me>
Subject: [RFC PATCH v2 14/24] unwind_user/eh_frame: Add .eh_frame[_hdr] validation option
Date: Fri, 21 Aug 2026 21:52:49 +0200
Message-ID: <20260821195259.2688377-15-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821195259.2688377-1-jremus@linux.ibm.com>
References: <20260821195259.2688377-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AdqB2XXG c=1 sm=1 tr=0 ts=6a88acaa cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=rU79QueooZ11dTUg0tsA:9
X-Proofpoint-GUID: V0QbgjbecwJnbO6dU4IgQ-bBO3sGdUfh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX1iVigc/iW8LB
 zeqq4vE+GPJLSxItxBmu3VRnL/3oRRr8kjlci1KHJadHGRC8H43mpt1CqviFREy3nVAJODZ6sS8
 h+ZaYSwA7HyQY9krH8TKU5pq6G7v4ziooiCBkfXjD+zXyxo+S+K4njorH6qNu+5bVD3683qrsPR
 BWd5mxzfiPbDbSmJfz9UjhgnFZsCzPH7F3DITljFiBBDbMSey+LGv1iqnXccg+SS3r4i9KKdgpN
 dqcOWVMILcDMfHF08nP3KyuF21Yw0S/EkuCa0vVmQv3KpzIi+8muccF18SyIoKLnXJtc5u936dT
 vjjbdCKvAqHIHue1ISrIK+CjZwy4iixTucHK0wJixY0F9qSqNPAJJCHeg7cqJ+Wl8MZ4k2e6nol
 F9dsWzGAxRX7Ol6nbVyVwIQMZxIUQrNs1j0cQFMaSOjD40K7mb4JO30O4HkxVWKJPvgPql0mf1Q
 g0JTqY8RxDnAiAAA0gg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX0mQVwO7Z4iLA
 sNZ6cUUHh4dcWQyiCHC5GHj8vpxe1LxlTshbbBebiyoUro73YJU9uvDE8r1LxykSUrg9HAsDj2i
 uyESaMo4IaSG23qdrih51d/Z6lyDL+w=
X-Proofpoint-ORIG-GUID: lW3CGmU-Qqxb1m_pLlfWazP5XlGeBG4t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210155

Add a debug feature to validate all .eh_frame[_hdr] sections when first
loading the file rather than on demand.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    FIXME: dbg*() with UACCESS enabled.
    
    Changes in RFC v2:
    - Fix compile error. (Sashiko AI)
    - Correct loop counter type to prevent infinite loop. (Sashiko AI)

 arch/Kconfig                   | 22 +++++++++
 kernel/unwind/eh_frame.c       | 90 ++++++++++++++++++++++++++++++++++
 kernel/unwind/eh_frame_debug.h |  4 ++
 3 files changed, 116 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index ea969811f798..c06e5010a88a 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -490,6 +490,28 @@ config HAVE_UNWIND_USER_EH_FRAME
 	bool
 	select UNWIND_USER
 
+config EH_FRAME_VALIDATION
+	bool "Enable .eh_frame[_hdr] section debugging"
+	depends on HAVE_UNWIND_USER_EH_FRAME
+	depends on DYNAMIC_DEBUG
+	help
+	  When adding an .eh_frame_hdr section for a test, validate the
+	  entire section and its referenced entire .eh_frame section
+	  immediately rather than on demand.
+
+	  This is a debug feature which is helpful for rooting out
+	  .eh_frame[_hdr] section issues.  If the .eh_frame[_hdr]
+	  section is corrupt, it will fail to load immediately, with
+	  more information provided in dynamic printks.
+
+	  This has a significant page cache footprint due to its reading
+	  of the entire .eh_frame[_hdr] sections for every loaded executable
+	  and shared library.  Also, it's done for all processes, even those
+	  which don't get stack traced by the kernel.  Not recommended for
+	  general use.
+
+	  If unsure, say N.
+
 config HAVE_UNWIND_USER_FP
 	bool
 	select UNWIND_USER
diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c
index 96237a96d263..b0be56e31508 100644
--- a/kernel/unwind/eh_frame.c
+++ b/kernel/unwind/eh_frame.c
@@ -1216,6 +1216,92 @@ int eh_frame_find(unsigned long ip, struct unwind_user_frame *frame)
 	return ret;
 }
 
+#ifdef CONFIG_EH_FRAME_VALIDATION
+
+static int eh_frame_validate_section(struct eh_frame_section *sec)
+{
+	void __user *table_start_ptr;
+	unsigned long table_size;
+	u8 table_enc;
+	int entry_size;
+	unsigned long prev_func_addr;
+	unsigned long i;
+
+	if (!sec->fde_count) {
+		dbg_sec(".eh_frame_hdr: invalid FDE count\n");
+		return -EINVAL;
+	}
+
+	table_enc = sec->binary_search_table_enc;
+	entry_size = 2 * encoded_pointer_size(table_enc);
+	if (!entry_size) {
+		dbg_sec(".eh_frame_hdr: invalid binary search table entry size\n");
+		return -EINVAL;
+	}
+	table_start_ptr = (void __user *)sec->binary_search_table_start;
+	table_size = sec->binary_search_table_end - sec->binary_search_table_start;
+
+	for (i = 0; i < sec->fde_count; i++) {
+		struct eh_frame_fde fde;
+		unsigned long cur;
+		unsigned long func_addr, fde_addr;
+		int ret;
+
+		cur = sec->binary_search_table_start + i * entry_size;
+
+		scoped_user_read_access_size(table_start_ptr, table_size, Efault) {
+			/* Read function start address from table */
+			ret = read_encoded_pointer(sec, &cur,
+						   sec->binary_search_table_end,
+						   table_enc, &func_addr);
+			if (ret) {
+				dbg_sec_ehfh(cur, "table[%lu]: failed to read function start address\n", i);
+				return ret;
+			}
+			if (i && func_addr <= prev_func_addr) {
+				dbg_sec(".eh_frame_hdr: table[%lu]: not sorted\n", i);
+				return -EINVAL;
+			}
+			prev_func_addr = func_addr;
+
+			/* Read FDE address from table */
+			ret = read_encoded_pointer(sec, &cur,
+						   sec->binary_search_table_end,
+						   table_enc, &fde_addr);
+			if (ret) {
+				dbg_sec_ehfh(cur, "table[%lu]: failed to read FDE pointer\n", i);
+				return ret;
+			}
+			if (fde_addr < sec->eh_frame_start) {
+				dbg_sec(".eh_frame_hdr: table[%lu]: invalid FDE address\n", i);
+				return -EINVAL;
+			}
+		}
+
+		ret = __read_fde(sec, fde_addr, &fde);
+		if (ret) {
+			dbg_sec(".eh_frame_hdr: table[%lu]: failed to read FDE at .eh_frame+%#lx\n",
+				i, fde_addr - sec->eh_frame_start);
+			return ret;
+		}
+		if (func_addr != fde.func_addr) {
+			dbg_sec(".eh_frame_hdr: table[%lu]: function start address mismatch\n", i);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+
+Efault:
+	return -EFAULT;
+}
+
+#else /* !CONFIG_EH_FRAME_VALIDATION */
+
+static int eh_frame_validate_section(struct eh_frame_section *sec) { return 0; }
+
+#endif /* !CONFIG_EH_FRAME_VALIDATION */
+
 static void free_section(struct eh_frame_section *sec)
 {
 	dbg_free(sec);
@@ -1351,6 +1437,10 @@ int eh_frame_add_section(unsigned long eh_frame_hdr_start,
 	if (ret)
 		goto err_free;
 
+	ret = eh_frame_validate_section(sec);
+	if (ret)
+		goto err_free;
+
 	ret = mtree_insert_range(eh_frame_mt, sec->text_start, sec->text_end - 1,
 				 sec, GFP_KERNEL_ACCOUNT);
 	if (ret) {
diff --git a/kernel/unwind/eh_frame_debug.h b/kernel/unwind/eh_frame_debug.h
index 40a80861d4d4..bcb2d03ab9ab 100644
--- a/kernel/unwind/eh_frame_debug.h
+++ b/kernel/unwind/eh_frame_debug.h
@@ -14,6 +14,9 @@
 #define dbg_sec(fmt, ...)						\
 	dbg("%s: " fmt, sec->filename, ##__VA_ARGS__)
 
+#define dbg_sec_ehfh(addr, fmt, ...)					\
+	dbg_sec(".eh_frame_hdr+%#lx: " fmt, ((addr) - sec->eh_frame_hdr_start), ##__VA_ARGS__)
+
 static inline void dbg_init(struct eh_frame_section *sec)
 {
 	struct mm_struct *mm = current->mm;
@@ -47,6 +50,7 @@ static inline void dbg_free(struct eh_frame_section *sec)
 
 #define dbg(args...)			no_printk(args)
 #define dbg_sec(args...)		no_printk(args)
+#define dbg_sec_ehfh(args...)		no_printk(args)
 
 static inline void dbg_init(struct eh_frame_section *sec) {}
 static inline void dbg_free(struct eh_frame_section *sec) {}
-- 
2.53.0

