Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F88C32ED40
	for <linux-s390@vger.kernel.org>; Sat, 12 Sep 2026 13:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789221041; cv=none; b=VDeEaLRC4OKrfKD56bxp+aV926e/2F9c4BFpUmXr0hDHbZcMn6BxtTvIMvPpSJv5Uf2reTRT0XagTs6AGBad4Ff3v10pdiQ/Qt7yOn/QPDETMiQt9Muy0BiG+BmVmMWe03kRdNoUBFknJfgz4a3O1NoovZk1sk3pZWovf2PypXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789221041; c=relaxed/simple;
	bh=9JjWJlQanOFgNu6EDHV88ITYLaK2cjjVq8yIXb93bls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jJFuf040GLWwANLvXROHA56127RLtgbTJKalcywOwT74nwseL8wOeoInapiyFSVkGXtnnB7MQef1+wCV1H84yvpwkld/jwrq3WHuvNIP5s0Ij6MulyErv5EgjbmlbDXxENi8HzOXuj/RGfpZxEihPmflomX1rEHjMV6o2gbKGM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIxZtyPP; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIxZtyPP"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f13d7aso559014e87.1
        for <linux-s390@vger.kernel.org>; Sat, 12 Sep 2026 06:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789221037; x=1789825837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PkBUg+m8HfIyEOkPoB1jZJ5opS1mW8Hh1Xx4YggldGE=;
        b=jIxZtyPPEr65upOAkpKscDsfcBWsGEzWsLYT6lpdZ65o2Gz3ppCtADdhhrFn0zmcLH
         etydSLUfMrpIJjIxHYaOAnacEfnFlXPNV390x3rYHw58XUbV8SLTkwMO4ooEmNS0oYOd
         HOYqq4AuZCNi3NSNZY5mJQozMU6Oh+HQL8DY/L0vsDM+F+D6YV5n3Fy0rzOvv3EiHTMo
         NdZdG9udkfp0tUIxVzPWxfVh625oaqpiJdBLTMzOd01WRFZzmY7t4errwg5NbjBiatJM
         eepk2shSZCVVFd1qTuUf4iDvijBFc0lKBD+ueehWdRURjFbJzqL4fLu4NNdJCF8xLPJR
         Mf2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789221037; x=1789825837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PkBUg+m8HfIyEOkPoB1jZJ5opS1mW8Hh1Xx4YggldGE=;
        b=cKC7HnqaVvE2LL6LkARhjs4BTV41WNOeVYdvfaLX4ga/cn6Cm6JXHNFCORtkDcje0O
         Yd5/2VaaLs8TYPT7yCeegTV2EGR+O0hLxbifMwPfy5uSw6+gcBYHjM2IwmVb7IUheGYM
         ncRocwhXTYFsKgn5Qa8iKmQI9K4pY+qzU6/NYBiyEkYXmZPzTIEktngKfQRWaxiM3nSb
         59dfOgW/bNSAwsB4RJXyBOWSzfM89kbrf6aHdoSLJEnmqNDar7kY9pFrDOUmgMpeN68+
         w/e0YAq3lMEroUNKiRhC/mk6sNGNcUBTUk18qW50ZL2FLh2CFVdgPXsyrV2CBnCbb0WW
         evKg==
X-Forwarded-Encrypted: i=1; AKwUvBybUVqkg4MKcR+9BD+twTr4gK4r3iXy0qeFNkVvWTerOZa2nFSNPXGnVlgiRzNKwGv/RQKFlUE/9Dfg@vger.kernel.org
X-Gm-Message-State: AFuF++lrI1N/ks4VoTv0NRgRMl8QcYFbAFEqvph/TPBkqAR1yv0JU3kR
	PPi4GVCzmdG3EfWM1bsHbr4Wj/dHXvxEOahdBfilcbCDD/rNNSg1qrKz
X-Gm-Gg: AYBFou0QrPx9FNTZtJfs6Yte8s9K1mUN32VgzbjEazVV0lfIiqsjH3ln8WGhO/6b02b
	sXBjdm9YSSfApwf/AtTOfw1ENOUJATWabzkQG0Hb/3YWw73bbVcJ5Cg5M02rX0r8EFLhr0OovAV
	/TxH+0tHCm0/BMw8QcpI0hhQRC4gNINDYfV6lkc8UJy5a5/kva+1NsfLNFkhnOdQI/r9VJV6Vui
	uLpqhXH5wfJNuRmHYiGxm37Nm9h5Z/BrBDVCRrjmJVLGnJAMVTW86yMv1d56TR/v4H622dvbo8T
	lgR4XfRkvx52ktNQI8gvfMD/DV0Lw2sWoqXTz+N82goGHbDGx6zaw343k/bVy6/POSjQWbL3x17
	ljQ3yxU+KWKZ89i+TC6cVdDXE/rj4HdGTSf1JDh+DGyqGcc//AjU91Marnm1y8pumzfKm+P2RyG
	L+DEdzIBgH63ouu63/BxAdsVhnae1OQWZ+kDBpEeYetRDmqw/rLUs2vePKyK72OxFhZhVf7Vt9/
	w43jL49TToq6Q4glo2n/Nfs2iHfURpLxHfRc/GVMA7ISIAYgwCj/tFFIrVTd/+LiPeq
X-Received: by 2002:a05:6512:1594:b0:5b0:eda:de1c with SMTP id 2adb3069b0e04-5b8a8ea0818mr465882e87.5.1789221037446;
        Sat, 12 Sep 2026 06:50:37 -0700 (PDT)
Received: from localhost.localdomain (46-138-187-224.dynamic.spd-mgts.ru. [46.138.187.224])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8a0457246sm1257770e87.23.2026.09.12.06.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 06:50:37 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/2] net: bridge: fail link info that does not fit the IFLA_AF_SPEC nest
Date: Sat, 12 Sep 2026 16:50:22 +0300
Message-ID: <20260912135022.1701-3-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260912135022.1701-1-iprintercanon@gmail.com>
References: <20260912135022.1701-1-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

br_fill_ifinfo() puts all of a port's VLAN, tunnel and MST entries into
one nest, and nla_len is a u16, so a large enough port produces a nest
whose length wraps and userspace reads garbage.

Cancel the message and return -E2BIG with an extack pointing at
RTM_GETVLAN instead. The dump retries the port with an empty skb and
the error goes to userspace; notifications reach rtnl_set_sk_err() and
listeners resync. Not -EMSGSIZE, since no bigger buffer would help.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
---
 net/bridge/br_netlink.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 855a46aec3a89..53676df9e4d11 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -459,7 +459,7 @@ static int br_fill_ifinfo(struct sk_buff *skb,
 			  const struct net_bridge_port *port,
 			  u32 pid, u32 seq, int event, unsigned int flags,
 			  u32 filter_mask, const struct net_device *dev,
-			  bool getlink)
+			  bool getlink, struct netlink_ext_ack *extack)
 {
 	u8 operstate = netif_running(dev) ? READ_ONCE(dev->operstate) :
 					    IF_OPER_DOWN;
@@ -613,6 +613,12 @@ static int br_fill_ifinfo(struct sk_buff *skb,
 
 done:
 	if (af) {
+		if (skb_tail_pointer(skb) - (unsigned char *)af > U16_MAX) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "VLAN information does not fit in one message, use RTM_GETVLAN");
+			nlmsg_cancel(skb, nlh);
+			return -E2BIG;
+		}
 		if (nlmsg_get_pos(skb) - (void *)af > nla_attr_size(0))
 			nla_nest_end(skb, af);
 		else
@@ -654,7 +660,8 @@ void br_info_notify(int event, const struct net_bridge *br,
 	if (skb == NULL)
 		goto errout;
 
-	err = br_fill_ifinfo(skb, port, 0, 0, event, 0, filter, dev, false);
+	err = br_fill_ifinfo(skb, port, 0, 0, event, 0, filter, dev, false,
+			     NULL);
 	if (err < 0) {
 		/* -EMSGSIZE implies BUG in br_nlmsg_size() */
 		WARN_ON(err == -EMSGSIZE);
@@ -693,7 +700,7 @@ int br_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 		return 0;
 
 	return br_fill_ifinfo(skb, port, pid, seq, RTM_NEWLINK, nlflags,
-			      filter_mask, dev, true);
+			      filter_mask, dev, true, extack);
 }
 
 static int br_vlan_info(struct net_bridge *br, struct net_bridge_port *p,
-- 
2.43.0

