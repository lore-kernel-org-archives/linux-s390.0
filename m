Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B0249B5A2;
	Tue, 22 Sep 2026 18:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790102669; cv=none; b=Iaq+sHin2fEDMiP95rwrVBt46DPMUS/W3+h9S8TgANk/oXmZPWVX/mL4T0c/jd2R/yiCL45FFBbtmctUb0t2C3gXqVDe3VWGRXIiGrskimJVKQxkpb0BkS+y9Om/iOxmajsFqj4Yut/SjsStvhkF2SvtfCWQv5TKyGqbMm9OXng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790102669; c=relaxed/simple;
	bh=7PLii7ETIvCKdWk31bzgi6aDo157/lglI8HsoGMnRdM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nuvqKCq6s55uocC1FY7Rf+SF0eEyRV2kbROiRx5ZHEK17XdnmUlnmgdDU9qIRbTW7cpTydTIgTWqASS/yunTxUHv1GJw4NoH/G1SM0ZIzhMp4q72a5D2kUOyWRLEulPvZto7ydPci8fXyt/Rw3uaiUK9ip7z+AbCkrdVpgasl4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAXyt4bd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kAXyt4bd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7911F000FF;
	Tue, 22 Sep 2026 18:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790102660;
	bh=UjEou/Ftu9I+L9AdcUk1ScJDdFJXrMrfvwt0cglL1Ok=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kAXyt4bdygdTvDTWP9ntXNYI0zgVyiwrs67bi2HRbSIo7Wxqaz2v4x7icoTZqR80V
	 4/QXnH3/sd24yVc/cs5JtVq0uYoQMMUbKh9FzQIi0n7njAPMg37w9FzAXz4QGiiZd9
	 cI31Q4kq6LXby1RYeHzlYuo3ZEp/1U0JGUj2rYqNShaGDbQN5YdP7kgEX4mDj5klRd
	 NHFVCZ0Zd+RfrOSR9297bdJEI3sU2cF4MTUYjZMEBGDYtx2tPm56BZ0LFh/EAKBU5Z
	 CDn92FXS8UicEfgNeEv+Az9kh+5afz1FxuSaETQ6grP7RiGfWcErFY5TR+u1cPTj7D
	 GACtiByAkm2XA==
Subject:
 Re: [PATCH net-next v3 1/2] rtnetlink: pass extack to ndo_bridge_getlink()
From: netdev-bot+sashiko@kernel.org
To: iprintercanon@gmail.com
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev, razor@blackwall.org,
 idosch@nvidia.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch, kuniyu@google.com,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, oss-drivers@corigine.com, wintera@linux.ibm.com,
 aswin@linux.ibm.com, linux-s390@vger.kernel.org
Date: Tue, 22 Sep 2026 18:44:18 +0000
Message-ID: <179010265895.2160803.373522142695973642@kernel.org>
In-Reply-To: <20260919134333.49379-2-iprintercanon@gmail.com>
References: <20260919134333.49379-2-iprintercanon@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Patch 1 ("rtnetlink: pass extack to ndo_bridge_getlink()")
  threads a `struct netlink_ext_ack *extack` through the…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but in
  `br_fill_ifinfo()` (net/bridge/br_netlink.c) the VLAN-fill result is…

--

rtnetlink: pass extack to ndo_bridge_getlink()

The patch adds a struct netlink_ext_ack *extack argument to the
ndo_bridge_getlink op, to ndo_dflt_bridge_getlink() and to br_getlink(),
and updates the eight in-tree implementations plus the two rtnetlink call
sites. The commit describes itself as no functional change.

> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index e3444fd24061..a341e06f47d3 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -5420,7 +5420,8 @@ int ndo_dflt_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>  			    u32 filter_mask,
>  			    int (*vlan_fill)(struct sk_buff *skb,
>  					     struct net_device *dev,
> -					     u32 filter_mask))
> +					     u32 filter_mask),
> +			    struct netlink_ext_ack *extack)
>  {
>  	struct nlmsghdr *nlh;
>  	struct ifinfomsg *ifm;

[Severity: Low]
Taken on its own, does this patch leave extack unused in every callee it
touches?

ndo_dflt_bridge_getlink() gains the parameter but none of its failure
paths reference it:

net/core/rtnetlink.c:ndo_dflt_bridge_getlink() {
	...
	nlh = nlmsg_put(skb, pid, seq, RTM_NEWLINK, sizeof(*ifm), nlflags);
	if (nlh == NULL)
		return -EMSGSIZE;
	...
nla_put_failure:
	nlmsg_cancel(skb, nlh);
	return err ? err : -EMSGSIZE;
}

So for the eight drivers that use the default helper the extack stays
empty, and the commit message statement "So the bridge can say why filling
the link info failed" is only realized by the next patch in the series,
which adds the extack argument to br_fill_ifinfo() and emits
NL_SET_ERR_MSG_MOD() there. Would it help to say in the changelog that
this is preparation and that the message is added by the following patch?

[ ... ]

> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index ae76df0de05a..855a46aec3a8 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -680,7 +680,8 @@ void br_ifinfo_notify(int event, const struct net_bridge *br,
>   * Dump information about all ports, in response to GETLINK
>   */
>  int br_getlink(struct sk_buff *skb, u32 pid, u32 seq,
> -	       struct net_device *dev, u32 filter_mask, int nlflags)
> +	       struct net_device *dev, u32 filter_mask, int nlflags,
> +	       struct netlink_ext_ack *extack)
>  {
>  	struct net_bridge_port *port = br_port_get_rtnl(dev);
>  

[Severity: Low]
br_getlink() accepts extack here but drops it, since the call below is
left unchanged:

net/bridge/br_netlink.c:br_getlink() {
	...
	return br_fill_ifinfo(skb, port, pid, seq, RTM_NEWLINK, nlflags,
			      filter_mask, dev, true);
}

br_fill_ifinfo() is the function that actually returns -EMSGSIZE, so does
anything in the bridge get to use the new argument until the follow-up
patch wires it into br_fill_ifinfo()?

While looking at br_fill_ifinfo() for the above, one unrelated
observation:

[Severity: Medium]
This isn't a bug introduced by this patch, but in br_fill_ifinfo() the
VLAN fill result is overwritten before it is tested:

net/bridge/br_netlink.c:br_fill_ifinfo() {
	...
		if (filter_mask & RTEXT_FILTER_BRVLAN_COMPRESSED)
			err = br_fill_ifvlaninfo_compressed(skb, vg);
		else
			err = br_fill_ifvlaninfo(skb, vg);

		if (port && test_bit(BR_VLAN_TUNNEL_BIT, &port->flags))
			err = br_fill_vlan_tunnel_info(skb, vg);
		rcu_read_unlock();
		if (err)
			goto nla_put_failure;
	...
}

Can an -EMSGSIZE from br_fill_ifvlaninfo[_compressed]() be lost here?
br_fill_vlan_tunnel_info() in net/bridge/br_netlink_tunnel.c skips every
VLAN that has no tinfo.tunnel_dst and returns 0 without touching the skb,
which happens after "bridge link set dev X vlan_tunnel on" with no
tunnel_info id mappings configured:

net/bridge/br_netlink_tunnel.c:br_fill_vlan_tunnel_info() {
	list_for_each_entry_rcu(v, &vg->vlan_list, vlist) {
		if (!br_vlan_should_use(v))
			continue;

		if (!v->tinfo.tunnel_dst)
			continue;
	...
	return 0;
}

In that configuration a partially filled VLAN list appears to be
finalized as success, and rtnl_bridge_getlink() then advances idx and
records it in cb->args[0], so the port is not retried in the next dump
round:

net/core/rtnetlink.c:rtnl_bridge_getlink() {
	...
				if (err < 0 && err != -EOPNOTSUPP) {
					if (likely(skb->len))
						break;

					goto out_err;
				}
			}
			idx++;
	...
}

Would testing the VLAN fill error before calling
br_fill_vlan_tunnel_info() be the right fix? This code is identical in
the baseline and is unchanged by the series, so it is a separate patch.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260919134333.49379-1-iprintercanon%40gmail.com
