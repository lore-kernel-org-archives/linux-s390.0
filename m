Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D8784D24;
	Mon, 15 Apr 2024 17:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713202657; cv=none; b=pQDm+m4UbqdaYqOl9BAYs7cUHVlANkYg6pYfXmcq+xvrdj5eskLfRaZXDPz57n9tluMd1CLXh4PRuBN5EijU2Q5hjNLngmwlWZq0uVZCiO1R0o1Vfwezd3X3dwJrlex/hfH14Y+9LvuagERdLnbqocVK622HwkQsHOH7TuiBFD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713202657; c=relaxed/simple;
	bh=aRXYP7whVmwGDAAoL4RxJq5dXy/yDUYDAJLbCRKjIv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lmnSMtLqQG/H6OiKknN4UsDFbix8toVvaxoT9frenH6pmZuUJPonKZ4o9iQ7QEByUz5rl4JKNbnHw+0xspB1C7Ekyln8DnB+f5+s2twoAFur8Fe/jH4toNXWZ4Q2pZUsLxrDyB5K0+gasxYtecXdo1L+0I4wWj0JDsBOo2eyhBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f8QTb1Ru; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f8QTb1Ru"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43FHTd7t032517;
	Mon, 15 Apr 2024 17:37:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=giuL7psBnCYmcCNZfVK84ryizKXG50Ihblmwkj3wriw=;
 b=f8QTb1RuyUjHKdTvFgX2dE7EA1EgVPrHkNiroZulh4nqHh3HykkQyUWdconiEhzFGDzk
 noIruYi4krEUsJodLiYHeizRDMUiK7WlEvGAwnVD0HpHJ04xCKqNSkqEhaMMFAOUMF13
 0Mvt7NeZs5FOrg+mSs2sM6R92+vLbP66oCXpsv2wbLMFqGJjOLR4U5zpaEBZvy7JzwUx
 cTFcAMK0AJbRWtOSRklP/Yss6hte0tqkT3yDouT1kipVb2XDc0N4I4a336wS2tg+hCyC
 0Urr+7j8W00KA6KUjBwM4goi+5LevkAoFCXyXPw0DzS6eF4iAzIow3bygupdMDTyjAsw bw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xh8p280k0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 17:37:14 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43FHbDnu012027;
	Mon, 15 Apr 2024 17:37:14 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xh8p280jv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 17:37:13 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43FHUiHA011118;
	Mon, 15 Apr 2024 17:37:13 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xg7328t8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 17:37:13 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43FHbAex29098500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 17:37:12 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FB7158060;
	Mon, 15 Apr 2024 17:37:10 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB51C5804E;
	Mon, 15 Apr 2024 17:37:07 +0000 (GMT)
Received: from [9.171.82.37] (unknown [9.171.82.37])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Apr 2024 17:37:07 +0000 (GMT)
Message-ID: <f664c557-7924-4a75-a782-040cfc23f404@linux.ibm.com>
Date: Mon, 15 Apr 2024 19:37:06 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: fix potential sleeping issue in
 smc_switch_conns
Content-Language: en-GB
To: Zhengchao Shao <shaozhengchao@huawei.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc: jaka@linux.ibm.com, alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, weiyongjun1@huawei.com, yuehaibing@huawei.com,
        tangchengchang@huawei.com
References: <20240413035150.3338977-1-shaozhengchao@huawei.com>
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20240413035150.3338977-1-shaozhengchao@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XTtCLkSoJ02eeTFokA2wyIm50YiP5hc1
X-Proofpoint-GUID: HhPyQvNa9dY9xt4VfAgyIeATCj8gdNQw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_14,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=876
 spamscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404150116



On 13.04.24 05:51, Zhengchao Shao wrote:
> Potential sleeping issue exists in the following processes:
> smc_switch_conns
>    spin_lock_bh(&conn->send_lock)
>    smc_switch_link_and_count
>      smcr_link_put
>        __smcr_link_clear
>          smc_lgr_put
>            __smc_lgr_free
>              smc_lgr_free_bufs
>                __smc_lgr_free_bufs
>                  smc_buf_free
>                    smcr_buf_free
>                      smcr_buf_unmap_link
>                        smc_ib_put_memory_region
>                          ib_dereg_mr
>                            ib_dereg_mr_user
>                              mr->device->ops.dereg_mr
> If scheduling exists when the IB driver implements .dereg_mr hook
> function, the bug "scheduling while atomic" will occur. For example,
> cxgb4 and efa driver. Use mutex lock instead of spin lock to fix it.
> 
> Fixes: 20c9398d3309 ("net/smc: Resolve the race between SMC-R link access and clear")
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
>   net/smc/af_smc.c   |  2 +-
>   net/smc/smc.h      |  2 +-
>   net/smc/smc_cdc.c  | 14 +++++++-------
>   net/smc/smc_core.c |  8 ++++----
>   net/smc/smc_tx.c   |  8 ++++----
>   5 files changed, 17 insertions(+), 17 deletions(-)
> 

Hi Zhengchao,

If I understand correctly, the sleeping issue is not the core issue, it 
looks like a kind of deadlock or kernel pointer dereference issue. Did 
you get crash? Do you have any backtrace? Why do you think the mutex 
lock will fix it?

Thanks,
Wenjia
