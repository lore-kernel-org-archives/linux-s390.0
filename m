Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116336;
	b=klmsnJhaYd+IPYdkt/qSylASrFod1ugrHWRJ1TVtRsXpzSNOsyB8Jt7+jtX2m2wKZeTK
	 JYMtLnDaAKVPCIQd9oHEsEh7ub5p8CIcpAbrYaCDllOQtsaATP24Ar9pib9/MARsEPmVU
	 ZVZ8sYVgjSdhrGCxALJSc1Te2fde1B40RXlRKtOH0LTcX06esAGBfwgRk3aCIbTZBIUUq
	 60+acFcLWZNaL7sBMNyQvtBc4bPhTwdZ9N2+Y3RDJcsdJTtWO6Zq8FStzZFEGryUj/1ei
	 127SAgNVvKqe58PpRskOvqsdbfKo639sVCAhuuvdC20Nid2rvdOejwTzyOj9xu9BR7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116336;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=5sSK0mEpHDMvzrLQAsEFtk5LbI4UItSogecSbLV64WI=;
	b=tellNj4Rbb7piLFBo/OPJa9OAyEM6V8II+JGfKoT7i0/nRg8Qz48CMLl+Vi/D01oh5Q+
	 TOCfK1Pxv7UZkm3EC7odlJ33gLyQC4tDavDG8ge0gJEoQ+nbT1axgWJNfRP9hQdkCEbHj
	 bgHamahyFh8j7lRt92+zjOpDB/RAbkKhAq9VLs0i5i7IoXlcBBgzOl83GSXmaKdlPLGc9
	 yFIGgg5/xEl5ppj2L8f3gnfEMgk6xm6kLrLF+vqgcO1SC81RCpB+D7asi5trMVJkfHwy7
	 ptCgWw0rrUoVEutUbPzosVZjThpTbDLCW6NpJHM7qoYs5C54XyH6S8lylhRczeuMCPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jsDNgjK9;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484DB60A2600
	for <linux-s390@vger.kernel.org>; Thu, 19 Nov 2026 19:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 484DB60A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jsDNgjK9
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-383f2d05c73so194989eec.0
        for <linux-s390@vger.kernel.org>; Thu, 19 Nov 2026 11:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795116335; x=1795721135; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5sSK0mEpHDMvzrLQAsEFtk5LbI4UItSogecSbLV64WI=;
        b=jsDNgjK9H3WzWV1nFlC/nPOonF3As4uF8i252IB5Iayfe+YMQAx4aK1ZgtHqU3ylF1
         qCQ2Aa1fRig+8MOpwaPotXPIBFHwEdGO8KETRUnHNGShaVuAoxNF908tV0EPKeu3fPPU
         vWoqgXqmhKSFHp+oZfm7imuSGUMmAPT109I2Mp0s4U6ugYIHi4Q6eOEZaU2wRldbmWmc
         1FcQHhb9g/EEH9RV8ufzA3oOdmuFwKaZjjICjfRob0wf4QQpfiTrvMFSl4Sxmk6WDH3O
         O+5iY+Wj9s5hG2FiX85RjAdyzamXFz/RJ7WeP2fw3PynqrIuy4QT8YSy1FtrEnwS9I/i
         BbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116335; x=1795721135;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5sSK0mEpHDMvzrLQAsEFtk5LbI4UItSogecSbLV64WI=;
        b=C36vhgk95xpUs2ZxExCdi1K5X53cUVLj0Oq8JOKLU8wxHoHsOh64FuZb+hsGRwrQmV
         lhuHrJp7XVAWR+tkSkzMrxJC5TcoHKtq3UycgxL0eNd0cV+zFxo1YlMQEZdYrEn6A0Wc
         q36FrbRb+dUastS7VOyJWQT6Vrl6PW0GSKKeipg9ZKMMkTHmdZaZcO+zq3t7S4HSnsCN
         jIHpA4KZYHAd20swb/yydfGAFyj4Vy9x6Q5bh23TCNTEoPDQYndgO1HHEi0qhhbdU+ce
         P8lZ0A8EfoA01AqUMx0OAX98gn+XSZE+uw4d/g+gFL9zx/nglwsinZWjGLJXMEKp9o6I
         yiYQ==
X-Forwarded-Encrypted: i=1; AL+hErEWfJVERr/j/3wtcdUIPlQPxna6wy2azEn3S54sHLmj3kcXAvHosbQLxgRjaDVWA7m+kvivoV+VL15t@vger.kernel.org
X-Gm-Message-State: APuU4Z96QQqeXGD4fhkGOBlcsKNSS/gbYXm9z1SdH0PJmZHB8q+l2iAD
	U4ktIadH5w5v3oxvPuMzjyVhOiMeOplQtmTDnXKQ3aEpecLne/ZUgOosEQ9WqJFyagiredaHkpy
	fyJlC6uPvcw==
X-Received: from dybqm10.prod.google.com ([2002:a05:7301:670a:b0:385:6c3c:3ea1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:152f:b0:381:c532:3d88
 with SMTP id 5a478bee46e88-3857093c38bmr360600eec.23.1795116334302; Thu, 19
 Nov 2026 11:25:34 -0800 (PST)
Date: Thu, 19 Nov 2026 11:25:12 -0800
In-Reply-To: <20261119192520.1983406-1-irogers@google.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119192520.1983406-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261119192520.1983406-2-irogers@google.com>
Subject: [PATCH v4 1/9] Compiler Attributes: Add __must_init macro
From: Ian Rogers <irogers@google.com>
To: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Srish Srinivasan <ssrish@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
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
2.56.1.708.g77570a6a1d-goog

