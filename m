Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EBC2D5A13
	for <linux-s390@vger.kernel.org>; Fri, 19 Dec 2025 05:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766122962; cv=none; b=mFpRyrnPxyMDJkhxlNSbqJLq4NWJhZqPCoNkA0zo5msC3uueedayxmmAXVyeLq37KginWZki1DBEgN/CuXbxmv8QyN1AsgFraWas8zVUtOSCa+D2VCc6FP8xG7zTCyUSrv8FMSu08aF8NS+usn5V7Zo9PQTKAus2QoL78J7dlvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766122962; c=relaxed/simple;
	bh=IEnkmMkvBLHbjCpXsYVUXQfPmf3NVslrHp9Qvjpb+dw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=IkpWF7QUtgPqceo490ft0B0+AQP9P8sYCZsOCXMF3IXdSUPkvOTzwCC4rOTnW/jrZpIeoyDzpQj85UZsUVMKy0EnRZTPaEh4AJGhfORBspqClSgVoLatEaztanWptTut53rwctIizAgqPU2kUmw9vmbDKtZBP791c8fCkG78CIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIVMHVzf; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIVMHVzf"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso1413558b3a.3
        for <linux-s390@vger.kernel.org>; Thu, 18 Dec 2025 21:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766122955; x=1766727755; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3YZTuXKJS0jJ/FjWVkX1S0/dpihzlaBm67evQ8OxNp4=;
        b=TIVMHVzf80UtOLy3yfMtE3Vgfltrpx+uPHBdjn7XLOnyzztJRO8IUwWfBcNXRW/GdL
         VH4hQFJ5YmfFbnuG9nmMvmsXSFhNhjf0B0m40fdz55di93/8GTJKxRDoIA+EjhGwchdM
         xdK471r0j2fWAA5Ragz7jdneYFW8MCn0vMcYO1W5XtEVvLit/cmVlmwMS1AWTsmxfHTO
         Td9XNDvoQCkssMWKSx+H4mYi5iLufhsfVWxNq87UQWlLq9yFJqAntzbHeD2jkkTcWolr
         qZgH3mSqEnGLtUtx1ixzYDKB84HsCJBoeUAOe2ZnBUPreP/b1TgmwzJMp4aX4/EtZrUU
         0S3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766122955; x=1766727755;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3YZTuXKJS0jJ/FjWVkX1S0/dpihzlaBm67evQ8OxNp4=;
        b=hnOvePLybSXczkuvZoQI4YtsX0rhIN8udGp+0/iqhi70Tt4h3V4E0Fjtj9IeJgx2ug
         D1iyj2617iHXNXqszvEOA0c2/XFDFOYcA+nvYGBjmcLVn9MrCLRtnU/CnmILO1ofWf+G
         ZsE0P7JoutsiE6FZvQrl9nihqIiM1dLhlmAxdcXNLiDUMLXz/dFem5lmPxVYCk8Nhxoe
         YMrEvOIRib0i8dvd24VDieWmR65loqDPj4zbbT0ijsmvSbZ0FtTo7gu4csM62YBH3QS7
         UbIziDLix6i5ilel2gLpnsAqItvhlo05anjn82+W8jjrsHa8GlY1uzEAYikF0sBK1Rb2
         99gg==
X-Forwarded-Encrypted: i=1; AJvYcCUqjoF3d8SNUiEcd3amfRTKkjt2KD1yiwEOWp5+1WNShNwnqoN6dhW95TE6Vlu0IJDR92hoRJQpFqk/@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3O09VG+T3wHVdc1hN/BZhhMfBuj21+93KNesf5zwvXOOED8mV
	EH+QGMMQMhZEIYajvWqr33nTPZAnXZMLhjuJOngSLMm+oMQDPIK3VeQApKitH+iD4dw=
X-Gm-Gg: AY/fxX6fdhO3IVJSSPmrNa5idQ1X6dKj3He0+e9jDklo0Zjzd+zX+rmIU5l61uy4CjZ
	Ca3WPzyrEJ3G0EBeorekKM3MaPrJ6XTco6gYOKGwCeIWdDKIUiAZGtfZV6mE0R4lbTEN++RX4Hr
	T/VRnHOynaw4NQNa2mXQHdh+yQqmrp9VKefzqvEyVRFs7MxCvaLDN520KLmos6LyNNCPKe6hDb2
	K+C7y9c61L1u+sCDqlJT4+Ed3NutT4ouA23vPWjNkFNe8WwVz0/YRTfsBm3ov5Fv2HDpt4oWxL3
	Gg3aWsY/QuLcbQxuECRCeI3rRG+6iSoCuRpwissaJ/+Uc1YRhgijLIOZQ1VWgLScxWFaXv1mCAP
	9Cmy0dAVsqPQc/XrUKSgaSAS18ip48OPw7PZUag6b2HsI5lPbahI+vtUsnfN6OVzoHum+EId+Dr
	mMzm0BAg==
X-Google-Smtp-Source: AGHT+IGI8fuFuucCjImuX4l87nELJyNl9OPjlv6P1lULzof6E2V8PchTbygl/w/ZX4miaVw5gIXTMA==
X-Received: by 2002:a05:6a00:414b:b0:7e8:450c:61b6 with SMTP id d2e1a72fcca58-7ff6607cf9emr1880110b3a.38.1766122955457;
        Thu, 18 Dec 2025 21:42:35 -0800 (PST)
Received: from dw-tp ([203.81.243.211])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e0a19besm1067558b3a.40.2025.12.18.21.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 21:42:34 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Christophe Leroy <christophe.leroy@csgroup.eu>, David Hildenbrand <david@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, x86@kernel.org, linux-arm64@lists.infradead.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5] mm/hugetlb: ignore hugepage kernel args if hugepages are unsupported
In-Reply-To: <20251218114154.228484-1-sourabhjain@linux.ibm.com>
Date: Fri, 19 Dec 2025 09:45:06 +0530
Message-ID: <875xa3ksz9.ritesh.list@gmail.com>
References: <20251218114154.228484-1-sourabhjain@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

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
> For example, fadump kernel booting with the kernel arguments
> default_hugepagesz=1GB hugepagesz=1GB hugepages=200 prints the
> following logs:
>
> HugeTLB: allocating 200 of page size 1.00 GiB failed.  Only allocated 58 hugepages.
> HugeTLB support is disabled!
> HugeTLB: huge pages not supported, ignoring associated command-line parameters
> hugetlbfs: disabling because there are no supported hugepage sizes
>
> Even though the logs say that hugetlb support is disabled, gigantic
> hugepages are still getting allocated, which causes the fadump kernel
> to run out of memory during boot.
>
> To fix this, the gigantic hugepage allocation should come under
> hugepages_supported().
>
> To bring gigantic hugepage allocation under hugepages_supported(), two
> approaches were previously proposed:
> [1] Check hugepages_supported() in the generic code before allocating
> gigantic hugepages.
> [2] Make arch_hugetlb_valid_size() return false for all hugetlb sizes.
>
> Approach [2] has two minor issues:
> 1. It prints misleading logs about invalid hugepage sizes
> 2. The kernel still processes hugepage kernel arguments unnecessarily
>

And that every other architecture will have to duplicate this in their
arch_hugetlb_valid_size() whenever they face the same problem.

Instead like at other places, hugepages_supported() should also be
checked in the following cmdlines setup functions.

> To control gigantic hugepage allocation, it is proposed to skip
> processing the hugepage kernel arguments (hugepagesz, hugepages, and
> default_hugepagesz) when hugepages_support() returns false.
>

Right. Thanks for taking care of it. I guess after this patch [1] moves
hugetlbpage_init_defaultsize() to mmu_early_init_devtree(), it's good to
bring back these checks in the respective cmdline setup functions which
was removed as part of commit [2]

[1]:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2354ad252b66695be02f4acd18e37bf6264f0464

[2]: https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c2833a5bf75b3657c4dd20b3709c8c702754cb1f

LGTM. Please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
