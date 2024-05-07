Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF356BFB8;
	Tue,  7 May 2024 05:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715061309; cv=none; b=t2VJ+V4Kk5yhv7bjpo5MW8I8q69mRh1y/rNOg/VhBqlWjl2iRvF5twcRrti33GhRhULMZ+u7hQF7PebCGw0T81YQlv3N1WBr2VH3hbK7+r3WwQbbX5p3IOo9d92mLqchibymQXdoSxhqylL71BcQSEOuvmzDPaDHMvbG4ZIvfC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715061309; c=relaxed/simple;
	bh=Pdne6XsnBJ3ITSgD5gyoB3HBz7+wRA143svwnH2aqpE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=ZQ5YuTpJZ6y7QG4ijb0MrhhDRY9u0JQJfSnBQaNe6vUJ8CC1ONtDiAlW/edqI0llPpLFw9kwxalLOrZxBaRsQhaEXy1genJOs8O01N5R4nVpR5G1xJ0mYfo62lZqt4fVEKa2RepqbXtxdzXfFdCANJn5AWW6GirHSKxHmUNJQYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mAitka9r; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mAitka9r"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715061298; h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type;
	bh=ZEG518/BRX8gY2yhcbQUnSzkHiL/oK8UZA07FWoGJIw=;
	b=mAitka9r1iDCfLCMusF/TcuTMVSGdl/f5YDEo592s4OBwiwxhupp5WYn/LPQvNXYMxxcIwhgJcWleCtnI/v5CXckR+99CcOM1svZjuodBSoI7bmqgFQ3HKOLi+o79Nri9rP3NMNPhz43So7lOk/e+IwWMooCfkek0NBia7bzghI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W6.3fpX_1715061296;
Received: from 30.221.101.18(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0W6.3fpX_1715061296)
          by smtp.aliyun-inc.com;
          Tue, 07 May 2024 13:54:57 +0800
Message-ID: <6d6e870a-3fbf-4802-9818-32ff46489448@linux.alibaba.com>
Date: Tue, 7 May 2024 13:54:55 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: wenjia@linux.ibm.com, jaka@linux.ibm.com, kgraul@linux.ibm.com
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Subject: some questions about restrictions in SMC-R v2's implementation
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Wenjia and Jan,

When testing SMC-R v2, I found some scenarios where SMC-R v2 should be worked, but due to some restrictions in SMC-R v2's implementation,
fallback happened. I want to know why these restrictions exist and what would happen if these restrictions were removed.

The first is in the function smc_ib_determine_gid_rcu, where restricts the subnet matching between smcrv2->saddr and the RDMA related netdev.
codes here:
static int smc_ib_determine_gid_rcu(...)
{
    ...
        in_dev_for_each_ifa_rcu(ifa, in_dev) {
            if (!inet_ifa_match(smcrv2->saddr, ifa))
                continue;
            subnet_match = true;
            break;
        }
        if (!subnet_match)
            goto out;
    ...
out:
    return -ENODEV;
}
In my testing environment, either server or client, exists two netdevs, eth0 in netnamespace1 and eth0 in netnamespace2. For the sake of clarity
in the following text, we will refer to eth0 in netnamespace1 as eth1, and eth0 in netnamespace2 as eth2. The eth1's ip is 192.168.0.3/32 and the
eth2's ip is 192.168.0.4/24. The netmask of eth1 must be 32 due to some reasons. The eth1 is a RDMA related netdev, which means the adaptor of eth1
has RDMA function. The eth2 has been associated to the eth1's RDMA device using smc_pnet. When testing connection in netnamespace2(using eth2 for
SMC-R connection), we got fallback connection, rsn is 0x03010000, due to the above subnet matching restriction. But in this scenario, I think
SMC-R should work.
In my another testing environment, either server or client, exists two netdevs, eth0 in netnamespace1 and eth1 in netnamespace1. The eth0's ip is
192.168.0.3/24 and the eth1's ip is 192.168.1.4/24. The eth0 is a RDMA related netdev, which means the adaptor of eth0 has RDMA function. The eth1 has
been associated to the eth0's RDMA device using smc_pnet. When testing SMC-R connection through eth1, we got fallback connection, rsn is 0x03010000,
due to the above subnet matching restriction. In my environment, eth0 and eth1 have the same network connectivity even though they have different
subnet. I think SMC-R should work in this scenario.

The other is in the function smc_connect_rdma_v2_prepare, where restricts the symmetric configuration of routing between client and server. codes here:
static int smc_connect_rdma_v2_prepare(...)
{
    ...
    if (fce->v2_direct) {
        memcpy(ini->smcrv2.nexthop_mac, &aclc->r0.lcl.mac, ETH_ALEN);
        ini->smcrv2.uses_gateway = false;
    } else {
        if (smc_ib_find_route(net, smc->clcsock->sk->sk_rcv_saddr,
              smc_ib_gid_to_ipv4(aclc->r0.lcl.gid),
              ini->smcrv2.nexthop_mac,
              &ini->smcrv2.uses_gateway))
            return SMC_CLC_DECL_NOROUTE;
        if (!ini->smcrv2.uses_gateway) {
            /* mismatch: peer claims indirect, but its direct */
            return SMC_CLC_DECL_NOINDIRECT;
        }
    }
    ...
}
In my testing environment, server's ip is 192.168.0.3/24, client's ip 192.168.0.4/24, regarding how many netdev in server or client. Server has special
route setting due to some other reasons, which results in indirect route from 192.168.0.3/24 to 192.168.0.4/24. Thus, when CLC handshake, client will
get fce->v2_direct==false, but client has no special routing setting and will find direct route from 192.168.0.4/24 to 192.168.0.3/24. Due to the above
symmetric configuration of routing restriction, we got fallback connection, rsn is 0x030f0000. But I think SMC-R should work in this scenario.
And more, why check the symmetric configuration of routing only when server is indirect route?

Waiting for your reply.

Thanks,
Guangguan Wang
