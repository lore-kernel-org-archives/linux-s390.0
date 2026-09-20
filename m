Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4CA3D891B
	for <linux-s390@vger.kernel.org>; Sun, 20 Sep 2026 07:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789888119; cv=none; b=VgAOyd248rQxN6Iixx7Xu3gEOYYD3RHGxoGdcHJaebpgS+kWI6aJLhjHhUtKnzRwXVOaU91kQTLREREydqfyFLcGvqBlwdL1vHKgr5cQiOGt32lTn9jud5eIsjyPAyWKakh9JgXXJpFxtcKACAE3FEriVYRAovWi0n9ZUU90S6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789888119; c=relaxed/simple;
	bh=UcyekEQRBb7flYblA6hLBahsKdgReCtr55hlqgu3CqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GjajNFxfaWA4HjBup92wz8FQOFZbn4VlGJaR0K4o3+sqbxK54MvfLzwzJXqRsRkMyYWEIG4v7S+9OPuv6ouLrC1ZJkl3fSRLzz2mYS2udAkdJaO3p3E6PS9qscns4CqBHMcEXKaRo0oWlREklvILZjHi+4W+poOs4D6gulmBgoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=VxEkaL+d; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="VxEkaL+d"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843c2790ccso1152701f8f.1
        for <linux-s390@vger.kernel.org>; Sun, 20 Sep 2026 00:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1789888115; x=1790492915; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IWoOG7D8vztnIM1BP023M7H61wV5J54IgjjOh01M0Yk=;
        b=VxEkaL+dCN5AT+D2DVMO1pGcHuXbsf+Jk1u2Gzar387vVs2LqMNFguTIBEKfy4YD8p
         gYiHQvMT9uTEO9430p9UpqkyocoC8ylQ2mgvvVH9PlN8p5nmx7qfF+rovC/fENmrS/wg
         NNu0Ewj6z1paiKhBPncxdsAx1YgS9sWhDsdegwoOUS+xHvKRV5APQ7Lk/nyBHk7MC2SA
         De2KYBfngMEXqsdoJ5Wldjr+Vn+xj/oqt2u2DPaxUyLuxT9Lwgp7nyDQa9f5o2VuNH7r
         5szmvw3w30bAxqLYSqPpTlkHjhfpAi4yZCarYMzok5yUoqlMI7KkN7B6gZ2Jo58j1Ceb
         drTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789888115; x=1790492915;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IWoOG7D8vztnIM1BP023M7H61wV5J54IgjjOh01M0Yk=;
        b=KJdmFWvoGKpkK1pRPE+qXws5OQ0UC/kuBQ6X4m25mN4n99H3vEI7ITIilj67kSgeR4
         1un3MUR0AL0LAMm7x4y4A2ZbIv44YtRMcsINzCLsCScXgGnkS/D04AGvs61PdxxDdiPC
         NYVEbSpEoMft+zqzySWJhpYwkeGHDS09VTp2Jy70KeYIM2Gp+0XwGh9xI2hqctSaWp33
         ItQfG4aX0MKB1W6D3wew8O9KhfI0Do+KbkTLK6g18CLoM5v0yO5K54WT9YXNlb6lSki9
         nBy1z/iEXZ4jaKPI5GqKOIbSk94pSCoWymSXmTeN+qptmpmD6z0sz5NlTuTxqle5DfTq
         05GQ==
X-Forwarded-Encrypted: i=1; AKwUvBxF7YpfKmGEKMRBerI5vasD8pR2F3yxBhXhAaP/9zy0J7JykxgjLvrYOlSCjLEI0MHKBD8bA/7j/zVp@vger.kernel.org
X-Gm-Message-State: AFuF++mFdS6fPc+QWMFyFSEvJHkUmmKoLt92028iRsGtAi10Uhe1rUFc
	oHEopxEOANZ6ubYkdYvvCeCKf0t0yge65w0mSsctmd+mEfkBRvMMmE2+v9y/VgddNNc=
X-Gm-Gg: AYBFou3SgDdjlpM3Hpn23vR0MnDS6dxDNRZAsYyetk/ZrtjNYZpKFEzUtm/G6L5RUYJ
	tbesbsUPZdt6Y0f4zP6A/3YN5ayDTMeJB4pQeWaj8lzJ1SfjYrDmDtehIVUgICLDZIR1LMaKL3a
	neLOfjEXtLFgjzKh1GltsKKooKQwyznOzRJe8gxSvl6yXi5MBEHvj0GLOtLURAzkxIG8+VRLHpV
	Do9fH10CtEwPJkF4DmhqHbOTho4wCwVVBTON7SfEMNBq7iDnxpxMpkiywMjxccn/iagLda3SKC1
	nIaYaR4zb2q6sROq7lgNj1gizVon46Cc25ma8rR6aXGEJJfSKn5r2WNgs5a0SFarH9kcU9H9yXO
	PyY9OBQtEwQ+PeKxC6v4yoH9gcW3AQxykRxAa4+XMCufX1Mk0fjayJTxVbY7l42cP3Oj27YrKf4
	xmSKkGUfN/dUCTAM27yAlR9vFmF9IPzCqDRqv/FginCIZP7ezIRD2z1f/ApcQ/0P2qSoRDS5Mrk
	W3PUiBL62pU5If76JALKDeWr489jg==
X-Received: by 2002:adf:e001:0:20b0:487:21a4:f617 with SMTP id ffacd0b85a97d-48721a4f785mr9429604f8f.19.1789888115117;
        Sun, 20 Sep 2026 00:08:35 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48724583250sm12547870f8f.22.2026.09.20.00.08.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2026 00:08:33 -0700 (PDT)
Message-ID: <7264d59b-45d1-4235-9079-dfb8e800dd83@blackwall.org>
Date: Sun, 20 Sep 2026 10:08:31 +0300
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] rtnetlink: pass extack to
 ndo_bridge_getlink()
Content-Language: en-US, bg
To: Artem Lytkin <iprintercanon@gmail.com>, netdev@vger.kernel.org
Cc: bridge@lists.linux.dev, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, kuniyu@google.com, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, ajit.khaparde@broadcom.com,
 sriharsha.basavapatna@broadcom.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
 oss-drivers@corigine.com, wintera@linux.ibm.com, aswin@linux.ibm.com,
 linux-s390@vger.kernel.org
References: <20260919134333.49379-1-iprintercanon@gmail.com>
 <20260919134333.49379-2-iprintercanon@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260919134333.49379-2-iprintercanon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/09/2026 16:43, Artem Lytkin wrote:
> So the bridge can say why filling the link info failed.
> No functional change.
> 
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
> ---
>   drivers/net/ethernet/broadcom/bnxt/bnxt.c      |  4 ++--
>   drivers/net/ethernet/emulex/benet/be_main.c    |  4 ++--
>   drivers/net/ethernet/intel/i40e/i40e_main.c    |  6 ++++--
>   drivers/net/ethernet/intel/ice/ice_main.c      |  6 ++++--
>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |  5 +++--
>   .../net/ethernet/mellanox/mlx5/core/en_main.c  |  4 ++--
>   .../ethernet/netronome/nfp/nfp_net_common.c    |  4 ++--
>   drivers/s390/net/qeth_l2_main.c                |  4 ++--
>   include/linux/netdevice.h                      |  5 +++--
>   include/linux/rtnetlink.h                      |  3 ++-
>   net/bridge/br_netlink.c                        |  3 ++-
>   net/bridge/br_private.h                        |  2 +-
>   net/core/rtnetlink.c                           | 18 +++++++++++-------
>   13 files changed, 40 insertions(+), 28 deletions(-)
> 

Why do you add extack to ndo_dflt_bridge_getlink() at all? It doesn't use it and
just causes unnecessary churn in drivers.

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index ca99f4b1a63c3..a752e66bf6368 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -16154,12 +16154,12 @@ static const struct udp_tunnel_nic_info bnxt_udp_tunnels = {
>   
>   static int bnxt_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>   			       struct net_device *dev, u32 filter_mask,
> -			       int nlflags)
> +			       int nlflags, struct netlink_ext_ack *extack)
>   {
>   	struct bnxt *bp = netdev_priv(dev);
>   
>   	return ndo_dflt_bridge_getlink(skb, pid, seq, dev, bp->br_mode, 0, 0,
> -				       nlflags, filter_mask, NULL);
> +				       nlflags, filter_mask, NULL, extack);
>   }
>   
>   static int bnxt_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
> diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
> index ed302f5ec4768..cc9c87539a429 100644
> --- a/drivers/net/ethernet/emulex/benet/be_main.c
> +++ b/drivers/net/ethernet/emulex/benet/be_main.c
> @@ -5011,7 +5011,7 @@ static int be_ndo_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
>   
>   static int be_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>   				 struct net_device *dev, u32 filter_mask,
> -				 int nlflags)
> +				 int nlflags, struct netlink_ext_ack *extack)
>   {
>   	struct be_adapter *adapter = netdev_priv(dev);
>   	int status = 0;
> @@ -5037,7 +5037,7 @@ static int be_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>   	return ndo_dflt_bridge_getlink(skb, pid, seq, dev,
>   				       hsw_mode == PORT_FWD_TYPE_VEPA ?
>   				       BRIDGE_MODE_VEPA : BRIDGE_MODE_VEB,
> -				       0, 0, nlflags, filter_mask, NULL);
> +				       0, 0, nlflags, filter_mask, NULL, extack);
>   }
>   
>   static struct be_cmd_work *be_alloc_work(struct be_adapter *adapter,
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index abbc71e815ae3..52c2b393aacd2 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -13151,6 +13151,7 @@ static int i40e_ndo_bridge_setlink(struct net_device *dev,
>    * @dev: the netdev being configured
>    * @filter_mask: unused
>    * @nlflags: netlink flags passed in
> + * @extack: netlink extended ack
>    *
>    * Return the mode in which the hardware bridge is operating in
>    * i.e VEB or VEPA.
> @@ -13158,7 +13159,8 @@ static int i40e_ndo_bridge_setlink(struct net_device *dev,
>   static int i40e_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>   				   struct net_device *dev,
>   				   u32 __always_unused filter_mask,
> -				   int nlflags)
> +				   int nlflags,
> +				   struct netlink_ext_ack *extack)
>   {
>   	struct i40e_netdev_priv *np = netdev_priv(dev);
>   	struct i40e_vsi *vsi = np->vsi;
> @@ -13175,7 +13177,7 @@ static int i40e_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>   		return 0;
>   
>   	return ndo_dflt_bridge_getlink(skb, pid, seq, dev, veb->bridge_mode,
> -				       0, 0, nlflags, filter_mask, NULL);
> +				       0, 0, nlflags, filter_mask, NULL, extack);
>   }
>   
>   /**
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 707c7431b91a6..f98295438df78 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -8095,12 +8095,14 @@ int ice_set_rss_hfunc(struct ice_vsi *vsi, u8 hfunc)
>    * @dev: the netdev being configured
>    * @filter_mask: filter mask passed in
>    * @nlflags: netlink flags passed in
> + * @extack: netlink extended ack
>    *
>    * Return the bridge mode (VEB/VEPA)
>    */
>   static int
>   ice_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
> -		   struct net_device *dev, u32 filter_mask, int nlflags)
> +		   struct net_device *dev, u32 filter_mask, int nlflags,
> +		   struct netlink_ext_ack *extack)
>   {
>   	struct ice_pf *pf = ice_netdev_to_pf(dev);
>   	u16 bmode;
> @@ -8108,7 +8110,7 @@ ice_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>   	bmode = pf->first_sw->bridge_mode;
>   
>   	return ndo_dflt_bridge_getlink(skb, pid, seq, dev, bmode, 0, 0, nlflags,
> -				       filter_mask, NULL);
> +				       filter_mask, NULL, extack);
>   }
>   
>   /**
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index f91856498eb2d..77dfd80a6e368 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -10726,7 +10726,8 @@ static int ixgbe_ndo_bridge_setlink(struct net_device *dev,
>   
>   static int ixgbe_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>   				    struct net_device *dev,
> -				    u32 filter_mask, int nlflags)
> +				    u32 filter_mask, int nlflags,
> +				    struct netlink_ext_ack *extack)
>   {
>   	struct ixgbe_adapter *adapter = ixgbe_from_netdev(dev);
>   
> @@ -10735,7 +10736,7 @@ static int ixgbe_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>   
>   	return ndo_dflt_bridge_getlink(skb, pid, seq, dev,
>   				       adapter->bridge_mode, 0, 0, nlflags,
> -				       filter_mask, NULL);
> +				       filter_mask, NULL, extack);
>   }
>   
>   static void *ixgbe_fwd_add(struct net_device *pdev, struct net_device *vdev)
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index fc110a7d16e8d..53bf79dbe08de 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -5277,7 +5277,7 @@ static int mlx5e_xdp(struct net_device *dev, struct netdev_bpf *xdp)
>   #ifdef CONFIG_MLX5_ESWITCH
>   static int mlx5e_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>   				struct net_device *dev, u32 filter_mask,
> -				int nlflags)
> +				int nlflags, struct netlink_ext_ack *extack)
>   {
>   	struct mlx5e_priv *priv = netdev_priv(dev);
>   	struct mlx5_core_dev *mdev = priv->mdev;
> @@ -5288,7 +5288,7 @@ static int mlx5e_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>   	mode = setting ? BRIDGE_MODE_VEPA : BRIDGE_MODE_VEB;
>   	return ndo_dflt_bridge_getlink(skb, pid, seq, dev,
>   				       mode,
> -				       0, 0, nlflags, filter_mask, NULL);
> +				       0, 0, nlflags, filter_mask, NULL, extack);
>   }
>   
>   static int mlx5e_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
> diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
> index 7928e76da723e..cb751dddb6887 100644
> --- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
> +++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
> @@ -2257,7 +2257,7 @@ static int nfp_net_set_mac_address(struct net_device *netdev, void *addr)
>   
>   static int nfp_net_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>   				  struct net_device *dev, u32 filter_mask,
> -				  int nlflags)
> +				  int nlflags, struct netlink_ext_ack *extack)
>   {
>   	struct nfp_net *nn = netdev_priv(dev);
>   	u16 mode;
> @@ -2269,7 +2269,7 @@ static int nfp_net_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>   	       BRIDGE_MODE_VEPA : BRIDGE_MODE_VEB;
>   
>   	return ndo_dflt_bridge_getlink(skb, pid, seq, dev, mode, 0, 0,
> -				       nlflags, filter_mask, NULL);
> +				       nlflags, filter_mask, NULL, extack);
>   }
>   
>   static int nfp_net_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
> diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
> index 2935c2ecc314b..f960cf5a97a29 100644
> --- a/drivers/s390/net/qeth_l2_main.c
> +++ b/drivers/s390/net/qeth_l2_main.c
> @@ -935,7 +935,7 @@ static void qeth_l2_br2dev_put(void)
>   
>   static int qeth_l2_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>   				  struct net_device *dev, u32 filter_mask,
> -				  int nlflags)
> +				  int nlflags, struct netlink_ext_ack *extack)
>   {
>   	struct qeth_priv *priv = netdev_priv(dev);
>   	struct qeth_card *card = dev->ml_priv;
> @@ -949,7 +949,7 @@ static int qeth_l2_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>   	return ndo_dflt_bridge_getlink(skb, pid, seq, dev,
>   				       mode, priv->brport_features,
>   				       priv->brport_hw_features,
> -				       nlflags, filter_mask, NULL);
> +				       nlflags, filter_mask, NULL, extack);
>   }
>   
>   static const struct nla_policy qeth_brport_policy[IFLA_BRPORT_MAX + 1] = {
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 1f0710eef185b..02238b1e33453 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1360,7 +1360,7 @@ struct netdev_net_notifier {
>    *			     u16 flags, struct netlink_ext_ack *extack)
>    * int (*ndo_bridge_getlink)(struct sk_buff *skb, u32 pid, u32 seq,
>    *			     struct net_device *dev, u32 filter_mask,
> - *			     int nlflags)
> + *			     int nlflags, struct netlink_ext_ack *extack)
>    * int (*ndo_bridge_dellink)(struct net_device *dev, struct nlmsghdr *nlh,
>    *			     u16 flags);
>    *
> @@ -1659,7 +1659,8 @@ struct net_device_ops {
>   						      u32 pid, u32 seq,
>   						      struct net_device *dev,
>   						      u32 filter_mask,
> -						      int nlflags);
> +						      int nlflags,
> +						      struct netlink_ext_ack *extack);
>   	int			(*ndo_bridge_dellink)(struct net_device *dev,
>   						      struct nlmsghdr *nlh,
>   						      u16 flags);
> diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
> index 95729339e7a54..a408c36a7b558 100644
> --- a/include/linux/rtnetlink.h
> +++ b/include/linux/rtnetlink.h
> @@ -222,7 +222,8 @@ extern int ndo_dflt_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>   				   u32 filter_mask,
>   				   int (*vlan_fill)(struct sk_buff *skb,
>   						    struct net_device *dev,
> -						    u32 filter_mask));
> +						    u32 filter_mask),
> +				   struct netlink_ext_ack *extack);
>   
>   extern void rtnl_offload_xstats_notify(struct net_device *dev);
>   
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index ae76df0de05a0..855a46aec3a89 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -680,7 +680,8 @@ void br_ifinfo_notify(int event, const struct net_bridge *br,
>    * Dump information about all ports, in response to GETLINK
>    */
>   int br_getlink(struct sk_buff *skb, u32 pid, u32 seq,
> -	       struct net_device *dev, u32 filter_mask, int nlflags)
> +	       struct net_device *dev, u32 filter_mask, int nlflags,
> +	       struct netlink_ext_ack *extack)
>   {
>   	struct net_bridge_port *port = br_port_get_rtnl(dev);
>   
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 09c397e303307..edbe7a1f57363 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -2179,7 +2179,7 @@ int br_setlink(struct net_device *dev, struct nlmsghdr *nlmsg, u16 flags,
>   	       struct netlink_ext_ack *extack);
>   int br_dellink(struct net_device *dev, struct nlmsghdr *nlmsg, u16 flags);
>   int br_getlink(struct sk_buff *skb, u32 pid, u32 seq, struct net_device *dev,
> -	       u32 filter_mask, int nlflags);
> +	       u32 filter_mask, int nlflags, struct netlink_ext_ack *extack);
>   int br_process_vlan_info(struct net_bridge *br,
>   			 struct net_bridge_port *p, int cmd,
>   			 struct bridge_vlan_info *vinfo_curr,
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index e3444fd240615..a341e06f47d31 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -5420,7 +5420,8 @@ int ndo_dflt_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>   			    u32 filter_mask,
>   			    int (*vlan_fill)(struct sk_buff *skb,
>   					     struct net_device *dev,
> -					     u32 filter_mask))
> +					     u32 filter_mask),
> +			    struct netlink_ext_ack *extack)
>   {
>   	struct nlmsghdr *nlh;
>   	struct ifinfomsg *ifm;
> @@ -5596,7 +5597,8 @@ static int rtnl_bridge_getlink(struct sk_buff *skb, struct netlink_callback *cb)
>   			if (idx >= cb->args[0]) {
>   				err = br_dev->netdev_ops->ndo_bridge_getlink(
>   						skb, portid, seq, dev,
> -						filter_mask, NLM_F_MULTI);
> +						filter_mask, NLM_F_MULTI,
> +						cb->extack);
>   				if (err < 0 && err != -EOPNOTSUPP) {
>   					if (likely(skb->len))
>   						break;
> @@ -5612,7 +5614,8 @@ static int rtnl_bridge_getlink(struct sk_buff *skb, struct netlink_callback *cb)
>   				err = ops->ndo_bridge_getlink(skb, portid,
>   							      seq, dev,
>   							      filter_mask,
> -							      NLM_F_MULTI);
> +							      NLM_F_MULTI,
> +							      cb->extack);
>   				if (err < 0 && err != -EOPNOTSUPP) {
>   					if (likely(skb->len))
>   						break;
> @@ -5646,7 +5649,8 @@ static inline size_t bridge_nlmsg_size(void)
>   		+ nla_total_size(sizeof(u16));	/* IFLA_BRIDGE_MODE */
>   }
>   
> -static int rtnl_bridge_notify(struct net_device *dev)
> +static int rtnl_bridge_notify(struct net_device *dev,
> +			      struct netlink_ext_ack *extack)
>   {
>   	struct net *net = dev_net(dev);
>   	struct sk_buff *skb;
> @@ -5661,7 +5665,7 @@ static int rtnl_bridge_notify(struct net_device *dev)
>   		goto errout;
>   	}
>   
> -	err = dev->netdev_ops->ndo_bridge_getlink(skb, 0, 0, dev, 0, 0);
> +	err = dev->netdev_ops->ndo_bridge_getlink(skb, 0, 0, dev, 0, 0, extack);
>   	if (err < 0)
>   		goto errout;
>   
> @@ -5752,7 +5756,7 @@ static int rtnl_bridge_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
>   			/* Generate event to notify upper layer of bridge
>   			 * change
>   			 */
> -			err = rtnl_bridge_notify(dev);
> +			err = rtnl_bridge_notify(dev, extack);
>   		}
>   	}
>   
> @@ -5827,7 +5831,7 @@ static int rtnl_bridge_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
>   			/* Generate event to notify upper layer of bridge
>   			 * change
>   			 */
> -			err = rtnl_bridge_notify(dev);
> +			err = rtnl_bridge_notify(dev, extack);
>   		}
>   	}
>   

