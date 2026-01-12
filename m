Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B1B359717
	for <linux-s390@vger.kernel.org>; Mon, 12 Jan 2026 12:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768222504; cv=none; b=lqLSRtnkMAtgKSD3TFyHMbCEVM5JX2D01AIj/Ahg2YhK72t54uOkWK4oK8z2/VjUAIvxhKZNLzlDrlNc/VrcVusrWs80+WSXUNMLKKiVrVbE/YwHai6WRHB12vnIQqby8J6ffuIfStZxxoLI9ID7dmQek68tyxRa7Sj5M+Guoq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768222504; c=relaxed/simple;
	bh=TCr86+g83B5jykr4uoI4MF4hOXPzr5E27AlUPYqmfnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nNxQgu5CAhgwzJ0ZdGHNVBA3s4pF+xlp+gLUCABbhFR8YqsBSzS6wt15BDeqUlWyVc8IYmW22dVJ3siCWAOQEpKB8vO2nE/i8NnoLFYi9VVyf8eWjM4lx9SLunNEudvOZEoQF171M1CN/OwEsk7rB94nOaFZwOCEwW5Ba54ps/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PFo0d1up; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=a2cu08iV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PFo0d1up";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2cu08iV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768222501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rhxkLbdZYuCDIREBJ5aMnl1Pqa4kOCAZc2N2w1wi0pg=;
	b=PFo0d1upUW83+n7Dv77dKkBu/gq5gfntsjyfS20sCIoS4O5ME+5k/Pe1NBOtRAp73REcMz
	q9+wvLJiHCXgWL5OUdraStZ62dZoBf10vILcz5+XGdwcTbqMFQUDDpv3sydQUahJTFEGka
	rOQ8MwDygUUcOTxi3VZTcfH46p+uA/I=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-ItnARfSRNxyu7lsDuy7ueg-1; Mon, 12 Jan 2026 07:54:59 -0500
X-MC-Unique: ItnARfSRNxyu7lsDuy7ueg-1
X-Mimecast-MFC-AGG-ID: ItnARfSRNxyu7lsDuy7ueg_1768222498
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b871ea8299dso75154966b.0
        for <linux-s390@vger.kernel.org>; Mon, 12 Jan 2026 04:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768222498; x=1768827298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhxkLbdZYuCDIREBJ5aMnl1Pqa4kOCAZc2N2w1wi0pg=;
        b=a2cu08iVMFn/z5KVTdc33ddBRhM9nauUO+V8DwpNdFsMpxt232p6ZYmRWfPT/Q0oHG
         Qw3GHiPJBzHZ4iigWJ2KQXwzanAxlsSUj80xkJ90GIVVnsQby1B0hmjPWazr6l3+b+T8
         ctYH1c9NTrcIfrjNClPCGuvzE30AIretagA5yiIeaWCT/pGzdEinYjAGbjRWStU2KA2h
         P37z+/qGACCyilZ/Y1IUCewb9qSxh8mOUzkKKPxY9tO588Ks+HpFJOgv6MQ7IRrYzoCn
         RvCD659tiovByLPspnNOJctMGD8Z41RlRezMjtXYJ6qXkT77PPjXrnE/mzCofGem9xS9
         +/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768222498; x=1768827298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rhxkLbdZYuCDIREBJ5aMnl1Pqa4kOCAZc2N2w1wi0pg=;
        b=bfuwynxUkqM328TzGwUhkMKudI2G+IkvTH2sfz10Pq4Q9URNztGdM7tDudPJJesN5R
         JY4rXSkHzpf2wV/AfHcfXD7WcTX9s2j3OcIsMeppQYLnREDmoxZEpa4uUKm7Rr30U3BR
         vEVwY3FlHofTRtFAti0ruKVlEgrbd6HdtRTfJ4H5ntPJIgmOHH7R2KWMxbBkabblt98l
         Jq+oxS/Sz3y6LkVpdGUa0JR+ZRIQM+5AMC2p2didfuEsmtNQd/yihL6KysI7OWvr6Ahm
         QoVKxpxS5aKRZokIc1zTteorRy9cQoZNzB4k/izIpob/ZzDX9adQfCUtR9Bq6CeVTOpy
         PiiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJq2mO6GbPb7am59Pq/GeCwSdBdUlDGvKsft/dCXoNaZW+wenYDcWsOcCyhYve7T7LtADFp0hxwSQd@vger.kernel.org
X-Gm-Message-State: AOJu0YwwvgVHhtiNL7Xz/t3zNJoN6rEVDyJrh7e4905HNivdXtC8YkLc
	ajts3vt1huCCSJZyrH8BZYPfwbD+p48hwe3pB3n2HKGfD+Oyu9GjIPVcnURe6a1oGEe1Wkxm/fc
	t/svbfgSQR1LU/qNuZ1KS6qoXhKCXHNYf9qlBq8XjT05SF4ROs8WfndK/BXam2FQ=
X-Gm-Gg: AY/fxX5sh7tV6jlcE/QDd4BNm0N1tecOMuRghTso7cdkqTTfSPxA1hXR+XZN9Pd4Siu
	IeFcXRyJ1Ae+MI5nY4PP+qqnB8ImisBBw/1kK0KvugSPzR423PxFgO9CqNpkkdQYCuO0900utjJ
	Xk3eUYnjZaK4eKW+fVSFbM02xT1E2XiLVdx0E6fvQahBsIGb7ycLd/QWux0trI5KcOTUv4vGGGX
	umXaGTuqK5nZYgFBw2ya4Sy/jRe/MkJxnly7sYh6lFll8o6i4eYhL0YcQjSavKLubrfJpSeL+mS
	1wkQBuhR8DX6ON/mmMHmMz7o7t2G25sIjPi1efu26O+rIGA2PQiElbnLG0uCZrhYG2C4DZuxe5p
	aUtlf2H/USdKjmsJKu8oGimGpMrxISkUeaT8sMN3yD9oz070AiVyj2xo8aIE=
X-Received: by 2002:a17:907:26c7:b0:b73:a2ce:540f with SMTP id a640c23a62f3a-b8444c80f04mr1718742366b.17.1768222498439;
        Mon, 12 Jan 2026 04:54:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPr3dIgVWRsuP91OEnws2gf/Ukq1HmhAKZbz1wMFay2J0zyGKodjzzWjXpSeXa764C1KXgRg==
X-Received: by 2002:a17:907:26c7:b0:b73:a2ce:540f with SMTP id a640c23a62f3a-b8444c80f04mr1718740366b.17.1768222497991;
        Mon, 12 Jan 2026 04:54:57 -0800 (PST)
Received: from lbulwahn-thinkpadx1carbongen12.rmtde.csb ([2a02:810d:7e01:ef00:ff56:9b88:c93b:ed43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8706c2604bsm497062466b.16.2026.01.12.04.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 04:54:57 -0800 (PST)
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
Subject: [RFC PATCH 5/5] s390/configs: replace deprecated NF_LOG configs by NF_LOG_SYSLOG
Date: Mon, 12 Jan 2026 13:54:31 +0100
Message-ID: <20260112125432.61218-6-lukas.bulwahn@redhat.com>
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
tree, update the s390 kernel configurations to set NF_LOG_SYSLOG and drop
the deprecated config options.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 arch/s390/configs/debug_defconfig | 2 +-
 arch/s390/configs/defconfig       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index 4be3a7540909..93721ca340c1 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -176,6 +176,7 @@ CONFIG_NETFILTER=y
 CONFIG_BRIDGE_NETFILTER=m
 CONFIG_NETFILTER_NETLINK_HOOK=m
 CONFIG_NF_CONNTRACK=m
+CONFIG_NF_LOG_SYSLOG=m
 CONFIG_NF_CONNTRACK_SECMARK=y
 CONFIG_NF_CONNTRACK_ZONES=y
 CONFIG_NF_CONNTRACK_PROCFS=y
@@ -327,7 +328,6 @@ CONFIG_IP_VS_FTP=m
 CONFIG_IP_VS_PE_SIP=m
 CONFIG_NFT_FIB_IPV4=m
 CONFIG_NF_TABLES_ARP=y
-CONFIG_NF_LOG_IPV4=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_AH=m
 CONFIG_IP_NF_MATCH_ECN=m
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index c064e0cacc98..7750f333a1ac 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -167,6 +167,7 @@ CONFIG_NETFILTER=y
 CONFIG_BRIDGE_NETFILTER=m
 CONFIG_NETFILTER_NETLINK_HOOK=m
 CONFIG_NF_CONNTRACK=m
+CONFIG_NF_LOG_SYSLOG=m
 CONFIG_NF_CONNTRACK_SECMARK=y
 CONFIG_NF_CONNTRACK_ZONES=y
 CONFIG_NF_CONNTRACK_PROCFS=y
@@ -318,7 +319,6 @@ CONFIG_IP_VS_FTP=m
 CONFIG_IP_VS_PE_SIP=m
 CONFIG_NFT_FIB_IPV4=m
 CONFIG_NF_TABLES_ARP=y
-CONFIG_NF_LOG_IPV4=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_AH=m
 CONFIG_IP_NF_MATCH_ECN=m
-- 
2.52.0

