Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC722ED867;
	Thu, 26 Jun 2025 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750951996; cv=none; b=rcQ9VXJMgGQHJ+XfSCkTd+LMTh2d7YI2rUccpRw04+NETQWvZuGPIy7+jWbIEvy27QOjSWd9qUsNx8WOvcDvnOgdCAbdJsY8bnSNwuNufF4bXi+CkIpLAD1q0VWi0U0uA/CagQGB0ovXw/7rfBCzsCrJSfDHfWsuhIyKmO90kkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750951996; c=relaxed/simple;
	bh=PO73mn2x5YD52HxkHa1DEufvZN68reU9EhZDSWAODRM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ppvBT0p60B78ckeRex/o6uu+/B6qxo0oapzjm1K3Gsr9AicggnjpxBC3vruhOPomCfqgAIwLd1N7MrwiDVvRWngQVb6SIPuCbiXJSZHIw7XfZ1itwLtHr3vWCBFTDSe2l8ybk5KqsqKElZdTPeDo2mPrGW7gGkNmP2Gfi0evX5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMs5cVmY; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMs5cVmY"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54d98aa5981so1655431e87.0;
        Thu, 26 Jun 2025 08:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750951992; x=1751556792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSxJD4SCtsi5mR6YtVjdi0UPNRveg1OSTrY+9IeINk8=;
        b=CMs5cVmY7NKVKjT6coGWJi5N9E2o0bNRKGwz8nHdRKixcXmQksbqhuz+ESCYx8NhXS
         QYz6CmugQrRPT1GXTtGU0n7JghlsQZftiR4OkifTI96mD6bzqK0JjESQxHJ6Mvm22JdZ
         Q6vjcuJAgXhfnD7MgHKCHsM5KMq0rFnkiqpNCSC2aroam5LqX8ws0Emh6ncUeJ2fZSvE
         knQlVJiD9dSL7asvnzFajMWopvRtIJI3mmUHFRu3xpsG+nntLTQWkt+H02NeGHgQh+yN
         yOeSWUzuZMM/agq+PEXj8yzemHGmeH85Bs0BGG9dmUN65uKNriIPNkJ4ize3ve2QaY4L
         w+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750951992; x=1751556792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wSxJD4SCtsi5mR6YtVjdi0UPNRveg1OSTrY+9IeINk8=;
        b=jzYZSEq6i/9A7Ed8huSgkHhn7ev3NsnKFEHMiJ4M7TD+Yg7+w7uLo5ZZ1nIUOalfIW
         HQ//0ExWvHkRlIqNbJMLxoL2JzwZkqP6PgSVBO273778x2LySOEMp0mYdMhT/Rd8chI7
         yEaUi1JB6MTN0zpCyvP1GDfjxZUKeRaFCqrQnuahvNiQTTzirLBMwwuiCOLcAc39if+o
         2DG+ggxSSNX37EoaswNtidOmswxqqauLgYZBmQX2nOqtm8V7HlSpu4BJmbEqC6uf9q4V
         BqvsUoy7THO3el6nh8UatZsGiqXxcrh5c5Zmk0aAB3ehghBnY3LlYLIgQkJHM36pL92M
         2UKA==
X-Forwarded-Encrypted: i=1; AJvYcCVnquvcfIE/gcbhzgUut4zSlLkNA2LFFn/6Do/h7hIkJMxgBkQA1DU5xDtnU5QIdkNGps6B3nl5+sey8Q==@vger.kernel.org, AJvYcCXdKV3fRb90mUjMTT5IzT7+L59oWe0IwDAue5jmI3ft07XKElZefj6uaFpuZMvI9xp0SiW/HnYFmfjZl0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK2Qwmm+tzNoZTcLpL7St8753sJo17BGTAtlab8ojGyFahZ/P1
	QnumBtbmnAgU/c64XG3S6ss2OZCmNzFMAeh+bikSBOG4bnQ1A4Xq3sfj
X-Gm-Gg: ASbGncuG2t5mRvwTddtWNgBzCK5fRHK8txZvgm+45XhzBu4nIudJwrx2T0coaX72tQw
	AZ9g1T+0tEXUauJnV9FmdBCzQCNNvnfaietXm/RcTH1aAaFdnIS51EO+hUzPtjL+OilikmU5ncF
	jXvpKf7yw7UMHAt9/oekKzdAo8HdOqdgV0AMsW1+OJCl2wqtmwr7j1Q0xYTKa7GA3Atx0pLlWNc
	ucLYLdiM2YI44JizprVXNjNYiphNNMbv0HN6oKsqy0FvZG2uITIMywMtm6DRV/UYoTEVqsQNpWW
	c0jBfm0mWEhBA6o4Q0o2RjSQYoucrISCqrgYqHkKAVY1onibFhB2Kzrptsyrfix6H2z9ZGvBJxR
	dV/ptYCCZ3JG/Fgfm2s2ly8U7BVySzA==
X-Google-Smtp-Source: AGHT+IFoZkRuIIumANr6hYYRzr1inmKBevr4v8neJa1j+iQaqRjcvodg6bFFAhrpbTZKPBtQIm3EXA==
X-Received: by 2002:a05:6512:15a1:b0:553:2882:d79b with SMTP id 2adb3069b0e04-554fdd1b90dmr3161154e87.32.1750951992214;
        Thu, 26 Jun 2025 08:33:12 -0700 (PDT)
Received: from localhost.localdomain (2.135.54.165.dynamic.telecom.kz. [2.135.54.165])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2ce1fasm42792e87.174.2025.06.26.08.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 08:33:10 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: ryabinin.a.a@gmail.com,
	glider@google.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	linux@armlinux.org.uk,
	catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	akpm@linux-foundation.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com
Cc: arnd@arndb.de,
	rppt@kernel.org,
	geert@linux-m68k.org,
	mcgrof@kernel.org,
	guoweikang.kernel@gmail.com,
	tiwei.btw@antgroup.com,
	kevin.brodsky@arm.com,
	benjamin.berg@intel.com,
	kasan-dev@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-mm@kvack.org,
	llvm@lists.linux.dev,
	snovitoll@gmail.com
Subject: [PATCH v2 10/11] kasan/riscv: call kasan_init_generic in kasan_init
Date: Thu, 26 Jun 2025 20:31:46 +0500
Message-Id: <20250626153147.145312-11-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250626153147.145312-1-snovitoll@gmail.com>
References: <20250626153147.145312-1-snovitoll@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Call kasan_init_generic() which enables the static flag
to mark generic KASAN initialized, otherwise it's an inline stub.
Also prints the banner from the single place.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218315
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 arch/riscv/mm/kasan_init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index 41c635d6aca..ba2709b1eec 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -530,6 +530,7 @@ void __init kasan_init(void)
 
 	memset(kasan_early_shadow_page, KASAN_SHADOW_INIT, PAGE_SIZE);
 	init_task.kasan_depth = 0;
+	kasan_init_generic();
 
 	csr_write(CSR_SATP, PFN_DOWN(__pa(swapper_pg_dir)) | satp_mode);
 	local_flush_tlb_all();
-- 
2.34.1

