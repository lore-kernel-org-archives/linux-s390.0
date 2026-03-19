Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D59320CD9
	for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 14:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773929684; cv=none; b=csL8hYCbRg+6qsd/103cVWPH359tsptWS7cdL3wn2CJFJsyyMf6bejr2LlRS0LoGT0i4zlV2/DNFYRcg5kkxF7N8k5nR5V2aTWZaqQLLSjJcqWExDrluGZaqHIDIidAcSES05TF98m9fm1N/KKjszc3/8FHX5A0xGK930kKd4kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773929684; c=relaxed/simple;
	bh=/nvuLQ6hKFv63U1YHBSa/Uk5cFBZ0KJIR4YblpPl2Jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d6tgK414fbBej8XNL5paQaSUnBwnXvGls8fa1uT2xFkDkRHixLn/SN4pEwJOwzKjWbHut2/CTEZIz07Quw20+VmYW+ddcAvCg11evZ47q+F/XtG6N6hcOCgWZCNGw3ihaabdpwaRSw2brbvW3JYd560wqfIKxQB2NBZzVC8FbDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSXg1jR6; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSXg1jR6"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-67baf20e8c2so370894eaf.3
        for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 07:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773929682; x=1774534482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntFH0htT9ffFrh9knb0jn+m+GRQSXC/6K3X5v8dqre4=;
        b=TSXg1jR6/pHxPN/Lj0dmxwkHFQsPWh+HMZrrbamGs9cLQp6NX/sCTqGmSe/uoSfDHB
         en2nyANx25FZZQ85MJHK+9FFQc9dUmHNFB/aWjdsmsAZs5oItc/c7CUQG2aAlElI9lUf
         yblNxPyAl1Lb5jk4+NW+i+hZ8WY/yajY+lUqzVJgsD9olrWHpgYcLGQtfRvULtv8TAnq
         6HtI38olDYbBh+5Rcl19UNrJWaGmVl9qmOgz/H/b+PzXKDMVJADihDLqKYiEiYPAR7zw
         /y1mVS4dwUOTdLAllgB3zdcSo8PPuyCinPnbQgwD22J2CglXSmNVonfWVa3teJpU4ing
         5rqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773929682; x=1774534482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ntFH0htT9ffFrh9knb0jn+m+GRQSXC/6K3X5v8dqre4=;
        b=hPaU0QKhk5SilYiFqPLVJRENYWaZZWPceg9itZlTGL152DiyN2izPOtl1zcswC/czg
         SBQh/2v8GqjRb62b/JHaa5k538+uAYqp6RLHvX3oFNYnzg9zemCqrNqkgLXTmw7NY9y3
         iheHeg2/unr8qFkC+sdGxMLD6daQg5kBULARw2+ovx7lxoDcDtC/5BflGhuaycQuha50
         Ndr362u2kJZwywR97xVsr7teAv3qftbU3/Xy7u+vLIRX0nhP0JPCw8DvFitTy20bvYy1
         G6w2L6AEIYDHtEndC6Z+AF8TO+HaC0+DBF5zNgvWVoJ02lEUfXKedfHDVpmqRI/udpGp
         f2dQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhxd7TObFJWRbiLdX6uZWSaSaqvGiV9x8itAnAL3cqpA0732F8r3O85C3X270VbZs9U3PhbjsPRKS6@vger.kernel.org
X-Gm-Message-State: AOJu0YxnoL7U2aB3CabYzHf0/P3VfRgIHWNLE79pmokfugghdMrsOTD8
	3+ZFcGPFZma7okGyCfJUf7+lp60AfrSm+lhAnEJZ70UDGUw+gRJ8+G9i
X-Gm-Gg: ATEYQzxz5U4ypi9APAtBvfBfj9EBhsNS4Dtp0htTcQayCg+AGXRU9T1V5VpzwwGnpq8
	cLj6UeAz7Xa+PZjNNe2N79sZ5D9Akl8xK3tDo05J8O7AzcTwdOlJZkAMfAm0kxN2/dOawemJgzd
	YgpouZjB9/G7U20OUfKBd3A7zVKzkX6aqYE9HP5/p5DVXQ38554vOvQDGl5x9tlYzjePKm6sFY+
	ftcD1cnXZgvzSq69N/vFW49mLLjJUQFLqr0HqcRzeW195dLYFUEUUEkAq2EBmDsOgrwl5IZwGJi
	s4jge548vC+hg/x3vx0aTu1RH2bHge/fABF4XuLFXEBehDunUfQJtmMZ4seIuIlhf4OdBhkItUn
	DFyUdc5SotKPYuSYTbLoikCORtBpwJnz4cBdG7/LKmylTNHSxGISs1YxuJzczQFH76v4e+2I/5s
	AYb8oP0jF4OgD6eEVuHAlC
X-Received: by 2002:a05:6820:1518:b0:67c:c4e:4ca with SMTP id 006d021491bc7-67c0dab23c8mr4161966eaf.29.1773929681867;
        Thu, 19 Mar 2026 07:14:41 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:8::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41bd689e3cdsm5313808fac.6.2026.03.19.07.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 07:14:41 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-mm@kvack.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 1/2] mm: remove CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE
Date: Thu, 19 Mar 2026 07:14:36 -0700
Message-ID: <20260319141439.218078-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260319-config_migration-v1-1-42270124966f@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 19 Mar 2026 09:19:40 +0100 "David Hildenbrand (Arm)" <david@kernel.org> wrote:

> All architectures that select CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE also
> select CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG. So we can just remove
> CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE.
> 
> For CONFIG_MIGRATION, make it depend on CONFIG_MEMORY_HOTREMOVE instead,
> and make CONFIG_MEMORY_HOTREMOVE select CONFIG_MIGRATION (just like
> CONFIG_CMA and CONFIG_COMPACTION already do).
> 
> We'll clean up CONFIG_MIGRATION next.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Hello David,

Looks good to me : -) Thank you for the patch, I hope you have a great day!

Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
