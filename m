Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140759;
	b=1ITxGTBKLoAcCPQFOVz9CMc4wTeLi1iAHKL8+uU3CdFlDLN8y3QrZiGkAgo4VOAEmhyp
	 ny6x2SLK/TkZU7nSlWQi2jC3g/JqSQCjHS+ns2yNlwrP8kJfnrwLP9DYcb9S19hlnjvFr
	 jEIT4WZjNothrzLAUY8BIhW+z9eIq4t4wmF/oL1yFqQnbG0PANtb+O9jJucw6TiYX9KKi
	 GsQ+Fyw5P1AChjkQFOERcB2r0/Kmt5F+W39vU80ZZeoRcyXKQGcQyb0syob+olxAlbrEe
	 5uc8f/c57yTkSrUOdWAm1rlfrXMDBhuHplyQrJbBRgJCZK4XK8EHazNABWAJL/NXFSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140759;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=kZ/TSWTZAJNbAAfYXfetESQgQ8bp7xksXUAoJHJHiFs=;
	b=D8ikavYUEqNoksjr4XAxI1cEOSg2GnyXy0PO9uSioZcaI1T/nZGzEdUvaQa8YARLrBWp
	 EQzWp/xArqbLf99/JG2u0o+N4OFXGimmdhPStskeufj+rLWtJt1lafM3shtOFJHlzpZgU
	 6OV67AIlz/0xRlDXmKXrqstR88D4fXZoGkYHjHK46W37/5+nfT3393Waqq6r+bXWgZJEA
	 lsF9ZGp52EdfNO9KtUIghKaNUqOtnyB8tgoY1BR3diImZP/DEJNFqAfEIeqlbonDiOUP5
	 ipmdhUU/L7qxpE5eGApumPTdz+iLUQoBAVdv8sP8luQmlu9f5zmcfuTbk3EDLJUjcIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AM0U1bTn;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691D0606A31F
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 22:39:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 691D0606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AM0U1bTn
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-341eff9e381so708227eec.1
        for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 15:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793140756; x=1793745556; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kZ/TSWTZAJNbAAfYXfetESQgQ8bp7xksXUAoJHJHiFs=;
        b=AM0U1bTn+FBfrtRXE0vv0BDIqy142hMoBHOxySxpTba8mZqsCKdiH7AcgMgAyDergD
         /Pm0SA04DcRopZol9tqMR9uqtV7SWWbXLODsXQW5E2Nz87dJUJTEv9MENnB6uZEDCydX
         bzH1uuY83A2Ilur70UWvrINSlPegvzIpxnoUDHLAKQyOSZjyd7ZnaKpnu96OtHfa681+
         yn32BwRvIzkiWcgRF/RQt1W13A77VnuM5E40B2lvNBFScs2cQI7oVMCTZ1fs0nUoOor9
         yK0A2SJcXO2B/nbS31dOcpWY13YkRl2qukDyyZeX28bXtF+bXwoIzHqgunH+hlapdIuA
         bVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793140756; x=1793745556;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kZ/TSWTZAJNbAAfYXfetESQgQ8bp7xksXUAoJHJHiFs=;
        b=xlOOSyD92XUkBT6Fanq36iUG2KwWnbI0J7Z8dVWr3bo1B+fgHMfj9bat7yMam6NG7o
         HIakLLQpalGbVwvlDo8inzK03TbJxVQTzwp2GZX24+0Vw8hNwQRGNwclUv+l/6MRBk3K
         YqZmW8CbPatUleMIaBqpQBwSpnxm+6O1n2O8OtreRBvX+H5bpaSjDZjr2M+oLA5CBLYj
         bdd4oEH+KP1BiF0hqJ4qsYfECsrhMQGpezAkpo0iC7ufqHQRErwUWJID4RCBqUhrO2vK
         aAF5YeRUSJOIKZi71knG0xBF1h6UCJ9euen7kd9TlD/oOr6tmuFpmleVtWRoqryRlQoo
         +H1Q==
X-Forwarded-Encrypted: i=1; AKwUvBy8E+AQ9jriAZhmgkdydesY02aSR2ZLokkP1bSybIM1YVSTGKf2iiAYIm3RFsjktB3rUo6hPWOC2j+d@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5qAhaUDQkezJes+i2ttsUX+EU8OkYNNHoyav/J8+mFkecxJpK
	80HkgXjJMB4Obcyev8sJpJtis/wJvoLPAirWK9mNo2Z1YypA9DwSowwZfRoOAMhruj3DZ5S2Ekm
	G1PU7CT3DKw==
X-Received: from dlbrl28.prod.google.com ([2002:a05:7022:f51c:b0:192:91:5cc4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:618:b0:19f:527d:96da
 with SMTP id a92af1059eb24-1a6cdd3e006mr1194989c88.33.1793140755024; Tue, 27
 Oct 2026 15:39:15 -0700 (PDT)
Date: Tue, 27 Oct 2026 15:38:37 -0700
In-Reply-To: <20261027223847.652884-1-irogers@google.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261027223847.652884-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261027223847.652884-3-irogers@google.com>
Subject: [PATCH v2 2/9] powerpc/secvar: Add missing kobject release callback
 to secvar_ktype
From: Ian Rogers <irogers@google.com>
To: Kees Cook <kees@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Miguel Ojeda <ojeda@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Nayna Jain <nayna@linux.ibm.com>, Eric Richter <erichte@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

In add_var(), a struct kobject is dynamically allocated with
kzalloc_obj() and initialized with secvar_ktype. If kobject_add() or
sysfs_create_file() fails, kobject_put(kobj) is called to clean up.
However, secvar_ktype does not define a .release callback, which results
in a memory leak of kobj (and a pr_debug warning in kobject_cleanup()
when CONFIG_DEBUG_KOBJECT_RELEASE is enabled).

Provide a secvar_release() callback that calls kfree(kobj).

Fixes: bd5d9c743d38 ("powerpc: expose secure variables to userspace via sysfs")
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
2.56.0.313.g2479322e68-goog

