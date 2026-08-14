Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4777377A8F;
	Fri, 14 Aug 2026 11:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786705517; cv=none; b=RoBA8j2vTxmFoAMnKdFMabgPj0q/gLCFXkmgCOidB3riJDhSCoYyY/VX6Y4mTtxm2Prd5g3m2YGIcP7DwBQXlhokbb/clFvDJLUaoQJwMIBAtxyg4NFNDuU0u+r+dULEe7J095SY6YERn3hzpxUpKAHfei1B1hLPyEuElNxxzyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786705517; c=relaxed/simple;
	bh=91oadxM4M49fmwrYPu3ckidbTI2XxIuoD3BbuDM8gK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ijxyDzKsEAcSFnI6H0ZP1912nFuPpqKSOgcORDUwhEql/GyVzuyboCeX6dfnBsBG5rMsyFTry0z0LAlGiU8ScwvG44XokMC7lpIWPFC+PY3A31ojv2Gu21SND+T/2SvoQ56KF+Ypg42I/aEFplkpQVPR7TH70/ZqDVqQaWHROLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RPNKI/kO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RPNKI/kO"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EB1ZwI903484;
	Fri, 14 Aug 2026 11:05:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WL8+yR
	KMc6DLY887T0sB8ofwibr3O2oZm+bYrbKXEVU=; b=RPNKI/kOX8xXTouFiCjqU4
	oYXNlWM9fN0oqaTOBZyeRLydudPwxUKVPGTKxw+nTb81JzBm1+OU2URq5jhIJj4S
	H/Vjd2CwxNJQqGzvYwLPi0hpTanFRPg5afoT3muXrRCIG5jCNb5OxagR5ezM41Ct
	3sJobfQ6MtbX9hqJglMJaqrrTLYVunbEVt5nzsx0NBu5cgsl7aDTX+7oKgzOBcnv
	k2XBuR8AejLNFRB2mTMvdc2WGLVYJyxR2vk9I9a0mE+yZXb2UAOchZjF+mmHiIGc
	6q/jq5fJB2Dc9ZEy0P8HjkT8xR6g1IPEvizNzUANOSNEHRg9dLTZRkR6Tk/Ugf1g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9vdar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 11:05:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67EAuHG9028551;
	Fri, 14 Aug 2026 11:05:07 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g1rpv9rbp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 11:05:07 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67EB56bC47120742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 11:05:06 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE7FF58052;
	Fri, 14 Aug 2026 11:05:05 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E91058050;
	Fri, 14 Aug 2026 11:05:01 +0000 (GMT)
Received: from [9.124.209.161] (unknown [9.124.209.161])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 11:05:00 +0000 (GMT)
Message-ID: <343e412c-16b8-4490-b5df-59679222a7c2@linux.ibm.com>
Date: Fri, 14 Aug 2026 16:34:59 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: hash socket only after full initialisation
 in smc_sk_init()
To: sashiko-reviews@lists.linux.dev, Dust Li <dust.li@linux.alibaba.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Hidayath Khan <hidayath@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.vom>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
References: <20260813074315.554926-1-mjambigi@linux.ibm.com>
 <20260814074345.F29311F000E9@smtp.kernel.org>
Content-Language: en-US
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
In-Reply-To: <20260814074345.F29311F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 2WyICCSVN9eehehuzvEGSXxzYIfYS1By
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7ef664 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=tC_9Y1JomW0XG8RL0-4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA4MyBTYWx0ZWRfX2TOoItsQXRTz
 n3Mfd/7KRQld9yAWeGTG8TbgfeTaU5HFeiHdjvk2qEPD3i0CQzubh6uwWJgk144HPNCBlvMGdn0
 LfPq/s+h/WYhSRP6XOcqXPTjPMfKRFb3eybiho49cc1Axo9iFTmKSefsiWJnNE/D+1R3c+Tbdj7
 PuyIcCzaiaWHlqIb2LCW1t6TNuPWG8jWQ0Wcj4p9WY5ODvtp3maLuMdPiBmc2v4oB7383L7aNIJ
 4egrAK7YaDqeqXDL2bs7cgbP6WhhnESO9gbd0LZf/mhXvR32/+hSXCubJB6hU60479FMRU+1LED
 N/Fc5sOOup+r04ZR/SDVGVBuRODrALvqxgl1CYqswrDIx6gPVlz/bbMKFQbyiWJnswwmB57+rvA
 wNhSx+KZOCgGET404GVYqcGLuNCKQR4IVNCj8MY5YzNWzmYtsb9EPopN9r/ps8lNu63xqCGWHAt
 8pt3peScZnJL1f4y3Eg==
X-Proofpoint-ORIG-GUID: d_tEkx5V1HSQWC_0HLEhda3RBz4cqu_Z
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA4MyBTYWx0ZWRfXywzriquNtYv4
 iohT8HYfFM9qHPy3Zvx7UYyCpbA65SnTu6X4lFqjytpmFxoCvs9fKFkI1+3ewjsc47Zi626UR7k
 N2EimHNmgJvTraJ+j6mZyRi4uaFxbUU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1011 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140083



On 14/08/26 1:13 pm, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Data Race and Unsafe Publication leading to TOCTOU NULL pointer dereference in smc_diag_msg_common_fill
> --
> 
> --- Patch [1]: [PATCH net] net/smc: hash socket only after full initialisation in smc_sk_init() ---
> commit 86b5da4b01196842fbdd925890a17242339aa010
> Author: Mahanta Jambigi <mjambigi@linux.ibm.com>
> 
> net/smc: hash socket only after full initialisation in smc_sk_init()
> 
> This commit delays hashing the SMC socket to the end of smc_sk_init() to
> prevent concurrent hash walkers from observing an uninitialized socket.
> 
>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>> index 00403175b7406..5e7560417ec70 100644
>> --- a/net/smc/af_smc.c
>> +++ b/net/smc/af_smc.c
>> @@ -409,13 +409,13 @@ void smc_sk_init(struct net *net, struct sock *sk, int protocol)
>>  				      "sk_lock-AF_SMC", &smc_key);
>>  	spin_lock_init(&smc->accept_q_lock);
>>  	spin_lock_init(&smc->conn.send_lock);
>> -	sk->sk_prot->hash(sk);
>>  	mutex_init(&smc->clcsock_release_lock);
>>  	smc_init_saved_callbacks(smc);
>>  	smc->limit_smc_hs = net->smc.limit_smc_hs;
>>  	smc->use_fallback = false; /* assume rdma capability first */
>>  	smc->fallback_rsn = 0;
>>  	smc_close_init(smc);
>> +	sk->sk_prot->hash(sk);
> 
> [Severity: High]
> This is a pre-existing issue, but does moving the hash here fully protect
> hash walkers from seeing uninitialized socket state?
> 
> Even with this change, the socket is still hashed inside smc_sk_init(),
> which is called by smc_sock_alloc() before caller-level initialization
> completes. For instance, in smc_create():
> 
> net/smc/af_smc.c:smc_create() {
>     ...
> 	sk = smc_sock_alloc(net, sock, protocol);
> 	if (!sk)
> 		goto out;
> 
> 	rc = smc_create_clcsk(net, sk, family);
>     ...
> }
> 
> Because smc_sock_alloc() hashes the socket, it becomes visible to hash
> walkers before smc_create_clcsk() assigns smc->clcsock.
> 
> A similar pattern occurs in smc_clcsock_accept():
> 
> net/smc/af_smc.c:smc_clcsock_accept() {
>     ...
> 	new_sk = smc_sock_alloc(sock_net(lsk), NULL, lsk->sk_protocol);
>     ...
> 	(*new_smc)->clcsock = new_clcsock;
>     ...
> }
> 
> Could this expose the socket to a TOCTOU race in smc_diag_msg_common_fill()?
> 
> That function accesses smc->clcsock locklessly without READ_ONCE():
> 
> net/smc/smc_diag.c:smc_diag_msg_common_fill() {
>     ...
> 	if (!smc->clcsock)
> 		return;
> 	r->id.idiag_sport = htons(smc->clcsock->sk->sk_num);
>     ...
> }
> 
> Since the compiler might reload the pointer after the NULL check, a
> concurrent update to smc->clcsock (either during initialization or when
> smc_clcsock_release() sets it to NULL) could cause a NULL pointer
> dereference.

The TOCTOU race in smc_diag_msg_common_fill() that you identified is
*addressed* by a companion patch ("net/smc: fix clcsock and lgr/lnk
races in smc_diag dump path"[1]). That patch wraps the NULL check and
all clcsock field reads inside mutex_lock(&smc->clcsock_release_lock),
which is the same mutex held by smc_clcsock_release() when it sets
clcsock = NULL. This makes the check and reads atomic with the writer,
closing the TOCTOU.

[1]
https://lore.kernel.org/netdev/20260807081606.3200128-1-mjambigi@linux.ibm.com/

