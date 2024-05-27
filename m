Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E9716EC0B;
	Mon, 27 May 2024 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716821868; cv=none; b=ECw31iGK2d6niwocYR2iMoChDxMT0/0YmdOCF+xpZGxTa2mJSpD3odsxjbFfbRbJg8SpeHNpYVOny9SU8y9SFulDSwE5AdL9/tewafTsA4wRTgi7O0A4Vdo3fhD8jjGxcowe42kwB7gUyKxepvEkp/n1FzI11fPiyroprLmJE2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716821868; c=relaxed/simple;
	bh=DSVyb03WsY6MrmubRsPQ/zzwuFEdLQJrp5rNkQ6v3RU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tDK0lYOrDEsPryjZ+ALCup3UQ1c0TsoA9Xhpc0mk2V4pD9cRjwYstYy4Ac/nlcE9l9JkD6iq/JdQi9u2U/H2pxrw7eudvrXyoFU5rOJqQHhA8z/CzHWYxDhxV+L0siqbHPZydomCwdgz3bi6iyR4cAtYR2qAvko0WNDI/WM/6dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44REQU4X006904;
	Mon, 27 May 2024 14:57:45 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Dibm.com;_h=3Dcc?=
 =?UTF-8?Q?:content-transfer-encoding:content-type:date:from:in-reply-to:m?=
 =?UTF-8?Q?essage-id:mime-version:references:subject:to;_s=3Dpp1;_bh=3DJio?=
 =?UTF-8?Q?5eHm3gtxkaULLxZ3ZbU3zzLR4VxSRJ6R3MUBoBvc=3D;_b=3DGsxfJ1c9P1m9+C?=
 =?UTF-8?Q?Ygcg5OxeeFzvNzUEXZf8sQA+30PxdEdkB/9U014p0TiuvUMEax5h4F_7C0fV7fY?=
 =?UTF-8?Q?CQtHN5vkOhqs08b42P3Mbcf2zsOkBSq4JVVP0tm0VROb4f115grdwXnekW4Z_34?=
 =?UTF-8?Q?tce57UhRny0IRxhas2wUxyyBfRrSSvIVmcIWpd9L5Fx7zcOd/UCSeOeKCqB/IXZ?=
 =?UTF-8?Q?Ri5_ptz9dm+GP3xXQxdoUZ4qEgtPG7P46TT5n4ahMU9JTNzIOjCPl3EloEOMlhx?=
 =?UTF-8?Q?+DXnuMjDi_dwlG6Ua/BZnYyLCSSGSck74+sRhay+U0P5Qai9zErlWjXrpmPoqLC?=
 =?UTF-8?Q?IT3+8I0glO71VK0_cA=3D=3D_?=
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yctdrg9qb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 14:57:44 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44REviQq026134;
	Mon, 27 May 2024 14:57:44 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yctdrg9q9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 14:57:44 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44RDW0Y0010920;
	Mon, 27 May 2024 14:57:43 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ybw12h5cr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 14:57:43 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44REveuF27460128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 May 2024 14:57:42 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C65D58055;
	Mon, 27 May 2024 14:57:40 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC0CD5803F;
	Mon, 27 May 2024 14:57:38 +0000 (GMT)
Received: from [9.171.19.186] (unknown [9.171.19.186])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 May 2024 14:57:38 +0000 (GMT)
Message-ID: <9be5a19c-1641-4b2e-8dac-d2d715cadd42@linux.ibm.com>
Date: Mon, 27 May 2024 16:57:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: some questions about restrictions in SMC-R v2's implementation
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jaka@linux.ibm.com, kgraul@linux.ibm.com
References: <6d6e870a-3fbf-4802-9818-32ff46489448@linux.alibaba.com>
 <c3c13531-f8be-4159-b8df-b316adb2d3fc@linux.ibm.com>
 <38c8a10a-339f-402e-836b-baf38994c7b2@linux.alibaba.com>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <38c8a10a-339f-402e-836b-baf38994c7b2@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SeXxcM7pNGsNDAB_CnNMXtQk9jwcZr1I
X-Proofpoint-ORIG-GUID: 4yY_bkcuWgA9rSosyBmVe2hPbRyFQRae
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_04,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405270121



On 21.05.24 12:52, Guangguan Wang wrote:
> 
> 
> On 2024/5/17 15:41, Wenjia Zhang wrote:
>>
>>
>> On 07.05.24 07:54, Guangdong Wang wrote:
>>> Hi, Wenjia and Jan,
>>>
>>> When testing SMC-R v2, I found some scenarios where SMC-R v2 should be worked, but due to some restrictions in SMC-R v2's implementation,
>>> fallback happened. I want to know why these restrictions exist and what would happen if these restrictions were removed.
>>>
>>
>> Hi Guangguan and Wen,
>>
>> please see my answer below.
>>> The first is in the function smc_ib_determine_gid_rcu, where restricts the subnet matching between smcrv2->saddr and the RDMA related netdev.
>>> ...
>>>
>> The purpose of the restriction is to simplify the IP routing topology allowing IP routing to use the destination host's subnet route. Because each host must also have a valid IP route to the peer’s RoCE IP address to create RC QP. If the IP route used is the same IP Route as the associated TCP/IP connection, the reuse of the IP routing topology could be achieved. I think it is what the following sentence means in the doc https://www.ibm.com/support/pages/system/files/inline-files/IBM%20Shared%20Memory%20Communications%20Version%202_2.pdf
>>
>> "
>> For HA, multiple RoCE adapters should be provisioned along with multiple equal cost IP routes to the peer host (i.e., reusing the TCP/IP routing topology).
>> "
>> And the "Figure 19. SMC-Rv2 with RoCEv2 Connectivity" in the doc also mentions the restriction.
>>
>> The SMCRv2 on linux is indeed implemented with this purpose. Please see the function smc_ib_modify_qp_rtr(). During the first contact processing, the Mac address of the next hop IP address for the IP route is resolved by performing e.g. ARP and used to create the RoCEv2 RC QP. If the route is not usable for the RoCE IP address to reach the peer's RoCE IP address i.e. without this restriction, the UDP/IP packets would not be transported in a right way.
>>
> 
> Hi, Wenjia
> 
> Thanks for the answer.
> 
> I am clear about the restriction of subnet matching.
> 
>> BTW, the fallback would still happen without the restriction. Because at the end of the CLC handshake(TCP/IP traffic), the first link will be created by sending and receiving LLC confirm message (SMCRv2 traffic). If one peer can just send but not receive the LLC confirm message, he will send CLC decline message with the reason "Time Out".
>>
>> Now let's have a look at your examples above. Both of your RDMA related device have another IP route as the TCP/IP connection, so that the reuse of the IP routing topology is not possible.
>>
>> Any thought still?
>>
>>> The other is in the function smc_connect_rdma_v2_prepare, where restricts the symmetric configuration of routing between client and server. codes here:
>>> ...
>>> In my testing environment, server's ip is 192.168.0.3/24, client's ip 192.168.0.4/24, regarding how many netdev in server or client. Server has special
>>> route setting due to some other reasons, which results in indirect route from 192.168.0.3/24 to 192.168.0.4/24. Thus, when CLC handshake, client will
>>> get fce->v2_direct==false, but client has no special routing setting and will find direct route from 192.168.0.4/24 to 192.168.0.3/24. Due to the above
>>> symmetric configuration of routing restriction, we got fallback connection, rsn is 0x030f0000. But I think SMC-R should work in this scenario.
>>> And more, why check the symmetric configuration of routing only when server is indirect route?
>>>
>> That is to check if the IP routing topology is the same on both sides. Then I'd like to ask why you use asymmetric routing for your connection? From the perspective of Networking set up, does it make any sense that the peers communicate with each other with different IP routing topology?
> 
> I have looked into the configuration of my testing environment's routing table and found that the configuration can be optimized.
> And the sketch in the attachment used to describe the topology and route configuration of my testing environment.
> After optimizing the route setting, the fallback disappear.
> 
> But why check the symmetric configuration of routing only when server is indirect route is still not clear.
> 
> 
> Thanks,
> Guangguan Wang

The optimized configuration looks much more reasonable to me. Thus, why 
do we need to do the symmetric check when the server is direct route? 
Don't we expect for a direct route on the client's side? If not, I have 
to repeat my question: does it make any sense that the peers communicate 
with each other with different IP routing topology structures, like your 
first version of configuration? If yes, I need convincing argument.

Thanks,
Wenjia
