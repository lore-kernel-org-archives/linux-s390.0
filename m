Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594B636EAB2
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 10:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782209447; cv=none; b=d3I6aELjyStD0vUA6woL1BpyqO3A2PLYPItq+sdAgIkENCiL5/nI6qktfaaI6bwaXBlWcY9Bf/dWqbIAzrdD2nwPLWZP7tz6917kXbkElvt/TPnETYWOjMTd5aViguD6QrbFFmSVPsm9giFPDc30EjARkk8wm0wMFw3BTWPXr+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782209447; c=relaxed/simple;
	bh=uhA+JyyRZIPxz0qljYM0uVmm3ahqPcFCCZcwfbgkmhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=juSD2kgB1gGPf8ruiFyvlQoz+4m0ysB0Bzs3CJ7zupDDMkZtX38u0UKmsGYhQCKHnfqiCkOD6QBHv3UYvWSn18PHxaJHS9ZxLWvvPl1CcjdvIKEnRPON0P5yRRNZPhHIRY65fQPCu1iOEB9UWBie+LCMtwHmEmMZTCi+WRB6Bsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOlobk7e; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOlobk7e"
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-37cae9b7536so3208306a91.3
        for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 03:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782209444; x=1782814244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9xRyN5mmtNm+QB3YIDVLwBheiPW9GTxijNSPRoIWhA=;
        b=cOlobk7eIBUcDYEKA1fDo8Wf0jzIB/Rc1SzTUCX3Kyq1bM81yMnmbAJFP5pM3sIed8
         Tp8gZ2tMHQ47M4RVpF15Pisp1jALlcm1YGrgqYJfxvINIt7iPx/vp4wHNn/2P/qgCvWk
         6iK2dc0x++1mXk2eauqO2Oltahsn09qkxTnBRJHMQto1rBMJL/unkmoQBGUSQMMWU+cx
         Vkl1abCl73CMUek/1RYUY5KhmlicBSsZAZVIXeVvL72PRw2jUxBjLXSMj44abb1FIZRB
         hsLBmrt49bcJa+KmJ0C5GUzPj9IbxlbqNVCOKqVzYLtAL9EF36z2xwQmXF2oe5+zb5Pe
         rHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782209444; x=1782814244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q9xRyN5mmtNm+QB3YIDVLwBheiPW9GTxijNSPRoIWhA=;
        b=ej7iTrjr2MeC2GALv1lzJ4MeOfQzuCJkJhXLJ3qJPvWjDMFwnnaMX9msqkd+r1wOdA
         nlXfMCEJu1FZcwxFU1tOj1qhdWiv2BXE6ugkhcRgzk7eaK3w233ykVkRtzVx5Ht4UWRR
         AmZk/9dZWdPbbH2jJzVKqn7YQscHYSoniB4gZR/Dj35BbLKupQmiuF3dKMDWFxijQV7z
         ZzTSZodCM+D0DgsvwvEJBGKXtAPz3mkPYcnAnlxc5v1xwiNQ5OlJ9rVDyw8r9r9jGZ+H
         iKqq2pIFYDTXUl4D2qCosiPku7sThU55St80tbHhDb33ETSQuwvGLlze4FWxO4/LMt2Q
         C/kg==
X-Forwarded-Encrypted: i=1; AHgh+Rr4QsAXs1Jcp3l6BBpYIR1Fhlmu+/1cmanpXSd+2FJpwexFYMyUDZ7m+vRcc1rvihTJVEeUuJ9QVftV@vger.kernel.org
X-Gm-Message-State: AOJu0YxUvCZMuw3l62j2V39B2egg2abeuMhWzXt+nYuhBCV9gRcFLaMs
	gGIAPwIhaPke5Wjlk0iwL9lD9DwVlDdmXw8twgxUfxL+zEGIv1WQfRgj
X-Gm-Gg: AfdE7cln0QhEDk2NNsVAmgRkGdEFlB7MjcEhpw4IcchqsuOka04wnhAE49rqC8toYm2
	4M8N9bczZsuIf9G+mfaa19BKz+nDA5kP48C2JeQOuWOqxZ6VvRog2znZ+IRsOEzPIgOZbiCiv21
	TKsSSCKS5NviDW6f//C7HTup2r4KY2IUwXGFXVBdlgkpegRK5Y0wXehhyXervN3uyBfdppm1nVQ
	JjV3Q2erjEmgc8SFjyxsfDOS98kmEy9rO1+diHjiOnnZV5hj0nStj5Zjwf/MWmI9bk8HBr88XLN
	gdaQJZwtJd5iRgDn6RJwvstmU7dQej+6Em6ra8jdL/AsDJbV+9GpJ0cNamFBFMInMEHDeCEVMgK
	jJlHGvtyq7b7wj4ICVq5AbKSCPHqRHgL0ATX5ZGx4Z3Aaxsxl2W0ZULHAU+XCj9LeRpWZcqeiN9
	XLGDz7im4CV49Sh+/RRl7tJvNppFRp2e7og6U9VTl5
X-Received: by 2002:a17:902:ec8f:b0:2c0:e5ee:f56c with SMTP id d9443c01a7336-2c7c99def24mr17988445ad.20.1782209444473;
        Tue, 23 Jun 2026 03:10:44 -0700 (PDT)
Received: from zhr-ThinkStation-K.mioffice.cn ([2408:8607:1b00:8:ede9:3e72:37cf:55a2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7436f7e0asm118059125ad.30.2026.06.23.03.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 03:10:44 -0700 (PDT)
From: Hongru Zhang <zhanghongru06@gmail.com>
X-Google-Original-From: Hongru Zhang <zhanghongru@xiaomi.com>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	baohua@kernel.org,
	bhe@redhat.com,
	chentao@kylinos.cn,
	chrisl@kernel.org,
	jack@suse.cz,
	kasong@tencent.com,
	kunwu.chan@gmail.com,
	liam@infradead.org,
	lianux.mm@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	liyangouwen1@oppo.com,
	ljs@kernel.org,
	loongarch@lists.linux.dev,
	mhocko@suse.com,
	nphamcs@gmail.com,
	nzzhao@126.com,
	pfalcato@suse.de,
	rppt@kernel.org,
	shikemeng@huaweicloud.com,
	surenb@google.com,
	vbabka@kernel.org,
	wanglian@kylinos.cn,
	willy@infradead.org,
	youngjun.park@lge.com,
	zhanghongru06@gmail.com
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page fault performance
Date: Tue, 23 Jun 2026 18:10:09 +0800
Message-ID: <20260623101009.522775-1-zhanghongru@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <d04f745d-eb3e-4d2c-8ea2-5fdcf2cf27b8@kernel.org>
References: <d04f745d-eb3e-4d2c-8ea2-5fdcf2cf27b8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 6/23/26 10:02, David Hildenbrand wrote:=0D
> I know that especially browser usually use fork servers: a tiny=0D
> (single-threaded) process just to create new child processes. Any informa=
tion=0D
> regarding the apps above that use fork() on small vs. large processes?=0D
=0D
I wrote a second BPF tool (fork_info) that captures nr_threads and=0D
map_count (VMA count) from the calling process at the exact moment=0D
fork() is triggered. Results from 3 representative apps:=0D
=0D
  App (category)          Fork caller        Threads   VMAs=0D
  -----------------------------------------------------------=0D
  Taobao (shopping)       DaemonThread-6        526    8,987=0D
  Amap (navigation)       DaemonThread-6        289    7,120=0D
  UC Browser (browser)    OneNativeThread       350    8,144=0D
=0D
These are all heavyweight multi-threaded processes (hundreds of threads,=0D
7,000-9,000 VMAs), not fork servers.=0D
=0D
> Above you write "some call fork() from multiple threads". Any further=0D
> information on that?=0D
=0D
Xiaohongshu (com.xingin.xhs, social media) is a clear example. In just=0D
tens of seconds of normal usage, fork() was called 22 times from 4=0D
different threads:=0D
=0D
  PID     COMM            THREADS    VMAS=0D
  4206    com.xingin.xhs       85    4,140=0D
  4216    Thread-2208          85    4,157=0D
  4208    Thread-2208          90    4,211=0D
  5200    Thread-3200         337    6,519=0D
  5200    Thread-3200         343    6,563=0D
  5200    Thread-3200         361    6,769=0D
  5200    Thread-3200         453    7,793=0D
  5200    Thread-3200         450    7,779=0D
  5202    Thread-2219         459    7,846=0D
  5202    Thread-2219         462    7,875=0D
  5202    Thread-2219         465    7,899=0D
  4219    Thread-2219         465    7,903=0D
  4219    Thread-2219         468    7,922=0D
  5202    Thread-2219         467    7,917=0D
  4219    Thread-2219         467    7,921=0D
  4219    Thread-2219         468    7,929=0D
  5202    Thread-2219         464    7,909=0D
  5202    Thread-2219         460    7,889=0D
  5202    Thread-2219         459    7,884=0D
  4219    Thread-2219         433    7,771=0D
  4219    Thread-2219         433    7,771=0D
  4219    Thread-2219         434    7,778=0D
=0D
The process grew from 85 threads / 4,140 VMAs at first fork to=0D
434 threads / 7,778 VMAs at last fork, showing these are long-lived=0D
heavyweight processes that fork repeatedly throughout their lifecycle.=0D
=0D
Tracing tool:=0D
  https://gist.github.com/zhr250/ba7725d0ea55594bcafd3cd4806eed98=0D
=0D
Hongru=0D
