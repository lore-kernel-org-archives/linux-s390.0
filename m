Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943E7357A5D
	for <linux-s390@vger.kernel.org>; Mon, 12 Jan 2026 12:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768222488; cv=none; b=tjeZkbmfVi28KVIYINlWnGqgvp8EakIhK74j9IhP53MCJFEDcmumuzh73sHxXjydi3kuT7Ae0Lhbi5oNrX2ojEkvibjzRTLqGADHwpQgmSdBb28y7Hy/uAkXXBsmZtAXS71qOdoi+l3LD5u88mSbxIdzk0f7V1RUtn7sHRLu8Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768222488; c=relaxed/simple;
	bh=ArVVBiqIBetgJi+p5f+cmJSVHQwk79p7Tqq1GTf/FIY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hb2QQUCswruj3VwvPvdv9g5BaF97DO1S+wvRZGlO6pT6JiYnkeGAbAZ/A7Y2GmhjhWLZj/YyV48RNIXgX5FBxOxX15Owp3WacX8k4A/DP4DFz0B/sdaEKDEZEXifwGnn5Sm7C3ZmlR6XElZdnEYNKaZoGi9jQWuG0OG7z3QxXag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E9j4cyk5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rCxp4Ryz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E9j4cyk5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rCxp4Ryz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768222483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iKF0BzHe4DoMZWSEsankET3G7Dd2Xauwml8GRRGytpc=;
	b=E9j4cyk5z0iEToT85F/Oc74/7Vp/ox9v9+St2NSE2BbsvfxfVnI7M6DsWgeC6i0jZZBejb
	dAn6CK65rZSSIXwbaJihC/fIekDj1Sp6ZJlkPaO0uD9wEaXuVDPyBVyr2itqMBCeIxKVOj
	o4DwzypcW/YD3mpcYZaXTztk8gWUBSQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-Nq4Vbo6dO1q7fU2OHN5uig-1; Mon, 12 Jan 2026 07:54:42 -0500
X-MC-Unique: Nq4Vbo6dO1q7fU2OHN5uig-1
X-Mimecast-MFC-AGG-ID: Nq4Vbo6dO1q7fU2OHN5uig_1768222481
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b870f354682so133023566b.3
        for <linux-s390@vger.kernel.org>; Mon, 12 Jan 2026 04:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768222481; x=1768827281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iKF0BzHe4DoMZWSEsankET3G7Dd2Xauwml8GRRGytpc=;
        b=rCxp4RyzYa1uRlHfi4XCk6oEMRJJXQ9SgGaYEBF/YfmuGPtkoZrDAfaxomS6GCz6Za
         QiN9IH2twxYg+43Ig2uUrdLwb3VuNarUO8ZDZfruxNxxxT8n3txWJS7ZxBvGpxY1Marm
         w2N0QCCS58hX+iD7Q3wlj6wTnNiTQAg30DJFY/HwEaUR+1w8K9zQfHZNLP3rST+puygG
         S5TKaTzGsSxcicY34XgrKC/7iSg5UcrA5ppX9ojDzluwSo9+pCpfJenj0wgiCn7A9nSR
         2/mgXe3TuUFIJlmkjqC6oS82ir5qMn0wr4ssq8/HLwbsFVwSS/YtEnjtvtr+Ga6DCD1w
         JjOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768222481; x=1768827281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKF0BzHe4DoMZWSEsankET3G7Dd2Xauwml8GRRGytpc=;
        b=fZINjClU+izKtvoJ3lbB34/kjWqIiaxMrvoQInbqBYJfdl+NvUnc6dY5hgql0KBSAO
         h5v2SxY9BFlmomZOrEpdRGhrmOThsHU/oPTUPtQWU97q4kaF4tSP8ZEPba1s99sOHD8A
         5ETrF0uUBBP/UwOWF2MUHV2QORVjAW5p7wRfHj1MiEdjliKWXRTUEymx7z7yd/Bp9FUP
         ntXe2doDYR5cGOw+cQ26Hh/vJd/RRf7H1MsF+kw0EvOAfT3KAehNcAH5pnfiJEwfi5yW
         kRSAZxVBf6sNT75OUsWKhofv1mo97GoJl+gDf8hRc1dKaOnz4yRH6yycrqVxzT8eAlQG
         xHgA==
X-Forwarded-Encrypted: i=1; AJvYcCW+chfB+nExwJG//dr4MS3U6vloK5HBIuGlEtaXe4/nRAvlIGgpUA2UM1ttTV8KdI6354ViY3KygMH3@vger.kernel.org
X-Gm-Message-State: AOJu0YynWKXK78O7Yyo0KI9QaAj8W/aV7kcyMcVTWc5NBPTw+Flw+U0B
	ouRLMPlxLzaD6qF8Cfl0g9kNVBI7ulYtw5otrxUhyJDisdRzxrKn9m0RsdOjjKTnTBBJpakiZpN
	BfggDo72uabhLj3fugw25WjGl6fAfLkdzKUg2nYX6VEsQOMw6f0G6lhl7FygBQnw=
X-Gm-Gg: AY/fxX5uAUeXf1C2fVtOfy5WvmUHJqvGGl0p0efZR09f5dyM/tcLJwexFg7v55+fcYM
	EudHwH4Ub4PJuBgEQ6dY6bmI0fahHnZiayGdGacUNVH6Z06qot/KHjC9oW0uTG1Ep7bICPUCfMr
	R2KAlM3pW8UaIQjbjJwfZGOER6JATsnD/fiXGq+pduIPHlQjkCSjqdE0Oy+7D9A3qrfzjYAZFOO
	CH/m4olHlBqQrx2131/mQB4CRdAEGfQ1IMcmRwOjMLvdG5sE8CTSLSFQWYihu81MWwwbkPDCStP
	2f1LPiutI1xLDrXOotdVoTkD7M6devqOOypOOtjI/G4BxiKLV4onGryA0s40EN4tP3fOewkeMXt
	YABrkqwh/OxtADDoRDX+lZQVOJejl7ZWiLcpNeeu/wQ93LtzMAIu89xcdN1M=
X-Received: by 2002:a17:907:a4a:b0:b83:8f35:773b with SMTP id a640c23a62f3a-b844501e49emr1772457366b.54.1768222480787;
        Mon, 12 Jan 2026 04:54:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSZz6AlBAsyDbYMyXJssyt5r14tT5j/dhOjPD0uwwtT32eYJd5F4wjSbE4zxf083DcjrlpEg==
X-Received: by 2002:a17:907:a4a:b0:b83:8f35:773b with SMTP id a640c23a62f3a-b844501e49emr1772452766b.54.1768222480270;
        Mon, 12 Jan 2026 04:54:40 -0800 (PST)
Received: from lbulwahn-thinkpadx1carbongen12.rmtde.csb ([2a02:810d:7e01:ef00:ff56:9b88:c93b:ed43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8706c2604bsm497062466b.16.2026.01.12.04.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 04:54:39 -0800 (PST)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-riscv@lists.infradead.org,
	linux-m68k@lists.linux-m68k.org,
	linux-s390@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [RFC PATCH 0/5] net: make config options NF_LOG_{ARP,IPV4,IPV6} transitional
Date: Mon, 12 Jan 2026 13:54:26 +0100
Message-ID: <20260112125432.61218-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This RFC patch series makes the config options NF_LOG_{ARP,IPV4,IPV6}
transitional. Recently, Kees Cook added a feature to kconfig to assist
transitioning deprecated config options. Here is a first RFC patch to apply
this feature for NF_LOG_{ARP,IPV4,IPV6}.

The plan is to mark all deprecated config options in net transitional, and
update the kernel configurations in the kernel tree to not use those
transitional config options. Then we leave these transitional config
options for a year or two to allow users that only update from one LTS to
the next to see that these config options are deprecated. After such a
grace period, we can finally drop these transitional config options.

This patch series is the manifestation of that plan for the three
deprecated options NF_LOG_{ARP,IPV4,IPV6}. If there is general agreement
that this is how deprecated config options are to be handled, then please
apply the patches 1 and 2 to the net-next tree.

Note that for the time being, as there is no dedicated kernel-wide Kconfig
file for collecting transitional config options right now, so simply adding
them at the end of the net/Kconfig file seems the best choice for now. 

The patches 3, 4 and 5 are added here to understand the complete treewide
change to transition the deprecated config options; I expect the patches
3, 4 and 5 to be applied by the corresponding arch maintainers, though.
Note that all patches in this series can be applied independently from each
other without causing any regression, i.e., if any patch 2 to 5 is applied
without patch 1, the resulting kernel configurations still enable the same
functionality as before as well as with patch 1 applied.

Once the general approach and patches are accepted, I plan to send some
further patch series to transition more net config options. My current
investigation identified that these further config options in net can be
transitioned:

  IP_NF_MATCH_ECN -> NETFILTER_XT_MATCH_ECN
  IP_NF_MATCH_TTL -> NETFILTER_XT_MATCH_HL
  IP_NF_TARGET_MASQUERADE -> NETFILTER_XT_TARGET_MASQUERADE
  IP_NF_TARGET_NETMAP -> NETFILTER_XT_TARGET_NETMAP
  IP_NF_TARGET_REDIRECT -> NETFILTER_XT_TARGET_REDIRECT
  IP_NF_TARGET_TTL -> NETFILTER_XT_TARGET_HL
  NETFILTER_XT_TARGET_CONNMARK -> NETFILTER_XT_CONNMARK
  NETFILTER_XT_TARGET_MARK -> NETFILTER_XT_MARK


Lukas


Lukas Bulwahn (5):
  net: make configs NF_LOG_{ARP,IPV4,IPV6} transitional
  selftests: net: replace deprecated NF_LOG configs by NF_LOG_SYSLOG
  m68k: defconfig: replace deprecated NF_LOG configs by NF_LOG_SYSLOG
  riscv: defconfig: replace deprecated NF_LOG configs by NF_LOG_SYSLOG
  s390/configs: replace deprecated NF_LOG configs by NF_LOG_SYSLOG

 arch/m68k/configs/amiga_defconfig            |  3 +--
 arch/m68k/configs/apollo_defconfig           |  3 +--
 arch/m68k/configs/atari_defconfig            |  3 +--
 arch/m68k/configs/bvme6000_defconfig         |  3 +--
 arch/m68k/configs/hp300_defconfig            |  3 +--
 arch/m68k/configs/mac_defconfig              |  3 +--
 arch/m68k/configs/multi_defconfig            |  3 +--
 arch/m68k/configs/mvme147_defconfig          |  3 +--
 arch/m68k/configs/mvme16x_defconfig          |  3 +--
 arch/m68k/configs/q40_defconfig              |  3 +--
 arch/m68k/configs/sun3_defconfig             |  3 +--
 arch/m68k/configs/sun3x_defconfig            |  3 +--
 arch/riscv/configs/defconfig                 |  4 +---
 arch/s390/configs/debug_defconfig            |  2 +-
 arch/s390/configs/defconfig                  |  2 +-
 net/Kconfig                                  | 21 ++++++++++++++++++++
 net/ipv4/netfilter/Kconfig                   | 16 ---------------
 net/ipv6/netfilter/Kconfig                   |  8 --------
 net/netfilter/Kconfig                        |  1 +
 tools/testing/selftests/net/netfilter/config |  3 +--
 20 files changed, 38 insertions(+), 55 deletions(-)

-- 
2.52.0

