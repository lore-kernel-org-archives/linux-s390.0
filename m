Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672603382F7
	for <linux-s390@vger.kernel.org>; Sun, 22 Mar 2026 05:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774158201; cv=none; b=AluWhd2fUt7aGUHiO5niPe4/P5BwKZ8pAgBQlH/UfGsalTX8k2sZwTjIcWsihkhfZn6X9l5Ol3Vi1tKw3XHFns5xhRKiqzG+MooZXMXtvjmRLDCpI67P0QbFflcdQ6pMzwcXBS9ymSwZN128zHbWf9ZgKv0w9yNuVqAYibC2lqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774158201; c=relaxed/simple;
	bh=pUtFLNM8bIVhn1C4HEgCXPw2t6WuvF6D4DtWrOoUcZE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mYfSa8MtLSL9A8+dlISbitCe4gtvCnzvXw/XOryUIOqt4ntw/+zPAKjBY9fIk7t5nCZDVmNes0T3NfbDXhRK3I/r3zhoFoVSMxdyN86AP8YHwfzBkJn5blVPktghnde+7Le4qa346XkVwz7YtzyPYT0mny1h7qfmoFqPueF6+fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hbcSaLCR; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hbcSaLCR"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-127337c8e52so16082521c88.1
        for <linux-s390@vger.kernel.org>; Sat, 21 Mar 2026 22:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774158200; x=1774763000; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GvTHfHDaEeYEd5IaJalf0yvJB887/iPHMmYQM447rIU=;
        b=hbcSaLCRFIUMUS246631VYrBowPulSUwmCcJGVx6RNwMKGXUc+Ulx9y/3TeNPQ7xfF
         lHRt5kWXts+FenIcxKtKGRaGHK9ELVsYscvTK0SBKvkZVp9Mh1J9t3uTV/JHqfIiIjDb
         wz7aGG5NZpZDPBJSKJ82YzuKTfrTQ0r+Wd4zM7f28eidDcj4LHd5HrTlRpHVFbbCyHgZ
         R7KqlqRG9/0DVV+a7zEYaCcYwyl0FWQC8xN9eq/FHyrM2SZGEbWoKvQesrFbTXOO/Phz
         xUZvxugQh9IS9tZn9f5HP/jgRHAUuty2Nu71eCbf0ZJ1VUjLUlFdoQ1Q8dC8zYaiGn0I
         4w9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774158200; x=1774763000;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GvTHfHDaEeYEd5IaJalf0yvJB887/iPHMmYQM447rIU=;
        b=LDRaKhUQvNESmKMjUtC2wPV605IHrRh/ghQTbcW6zbsKUFnQYPccGDBr5fW+gCotrC
         GRwJzdZbpByg5GJRoJ5O0mfQAXX23wr4Mtl9MXuhX2dbbxdv3x9zp+7MwLNLmnIGq+09
         JFNC+xRABIMUH79+zBGerSgIEkONxTIMqFvqE9Aiqme0FsG92h4ahURH61oqRLAjxNaJ
         bvM3XLx9J2KaglZqM+ymu8yJKETHWiwSTIA0VlRbLINyXH5GhU27nJmlJnGgvHWIouNW
         6ENyqM+6HD/F765YblSd9obX0pWlhBMI2W3zapEApwjb3iLuvNoEPPeTpvU0EBMrFxfo
         vDwA==
X-Forwarded-Encrypted: i=1; AJvYcCUBdFFSIyUkdlYud8v0Kq7DKtRBrxEQGEHQbRV5E8XcW6XP7CiTrC09V66c1gFh61Vr7QDH6ZYGzV4U@vger.kernel.org
X-Gm-Message-State: AOJu0YxUtVTUt7vzjvLQkaPxTWYJSrJkU5M+TkeGF4qlCbAh8MpbfXw0
	B948IpKolv6KLXzFyvbK7fUlSIJHHX0msUHRSFxo0XeQx1HAzYqrTt13l5Kao1GlLxaKsuk0dZP
	Z6QMnQg==
X-Received: from dlbvg27.prod.google.com ([2002:a05:7022:7f1b:b0:128:d754:39d])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:41a8:b0:127:33e0:ea33
 with SMTP id a92af1059eb24-12a726b3177mr4054533c88.22.1774158199330; Sat, 21
 Mar 2026 22:43:19 -0700 (PDT)
Date: Sat, 21 Mar 2026 22:43:07 -0700
In-Reply-To: <20260322054309.898214-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260322054309.898214-1-surenb@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260322054309.898214-4-surenb@google.com>
Subject: [PATCH v4 3/4] KVM: s390: avoid kvm_s390_handle_pv() error overwrite
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org, david@kernel.org, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, 
	jannh@google.com, rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, 
	kees@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, borntraeger@linux.ibm.com, frankja@linux.ibm.com, 
	imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

If kvm_s390_handle_pv() call fails its error code gets recorded but
execution proceeds as if the call was successful. If the next call to
copy_to_user() fails then the original error is overwritten.
The follow-up patch adds fatal signal checks during VMA walk, which
makes it possible for kvm_s390_handle_pv() to return EINTR error.
Without this fix any error including EINTR can be overwritten and
original error will be lost.

Change error handling for kvm_s390_handle_pv() to alter normal flow
once failure happens. This is consistent with how kvm_arch_vm_ioctl
handles errors for other ioctl commands.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 arch/s390/kvm/kvm-s390.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 3eb60aa932ec..ddad08c0926f 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2947,6 +2947,8 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		}
 		/* must be called without kvm->lock */
 		r = kvm_s390_handle_pv(kvm, &args);
+		if (r)
+			break;
 		if (copy_to_user(argp, &args, sizeof(args))) {
 			r = -EFAULT;
 			break;
-- 
2.53.0.1018.g2bb0e51243-goog

