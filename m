Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D660535083A
	for <linux-s390@vger.kernel.org>; Thu, 21 Aug 2025 20:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806840; cv=none; b=NngM99B3dxTZ7qQMMKKm2oHvBRXZwAHcnjBjXMu6cw7TQ8gQbhoys/ukVXjI+K3pLHE+rLWCzEHb9OuZsrd2DMu48KOdFTy3LPwm7Dm+NZoIGUtZeF7dt9AavtBC2xOwvqDnDTgtFLo2Zgh0hOcn1/9RWDeDDrkQNkI37vdF5GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806840; c=relaxed/simple;
	bh=3FOM28sJXvbUF2Tn/5jLCVekviR1dLu1+OtM4m//AQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NXZyQnLN+bskkavXphByUnpF/8HOk1C/+0sn+h3XWAVvVGuvcUzhg5G545P7y4ktpI7tjjgHsf/iGseQngALNp7V/S1lGxHYdPh1HOzn16kK5TqSpYC1ryeJuDG8s6PQBxwq9/Ukhq680/xrpMCiZiLLeAYnoEdv/q4/VbtyPCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HbguPC8t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HbguPC8t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7sWLap5u4LkaWlbSo2T/W3JLtp2tuveUv2Z9sucaeo0=;
	b=HbguPC8tqBkg7t9/QOVKN35ZpT6p3DwwnNWto2lsLSPmzEFAH/NWIL/1ftGjfqy6oJgfIm
	vFfgtL3Abduu/oa56uS15OTjsdnVjAj0CciRfKz5zBxWHb5uXFtpZ4foA1Ur45VsAHtVSt
	nkvO04oL4Iu1BYlT+IGC12IVe5fuu8I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-HLUwQ3xzOgGhObDGqkDmlA-1; Thu, 21 Aug 2025 16:07:14 -0400
X-MC-Unique: HLUwQ3xzOgGhObDGqkDmlA-1
X-Mimecast-MFC-AGG-ID: HLUwQ3xzOgGhObDGqkDmlA_1755806834
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1b05d251so7730755e9.1
        for <linux-s390@vger.kernel.org>; Thu, 21 Aug 2025 13:07:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806833; x=1756411633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7sWLap5u4LkaWlbSo2T/W3JLtp2tuveUv2Z9sucaeo0=;
        b=VyFVYaNMyEW0hPzTbgZIgGet/iu4akYpyOf6nTkWNp/CGl6nuXz2l9dYuiRzY0muHT
         KnE50rb/gBSFqBhXPd/S8vjElgzvSXk6MizYgNZHrynMOngLcEqZtvkWUCWaKcYpscVw
         PrFt2VUdwqnaawdCOfKBW4A8EIkXBym4tkPNNlLGECaPw9lZvW5G/LwWPWpWPNbKgVeA
         q0+hwIbdzBVV+TZDKctfJytovjarKTN0b+C3DmpwGhMM6cxPRoNyevQFkds/WdXP4tZx
         uA1DPK6rqcQc8Q4yWd44qLHu0KKJE/7VjPlX6xZR6GtVo48cJIBK/AXv2VeZhkSByi0h
         gd+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJEeFmFpNqRJIsZWReHTeZPdIDf1Vn2R3DCUpqNOsaio04vz9NYCAZgzvvTwwAvtMYFj0eZwM7+2Yi@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Z7P89vw32ufHqWN6ORGTWZJQOrj8a3jVg3VapL6aaqdnknvu
	xhmo87l2YwspUjWHoBrVhNN06lbYUpOdAJ7USHQYlZ0B5OkWOMljW2WhJS0fk6SrGiSTQa44Cnk
	Fox93z4+Jh3peelLuB0PIPCLjNl5yR5rP3/xm0sm9p0ATtQT9yvn6rFyxmc1Ejo4=
X-Gm-Gg: ASbGncuGDBc4j4FSC64rcsiMunDsQghxKarafzpL7kh2ibReSM9CQvr+tGM5eMYmM2M
	BlK5ya860IEsVQjFfVu3fRTWwFDcFWZusEPnARCUyNhqywE90vjyM/1Ex1pF/QPMsnoVTVMFqlH
	tXoquXCMhIb4m7y+JJ389IhvIPPdIpBCy5lY0TOHe61ABO6EXbEYXnly+riaOIKFWO6+H7ca8BV
	Q0s9d3wlkUHt8nv55smhKmsT/QYrjcunwCVinSaLu8hE9Yx8CCZuVmu/NJ3TaqxyFnz6nzNRfcQ
	7mQqcGGcIRbx4xtisEkmchHwKsF5qIfR0wPJsVUkvtVinTTJhLbs1p/71h1WWZ+E8TvDSy8psT1
	7YvoyKFpOzWGTHad1c1gPiw==
X-Received: by 2002:a05:600c:1d06:b0:455:ed48:144f with SMTP id 5b1f17b1804b1-45b5179669dmr2598595e9.14.1755806833371;
        Thu, 21 Aug 2025 13:07:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSutx6qbatKffMJ28UfT2ZDXFlSv+vNq81oYks3KAGI73zxxTWKo8ClwQ/mmPq6W0wDfVQow==
X-Received: by 2002:a05:600c:1d06:b0:455:ed48:144f with SMTP id 5b1f17b1804b1-45b5179669dmr2597955e9.14.1755806832889;
        Thu, 21 Aug 2025 13:07:12 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c0771c166bsm12916801f8f.33.2025.08.21.13.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:11 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Jackman <jackmanb@google.com>,
	Christoph Lameter <cl@gentwo.org>,
	Dennis Zhou <dennis@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	iommu@lists.linux.dev,
	io-uring@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	John Hubbard <jhubbard@nvidia.com>,
	kasan-dev@googlegroups.com,
	kvm@vger.kernel.org,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-arm-kernel@axis.com,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Marco Elver <elver@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	netdev@vger.kernel.org,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tejun Heo <tj@kernel.org>,
	virtualization@lists.linux.dev,
	Vlastimil Babka <vbabka@suse.cz>,
	wireguard@lists.zx2c4.com,
	x86@kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH RFC 02/35] arm64: Kconfig: drop superfluous "select SPARSEMEM_VMEMMAP"
Date: Thu, 21 Aug 2025 22:06:28 +0200
Message-ID: <20250821200701.1329277-3-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821200701.1329277-1-david@redhat.com>
References: <20250821200701.1329277-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now handled by the core automatically once SPARSEMEM_VMEMMAP_ENABLE
is selected.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/arm64/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e9bbfacc35a64..b1d1f2ff2493b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1570,7 +1570,6 @@ source "kernel/Kconfig.hz"
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y
 	select SPARSEMEM_VMEMMAP_ENABLE
-	select SPARSEMEM_VMEMMAP
 
 config HW_PERF_EVENTS
 	def_bool y
-- 
2.50.1

