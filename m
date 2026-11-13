Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606577;
	b=jDcOBDSE1gm5Q+U4d3H+Q+t6+ZMQSKIwVPlJGMr78FlSGLBxM6t14S4tVg5/j4+C30W5
	 3K8kBc7zznUrsnNJpzJCUgDYV9zMXpg5MG4ZEUGuvCK2d79xKlhTceyy/Cnc3Y9gy+s6n
	 wUPizMVSBYcmxTHmRpWrD/HQAA/yevF50wwdfuhL1ugAp7nParQbwZluCyG+sjGbU2Vr9
	 KsU6Cqa/n/5RvgDha+75SMRJmPmI0Q9tVOLyTxw9GAmcts4+WTw+u1+kV6lVi7bwg734x
	 FsT9KwUbNF+gqtjamp7RhPlfW/haDByrmHZt6AtCkNWOWgEyCwmnM/TiomcDpPyKuuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606577;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=/qcsr62uFOhvdCv1Z4CFJXXaONdJiHRFO6Btz2367L0=;
	b=km/EL6ASzEs/y3xsjSsTuX3kXsPYXqnfr3J5+EgMxgcLCrG1QsznifPzMKgQ+5+23Xbh
	 xfZRk42WoGwz0QPKRHfU1I23p05Yj7Iuuxh7k20DHlBU2drSESBQSOJnSIUVlXaFSnmLt
	 MUR+tCrOigBdonTzH+X3xP+6yEWR8bphmrSm3J1BvmYWJFw+r791ChV7vA7pAOPKFP2SC
	 tYkdtE9xBtTfswyuRX1Y+rVZZSHUHInvg+DtKyadhC9YD/o3JTaYUHCTcVnotsOvqGtZW
	 IqfM+WeHBCXUFPjasJ4HlKscXRKQG7QZp1iIENlmTblYbyzMUBLtzYdy1oDYaD/vG9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=ghqIEHNU;
	arc=none smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BB360A263B
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 21:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6BB360A263B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=ghqIEHNU
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91ccfb88e4dso33065436d6.0
        for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 13:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794606575; x=1795211375; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/qcsr62uFOhvdCv1Z4CFJXXaONdJiHRFO6Btz2367L0=;
        b=ghqIEHNUTk/Egmeku5ypK1Wz5tcQukr5e5ExNt3NiqCSADJ0H6FB6nWIAfBthKyuz7
         4Xqameh7l18qWPZ3TNz1BUzTHaARTohdL3Zd7gjqrhsDglIKqLef65F8kUYnxrTHB4Zl
         bo90KaR3amttm01kClcxvL8wxycMxohW0EzetFpZWf0eNdqqGIY93nDUjCPEnaGY27q9
         4xOOCpH14vnboktINgLxJ3nanxglA8VyNnVQlMIBaWnV4hH39CJiaU9+ZSZ7HQqRjie5
         Fkc9v66buLfQpspMAvkyrwDNPEy3EEqInyN3YC/kybPSgnrLKdkX7kyCs/WKaMEkqq8k
         2TTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794606575; x=1795211375;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/qcsr62uFOhvdCv1Z4CFJXXaONdJiHRFO6Btz2367L0=;
        b=r3GXRQxTaAyJP5o5bvte05NAhgxzliWJ+cebk2wvdwPIm5HyijyiW3cbMHiuez4viM
         JLDY2FjFsMNiBfmQWirpNBvPZJ5GbAoy7Pw5f5jrSY0awsvfmBdaclAIluHDwYM9eMTs
         NJ7dwiTiOSynevT2G18gRmz5x91GdDAQTxDWU0OuTlZMn5eWBWJpVRREJ2mMTi3FXHD4
         NOMAsu7SVaCgOYOkSLn3MkK9AEGXKcPKrBq86h56cN82+/4jY0DRhxu8cNYRBye4dShl
         UBeMRyC6YNGIHnmAGcf/DMcwfeJPnWV2sHF9P3rr4lNHPB+ycfCCbJGYY9WbMSp4Alv/
         HhcA==
X-Forwarded-Encrypted: i=1; AL+hErHWkcCnUxwKWip27PcPAWz77C9EDeyLcrPjubPB8UxPJ91vbIVI20TRjIar1vkkLxN/rzVNZChxe/3E@vger.kernel.org
X-Gm-Message-State: APuU4Z8gh5az2QmjBtoP7ytxxznC+OojG1VBeCcADhbsEhYDvJWHI9x3
	cDayDPEoj6ZKCKumdMaAIrUiJ9e8Wsi6ADt/2UVlcK2bZAyNmIEPhGzVr8YkhOiJQmw=
X-Gm-Gg: AYBFou34zKRSP6fK6gCjc7c7zwye3A+Yb1MUKriW51cTykAmP7PBxun6B0lAiugCsC+
	JCZFVsy9RKKJCzLpdznTLnVaDlPGEuwCi3gXKLWMd/QSbzPIDvVU3LjpYby8EBCOq+byXG9bPpj
	Y7NOgXyD9JXlX8kaAh/eO3+K7nNszYnD3eeWFOgU753FE2LbT3vLJPVXYFHEYPOCdSt3i1qDiPQ
	QLOMY/6qcMGOSU8N5csTq8noVSoEDRyAkChuzmPE5bJtg2AngfPGXJVsVSLjEfBiTfl6lPObPRi
	4F8BC099nFNzADWPRdb8Ofh/X1ttRPeP+ISQnIILJOpF54MxOkQ/sZFe+7lCxr0ytj9/LPhy4x0
	94GLpku2WaqKV9OMNF/hkT2r/q3SOjCPVGFK0Z81tyUg6OMfpTWRsdmMPYaX4has+hkVVSlWLRt
	jaaGFjv5sqKkQjyQLO62GTFDhuWY1clLRqAbBhWA8W4EBBj5kS1o+Pp0dA8KF+KJxQfZhEracUQ
	vGLhEaPiu5FE0ClKN9rDe4s+e/RHWBgL46XMw2Q0jrVM38sqKa/2uWf/zMcsU3/AFvIb+/7zwYN
	yTb0YZCiK5R5YjEpHiGIUevrpI1C565BC9ZZ6cya/KnMrpw+MMVSb+yx7RQBme4cvosAC6ufG0E
	vrQoHFsA=
X-Received: by 2002:a05:6214:5784:b0:91e:9437:95a6 with SMTP id 6a1803df08f44-91f24222b57mr56835466d6.47.1794606574483;
        Fri, 13 Nov 2026 13:49:34 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d459c6sm29868656d6.14.2026.11.13.13.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 13:49:34 -0800 (PST)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 11/15] hugetlbfs: do not grow a sealed file in mmap()
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>, 
 Andy Whitcroft <apw@canonical.com>, Miaohe Lin <linmiaohe@huawei.com>, 
 Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 Dave Airlie <airlied@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Peter Xu <peterx@redhat.com>, 
 Breno Leitao <leitao@debian.org>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Gerd Hoffmann <kraxel@redhat.com>, linux-doc@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, 
 Chris Mason <mason@kernel.org>, stable@kernel.org
In-Reply-To: <20261028-fixes_hugetlb-v1-11-a0a033db180f@kernel.org>
References: <20261028-fixes_hugetlb-v1-0-a0a033db180f@kernel.org>
 <20261028-fixes_hugetlb-v1-11-a0a033db180f@kernel.org>
Date: Fri, 13 Nov 2026 16:49:32 -0500
Message-Id: <179460657279.482102.3328777708780344971.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-28 21:13 +0100, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> hugetlbfs_file_mmap() grows a file when a writable mapping extends beyond
> EOF. We are missing seal checks similar to hugetlbfs_setattr() and
> hugetlbfs_fallocate(), allowing a user to grow a file that has F_SEAL_GROW
> set.
> 
> To fix it, skip the resize when F_SEAL_GROW is set; mmap() still succeeds
> without growing the file.
> 
> We currently also allow CoW mappings to grow a file. Disallowing this,
> maybe even only for read-only file descriptors, could break existing
> userspace, so we have to be more careful. QEMU's file backend is an
> example user that might rely on such things, and would suddenly start
> getting SIGBUS when faulting in memory outside EOF.
> 
> So be careful and focus on F_SEAL_GROW for now.
> 
> Fix generated by an LLM and sent by Chris Mason in private.
> 
> Fixes: ff62a3421044 ("hugetlb: implement memfd sealing")
> Cc: stable@kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: drop comment; simplify+extend description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reproduced by growing a sealed memfd length from 0 to 2MB.
With the patch, we stay at length 0.

Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

