Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F0D146D77;
	Wed, 17 Apr 2024 15:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713367097; cv=none; b=OfrvZ4oNIk8n228869t+jn5fLhh3pBVLVu3jbdudmYK043aCbckHT4B9Bblic7yXw9poe0kr19C5geV/nAba1RYuEpvxAuEpKWNfqfIoaUzDbmKOpAyDMGdHpbCrycbmWfwX/Ed0MZ422bCOBS8z/8pvRMI9LeMRn3Wwazh+Gk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713367097; c=relaxed/simple;
	bh=YHaVPj+iSuEOyB6ZA3xnahzX1PCRmORtT89CkjQ7/BU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CFoQkHxTHXCIr82GuEPiWiRd8KVJKmPBNcwU5f9zMjWBafp3xCXqleNF+5dvmrCo2rJ5v9vyYvRvk4bFw5wZ0gQRtD4N99zbtGdO3j8SFY25vcBakb+hHzieUgQUOHBjQfP3VMpTCzxoEn5MyS6p3Xn6fIPHwN/9tFWaiHF2pok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jv0wX1H1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jv0wX1H1"
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43HFGrXc022375;
	Wed, 17 Apr 2024 15:18:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=vFsflYqoST0FVYmNY0FM+GujFSx1cOAiMV41fi3PiAQ=;
 b=jv0wX1H1Topyjqsjx5xw8Veh9EEMLY6r+FKZn/uwj/BUT92Bm8lHBSE/ZJlbPPVH2Oyi
 0wIytvCfhmZ+jH78huE2McXwv80WgT2sPOxJIViwENhcSbbgC5BNPRAyd+xe4WVUG3s5
 P/4B+9BfctirQ70slBLxiylbHTJbhnkeNiWsy8Tn8LXFvbxJNqpavXEdZvnDbUWa4zIh
 DlQjgUI813v41gHWn2avRU+J+5J2L1dzAh/nTkrTXVMKXgUbJuSi3DQ8u2+iQ7JuBzsD
 7jjHPE0J+4Ywc2AyzQbXE7TZOVUbhGCIA1YqiybRVYz7dHVwn2qQ82OKzGCssxndbZpG Ww== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xjgx6g03n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 15:18:01 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43HFI0YW025508;
	Wed, 17 Apr 2024 15:18:00 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xjgx6g03d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 15:18:00 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43HExNFf023582;
	Wed, 17 Apr 2024 15:17:59 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xg5cp56sp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 15:17:59 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43HFHuwM39977294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 15:17:58 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 37C865804E;
	Wed, 17 Apr 2024 15:17:56 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 699645803F;
	Wed, 17 Apr 2024 15:17:53 +0000 (GMT)
Received: from [9.171.10.59] (unknown [9.171.10.59])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Apr 2024 15:17:53 +0000 (GMT)
Message-ID: <f614e5fe-29cb-42f5-a02b-b777c043e014@linux.ibm.com>
Date: Wed, 17 Apr 2024 17:17:52 +0200
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
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Zhengchao Shao <shaozhengchao@huawei.com>
Cc: jaka@linux.ibm.com, alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, weiyongjun1@huawei.com, yuehaibing@huawei.com,
        tangchengchang@huawei.com, kuba@kernel.org, edumazet@google.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20240413035150.3338977-1-shaozhengchao@huawei.com>
 <b2573ccf2340a19b6cb039dac639b2d431c1404c.camel@redhat.com>
 <a94de96f-8b18-482c-90e2-7f8584528bc8@linux.alibaba.com>
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <a94de96f-8b18-482c-90e2-7f8584528bc8@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jgDXjJUjAdZnjbZAPbzUCf9MNtWSnraZ
X-Proofpoint-ORIG-GUID: lEFEOn2K2zQADe4HYYnjeTqF0kjUGp9G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_12,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=791 spamscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 mlxscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404170106



On 17.04.24 09:32, Guangguan Wang wrote:
> 
> 
> On 2024/4/16 20:06, Paolo Abeni wrote:
>> On Sat, 2024-04-13 at 11:51 +0800, Zhengchao Shao wrote:
>>> Potential sleeping issue exists in the following processes:
>>> smc_switch_conns
>>>    spin_lock_bh(&conn->send_lock)
>>>    smc_switch_link_and_count
>>>      smcr_link_put
>>>        __smcr_link_clear
>>>          smc_lgr_put
>>>            __smc_lgr_free
>>>              smc_lgr_free_bufs
>>>                __smc_lgr_free_bufs
>>>                  smc_buf_free
>>>                    smcr_buf_free
>>>                      smcr_buf_unmap_link
>>>                        smc_ib_put_memory_region
>>>                          ib_dereg_mr
>>>                            ib_dereg_mr_user
>>>                              mr->device->ops.dereg_mr
>>> If scheduling exists when the IB driver implements .dereg_mr hook
>>> function, the bug "scheduling while atomic" will occur. For example,
>>> cxgb4 and efa driver. Use mutex lock instead of spin lock to fix it.
>>
>> I tried to inspect all the lock call sites, and it *look* like they are
>> all in process context, so the switch should be feasible.
> 
> There exist some calls from tasklet, where mutex lock is infeasible.
> For example:
> - tasklet -> smc_wr_tx_tasklet_fn -> smc_wr_tx_process_cqe -> pnd_snd.handler -> smc_cdc_tx_handler -> smc_tx_pending -> smc_tx_sndbuf_nonempty -> smcr_tx_sndbuf_nonempty -> spin_lock_bh(&conn->send_lock)
> - tasklet -> smc_wr_rx_tasklet_fn -> smc_wr_rx_process_cqes -> smc_wr_rx_demultiplex -> smc_cdc_rx_handler -> smc_cdc_msg_validate -> spin_lock_bh(&conn->send_lock)
> 
> Thanks,
> Guangguan Wang
> Agree! Thank you, Guangguan, for the examples!
If we can verify that this bug exits, we should find other solutions.
>>
>> Still the fact that the existing lock is a BH variant is suspect.
>> Either the BH part was not needed or this can introduce subtle
>> regressions/issues.
>>
>> I think this deserves at least a 3rd party testing.
>>
>> Thanks,
>>
>> Paolo
>>
> 
