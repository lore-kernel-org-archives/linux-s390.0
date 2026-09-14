Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F03039CCEA
	for <linux-s390@vger.kernel.org>; Mon, 14 Sep 2026 08:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789375714; cv=none; b=Exic55c1Rv69SoineS3Ydb2bHRFz3VecRcVElIoV3EKahXRUIL2M0Skfsn1k49cdiNv5nW76AyJ7ETw+pbdmlwxLenHHW5o5yvYiho9qTLQrFyXHzGPSCtv9uQ3c2XGdgClWCEe4ve71jzKr6pqRfKVPDsizJm6s/XjjEAwN6zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789375714; c=relaxed/simple;
	bh=R0P/c38iIYnBempsh/B5wBuzkZjvXciuyexnFDMRjPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K7EFOlcOcKG/PNj//VPkIOrCn1LCOH0GSFzjlz0PgQBWZXUic91FaZrLxDg0TcAyQZ4bEX7VnCnHzdLSPbyQ90FxhNQD5YYccRLXd2T4QbSj0Ul29naOzo9OjLBuusQgrl6fKItW9aSRIvCSattPaPEuHZaiWfquwv8MQkPsW6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=KZKeXM8L; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="KZKeXM8L"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f89so780635f8f.3
        for <linux-s390@vger.kernel.org>; Mon, 14 Sep 2026 01:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1789375710; x=1789980510; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0kvizxDrpk0j6xDj6aqJhobOa++7+JeUcG4npstg5E8=;
        b=KZKeXM8LcUp5K9+4DuPysBsci5VmQYi0iEfPg2+Jgm+n5r40Rv5zZbHnGDXVgk6LV5
         j6JQ6ra7NHEL2OMqwvkV9lMaW89WoN6mRWmbFx3vSTEJYL5dqsBr5hErHPgZAxq7+L8a
         q5x4l+ADOYlPbYXnP5JoYeMnlbrhjQb6tJDuNvEERuzT7OOIdt474xdW1HabpF/bdqYM
         y5d8BvR2SgioWykSJQM8w/xMqMnx5V6gSn9shrZrkUTOQ2mxUCPTer7+weK/o6z2H1NF
         OtquY4I8kvqMzMGz1HHIl9o+Ch2LXW8yg1Qv5vTWEIUE0QTHk0sJ/zUBD6i8TPy80Bxs
         l2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789375710; x=1789980510;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0kvizxDrpk0j6xDj6aqJhobOa++7+JeUcG4npstg5E8=;
        b=PDlpHTSHXAwxcbh9XQ61tK6g4VCzJjAHUG2m7ChXS1pACFnu8bDQnLp9N1iQEffUgR
         0rX6t+9U1r+DcW23zX0hGxe/qLONC+IJHKWw9XftWpN/Z05FN26lUUwCRoytg5eDZn8z
         79OaU56301BeUu9YLn0XIQnhRppsuzJ4zA36UzYG4cT3SAvGQ5oeyM/sx5yMK/f9o68J
         CNLmJAyVDFjysil4P7jvWLWZyRGV4OTyJGRxQ/ARZO6G4pwanZ/YBhNyFCiRHRkZoT9p
         f+ib7zEevLCfTwDfZG8TFEBPiDfK0lHxPNnMxA1X/Ktr6za5mLSBNx5BNCzs8ddJRhum
         WYRg==
X-Forwarded-Encrypted: i=1; AKwUvBzjPvHpYg2I1nK+NLtC+Zox0mR0PyvdT5ti56wc/ozQqYADkzwThvSooMPkfoT3YSCyey+NU/f+ZPQI@vger.kernel.org
X-Gm-Message-State: AFuF++nqTQvpM8nyTOQfum1GCMBRiQjDQm7z5RHYHQ547OBi2p+D7DPb
	gg1sdiGMKcoC2yq39phMdGTOA2C3wFgnmZVBl9QdtA9Sr+DXKoMlWQ+6d4bgNlU03NA=
X-Gm-Gg: AYBFou3lEfROGeLS+gROpJIrzNQmWd6rwEFXiHpIpYrZfWecaxkO37fqNCjn/lWFexx
	1/A3WrM9C1gz7HfvY8lfomgDdZU+a29wBliBdHc/TuGIfHuB8wqdJPLzuynTlc7jATgYhdunaQt
	wDzpYa8BJza2YgLHRDhUwOL3s8pz0+0FXSSAvMS/SJbRAVBztyqKEQoxNu1kizgRw8BP1P8yQde
	lI4PSeUPhBHiyHTQKGLE7AapDLbqUS+HuefyUQz7RjXsHUNzbcqXKxi7nmgO6f1u46ut08A9g9w
	VE6sJbXjMkY69rMY/zVFfFFDsXfCB6op3rz5TORsPDixkVM8veqvczZtNMb6SAhzu29anYkQQDu
	0ZlYNeO4P4nihlsrRfB55wt8tLmldP0rzFvoGHMxqo1ctEp4F6Z+mfbDsKcXdBpMdRA2xa0rbUH
	ZS6puNby67POSN2nKufWzJGO8+MGvKOEoqC4wUJDyh9qf5BBMKzAgC1K26Rks60OeuIKvRATGWq
	bJmJbGS/4baC50kgr5zx7lJVtiqDQ==
X-Received: by 2002:a05:6000:41eb:b0:484:42d5:e6d5 with SMTP id ffacd0b85a97d-48702a9a973mr1744558f8f.11.1789375710548;
        Mon, 14 Sep 2026 01:48:30 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb33fd3bsm25823507f8f.19.2026.09.14.01.48.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 01:48:30 -0700 (PDT)
Message-ID: <2ce01033-a121-4d50-b629-f35e789a4743@blackwall.org>
Date: Mon, 14 Sep 2026 11:48:28 +0300
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net: bridge: fail link info that does not
 fit the IFLA_AF_SPEC nest
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
References: <20260912135022.1701-1-iprintercanon@gmail.com>
 <20260912135022.1701-3-iprintercanon@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260912135022.1701-3-iprintercanon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/09/2026 16:50, Artem Lytkin wrote:
> br_fill_ifinfo() puts all of a port's VLAN, tunnel and MST entries into
> one nest, and nla_len is a u16, so a large enough port produces a nest
> whose length wraps and userspace reads garbage.
> 
> Cancel the message and return -E2BIG with an extack pointing at
> RTM_GETVLAN instead. The dump retries the port with an empty skb and
> the error goes to userspace; notifications reach rtnl_set_sk_err() and
> listeners resync. Not -EMSGSIZE, since no bigger buffer would help.
> 
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
> ---
>   net/bridge/br_netlink.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 

This patch seems incomplete, it doesn't fix the same problem for MST and CFM.
They both can use the same helper - nla_nest_end_safe().
More below...

> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index 855a46aec3a89..53676df9e4d11 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -459,7 +459,7 @@ static int br_fill_ifinfo(struct sk_buff *skb,
>   			  const struct net_bridge_port *port,
>   			  u32 pid, u32 seq, int event, unsigned int flags,
>   			  u32 filter_mask, const struct net_device *dev,
> -			  bool getlink)
> +			  bool getlink, struct netlink_ext_ack *extack)
>   {
>   	u8 operstate = netif_running(dev) ? READ_ONCE(dev->operstate) :
>   					    IF_OPER_DOWN;
> @@ -613,6 +613,12 @@ static int br_fill_ifinfo(struct sk_buff *skb,
>   
>   done:
>   	if (af) {
> +		if (skb_tail_pointer(skb) - (unsigned char *)af > U16_MAX) {

here you can use nla_nest_end_safe()

> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "VLAN information does not fit in one message, use RTM_GETVLAN");
> +			nlmsg_cancel(skb, nlh);
> +			return -E2BIG;
> +		}
>   		if (nlmsg_get_pos(skb) - (void *)af > nla_attr_size(0))

while here you can just change this to if !nla_len(af) nla_nest_cancel()

Also add a common label and goto it from all errors e.g:
nla_nest_too_large:
   	nlmsg_cancel(skb, nlh);
   	return -E2BIG;
>   			nla_nest_end(skb, af);
>   		else
> @@ -654,7 +660,8 @@ void br_info_notify(int event, const struct net_bridge *br,
>   	if (skb == NULL)
>   		goto errout;
>   
> -	err = br_fill_ifinfo(skb, port, 0, 0, event, 0, filter, dev, false);
> +	err = br_fill_ifinfo(skb, port, 0, 0, event, 0, filter, dev, false,
> +			     NULL);
>   	if (err < 0) {
>   		/* -EMSGSIZE implies BUG in br_nlmsg_size() */
>   		WARN_ON(err == -EMSGSIZE);
> @@ -693,7 +700,7 @@ int br_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>   		return 0;
>   
>   	return br_fill_ifinfo(skb, port, pid, seq, RTM_NEWLINK, nlflags,
> -			      filter_mask, dev, true);
> +			      filter_mask, dev, true, extack);
>   }
>   
>   static int br_vlan_info(struct net_bridge *br, struct net_bridge_port *p,

