Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90627481DD
	for <linux-s390@vger.kernel.org>; Sun, 21 Dec 2025 07:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766301135; cv=none; b=o3Si1+rKEapp5kgrL4n2FjQLUYgqpcDGxDXAU8mpjPps2XlGHrmRhVrfvSyxX4R5V+xliBSr1CvV4I3aq3LMtUtwBtDOaXedh//4PUF8Om85heuq5nKe9u0IKn+P2U4uFN45FmalrUpd0ls+QThC47NXHtNPq21V+rQRoRhrfik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766301135; c=relaxed/simple;
	bh=m8c1VhMNRt9AL2UX52j+Tb3cEm8nXSpC5tHKcEGsx48=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=ExdjmxCCTfWlfN8CWNoH/NJYb8jno6241s19t1ss4fY11IoEx99poci7qX6OU1KqCVIpi72qVK2+PeIdcIVA3u86hxF80q56KUZptj61sTUKMDnh5F3aQdjktUFB9swQvQaaRCGXoqn9lefDiGDjkjN3Y9L9BKCyBbLukZ0QSjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRxLKUiu; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRxLKUiu"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a1022dda33so24967145ad.2
        for <linux-s390@vger.kernel.org>; Sat, 20 Dec 2025 23:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766301133; x=1766905933; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qzCtCXPpJksCwKOWKXvWbqXbkA87udvkBHpHfw0vp1Y=;
        b=bRxLKUiuCCT/XscZ04KVQV25fnpXI7urBLSJsu7hWcW0HIvCabqrC0EXm6t+5PaObl
         oyfHzMrL1dZhn7iRC4DKfEmQ+JLtsE58Q/bKHJFsyt5ca52iRhgbPNc+LPbNgR7QA0Ch
         wHL8wwSkWcUs32Oa142UDLIsU1Or4Mr4hl1WBk/U7P9b2dKBYYmILWchWI82AFEET66L
         1rpxwRF2G5KLuopeB2iaX7zG3zFJm5VXPnR04Z/FhFOm7aldLoosP7nAHSGj5k1QdjTo
         JCHo0Pqcf1+N51WHszjmIdIfoo5O+paCsJW5WL20aNQNMNEFsU8SmzfzMuwAEE9pM+mm
         bveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766301133; x=1766905933;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qzCtCXPpJksCwKOWKXvWbqXbkA87udvkBHpHfw0vp1Y=;
        b=WnTnnG+0bv+Fl4R2TNLUKzGAjihJdZBzuSFYSZ5wuJD+TCjBvWfktGNEs07kYFtlPh
         DfDKRhu7C3RSRkqRODNnQEMLOFzcofK7wG51fy09FwDsMvOLJftSnP8Qa885Ij886nOn
         VToPockGFkfciW0R4lnPiTykzvLxHMYkXnleEUzNg8O+f7FQlHtOpmYDgxTAKumZIl2/
         +pb2NbVqLaj0o5YUSqpraO/bsLSCf9UTVszjH/nf6VxFiH0n0rtFVa1eQaAaKrdvsmeP
         0/kW+eMM0e7ciEyP63lO4wLOgunPI7JakHsZvO2kk+i2lbFu2V1+Er2+Q7dlzDA62zsr
         syJw==
X-Forwarded-Encrypted: i=1; AJvYcCWZVw8/NIt5FKfGOVTOJLe1Uv3H6MVvbAm99eexXBxV0qkcySN1EL/Lj6PKbpk/Ox9jiwg88+wRYTF5@vger.kernel.org
X-Gm-Message-State: AOJu0Yyen2Mh42x/ays5iiNiLZLlyrQGWVCti8r1Ies3Q3faGpl2sI8P
	DTH5+eqw0WB40tOP33/aa45BF/hdu+3MxYsoqHJo2oFlTCVi06al8yqD
X-Gm-Gg: AY/fxX5c8FGB3tTYksWj7mUYOn087DJ4S1EHOs+WZSjDkuHC0oQ4k4FuPXKQf5IzBfX
	FqU4i3N7LBNAnGUJOTlfjM1aFKnAzsID/C7cbg9bdQE1NBDHbcMpJL1KT9htVap96v2OwsIXfN/
	0xnUSYs5qDCMI/mD35ROM853sJeZ/XzN1Njw8Y0IdtvZUfUEZ3goXTsIwEnErWz08hGMxujB2DJ
	oPw5wzLSzh36HY8VsWWHX6wrV6BG9v5SdkU09x0ylyB0EHyCrt6bd8T9L5hpiJADabh3zuv+AwT
	8lwt29iQ8aAp/wfpVYqYl5ozLxY4XGbY6tRLZ6XChw1B6IrXQxYoPfiXCPLVLHqV2sguIBOiFUv
	Ksfm0RJ88m/2hHikACyxalvOrT+B7ixIp0MgVxFUeA8jPcDSWbVWOibp+/VHSdK0izVr/jRaNpf
	E54rEb
X-Google-Smtp-Source: AGHT+IGIPYFeedEPq4NHjeRfIrATjm+rPLqP/z//FB66WtSOi9nspDfl3x3TE/ddBevIS7cWXjTI7Q==
X-Received: by 2002:a17:902:d488:b0:2a0:9b4f:5ebd with SMTP id d9443c01a7336-2a2f2229d26mr67255515ad.15.1766301132600;
        Sat, 20 Dec 2025 23:12:12 -0800 (PST)
Received: from dw-tp ([171.76.81.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c828dbsm63727595ad.22.2025.12.20.23.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 23:12:11 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Christophe Leroy <christophe.leroy@csgroup.eu>, Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, x86@kernel.org, linux-riscv@lists.infradead.org, "David Hildenbrand (Red Hat)" <david@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] mm/hugetlb: ignore hugepage kernel args if hugepages are unsupported
In-Reply-To: <20251221053611.441251-1-sourabhjain@linux.ibm.com>
Date: Sun, 21 Dec 2025 11:29:25 +0530
Message-ID: <87a4zcml36.ritesh.list@gmail.com>
References: <20251221053611.441251-1-sourabhjain@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>


Hi Sourabh,

Sourabh Jain <sourabhjain@linux.ibm.com> writes:

> Skip processing hugepage kernel arguments (hugepagesz, hugepages, and
> default_hugepagesz) when hugepages are not supported by the
> architecture.
>
> Some architectures may need to disable hugepages based on conditions
> discovered during kernel boot. The hugepages_supported() helper allows
> architecture code to advertise whether hugepages are supported.
>
> Currently, normal hugepage allocation is guarded by
> hugepages_supported(), but gigantic hugepages are allocated regardless
> of this check. This causes problems on powerpc for fadump (firmware-
> assisted dump).
>
> In the fadump (firmware-assisted dump) scenario, a production kernel
> crash causes the system to boot into a special kernel whose sole
> purpose is to collect the memory dump and reboot. Features such as
> hugepages are not required in this environment and should be
> disabled.
>
> For example, when the fadump kernel boots with the following kernel
> arguments:
> default_hugepagesz=1GB hugepagesz=1GB hugepages=200
>
> Before this patch, the kernel prints the following logs:
>
> HugeTLB: allocating 200 of page size 1.00 GiB failed.  Only allocated 58 hugepages.
> HugeTLB support is disabled!
> HugeTLB: huge pages not supported, ignoring associated command-line parameters
> hugetlbfs: disabling because there are no supported hugepage sizes
>
> Even though the logs state that HugeTLB support is disabled, gigantic
> hugepages are still allocated. This causes the fadump kernel to run out
> of memory during boot.
>
> After this patch is applied, the kernel prints the following logs for
> the same command line:
>
> HugeTLB: hugepages unsupported, ignoring default_hugepagesz=1GB cmdline
> HugeTLB: hugepages unsupported, ignoring hugepagesz=1GB cmdline
> HugeTLB: hugepages unsupported, ignoring hugepages=200 cmdline
> HugeTLB support is disabled!
> hugetlbfs: disabling because there are no supported hugepage sizes
>
> To fix the issue, gigantic hugepage allocation should be guarded by
> hugepages_supported().
>
> Previously, two approaches were proposed to bring gigantic hugepage
> allocation under hugepages_supported():
>
> [1] Check hugepages_supported() in the generic code before allocating
> gigantic hugepages
> [2] Make arch_hugetlb_valid_size() return false for all hugetlb sizes
>
> Approach [2] has two minor issues:
> 1. It prints misleading logs about invalid hugepage sizes
> 2. The kernel still processes hugepage kernel arguments unnecessarily
>
> To control gigantic hugepage allocation, skip processing hugepage kernel
> arguments (default_hugepagesz, hugepagesz and hugepages) when
> hugepages_supported() returns false.
>
> Link: https://lore.kernel.org/all/20250121150419.1342794-1-sourabhjain@linux.ibm.com/ [1]
> Link: https://lore.kernel.org/all/20250128043358.163372-1-sourabhjain@linux.ibm.com/ [2]
> Fixes: c2833a5bf75b ("hugetlbfs: fix changes to command line processing")


I appreciate our proactiveness to respond quickly on mailing list, but I
suggest we give enough time to folks before sending the next version
please ;).

Your email from last night [1] says that we will use this fixes tag but
you haven't even given us 24hrs to respond to that email thread :). Now
we've sent this v6, with Acked-by of David and Reviewed-by of mine,
which seems like everything was agreed upon, but that isn't the case
actually.

My main concern was - 
A fixes tag means it might get auto backported to stable kernels too,
which means if the fixes tag is incorrect it could even break stable
kernels then. 

[1]: https://lore.kernel.org/linuxppc-dev/041352df-41ce-4898-8535-d6b7fd74a52b@linux.ibm.com/T/#m6e16738c03b2b2a8d09717f6291e46207033507a


Anyways,
Coming back to the fixes tag. I did mention a bit of a history [2] of
whatever I could find while reviewing this patch. I am not sure whether
you have looked into the links shared in that email or not. Here [2]: 

[2]: https://lore.kernel.org/linuxppc-dev/875xa3ksz9.ritesh.list@gmail.com/

Where I am coming from is.. The current patch is acutally a partial
revert of the patch mentioned in the fixes tag. That means if this patch
gets applied to the older stable kernels, it would end up bringing the
same problem back, which the "Fixes" tagged patch is fixing in the 1st
place, isnt' it? See this discussion [3]...

[3]: https://lore.kernel.org/all/b1f04f9f-fa46-c2a0-7693-4a0679d2a1ee@oracle.com/T/#m0eee87b458d93559426b8b0e78dc6ebcd26ad3ae

... So, IMO - the right fixes tag, if we have to add, it should be the
patch which moved the hpage_shift initialization to happen early i.e. in
mmu_early_init_devtree. That would be this patch [4]:  

[4]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2354ad252b66695be02f4acd18e37bf6264f0464

Now, it's not really that the patch [4] had any issue as such. But it
seems like, that the current fix can only be applied after patch [4] is
taken.

Do we agree? 

<...>
> Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
> Changelog:
>
<...>
> v6:
>  - Updated commit message with additional logs and tags
>  - No functional changes
> ---
>  mm/hugetlb.c | 16 ++++++++++++++++
>  1

-ritesh
