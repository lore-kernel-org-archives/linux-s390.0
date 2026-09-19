Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FEA25B08D
	for <linux-s390@vger.kernel.org>; Sat, 19 Sep 2026 13:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789825432; cv=none; b=p4VwBlmByRXKsM60bmE9lPv9UmrWOgPQSmgZSmDtkEU2VLchFtjTsfKNleaaNbGg/53nEJ0RTnybqzPx6FQJi5IBeMIMQ70nfnnXOHrWQRtCgj5pwLmjakWCmZqlcawJH8LstziQq0I4R1JXtE2mpBFb4KJ/gZw1ujAwP8VoJyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789825432; c=relaxed/simple;
	bh=dFZ63T3zvOowaEIbbYHyNeo31i69lA6u+JkTJ9+rQeY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iVK9VspwSvfQxuMCoo9MzK6JYN/3+l2Us0ISLXAN1z8b+sDDhM3NBhYFR0rpCcEUTM/DZ+ZANwgJSsMsDADkLeQgOKHYlneVdPhdyNHSuCi6RE7d7VMKnyq8VYW+LSBC2LEmw7U6WXC0K3/lhr0da8/MdZBRK4qSN5F35F1pcp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/zngkOn; arc=none smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/zngkOn"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a36de66c0dso16055001fa.0
        for <linux-s390@vger.kernel.org>; Sat, 19 Sep 2026 06:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789825428; x=1790430228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HuHF/oDZVPSpibhsK+iPHeV9FkZXWA2uFO4o60iu8z0=;
        b=H/zngkOncThpID1/pMXMVInlk7OkTPlKuJk5fdWven3hX8/TIEcozwB2K1Dz8XNdRj
         pq6ysDnx+Cz5VmuoIm0q891L2OhMcX9l+wGIHAeIgrE+ho4F1TPWM0XmpwBu1n+BgLIa
         LlrLHexOZyXo0r8tIujIGvQkwVz738I25ovWMZc+ZTFYQs8DUWjWYnZ+5HReb3nfD8Fz
         FdNLFUybxbouKAPqslPUrY42xdKgp++U2y//2UN45u83YmK0yRYcpKgINF7nY1LHiYz+
         MDS7gvJtxYtE5X+jlrHOk4byiTTWdklQf6QUJPgGkSIuUU+Zq4CJ7YOQFEu7ldqwajdK
         b9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789825428; x=1790430228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HuHF/oDZVPSpibhsK+iPHeV9FkZXWA2uFO4o60iu8z0=;
        b=WEfoVDhD0U9DSrxy9h7JhMqrvxYlKOdAklT1FUnUqQaNezki0cLQQwpCMZA0AyHZg8
         l8WZ/1DorqamDaqlMjPZQ+0ucNNRMtljO1lGcOINDZmYtNOx7Tu2X9PCV6lRgZfRIRb3
         J5LKYmqLwRq06yxxVwFXyoL26uXM1sTWVgSRocQ/hNz6IU3JxyetdiaGYgSXnlIC3vC8
         dL8U7Lj9HmZWgE7BqBtG1709KH5TQAlt9h6XLWvVFDyl74/twJ5VHxnPByWn+/h3vuKJ
         A9RXGiQ3Ouate/8AetGoCA6Es5mzJlLUNy5lo559BDacZsbLuFbYbzt0iNWwY/qTbEua
         zSKA==
X-Forwarded-Encrypted: i=1; AKwUvBzAnV9Kav5/7lFqwGrpCriQi4wm//n9+iytYKbehe2Alq6rCTrDerxdSASdXyc0Uj10ocu7QtEUXQIw@vger.kernel.org
X-Gm-Message-State: AFuF++k3TYP/hBgfl3tiCqeh5dSsTJOlo/7pB/Ybg3PLs8YjBs76swDT
	bRlrJnO2zWiLHPogWZIMA2iNP4IALbx2covnUEnw2HAJC/FL8OZ8Qvbm
X-Gm-Gg: AYBFou3RSg4+iAj5Z8RVWQIEl3ovG+q1z8p6Bj77GyDSbdTeLp5RbBqwNyG/INQC95/
	4PC+kVnUkiM1SQKSH3fiWAk7MoRtXJXmZWptdkQD5c5WIRKSFywgOdt00a0IM8m1tgJ94G5hnuO
	H9bUjIi4Fawa81PloAnFsvySsAFtMN4kZMK7EhWLA9/XeJ+McP+aRLsPZ9LrsCZJPINI9BimtPk
	qROu0mdJ0lCw/kF5FI6a9/9OXTzpz89kHp4EvZzaWKIpfVYQJxT3D3iR4Hjt/Td7h6cF2MixrcE
	JgAcpo53rcbTs40q3cDpqx7dmLny3QTXRddPhYxRPCjpi92QGy9v9wIYjvU0SoeK2pBGYilOKGV
	YvRCmyKpLHxn9o3nvLMIvOe2k3+iSWFxccH0z0WmquxiD6QkZapnc0jxfqSWqUhPhaXYkCzJ9oN
	AhMMvsGWFxEsY5nBPrp3pNZCrsRIYS+uUU0FEtbX37zDzCwwvr1I87+y8HyeHmhXISXPiZIOWhy
	zfVTbnNG5oVjdzo3jB5l5ZGcTh8uJx9ftcgQljXzRTbjOCr23Mj4PycNzpw6pvNKmB+
X-Received: by 2002:a05:651c:2213:b0:3a3:314d:1169 with SMTP id 38308e7fff4ca-3a5fbf05908mr10726771fa.1.1789825427681;
        Sat, 19 Sep 2026 06:43:47 -0700 (PDT)
Received: from localhost.localdomain (46-138-187-224.dynamic.spd-mgts.ru. [46.138.187.224])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a60767aa6asm6220941fa.40.2026.09.19.06.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 06:43:47 -0700 (PDT)
From: Artem Lytkin <iprintercanon@gmail.com>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux.dev,
	razor@blackwall.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	kuniyu@google.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	ajit.khaparde@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	oss-drivers@corigine.com,
	wintera@linux.ibm.com,
	aswin@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH net-next v3 0/2] bridge: report an oversized IFLA_AF_SPEC nest instead of truncating
Date: Sat, 19 Sep 2026 16:43:31 +0300
Message-ID: <20260919134333.49379-1-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 adds extack to ndo_bridge_getlink(), patch 2 returns -E2BIG
when the AF_SPEC nest, or the MST/CFM nest inside it, overflows nla_len.

v3: handle the MST and CFM nests too, use nla_nest_end_safe() (Nikolay)
v2: https://lore.kernel.org/netdev/20260912135022.1701-1-iprintercanon@gmail.com/
v1: https://lore.kernel.org/netdev/20260906224246.21719-1-iprintercanon@gmail.com/


Artem Lytkin (2):
  rtnetlink: pass extack to ndo_bridge_getlink()
  net: bridge: fail link info that does not fit in a netlink attribute

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  4 +--
 drivers/net/ethernet/emulex/benet/be_main.c   |  4 +--
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  6 ++--
 drivers/net/ethernet/intel/ice/ice_main.c     |  6 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  5 ++--
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  4 +--
 .../ethernet/netronome/nfp/nfp_net_common.c   |  4 +--
 drivers/s390/net/qeth_l2_main.c               |  4 +--
 include/linux/netdevice.h                     |  5 ++--
 include/linux/rtnetlink.h                     |  3 +-
 net/bridge/br_netlink.c                       | 28 +++++++++++++------
 net/bridge/br_private.h                       |  2 +-
 net/core/rtnetlink.c                          | 18 +++++++-----
 13 files changed, 57 insertions(+), 36 deletions(-)


base-commit: e3bfd25626b44b6fa61a13c17178922171d519ce
-- 
2.43.0

