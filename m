Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725AF566C59
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 22:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931241; cv=none; b=vC7Epk9v5SbgJPtvkIi0N+OnvvYV35QdA0rSCt5eMZFShq3cjWhudUzM1u+l/ZmibQ/F5Sl6Ahil/PMKBN9dvzvejntqjDlCbcbwGyi0BMnHKvx+RmnPYih6xKF4al4qXnfT2+CBUZZHsTyZh80bsDrSBLsbuw3qLzS8QbkagTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931241; c=relaxed/simple;
	bh=GRIZQKuwWcuCjR8A0ylF/V4G5/ojiWDtGgUJc8zlstU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kaErurzPt7SIBu7zgp6GF6vyohOeFiN5wvShYQO045aGyb9IWLZPztVoEe9+/lbHzaE4cvpE7ykwnRrXNV5jxKzfAnmS0aFKmYp6RLlDUFsnY+jcvOg7oH0zDWeVV0n7udlM2mZbfeWPb3Btuyexpqx4Zol9pmL1/kCgsoU8l7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g8gifxaS; arc=none smtp.client-ip=74.125.82.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g8gifxaS"
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1665200f4c2so4837732c88.0
        for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 15:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791931227; x=1792536027; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zqg4bcg4yTM1CSL1NV7gzxaOXxYgsDcagY96onRKZWw=;
        b=g8gifxaSdCCIAbkivfGWNcDH6utzh4z1cfa5VpsXY+0PZJFXilUJdXZh4uv+2qTb+r
         XlcAXqim9CgkNeLtOqhaqTXnYIu/TlKZ/LOOl3qS5J0dsSV6yEeJkmnGf0bFR0jaFBdY
         /egtQ6t4Uyy8eb3z9XK5nwK0oV2FxxZQyndEgMkUGhxn1aOzCGsUPRS6jY5DX0ic7lDZ
         SgrTf6ib/QXH6Dz///lcRkp3traYSXWovSQkPoHaGaCE7hDG0zlhWjD5bEq31Zqwky4y
         wBywwX5UfHf+Lo/f7a2KpdwAclqZrDaSJB66WkylGffGBuCEJWElKUo3vDXF7FQTL3iD
         /9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791931227; x=1792536027;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zqg4bcg4yTM1CSL1NV7gzxaOXxYgsDcagY96onRKZWw=;
        b=Yu5O/gOq2msnOBBIgZixZyR7qR09GGb6zYXN3QF5cJ4Jo4a/rLSqabl2I6EXJz3c9U
         d10WJwzakZxTUMIZrm/tzBpXOO0KpKyBf+NCZW9MkEuGj2oNlP5OYTrEGz5sBVsrPK20
         6RZvf79v9/MiL41QIdkOzCJydGok6Cmg9Jf5XgA05KACqRCG0G4EXf/7tAgbhXSY7H4s
         Wt5YMTKC0JUOfNr4XU3qMxan0Si46Ee/O9llUkxnQWC6pNwT6FW+x+4bC4FdLwnOOSXE
         0De24WKPXfAa7ljQ66UNLQ4kst5Ws3h5IRor6MvlZNwPqEaRG85qDCZiIG/Vgef3SZ6L
         BX/g==
X-Forwarded-Encrypted: i=1; AKwUvBwuJHwlonjqJ06/3a51zM9Iz3Xv4sZKuc8v9nEVXfM/bhXF0kGKsUwW7kmQVfgKntCq6lCFJ30w3smg@vger.kernel.org
X-Gm-Message-State: AFq9FYKbp6YCN3WkTsRKnzEu9pbFlY/G0d79to4SaBLse9VgZ8+reiRe
	gQ2nc1S8YmUD0vtjK2SC4xow437zw/WDGPn72Z43fF0/DeAUQiMfzZe3n9xfoU90+8vkq+WqwjZ
	p6x/FR1n97g==
X-Received: from dldyq19-n1.prod.google.com ([2002:a05:701b:4553:10b0:164:47f8:a96a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4286:10b0:144:c128:4c4b
 with SMTP id a92af1059eb24-16a5e49c474mr18578865c88.36.1791931226644; Tue, 13
 Oct 2026 15:40:26 -0700 (PDT)
Date: Tue, 13 Oct 2026 15:39:41 -0700
In-Reply-To: <20261013223946.1836757-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013223946.1836757-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013223946.1836757-7-irogers@google.com>
Subject: [PATCH 06/11] dlm: Free dlm_ls in kobject release callback
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

struct dlm_ls embeds a struct kobject (ls_kobj), but dlm_ktype lacked a
.release callback and dlm freed the lockspace structure directly via
kfree(ls). With CONFIG_DEBUG_KOBJECT_RELEASE=y, freeing ls before the
kobject release runs causes a use-after-free.

Add dlm_ls_release() to free struct dlm_ls when the last reference to
ls_kobj is dropped, use kobject_del() in release_lockspace(), and drop
the final kobject reference in free_lockspace().

Fixes: 3514faca19a6 ("kobject: remove struct kobj_type from struct kset")
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 fs/dlm/lockspace.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index a9c98b4f378f..1d226b27d8e6 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -179,7 +179,15 @@ static const struct sysfs_ops dlm_attr_ops = {
 	.store = dlm_attr_store,
 };
 
+static void dlm_ls_release(struct kobject *kobj)
+{
+	struct dlm_ls *ls = container_of(kobj, struct dlm_ls, ls_kobj);
+
+	kfree(ls);
+}
+
 static struct kobj_type dlm_ktype = {
+	.release        = dlm_ls_release,
 	.default_groups = dlm_groups,
 	.sysfs_ops     = &dlm_attr_ops,
 };
@@ -355,7 +363,7 @@ static void free_lockspace(struct work_struct *work)
 	 */
 	rhashtable_free_and_destroy(&ls->ls_rsbtbl, rhash_free_rsb, NULL);
 
-	kfree(ls);
+	kobject_put(&ls->ls_kobj);
 }
 
 static int new_lockspace(const char *name, const char *cluster,
@@ -436,6 +444,8 @@ static int new_lockspace(const char *name, const char *cluster,
 	atomic_set(&ls->ls_count, 0);
 	init_waitqueue_head(&ls->ls_count_wait);
 	ls->ls_flags = 0;
+	ls->ls_kobj.kset = dlm_kset;
+	kobject_init(&ls->ls_kobj, &dlm_ktype);
 
 	if (ops && dlm_config.ci_recover_callbacks) {
 		ls->ls_ops = ops;
@@ -567,9 +577,7 @@ static int new_lockspace(const char *name, const char *cluster,
 	wait_event(ls->ls_recover_lock_wait,
 		   test_bit(LSFL_RECOVER_LOCK, &ls->ls_flags));
 
-	ls->ls_kobj.kset = dlm_kset;
-	error = kobject_init_and_add(&ls->ls_kobj, &dlm_ktype, NULL,
-				     "%s", ls->ls_name);
+	error = kobject_add(&ls->ls_kobj, NULL, "%s", ls->ls_name);
 	if (error)
 		goto out_recoverd;
 	kobject_uevent(&ls->ls_kobj, KOBJ_ADD);
@@ -615,7 +623,6 @@ static int new_lockspace(const char *name, const char *cluster,
 	rhashtable_destroy(&ls->ls_rsbtbl);
  out_lsfree:
 	kobject_put(&ls->ls_kobj);
-	kfree(ls);
  out:
 	module_put(THIS_MODULE);
 	return error;
@@ -759,7 +766,7 @@ static int release_lockspace(struct dlm_ls *ls, unsigned int release_option)
 
 	dlm_delete_debug_file(ls);
 
-	kobject_put(&ls->ls_kobj);
+	kobject_del(&ls->ls_kobj);
 
 	xa_destroy(&ls->ls_recover_xa);
 	kfree(ls->ls_recover_buf);
-- 
2.56.0.385.gd3acb90ef8-goog

