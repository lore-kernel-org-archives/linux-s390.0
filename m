Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18DC32B9B5
	for <linux-s390@vger.kernel.org>; Sat, 12 Sep 2026 13:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789221041; cv=none; b=LBVFxOZT7FRphbXNApAehUCs5zFeYhsscEtiManEgzHHDzL3EBz5aFfWSOOUXqfcu4wMzqTx7JbukGaB7gPrf3XAEGvpklUEBuj68ZA8dBl1MK0dzJX3kwIQNpFMNStn4JFOcbipHLB0RezK0lYOHEXGasz/t/rzksREal1ewmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789221041; c=relaxed/simple;
	bh=CHkZQNCMDbg1G0Fesqtyswf27HYf5X6YFZ3fNkH0jIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVwtAJyFVqh41lFZcV+3DX3q9nDLbeA1BzBnGXUtqXa3xp7AXDe4uZfDM+ZzKksQsZYwRXxn15MwyxJk1t4K0mfzlwMBq63gzIh2Yg8TrAqhKdAcfMELShV3EMfpkHmqDLysSJ2wYSbp+GHDyJfdhxW76P5eSyjZflPiNtLJCzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OiD5zxUp; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiD5zxUp"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f16f15so944912e87.3
        for <linux-s390@vger.kernel.org>; Sat, 12 Sep 2026 06:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789221037; x=1789825837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y5bfO3aVxyQqkN/+edIPBHMp3Bhz/WilPPvcS2a/7bI=;
        b=OiD5zxUpfhZGVRoNBux/4um7PaMocc7SbtgDlVyHi3ItZMGKIOcX2/f9GYp3fSEntT
         P3NDjSkf3nhN3Zyp6G3pmdsIiTuL4ynd8FiMi0CrPIthauwvkWBw2wILonVC6Jq+qVDu
         5QZ8A93edFQOUTJ1VD+6ol4WsQe2uuGB8i1KDB9TbrawVrmmEgjR+Jerj7t1hGoJWOVs
         NoGbVk8NYbKIVjFDuKZKKC91yhvJ8TLsr+lcOy93xPpMKZtPtmcpbsp3gvdSGSVopRHI
         JkzzON6s+j6PV1RevH3yaOQTTh7p5PUTaaCHhfAAJ2q0Kj6x3EKGPVVonRhqkjkD+9S5
         AeeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789221037; x=1789825837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y5bfO3aVxyQqkN/+edIPBHMp3Bhz/WilPPvcS2a/7bI=;
        b=cViDPlgOJ8R98okIrqy4qgNRhFdLADQO6rOQ6q6aRyNkQvEA0a4So0vu26l6vrEaoB
         QEoxIVGpjEBvDPGewYRe4smxFX7BAGDkKbMo1gG8H6wgoTvCPIGWZKOs5WpNtko429Tb
         Igya/W9y6KqpxwUX8pJ/KXA+xbOAkVaFP+/TZYXb08Y+Y4Sykux1wOWGK5OKf1xL436h
         OIDky536ymy+uu0W7ouF1RmjIIk1AH8Uuh00h/Kh5mcd9NjsuWfOCNLJzVWLmcyviRMT
         iz5JuuzJXCXfFVOBAvRZfhkNocEcufUdYwzLj4Hl3wYTrGR7FCKyYcTd2BTPJfgwuQbh
         g/Uw==
X-Forwarded-Encrypted: i=1; AKwUvBw3wbXDNkBjEKnPJjZwoDy/QeHcHF9k0MQkqsmp7QhxwylwDckIRm3/ghKgT9sXN8rLAZEAt8zNZkta@vger.kernel.org
X-Gm-Message-State: AFuF++nZsJi4nnfST/aHWRpnHEZdrCfaRFp+ZS3z+XGyecbnynhgXMia
	L2NvG3LI4bosge3prpdhHx2z1UTcnpNNQoQR7cYXx3NgjMTgXnK0ubJv
X-Gm-Gg: AYBFou11AvcPW9gn2kTAUYwdhyV6/wtKEPEyJ1yZr4pJdVXIb55iJVI9WPQ+xWGiyOS
	OgK6YtbSH9G+EOWZxwjP6ECiUPNmdR0EJjJSXsuiYu3n3JH2Qr2ddtpBnfNDi5yXYX3Zd4WhdSK
	GmtNybbjJs1Ae528Ma/kkCYG49IufiuY4K083MS6Xv5g8+zHJta3NaXJ3iB+92Iy/iKzlfFxKK5
	nZDsURrwL/IFui/RPJAxOOPeY3NVmfSC+1neKlCtDnuAWAUAeTPfGvVQ1I5ESGlU2YV18ttW9Oz
	5CwpvpTgu5bcSFc/lh9CODf2hpEpjWdjivOVw2ACyMKwsWWQQdeyNn178N5OAi77lsPAVszaCGE
	nftSpmX+28WHuXp+lY25wlbgSLnzWcPIZa0H+TUAdItiJ6MLySU9kkagYqw1KgmIbQ6VZhRuDKS
	MiAmF7XUAOV5gZRJwKG5jYa89wPKHxU2b7hQNGDRnmavSIwbb9V9YwFKA1NUCxFbjINF46jCGlb
	voylOECpiPBVhxqayNtEm1f1f3MyT9rs50paQzC/leDx/LWH3s9VQqyyyPUTKze+Q9k
X-Received: by 2002:a05:6512:3f23:b0:5b6:6af:4e0e with SMTP id 2adb3069b0e04-5b8a02dccabmr3745340e87.3.1789221036430;
        Sat, 12 Sep 2026 06:50:36 -0700 (PDT)
Received: from localhost.localdomain (46-138-187-224.dynamic.spd-mgts.ru. [46.138.187.224])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8a0457246sm1257770e87.23.2026.09.12.06.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 06:50:36 -0700 (PDT)
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
Subject: [PATCH net-next v2 1/2] rtnetlink: pass extack to ndo_bridge_getlink()
Date: Sat, 12 Sep 2026 16:50:21 +0300
Message-ID: <20260912135022.1701-2-iprintercanon@gmail.com>
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

Let the bridge report why it could not fill in the link info for a
port. rtnl_bridge_getlink() passes the dump extack, rtnl_bridge_notify()
gets one from its setlink and dellink callers.

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
index fe47ec0ba8094..038ce1fe5bfe5 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -8086,12 +8086,14 @@ int ice_set_rss_hfunc(struct ice_vsi *vsi, u8 hfunc)
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
@@ -8099,7 +8101,7 @@ ice_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
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
index 707b2e51c2b97..18a03f0f6f113 100644
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
index be9d1625bac31..967b587ef6648 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -5398,7 +5398,8 @@ int ndo_dflt_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 			    u32 filter_mask,
 			    int (*vlan_fill)(struct sk_buff *skb,
 					     struct net_device *dev,
-					     u32 filter_mask))
+					     u32 filter_mask),
+			    struct netlink_ext_ack *extack)
 {
 	struct nlmsghdr *nlh;
 	struct ifinfomsg *ifm;
@@ -5574,7 +5575,8 @@ static int rtnl_bridge_getlink(struct sk_buff *skb, struct netlink_callback *cb)
 			if (idx >= cb->args[0]) {
 				err = br_dev->netdev_ops->ndo_bridge_getlink(
 						skb, portid, seq, dev,
-						filter_mask, NLM_F_MULTI);
+						filter_mask, NLM_F_MULTI,
+						cb->extack);
 				if (err < 0 && err != -EOPNOTSUPP) {
 					if (likely(skb->len))
 						break;
@@ -5590,7 +5592,8 @@ static int rtnl_bridge_getlink(struct sk_buff *skb, struct netlink_callback *cb)
 				err = ops->ndo_bridge_getlink(skb, portid,
 							      seq, dev,
 							      filter_mask,
-							      NLM_F_MULTI);
+							      NLM_F_MULTI,
+							      cb->extack);
 				if (err < 0 && err != -EOPNOTSUPP) {
 					if (likely(skb->len))
 						break;
@@ -5624,7 +5627,8 @@ static inline size_t bridge_nlmsg_size(void)
 		+ nla_total_size(sizeof(u16));	/* IFLA_BRIDGE_MODE */
 }
 
-static int rtnl_bridge_notify(struct net_device *dev)
+static int rtnl_bridge_notify(struct net_device *dev,
+			      struct netlink_ext_ack *extack)
 {
 	struct net *net = dev_net(dev);
 	struct sk_buff *skb;
@@ -5639,7 +5643,7 @@ static int rtnl_bridge_notify(struct net_device *dev)
 		goto errout;
 	}
 
-	err = dev->netdev_ops->ndo_bridge_getlink(skb, 0, 0, dev, 0, 0);
+	err = dev->netdev_ops->ndo_bridge_getlink(skb, 0, 0, dev, 0, 0, extack);
 	if (err < 0)
 		goto errout;
 
@@ -5730,7 +5734,7 @@ static int rtnl_bridge_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			/* Generate event to notify upper layer of bridge
 			 * change
 			 */
-			err = rtnl_bridge_notify(dev);
+			err = rtnl_bridge_notify(dev, extack);
 		}
 	}
 
@@ -5805,7 +5809,7 @@ static int rtnl_bridge_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			/* Generate event to notify upper layer of bridge
 			 * change
 			 */
-			err = rtnl_bridge_notify(dev);
+			err = rtnl_bridge_notify(dev, extack);
 		}
 	}
 
-- 
2.43.0

