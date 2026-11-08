Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177584;
	b=pzXvRpsTYSxYlxI6ABkeChJ+7Iq0w8LdjyTVlh2//xlLR71lJwG5N+fhjfhTU1zYgrLo
	 z6C16U7DFMJ0AmWCldargt80eaR65CTO9KGXxONwhdQpFwn5NEzEo9OWk5Qibs9OGaYW3
	 HiZRAaSbXLwVvt5tR8pFaUb9ZSz/81JWnAAE/DOihTXYz2ybV+gN8ULLmMWL8D3oeAl7j
	 2D4dIpX5OnWMrDRMS5of792P/RilVCK4eh4C/RlFxnVE1m0v55IrlNgNUC5KiqVqsV9fT
	 irbkVjihILCxE3bGFZe2Wjjl7FSf/ONrURQPzbkP2I/lWaVp44QftC4ts3Lf/qVA5lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177584;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=AHLMqwM6/67Zcd/LOxQ2+hhUbtfPU/BOw3z2THUGUxg=;
	b=ZD9CfDhndjkxR9c1fuhoTKJ7TOiPwmegcoZ4R8NkvD9QJ3yj4NZxws+3m42ePNw7C/Vq
	 otcoef2ockvBi7z2wr9u7ZuzFOrhefLpE4RYkkRqbzXtnAxqALyOwRakptNpBTlaHasJS
	 TjT1Ph2UyIpNgrTPQqCPLpf1BKPhHxVhZqyo8rSEF3sudbngUv8YVe8fo6bV4arr+FsPL
	 L+8QUVtnmJJ/fdBpqDy1HXNEcmvEtU1LT9w7bsdLTrLXmvGWWQ48CmPEh4c9aU3D4zoOy
	 6pZqx0+L2oiPIOcgZKMjU3qQ7eIbegOGy8t82qqFCgtty1STp1TDnrE+LIYt26OQIOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DDM9ziHH;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E3F606A33D
	for <linux-s390@vger.kernel.org>; Sun,  8 Nov 2026 22:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39E3F606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DDM9ziHH
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36d1353fdcdso767803eec.0
        for <linux-s390@vger.kernel.org>; Sun, 08 Nov 2026 14:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794177582; x=1794782382; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AHLMqwM6/67Zcd/LOxQ2+hhUbtfPU/BOw3z2THUGUxg=;
        b=DDM9ziHHycZyyJZHGRL6PqLNcLxbYkI0L6RfQVmG2hrXn/doLWCV2deQ4V57vXvCff
         R7ROEEVWQOoTe6MTYd765lzcdcorknCcL9ldDYylTgEf3C18y/+Jitg6xj/LYAvEAqN1
         VFF7kwjKwF+XfQxq/WOea6xr8MRXQoXjBCrOiXLryI2lAArDzjLGDCzOR3oaGhYc3sr8
         vqzBDRqyx3tf4PgG/kY/GT67mXthfKrNZfYYpiQTouxXHIjuji9785S1A1QEmIwDGlVE
         iCvvPkunW2GZyIM0xjFAGkKaC77nayP+lv55bdHSAn3i0AwchyOC8iN73cuZO2+a84Rn
         /keQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177582; x=1794782382;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AHLMqwM6/67Zcd/LOxQ2+hhUbtfPU/BOw3z2THUGUxg=;
        b=gqkabrrPnEyc1d/EK6/Zi3AaCdo/QvlCIeKtoZXxLgRs5+qx8WOLuO8AkKBchLN8NV
         tVTbuXCPAoQZPzyTCavWbGSqD25roHYj0ByfTKi1M51MSs1gFivspvIvd9hoNza6jxqA
         0F3NYv2r07rztxlqwAmOgP7HhHxVq0ouZxr7+CMxz80TJIxKm4gYZ0iPrAcXDjUxR7xM
         gl6mmSb1NpcjvUtibNlRrBBhFQ4ymrG+oS19yrvBA7DYblrbxnHsKlMkqDbBvkhUYfuD
         nd4PpACBUciLHnch68g2QHFFibVzWPUUJT/8fUH7gqfu/9oQUOFgIwOG4YAZYEMN9Tvr
         HZcg==
X-Forwarded-Encrypted: i=1; AL+hErHoPmnZXFlrQIF0HwMnpHleayCtxWvgA8qEpVlHOFKaXCj9sJAPa8/wVL4vbWSjad+WDYC7emQFlt9x@vger.kernel.org
X-Gm-Message-State: APuU4Z++BNA5Z4su0UncevuKYYwWOMq5YpJuwpKfE+TzbxvmP6ejtW5h
	Aei59Pl9axo7HoU0bPVZ58IQqCA6QVGSwWSK3VUNbzCbu6dBix8AMQouvBhhg01M9YuuuPT0Wwe
	AS6BP+gvspg==
X-Received: from dlbox21.prod.google.com ([2002:a05:7022:1215:b0:1ab:fb55:f657])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:b884:b0:1b2:695b:79f0
 with SMTP id a92af1059eb24-1b39fef03f3mr3576923c88.32.1794177581955; Sun, 08
 Nov 2026 14:39:41 -0800 (PST)
Date: Sun,  8 Nov 2026 14:39:05 -0800
In-Reply-To: <20261108223913.3624571-1-irogers@google.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261108223913.3624571-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261108223913.3624571-2-irogers@google.com>
Subject: [PATCH v3 1/9] Compiler Attributes: Add __must_init macro
From: Ian Rogers <irogers@google.com>
To: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Srish Srinivasan <ssrish@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Alexander Aring <aahringo@redhat.com>, 
	Felix Kuehling <felix.kuehling@amd.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Clang supports the 'require_explicit_initialization' attribute on struct
fields to indicate that a field must be initialized explicitly by the
user when the object is constructed. When an aggregate initializer or
uninitialized variable omits an annotated field, Clang emits a
-Wuninitialized-explicit-init warning (enabled by default).

Add the __must_init macro to include/linux/compiler_attributes.h (which
is included by include/linux/compiler_types.h and
include/linux/compiler.h) so kernel structs with error-prone
initialization (such as mandatory callbacks or cleanup handlers) can
enforce explicit initialization at compile time, as discussed at the
Linux Plumbers Conference. The shorter __must_init spelling, rather than
the attribute's full name, keeps annotated struct members readable and
was suggested by Greg Kroah-Hartman.

Note that Clang versions prior to the fix for
https://github.com/llvm/llvm-project/issues/232483 do not diagnose
file-scope objects declared without any initializer (initializers at
file scope that omit the field are diagnosed).

Also teach Sphinx (Documentation/conf.py), kernel-doc
(tools/lib/python/kdoc/xforms_lists.py), and checkpatch.pl about the new
attribute macro.

Link: https://lpc.events/event/20/contributions/2392/
Link: https://lore.kernel.org/lkml/2026101532-fantastic-deafness-e04c@gregkh/
Acked-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 Documentation/conf.py                 |  1 +
 include/linux/compiler_attributes.h   | 12 ++++++++++++
 scripts/checkpatch.pl                 |  1 +
 tools/lib/python/kdoc/xforms_lists.py |  1 +
 4 files changed, 15 insertions(+)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 5ab26ce89daf..baaa4035258c 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -203,6 +203,7 @@ c_id_attributes = [
     "__noreturn",
     "__packed",
     "__pure",
+    "__must_init",
     "__section",
     "__always_unused",
     "__maybe_unused",
diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 476c4c560d17..b9c0b56dd22e 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -322,6 +322,18 @@
  */
 #define __pure                          __attribute__((__pure__))
 
+/*
+ * Optional: not supported by gcc
+ * Optional: only supported since clang >= 20.0
+ *
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#require-explicit-initialization
+ */
+#if __has_attribute(__require_explicit_initialization__)
+# define __must_init __attribute__((__require_explicit_initialization__))
+#else
+# define __must_init
+#endif
+
 /*
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-section-function-attribute
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-section-variable-attribute
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b8b64f720191..6a091c45b1a1 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6888,6 +6888,7 @@ sub process {
 				"noreturn"			=> "__noreturn",
 				"packed"			=> "__packed",
 				"pure"				=> "__pure",
+				"require_explicit_initialization" => "__must_init",
 				"section"			=> "__section",
 				"used"				=> "__used",
 				"weak"				=> "__weak"
diff --git a/tools/lib/python/kdoc/xforms_lists.py b/tools/lib/python/kdoc/xforms_lists.py
index db23fb650ea8..42956b98aae3 100644
--- a/tools/lib/python/kdoc/xforms_lists.py
+++ b/tools/lib/python/kdoc/xforms_lists.py
@@ -36,6 +36,7 @@ class CTransforms:
         (CMatch("CRYPTO_MINALIGN_ATTR"), ""),
         (CMatch("__private"), ""),
         (CMatch("__rcu"), ""),
+        (CMatch("__must_init"), ""),
         (CMatch("____cacheline_aligned_in_smp"), ""),
         (CMatch("____cacheline_aligned"), ""),
         (CMatch("__cacheline_group_(?:begin|end)"), ""),
-- 
2.56.0.455.g6c5a503b38-goog

