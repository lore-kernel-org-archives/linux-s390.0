Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12B8165F1A;
	Sun,  6 Sep 2026 02:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788660033; cv=none; b=HjL7mxXnnuwyUkXAMu+eB2ycOJLDlqNFq7cBTNtaKK1fAMgG8zvIwNylHC3ZryLGVDrepkpFkNYk2MtSeY+yCZE8tcMUvCqeLfjf9MdmOh9b41ywDjlHqejyt2gnvN3EWoPFyAkhI/PWv2wwkZiBQlHvwnEMu+N0u4kVK9d3tuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788660033; c=relaxed/simple;
	bh=4OCA7cZQxsiy+4IQEWSullQEGcLugcqxv9G1On3+2dI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YlqYghYX1hsuR1cjTIkn+ey5Kfcn1v6Wv3i4kmwpeUTloo0WviWVVFLb/DXycmQh0ooWeWTeypmhkpx/CiISfRf0u2pKCaaPYFJorwMdVQmd2oVWtiKA4w2JykncZgo6vaDmFZYD6d2N+FcVybVdJ//9/Z+uRm/HjKbgfmjsaN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=onvqGLmc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="onvqGLmc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131AD1F00A3A;
	Sun,  6 Sep 2026 02:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1788660032;
	bh=ohXcpCjF3E8Su2iGbnUTFcKH4Q5PX6bz9vn2jqgCP+c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=onvqGLmcP1GLOxpEKfzU67JdQE7IDZGMsPO64h/0NSOK+RvFXdBCqD8+ofD1WBq2g
	 i6cYyIHzjygejYh8PKFLzFY7Ac5zL8dW6mlFYoHExtDtLuDxudvpRUkwCZVnaHxKoG
	 FWNotUDCuJBgzmpoHcxnORH4VODmerRMAERbMW3I=
Date: Sat, 5 Sep 2026 19:00:30 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Adrian =?UTF-8?Q?Barna=C5=9B?= <abarnas@google.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Alexandre Ghiti <alex@ghiti.fr>, Andy Lutomirski <luto@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Brendan Jackman
 <brendan.jackman@linux.dev>, Catalin Marinas <catalin.marinas@arm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, David Hildenbrand <david@kernel.org>, Gerald
 Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens
 <hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Len Brown <lenb@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, Pavel Machek
 <pavel@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin"
 <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ryan Roberts
 <ryan.roberts@arm.com>, Sven Schnelle <svens@linux.ibm.com>, Thomas
 Gleixner <tglx@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, Vasily
 Gorbik <gor@linux.ibm.com>, WANG Xuerui <kernel@xen0n.name>, Will Deacon
 <will@kernel.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 loongarch@lists.linux.dev
Subject: Re: [PATCH v3 0/6] arch, mm/execmem: resolve confusion about
 set_direct_map_valid_noflush()
Message-Id: <20260905190030.adf2740822e211ddc028a24a@linux-foundation.org>
In-Reply-To: <20260903-execmem-set-vm-perms-v0-2-v3-0-949b64a9f755@kernel.org>
References: <20260903-execmem-set-vm-perms-v0-2-v3-0-949b64a9f755@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 03 Sep 2026 12:28:26 +0300 "Mike Rapoport (Microsoft)" <rppt@kernel.org> wrote:

> Recent discussion about implementation of execmem's ROX caches on arm64
> revealed a confusion about how set_direct_map_valid_noflush()
> implemented on different architectures.
> 
> ...
> 
> Implement these adjustments, make execmem always use VM_FLUSH_RESET_PERMS
> and revert set_direct_map_valid_noflush() changes.
> 

Thanks, I updated mm-unstable to this version.

> 
> v3 changes:
> * set VM_FLUSH_RESET_PERMS to allocated area just before flipping the
>   permissions rather than at allocation time
> 

Here's how v3 altered mm.git:


 mm/execmem.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/mm/execmem.c~b
+++ a/mm/execmem.c
@@ -36,7 +36,6 @@ static void *execmem_vmalloc(struct exec
 	unsigned long end = range->end;
 	void *p;
 
-	vm_flags |= VM_FLUSH_RESET_PERMS;
 	if (kasan)
 		vm_flags |= VM_DEFER_KMEMLEAK;
 
@@ -277,6 +276,8 @@ static void *execmem_cache_populate_allo
 	/* fill memory with instructions that will trap */
 	execmem_fill_trapping_insns(p, alloc_size);
 
+	set_vm_flush_reset_perms(p);
+
 	err = set_memory_rox((unsigned long)p, vm->nr_pages);
 	if (err)
 		goto err_free_mem;
@@ -439,6 +440,7 @@ void *execmem_alloc(enum execmem_type ty
 {
 	struct execmem_range *range = &execmem_info->ranges[type];
 	bool use_cache = range->flags & EXECMEM_ROX_CACHE;
+	unsigned long vm_flags = VM_FLUSH_RESET_PERMS;
 	pgprot_t pgprot = range->pgprot;
 	void *p = NULL;
 
@@ -447,7 +449,7 @@ void *execmem_alloc(enum execmem_type ty
 	if (use_cache)
 		p = execmem_cache_alloc(range, size);
 	else
-		p = execmem_vmalloc(range, size, pgprot, 0);
+		p = execmem_vmalloc(range, size, pgprot, vm_flags);
 
 	return kasan_reset_tag(p);
 }
_

