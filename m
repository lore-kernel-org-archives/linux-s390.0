Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63683AE70C
	for <linux-s390@vger.kernel.org>; Thu, 26 Mar 2026 08:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774512529; cv=none; b=Qv1Cf3ECRYLioyj3q8CyBfSjA6a1TXaAjDlQ0a+J2KvD1Lqy4ZlX8zVk/fAr46cVGOEjb8uuP+oOzQWbgHRwOH1I1KgkPhAiMH+uP3umyTo1wa+khqYcM+ujjD4x9KlIUsLBtInpcA3dp38HpNPztrYiK29PuwkfvwQF7qfoIdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774512529; c=relaxed/simple;
	bh=3GnyT2WlT0kxCiLmP60OzV4FCCTn3R5BE0Og+KeeECM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wqivls5zqTXeJx6ypL4S7uZAuMfVjaw7tRSCFnTiQ/ZgYBUkWEbi5FBkk61tfupvfqXd45KtizmgAD3cKGkYDXey9PP+e8afgAd8dn8ndXIQXa2h8wpAq2HIns8tcV0gq0bkXDZJs8bW32R1pcvf7f32S2WqprxBsILcY3xBc9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g2rMXptF; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g2rMXptF"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bda35eab74so476605eec.0
        for <linux-s390@vger.kernel.org>; Thu, 26 Mar 2026 01:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774512528; x=1775117328; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f0m3laKqVZc6BVbp9FlOKUOANtvuTeySm/ZmFaYOMpk=;
        b=g2rMXptFmW4TRj48LH0oH/MEJgD7TxDarlOlK0oGHU9UxCAgx/NiGncdIC/DM8RwSm
         32EMcdSlm01zFWSHXMQfaOMO4JjnsIeP2PjnBSoNvEiI++XSmS/UetS1bfdXtddkP1Sl
         t1aOICPZClUQxh5m/lUNpHmF35ecEwhxh1UBApWjhvSSOlDr0EpbOVNWyII2RIUs6OBQ
         G8PKZoNLStToQL+oR6Su/TrFhVQjQZ2Ot1a49D9TGhrDMG2ZRLn8iocSg/IR+LeSrOp3
         BHio8f5uCbx2xI/1sers5kiY9GkrFxNXIdtMB2NXMw44Wv6xsnfF97LQThfc9f22pbnc
         MpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774512528; x=1775117328;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f0m3laKqVZc6BVbp9FlOKUOANtvuTeySm/ZmFaYOMpk=;
        b=EBGI4AALrmS9bL6P3rDfXxy20RuNy/WdKhkkeA4gtbJcDvm4zxLdK7mawkksHUgGI6
         odjrUwZUZWftHWuMjRMSzPb+gbbUsQy36s2oxNOdV0qupHgYBilfV9Y/YC9l11iiHYgD
         fu0db4Fan3LMH0yiv4usgMTbiUf69gJCBJNXXoRrc0XqBoCT8GnOgvdJs+f8aiP6c/uF
         WjYvZe1CWnAszU5mygee0CtyC0a3TxSBWH7+vQM75SyOWXkS/I8j37A9Ctc6I+EzO8Kf
         oXHpvQMoNsFPN4T2L7GiciIBJDoBQD/QidM9flD6HNosVejLnZUrcQa0quf9YACfcpmS
         VolA==
X-Forwarded-Encrypted: i=1; AJvYcCU9MX3Epc5KDhybo2XoVByrxALHsoC0OFvt7IpruJDpDV6kOh/KiCrjpnIrJA4A0MBBcIoeT4zUN8l8@vger.kernel.org
X-Gm-Message-State: AOJu0YwoaVq77wZO9krnySLKlJNUGxYzsKFuxgYpVIUaNyxS1Fj4n84x
	AnqR7pNs+/raIUBV9oLamx7lSlaOfQwqtUG3CYCgETb2GZd/hIa0SYXkqTPKQnGsdhv0hExGrcT
	tNZlRoA==
X-Received: from dybvq8.prod.google.com ([2002:a05:7301:77c8:b0:2c1:da8:eab3])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:724c:b0:2ba:6f16:10cf
 with SMTP id 5a478bee46e88-2c17726234cmr295020eec.14.1774512527594; Thu, 26
 Mar 2026 01:08:47 -0700 (PDT)
Date: Thu, 26 Mar 2026 01:08:33 -0700
In-Reply-To: <20260326080836.695207-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326080836.695207-1-surenb@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260326080836.695207-4-surenb@google.com>
Subject: [PATCH v5 3/6] mm/khugepaged: use vma_start_write_killable() in collapse_huge_page()
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
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, surenb@google.com, 
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Replace vma_start_write() with vma_start_write_killable(), improving
reaction time to the kill signal.
Replace vma_start_write() in collapse_huge_page().

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 mm/khugepaged.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index d06d84219e1b..a1825a4dec8b 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1166,7 +1166,10 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
 	if (result != SCAN_SUCCEED)
 		goto out_up_write;
 	/* check if the pmd is still valid */
-	vma_start_write(vma);
+	if (vma_start_write_killable(vma)) {
+		result = SCAN_FAIL;
+		goto out_up_write;
+	}
 	result = check_pmd_still_valid(mm, address, pmd);
 	if (result != SCAN_SUCCEED)
 		goto out_up_write;
-- 
2.53.0.1018.g2bb0e51243-goog

