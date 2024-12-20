Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B69D1AB6E2
	for <linux-s390@vger.kernel.org>; Fri, 20 Dec 2024 09:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734688552; cv=none; b=eyBkzh03kNzcSnFusO/kU0eILPXBJ56tGvbhpvfXmXvx7GzDenpTwj+ogD2ZuIamiXrIDcFMknatJHNPbrqd+h75EPLqAvG5Pxsyy25URrjOXZDH27sSYm0vlojtmZvjfoZLy6eH8971F0xxqJvYB6rTQSo1mqicnsKnEql56Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734688552; c=relaxed/simple;
	bh=p76DzD4pZwmLrswFnQUudN2VJOBVF+4CR3iZuSJkl1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F4/fIPMqvxk6uG/WW6Kf03x8/46R2myBwM3aAcdcbFoxQyXSiAJvO/TYtg7Fl3Q62BuQirBVFbaaGp4aD/LCNg6FrNiU8QhX2xj1CQ0OBHrmZkTGmdsbDF4leeZlBaW5KkBqahsfvV3yt7b5TO6oq7t0UQJbRN7sL72wP+Z4Wh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HcLfmmkO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HcLfmmkO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734688549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AvU8JFqW6ZJDZpFadoum7GUCRHp9GUaFtFIZ2dfsiNU=;
	b=HcLfmmkOIvtct/mvF9h3wS7cpGu8pFfHBMHt53ycLkktqHZUmQZN0lEj0xDXpthava59bV
	34SVQyXdAWfX7yC0v36CyGjP4ayNcX5lM8wLLdsKBgE5u065hV11/2sZUJ7+esajHhGZ0N
	BfCulFeNDpPcYK5b0nzVGSuy2z0zAPo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-R-pCT-CKPweYdT_B6aAONw-1; Fri, 20 Dec 2024 04:55:47 -0500
X-MC-Unique: R-pCT-CKPweYdT_B6aAONw-1
X-Mimecast-MFC-AGG-ID: R-pCT-CKPweYdT_B6aAONw
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3862a49fbdaso811912f8f.1
        for <linux-s390@vger.kernel.org>; Fri, 20 Dec 2024 01:55:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734688546; x=1735293346;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AvU8JFqW6ZJDZpFadoum7GUCRHp9GUaFtFIZ2dfsiNU=;
        b=J0Uh+N0A9KGGHTWJXwfwQSEh7nTNvVKUdB91NtXO0yyyIiWOz8YNjjbEc7H5oUwSGu
         dS5unloV+8cnqiymURMfDLaRL01JIiZRA1cMFm6MrLwzuakCsVcY9AAOyzffz+AcMWUh
         cYxzRwz2colBWby0vYR6rHFe7sYWi2gjZX+be8l5ZLm24lfM1+OnOKsCkAzvu0ijV6Bn
         6Q/OLadcPWxu5HmY+qxrHq+OhnwgOS3S31Ft2DzUP+WETO5P/jQ4NIMSDHPl978tLhtb
         oXO3plX5n8ctAzK3wwiWO+CZ10qdq0UL/q27oTrA2HgCBfWx0dn1KDVnSx8UKzZUOE7L
         82NQ==
X-Forwarded-Encrypted: i=1; AJvYcCXy4hmJT7mfGSEvSujWuF4YcvLHuJYlgSdSaFbU34i1fucHjbTWttINW/MXJnlQOrsbdxuiUId4AIoO@vger.kernel.org
X-Gm-Message-State: AOJu0YwB5GU7DfCYAzbL5lkv6CZCebkpAmviydj9r8uEzyjFJXRzcrZh
	iQY13czR05P/Kl+2ACjZgDKvG8sMSz38lAqyUDr4GVIIMOWwgwpawBQZaPOWTcIFM8g032Z2/Q+
	lehQVZPdbGstlEmWrujPc95k6whfYtL2bFw1FMc9AtlkkWtUBli1Rfiv3JD8=
X-Gm-Gg: ASbGnctVw3wUXlNteT8OrX9YSy/dWw7ewgRoUL7meoi22JVkOSX4+nXWxW6+3wVKco2
	SQVi14WgmsPsQycVyoCNNUudSdw84uEFg8JJEfYVeyg9P6D23fxcjA/J0Yim3obqHHqjl703de3
	L4YvQxuZ4vOzBCZ4yumG3RutB/Z0/zHYqHTUOPV4EFIVMuGfxWtPw9rvU+Fv3+/DdP0tlkjcXu/
	yaNkG6iK8HbvHBpSzrXXPXTCx8Ubb721jghNrrYyOAAjYaHwWCSeExGV16Y+KofKNDlHifcuimY
	lm1Z5anvTKDRGzjsPX8rmV6Wi03s9xmJI7kdiihJP6jbPlKgxayVzpQExYcbds34KJBNDIF4X6O
	bZt/2bMcd
X-Received: by 2002:a05:6000:480d:b0:385:f38e:c0d3 with SMTP id ffacd0b85a97d-38a22408d9cmr1987324f8f.58.1734688546612;
        Fri, 20 Dec 2024 01:55:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGd8b4THn8ndcj6OJD2Cr1moAk5STf4OEK1lnTnKJBHx+mPBX++hd54hzcZ7RNbGxDLRr4kHw==
X-Received: by 2002:a05:6000:480d:b0:385:f38e:c0d3 with SMTP id ffacd0b85a97d-38a22408d9cmr1987296f8f.58.1734688546192;
        Fri, 20 Dec 2024 01:55:46 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:9d00:edd9:835b:4bfb:2ce3? (p200300cbc7089d00edd9835b4bfb2ce3.dip0.t-ipconnect.de. [2003:cb:c708:9d00:edd9:835b:4bfb:2ce3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e1acsm3629356f8f.68.2024.12.20.01.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 01:55:45 -0800 (PST)
Message-ID: <0b45aab7-a0d0-4471-b3d1-c50283f19515@redhat.com>
Date: Fri, 20 Dec 2024 10:55:44 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] s390: Convert vsie code to use page->private
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-mm@kvack.org, linux-s390@vger.kernel.org
References: <20241219162252.1025317-1-willy@infradead.org>
 <20241219162252.1025317-3-willy@infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241219162252.1025317-3-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.12.24 17:22, Matthew Wilcox (Oracle) wrote:
> The vsie pages are not standard page tables, so do not convert them to
> use ptdesc.  

They are not page tables "at all" :)

A vsie_page is used when emulating hardware virtualization (SIE --
Start Interpretive Executio) for a CPU: vSIE -- virtual SIE

These pages primarily hold the shadowed "SIE control block" (SCB) that tells
the hardware what to do when entering hardware virtualization (SIE), and
include things like CPU state such as registers. We store some other
information in the same page.

We have to the SCB provided by the VM VCPU when running the nested VM VCPU. The
SCB resides in guest physical memory. So similar to shadowing of page tables,
we have to detect modifications to the SCB, so we can update out shadowed version
accordingly.

We use grab a page and fill a vsie page VCPU wants to execute the SIE instruction
(executing the nested VM VCPU), and return it to the pool when we are done
emulating the SIE instruction. We try to reuse the same vsie pages over various
runs, thats why we store the address of the last SCB address we shadowed,
to look it up. (improves HW performance)


So page->index will hold the "guest physical address of the SCB we shadowed
the last time this vsie page was used".

We seem to have space in the vsie page, so I think we can avoid messing
with page-> completely!

 From c94e4ecd6ee791ef9cda1c0577a1e765e5ce2867 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Fri, 20 Dec 2024 10:53:46 +0100
Subject: [PATCH] tmp

Signed-off-by: David Hildenbrand <david@redhat.com>
---
  arch/s390/kvm/vsie.c | 19 ++++++++++++++-----
  1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 150b9387860ad..0a8cffe9b80bf 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -46,7 +46,13 @@ struct vsie_page {
  	gpa_t gvrd_gpa;				/* 0x0240 */
  	gpa_t riccbd_gpa;			/* 0x0248 */
  	gpa_t sdnx_gpa;				/* 0x0250 */
-	__u8 reserved[0x0700 - 0x0258];		/* 0x0258 */
+	/*
+	 * guest address of the original SCB. Remains set for free vsie
+	 * pages, so we can properly look them up in our addr_to_page
+	 * radix tree.
+	 */
+	gpa_t scb_gpa;				/* 0x0258 */
+	__u8 reserved[0x0700 - 0x0260];		/* 0x0260 */
  	struct kvm_s390_crypto_cb crycb;	/* 0x0700 */
  	__u8 fac[S390_ARCH_FAC_LIST_SIZE_BYTE];	/* 0x0800 */
  };
@@ -1383,6 +1389,7 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
  		page_ref_inc(page);
  		kvm->arch.vsie.pages[kvm->arch.vsie.page_count] = page;
  		kvm->arch.vsie.page_count++;
+		vsie_page = page_to_virt(page);
  	} else {
  		/* reuse an existing entry that belongs to nobody */
  		while (true) {
@@ -1393,9 +1400,11 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
  			kvm->arch.vsie.next++;
  			kvm->arch.vsie.next %= nr_vcpus;
  		}
-		radix_tree_delete(&kvm->arch.vsie.addr_to_page, page->index >> 9);
+		vsie_page = page_to_virt(page);
+		radix_tree_delete(&kvm->arch.vsie.addr_to_page,
+				  vsie_page->scb_gpa >> 9);
  	}
-	page->index = addr;
+	vsie_page->scb_gpa = addr;
  	/* double use of the same address */
  	if (radix_tree_insert(&kvm->arch.vsie.addr_to_page, addr >> 9, page)) {
  		page_ref_dec(page);
@@ -1404,7 +1413,6 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
  	}
  	mutex_unlock(&kvm->arch.vsie.mutex);
  
-	vsie_page = page_to_virt(page);
  	memset(&vsie_page->scb_s, 0, sizeof(struct kvm_s390_sie_block));
  	release_gmap_shadow(vsie_page);
  	vsie_page->fault_addr = 0;
@@ -1496,7 +1504,8 @@ void kvm_s390_vsie_destroy(struct kvm *kvm)
  		vsie_page = page_to_virt(page);
  		release_gmap_shadow(vsie_page);
  		/* free the radix tree entry */
-		radix_tree_delete(&kvm->arch.vsie.addr_to_page, page->index >> 9);
+		radix_tree_delete(&kvm->arch.vsie.addr_to_page,
+				  vsie_page->scb_gpa >> 9);
  		__free_page(page);
  	}
  	kvm->arch.vsie.page_count = 0;
-- 
2.47.1


Howver, page->index is going away so use page->private to
> store the address rather than page->index.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   arch/s390/kvm/vsie.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 150b9387860a..26cbd69eb06d 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -1393,9 +1393,9 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
>   			kvm->arch.vsie.next++;
>   			kvm->arch.vsie.next %= nr_vcpus;
>   		}
> -		radix_tree_delete(&kvm->arch.vsie.addr_to_page, page->index >> 9);
> +		radix_tree_delete(&kvm->arch.vsie.addr_to_page, page->private >> 9);
>   	}
> -	page->index = addr;
> +	page->private = addr;
>   	/* double use of the same address */
>   	if (radix_tree_insert(&kvm->arch.vsie.addr_to_page, addr >> 9, page)) {
>   		page_ref_dec(page);
> @@ -1496,7 +1496,7 @@ void kvm_s390_vsie_destroy(struct kvm *kvm)
>   		vsie_page = page_to_virt(page);
>   		release_gmap_shadow(vsie_page);
>   		/* free the radix tree entry */
> -		radix_tree_delete(&kvm->arch.vsie.addr_to_page, page->index >> 9);
> +		radix_tree_delete(&kvm->arch.vsie.addr_to_page, page->private >> 9);
>   		__free_page(page);
>   	}
>   	kvm->arch.vsie.page_count = 0;


-- 
Cheers,

David / dhildenb

