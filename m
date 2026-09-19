Received: from mail-lr2-f14.google.com (mail-lr2-f14.google.com [74.125.230.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFAF339395
	for <linux-s390@vger.kernel.org>; Sat, 19 Sep 2026 13:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789825434; cv=none; b=fFlw35aM7Sz9LoOmg+75B7WjGZgkTL5uvllXnsdNCNZt+Rjc9pgQIyEgmJNAxFUFE5P8ZqdSHDQbp6pc/QR1k7Vv8msH15+faRKrMZ517WHJkdZ6iUcsAHVwMDi1xgh++cWm8GnilwsDjS7NEwnUvIOFMbyQ6d9NoCzX/hPbKWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789825434; c=relaxed/simple;
	bh=Neh/FDQ2RY8OrFxtlIC/w3H0LG+CLOhi6pdfv56r7oE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uIkPUaD3RS/XPcEpWt0/BslGNnqze71wpvGcVX7MnuD2fzvuHuWCpqyE3INCpLw2gMOR+S4CcwyO/XduNkOvTJoMGdXmRl2dZOQAehMNFMKju7L/zLXyL5/cnNZiisz9b990nLeAv9/yO/olS1bX7WDiaU5VT60fZaDbVwzKloA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxwaexRx; arc=none smtp.client-ip=74.125.230.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxwaexRx"
Received: by mail-lr2-f14.google.com with SMTP id 38308e7fff4ca-3a5b2864f1cso14872581fa.3
        for <linux-s390@vger.kernel.org>; Sat, 19 Sep 2026 06:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789825429; x=1790430229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fQI3S0LyGyRRUcXsOa75Z3ymY28haXHCQF4fW8+TIHQ=;
        b=IxwaexRxk8nhueOqezCpnlkFN5pe0wJz1jaquqqS7BdSxR12jxwht0Ebaf48DpL38w
         hNhAcqgg9ym5TTVu5T7HktTx0QHTqkMWeGDTZUmnPYHQH7MhOL4n2n0JvqXklU9nj195
         4LI9pv79kZRC7lxoCYtmoW0ibMX3lp8QUFQ3/5RZCQIkdGtT4gVqVm6GYUV3DGGYIL4f
         8EHOkePMFl0qXLzlG5Ws3muK3LxRMyphitpd8Tz+J+c5FhrFfCA0kaIGpZ/UokMgSs1Z
         D6aDyEIBUMEgdllrjtN/QrJWI+0LkUQjiYJWQRBYODyGrJ4K9Vb8j5o32EZ3f7uEkQKP
         9V4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789825429; x=1790430229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fQI3S0LyGyRRUcXsOa75Z3ymY28haXHCQF4fW8+TIHQ=;
        b=xYMX9CTkIWNaRqPzU5++69zQiHKZMYqmdKeTaBly469faIBEkuNIfvUV7iEpBUM1Cs
         6dFDga/gj4mMeLkoyZ6/sE2/DjxDsu/nUW91BplwjDhKdceqCz1Rm4GV4QDxIrcLISaf
         JkoxuGJQ23Dc+QhzCRGqGdGeV303aW/WwaHKAEX/IehhVza96imr4qonNxytVuA74Kfi
         6MC09+L90MXg+B+t71K4x8kJwll2XHWD3/8n4/xFgVpz0qGP5bOq0m2N9cHftaiz6a/K
         FWPi2t1wZ+NNT4iqi+nZ29cprq+3afvTJLOdYfFTpn8G4QQQqK4RApeg5Uq2JM8EjpFA
         pMCA==
X-Forwarded-Encrypted: i=1; AKwUvBzQKGASeHdm9fouHSPaXLHiK0d4Fib0NGbFcW8D4RBMk3jPF13oECGBzHlZ0Bg1b5pn+6y1ncUhF39E@vger.kernel.org
X-Gm-Message-State: AFuF++kVkBcXOFvqqJo6PkxmaWqgN+hijjUJSb+W5+Nq9k2tMNEwPgNU
	JG4diGwPYJ4qpVWuiWh2YBB4fFO8DSJmMzOcS0890d1+iqGZMWR0vhpx
X-Gm-Gg: AYBFou006zo3iWe9cFIUtPkxb4WDwFt9Msx73/pmmT4UH9km/c4xgqH2i+sRA6reiMr
	6+RZFoytZSF5DNoopHix+Nq9PzKS95o8Zr84MFtf9PlLUAl9ufodTdfMtfGyN/6s5NLKSo+OKE2
	SfbnP5bA1d7Uqakg8Gxy4P2iTrBUq4ehSLZecGt20OSC8JV8IX3FuU3t454Jwtc5oBqIadVYM27
	Z4vQmU1LHbEVulbwHkjz6UKA9KkJh3/HtEILhR7fL04Iz3JcypviqMuAkw40iQ46z3Get8jIy1T
	tzkmB0qIy/4rHdtxUhu6tjEKlCimIAk26dV3ugtKjowb+rw5wB2Oznndwn2N1iVAy6Y4GRAT6Nu
	FudBdCOUH2hfVMDpR8knFyzb3LxoWBH9QTXF4wsbpP87xa+LpEJXPxERwyOC1p/rYYG3yH/QM67
	77HWS++ufRpU1qrN6lfWVyyRhpFpLfZVe1MSeI5gRvjd/5AqzsC9fqUOOFgcV86u2LdmZOIdyBU
	rqjeMx5tRkKWRK2eIcHWJusCqqWDAAWsBJBBiZv8v1SLWhzVDYLvkpux3EKZ4qXj1kaY3EOQJHm
	KsQ=
X-Received: by 2002:a05:651c:509:b0:3a3:7682:49a0 with SMTP id 38308e7fff4ca-3a5fc0a87b3mr11118821fa.21.1789825429162;
        Sat, 19 Sep 2026 06:43:49 -0700 (PDT)
Received: from localhost.localdomain (46-138-187-224.dynamic.spd-mgts.ru. [46.138.187.224])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a60767aa6asm6220941fa.40.2026.09.19.06.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 06:43:48 -0700 (PDT)
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
Subject: [PATCH net-next v3 1/2] rtnetlink: pass extack to ndo_bridge_getlink()
Date: Sat, 19 Sep 2026 16:43:32 +0300
Message-ID: <20260919134333.49379-2-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260919134333.49379-1-iprintercanon@gmail.com>
References: <20260919134333.49379-1-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So the bridge can say why filling the link info failed.
No functional change.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c      |  4 ++--
 drivers/net/ethernet/emulex/benet/be_main.c    |  4 ++--
 drivers/net/ethernet/intel/i40e/i40e_main.c    |  6 ++++--
 drivers/net/ethernet/intel/ice/ice_main.c      |  6 ++++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |  5 +++--
 .../net/ethernet/mellanox/mlx5/core/en_main.c  |  4 ++--
 .../ethernet/netronome/nfp/nfp_net_common.c    |  4 ++--
 drivers/s390/net/qeth_l2_main.c                |  4 ++--
 include/linux/netdevice.h                      |  5 +++--
 include/linux/rtnetlink.h                      |  3 ++-
 net/bridge/br_netlink.c                        |  3 ++-
 net/bridge/br_private.h                        |  2 +-
 net/core/rtnetlink.c                           | 18 +++++++++++-------
 13 files changed, 40 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index ca99f4b1a63c3..a752e66bf6368 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -16154,12 +16154,12 @@ static const struct udp_tunnel_nic_info bnxt_udp_tunnels = {
 
 static int bnxt_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 			       struct net_device *dev, u32 filter_mask,
-			       int nlflags)
+			       int nlflags, struct netlink_ext_ack *extack)
 {
 	struct bnxt *bp = netdev_priv(dev);
 
 	return ndo_dflt_bridge_getlink(skb, pid, seq, dev, bp->br_mode, 0, 0,
-				       nlflags, filter_mask, NULL);
+				       nlflags, filter_mask, NULL, extack);
 }
 
 static int bnxt_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index ed302f5ec4768..cc9c87539a429 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -5011,7 +5011,7 @@ static int be_ndo_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
 
 static int be_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 				 struct net_device *dev, u32 filter_mask,
-				 int nlflags)
+				 int nlflags, struct netlink_ext_ack *extack)
 {
 	struct be_adapter *adapter = netdev_priv(dev);
 	int status = 0;
@@ -5037,7 +5037,7 @@ static int be_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 	return ndo_dflt_bridge_getlink(skb, pid, seq, dev,
 				       hsw_mode == PORT_FWD_TYPE_VEPA ?
 				       BRIDGE_MODE_VEPA : BRIDGE_MODE_VEB,
-				       0, 0, nlflags, filter_mask, NULL);
+				       0, 0, nlflags, filter_mask, NULL, extack);
 }
 
 static struct be_cmd_work *be_alloc_work(struct be_adapter *adapter,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index abbc71e815ae3..52c2b393aacd2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -13151,6 +13151,7 @@ static int i40e_ndo_bridge_setlink(struct net_device *dev,
  * @dev: the netdev being configured
  * @filter_mask: unused
  * @nlflags: netlink flags passed in
+ * @extack: netlink extended ack
  *
  * Return the mode in which the hardware bridge is operating in
  * i.e VEB or VEPA.
@@ -13158,7 +13159,8 @@ static int i40e_ndo_bridge_setlink(struct net_device *dev,
 static int i40e_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 				   struct net_device *dev,
 				   u32 __always_unused filter_mask,
-				   int nlflags)
+				   int nlflags,
+				   struct netlink_ext_ack *extack)
 {
 	struct i40e_netdev_priv *np = netdev_priv(dev);
 	struct i40e_vsi *vsi = np->vsi;
@@ -13175,7 +13177,7 @@ static int i40e_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 		return 0;
 
 	return ndo_dflt_bridge_getlink(skb, pid, seq, dev, veb->bridge_mode,
-				       0, 0, nlflags, filter_mask, NULL);
+				       0, 0, nlflags, filter_mask, NULL, extack);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 707c7431b91a6..f98295438df78 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -8095,12 +8095,14 @@ int ice_set_rss_hfunc(struct ice_vsi *vsi, u8 hfunc)
  * @dev: the netdev being configured
  * @filter_mask: filter mask passed in
  * @nlflags: netlink flags passed in
+ * @extack: netlink extended ack
  *
  * Return the bridge mode (VEB/VEPA)
  */
 static int
 ice_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
-		   struct net_device *dev, u32 filter_mask, int nlflags)
+		   struct net_device *dev, u32 filter_mask, int nlflags,
+		   struct netlink_ext_ack *extack)
 {
 	struct ice_pf *pf = ice_netdev_to_pf(dev);
 	u16 bmode;
@@ -8108,7 +8110,7 @@ ice_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 	bmode = pf->first_sw->bridge_mode;
 
 	return ndo_dflt_bridge_getlink(skb, pid, seq, dev, bmode, 0, 0, nlflags,
-				       filter_mask, NULL);
+				       filter_mask, NULL, extack);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index f91856498eb2d..77dfd80a6e368 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -10726,7 +10726,8 @@ static int ixgbe_ndo_bridge_setlink(struct net_device *dev,
 
 static int ixgbe_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 				    struct net_device *dev,
-				    u32 filter_mask, int nlflags)
+				    u32 filter_mask, int nlflags,
+				    struct netlink_ext_ack *extack)
 {
 	struct ixgbe_adapter *adapter = ixgbe_from_netdev(dev);
 
@@ -10735,7 +10736,7 @@ static int ixgbe_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 
 	return ndo_dflt_bridge_getlink(skb, pid, seq, dev,
 				       adapter->bridge_mode, 0, 0, nlflags,
-				       filter_mask, NULL);
+				       filter_mask, NULL, extack);
 }
 
 static void *ixgbe_fwd_add(struct net_device *pdev, struct net_device *vdev)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index fc110a7d16e8d..53bf79dbe08de 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5277,7 +5277,7 @@ static int mlx5e_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 #ifdef CONFIG_MLX5_ESWITCH
 static int mlx5e_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 				struct net_device *dev, u32 filter_mask,
-				int nlflags)
+				int nlflags, struct netlink_ext_ack *extack)
 {
 	struct mlx5e_priv *priv = netdev_priv(dev);
 	struct mlx5_core_dev *mdev = priv->mdev;
@@ -5288,7 +5288,7 @@ static int mlx5e_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 	mode = setting ? BRIDGE_MODE_VEPA : BRIDGE_MODE_VEB;
 	return ndo_dflt_bridge_getlink(skb, pid, seq, dev,
 				       mode,
-				       0, 0, nlflags, filter_mask, NULL);
+				       0, 0, nlflags, filter_mask, NULL, extack);
 }
 
 static int mlx5e_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index 7928e76da723e..cb751dddb6887 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -2257,7 +2257,7 @@ static int nfp_net_set_mac_address(struct net_device *netdev, void *addr)
 
 static int nfp_net_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 				  struct net_device *dev, u32 filter_mask,
-				  int nlflags)
+				  int nlflags, struct netlink_ext_ack *extack)
 {
 	struct nfp_net *nn = netdev_priv(dev);
 	u16 mode;
@@ -2269,7 +2269,7 @@ static int nfp_net_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 	       BRIDGE_MODE_VEPA : BRIDGE_MODE_VEB;
 
 	return ndo_dflt_bridge_getlink(skb, pid, seq, dev, mode, 0, 0,
-				       nlflags, filter_mask, NULL);
+				       nlflags, filter_mask, NULL, extack);
 }
 
 static int nfp_net_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 2935c2ecc314b..f960cf5a97a29 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -935,7 +935,7 @@ static void qeth_l2_br2dev_put(void)
 
 static int qeth_l2_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 				  struct net_device *dev, u32 filter_mask,
-				  int nlflags)
+				  int nlflags, struct netlink_ext_ack *extack)
 {
 	struct qeth_priv *priv = netdev_priv(dev);
 	struct qeth_card *card = dev->ml_priv;
@@ -949,7 +949,7 @@ static int qeth_l2_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 	return ndo_dflt_bridge_getlink(skb, pid, seq, dev,
 				       mode, priv->brport_features,
 				       priv->brport_hw_features,
-				       nlflags, filter_mask, NULL);
+				       nlflags, filter_mask, NULL, extack);
 }
 
 static const struct nla_policy qeth_brport_policy[IFLA_BRPORT_MAX + 1] = {
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 1f0710eef185b..02238b1e33453 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1360,7 +1360,7 @@ struct netdev_net_notifier {
  *			     u16 flags, struct netlink_ext_ack *extack)
  * int (*ndo_bridge_getlink)(struct sk_buff *skb, u32 pid, u32 seq,
  *			     struct net_device *dev, u32 filter_mask,
- *			     int nlflags)
+ *			     int nlflags, struct netlink_ext_ack *extack)
  * int (*ndo_bridge_dellink)(struct net_device *dev, struct nlmsghdr *nlh,
  *			     u16 flags);
  *
@@ -1659,7 +1659,8 @@ struct net_device_ops {
 						      u32 pid, u32 seq,
 						      struct net_device *dev,
 						      u32 filter_mask,
-						      int nlflags);
+						      int nlflags,
+						      struct netlink_ext_ack *extack);
 	int			(*ndo_bridge_dellink)(struct net_device *dev,
 						      struct nlmsghdr *nlh,
 						      u16 flags);
diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index 95729339e7a54..a408c36a7b558 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -222,7 +222,8 @@ extern int ndo_dflt_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 				   u32 filter_mask,
 				   int (*vlan_fill)(struct sk_buff *skb,
 						    struct net_device *dev,
-						    u32 filter_mask));
+						    u32 filter_mask),
+				   struct netlink_ext_ack *extack);
 
 extern void rtnl_offload_xstats_notify(struct net_device *dev);
 
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index ae76df0de05a0..855a46aec3a89 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -680,7 +680,8 @@ void br_ifinfo_notify(int event, const struct net_bridge *br,
  * Dump information about all ports, in response to GETLINK
  */
 int br_getlink(struct sk_buff *skb, u32 pid, u32 seq,
-	       struct net_device *dev, u32 filter_mask, int nlflags)
+	       struct net_device *dev, u32 filter_mask, int nlflags,
+	       struct netlink_ext_ack *extack)
 {
 	struct net_bridge_port *port = br_port_get_rtnl(dev);
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 09c397e303307..edbe7a1f57363 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -2179,7 +2179,7 @@ int br_setlink(struct net_device *dev, struct nlmsghdr *nlmsg, u16 flags,
 	       struct netlink_ext_ack *extack);
 int br_dellink(struct net_device *dev, struct nlmsghdr *nlmsg, u16 flags);
 int br_getlink(struct sk_buff *skb, u32 pid, u32 seq, struct net_device *dev,
-	       u32 filter_mask, int nlflags);
+	       u32 filter_mask, int nlflags, struct netlink_ext_ack *extack);
 int br_process_vlan_info(struct net_bridge *br,
 			 struct net_bridge_port *p, int cmd,
 			 struct bridge_vlan_info *vinfo_curr,
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index e3444fd240615..a341e06f47d31 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -5420,7 +5420,8 @@ int ndo_dflt_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 			    u32 filter_mask,
 			    int (*vlan_fill)(struct sk_buff *skb,
 					     struct net_device *dev,
-					     u32 filter_mask))
+					     u32 filter_mask),
+			    struct netlink_ext_ack *extack)
 {
 	struct nlmsghdr *nlh;
 	struct ifinfomsg *ifm;
@@ -5596,7 +5597,8 @@ static int rtnl_bridge_getlink(struct sk_buff *skb, struct netlink_callback *cb)
 			if (idx >= cb->args[0]) {
 				err = br_dev->netdev_ops->ndo_bridge_getlink(
 						skb, portid, seq, dev,
-						filter_mask, NLM_F_MULTI);
+						filter_mask, NLM_F_MULTI,
+						cb->extack);
 				if (err < 0 && err != -EOPNOTSUPP) {
 					if (likely(skb->len))
 						break;
@@ -5612,7 +5614,8 @@ static int rtnl_bridge_getlink(struct sk_buff *skb, struct netlink_callback *cb)
 				err = ops->ndo_bridge_getlink(skb, portid,
 							      seq, dev,
 							      filter_mask,
-							      NLM_F_MULTI);
+							      NLM_F_MULTI,
+							      cb->extack);
 				if (err < 0 && err != -EOPNOTSUPP) {
 					if (likely(skb->len))
 						break;
@@ -5646,7 +5649,8 @@ static inline size_t bridge_nlmsg_size(void)
 		+ nla_total_size(sizeof(u16));	/* IFLA_BRIDGE_MODE */
 }
 
-static int rtnl_bridge_notify(struct net_device *dev)
+static int rtnl_bridge_notify(struct net_device *dev,
+			      struct netlink_ext_ack *extack)
 {
 	struct net *net = dev_net(dev);
 	struct sk_buff *skb;
@@ -5661,7 +5665,7 @@ static int rtnl_bridge_notify(struct net_device *dev)
 		goto errout;
 	}
 
-	err = dev->netdev_ops->ndo_bridge_getlink(skb, 0, 0, dev, 0, 0);
+	err = dev->netdev_ops->ndo_bridge_getlink(skb, 0, 0, dev, 0, 0, extack);
 	if (err < 0)
 		goto errout;
 
@@ -5752,7 +5756,7 @@ static int rtnl_bridge_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			/* Generate event to notify upper layer of bridge
 			 * change
 			 */
-			err = rtnl_bridge_notify(dev);
+			err = rtnl_bridge_notify(dev, extack);
 		}
 	}
 
@@ -5827,7 +5831,7 @@ static int rtnl_bridge_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			/* Generate event to notify upper layer of bridge
 			 * change
 			 */
-			err = rtnl_bridge_notify(dev);
+			err = rtnl_bridge_notify(dev, extack);
 		}
 	}
 
-- 
2.43.0

