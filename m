Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155763587DB
	for <linux-s390@vger.kernel.org>; Mon, 12 Jan 2026 12:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768222499; cv=none; b=baaCf16bODqi/+MZjAR7Men58Q1fYTvsvGa3t0eko4VibckGRXDKWoTd7zng380j6lU1k0GM13Fwc6sQ3PPOaYwrWakSIdZB0Y4pHTbw5uxu06UzyqRpQaJITBEzmp+UE6jOSbANMuVL1bbP4T7Hu+NSZV40RA8ejBycXHgmeng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768222499; c=relaxed/simple;
	bh=XU1R8eEmf+8OcV6QhVEoFS8ffVTmlKxgnjEPke2eHaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gzPnxF8pve9QPa0DD50BFmiBRluTRnG7bqJYTSx3prIGEHXJQrli3K2D0sZLVlfPPe0lepdVXPdO57nPr1XBOCgcoAGSpk43+aLXfPy7OoXLZ9nxgsKqzYthpSnC+WteaQ7FI3e6WnMwGQZLULcJ9GtaU9Y6amJLLxo/sH9+aLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C28sQEKN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LqSqNFh5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C28sQEKN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LqSqNFh5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768222493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2pTWpsZNjWgj8wv5f92UAOMouEbb8hc3HuMURULyk40=;
	b=C28sQEKN/u94Tg/mDNWIy1b/P9q5jnQhLTen3NpoBZuj+Ro8xD4xvA1svldoix5FeuyCqT
	btulS615GkqOtxa8p9a9kCdbybML6Em1GpIZbd+JGNnLD3GpxZNdzwAUzvthrMNKE8v3EC
	cPr3Ni0rFKX9E8SGcayJLajhOJUJ/4s=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-XlgdL1-_M56Dx6MTEfe88Q-1; Mon, 12 Jan 2026 07:54:50 -0500
X-MC-Unique: XlgdL1-_M56Dx6MTEfe88Q-1
X-Mimecast-MFC-AGG-ID: XlgdL1-_M56Dx6MTEfe88Q_1768222489
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b8701175a88so106747766b.1
        for <linux-s390@vger.kernel.org>; Mon, 12 Jan 2026 04:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768222489; x=1768827289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pTWpsZNjWgj8wv5f92UAOMouEbb8hc3HuMURULyk40=;
        b=LqSqNFh52oCCy4tw8QgSvS8ufBhTEEWVhgKds6lYaSxVk1WvSTIIEACeYiUzsVQpPM
         IjyuipVH2D8+7BOhL8h1P3wvZIhCCwu9POsdpoifZ8r/o9RkJtG1QEMlz5Ww3LHc7NsT
         PCAZ01DDVwLMNqGuRjD3sLZGnaTQYfyNtoG/H8iQJpXYp+vlU107WBn52H86etbyw6pb
         92l4B4JQnuhwAFrO2eAtIgK58nj3X2GbICLw2L9XNuEjR1BvBQzCw9BQyEc232Fy3izr
         lXEkITsELO+NXFrfTHcuhW/wH1PKXtDUivtDxdxPfcMG+Tk2WPWRmcHAwQ37rht0prEQ
         lfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768222489; x=1768827289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2pTWpsZNjWgj8wv5f92UAOMouEbb8hc3HuMURULyk40=;
        b=GYdhJuhLwiGJODoootrqOOktbhCPCjNGJnBdIWazZBw9v9fRFtloFL89VUEbpBphW3
         xW9Mfs8JzFNWCIYfOn34Scjt+K3Ds8dsi9EMpECdeL9OlaJSuuEZ9yfiHdf+iagXKY4Q
         WzCFSnvVUIuHu03Wt2+V4Ozvbnded3XKn68Zelv9CMoKfX/oOKAniuJqYh92eLpuUxcN
         Y2EJI5TZ/q9A5py4UMSbruuZdXz1wN66Xs4cAt/7pqfKlE/5rCtjh9bALFkjpZ4QeHVp
         8bRbGX16xvw1aAxVm5FY4nexypIegrCdlTR7C1O/U/kJ1nXw3XvZpxQ7KlKK6YiBmYGe
         uTVw==
X-Forwarded-Encrypted: i=1; AJvYcCWrc1N40RLOkIxLsTF4LwK4088VozHj1fH5g2aFa1t/dhk0g5J5QngvZygD0TQeToJhqdDvUyDBOjzW@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb+zxObqkm+sRagNqDV2rfG9PzyFyL5QsWJesIBSo3o15VO6PI
	BNUK/sE8SEa/kH97y3XKRRWhGDqVQirhtG+IGhwTvF6HjbaDXD/NAFFB+ROpuOTudp7n5HlRkJK
	z0LFDDyD84AGakzoeeeamiywAddRY3uyoiCBCPMIhbe6COrHcfGE8+t5G7N+PJyY=
X-Gm-Gg: AY/fxX4/hxIOohpO4nkU39iBjxYUmSTf8pi9HTxqdTgpWGmwOGqTIZUMDAq3wGBPWHI
	Iltf8jxQOAmnIK5IRW1B/Fp3YRDdfx86MTyKGqFNTmWU9im0ne4CXX8WMPwSUvihoHcgLPRRuIB
	VMwqKESRxKmgejj2UcfhjjQKhZGTHKg8AmHf3Rwb0mOyVz0+EPBUh9qyJq/SfF1h4eITnroMhQj
	qwvHQfoaNiZ9oOgqmlvK6ahM7ajCXQFlbezJjHKoF+au99OCpglcgJVQAJFbjvd30etzirkabnr
	GuFDu7Nlv5Nl+tYlNksnObCQ2TD1+BzFGQX9An+Lp9BrUCmXzchma47wL0cXpUlQKKAEvYc2M6G
	P+E7Cd0rCGCaeWSNIh42Bjo+ABHkA2/BcdR88i6AuiiM4q4A7F8Mf/77a/KE=
X-Received: by 2002:a17:907:a0e:b0:b80:34e8:5eb with SMTP id a640c23a62f3a-b844542221cmr1612467866b.55.1768222489053;
        Mon, 12 Jan 2026 04:54:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7t8/HlV/5AlKScEccxcE3fk05AaGQ3PxxJdFkixgC3oQPqTZ4vVB050U3KXnraou/3iD9lw==
X-Received: by 2002:a17:907:a0e:b0:b80:34e8:5eb with SMTP id a640c23a62f3a-b844542221cmr1612464966b.55.1768222488577;
        Mon, 12 Jan 2026 04:54:48 -0800 (PST)
Received: from lbulwahn-thinkpadx1carbongen12.rmtde.csb ([2a02:810d:7e01:ef00:ff56:9b88:c93b:ed43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8706c2604bsm497062466b.16.2026.01.12.04.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 04:54:48 -0800 (PST)
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
Subject: [RFC PATCH 2/5] selftests: net: replace deprecated NF_LOG configs by NF_LOG_SYSLOG
Date: Mon, 12 Jan 2026 13:54:28 +0100
Message-ID: <20260112125432.61218-3-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112125432.61218-1-lukas.bulwahn@redhat.com>
References: <20260112125432.61218-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

The config options NF_LOG_{ARP,IPV4,IPV6} are deprecated and they only
exist to ensure that older kernel configurations would enable the
replacement config option NF_LOG_SYSLOG. To step towards eventually
removing the definitions of these deprecated config options from the kernel
tree, update the selftests net kernel configuration to set NF_LOG_SYSLOG
and drop the deprecated config options.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 tools/testing/selftests/net/netfilter/config | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/netfilter/config b/tools/testing/selftests/net/netfilter/config
index 12ce61fa15a8..f7b1f1299ff0 100644
--- a/tools/testing/selftests/net/netfilter/config
+++ b/tools/testing/selftests/net/netfilter/config
@@ -64,8 +64,7 @@ CONFIG_NF_CT_NETLINK=m
 CONFIG_NF_CT_PROTO_SCTP=y
 CONFIG_NF_FLOW_TABLE=m
 CONFIG_NF_FLOW_TABLE_INET=m
-CONFIG_NF_LOG_IPV4=m
-CONFIG_NF_LOG_IPV6=m
+CONFIG_NF_LOG_SYSLOG=m
 CONFIG_NF_NAT=m
 CONFIG_NF_NAT_MASQUERADE=y
 CONFIG_NF_NAT_REDIRECT=y
-- 
2.52.0

