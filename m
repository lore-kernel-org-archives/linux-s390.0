Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793719120;
	b=c2iHiib4AXd+BqxukwslKLRL7hkRRJnWlpuiLO+pZGcqqd10WBq4vjOOpYK5tFuh9dKo
	 bU7VkbLC8FPniGI+XDfBTS0rclDOMWviR8Qv4VHpGwr4UZjCIbNoFw/HAskgMcxNMLUZw
	 sDHcdHf3pjCoukXrXW3MGZWRD3aJM4ZV8fH1eC5Py12r37AGkcnsusaY8D8TA5yu4RYlU
	 IsKEamA4ZIVbMGT1FzxWXC2IsRXMNYcC4NeK1Nb8omuf2UMytctFgVbjw86FJ68NazsA0
	 WwmCRcPRpp6UNrClmRa3OutzW8KQB2c5l5hoE8TTbLzdD04Rzppsr5kqXRcMF/799NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793719120;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=wslCY1XSUoR3v4P9N4tk1erDlQSR29c2WrcvV4W33z8=;
	b=gbMBTIrYg6uJ9iPE2rXrK7kDkEdnfB1/3ovoAeB81+BVnX4ITkxNSoqFHqLTyyj5QbEQ
	 2YKtoOco/NO8xhieKhZoSwz+lHG/QTZhoZ5kNThQsgqRT7sHOmV0eZ2uCkvWPoWe9viQk
	 2+P4+zVoTsiUwnu2icbnA7cNf7frnrecMkZDsf6Nkshn4MxcACcQV4JKHNR7qPBfSsM0z
	 s6b4Qi0PKGKtPfIRNne0VJqgYPnfIg8AZx4gAGWeEj0D4BJS3sH8GftC6MWg6Tjeui3px
	 I4rJ/YdOhDRzJyMVC1KWC6I/A+2YgzOPc5ogt/EYujQ4SekcftUJsAmZ4foW5ad3FfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=NzH9v5uE;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5BB606FCEB
	for <linux-s390@vger.kernel.org>; Tue,  3 Nov 2026 15:18:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D5BB606FCEB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=NzH9v5uE
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a064dcfcfdso1544404b3a.2
        for <linux-s390@vger.kernel.org>; Tue, 03 Nov 2026 07:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793719118; x=1794323918; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wslCY1XSUoR3v4P9N4tk1erDlQSR29c2WrcvV4W33z8=;
        b=NzH9v5uEH+MPtdumNErHcLU8TI7esovID+0FCTg4cq4Ny7OB6Jbv2iuLnSDCRB39Vh
         z1jm9WbnlKgC0FM/ImPLdCDbfHy1wPtGKCnh7nLr66I2ZWRMh6r61Gw1Myi8kqqxygS/
         MP+GB+led6l0lrR+WCQZnEEeUcd7JizQOJMcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793719118; x=1794323918;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wslCY1XSUoR3v4P9N4tk1erDlQSR29c2WrcvV4W33z8=;
        b=2dqfmjLT4JuxVwKFUi9pNDnlhcyLu2cURnJ0kOWowigp2bq5mDb8lPvv8GSG0ghDCz
         E9P6a6fjaOqiZQACYYXTI/CDpdufPME/5Bq6VBpBgRDmRg79bwZVfM7uKvR5+PJUP/+a
         LsEffEToLxOB8rjDhY4QFjuv9sO7APrOdgT/9TqFhyYz8TTCvgNmBfVSV9b2usL3ymaU
         zC3wscjg64K1hX0fcf4LuFhm3uzom5BwoO6SVf6bpmpVfjf9bXdH3dgg4aYySJB56m5c
         6e8W6eE6ZgDXep2ReBTnG+P6+DVT0cGXUxspvzw63CZfCspo1tfOqiJV/3qPiGcCuLtm
         1IuQ==
X-Forwarded-Encrypted: i=1; AKwUvBxrJYINWvrdFRk2Q24u8Sbg5XfHQMjEJ9JLWPr9LkOzEjkoeb1EK53UC7kk/PkxvWrigO6I5zfYsFJX@vger.kernel.org
X-Gm-Message-State: APuU4Z83lElSDq2EpDDrrnZq5qaYTr+buWSVdJGWV8HPH2tsDvxY2WnB
	zySbn2NlBs1O+UMyy2IsLaQ0e1Ls4w8MaZYsHR05tQvUcAf2paFaTj0H6YQ3q8ABoC4=
X-Gm-Gg: AYBFou3YcTJnWuob7omq6FAC49td/5An9u3I3MDkAZ8uu8LT5otU8Ym/Dq2ihDvm16e
	0rWcPb1oozcX/BApJwr3bfDvExeQXwx0pSk62lNEF7mE7m4DCGhqWt8yDPUlJ64unLio2v8cj2Y
	LlkdK4PnWIhWhtyk8/til8Bm71vjTvfWMvMnzUCxg4vLGubnRGQFBxwsoxGBqKkExQLbw+RGaTJ
	70JuP9JCyq2BcuUDgvvxqMDZmtNUnM+k1pzcZBZfxXbheLtS7dXmt9IXRGr47D1Lzu1RpBVQ1+z
	HYzrrRPX/8KFYlxYI4MNcue4DXDwzGa3J6ivNLWbp+awnYzC2+CImJyiKr2eXkzJB20s68UWjk9
	335uVPnUFPDmF0ufTX2mD1OQC5oyXsRRMLr21XuldMtzGWBxQGGa15uaNM/ZkHzhod+guC0zIFD
	pb0jQuPDOMiguN7Y1+eyrOdXQOyNEbvPMSEN8iCXupp6BkaLMrqIL6KclwV1NqzNWQmxix+6hWF
	BIi04CnN/yXdqKL02gbJRg1LpvLCZxgGR9Puv78/jJaS1xjN6dShH1jXhdDh8E9ssQaBYlZWgNb
	CUolKb1ehBCsWKgT1VWWTN25FO/Q+UJ1rYna9aOiW6Ii0NzpVGrSn2dHjQ6S1K8O6NT8lWNcC5i
	Hk5SCsRlVJ8rOpu2qbEeN2GaDB2P3tUfopsOuy7bPKFokk1CqJK+3Vxcx0N0zU6zJijzIuhpCUj
	j3l49cLgSJCq7CBzbeVg==
X-Received: by 2002:a05:6a20:914a:b0:3dd:a009:3182 with SMTP id adf61e73a8af0-3e928e2909amr12529216637.42.1793719118513;
        Tue, 03 Nov 2026 07:18:38 -0800 (PST)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb362ab313sm1592131a12.0.2026.11.03.07.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 07:18:35 -0800 (PST)
Date: Tue, 3 Nov 2026 23:18:33 +0800
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
Subject: [PATCH v2 5/8] uprobes/x86: Leave sealed trampolines in place on
 optimisation failure
Message-ID: <eafd3da2cd2c3e2c4d137a46f50351dc6290c5ea.1793718940.git.chris@chrisdown.name>
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

If swbp_optimize() fails, __arch_uprobe_optimize() unmaps the
trampoline it has just created. The next patch seals all special
mappings when CONFIG_MSEAL_SYSTEM_MAPPINGS is enabled, which includes
uprobe trampolines, and then this do_munmap() would fail with -EPERM
and warn a second time.

Nothing is really leaked if we leave the trampoline mapped in that
case, since get_uprobe_trampoline() reuses any existing trampoline
which is in reach of the probe. So let's just leave it in place when
it's sealed.

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 arch/x86/kernel/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 0f60c0d076b6..fb895bfc09e0 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -1183,7 +1183,7 @@ static int __arch_uprobe_optimize(struct arch_uprobe *auprobe, struct mm_struct
 	if (IS_ERR(tramp))
 		return PTR_ERR(tramp);
 	ret = swbp_optimize(auprobe, vma, vaddr, tramp->vm_start);
-	if (WARN_ON_ONCE(ret) && new_mapping)
+	if (WARN_ON_ONCE(ret) && new_mapping && !vma_test(tramp, VMA_SEALED_BIT))
 		WARN_ON_ONCE(do_munmap(mm, tramp->vm_start, PAGE_SIZE, NULL));
 	return ret;
 }
-- 
2.54.0

