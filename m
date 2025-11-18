Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C224F2F548A
	for <linux-s390@vger.kernel.org>; Tue, 18 Nov 2025 00:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763427194; cv=none; b=qz8T8CP4Gotgx6PEjf6NMBrFcFoLk/F4GRjxpfaM9PyhYxktjiH9mhKDYMae9eN69QG8rDAYsDmG1dhllj/vX4W007k0o/IC1x61Y0kY6M7EYpmi6WyE4nLcroHsDEpHSLbn8l8KrOJHDdzz53k1qqmVIpOqDXbPFx9efvmaa0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763427194; c=relaxed/simple;
	bh=pfVZo5pq81wNsPJgUa90qDINb3FW9xgTlXqCyicI4LE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hHdXe+EAZrIb4eYligvKEGooXx5p+HcE95aFrS4dEtwclEbUsICC8pMlhNN7CfdhQT3kfFrNAbEqgzxfqEI2KSJuDgZg1/zUzSIUAkA8PM8BZglsmJI/GBtdixKPXFO/dO48n7vbpIegkeXpdRqt+/BPUCX4F9+tMe+Ir/03UFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=SZ62LKPT; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="SZ62LKPT"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-297e2736308so4457635ad.1
        for <linux-s390@vger.kernel.org>; Mon, 17 Nov 2025 16:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1763427192; x=1764031992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ECcRFPnZSJ/74qLcUT1nDtXwbFmCLS0/Z+AkSmPgFFQ=;
        b=SZ62LKPTWjF6hTBBYSlyaox+K/WBPQXcYPxjjrjtA/949L02VfY5p8P9uDDxZXRlOz
         R1o5oVkGdqbqqK8Y0ZkO3B9hbvNl1LmXl3AsZA4jjz85zF0+Hq/JplC/Kzh3d1K7YwYT
         hjB6D8v46JaV5zmLdFat+rgySdm6PyqK0gCuhp8cRFXs9wwCqOi6S0x2x+Mtaxlfg+/a
         aMoCcjWjrA7apOCO//WGPWb+flSNVGC0lHXuaQETt8B8aNYhggtGNrImLe2NAD9AKoT3
         0qoGOvh1xNjSFPtaa+F7vuoPe3gJLtXw2mV3yri+1WJt5C8gKGf0aD4ylnkdtAgdPHGS
         xmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763427192; x=1764031992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ECcRFPnZSJ/74qLcUT1nDtXwbFmCLS0/Z+AkSmPgFFQ=;
        b=ItgqeMTIs37i2uPOvpjA/9tChXYAV2ZPLTZqtpOCKk5ZtD/CyLIkpVZxSARhm52QpL
         6jDhR5CCiZuW8BW8hf0Fx8y3VA9xURjq4kzai4cmP6miFIx7Mo4ivgEeISxwjP2Eavo5
         3duRyRFSpsPIv2tk9f9zrtKbEnOwaCm5koaOd/nrh5MDNKf5vCK4dZC3KQqKNnWf2GRF
         EAsVjTbVlWWdS4N42lFKTAatLzrnacpK7F8Sss0q0R7mGjyw3xHwEFoYTYmu0yhDacK0
         BoNBG7Fnrr7Zn0bvSi5thvC/7RTWzomtfEinqgoq0eitddkPIeZm0JIufDAZ2lnyyXmm
         SDVA==
X-Forwarded-Encrypted: i=1; AJvYcCUOE4wuyuMiCWZbElbGpk65viIZvHMu4UCyyW4tg0deUmbvNhz213MWN/ZUErX64/OVB3gEn3J935Qg@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7/B1tj7OCimbmt1EWkpQIY6wd827x1tLwXpUFXlLPV2ECsz5K
	Yo2+gH0od7WjkAwBCw6tAgj+8VfLsvQY+YZozIsgKvpPRkzqnuJE/NjncMB40KPQcrq+LlsyK/e
	3t4B7
X-Gm-Gg: ASbGncs8TqbaB4m1Ck0nwdVdEYCza3M0Dmt7b7LWDQ2OnOUJcxruXXfU/ciR+oOJN5z
	N7nn2vd9MU8ASiw/JwWHpcmvTuqIcqVztMaRPHutTC+C+jm/ftwBOonCTbUShff4U01I4pLCKSJ
	iZAcbzF+Pg4tBx3ooGhdWIqzjCW7KebqzG/9kxO4vOvS85kCsr60PcxMZxVzSv8jakSfeZxHifv
	YwPhMQqxJfXwVRQiZX24Is7FGPTC8YVVgzYmKcPrQYJNzZo53LxM2yiZ2LPDdnEBqQuqVj4veVE
	FmGJb9WriEJD7NfPnrWG7VOjOowM+FFI7VjLVgDmxvl62JFjUZP40T+OZwd42yTV6Ev7l+AVipN
	xmqP8enacr+xNYMWBP9VoVmO5qb8TThFi6YZNmNTtgkKeiIBgJ/+nzA99+txJ8o+N
X-Google-Smtp-Source: AGHT+IEjPzaJypGOyu7ighv5aVAvafyjybl9abS/IeF+SU6SIlOj40X9SRbCB6CrI/miT/nJFjWaxw==
X-Received: by 2002:a05:7300:fb05:b0:2a4:3593:5fc8 with SMTP id 5a478bee46e88-2a4abb56fe7mr4474649eec.2.1763427191866;
        Mon, 17 Nov 2025 16:53:11 -0800 (PST)
Received: from t14.. ([2001:5a8:47ec:d700:ef59:f68f:7ffe:54f2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49d9ead79sm67568555eec.1.2025.11.17.16.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 16:53:11 -0800 (PST)
From: Jordan Rife <jordan@jrife.io>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	linux-arm-kernel@lists.infradead.org,
	linux-s390@vger.kernel.org,
	x86@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>
Subject: [RFC PATCH bpf-next 0/7] bpf: Implement BPF_LINK_UPDATE for tracing links
Date: Mon, 17 Nov 2025 16:52:52 -0800
Message-ID: <20251118005305.27058-1-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement update_prog for bpf_tracing_link_lops to enable
BPF_LINK_UPDATE for fentry, fexit, fmod_ret, freplace, etc. links.

My initial motivation for this was to enable a use case where one
process creates and owns links pointing to "hooks" within a tc, xdp, ...
attachment and an external "plugin" loads freplace programs and updates
links to these hooks. Aside from that though, it seemed like it could
be useful to be able to atomically swap out the program associated with
an freplace/fentry/fexit/fmod_ret link more generally.

Implementing program updates for freplace links was fairly
straightforward but proved more difficult for the other link types. The
third patch in this series discusses some other approaches I considered
before settling on the current approach, but I'd appreciate others'
input here to see if there is a better way to implement this that
doesn't require architecture-specific changes.

Thanks!

Jordan

Jordan Rife (7):
  bpf: Set up update_prog scaffolding for bpf_tracing_link_lops
  bpf: Enable BPF_LINK_UPDATE for freplace links
  bpf: Enable BPF_LINK_UPDATE for fentry/fexit/fmod_ret links
  bpf, x86: Make program update work for trampoline ops
  bpf, s390: Make program update work for trampoline ops
  bpf, arm64: Make program update work for trampoline ops
  selftests/bpf: Test BPF_LINK_UPDATE behavior for tracing links

 arch/arm64/net/bpf_jit_comp.c                 |  23 +-
 arch/s390/net/bpf_jit_comp.c                  |  24 +-
 arch/x86/net/bpf_jit_comp.c                   |  17 +-
 include/linux/bpf.h                           |  21 +
 kernel/bpf/syscall.c                          |  68 +++
 kernel/bpf/trampoline.c                       |  75 ++-
 .../bpf/prog_tests/prog_update_tracing.c      | 460 ++++++++++++++++++
 .../selftests/bpf/progs/prog_update_tracing.c | 133 +++++
 8 files changed, 796 insertions(+), 25 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/prog_update_tracing.c
 create mode 100644 tools/testing/selftests/bpf/progs/prog_update_tracing.c

-- 
2.43.0

