Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116339;
	b=bke5Bmuh2V99iKvym2MLXPVSRMF3NovyXk1gW5iWuSIxJqUrCl+n33IKfL5u5P209Q67
	 DymroHn3IAlGVsCAw6ygYYVUOOkjSryaVPWZA8chUllY5xF4/uFVbGYqtxHCjwNOx+mE6
	 hWkRxBmTKxrCpLaNMlJRhqTLGWK2lbixkQjuUi0deouxK/6/WH2xV48+1EFj6ZfKW2ONR
	 kGjTYqW/Z0njxZIn+gd6Fl/zPMA3OXsvhgtK4h30Wd+GvZmb3oPGpPsDM7fc/pjSTo8ph
	 8ekVesDocDXNIw6zkBvh1pFsF0W8sPVeLoOm10u/LQ3y2bA3lJBJJjwEcMA5018RDDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116339;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=rEPVdW1UHjKh7bwOu3YUjmxSg8vF1ESXVYVOzAB45kQ=;
	b=RasiLUzO1bLJShYy6JlaxfON+yZh503j/E00i13slTr89Yx9xi81YwUfRXs+A+Ja+iUB
	 a4Jj+7tyilQBrfykUpwGcEOhulzweOIF9h/HlyuuFDIBQsKVu/RIMNfYYmIZBQoDKlO/j
	 6E4I5hKxu5YWWDgX7D8r4iVxnjgwZtQaiEiz5ZPnkdXoiy9oSZ7Orr2n0I03P2S8uwR7S
	 YPz50jb37/d5KuIvsfiCYr+WjttUMxkEJFj6IXcq2SHM2Rr04lFKpOWcYQALxM8xBBu4z
	 KtveXYbvX+suhlQrgVjN+NkUgazaUYzCQSiBF+zsa+NGvzJg+GaO16tkW5/EHkAwn7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="nkk/aHO+";
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF64C60A2618
	for <linux-s390@vger.kernel.org>; Thu, 19 Nov 2026 19:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF64C60A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nkk/aHO+
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4e778acdbc6so216233b6e.3
        for <linux-s390@vger.kernel.org>; Thu, 19 Nov 2026 11:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795116338; x=1795721138; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rEPVdW1UHjKh7bwOu3YUjmxSg8vF1ESXVYVOzAB45kQ=;
        b=nkk/aHO+iL/QVslKweTpGRJyta8pMKUanDqzsOYLUoHxYvHbcPk0K1oPjzbmUIgX5C
         a4ksEvuUXVb4knCRuLE/pngJN0Fu2U7Ksnr/txK6kZlULF0dMIonkXOHbeOOy6kXkLF0
         hVfNMJ3zBFp3whK2WapWwlMlx+6npAGmfKXoz3p7CihvOHcneCzBcGa76xjoOS4s2x8p
         V7MoBox3I5jV2aUG934ychxiasYie3HbUjHiyYnzAIkJmMHZ2tir8L0UT57NTHVWaibf
         +6uN66iZBFfXTXXFMLCcqQ9E/Qx4vuSInlbSJ/WlGdcn6yjZQcoU5sQtMa7Oi6dIP0VC
         1Ykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116338; x=1795721138;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rEPVdW1UHjKh7bwOu3YUjmxSg8vF1ESXVYVOzAB45kQ=;
        b=kfTVZYGYZmLZGdXhMAYOFG+426goBFVNjPszfxH9+dwBZ+PMnQTy+3jT9QE+2lvBYU
         2D4NZ30ctq//VioX1ioLH6SmMhPsXSIacwrcxgcVXCMgzWyEFOKcbeBGwQ92XSfCETAS
         N9CmJZTpCt1yP8f3KtYobvMJQpg2TYkUaNUWuvvQq0Y4ktv6ySkUIuFBjsCp2xAyWZh1
         6H0SGk/L0291HmntKoEZ19MtzIjCLohqxDKh0grUtTnkqt4bIa4Htz8o83NyOmwQZfyk
         Ky1G8ll/YB201laAHXakQNZabbo/MlSclLL6cSbJRaWOOi3h2RTmxmGKWwRi8qH0aOiG
         ZTRQ==
X-Forwarded-Encrypted: i=1; AL+hErHW5wnIfnRbg3nn5mg01K5GFQLus2GoUD/589dxJedKZvtoYkZyJJXcapiGeT23MZM1kttnSGAbFdsp@vger.kernel.org
X-Gm-Message-State: APuU4Z8sWf2ttQH2K5tAsFtLTVOgM9CfXCWV30aJn5gUp/uORb/92VBo
	cWIKPpIurxZBJP7CFtl/0GZA4dJJcnThgGkrfUmy/gsfMr+ZAr1Q4c5QOP7me2W5VDYRRDnck+u
	Jgs3raAuRlQ==
X-Received: from ilmp8.prod.google.com ([2002:a92:c608:0:b0:51e:1b8:eceb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:c110:b0:576:4595:9836
 with SMTP id 5614622812f47-57a0ba52419mr994155b6e.40.1795116337420; Thu, 19
 Nov 2026 11:25:37 -0800 (PST)
Date: Thu, 19 Nov 2026 11:25:13 -0800
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
Message-ID: <20261119192520.1983406-3-irogers@google.com>
Subject: [PATCH v4 2/9] powerpc/secvar: Add missing kobject release callback
 to secvar_ktype
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

In add_var(), a struct kobject is dynamically allocated with
kzalloc_obj() and initialized with secvar_ktype. If kobject_add() or
sysfs_create_file() fails, kobject_put(kobj) is called to clean up.
However, secvar_ktype does not define a .release callback, which results
in a memory leak of kobj (and a pr_debug warning in kobject_cleanup()
when CONFIG_DEBUG_KOBJECT_RELEASE is enabled).

Provide a secvar_release() callback that calls kfree(kobj).

Fixes: bd5d9c743d38 ("powerpc: expose secure variables to userspace via sysfs")
Reviewed-by: Srish Srinivasan <ssrish@linux.ibm.com>
Acked-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 arch/powerpc/kernel/secvar-sysfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
index 395399bbab2c..f3f6ac25ea78 100644
--- a/arch/powerpc/kernel/secvar-sysfs.c
+++ b/arch/powerpc/kernel/secvar-sysfs.c
@@ -126,7 +126,13 @@ static const struct attribute_group secvar_attr_group = {
 };
 __ATTRIBUTE_GROUPS(secvar_attr);
 
+static void secvar_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
 static const struct kobj_type secvar_ktype = {
+	.release	= secvar_release,
 	.sysfs_ops	= &kobj_sysfs_ops,
 	.default_groups = secvar_attr_groups,
 };
-- 
2.56.1.708.g77570a6a1d-goog

