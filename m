Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AF033A9F8;
	Tue,  8 Sep 2026 17:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887091; cv=none; b=PdsoArj1YIpBsxruNYJMsF8qRaDfpKy7Nd8FlNzCSy5XiPUK0M6eLHfkITIPgq44vGnKoP+efXCG9bgdwZBg4zPYNkYLV9UURORsGziT3RKcOQ2BkVXzQR7n43VGLz9iqlCy8h84913iBOvwQm2bmst5jDIDbJ+e7zKJlUA2Ick=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887091; c=relaxed/simple;
	bh=cgxvIR7KZyvUD/UIdueV6Tb4z6fUOJZHD/riDvwewmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UYmQJmKcZa2ARKrr1GJkj7U8rSh6HfXTFAMvBg+NgZ/OjeYKAKrpGRJmgxI2m/5JfYt9gYeUb2E6muZ3keDa3od7UW5yfP0aypfKW9neGLiIuD1W1rylv1dZUtmSRTPLjE6YPrRbQGNUOAan+OzTk6VHU49denT5LcY8NOxTsYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tYLI6ixx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tYLI6ixx"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688F1eJY1268563;
	Tue, 8 Sep 2026 17:04:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=U1n6Rq
	vtplt2mS9BVm+Dv4IDALJSJUvvoeyVX9qlr8Q=; b=tYLI6ixxhf+yeh0BrLhno9
	doRKfHN/RcsdIN5G5GpX08o74dQaPjw9IlrGdlK2Tt5pef+8b9ITp/OXmLCIEkHu
	wxFgPsSa9JNf+dHe5ttq7BB00kGDF+uWIGOaV0ilwsZZivU5I+kC0mkYYef/UKmb
	iFD9Adi8lDyBvGjF+P+d47aOynygzbDzZXHos91f4rl8QJWLRVQxxSC61Ea5ek2h
	7pREcpUUofFZb9ypDSJiW0ExGEUc00a31Xm2JvzvJnjmANLlk3sEjlQHS3/zWwFg
	XgTCpBloS5w52Lbm0x9olNq2nNwKZ8646TGVurniLtNmCJa2AT1ODeuypiscnPFg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbhf0bss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 17:04:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 688GuKrL008756;
	Tue, 8 Sep 2026 17:04:42 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggxwh55ty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 17:04:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 688H4bSE43581938
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Sep 2026 17:04:37 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A46E32004B;
	Tue,  8 Sep 2026 17:04:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 102C020040;
	Tue,  8 Sep 2026 17:04:37 +0000 (GMT)
Received: from [9.111.167.236] (unknown [9.111.167.236])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Sep 2026 17:04:36 +0000 (GMT)
Message-ID: <a5ffb5d2-4509-4e73-af0d-aad4b1cc9412@linux.ibm.com>
Date: Tue, 8 Sep 2026 19:04:36 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] dibs: Avoid inconsistent lockstate warning in
 dibs_lo_move_data()
To: netdev-bot+sashiko@kernel.org
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com,
        sidraya@linux.ibm.com, mjambigi@linux.ibm.com, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
        andrew+netdev@lunn.ch, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, horms@kernel.org
References: <20260904094446.1342654-1-wintera@linux.ibm.com>
 <178887153533.219967.1817289806507440884@kernel.org>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <178887153533.219967.1817289806507440884@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: pJJv20tp77M_bMt11DmhNNlHpvFwY-G-
X-Authority-Analysis: v=2.4 cv=RIaD2Yi+ c=1 sm=1 tr=0 ts=6aa0402b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=TqvEKpW1L8R4wEG_ojMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE4NCBTYWx0ZWRfX6G106RzS9tju
 u6w/DJdzvyoUtIzGCQZWsijUECbDPHuFhWTrkqdaPRsDg4ZWcY07lHfUMF4YjT/Hs36h7PkVOmY
 4QcIKAlFMvgAw+qM/tuXKumQeN3WLAQ=
X-Proofpoint-ORIG-GUID: ghIgFFWfwLroN4Lmvm957VMglJKA_8sH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE4NCBTYWx0ZWRfXxckbs15pHi8s
 kCdpgwCmLWuYJH5cqaVhG8wPPimyM/1HxIv/9AB5R/KYko/zKpm4stK2vAOCZ2/o3i++0AG4rjQ
 cY+86PgIPdS78ZWIZSv9o3BH2kPT7URDUNyR0kEHxaI0kszHd4fOJLkB4Bn539BCnq8CADxBNaz
 8jIQbYSo7bmMgYxOCpyBT/Tc8Tv6ju2/gE38p7nMNxppWJqNCAnx9V5i1na5QpSVU3t31ahpRlt
 vVPFZTB+UJPVJuUCI7dIIz0n7v4B3sID5bKPfATNjgthAtDUj4FwZAbwDXuDt+QzKBBKUPuxioO
 n3B/GuDtJEP/sG+JZFYFCB7BUmp010phXImiv3Rluc9N7YyPepkH15QEk61redswI67Gh9cKYsZ
 pptdBdBNggacQjFxirZlyRyn8G6zv2g8z3PzAl7ukH8gDulL0VtnhNl7rBYYCeaMawWJYl/OOus
 gUEcf7PioKWC9n6AWZw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 adultscore=0 phishscore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080184



On 08.09.26 14:45, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> - [Medium] The patch fixes an observable lockdep "inconsistent lock
>   state" splat produced by the plain spin_lock(&dibs->lock) in…
> 
> --
> 
> Here is the report.
> 
> dibs: Avoid inconsistent lockstate warning in dibs_lo_move_data()
> 
> This converts the plain spin_lock()/spin_unlock() around the
> dibs->subs[]->ops->handle_irq() call in dibs_lo_move_data() to
> spin_lock_irqsave()/spin_unlock_irqrestore(), because the same lock is
> also taken from hardirq context in ism_handle_irq().  The commit message
> notes this is not a real deadlock since dibs_lo devices have no interrupt
> context.
> 
>> diff --git a/drivers/dibs/dibs_loopback.c b/drivers/dibs/dibs_loopback.c
>> index 649e4e375be33..44a2e74c2efcb 100644
>> --- a/drivers/dibs/dibs_loopback.c
>> +++ b/drivers/dibs/dibs_loopback.c
> 
> [ ... ]
> 
>> @@ -267,12 +268,12 @@ static int dibs_lo_move_data(struct dibs_dev *dibs, u64 dmb_tok,
>>  	if (!sf)
>>  		return 0;
>>  
>> -	spin_lock(&dibs->lock);
>> +	spin_lock_irqsave(&dibs->lock, flags);
>>  	client_id = dibs->dmb_clientid_arr[sba_idx];
>>  	s_mask = ror16(0x1000, idx);
>>  	if (likely(client_id != NO_DIBS_CLIENT && dibs->subs[client_id]))
>>  		dibs->subs[client_id]->ops->handle_irq(dibs, sba_idx, s_mask);
>> -	spin_unlock(&dibs->lock);
>> +	spin_unlock_irqrestore(&dibs->lock, flags);
> 
> [Severity: Medium]
> Should this carry a Fixes: tag?  The lockdep splat quoted in the commit
> message is reproducible on shipped kernels, and git blame attributes the
> converted spin_lock()/spin_unlock() pair in dibs_lo_move_data() to:
> 
> cc21191b584c6f ("dibs: Move data path to dibs layer")
> 
> The hardirq-side acquisition of the same lock is in ism_handle_irq()
> (drivers/s390/net/ism_drv.c):
> 
> 	spin_lock(&dibs->lock);
> 
> which matches the {IN-HARDIRQ-W} registration in the report, so the
> warning can be hit by ordinary SMC traffic through
> smc_close_active()->smcd_cdc_msg_send()->smcd_tx_ism_write()->dibs_lo_move_data()
> on a lockdep-enabled kernel.
> 
> The splat also ends with "INFO: lockdep is turned off", so further lock
> checking is lost for the rest of that boot on affected kernels.
> 
> Would adding the following help backporters and stable tooling identify
> which trees need this change?
> 
> Fixes: cc21191b584c6f ("dibs: Move data path to dibs layer")
> 


As mentioned in the commit message the paths reported by lockdep belong to two
different device types (dibs-lo and ism). So not a real deadlock.
So unless lockdep-warnings by themselves warrant a Fixes-tag (?), I think net-next is correct here.

Paolo applied this already to net-next.
For the records: Sahiko identified the right patch to blame.
