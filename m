Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEB3374737
	for <linux-s390@vger.kernel.org>; Thu, 26 Feb 2026 14:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772115762; cv=none; b=A3pRcxZehqDhvMIGJ0oE5sdzhEeMQVEg6hOmwz+f+tOMp6fS/mgGchAOKL0hfoErOpwFfO55MNwyNmz8DCURp3/Iox1ajxtDhCIfUKm/hgNQpDQkvDhhjyS6NQiFCesuN1jlkS1F6KiW10OkQ+G8jB5gnoZ+BU3fX0zjEmLkOdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772115762; c=relaxed/simple;
	bh=RceW3omtq+6jX7rEf3y6VHTawOLP6mPxHBdXOGE79IA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZH2hqEQKFZbJ9Vuv9Pr+RcJKohcQo8TbX/vGT67iUbYN23WcKw4XWoSndzaL4g07fLT6JAbFXhktRqQjr0ukeNEfTQtvdwVqys7qtgw9cFE8MMKFUOJNdHw8ofHWCxHNp9PZ++TLvqnoVL1/2Q8zA23B9I8+nggZIxgV2BqeJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jKgAMrXK; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jKgAMrXK"
Message-ID: <a108bab5-9b53-4b90-a102-cc6fc22bb389@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772115759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jb9YPiWuPBlQARNsplGopujxVA0bSVtV2JHBgzvaymY=;
	b=jKgAMrXKDp/fFQ5Qy0F4SHLZDHjfhKJDxbbLLtY+pveidJYQS4BwYY5icSGR6bqLh7c5yL
	dRolPPiOmwgxNE75HXCcD1jdE8X5lC5Ks2p9bLaV8lOOd+HsPb3Y+wLrYQFX6TZc3A8yHY
	9Srq/4+a9GOfDAKt9fJHnlcntrkPyq0=
Date: Thu, 26 Feb 2026 14:22:35 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC v2 16/21] mm: thp: add THP_SPLIT_PMD_FAILED counter
Content-Language: en-GB
To: Andrew Morton <akpm@linux-foundation.org>, david@kernel.org,
 lorenzo.stoakes@oracle.com, willy@infradead.org, linux-mm@kvack.org
Cc: fvdl@google.com, hannes@cmpxchg.org, riel@surriel.com,
 shakeel.butt@linux.dev, kas@kernel.org, baohua@kernel.org, dev.jain@arm.com,
 baolin.wang@linux.alibaba.com, npache@redhat.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, Vlastimil Babka <vbabka@kernel.org>,
 lance.yang@linux.dev, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, linux-s390@vger.kernel.org
References: <20260226113233.3987674-1-usama.arif@linux.dev>
 <20260226113233.3987674-17-usama.arif@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <20260226113233.3987674-17-usama.arif@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 26/02/2026 11:23, Usama Arif wrote:
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 2519d579bc1d8..2dae46fff08ae 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -2067,8 +2067,10 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>  				pgtable_t pgtable = prealloc_pte;
>  
>  				prealloc_pte = NULL;
> +
>  				if (!arch_needs_pgtable_deposit() && !pgtable &&
>  				    vma_is_anonymous(vma)) {
> +					count_vm_event(THP_SPLIT_PMD_FAILED);
>  					page_vma_mapped_walk_done(&pvmw);
>  					ret = false;
>  					break;
> @@ -2471,6 +2473,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>  				prealloc_pte = NULL;
>  				if (!arch_needs_pgtable_deposit() && !pgtable &&
>  				    vma_is_anonymous(vma)) {
> +					count_vm_event(THP_SPLIT_PMD_FAILED);
>  					page_vma_mapped_walk_done(&pvmw);
>  					ret = false;
>  					break;
This will need to be guarded by CONFIG_TRANSPARENT_HUGEPAGE. Will need below diff in next series..

diff --git a/mm/rmap.c b/mm/rmap.c
index 2dae46fff08ae..9d74600951cf6 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2070,7 +2070,9 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 
                                if (!arch_needs_pgtable_deposit() && !pgtable &&
                                    vma_is_anonymous(vma)) {
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE)
                                        count_vm_event(THP_SPLIT_PMD_FAILED);
+#endif
                                        page_vma_mapped_walk_done(&pvmw);
                                        ret = false;
                                        break;
@@ -2473,7 +2475,9 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
                                prealloc_pte = NULL;
                                if (!arch_needs_pgtable_deposit() && !pgtable &&
                                    vma_is_anonymous(vma)) {
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE)
                                        count_vm_event(THP_SPLIT_PMD_FAILED);
+#endif
                                        page_vma_mapped_walk_done(&pvmw);
                                        ret = false;
                                        break;
