Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08A03E1D17
	for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 15:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773933874; cv=none; b=o5iK2psVHMv2RbSlbkgbxk7eOsAHhKY0IK2JHS4VPYTYJp7l4TtP0vIgtgB0gURrZvCZWlLSqOCYwP/zUOvHiod9IVoctbIBkwQ1Ii+GeIC4i2qqSJbZY85kswyOsXol8XsLFPa6N4o+ueTB5caBaCK7MQTwL/Khca7o17SwP80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773933874; c=relaxed/simple;
	bh=pg6Bqlz4hp2TL3LRD1rOcSMVpMNVbsxv6jOeSgguD9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwTXfWJ3Ku8ORSGwEjc4F1T89wWoqLJjhFzKFGLospYcC3TRsKNiMih9RdNDxhZs7LdcTI0tbbgiNcg5AihfNeCZKlZd6ZdV1H0RQ6L71MLiAk4Mc+7gq0SVl4WmYqpBSl7i5nl7no6YyJprMcfMjgs2FnFFmqFcsAAQ+vkmuhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=PdgfnqTe; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="PdgfnqTe"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-899e87b04d8so16593126d6.3
        for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 08:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1773933871; x=1774538671; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CAHdFeNRl4yy2sR/1LOHb2d72hyJTySGsjAok8mzB+g=;
        b=PdgfnqTe5oz+hF/CYus4Cr7Z9K4LJKnnoTNlcJXgFQ9yqF8NyC7AVKqwnniFYJLWfx
         F5Ymo0UwnvivL0x4OLLoUUBVIl1Ru2b0rDBQkZ8e1YtLH+Qg5o9JV6A7fXhw+Q38okFe
         KZc3pjsvZv/MA7gx7QuDr/ONJJarS63L6HWOUDGEAH5MSKYM+gLrT0COHj8GV7wnaQ2J
         ox+tVGaAaQeD8MQllUhTsAKQ6w+B/e+ljs8vxBAPq//6B/bOmA7jOuLQ0ZXqv21rj1O7
         1R7HIdqGltPM6hAYB5nmmMcz0gLIl0oh+TQt286HYqjIdXWCV9citABO+x3VQrENpbhu
         oLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773933871; x=1774538671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAHdFeNRl4yy2sR/1LOHb2d72hyJTySGsjAok8mzB+g=;
        b=HPm74DdunfZw8ZnELVjy6/9Sd7AEuaWLeEwLWtu7SZxrVKGhxIwTSOd0VOwDBc0WcK
         Yk/H8v60S8C63dQX6eCawkySl9xxoOUApIwZ1BsRuF1F1MjN11A8S7oUYyWsmR0siP9T
         PmOklh9HpGCSn+PSYup4tgVTaJS+gzxIgSP6cmTRErEBfoPWozBbA/+QoeUnupWV1iuy
         zGkjL7nmDo8TfuV3UyZKK5S35P0Aak/p9DWIzdZFVX5ug2E6KmA53idow/p3E7fHfbIC
         r95C8bnikNTQRx9mhGBWgNugInbo/XBpaQM4tvqae11jqCM7uaTkLrtnsJXsarf4Ebte
         WFvg==
X-Forwarded-Encrypted: i=1; AJvYcCVu/daFY4XySuiE+aOWkwVqmT09icbdKaDDAoYsgawkGfRDv8+alstSqaHsS9CK+0uJXI6MkuOE31oM@vger.kernel.org
X-Gm-Message-State: AOJu0YyFDCc4f+iwroHeVGBm/suFbel/DiF+wAQ9tnXxLh5r21Ua49hk
	GfP2WpE/kgu1Sxl1uxtFSc7av5KdO9/HmNMeZKmgp3xleqHUmZj2wH4vUsp3BBV2dYI=
X-Gm-Gg: ATEYQzwU5NtWtQrzRyX381/rAZfW8136T5DFD+q/br/o4YAbFT0v/PjOeu/+aycxjth
	sKZCqGTh1A72aVrTPoD1zArZYSSUZmjgxw+sSIyuHKXwMZKoUR40wMTi2vwFDnLBvjEH0U+OnRG
	qtDRL3mcTNeRY8y5jnQiyXk+hWgIU1930b/2cp+evF60nFRL6/EsTvJxDbZAAQ3s9F1m5UUrIBm
	7E7riIU94PJ8ehxDxpNaWcNbkT5DnJnFSKqW1Kty4JXK8qgKnJUpJCOO9FIWClsoruA7ZUH2AFd
	ohaX5ploQ8vwt2GfyPOIRJAZSrWfoXNc1nZqPx1uYM/YAxQ1wp3re46REB/I4X6rrJTI6Cpv1jX
	9Zx7JLoD/WwvX+0oIvMKRDLoHRvg4Fe7Y8auMbALoQblTBpHJcGdRMzP3RJ/BXyIGvtGCYSi+sI
	QU6DAhlO6iRqMNyIOz7YwT0VectqgDzt1/+JpcsNRoQJFVMUWg0jc/PPUEqN1P3EVsyBOoragy4
	SSuOU3n0g==
X-Received: by 2002:a05:6214:3314:b0:899:e702:b852 with SMTP id 6a1803df08f44-89c6b5fbac4mr107205736d6.57.1773933870639;
        Thu, 19 Mar 2026 08:24:30 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c6b8dfdf6sm49250646d6.5.2026.03.19.08.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 08:24:30 -0700 (PDT)
Date: Thu, 19 Mar 2026 11:24:27 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-mm@kvack.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 1/2] mm: remove CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE
Message-ID: <abwVK8nLpSLVcT5G@gourry-fedora-PF4VCD3F>
References: <20260319-config_migration-v1-0-42270124966f@kernel.org>
 <20260319-config_migration-v1-1-42270124966f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319-config_migration-v1-1-42270124966f@kernel.org>

On Thu, Mar 19, 2026 at 09:19:40AM +0100, David Hildenbrand (Arm) wrote:
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

HOTREMOVE has long been a thorn in my side, I appreciate you cleaning
this up.

Reviewed-by: Gregory Price <gourry@gourry.net>

~Gregory
