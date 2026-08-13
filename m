Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1371F351C2E;
	Thu, 13 Aug 2026 07:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786606410; cv=none; b=Tmzl556IxJm3BspmQq6uvI/tc+8YEqki9orCER1TKX91+y6WOjT7fDlvo/xyi7tvt+N2+KzwlPITjVYVWuaV/6c8kIfziogLjT5OqQ/zqO7ivCXk3UyXD8HGbuJxU7am8ljyG38GjiAacQZXSOkeNqYdAdK1FbUWzNo9o5BO8qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786606410; c=relaxed/simple;
	bh=D75FCIsLHoCiSTdJz8Ftw1gSuvzMU0+M3dXekbyGWfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p5FPsWM5UTjsm5esxJ1P/pp0W4YROKWdmc4E7pZ8wmi8z6HjZXbMOYF+ZxPypj2w1tj6VTvdm6loLfLREeEZm9Qfjfx2cQplD8K3jDarBvLKrdwO+rhSoUPe3X7cUI0lAOuN6rannk4yaCRR+Pn5BLTuDciruOlSy79UKrJfQ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oh5ltDzp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oh5ltDzp"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D61dKB1476581;
	Thu, 13 Aug 2026 07:33:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=e376Hn
	ZrdXmxktYumOwabrviuBeSHBQHoPF6kMTmMiE=; b=oh5ltDzpN5hnbj/AEDhEVR
	fluMhr8j8PqaidLwDuJwhaenLf/YFXlqDJowvhFlNwpJYkPhN80Yrh+6jUHXbjRc
	BBVHiULMIFfr+7DhBEYYgkZg0Vt9/ha68isS76WSnJK+EewIjsGaUn+jhsfO8+qd
	/AC/cVufyvG0iajMNnbRAqTc1phVDIoYG5scXPFOYKpD/TlgA480Q0UGao4zAOCQ
	61++KeiPlCdaXkPB+BTyQ8HJEEHxnG+DpfudVxuzZps1FnbEVYGPKXN0G8+D9BLh
	oCQmSfyuxvGDqG1uFodjKz/GlCvcOv0ivfIjLmPDDPr2Ju9wxm8k54OoBe4+N1rg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9prr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 07:33:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67D7QKsZ028838;
	Thu, 13 Aug 2026 07:33:26 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5wa5eq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 07:33:26 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67D7XPYe8651272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2026 07:33:25 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 37B4958060;
	Thu, 13 Aug 2026 07:33:25 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2028D58059;
	Thu, 13 Aug 2026 07:33:20 +0000 (GMT)
Received: from [9.124.209.227] (unknown [9.124.209.227])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Aug 2026 07:33:19 +0000 (GMT)
Message-ID: <b27c85b8-2adb-4a2d-b2f1-573b31cc3f3d@linux.ibm.com>
Date: Thu, 13 Aug 2026 13:03:17 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net/smc: fix clcsock and lgr/lnk races in smc_diag
 dump path
To: sashiko-reviews@lists.linux.dev, "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        Hidayath Khan <hidayath@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Aswin Karuvally <aswin@linux.ibm.com>,
        Nagamani PV <nagamani@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        netdev@vger.kernel.org
References: <20260807081606.3200128-1-mjambigi@linux.ibm.com>
 <20260808081643.35CA11F000E9@smtp.kernel.org>
Content-Language: en-US
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
In-Reply-To: <20260808081643.35CA11F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Rn_uyjMGkMRjPD5Vi4iTYsctvM_T7c72
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7d7348 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=ampr95YJykbg-QaUuO8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA1MSBTYWx0ZWRfXykFFhAb3XW6p
 ZdPxn5ndCcF4hYXko52tF8+Ro9w4LIF1qViFCk3/emLaTg7o6/oqXimx6vzXgBhXwmFr9k7B3Zq
 8+e+9xDKqvBkfCu3ptWnupe9mKSi4L23Q2FZP8GeoyuoyZ6+116t4epqRP2MsTJgzPgG39bMaI5
 tk/3WBamX+m6OePTfXG/R7zcJvtmSZrmhiWhmvZCrW6/5aNN4UNxeAZ7SlP2luKU3FEvr0CMkm3
 5awWWJpqGnX64UbF2o4kEXpC3n0CCa2/CPFkkTsKfLU45Nr82iRUWu+qOjZs8WNesh8rVIUqDXG
 N2H8MRlV0TwQdV6/JPo4IAXEpsvs/pi8nRc88Vjq1Pg4+ZedAUZ/ysXIOkzL4QByGDvNb7OlH8A
 QM0kq/kbrr2mw9VAHzBtbE+wZUx6Sd1DamekOu7sR1GaH56KhrI0gefV+sPRY0fCwRpwmMWaXjC
 6S9vERiZJIPi0MFj1Kg==
X-Proofpoint-ORIG-GUID: iDFG36-NGPsyw82UH4K-0U-a2jjQrRtZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA1MSBTYWx0ZWRfX6pTXE7J2CYDz
 +UV1nPsVOIyNNol4eC70aRPZ6GgLNaq2jsitKjRx0Fh7cAmXwD7PjBxAevWls0CAfETFXFOEM0Y
 CyR9h59CH5raWnq8rNdF6b5EHKTGkUI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1011 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130051



On 08/08/26 1:46 pm, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] Dropping the hash lock per-socket and unconditionally restarting the list walk from the head using a logical index introduces O(N^2) list traversal complexity and causes active sockets to be skipped in the diag dump.
> 
> Pre-existing issues:
> - [Critical] The patch attempts to fix a Use-After-Free race on `smc->clcsock` by adding `clcsock_release_lock` in `smc_diag_msg_common_fill()`, but misses a concurrent teardown path in `smc_accept_dequeue()` that frees the socket without acquiring the mutex.
> --
> 
> --- Patch [1]: [PATCH net v3] net/smc: fix clcsock and lgr/lnk races in smc_diag dump path ---
> commit a16d6de2c1851166c340508a037e5292d66a0907
> Author: Mahanta Jambigi <mjambigi@linux.ibm.com>
> 
> net/smc: fix clcsock and lgr/lnk races in smc_diag dump path
> 
> This commit attempts to fix two races in the SMC diag dump path by holding
> clcsock_release_lock in smc_diag_msg_common_fill() and lock_sock() in
> __smc_diag_dump(). It also modifies the dump iteration to pin sockets, drop
> the hash lock, and restart the traversal from the head of the list.
> 
>> diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
>> index bf0beaa23bdb6..72d77360e504f 100644
>> --- a/net/smc/smc_diag.c
>> +++ b/net/smc/smc_diag.c
>> @@ -39,22 +39,34 @@ static void smc_diag_msg_common_fill(struct smc_diag_msg *r, struct sock *sk)
>>  	memset(r, 0, sizeof(*r));
>>  	r->diag_family = sk->sk_family;
>>  	sock_diag_save_cookie(sk, r->id.idiag_cookie);
>> -	if (!smc->clcsock)
>> -		return;
>> -	r->id.idiag_sport = htons(smc->clcsock->sk->sk_num);
>> -	r->id.idiag_dst[0] = smc->clcsock->sk->sk_daddr;
>> +	/*
>> +	 * smc_clcsock_release() sets smc->clcsock = NULL under
>> +	 * clcsock_release_lock before freeing the socket. Hold the same
>> +	 * mutex here to make the NULL check and all field reads atomic
>> +	 * with that writer. mutex_lock() is safe: this function is called
>> +	 * only after the hash spinlock has been dropped by
>> +	 * smc_diag_dump_proto().
>> +	 */
>> +	mutex_lock(&smc->clcsock_release_lock);
>> +	if (smc->clcsock) {
>> +		r->id.idiag_sport = htons(smc->clcsock->sk->sk_num);
> 
> [Severity: Critical]
> This is a pre-existing issue, but does this mutex fully protect against
> concurrent teardowns?
> 
> Looking at smc_accept_dequeue() in net/smc/af_smc.c, if an unaccepted socket
> is closed (SMC_CLOSED), it unhashes it and frees isk->clcsock without holding
> clcsock_release_lock or the child's socket lock:

I'll address this issue separately as this is a pre-existing one.

> 
> net/smc/af_smc.c:smc_accept_dequeue() {
>     ...
>     if (new_sk->sk_state == SMC_CLOSED) {
>         new_sk->sk_prot->unhash(new_sk);
>         if (isk->clcsock) {
>             sock_release(isk->clcsock);
>             isk->clcsock = NULL;
>         }
>     ...
> }
> 
> If the netlink diag dump thread concurrently iterates the hash table, grabs
> the socket reference, and calls smc_diag_msg_common_fill(), could it acquire
> the mutex, see a non-NULL clcsock, and dereference it while it is being freed
> by smc_accept_dequeue()?
> 
> [ ... ]
> 
>> @@ -204,25 +228,43 @@ static int smc_diag_dump_proto(struct proto *prot, struct sk_buff *skb,
>>  	int rc = 0, num = 0;
>>  	struct sock *sk;
>>  
>> -	read_lock(&prot->h.smc_hash->lock);
>>  	head = &prot->h.smc_hash->ht;
>> +restart:
>> +	num = 0;
>> +	read_lock(&prot->h.smc_hash->lock);
>>  	if (hlist_empty(head))
>>  		goto out;
>> -
>>  	sk_for_each(sk, head) {
>>  		if (!net_eq(sock_net(sk), net))
>>  			continue;
>>  		if (num < snum)
>>  			goto next;
>> +		/*
>> +		 * Pin sk before dropping the lock. refcount_inc_not_zero()
>> +		 * skips sockets already past their last reference.
>> +		 * smc_unhash_sk() nulls sk->sk_node.next via sk_del_node_init()
>> +		 * so resuming an interrupted sk_for_each() would terminate
>> +		 * early if a socket is unhashed while the lock is dropped.
>> +		 * Restart from head after each unlock, using snum to skip
>> +		 * already-dumped entries.
>> +		 */
>> +		if (!refcount_inc_not_zero(&sk->sk_refcnt))
>> +			goto next;
>> +		read_unlock(&prot->h.smc_hash->lock);
>> +
>>  		rc = __smc_diag_dump(sk, skb, cb, nlmsg_data(cb->nlh), bc);
>> +		sock_put(sk);
>> +
>>  		if (rc < 0)
>> -			goto out;
>> +			goto out_nolock;
>> +		snum = num + 1;
>> +		goto restart;
> 
> [Severity: High]
> Does restarting the list walk from the head using a logical index (snum)
> introduce an O(N^2) list traversal complexity?
> 
> If any previously seen sockets are concurrently unhashed while the lock is
> dropped, could stepping over (num < snum) elements skip active sockets that
> shifted to earlier positions in the list?

I got couple of reviews from Sashiko AI & I have addressed them here.

Q1: O(N²) complexity?

Yes, this is O(N²) in the worst case — on each restart we skip
already-dumped entries from the head. This is an accepted trade-off: the
same pattern is used in inet_diag and unix_diag. The lock cannot be held
across __smc_diag_dump() since it now takes sleeping locks (mutex_lock,
lock_sock), so drop-and-restart is unavoidable. The skip itself is cheap
(counter comparison only), and the SMC hash is small in practice.

Q2: Can sockets shift to earlier positions and get skipped?

No. SMC uses an hlist where new sockets are always inserted at the head
via hlist_add_head(). Removal does not reorder remaining nodes. So a
socket that existed before an unlock cannot move to an earlier position
— its ordinal index across restarts is stable. A socket inserted during
the unlock will appear at position 0 on the next restart and will be
skipped by num < snum, but that is correct and consistent behaviour —
netlink dumps are not guaranteed to be atomic snapshots.


Sashiko AI review ·
https://sashiko.dev/#/patchset/20260807081606.3200128-1-mjambigi@linux.ibm.com?part=1
