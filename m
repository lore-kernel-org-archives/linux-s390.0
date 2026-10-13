Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99071558202
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 22:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931241; cv=none; b=GqrhYoWzoS/iJ5nCMiRgGLkm9ls5M7xoOK4lFkMhZenzRNOIB6Ure3HJBRG7xJXhpy7rSTzD8KD8ROf6JbxJr0RzahITTwQfN+U3afyZbTW9xYSZJ/3W1KYRvMKLjQXMecQ3AzuZwsB7dgN74gyFbcNemiaGkzNMF1aj3I1RSXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931241; c=relaxed/simple;
	bh=yGWlUBd3WHI6EIBVLEUjSDo5J54V9OXwWHfKf5QXzl4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FHQJ/ZjkBxke8OQkIf5cK6Bmqso5DaBCUhZQQzireA+s4lpAfeYd1Rvo2xd1heTyRXHxUier0EGYCylb8szD/IzOYgxs8H4RzbLBTmwIgqB7mgipNPh4C5U9gCcPEZjX79sxUL3ArbP3grKUGbH2eaH427mkWiUvyrIFBvv2LWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RVq37/Zt; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RVq37/Zt"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-35d4538fd74so1601275eec.1
        for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 15:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791931230; x=1792536030; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SzuEQJa4uF6wSn0s7ZpxNvjcEHFt9KB4NkbiARikmlQ=;
        b=RVq37/ZtTlsPwWoRZWhH2an/ROJ7Xk8D2sLlBv1Lho/p7SZP+mjbxll+Pab1y1F7eK
         sThf6gtuWGZoWguNm/e+xCo3XjsQi0TJNTTQRzeTKOAUgbb493YkgXgqe7oVNtkXSFu1
         S4guSrFGTZnY7APOThvSZqefkj1fXCWggkpVA2iOInj3dcEyvjuGwBKRzf/X2oP+5tib
         myGzk55SzXCktc9jwgkzh4Tm5iVBsVSS7zp/M1hHjc2HpNXWQw/lFEGOtauzLazwTsnR
         vI9XA0OyUInB8eXto6yLJGTclgyItflleGWFEZlUeY2/1F9ScX2EeCF7xq5Q8URr3Fl3
         guFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791931230; x=1792536030;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SzuEQJa4uF6wSn0s7ZpxNvjcEHFt9KB4NkbiARikmlQ=;
        b=uIhB5xF4uFsZ9o5PzyNFNY+9K77W1nkjsQ2DKvQMfpbNeNaucaSYsHsKfzDF2C0wgC
         cydhYHtyvOTbDjXcvJMkSUnRKX+WGtsWrzRZ6jNKXmLh1kRr2zsUOZ5eioHTRCBcUhYu
         eRNrXVC/yIltA9yI16szhFvkxS7b9lYCeE3LK5dZE6w+AKrYD1dbmXMMhQ/GXkSActaL
         DSFJNPIKrhGJJ7sX2PxA6igIg+GuLBnZnFgrLT/4Ays6MXmMWZFUAcJn2vxUIkKq0uEE
         zV9rNaL21PANB8bGYlCeDBmYMehmxwbV71spSP0K6bVgu1cNxB7o7/HggVvmU5m4X2Bt
         4oQA==
X-Forwarded-Encrypted: i=1; AKwUvBw24o/pNuCK1E8YqkTJS3tRwaxyhcDEMlOlSE+uJG5uNyDXDLnDG6umM9Nxhf6i4xRg0VxFx7Rg9mdE@vger.kernel.org
X-Gm-Message-State: AFq9FYIp4ps0vX5iKg/CTjMFa7bl4ZDWk4oiUKnHQkd5aBxTl11AM/9W
	V1taHMnjcV/MnNs5deNvqrJQg15XT3NIASiH2GbF+IUQTll/Qw1w/ngfTOLhwpHLUCvKDQxZj0j
	xwl19l6mQqQ==
X-Received: from dybmf44.prod.google.com ([2002:a05:7301:92c:b0:358:41fa:f46f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:c8c2:b0:35a:8dad:6724
 with SMTP id 5a478bee46e88-35a8dad7ec8mr9213311eec.22.1791931228757; Tue, 13
 Oct 2026 15:40:28 -0700 (PDT)
Date: Tue, 13 Oct 2026 15:39:42 -0700
In-Reply-To: <20261013223946.1836757-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013223946.1836757-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013223946.1836757-8-irogers@google.com>
Subject: [PATCH 07/11] xen/sys-hypervisor: Add release callback to hyp_sysfs_kobj_type
From: Ian Rogers <irogers@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Viresh Kumar <viresh.kumar@linaro.org>, 
	David Teigland <teigland@redhat.com>, Alexander Aring <aahringo@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, driver-core@lists.linux.dev, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
	linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-s390@vger.kernel.org, 
	linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

hypervisor_init() in drivers/base/hypervisor.c creates hypervisor_kobj
with kobject_create_and_add() (which allocates a dynamic kobject using
dynamic_kobj_ktype), and hypervisor_subsys_init() in
drivers/xen/sys-hypervisor.c then overwrites hypervisor_kobj->ktype with
&hyp_sysfs_kobj_type, which had no .release callback.

Add hyp_sysfs_release() calling kfree(kobj) to preserve the dynamic
kobject release behavior.

Fixes: cff7e81b3dd7 ("xen: add /sys/hypervisor support")
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/xen/sys-hypervisor.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/xen/sys-hypervisor.c b/drivers/xen/sys-hypervisor.c
index 91923242a5ae..0e8a2cd69fd6 100644
--- a/drivers/xen/sys-hypervisor.c
+++ b/drivers/xen/sys-hypervisor.c
@@ -659,7 +659,13 @@ static const struct sysfs_ops hyp_sysfs_ops = {
 	.store = hyp_sysfs_store,
 };
 
+static void hyp_sysfs_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
 static const struct kobj_type hyp_sysfs_kobj_type = {
+	.release = hyp_sysfs_release,
 	.sysfs_ops = &hyp_sysfs_ops,
 };
 
-- 
2.56.0.385.gd3acb90ef8-goog

