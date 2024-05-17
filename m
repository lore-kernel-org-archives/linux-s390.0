Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8446225D9;
	Fri, 17 May 2024 08:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715933734; cv=none; b=K9ZqLFdhYU5zw5QFRz/nFwPDgRBVdSCyhBlbiaCNuZP8Vv2qQLZj67j5EPmJFi3gC+bBWNCxTQ7EJpg3n4k0s7ntVVOWE9a0FieIIQLHE/vmObmeKfNdGuhsHgvyadoqnTR9xjWluw1ABSSsI9m211rfH5ux0EO48WO9k2R8j8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715933734; c=relaxed/simple;
	bh=R9OEpCL9zP8R35Rk+oa5VjpD4ZkZvl5mjjuqMvArp/M=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KCG5weoGw+rHC8zPM6P/D6PlQkKhBBRTA0ucsv6NIv+LhqnvYODnzpG2Yaq2f5JnsOA6n5fBPQVagDCaccUR4fRyTuhGA5jnr7JQbTBCW5hLDq/cM7XF9nlPlgo9xCVEToDn8tB6OQ82gSGvPm2bhVYFvp8syHcmYIsYjuZ0Fts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UAr+wMD0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UAr+wMD0"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44H7pJoO007430;
	Fri, 17 May 2024 08:15:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date : from
 : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=4OWFPEWY+tchyXWv8TrlCTJcHZCtaP/ddCODfvfGJW4=;
 b=UAr+wMD0nzBlb06IqSBx+LUuEbFmxRrjUeagPWaS9gS45H7uA4Djwff3Kxm72TXFE47p
 43oaHvFN9nSAq/UwZdiFWZVH3KYqx41IHKBpc84+QC8eYM9nPOzGX5C74A1O81p/Sh58
 Wq/WLLRSPQD33oh3C74eRrNfU+Hw+W33oG9IVXRuL8l6vUxd96U62spnvcZrQwHuKPN4
 hQbiv6Rbwo0FGByWAiSt3R3FEWOaWmYYJIhovTN7/uOB09+O7qukJbXUJ+iAg3dUNiqr
 Vr6rYEsNTi3B1ereBl4ckRKPkUWQRYaPqfsmFMTYu6j49ArxZ8dk9GcQc7jezPT2zXkS 9g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y630sg37f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 May 2024 08:15:30 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44H8FTnl021927;
	Fri, 17 May 2024 08:15:29 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y630sg37d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 May 2024 08:15:29 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44H7EmZ8020403;
	Fri, 17 May 2024 07:41:15 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y2kd0f08t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 May 2024 07:41:15 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44H7fCiv36635228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 May 2024 07:41:14 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C2D45805B;
	Fri, 17 May 2024 07:41:12 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D997858065;
	Fri, 17 May 2024 07:41:10 +0000 (GMT)
Received: from [9.179.8.72] (unknown [9.179.8.72])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 May 2024 07:41:10 +0000 (GMT)
Message-ID: <c3c13531-f8be-4159-b8df-b316adb2d3fc@linux.ibm.com>
Date: Fri, 17 May 2024 09:41:09 +0200
User-Agent: Mozilla Thunderbird
From: Wenjia Zhang <wenjia@linux.ibm.com>
Subject: Re: some questions about restrictions in SMC-R v2's implementation
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>, jaka@linux.ibm.com,
        kgraul@linux.ibm.com
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <6d6e870a-3fbf-4802-9818-32ff46489448@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <6d6e870a-3fbf-4802-9818-32ff46489448@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yW3G2SbF98EOydOHl2p8gsbuTtD4K99G
X-Proofpoint-ORIG-GUID: Zhv7hmol0_GwjLPyFoY3QVRwI_dcs9bg
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405170064



On 07.05.24 07:54, Guangdong Wang wrote:
> Hi, Wenjia and Jan,
> 
> When testing SMC-R v2, I found some scenarios where SMC-R v2 should be worked, but due to some restrictions in SMC-R v2's implementation,
> fallback happened. I want to know why these restrictions exist and what would happen if these restrictions were removed.
> 

Hi Guangguan and Wen,

please see my answer below.
> The first is in the function smc_ib_determine_gid_rcu, where restricts the subnet matching between smcrv2->saddr and the RDMA related netdev.
> codes here:
> static int smc_ib_determine_gid_rcu(...)
> {
>      ...
>          in_dev_for_each_ifa_rcu(ifa, in_dev) {
>              if (!inet_ifa_match(smcrv2->saddr, ifa))
>                  continue;
>              subnet_match = true;
>              break;
>          }
>          if (!subnet_match)
>              goto out;
>      ...
> out:
>      return -ENODEV;
> }
> In my testing environment, either server or client, exists two netdevs, eth0 in netnamespace1 and eth0 in netnamespace2. For the sake of clarity
> in the following text, we will refer to eth0 in netnamespace1 as eth1, and eth0 in netnamespace2 as eth2. The eth1's ip is 192.168.0.3/32 and the
> eth2's ip is 192.168.0.4/24. The netmask of eth1 must be 32 due to some reasons. The eth1 is a RDMA related netdev, which means the adaptor of eth1
> has RDMA function. The eth2 has been associated to the eth1's RDMA device using smc_pnet. When testing connection in netnamespace2(using eth2 for
> SMC-R connection), we got fallback connection, rsn is 0x03010000, due to the above subnet matching restriction. But in this scenario, I think
> SMC-R should work.
> In my another testing environment, either server or client, exists two netdevs, eth0 in netnamespace1 and eth1 in netnamespace1. The eth0's ip is
> 192.168.0.3/24 and the eth1's ip is 192.168.1.4/24. The eth0 is a RDMA related netdev, which means the adaptor of eth0 has RDMA function. The eth1 has
> been associated to the eth0's RDMA device using smc_pnet. When testing SMC-R connection through eth1, we got fallback connection, rsn is 0x03010000,
> due to the above subnet matching restriction. In my environment, eth0 and eth1 have the same network connectivity even though they have different
> subnet. I think SMC-R should work in this scenario.
> 
The purpose of the restriction is to simplify the IP routing topology 
allowing IP routing to use the destination host's subnet route. Because 
each host must also have a valid IP route to the peer’s RoCE IP address 
to create RC QP. If the IP route used is the same IP Route as the 
associated TCP/IP connection, the reuse of the IP routing topology could 
be achieved. I think it is what the following sentence means in the doc 
https://www.ibm.com/support/pages/system/files/inline-files/IBM%20Shared%20Memory%20Communications%20Version%202_2.pdf

"
For HA, multiple RoCE adapters should be provisioned along with multiple 
equal cost IP routes to the peer host (i.e., reusing the TCP/IP routing 
topology).
"
And the "Figure 19. SMC-Rv2 with RoCEv2 Connectivity" in the doc also 
mentions the restriction.

The SMCRv2 on linux is indeed implemented with this purpose. Please see 
the function smc_ib_modify_qp_rtr(). During the first contact 
processing, the Mac address of the next hop IP address for the IP route 
is resolved by performing e.g. ARP and used to create the RoCEv2 RC QP. 
If the route is not usable for the RoCE IP address to reach the peer's 
RoCE IP address i.e. without this restriction, the UDP/IP packets would 
not be transported in a right way.

BTW, the fallback would still happen without the restriction. Because at 
the end of the CLC handshake(TCP/IP traffic), the first link will be 
created by sending and receiving LLC confirm message (SMCRv2 traffic). 
If one peer can just send but not receive the LLC confirm message, he 
will send CLC decline message with the reason "Time Out".

Now let's have a look at your examples above. Both of your RDMA related 
device have another IP route as the TCP/IP connection, so that the reuse 
of the IP routing topology is not possible.

Any thought still?

> The other is in the function smc_connect_rdma_v2_prepare, where restricts the symmetric configuration of routing between client and server. codes here:
> static int smc_connect_rdma_v2_prepare(...)
> {
>      ...
>      if (fce->v2_direct) {
>          memcpy(ini->smcrv2.nexthop_mac, &aclc->r0.lcl.mac, ETH_ALEN);
>          ini->smcrv2.uses_gateway = false;
>      } else {
>          if (smc_ib_find_route(net, smc->clcsock->sk->sk_rcv_saddr,
>                smc_ib_gid_to_ipv4(aclc->r0.lcl.gid),
>                ini->smcrv2.nexthop_mac,
>                &ini->smcrv2.uses_gateway))
>              return SMC_CLC_DECL_NOROUTE;
>          if (!ini->smcrv2.uses_gateway) {
>              /* mismatch: peer claims indirect, but its direct */
>              return SMC_CLC_DECL_NOINDIRECT;
>          }
>      }
>      ...
> }
> In my testing environment, server's ip is 192.168.0.3/24, client's ip 192.168.0.4/24, regarding how many netdev in server or client. Server has special
> route setting due to some other reasons, which results in indirect route from 192.168.0.3/24 to 192.168.0.4/24. Thus, when CLC handshake, client will
> get fce->v2_direct==false, but client has no special routing setting and will find direct route from 192.168.0.4/24 to 192.168.0.3/24. Due to the above
> symmetric configuration of routing restriction, we got fallback connection, rsn is 0x030f0000. But I think SMC-R should work in this scenario.
> And more, why check the symmetric configuration of routing only when server is indirect route?
> 
That is to check if the IP routing topology is the same on both sides. 
Then I'd like to ask why you use asymmetric routing for your connection? 
 From the perspective of Networking set up, does it make any sense that 
the peers communicate with each other with different IP routing topology?
> Waiting for your reply.
> 
> Thanks,
> Guangguan Wang
> 
