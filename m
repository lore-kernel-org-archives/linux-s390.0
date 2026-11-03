Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793719071;
	b=XLB9NM4przJ+JbFhvP4187Qius1hGawPbBCf0wH9eDrBDw+grAnX7dDARk9lShHoYP+4
	 DjITBNjqE+ooX9NepMssAVZF/SmiwrxFQdoJ/1WJ54w0IWQYcuH/CxcTJqkjjCIZ88ab7
	 gMW+4IZwOFzEFl1mPjMWYEi+4ZHwrVtNiBWLX1wHvFQQbqDBAifqvPz69drWyIJgepshi
	 dr68v1s7QuUCYdbjc50vmlYzY0p3sWrtO0jRoiCWSIObcjAmhHIrOD6SaPuBTdSnNKyse
	 3mhIaOQjPAz3pv9WPg669xvHUkk54XpPVT0tn0e/XrehbDo3nvmugduhcTQBxivWRXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793719071;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:User-Agent;
	bh=Kv57rrW9AR5Uyx8+S36d+hVUEIxbqmnbUnmaj9pRDPc=;
	b=T9eNTrKE/rQC1uoPKozEidHnPUcgNhU3qsEOIXojiM4+H6B6zdM1csutaCk61euOLZQ5
	 mYVFq/jzFpIEfgvvE+N6JIINAasJJq0ikjBEPc/kK1FRhu/1ujuQ8of/D7moW7fot7y3o
	 Pzx+TXGhtXEkPMvt8ggK2pduxSWOTSot/31Dp9dexOCmIYY/tGyZv3j3ksGzv7HM+Ay21
	 K2BYX4iBjl2kcR7g7U4pJjb/LxyeT+F812kpaHXjYWxzTD8zum406O3JNTetWyrQxhQzN
	 fKYQsqXpwP/mC5EzcT3601o9uV9jEXKB37EPLUQp1ajhpMWHLWpHEdJEaNKX3AhCTwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=UTWV8h2n;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636FE606A333
	for <linux-s390@vger.kernel.org>; Tue,  3 Nov 2026 15:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 636FE606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=UTWV8h2n
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ac77270fbfso2158069a91.2
        for <linux-s390@vger.kernel.org>; Tue, 03 Nov 2026 07:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793719069; x=1794323869; darn=vger.kernel.org;
        h=user-agent:content-disposition:content-type:mime-version:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kv57rrW9AR5Uyx8+S36d+hVUEIxbqmnbUnmaj9pRDPc=;
        b=UTWV8h2nFTZ0eInmgrs3DEF7YRTvpPFa3wXSTzrgbTJdxS8o6LX18nP95bFPdtGbel
         mhOBG2L0OGKLRHHR5Df5WGSB4ANOi/n6F8HnF4gGjy7OOMbjUQlof9V2g4MRUDoAwbYS
         /cttKPQyPKLAjztUy3DJqrlEkWxeSKvdMeTW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793719069; x=1794323869;
        h=user-agent:content-disposition:content-type:mime-version:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Kv57rrW9AR5Uyx8+S36d+hVUEIxbqmnbUnmaj9pRDPc=;
        b=GSjhMmyEBRPYksqBTqAwNIy7K4syfZaIYqg8sCtFo1yDjzNtu/MoZmURCWBmOJh+9i
         Jk2BzxA+6BF4KndNEEI08Rx090sIISdXwoI2zMLw+b3R3aUC3AzZApPBbMCZSAbX82DB
         oae4JyDY9AsMkIrwYCPFPJDAlY53ka7qK3g/2dbsTqdT2Yl4uT62tuThYWYg/Nm5SFSj
         4rON10aud46MvXfnny605HGc6vzP42C3uK31CoCEWzBfMvcdtOqw4TqhTZW4lS68A2yA
         TegRGuVcj5kiD3p6kocaSnMl+28gjLVDu55M9JsgsSE8DK2pIVXZH3mnZE3cnnpB8Lqe
         jFeA==
X-Forwarded-Encrypted: i=1; AKwUvBycBTq6iIYJsFIunxXTcxWr3sL+OFbf2dASauds6Qx3Lf/EUHgkFh7K4lit4raefwAKP3/cNjeePyUE@vger.kernel.org
X-Gm-Message-State: APuU4Z/NLwTvsDdsQ0gfXidDtXjvTYyBPh7+R5mdv/fROSVPq1lcDyLJ
	IJLj1QgL9aKCT4qU4zuH9hI9NTyixT/vluKl4Hg3tadFKq1mo/RCD7DYIuEJDgMN26M=
X-Gm-Gg: AYBFou20fQKLSu60M6G7xKZ0Jrry54UN1AmH8iHjr97y1s8e0/iKYU3ZSTyv0JrheTh
	G6XbHBFcsIr1L+pFKXOZuoITyG3or06ugn8dXAtVrtNrI0IVUkjkVh+1o4rU8Ow9aSzeM3fyn8g
	qXWo11TPG1bWIbw6u5k5NS/3+HGnpJhxDFCSVUGZRIjHYpPpv/exAgwzjhyE8tDXdaIHsFMsmvc
	I5whRE+IoC6jvegZ7ygf68KnYRemy8eLAYOYClACJFXX469/FwiiCp/XqFfNbnPz4ONo3l62Lpw
	ODe3wnQkAHsCDNkLaKY8JX1zgywhjxa7uSSXhABhWiA0JYWO1PHVKKyMIV5MvZ+fF2rh6sC9kPS
	h+mmB2aiT0+hg2tdV7z1l113zD0Drlciuda7LNSptXpIYo5OExMMjcEWhexuyjBPf/m4wa+KvI+
	Ke89SDMbOQFItGfZzs8+jIxNhYLupmonIWLJ/zBMRsRT+a5nIyNFz8sp7uK6jWu9uryfhZfLg/y
	PcXE2yLUCGjWZJQJYe4shIdFAEuuDJRbfIv6lRtbQsZnM6t0nlXSOXbMF2XNeyZ+sg8XAsaO8lJ
	OAlpDqZ3SzGUg2nTo8TcAd7Ac/kA2PYjxtYCTnudEkCXAWCgI27PChDoSZe1ej9xGRUdb6Kdy/H
	P5lN1A1D3CkcrqRUoLnY5CtDsNLEhdzhtKmWjga5vtpf38tsEzMlR7XcDEp+C/5MiRIVQCwb565
	8AFlA5Ll4i1nvKoVyDyw==
X-Received: by 2002:a17:90b:3f84:b0:3ab:b39f:41da with SMTP id 98e67ed59e1d1-3ae89776af6mr10813768a91.11.1793719068633;
        Tue, 03 Nov 2026 07:17:48 -0800 (PST)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c62984bsm4849760a91.9.2026.11.03.07.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 07:17:47 -0800 (PST)
Date: Tue, 3 Nov 2026 23:17:43 +0800
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
Subject: [PATCH v2 0/8] mseal sysmap: Choose system mapping sealing at boot
Message-ID: <cover.1793718940.git.chris@chrisdown.name>
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
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)

System mapping sealing is currently a build time choice. Hosts which
want it and hosts which need to move or unmap these mappings therefore
need separate kernels, which is not ideal. Let's allow the administrator
to choose at boot time.

v2:

- Skip destructive vDSO tests on unsealed 32-bit x86 mappings
- Move the sysmap tests into selftests/mm (Lorenzo)
- Use shared vm_util helpers in the sysmap tests (Lorenzo)
- Use PROCMAP_QUERY for the vDSO lookup (Lorenzo)
- Keep test changes in separate patches (Lorenzo)
- Put the enforcement tests before the kernel changes (Lorenzo)
- Move MSEAL_SYSTEM_MAPPINGS to mm/Kconfig (Lorenzo)
- Remove VM_SEALED_SYSMAP (Lorenzo)
- Seal mappings in __install_special_mapping() (Lorenzo)
- Leave a sealed uprobe trampoline mapped if optimisation fails
- Replace the boolean parameter with no_mseal_sys_mappings (Lorenzo)
- Drop MSEAL_SYSTEM_MAPPINGS_DEFAULT_ON (Lorenzo)
- Drop the CHECKPOINT_RESTORE dependency (Lorenzo)
- Document the software which sealing breaks (Lorenzo)
- Keep Kconfig default-n regardless of CHECKPOINT_RESTORE (Andrei)
- Retain sealing by default when built in, with no_mseal_sys_mappings as
  the boot-time opt-out (Lorenzo)
- Explain the security rationale (Lorenzo)
- Describe the Meta/Reverie use case (Lorenzo)
- Skip general checks on unsealed kernels (Lorenzo)
- Add expect_sealed for strict CI checks (Jeff)
- Use the existing -T filter to exclude strict checks when needed (Jeff)
- Test that no_mseal_sys_mappings leaves mappings unsealed (Jeff)
- Add the vDSO mprotect() enforcement test (Jeff)

v1: https://lore.kernel.org/r/cover.1793094611.git.chris@chrisdown.name

Chris Down (8):
  selftests/mm: Move sysmap_is_sealed into mm
  selftests/mm: Skip sysmap_is_sealed when system mappings aren't sealed
  selftests/mm: Test that the seal on system mappings is enforced
  mm/mseal: Move MSEAL_SYSTEM_MAPPINGS to mm/Kconfig
  uprobes/x86: Leave sealed trampolines in place on optimisation failure
  mm/mseal: Seal system mappings in __install_special_mapping()
  mm/mseal: Add no_mseal_sys_mappings boot parameter
  selftests/mm: Check that no_mseal_sys_mappings unseals system mappings

 .../admin-guide/kernel-parameters.txt         |   7 +
 Documentation/userspace-api/mseal.rst         |  12 +-
 arch/arm64/kernel/vdso.c                      |   9 +-
 arch/loongarch/kernel/vdso.c                  |   3 +-
 arch/riscv/kernel/vdso.c                      |   2 +-
 arch/s390/kernel/vdso.c                       |   2 +-
 arch/x86/entry/vdso/vma.c                     |   5 +-
 arch/x86/kernel/uprobes.c                     |   2 +-
 include/linux/mm.h                            |   6 -
 init/Kconfig                                  |   5 +-
 kernel/events/uprobes.c                       |   2 +-
 lib/vdso/datastore.c                          |   2 +-
 mm/Kconfig                                    |  23 ++
 mm/mseal.c                                    |  12 +
 mm/vma.c                                      |   2 +
 mm/vma.h                                      |   8 +
 security/Kconfig                              |  21 --
 tools/testing/selftests/Makefile              |   1 -
 tools/testing/selftests/mm/Makefile           |   1 +
 tools/testing/selftests/mm/config             |   1 +
 tools/testing/selftests/mm/run_vmtests.sh     |   6 +
 tools/testing/selftests/mm/sysmap_is_sealed.c | 259 ++++++++++++++++++
 tools/testing/selftests/mm/vm_util.c          |   5 +
 tools/testing/selftests/mm/vm_util.h          |   1 +
 .../mseal_system_mappings/.gitignore          |   2 -
 .../selftests/mseal_system_mappings/Makefile  |   6 -
 .../selftests/mseal_system_mappings/config    |   1 -
 .../mseal_system_mappings/sysmap_is_sealed.c  | 119 --------
 28 files changed, 345 insertions(+), 180 deletions(-)
 create mode 100644 tools/testing/selftests/mm/sysmap_is_sealed.c
 delete mode 100644 tools/testing/selftests/mseal_system_mappings/.gitignore
 delete mode 100644 tools/testing/selftests/mseal_system_mappings/Makefile
 delete mode 100644 tools/testing/selftests/mseal_system_mappings/config
 delete mode 100644 tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c


base-commit: 734a9da61a5bc5d82b496a86bacc097d11dc6871
-- 
2.54.0

