Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793719078;
	b=ZMWPUhO3mjMvY5E3I9KmQ6D4F6Mqt80TjTTUtBpD93Ga6IAfjvM7c6+lCi34E8fQf7Po
	 /RJt1+OYCPX1WYoUjoiQRDVCZsnj9oMeeveHYB+mPWEl+M9g/OgPg8VK812+0UH8oBuYo
	 b4zQF2CYtjM+owdeM0uWWUPMSKtLKuR6N606fRKgi6kQbDBgWkokSAzgyzj00buvtdMBy
	 oK76qnjlr19AlL2RpxEU0YijcDclzXBXMHoYGX195paSIj9lBnXYv/Woo8PVdrziI1E1e
	 JgHOiiy6JfcxcOTo4QJ2WH97kgNHolk3njCzHNGv7xdXBb+R2ly/Fa+7CNQP6YoYU5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793719078;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=bbduBp3PV2PD6ZtgXv4ZkeG/rcdvbrKsRxBHo1Elyzk=;
	b=gbxBtbRDKxz/tFZYbslmw/1PVmW1OPt3BQG3jTXHIomqXsOk67X56Fo4K8NDtmGhLOgw
	 kFWvJn9gEhpW7hdOtrvR3PwTlikxfv8YIgGx39rL2fgqbhCj/1wUTKivwTyWehoEB1t9l
	 2bWHurvCHalcTXoqT04pwkNkPJaeg6F72xxHCOp6kPyQIKdRnMlYaoq/e0Zkon5Osq2ZS
	 oirH1NknV3lhXZJjCZcE3xFvzWatu7jrQLXPVe32q5eqic52e2gpmiiu5BteSx+DXXRQu
	 kDfd4ULkLe/3piwXHVf+BfjN6ndZXDgpAHAtOTaBj4xAiH6jY9/uKvgqhYmnZkgz/nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=e7DD8qBJ;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399AC606B259
	for <linux-s390@vger.kernel.org>; Tue,  3 Nov 2026 15:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 399AC606B259
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=e7DD8qBJ
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ac77270fbfso2158206a91.2
        for <linux-s390@vger.kernel.org>; Tue, 03 Nov 2026 07:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793719078; x=1794323878; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=bbduBp3PV2PD6ZtgXv4ZkeG/rcdvbrKsRxBHo1Elyzk=;
        b=e7DD8qBJGpWmtjaHh/YFm9cGb2nRovcHrUcnolSCv5USqGQbrODopqD08biD7yhSFD
         FQkxV/az1Lk6tF07iqQ/lPqtwr+2a+9ZcJEQle08PfN1QLtvcrJbo+oczRXiBF2TIVoo
         unnrc+2k70Ettv3/2bG4z8DvoF9t7yb9GhGho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793719078; x=1794323878;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bbduBp3PV2PD6ZtgXv4ZkeG/rcdvbrKsRxBHo1Elyzk=;
        b=gvvyyaWHvpQIrQT7drUgB0GW2TtJ4K6Mk7leUyVzT0xffAltXa5Shsb1/o3jOdSbPF
         W5f/zyV1K67XPYRXgwC7DFrxDScKs25EyUwLzUe7BBf0WyqauaycbNAaIQgQMvJfhgzm
         nBouMOeQiMbs9xn5bcsrzhxu7VdqB3mc1w0j6Qy59/LKWDP3QRlU8rjO/RVSpVxRRjmj
         X1zoI2hKllCO3XJ9FJ9xyI8lZLWq2snBq9XYffMflUGlVx4oXzV/D4cUsbPokuQBJYkF
         6E0d9p48LhNHF3/WLdnt0jI8G5yUgU+D46zQLbszBO0MSjBJrJzpc19SwYmcsiG4ih3+
         JTRw==
X-Forwarded-Encrypted: i=1; AKwUvBzQvMmiZOnwcSE8ndbwIb0lphcU8DqYbJpl3E/ZafgnFEhnDk/baCNrLP8GfjS9ExkHRGh+NsLX+7PR@vger.kernel.org
X-Gm-Message-State: APuU4Z99D51H7d1exycJwBGK0FsS5tbr+m7lYTH5BujzziE92BAqgdMb
	+lznl2gtqqmUz4qw7jUVImRW1BMrQIMQI7XXjdgfZh91LlpTPy5XXMxH6qQZEcsqCik=
X-Gm-Gg: AYBFou1okMttGBS/33JXKu8L1qzKpyLWRvFTgDrxYcelBNOs1z2tghT5QnlM9EsWgES
	jlNu3SXLb5njs6aO52oTgiG8Z8EL066uI8hBnujQS4cDwPaDGsgj02eGinh1JFtuyDmpcvkTUxZ
	FIuyj/Kw+ntWp96or0cZsVFSS2u/JtiuWAmBn6notkaGnZWq5xa4LMJuyQY/s95wsChBVJA+Fl5
	07oHKS2pzGB9DAWl9fDLz+rp0NnnMQc6YI2mJXmbZ8bQbEXtHk/XH+9GAEF4mJvJyiKJfU7dzH8
	AUmWPNaCeHbtxEcqh+B1A13kIsdk3oQUbJ8sSsLKv0u+FTYkdBdS3fqw6p/zfRtJeTjaN8f52pQ
	/Yj6iaM2T6Lbqgd+eC/E6qoaYinD+dWVdm+ffaxYLxx+MLP23YblcAWxhgn+DPdQFjk8rPgbp6n
	Rqvcw7z4zDpjOyxNXAsKevldC2UB8ijp5AdwC9G1K741ER/tCuOJgUND8Zuo19oiZqv4z1/fFpe
	ChsuID6jdo7yuFtDjtTE4077ehoBC76CByFXG9WerqSBSRMDRjcMvp+H4OS+gAEpr42nktbyJXn
	dkNOwQzVcI9ps4jsI29avZvm4Ag07XSC4NRXXDqA2hWLiHLHqt6sjGKrTJTPflBAM+mcHwL4RlE
	1t0koQF+M25pHIpM0BPYT1b/+G+iObqDG4vFokvdbvGX9LYeXuGrMuKSdV8vPboUN6hvO41fA
X-Received: by 2002:a17:90b:4e8f:b0:3ac:4e18:238c with SMTP id 98e67ed59e1d1-3ae89806287mr10222361a91.49.1793719077568;
        Tue, 03 Nov 2026 07:17:57 -0800 (PST)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae87f69605sm10791677a91.2.2026.11.03.07.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 07:17:56 -0800 (PST)
Date: Tue, 3 Nov 2026 23:17:54 +0800
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
Subject: [PATCH v2 1/8] selftests/mm: Move sysmap_is_sealed into mm
Message-ID: <1e2cfbe24810f976ee6e176346598900295adc73.1793718940.git.chris@chrisdown.name>
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

System mapping sealing is an mm feature, but its test has its own
directory under tools/testing/selftests rather than living with the
other mm tests.

Let's move it into tools/testing/selftests/mm and run it with the mmap
tests. Its config now comes from mm's config fragment. The test itself
is unchanged.

Suggested-by: Lorenzo Stoakes <ljs@kernel.org>
Signed-off-by: Chris Down <chris@chrisdown.name>
---
 tools/testing/selftests/Makefile                            | 1 -
 tools/testing/selftests/mm/Makefile                         | 1 +
 tools/testing/selftests/mm/config                           | 1 +
 tools/testing/selftests/mm/run_vmtests.sh                   | 1 +
 .../{mseal_system_mappings => mm}/sysmap_is_sealed.c        | 0
 tools/testing/selftests/mseal_system_mappings/.gitignore    | 2 --
 tools/testing/selftests/mseal_system_mappings/Makefile      | 6 ------
 tools/testing/selftests/mseal_system_mappings/config        | 1 -
 8 files changed, 3 insertions(+), 10 deletions(-)
 rename tools/testing/selftests/{mseal_system_mappings => mm}/sysmap_is_sealed.c (100%)
 delete mode 100644 tools/testing/selftests/mseal_system_mappings/.gitignore
 delete mode 100644 tools/testing/selftests/mseal_system_mappings/Makefile
 delete mode 100644 tools/testing/selftests/mseal_system_mappings/config

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 07c3719f8b04..94276b1310de 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -84,7 +84,6 @@ TARGETS += mount
 TARGETS += mount_setattr
 TARGETS += move_mount_set_group
 TARGETS += mqueue
-TARGETS += mseal_system_mappings
 TARGETS += nci
 TARGETS += net
 TARGETS += net/af_unix
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 675ec57d47de..94e305643c8d 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -110,6 +110,7 @@ TEST_GEN_FILES += folio_order_check
 TEST_GEN_FILES += khugepaged_sync_check
 TEST_GEN_FILES += khugepaged_race
 TEST_GEN_FILES += soft-dirty
+TEST_GEN_FILES += sysmap_is_sealed
 
 ifeq ($(ARCH),x86_64)
 CAN_BUILD_I386 := $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_32bit_program.c -m32)
diff --git a/tools/testing/selftests/mm/config b/tools/testing/selftests/mm/config
index 06f78bd232e2..b93b49cd675f 100644
--- a/tools/testing/selftests/mm/config
+++ b/tools/testing/selftests/mm/config
@@ -14,3 +14,4 @@ CONFIG_UPROBES=y
 CONFIG_MEMORY_FAILURE=y
 CONFIG_HWPOISON_INJECT=m
 CONFIG_PROC_MEM_ALWAYS_FORCE=y
+CONFIG_MSEAL_SYSTEM_MAPPINGS=y
diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 973cb715b326..573da5006268 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -307,6 +307,7 @@ fi
 
 CATEGORY="mmap" run_test ./map_populate
 CATEGORY="mmap" run_test ./droppable
+CATEGORY="mmap" run_test ./sysmap_is_sealed
 
 CATEGORY="mlock" run_test ./mlock-random-test
 
diff --git a/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c b/tools/testing/selftests/mm/sysmap_is_sealed.c
similarity index 100%
rename from tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
rename to tools/testing/selftests/mm/sysmap_is_sealed.c
diff --git a/tools/testing/selftests/mseal_system_mappings/.gitignore b/tools/testing/selftests/mseal_system_mappings/.gitignore
deleted file mode 100644
index 319c497a595e..000000000000
--- a/tools/testing/selftests/mseal_system_mappings/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-sysmap_is_sealed
diff --git a/tools/testing/selftests/mseal_system_mappings/Makefile b/tools/testing/selftests/mseal_system_mappings/Makefile
deleted file mode 100644
index 2b4504e2f52f..000000000000
--- a/tools/testing/selftests/mseal_system_mappings/Makefile
+++ /dev/null
@@ -1,6 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-CFLAGS += -std=c99 -pthread -Wall $(KHDR_INCLUDES)
-
-TEST_GEN_PROGS := sysmap_is_sealed
-
-include ../lib.mk
diff --git a/tools/testing/selftests/mseal_system_mappings/config b/tools/testing/selftests/mseal_system_mappings/config
deleted file mode 100644
index 675cb9f37b86..000000000000
--- a/tools/testing/selftests/mseal_system_mappings/config
+++ /dev/null
@@ -1 +0,0 @@
-CONFIG_MSEAL_SYSTEM_MAPPINGS=y
-- 
2.54.0

