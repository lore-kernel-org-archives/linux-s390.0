Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96C315B108;
	Fri, 10 May 2024 09:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715334034; cv=none; b=Kk414OE++VZGJ9TMiN4Tj6F2PF1prBKzA1JmNPWQy0FcSshe3g8cSNZIJNUdEEE+NAuqnndPmGD2G+9zc1aNITzgq1p9wgi2dnQ6LNpuJg4S28ok/f5uuR1V3lWOK/8OMUb8NjuOJ13y7+tL98EH5GIdGEUg+OQYGlhlYm4NnRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715334034; c=relaxed/simple;
	bh=VdsdasOmPy4sPsIFhfaAnrSDTw/u9uq15u29olSiUdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UXm6Y9MFSafRlVN6tgzGr52cuLcFanD6gKnj7P9k5JYbWDX0Tl2zyzoUQgbGsQnailiLBG2vHwYp86pvEj+Z6TD7ofI/391DMLfGpKGSpJLRN8Fiv0obnFbtMrNtYliTwn7kR7D5tyCv9ELFMEZEZmX3y+VY3OWuyKRcy2o65OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lXls/VCL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lXls/VCL"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44A9LYuv015356;
	Fri, 10 May 2024 09:40:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=lP6Gw9j5kJ8uGDKLhQswgwChAG7hxrrVGV2JYtdxmP0=;
 b=lXls/VCLGGnP0NhzCz1maWjVNqsqrM3qgWzcIFYljN7N3vFRXCkSEzff73kETXY0OD15
 tt8MRzsTsJs/3A9+183Gyw7GQGmCkzOh6W6dXxFooyrSp4STmoHX1DTJzqhdAWfvY0gc
 TSsafghSRNH8ec37yT4dKgIVDgrsRGeEQ9MDBto5cIxuSWCHkT+RsMeMRHPKBWGiaVsU
 2S27Db2INQZPGMFpv2EEuPSUaeXoLEJglJ10pfxZ9HKjTSKYMS1B9QWvCjV8tru9Oz0n
 i0EZox21mCQqUMRjBsVQUqMicJFjOlfBqQo9YaiJIyltp+1yipg9/JbiO10uXsajLZbb yQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y1gabr5ak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 09:40:30 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44A9eTT5014625;
	Fri, 10 May 2024 09:40:29 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y1gabr5ag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 09:40:29 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44A7i6VH009327;
	Fri, 10 May 2024 09:40:29 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xyshv0e5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 09:40:29 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44A9eQsj48693862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 09:40:28 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6322F5805D;
	Fri, 10 May 2024 09:40:26 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E15D58057;
	Fri, 10 May 2024 09:40:25 +0000 (GMT)
Received: from [9.171.7.235] (unknown [9.171.7.235])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 May 2024 09:40:25 +0000 (GMT)
Message-ID: <ba4c7916-d6c4-44b6-a649-1e17c65e87f9@linux.ibm.com>
Date: Fri, 10 May 2024 11:40:24 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: some questions about restrictions in SMC-R v2's implementation
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>, jaka@linux.ibm.com,
        kgraul@linux.ibm.com
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <6d6e870a-3fbf-4802-9818-32ff46489448@linux.alibaba.com>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <6d6e870a-3fbf-4802-9818-32ff46489448@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7n470_4bm7F81DT2l4dNXbQU2Cra1jiY
X-Proofpoint-ORIG-GUID: L6oY6bi9De9H696zDVCLbvuXILwf6ANJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_06,2024-05-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 suspectscore=0 phishscore=0 mlxscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405100069



On 07.05.24 07:54, Guangguan Wang wrote:
> Hi, Wenjia and Jan,
> 
> When testing SMC-R v2, I found some scenarios where SMC-R v2 should be worked, but due to some restrictions in SMC-R v2's implementation,
> fallback happened. I want to know why these restrictions exist and what would happen if these restrictions were removed.
> 
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
> Waiting for your reply.
> 
> Thanks,
> Guangguan Wang
> 
Hi Guangguan,

Thank you for the questions. We also asked ourselves the same questions 
a while ago, and also did some research on it. Unfortunately, it was not 
yet done and I had to delay it because of my vacation last month. Now 
it's time to pick it up again ;) I'll come back to you as soon as I can 
give a very certain answer.

Thanks,
Wenjia
