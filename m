Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793719108;
	b=uD0uKiXETm9s2XTUEiqGvldwy50MIE8QuOP4p3Dk7Uzfh9miai/aWrAsl2xka0yGiRH9
	 7hTOUh9xQqFtzMgUNyB+f/J2m4AxQwNsWoYb+PVgSeTyQcoGPVueGe8cpkM2ZIup0Arn8
	 V74HI3D26PXzG0cuPiIvMCC33wS9osXDR/U7NOAf0kAldq8ZkWWhqWu4dXtcvdSyqirPl
	 bpC3P6921RoAyvZTnYkQXFCZ6/DvtbjXNRH6gHnSnYp3CKOI9qVAx/twCXK7CNLRwMwQy
	 D32AZrSXHQZ6MkqzAVkK6mmXSzt05ECDxQnl/XQMGaJbrsUVaYs/Sm/94GcO9dS1uOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793719108;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=DEpA7EB35ETX+QEM+S0rPeRue+CXb/aqgZ9fcs/1WrA=;
	b=gOZOEIEBy/RoMzLn3S4LU58J2DH1Ghl+TUUrmz0zpH7+YISZcDUDW2R50YudrLylxAlk
	 n598XfV8/Zt3w2QV3/cyS7pJo4Bi77dvHJSONCclP+z1qotuUFvLJqoHpP7OY6I8DBnly
	 HBR8tK8UutBHKp1SV7xhWgP7avWePYzUCFT4MaG94N12coc1q7UGP35FNSNX94ngNqNx0
	 mDa7OOkqIgiL3cVv4N+AXsT4HITpUdn8JISlq9VjiQi85s0YKCLeMVjIIPraqik77f5CO
	 ZnK6xpKNzauSVU26Q1VkNof6vokrvrht6NFsEc2kIFBFM5TGsybd37VsBChoWQHYnTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=iJQAdWul;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BF7606EE8F
	for <linux-s390@vger.kernel.org>; Tue,  3 Nov 2026 15:18:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6BF7606EE8F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=iJQAdWul
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e98798cbddso20813135ad.0
        for <linux-s390@vger.kernel.org>; Tue, 03 Nov 2026 07:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793719107; x=1794323907; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DEpA7EB35ETX+QEM+S0rPeRue+CXb/aqgZ9fcs/1WrA=;
        b=iJQAdWul3W/CUJhIrS5dvX0eM6WuXTz1S48rZb7FrM5HAGY2k2eULG3UN7fMf2HesU
         BgcewLwYarj5CoCIUK0cf985AauuA6PTll3ljWMb/GhZikHr2S8DKVa6H7UHtVmQA1VC
         Y1mKhneDjNU802KN7Ay4+ex61G7mP1iOn6T9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793719107; x=1794323907;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DEpA7EB35ETX+QEM+S0rPeRue+CXb/aqgZ9fcs/1WrA=;
        b=l6/hBLyIa06GLP2iKBtAlyu8jPiRVOzeY7SNnYQymBC/2Hmh1zRrb4ipLrxBX4vNa9
         Ux5z6Y+B/LJVIUOWHssbK+nmjjKe05ME1XkSYInHdkeCM+/CII4PNl1bAYrDhDvC4oBQ
         ZFtLgc5gSH3dRWB0rmY1ZzdyBZcimoKZ1QVY110ne5UhUQ6Lwnc8opVIny7ixnI/wG4m
         EZQSSv10dheX9atCTzeZUQKmrQoPPRh+Iwiwk5OFfAto4Q5ZarWMYVJtnkPS7N+a7yxk
         /cE9JV+WK9a2gRdl5sjCFlMCRvlGxA3YZDX9JJt53nd9l3BFMgxFZxWeATAhk533BE08
         zXOA==
X-Forwarded-Encrypted: i=1; AKwUvBxJ0m7pCJHOseuHlINzMxk+CCc28ghwxL3FBi/jogcyGvRh3b5hBE6mENPfFC1S7fp65fZ8eE9uj/ga@vger.kernel.org
X-Gm-Message-State: APuU4Z+f8IztI/hNRRSxRxFxAIWgxmLlZgAhTlkjPVcdB83dax2CMeIi
	YyX3gZj9By1pj6tah7qE9Hvmn0igsp8kQCyU+BlHO4K+LfPltjeRrfR4rQbi+5ERyTM=
X-Gm-Gg: AYBFou31f9f9sRT5Rt0DN8iLApVS3JBzBBINhmJP3X7xV4ErQkVYCZAtyapuveNhfcK
	a4TvHLnFqrXRX1HtZvMPwkS5LXmZg4KD2aR16oDSA00MlPAogUROx4ar2WGWLo+OmPE2IaaJkhu
	lO4DYXskL4V8JwWuzwzff7JpES7ODP6os4SnK1hD8b1j5Od/9rzZgBfbzIp1vKhD1xVvTWpYE2e
	wkdxPAwFK3+8jmjBBRDPsR+09oF4nO4lI/G3Q8HYEGPCEN/O2J4gRVLNkfyZ1jyUu0RBJG5fguu
	Z0BdQHnlf6SBk+Uz1qf1fmL+ktWnxHsOGP1xvpCMq0jl44+CrvqkI5TiVYrr9KV1IUsAb4r46gb
	ySr6Ld/SAu+rZ9VdobNO73XStt3gL7Kr1JDw5vHbqHVUXmhAonVWYHd6MwZgpK3yE+kMkDzTNXc
	Vg03qb7Ed4VaU2IgSHO2adG9d2DI0isXyzYX1w8x2dwmqwmYT+Wjsib4A6wy2NDQAHcydTWQMnt
	jW2YhSFg2rxXpRprS7Yz65w28ffEWvwKemNeZ2Qenp6S1eUrVOYgoIZYpWEo5UCy5whwaXg93Zo
	v88bhg7qWt1IJbf76yRaZCWcrKoc5wHjE89XIwAxY2B2Cvx4fqgwxLnDTo7yJ671q3dvYa8+N+t
	z15MCB+bMW+ZS2DKgV7M89+XHRcvw4/UiZWkgKXkoSkcsAAhsegpEFgbs62abETtOTy8VVPrxxF
	4EDoUZrLxQGjdO+4zg7MU=
X-Received: by 2002:a17:903:1aef:b0:2e2:f2f9:b1ef with SMTP id d9443c01a7336-2eb364bc076mr131151785ad.39.1793719107092;
        Tue, 03 Nov 2026 07:18:27 -0800 (PST)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb392613bbsm43426035ad.37.2026.11.03.07.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 07:18:25 -0800 (PST)
Date: Tue, 3 Nov 2026 23:18:23 +0800
From: Chris Down <chris@chrisdown.name>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>
Cc: Jeff Xu <jeffxu@google.com>, David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>,
	Andrey Vagin <avagin@gmail.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Shuah Khan <shuah@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH v2 4/8] mm/mseal: Move MSEAL_SYSTEM_MAPPINGS to mm/Kconfig
Message-ID: <6d72b96fdd36c8870393d8d6e67a811a9bce9e4f.1793718940.git.chris@chrisdown.name>
References: <cover.1793718940.git.chris@chrisdown.name>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793718940.git.chris@chrisdown.name>
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)

MSEAL_SYSTEM_MAPPINGS is in security/Kconfig, but it's an mm feature,
it's implemented in mm, and changes to it need to go past mm.

Let's move it to mm/Kconfig, next to the other VMA features. No
functional change.

Suggested-by: Lorenzo Stoakes <ljs@kernel.org>
Signed-off-by: Chris Down <chris@chrisdown.name>
---
 mm/Kconfig       | 21 +++++++++++++++++++++
 security/Kconfig | 21 ---------------------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index afff1b25b543..40172787dfa7 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1355,6 +1355,27 @@ config ANON_VMA_NAME
 	  area from being merged with adjacent virtual memory areas due to the
 	  difference in their name.
 
+config MSEAL_SYSTEM_MAPPINGS
+	bool "mseal system mappings"
+	depends on 64BIT
+	depends on ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
+	depends on !CHECKPOINT_RESTORE
+	help
+	  Apply mseal on system mappings.
+	  The system mappings includes vdso, vvar, vvar_vclock,
+	  vectors (arm compat-mode), sigpage (arm compat-mode), uprobes.
+
+	  A 64-bit kernel is required for the memory sealing feature.
+	  No specific hardware features from the CPU are needed.
+
+	  WARNING: This feature breaks programs which rely on relocating
+	  or unmapping system mappings. Known broken software at the time
+	  of writing includes CHECKPOINT_RESTORE, UML, gVisor, rr. Therefore
+	  this config can't be enabled universally.
+
+	  For complete descriptions of memory sealing, please see
+	  Documentation/userspace-api/mseal.rst
+
 config HAVE_ARCH_USERFAULTFD_WP
 	bool
 	help
diff --git a/security/Kconfig b/security/Kconfig
index f7bf6cdc6229..1679e8d009c3 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -49,27 +49,6 @@ config PROC_MEM_NO_FORCE
 
 endchoice
 
-config MSEAL_SYSTEM_MAPPINGS
-	bool "mseal system mappings"
-	depends on 64BIT
-	depends on ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
-	depends on !CHECKPOINT_RESTORE
-	help
-	  Apply mseal on system mappings.
-	  The system mappings includes vdso, vvar, vvar_vclock,
-	  vectors (arm compat-mode), sigpage (arm compat-mode), uprobes.
-
-	  A 64-bit kernel is required for the memory sealing feature.
-	  No specific hardware features from the CPU are needed.
-
-	  WARNING: This feature breaks programs which rely on relocating
-	  or unmapping system mappings. Known broken software at the time
-	  of writing includes CHECKPOINT_RESTORE, UML, gVisor, rr. Therefore
-	  this config can't be enabled universally.
-
-	  For complete descriptions of memory sealing, please see
-	  Documentation/userspace-api/mseal.rst
-
 config SECURITY
 	bool "Enable different security models"
 	depends on SYSFS
-- 
2.54.0

