Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C53362156;
	Fri, 14 Aug 2026 16:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786726207; cv=none; b=GH94CfNA+G/jzKzUAgykCoy8zQsBsGcMPGVlQWr21SFWZeFGKxoB5MJ+jGEaicVKTPsggs6ePFhBG5d6BHPVLpX9WITqnkKzfIX7vbKKvmeRO5PztAjE9Gv8n03DqSnGx5GLAS6Ex8Lb5uWUghlQhzpx8M2GKPiUYkXeUxVfI6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786726207; c=relaxed/simple;
	bh=bRXqEeLKr3phf1vA0SnjHPx40WaEQOD5BwGayVFF0U0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V34aSQpxeD0tj3fsDjPYGafrGIQYgtJEv2t4JdobpaMEZ1lD/4BP1imQiDY7nc0rJ/IIElnDmDuBcLe8/tRNQfGDvaIAD2z14asgTatdxmxTcYKcF53THZ9wuloTeKLfw61EuSPCCY2RZmXUWdjrk7SJ/s1U6egAW3vq/B/FOmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Wg3Ha/S4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Wg3Ha/S4"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EE617K1248914;
	Fri, 14 Aug 2026 16:49:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5RcuLJ
	5FQiGSy2Z/Gd6iGBMfWiFpVSF55HFh4w9AonE=; b=Wg3Ha/S4PeHcC3QkmyR1ju
	lnEnerBR1HIM59pigTaF6dlDoAUTIDVvJ9M+DYKm44wLn03wAs5Qew5werOvlsJB
	QNN5mjRnrAoe5fBfX3kylYgJ7m5wYolcNkwV/QC9GqT+u+iQ4z7RUDNgesXZFowD
	j+BlettnsjbcKyhU1/MzWxQi/ojnAjjXZ/f9L02W/CZ8y6Yx0T09POOKnr350gV2
	70ZjBnnUSyZ54A1pAHOMetQzUaUclMvn1V9NL+dvbhrYyquAWQyO17zCvITcblt+
	DPO9th5SJ/Z7KT9UYKU+iTD4v6JMUgvl2WODNWrj75MtWcUkWczfRMSU7but6Qqg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp3cknk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 16:49:57 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67EGkYce019607;
	Fri, 14 Aug 2026 16:49:56 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0gqykk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 16:49:56 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67EGntpc51970526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 16:49:55 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D22EF5805C;
	Fri, 14 Aug 2026 16:49:55 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E85FF58051;
	Fri, 14 Aug 2026 16:49:49 +0000 (GMT)
Received: from [9.124.211.136] (unknown [9.124.211.136])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 16:49:49 +0000 (GMT)
Message-ID: <2d3ee7c6-b7f6-46d4-9670-53e36215915b@linux.ibm.com>
Date: Fri, 14 Aug 2026 22:19:48 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: drop the abort_work reference when the work
 is cancelled
To: Jakub Kicinski <kuba@kernel.org>
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com,
        sidraya@linux.ibm.com, mjambigi@linux.ibm.com, andrew+netdev@lunn.ch,
        tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
        pasic@linux.ibm.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
References: <20260806081549.595001-1-hidayath@linux.ibm.com>
 <20260810231913.969204-1-kuba@kernel.org>
Content-Language: en-GB
From: Hidayath Khan <hidayath@linux.ibm.com>
In-Reply-To: <20260810231913.969204-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7f4736 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=CsfcX7A8SnD_svm5:21 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22
 a=jnCOaTOOPObVVso7n2UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ybf7XDQ14n9SRPoVmmLwKIgtWOH-rhgT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDEyNiBTYWx0ZWRfX1qWSTQqXzcF3
 130bmlsfrPxrntV9XxYER/E92kFCSdaPu43083yj9slr83LseFjrTeRSAYlpyXvTjr6fjHIh+fh
 Kq+tb7EjIm3XwLH/xBNynr2zdUZhThr6IQUKT7d55yV2u/Lvdfg4wzy62ZU1FCvrW8vjKgDwcqM
 UEl8qfTUfFXKolMfnmthKqyQG/+P7te+COv6MlX2J/deIZm3nYOa1XGuCKG6Rzey0R8ivV2F2xS
 7H2Rbb0l4toSA/52N7eFjJmGHAaY50INYYqtGmH8Zhw7VlbtJBl+UsmBLxouxIldMUN698//xkJ
 xvW0SKwjOLGLOTfpH/b8GOAuBe3Z4P7ytBhPXO7cJ3vIgUj4CFEdKjl3z+j/sbJb2Q4qwNUXEmG
 EQChu/2y5tUbhBn4m+93dKfx13dRoONOWYdqGKgMhIBmlcGlQSSVqsnxtcAG+3Pe/n5zQr/eyNO
 QNYYHMKHyO4WHBT+BVw==
X-Proofpoint-ORIG-GUID: tZOgH3-ibX9mwaikLvLLyvFAh1iwnlX-
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDEyNiBTYWx0ZWRfX8CiXQmLplXdS
 l6r1IugU4AsSUf5+GaSMQqMVJiomenwM9ICXWxFFx3lt46luMcsStFh4Kk7A0Wnhlgp35SLnSq7
 O7orjhbRZN4shkFsIri/9uaB4PSa05g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140126

Thanks for the review.

All three issues are real, and none of them is fixed by anything 
currently in flight.
I will include this patch in a series against net that fixes all four.

On 11/08/26 4:49 am, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email says "*shiko finds more issues with the work termination here.
> Can you please TAL and fix these all in one series?"
> ---
> net/smc: drop the abort_work reference when the work is cancelled
>
> The patch makes smc_conn_free() drop the socket reference handed to
> conn->abort_work when cancel_work_sync() reports that the work was still
> pending, so the sock_hold() taken by the scheduler of the work is not
> leaked.  It follows the pattern smc_close_cancel_work() already uses for
> conn->close_work.
>
> A few questions about the surrounding cancel logic follow.
>
>> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
>> index b4208cb186c5e..3d4a86d99dd6b 100644
>> --- a/net/smc/smc_core.c
>> +++ b/net/smc/smc_core.c
>> @@ -1252,6 +1252,7 @@ static void smc_buf_unuse(struct smc_connection *conn,
>>   /* remove a finished connection from its link group */
>>   void smc_conn_free(struct smc_connection *conn)
>>   {
>> +	struct smc_sock *smc = container_of(conn, struct smc_sock, conn);
>>   	struct smc_link_group *lgr = conn->lgr;
>>   
>>   	if (!lgr || conn->freed)
>> @@ -1275,8 +1276,13 @@ static void smc_buf_unuse(struct smc_connection *conn,
>>   		tasklet_kill(&conn->rx_tsklet);
>>   	} else {
>>   		smc_cdc_wait_pend_tx_wr(conn);
>> -		if (current_work() != &conn->abort_work)
>> -			cancel_work_sync(&conn->abort_work);
>> +		/* If the work was pending (cancel returns true) it never ran,
>> +		 * so the sock_hold taken by its scheduler was never released.
>> +		 */
>> +		if (current_work() != &conn->abort_work) {
>> +			if (cancel_work_sync(&conn->abort_work))
>> +				sock_put(&smc->sk);
>> +		}
> [Severity: High]
> This isn't a bug introduced by this patch, but can this cancel_work_sync()
> deadlock against a already-running abort_work?
Yes, smc_conn_free() holds the socket lock and
smc_conn_abort_work() takes the same lock, so once the work has started
the cancel waits for the work and the work waits for the caller. The
current_work() test only stops the work cancelling itself, so it does not
help when the two are on different CPUs.  I will drop the lock around the
cancel, the way smc_close_cancel_work() already does for close_work.
>
> The worker takes the socket lock as its first action:
>
> net/smc/smc_core.c:smc_conn_abort_work() {
> 	lock_sock(&smc->sk);
> 	smc_conn_kill(conn, true);
> 	release_sock(&smc->sk);
> 	sock_put(&smc->sk); /* sock_hold done by schedulers of abort_work */
> }
>
> and the callers of smc_conn_free() reach it while holding that same lock:
>
> net/smc/af_smc.c:__smc_release()
> 	lock_sock(sk);
> 	...
> 	if (!smc->use_fallback)
> 		smc_conn_free(&smc->conn);
>
> net/smc/smc_close.c:smc_close_passive_work()  (inside lock_sock(sk))
> 	if ((sk->sk_state == SMC_CLOSED) &&
> 	    (sock_flag(sk, SOCK_DEAD) || !sk->sk_socket)) {
> 		smc_conn_free(conn);
>
> net/smc/smc_close.c:smc_close_active_abort()  (SMC_PEERCLOSEWAIT1/2,
> SMC_PEERFINCLOSEWAIT, SMC_PROCESSABORT, SMC_APPFINCLOSEWAIT)
> 		smc_conn_free(&smc->conn);
>
> So if abort_work has already started on another CPU and is blocked in
> lock_sock(), the closing task holds the socket lock and waits in
> cancel_work_sync() for that worker, which cannot proceed.  The
> current_work() != &conn->abort_work test only covers the case where the
> same task is running abort_work itself.
>
> Note both abort_work and close_work are queued on smc_close_wq, so
> close_work running smc_close_passive_work() can be the blocking canceller.
>
> The commit message cites smc_close_cancel_work() as the model:
>
> 	if (cancel_work_sync(&smc->conn.close_work))
> 		sock_put(sk);
>
> but that helper drops the socket lock around the cancel:
>
> net/smc/smc_close.c:smc_close_cancel_work() {
> 	release_sock(sk);
> 	if (cancel_work_sync(&smc->conn.close_work))
> 		sock_put(sk);
> 	cancel_delayed_work_sync(&smc->conn.tx_work);
> 	lock_sock(sk);
> }
>
> Should the abort_work cancel do the same, and would that change where the
> new sock_put() has to live?
Yes to both.  I will move the cancel into a small helper that drops the
socket lock first, and the sock_put() goes inside that helper, after the
lock is dropped, exactly as in smc_close_cancel_work().
>
> [Severity: High]
> This is a pre-existing ordering issue rather than something the patch adds,
> but does cancel_work_sync() here actually keep abort_work from being
> re-armed?
>
> The cancel happens before smc_lgr_unregister_conn(conn), so the receive
> path can still find the connection:
>
> net/smc/smc_cdc.c:smc_cdc_rx_handler() {
> 	read_lock_bh(&lgr->conns_lock);
> 	conn = smc_lgr_find_conn(ntohl(cdc->token), lgr);
> 	if (!conn || conn->out_of_sync) {
> 		read_unlock_bh(&lgr->conns_lock);
> 		return;
> 	}
> 	smc = container_of(conn, struct smc_sock, conn);
> 	sock_hold(&smc->sk);
> 	read_unlock_bh(&lgr->conns_lock);
>
> and then queue the work again:
>
> net/smc/smc_cdc.c:smc_cdc_msg_validate() {
> 		sock_hold(&smc->sk); /* sock_put in abort_work */
> 		if (!queue_work(smc_close_wq, &conn->abort_work))
> 			sock_put(&smc->sk);
>
> cancel_work_sync() passes cflags 0, so it re-enables the work before
> returning:
>
> kernel/workqueue.c:__cancel_work_sync() {
> 	ret = __cancel_work(work, cflags | WORK_CANCEL_DISABLE);
> 	...
> 	if (wq_online)
> 		__flush_work(work, true);
>
> 	if (!(cflags & WORK_CANCEL_DISABLE))
> 		enable_work(work);
>
> which means a queue_work() issued after the cancel returns succeeds.  The
> freshly queued worker then runs smc_conn_abort_work() -> smc_conn_kill() on
> a connection with conn->freed == 1 whose lgr reference smc_conn_free()
> already dropped, and dereferences conn->lgr:
>
> net/smc/smc_core.c:smc_conn_kill() {
> 	if (conn->lgr->is_smcd && conn->lgr->peer_shutdown)
>
> Would unregistering the connection from lgr->conns_all before cancelling,
> or gating the queueing on conn->freed under conns_lock, close that window?
The first one.  Gating the queue site would need smc_cdc_msg_validate() to
take conns_lock, which it does not do today, and it would not help with the
buffers.

So I will unregister first, then cancel.  The buffer release has to move as
well: cancel_work_sync() waits for a work item that may still start during
the wait, and that item would then run against buffers smc_buf_unuse() had
already returned.  The order becomes unregister, cancel, release.
>
>>   	}
>>   	if (!list_empty(&lgr->list)) {
>>   		smc_buf_unuse(conn, lgr); /* allow buffer reuse */
> [Severity: High]
> This is also a pre-existing problem and not something introduced here, but
> the patch documents smc_conn_free() as the place that disposes of a pending
> abort_work, and one exit path of the function skips that disposal:
>
> net/smc/smc_core.c:smc_conn_free() {
> 	if (!smc_conn_lgr_valid(conn))
> 		/* Connection has already unregistered from
> 		 * link group.
> 		 */
> 		goto lgr_put;
> 	...
> lgr_put:
> 	if (!lgr->is_smcd)
> 		smcr_link_put(conn->lnk); /* link_hold in smc_conn_create() */
> 	smc_lgr_put(lgr); /* lgr_hold in smc_conn_create() */
> }
>
> On that path neither the cancel nor the new sock_put() runs, yet the
> connection's link and link-group references are still dropped, and
> conn->lgr is not reset.  A pending abort_work then dereferences it:
>
> net/smc/smc_core.c:smc_conn_kill() {
> 	if (conn->lgr->is_smcd && conn->lgr->peer_shutdown)
>
> Concretely, a peer sends a CDC message with prod_flags.failover_validation
> and a stale seqno, so smc_cdc_msg_validate() queues abort_work.  Meanwhile
> __smc_lgr_terminate() calls smc_conn_kill(), which does
> smc_lgr_unregister_conn() (clearing alert_token_local) and then
> smc_close_active_abort() -> smc_conn_free(); smc_conn_lgr_valid(conn) is
> now false, so the goto lgr_put path is taken.  __smc_lgr_terminate() then
> calls smc_lgr_free(), whose smc_lgr_put() drops the last reference and
> kfree()s the lgr while abort_work is still queued.
>
> Can the queued abort_work read a freed struct smc_link_group here, and
> should this exit path also cancel the work and return its reference?
Yes to both.  smc_conn_kill() clears alert_token_local through 
smc_lgr_unregister_conn(),
so smc_conn_lgr_valid() is already false when smc_close_active_abort() 
reaches
smc_conn_free(), and the goto lgr_put path skips both the cancel and the
reference.  __smc_lgr_terminate() then frees the link group underneath the
queued work.  I will cancel on that path as well.

I will send the series shortly.

