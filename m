Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AED2D7DFB
	for <linux-s390@vger.kernel.org>; Thu, 21 Aug 2025 20:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806854; cv=none; b=n/5Avwgj3keAFLlC6tufRm5GJkYd++cIH3FuBXdFn1WRJV7qXMx43zRCT3Rk6ttPzW6PJzKEUqM8kr8nATJP3RiAX8NbTNIZ/PUmr10RUselLzKb9xqRWVKhqUzq39L0q1G5PjaU0r9D0MoQWeWjxuC/hJ8xhRsubY1InA52MQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806854; c=relaxed/simple;
	bh=vLP4m8ubY62ddowshnJEYGhNc+fB41I1n0umGIUlXAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X7GX349Twm8yPhK71W/Uo4KFpDMYVm93JYDAG9haSDnNHX3PzBFTJGpKjCWCO7TnmCpPGqEdUZmtANwVjSDe90sZPDvSFxqsHaz9WGvIW7BDzTFjka3WfLIZN+NntVOPdya2i+B2BZTxPtBfsyLviQLJxzKY3MlplBpPkcThPuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EwCudSfC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EwCudSfC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aOl+Pd7m6DQCTUATshUDhXjEbKNtUx8aQQ0CVjE/d9w=;
	b=EwCudSfCGuf1SqCDbUQOneXgeLk2d0dUXwxXAw5A3QQNEClF+sK1g541oUCVmGLdEc7Rmr
	4B6X0TrlLcf1G508CK1E8EXYvLIJGR5hKxgWAGfzLeu+EB/F2W2KdYgVyaQe+6ELCoQmGH
	WI+14X7lQVRRgkS09qnUmN1s05VK3D0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-YEKvdh3CPv-1fTEsBGsdnQ-1; Thu, 21 Aug 2025 16:07:23 -0400
X-MC-Unique: YEKvdh3CPv-1fTEsBGsdnQ-1
X-Mimecast-MFC-AGG-ID: YEKvdh3CPv-1fTEsBGsdnQ_1755806842
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45a1b0cc989so8650045e9.3
        for <linux-s390@vger.kernel.org>; Thu, 21 Aug 2025 13:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806842; x=1756411642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOl+Pd7m6DQCTUATshUDhXjEbKNtUx8aQQ0CVjE/d9w=;
        b=QpEuuS4PUHzORkVV+z+y4Zj3CeHprINXGlaOYiikEVB5WrUHKFHn54YnMUYdMwUr3d
         UKRMh7VoSamRl+OYvPRB4xYyGD+foOYwdFFYn7b+sHEx6yk9AdtQY1YQyRKLpNZ8EGK7
         /BqUmCMzsQPZt4TjZah6XdfV3AESOU8434nBHyOMha3nNJ7LMJG79zv+RNgbBK0xCAz8
         kpv8DGO4/Sg1hs9oodbVTpgGLSdv5MDm1Ognw6EZPhqqX2FrppddLxsdnsR3+KMJ/kMH
         wG1etYFEDaaqlrGFJGByx1850JThxGtpN214bX7k3Q1kb8n933cfXwMEkoOV906zINf2
         FErg==
X-Forwarded-Encrypted: i=1; AJvYcCX06xjCqgxz1uOQcIPg3cnZS+9JZpD0deCgKh1PLc8O4/Ock1ZkQe6E5cQVRy2undWWk/Ti9YQqe3Mp@vger.kernel.org
X-Gm-Message-State: AOJu0YxSA8wKZEXoM17WET0cxtOUaTF5udIAbOpR1tLndy1WWp9/31xT
	k9ItRHhfwi15FXbilOQIsRVtEEdqwycB++fO1qfHG3AxBneOpePkZTAnrXcjBcSqQZfTvzrDJTC
	9CmByg+AZFwyYtK33sPo7/sr/JbPKKTVgcYGFGLhtNx2ZGjGmarnBYEQvRHcqUqo=
X-Gm-Gg: ASbGnctcg0KqBfIoUe3vmycpwbRrXuwuHkrWeSDvVKQcolIFlDUrHdM/f7nFrJaUPPM
	aMsdOz17fk1hIvOqOjnFqIG6QaEN4L/d45hyhvNmii/hRL9IycQbFh8MUdaHi0m/evVK/N5q3UZ
	CdlfMx7DKPOzUU5w5UagAZf0e/xtGP3U/3CMkKtyyNS/s4uWZYjN+aqQopvfvU1pSLtAEoXl2iy
	rbdIyqc+MZ9Sdc3S2SJBuexU26730MdRbFOhevbiIhvwFF4RLrqWnDcx6Cpiyt0jcN0a3C3WwSY
	kRmwlhCzBW40VfhiouNU6/oD/tFGDAar4ntYWWo8CC2ODilxrsrexEiT7Bzqqd/s+ApcdyuImcX
	JdxDvhfDx5s0xp0Hjkv+zeA==
X-Received: by 2002:a05:600c:1993:b0:456:e39:ec1a with SMTP id 5b1f17b1804b1-45b517ad4a9mr2412865e9.14.1755806841745;
        Thu, 21 Aug 2025 13:07:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtBnzBdejX2oNj8vG9iZBZKJew+pPrkGWxHzVnhFEnb5RkXIsj+cBFTtJrIXnzr/4lYhSU+w==
X-Received: by 2002:a05:600c:1993:b0:456:e39:ec1a with SMTP id 5b1f17b1804b1-45b517ad4a9mr2412295e9.14.1755806841198;
        Thu, 21 Aug 2025 13:07:21 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b50dc00a8sm10960275e9.1.2025.08.21.13.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:20 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Shuah Khan <shuah@kernel.org>,
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
Subject: [PATCH RFC 05/35] wireguard: selftests: remove CONFIG_SPARSEMEM_VMEMMAP=y from qemu kernel config
Date: Thu, 21 Aug 2025 22:06:31 +0200
Message-ID: <20250821200701.1329277-6-david@redhat.com>
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

It's no longer user-selectable (and the default was already "y"), so
let's just drop it.

Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tools/testing/selftests/wireguard/qemu/kernel.config | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/wireguard/qemu/kernel.config b/tools/testing/selftests/wireguard/qemu/kernel.config
index 0a5381717e9f4..1149289f4b30f 100644
--- a/tools/testing/selftests/wireguard/qemu/kernel.config
+++ b/tools/testing/selftests/wireguard/qemu/kernel.config
@@ -48,7 +48,6 @@ CONFIG_JUMP_LABEL=y
 CONFIG_FUTEX=y
 CONFIG_SHMEM=y
 CONFIG_SLUB=y
-CONFIG_SPARSEMEM_VMEMMAP=y
 CONFIG_SMP=y
 CONFIG_SCHED_SMT=y
 CONFIG_SCHED_MC=y
-- 
2.50.1

