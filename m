Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A1B38E12C
	for <linux-s390@vger.kernel.org>; Thu, 26 Feb 2026 07:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772089577; cv=none; b=j9qDd2EAYLT5cNwAbMezq5nkSnb4I1lZ2r5dx19GCvNB26EPTTvcTL+uCEGNlTvcu5dC8XGV7RBOVY3v3Q8FMtZvMr2fJICel8cmHWQwsia0KHlXsBJFidKqeWFEh06vfXWPf41XR4MSALYwDiYtjOuexA0Ie/UdWLZnc6NsAwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772089577; c=relaxed/simple;
	bh=cvM66anYgz9K3Mo4/Dx9OzmNjnvAQXpBRRxnW76ZNTo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OHp8bHlRJzfGXFhi66lqnWyHSphyPniioKx3WiiWlnlJe8uKA2yMoYPR2Lu7mEe3xrZlgDPXQDVmwEbR/OMbtecelIFusbNlUqLHZKqPgo3t5otjEnAUV8KBKyEpDBGTE5iIrS7LsdeQqwPVbxpnzVTYgwmP6CF1G5wOjwP5Bi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W5HEB6du; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W5HEB6du"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1277896014fso13297146c88.1
        for <linux-s390@vger.kernel.org>; Wed, 25 Feb 2026 23:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772089576; x=1772694376; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xfjM/VAc0stWw4WShx/yqMtIU9xXg0AJdwokX5oM15c=;
        b=W5HEB6dut3kHHqSPYzHvkaFmdjI1pQ2DoNrlsVv77VKO2Fhe8z0B0PLsiniGF8X0NK
         x/B7JivPzI4+Da945+E5cOJyJp6OebAizX4FkpzZl742mmbBdvbW6epkhAdYiDmDI6JQ
         RIQtYbPkWB1wxij4AV3eP6xDnaS0q7fjJOnmcABD99ntcldmwMeHV9yelz5nmNh71Zz3
         8PH3lQcB+ulgWUL2zIB+NWl562SYcJbcpCpiUw8zw5P0Q6cw/MRB4rOHeoY2+R5+H5dQ
         qd1e3yNA69GgXwAgFbCzHhq+fgzS0tU0eJbxDfpfyhqRKElN9InEJGcHB2qQmr1+wKAK
         vNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772089576; x=1772694376;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xfjM/VAc0stWw4WShx/yqMtIU9xXg0AJdwokX5oM15c=;
        b=bz17VJRZU2rqSNYnR2fXiZkOXgxs7D+q/nN1tVHNO2TiGhufrrxa5t4ck2CUhimUE9
         411ViucXN3sOpStCp9C1/Hfo62OygrxO9UOC03bp7Hk8m8ehvinalbid/seGSYHMS6Fi
         k03l70M0Ux/PTzg2XrL4k33iPsICfDsdIIIgtmQGKXU5z6nEkRrNOiIUqT9hLw61XQKv
         rSsNnqKSOrV2HVVYMPi7+kiTVgxyqFO2+RqlZSQsAKlq6UpAd0riYQKrZU41XAK1u25M
         LikKaGZKvkTkBbOKtLPsp5qGI7PQEJo1aEq3I3BxGiu6aeEOcASW4BCBKLcX+tgBkqwI
         zbdA==
X-Forwarded-Encrypted: i=1; AJvYcCWc0DSTvlxB0C41/nKo3lLFunlfu4xOMSKqyWFpLLAUDkPo3WQ1Lv8APTutBpQgxQDZPaA3uKGXQ6Pv@vger.kernel.org
X-Gm-Message-State: AOJu0YyNeAR4k+QzoCTBvnCdTVY0lJi+9U3tT2IcOzvFZdP1xmkvX5NH
	j7sNfd+A83ul95SPvn99GfGW0GkqlBjGDomagvMYSQBXhMMuZmVuphwViuRl2JdZndyHqMvsMAN
	n0x1TRA==
X-Received: from dlbvv2.prod.google.com ([2002:a05:7022:5f02:b0:124:a76e:bd23])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:626:b0:123:345f:5d9c
 with SMTP id a92af1059eb24-1276acdaa5amr6463857c88.2.1772089575384; Wed, 25
 Feb 2026 23:06:15 -0800 (PST)
Date: Wed, 25 Feb 2026 23:06:07 -0800
In-Reply-To: <20260226070609.3072570-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260226070609.3072570-1-surenb@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260226070609.3072570-2-surenb@google.com>
Subject: [PATCH v3 1/3] mm/vma: cleanup error handling path in vma_expand()
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

vma_expand() error handling is a bit confusing with "if (ret) return ret;"
mixed with "if (!ret && ...) ret = ...;". Simplify the code to check
for errors and return immediately after an operation that might fail.
This also makes later changes to this function more readable.

No functional change intended.

Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/vma.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index be64f781a3aa..bb4d0326fecb 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1186,12 +1186,16 @@ int vma_expand(struct vma_merge_struct *vmg)
 	 * Note that, by convention, callers ignore OOM for this case, so
 	 * we don't need to account for vmg->give_up_on_mm here.
 	 */
-	if (remove_next)
+	if (remove_next) {
 		ret = dup_anon_vma(target, next, &anon_dup);
-	if (!ret && vmg->copied_from)
+		if (ret)
+			return ret;
+	}
+	if (vmg->copied_from) {
 		ret = dup_anon_vma(target, vmg->copied_from, &anon_dup);
-	if (ret)
-		return ret;
+		if (ret)
+			return ret;
+	}
 
 	if (remove_next) {
 		vma_start_write(next);
-- 
2.53.0.414.gf7e9f6c205-goog

