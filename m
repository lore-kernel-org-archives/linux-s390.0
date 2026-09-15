Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A084C9543;
	Tue, 15 Sep 2026 18:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789498319; cv=none; b=RfcaQtKP7+Kan5UIdOyJPPLTaPDu6rK7i3mlV59vpBw9SMezvq56Piw72ud+5v6S3q6GB9zQ6fl5F2IiLYdPG6XoniQyI5CPky0y/EDE9JCT5l6xc19ttdZf3979lPeCv/6Egoy2R/5BtZgkXgD6igLrCl2lHIa16N2/Z+suqqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789498319; c=relaxed/simple;
	bh=4pxf8aIjib0BRZxZRH4FGi8jsaJE+JnA3k+xYag0u28=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nwMEADnGpWxGFyKQIYlnry6jJPfS+bQJTSN/9c477+/EpCRDoNVB/MxuscN0PrVs6gSm/hiE0va/7noAXKxLE6Uywl8YBGjbFP6bZKQybR7pdoYYyG5OSi6hg9J3sMBmkgmQ1DG8tDjn9GyqJ5tcWohNjCxrPHuxX8Ys/8219YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvOpH985; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvOpH985"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4C51F000FF;
	Tue, 15 Sep 2026 18:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789498317;
	bh=6Zd0kC+Yy9Ng843KwX37t61erK5Sw7cuOKPZQI6ppzc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IvOpH985U8Dx0YGCxtSn8aHcEX1CsCN7dkKQBfKqsCUJxJaSEMSDxOtT9GEI/HLAH
	 r+Li9ccW37WAm4wjjstzLwP1TJ3US4KKO4u5/3MoMxyN+VwcUuZQpVsZLd0W5oFS1k
	 PTRavUfay78CMXmlR5BBpInf71aJP9vbFfUWDobmsq5ntitzBLSbkGpUJkbdOUCJAI
	 a8yE97PKje1S1hWktfvA1Cf82YQuZIQVK/43roT41GIyGdIIRemo4wMlh4JvQe/OOs
	 abuuKhaDqjTv8/0TM5HJBjnYbahUulcKROHkrQ8vjMSehqWVR+XiB5S0D/V8+g69LM
	 lAjlNHyYU5nWw==
Subject: Re: [PATCH net-next v2 2/2] net: bridge: fail link info that does not
 fit the IFLA_AF_SPEC nest
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
Date: Tue, 15 Sep 2026 18:51:55 +0000
Message-ID: <178949831579.22033.2772389608829417270@kernel.org>
In-Reply-To: <20260912135022.1701-3-iprintercanon@gmail.com>
References: <20260912135022.1701-3-iprintercanon@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 1 · Low: 1

- [High] Incomplete bounds check: the new U16_MAX guard only measures the
  outer IFLA_AF_SPEC nest and only runs at the 'done:' label, i.e. after…
- [Medium] Returning -E2BIG from br_fill_ifinfo()/br_getlink() aborts the
  whole RTM_GETLINK/AF_BRIDGE dump at the offending device:…
- [Low] The patch changes user-visible behaviour to fix a data-corruption
  bug (the commit message itself says 'a large enough port produces a…

--

net: bridge: fail link info that does not fit the IFLA_AF_SPEC nest

br_fill_ifinfo() now measures the IFLA_AF_SPEC nest at the done: label and,
if the accumulated payload exceeds U16_MAX, cancels the message and returns
-E2BIG with an extack.  An extack argument is threaded into br_fill_ifinfo()
from br_getlink(), while br_info_notify() passes NULL.

A couple of questions on the placement of the check and on the resulting
dump behaviour.

First, on the commit message trailers:

>     Assisted-by: Claude:claude-opus-5
>     Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>

[Severity: Low]
The commit message describes a user-visible corruption ("a large enough port
produces a nest whose length wraps and userspace reads garbage"), but there
is no Fixes: tag.  Should one be added naming the commit that first made more
than 64 KiB of IFLA_AF_SPEC content possible, for example the per-VLAN
tunnel-info netlink support or the IFLA_BRIDGE_MST support, so that stable
tooling picks this up and the affected range is clear?

Also, Assisted-by: is not one of the documented trailers.

> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index 855a46aec3a89..53676df9e4d11 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c

[ ... ]

> @@ -613,6 +613,12 @@ static int br_fill_ifinfo(struct sk_buff *skb,
>  
>  done:
>  	if (af) {
> +		if (skb_tail_pointer(skb) - (unsigned char *)af > U16_MAX) {
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "VLAN information does not fit in one message, use RTM_GETVLAN");
> +			nlmsg_cancel(skb, nlh);
> +			return -E2BIG;
> +		}

[Severity: High]
Does this check come too late to cover the inner nests?

The MST and CFM nests are closed earlier in br_fill_ifinfo(), before control
reaches done:

net/bridge/br_netlink.c:br_fill_ifinfo() {
	...
		err = br_mst_fill_info(skb, vg);
		if (err)
			goto nla_put_failure;

		nla_nest_end(skb, mst_nest);
	}

done:
	if (af) {
		if (skb_tail_pointer(skb) - (unsigned char *)af > U16_MAX) {
	...
}

and nla_nest_end() both warns and performs the truncating store:

include/net/netlink.h:nla_nest_end() {
	unsigned long diff = skb_tail_pointer(skb) - (unsigned char *)start;

	DEBUG_NET_WARN_ON_ONCE(diff > U16_MAX);
	start->nla_len = diff;
	...
}

Can IFLA_BRIDGE_MST alone exceed 65535 bytes?  br_mst_fill_info() emits one
roughly 20 byte IFLA_BRIDGE_MST_ENTRY per distinct MSTI, with no aggregate
size accounting:

net/bridge/br_mst.c:br_mst_fill_info() {
	list_for_each_entry(v, &vg->vlan_list, vlist) {
		if (test_bit(v->brvlan->msti, seen))
			continue;

		nest = nla_nest_start_noflag(skb, IFLA_BRIDGE_MST_ENTRY);
	...
}

With up to 4094 distinct MSTIs that is roughly 82 KB, and the same applies to
IFLA_BRIDGE_CFM where each peer-MEP status entry is roughly 76 bytes.  The
dump skb is sized from br_get_link_af_size_filtered() via rtnl_calcit() into
cb->min_dump_alloc, which is a u32 with no 64 KiB cap, so the oversized nest
is actually written out.

So for the inner nests the wrapped nla_len is still stored, and on
CONFIG_DEBUG_NET kernels the DEBUG_NET_WARN_ON_ONCE fires from an ordinary
unprivileged RTM_GETLINK/AF_BRIDGE dump.  Would the size have to be bounded
while each nest is being filled, rather than once after the whole message has
been serialized?

[Severity: Medium]
Does returning -E2BIG here stop the rest of the dump?

The chain is rtnl_bridge_getlink() -> br_getlink() -> br_fill_ifinfo(), and
rtnl_bridge_getlink() treats any negative error other than -EOPNOTSUPP as
terminal for the whole walk:

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
	err = skb->len;
out_err:
	rcu_read_unlock();
	cb->args[0] = idx;
}

Since idx is not incremented for the failing device, cb->args[0] still points
at it on the retry round.  That round starts with skb->len == 0, so it takes
goto out_err and the dump ends with -E2BIG.  Are all ports after the
offending one then never enumerated, and does every subsequent dump fail at
the same device again?  Before the patch the same configuration produced one
message with a wrapped AF_SPEC length but the walk continued.

The commit message says only that "the error goes to userspace"; should it
mention that the remainder of the dump is dropped?

On the extack text: the same overflow is reachable for a request that sets
only RTEXT_FILTER_MST or only RTEXT_FILTER_CFM_CONFIG / RTEXT_FILTER_CFM_STATUS,
where no VLAN data is emitted at all and RTM_GETVLAN is not a substitute.
Could the message be made specific to what actually overflowed?

>  		if (nlmsg_get_pos(skb) - (void *)af > nla_attr_size(0))
>  			nla_nest_end(skb, af);
>  		else

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260912135022.1701-1-iprintercanon%40gmail.com
