Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E7C3B7B7F;
	Tue, 22 Sep 2026 18:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790102669; cv=none; b=aVROGE7fzynzfW/pdovCbDv9WIc9984VcXIfPWkPM3tGklY6VJoKhKJkR5+/sPsNbV39D0kBNreG9iXZ/1YYwXU642WbZFKhrSwSuIkZntWt94iuH+QZPQh9Vc0cJI7HWIuiZ0j/bXRLbQTFcVpgZzDMNOMjanfVzar/Fki9+fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790102669; c=relaxed/simple;
	bh=h6IVm2PcH9mfF7+RczPWWLWohajk9HLBHhcz9iSYAjk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hl+61GrhFrMuBwallpkmyt5/6Vy8Jjm49Z4vb4N3nvO3UEMFnx0i0BHpqQiOdk6fbFRwtVXcj1oI7MHeOx+3sbhzopCt5uqgkkSoZ5fRl3h9qJ/MbAG2mywPBCXQ72f2zfL7CEnaNGnHU1xfwk9Ko65hLY1oJvTKM7TQ6tZIXnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULqOnm5o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULqOnm5o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A42C1F00893;
	Tue, 22 Sep 2026 18:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790102662;
	bh=1IxyZtZmcdhtuM2dKvn8d1mOOIfkqTrxHyUtB5yx34Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ULqOnm5olO9jV8adygoNsZuOmn8oIHOEmnsVGOtWjLKoo9wQbcDWm9aR2sEVyAa5P
	 xV8PP0GuJSs+MeZkf6/jt+3FTOKmFN3h/k/JlrGcdMfpwhTkrruHS+IhO9K2Wsj8sh
	 351uf+RCPeL1LQMBYTh301MfjqFFk3O7RbjsfLTpJYNFppizAwZYww2vQFKb63Y/yY
	 xUQBE1X+UGVTd1ZX/WndoRNElx59rsUwWC2c+tTzrXA7mdP8a3NyVE8A7Ku0AY0zwH
	 MEktnmSp+MONIClqYr0NgDhG8dvwcc/XkcgoWk/UylAecU+cEy6xqgX7cr9or2G+Oa
	 4d9WjI/4ulIOw==
Subject: Re: [PATCH net-next v3 2/2] net: bridge: fail link info that does not
 fit in a netlink attribute
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
Date: Tue, 22 Sep 2026 18:44:20 +0000
Message-ID: <179010266085.2160803.3521506082186980077@kernel.org>
In-Reply-To: <20260919134333.49379-3-iprintercanon@gmail.com>
References: <20260919134333.49379-3-iprintercanon@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (2) · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] New error path discards already-consumed CFM status.
- [Low] Missing `Fixes:` tag / stable routing information for a user-
  visible uAPI bug fix.
- [Low] The single `nla_nest_too_large` label emits "AF_SPEC info too
  large, use per-object dumps (e.g. RTM_GETVLAN)" for all three overflow…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but it
  undermines the notification behaviour the commit message describes:…
- [Medium] This problem wasn't introduced by this patch, but it sits
  directly in the rewritten function: in `br_fill_ifinfo()` the return…

--

net: bridge: fail link info that does not fit in a netlink attribute

br_fill_ifinfo() now finalizes the IFLA_AF_SPEC, IFLA_BRIDGE_CFM and
IFLA_BRIDGE_MST nests with nla_nest_end_safe() and returns -E2BIG with an
extack message when a nest payload exceeds what the u16 nla_len can
describe.  br_fill_ifinfo() gains an extack argument, passed through from
br_getlink() and NULL from br_info_notify().

A few questions on the change below.

> nla_len is a u16, and a port with enough VLANs, tunnels or MST entries
> makes the IFLA_AF_SPEC nest wrap, so userspace reads garbage. Same for
> the inner MST and CFM nests.

[Severity: Low]
Since the commit message describes pre-existing user-visible breakage
("userspace reads garbage") rather than a cleanup, should this carry a
Fixes: tag so it gets routed to stable?

The overflow does look reachable: __get_vlan_tinfo_size() in
br_netlink_tunnel.c charges 28 bytes per tunnel mapping

	return nla_total_size(0) + nla_total_size(sizeof(u32)) +
	       nla_total_size(sizeof(u16)) + nla_total_size(sizeof(u16));

so roughly 4094 VLANs with non-consecutive tunnel IDs push the AF_SPEC
payload past U16_MAX, and br_info_notify() allocates an skb of exactly
br_nlmsg_size() bytes for it.

Candidate anchors would be the commit that introduced the AF_SPEC nesting
(b6c02ef54913) and the later CFM/MST reporting additions.

> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index 855a46aec3a8..fbd91b86d426 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c

[ ... ]

> @@ -588,7 +588,8 @@ static int br_fill_ifinfo(struct sk_buff *skb,
>  				goto nla_put_failure;
>  		}
>  
> -		nla_nest_end(skb, cfm_nest);
> +		if (nla_nest_end_safe(skb, cfm_nest) < 0)
> +			goto nla_nest_too_large;
>  	}

[Severity: Medium]
Can this new exit throw away CFM status that has already been consumed?

br_getlink() calls br_fill_ifinfo() with getlink = true, and
br_cfm_status_fill_info() clears the "seen" indications as it serializes
each record:

net/bridge/br_cfm_netlink.c:br_cfm_status_fill_info() {
	...
	if (getlink) {
		/* Clear all 'seen' indications */
		mep->status.opcode_unexp_seen = false;
		mep->status.version_unexp_seen = false;
		mep->status.rx_level_low_seen = false;
	}
	...
		if (getlink) { /* Only clear if this is a GETLINK */
			/* Clear all 'seen' indications */
			peer_mep->cc_status.seen = false;
			peer_mep->cc_status.tlv_seen = false;
			peer_mep->cc_status.seq_unexp_seen = false;
		}
	...
}

Nothing bounds the peer MEP count so that the IFLA_BRIDGE_CFM nest stays
below U16_MAX (each peer status record is around 76 bytes, so roughly 860
peers overflow it).  The nest check then jumps to nla_nest_too_large, which
cancels the whole message and returns -E2BIG, after the flags were already
cleared.

A retry returns -E2BIG again, so that generation of defect and
unexpected-opcode information is gone.  Before this patch the malformed
message was at least delivered.  The existing nla_put_failure path has the
same clear-then-cancel shape; would validating the nest size before
consuming the state be preferable to adding another cancel-after-clear
exit?

> @@ -608,20 +609,27 @@ static int br_fill_ifinfo(struct sk_buff *skb,
>  		if (err)
>  			goto nla_put_failure;
>  
> -		nla_nest_end(skb, mst_nest);
> +		if (nla_nest_end_safe(skb, mst_nest) < 0)
> +			goto nla_nest_too_large;
>  	}
>  
>  done:
>  	if (af) {
> -		if (nlmsg_get_pos(skb) - (void *)af > nla_attr_size(0))
> -			nla_nest_end(skb, af);
> -		else
> +		if (nla_nest_end_safe(skb, af) < 0)
> +			goto nla_nest_too_large;
> +		if (!nla_len(af))
>  			nla_nest_cancel(skb, af);
>  	}
>  
>  	nlmsg_end(skb, nlh);
>  	return 0;
>  

[Severity: Medium]
This isn't a bug introduced by this patch, but it lands right in the
rewritten function: can the done: block finalize a truncated AF_SPEC nest
and report success?

Earlier in br_fill_ifinfo() the VLAN fill result is clobbered:

	if (filter_mask & RTEXT_FILTER_BRVLAN_COMPRESSED)
		err = br_fill_ifvlaninfo_compressed(skb, vg);
	else
		err = br_fill_ifvlaninfo(skb, vg);

	if (port && test_bit(BR_VLAN_TUNNEL_BIT, &port->flags))
		err = br_fill_vlan_tunnel_info(skb, vg);
	rcu_read_unlock();
	if (err)
		goto nla_put_failure;

br_fill_vlan_tunnel_info() in br_netlink_tunnel.c returns 0 without writing
anything when no VLAN in the group has a tunnel_dst:

	if (!v->tinfo.tunnel_dst)
		continue;
	...
	return 0;

vlan_tunnel is a port flag that can be set without any per-VLAN tunnel
mapping, so an -EMSGSIZE from the VLAN fill is overwritten with 0, the
goto nla_put_failure is skipped, and control reaches done: which ends the
nest and returns 0.  In a dump rtnl_bridge_getlink() then does

	idx++;

and moves past the device, so the missing VLANs are never emitted.

> +nla_nest_too_large:
> +	NL_SET_ERR_MSG_MOD(extack,
> +			   "AF_SPEC info too large, use per-object dumps (e.g. RTM_GETVLAN)");
> +	nlmsg_cancel(skb, nlh);
> +	return -E2BIG;
> +

[Severity: Low]
All three overflow sites share this label, so an oversized
IFLA_BRIDGE_CFM nest also tells userspace to retry with RTM_GETVLAN.

The bridge only registers PF_BRIDGE handlers for the VLAN and MDB commands:

net/bridge/br_vlan.c:
	{THIS_MODULE, PF_BRIDGE, RTM_GETVLAN, NULL, br_vlan_rtm_dump, 0},

There is no RTM_GET* command that dumps CFM MEP config or status; those
attributes are only produced by br_cfm_config_fill_info() and
br_cfm_status_fill_info(), reachable solely from br_fill_ifinfo(), and
include/uapi/linux/rtnetlink.h has no CFM command.  The same applies to the
per-port IFLA_BRIDGE_MST nest, for which RTM_GETVLAN returns only the
indirect per-VLAN state.

Would a per-site message be better here, so the advice matches what the
kernel can actually return?

>  nla_put_failure:
>  	nlmsg_cancel(skb, nlh);
>  	return -EMSGSIZE;
> @@ -654,7 +662,8 @@ void br_info_notify(int event, const struct net_bridge *br,
>  	if (skb == NULL)
>  		goto errout;
>  
> -	err = br_fill_ifinfo(skb, port, 0, 0, event, 0, filter, dev, false);
> +	err = br_fill_ifinfo(skb, port, 0, 0, event, 0, filter, dev, false,
> +			     NULL);
>  	if (err < 0) {
>  		/* -EMSGSIZE implies BUG in br_nlmsg_size() */
>  		WARN_ON(err == -EMSGSIZE);

[Severity: Medium]
This is a pre-existing issue, but it affects the notification behaviour
described in the changelog: on the CFM status notification path the skb can
be too small, so this WARN_ON fires before the new -E2BIG check is reached.

br_cfm_status_fill_info() opens one nest per record:

net/bridge/br_cfm_netlink.c:br_cfm_status_fill_info() {
	...
	tb = nla_nest_start(skb, IFLA_BRIDGE_CFM_MEP_STATUS_INFO);
	if (!tb)
		goto nla_info_failure;
	...
}

and likewise one IFLA_BRIDGE_CFM_CC_PEER_STATUS_INFO nest per peer MEP, but
br_get_link_af_size_filtered() only charges the outer nest plus the child
attributes:

net/bridge/br_netlink.c:br_get_link_af_size_filtered() {
	...
	vinfo_sz += nla_total_size(0);	/* IFLA_BRIDGE_CFM */
	/* For each status struct the MEP instance (u32) is added */
	vinfo_sz += num_cfm_mep_infos *
		    (nla_total_size(sizeof(u32)) ...
	...
}

No nla_total_size(0) is added for the enclosing per-record nests, so the
estimate is 4 bytes short per record.  br_cfm_notify() reaches this path:

net/bridge/br_cfm.c:br_cfm_notify() {
	u32 filter = RTEXT_FILTER_CFM_STATUS;

	br_info_notify(event, port->br, NULL, filter);
}

The deficit grows with the record count while the slack from kmalloc bucket
rounding does not, so for some MEP/peer counts nla_nest_start() fails with
-EMSGSIZE, the "implies BUG in br_nlmsg_size()" WARN_ON triggers and the
notification is dropped instead of taking the new -E2BIG path.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260919134333.49379-1-iprintercanon%40gmail.com
