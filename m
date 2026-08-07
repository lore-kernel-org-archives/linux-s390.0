Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC11477998;
	Fri,  7 Aug 2026 15:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786117011; cv=none; b=JOcqctkL0QzxtppsMd8xc2zzmzU7MsShXExqW4IZraaKHZkdN9/Hs+5aZQwmNZewq/jesPLDoP9d1mPf045oYc2rxIYxW5gVWcd7mY1zP4QuyNnCQ5ZlYZuZ3ONnkAnCjvDYOax9CSzbq5oUkkBgDgAVbS5zOGG4eoL9zFPpOn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786117011; c=relaxed/simple;
	bh=o0F8IfsclqWroTilCX6+DCQ7dx2LBNp9WoA/XuoK1Uk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q5HzCyn0eDkgB/7oIEQe87EIPHfypKPAOeg4ZAP99vZnXwcoy4eQfUSp/7kBHzNRqpaO29WGXUmWoGQOPx4DlDGL4j/gs7DWxc1dyi6thatEHT6YiuizuV7Xq/ghURJK9ig9TDumXG1Z4t7/hpVtCp8XZlUdCsb2CxgFmo2Dvwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aNxMoKNG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aNxMoKNG"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677FHjVP1733555;
	Fri, 7 Aug 2026 15:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=udJ27D
	Ru7XHSefBp0X8bd1JvAUdv7XP1pcjAcKviINI=; b=aNxMoKNG0q5UMXrqvT65bQ
	FEZv/CxXSBVL7Jkmb1jjdF4D1yZv7OG7Vz6rRsMy4G7LHwllsK1gx/VZQwoyRsno
	VOCGlGS+A5a8s7ypbhaau2nj8CzYF6qhGe+B3QDmKFGGmJCUUyIw8jUlWlSMo7YP
	gxu9QXBfITOm+kESZGTgONMvZk0B5aNcZaErKg2KLY8UgXEWQy8XgrZDN9V2ZS9c
	clR71ewje0s7F4AyqvWq7V1vVepLS/Vw+ZgpTu2mdE/4G1YHixU3zkldKDlir1nl
	xLJZcZ1RUbgWuETc+nEkL8haYNWYaLUPIkOgEcPl3MpTsyLhPiXZK5qdKs3fIjyw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy02cfgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 15:36:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677FBKZ4013810;
	Fri, 7 Aug 2026 15:36:36 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhr699-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 15:36:36 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677FaZn517302042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 15:36:35 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F20245805A;
	Fri,  7 Aug 2026 15:36:34 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BC6E58051;
	Fri,  7 Aug 2026 15:36:28 +0000 (GMT)
Received: from [9.39.23.175] (unknown [9.39.23.175])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 15:36:27 +0000 (GMT)
Message-ID: <7abde347-8a93-4a65-800e-3d1d42ac4185@linux.ibm.com>
Date: Fri, 7 Aug 2026 21:06:25 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/smc: abort the connection when the peer
 overruns the RMB
To: Simon Horman <horms@kernel.org>
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com,
        sidraya@linux.ibm.com, mjambigi@linux.ibm.com, andrew+netdev@lunn.ch,
        tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        pasic@linux.ibm.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, Bryam Vargas <hexlabsecurity@proton.me>
References: <20260804141109.542202-1-hidayath@linux.ibm.com>
 <20260805160317.GW51943@horms.kernel.org>
Content-Language: en-GB
From: Hidayathulla Khan I <hidayath@linux.ibm.com>
In-Reply-To: <20260805160317.GW51943@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=G6ws1dk5 c=1 sm=1 tr=0 ts=6a75fb85 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=9R54UkLUAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=tkcMkOXBoALFckE9JQQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDExOSBTYWx0ZWRfX12qvxBydvc4e
 cyNm60MLeNxFeGqXZdjUpOoqq1klEhpVFmvVikF7kmZsCCqQ0Ekp/SqLDqxgsKglAWBlnzdGORy
 GH+2papbEP6Xw+LQueQK9hVBsDSxUCR+fjK5h5Vl2jIi+feEhGUgJhMWS0pE8Mjbonr+aZ03roL
 A71qCGJRQ/27bwLIIOwtpPxTdqaupRzQ+30ajwa/Ljb1XvhEyknPb1sD8ayMDT4fYslS3n3D5Rs
 ErsTBIGIwKo4PAo0JEKX5dsjpol7hnofgQjOY/BlL0KMWNJlfbaSVUgojMMWSOTFmsYWVK6fbY8
 zYxxid7GXrB3uGJATqW6mtSH/nVJWsq5yNCMYnioDT8kQ7OvNrx9IaUZwZyt620vpJ5cWawrVdQ
 9nyTY0ok3rHthA60kqSY3uPm3r+ft+buKcypebMMx6XauUHqkOI/nH+J6sJItSimQJlLTyaeRPw
 muMRxmAUEzgWgpQ1UHQ==
X-Proofpoint-ORIG-GUID: GYF-y87WUiB7UcW58an6N3Xpdjr5xC0M
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDExOSBTYWx0ZWRfX1iifBPsHWWn0
 i3nYEToejpxhS6Q7WVn25Af5wuHCGv3T+MQaJgszOJD07aCQ60e03gvV9z5zJlpljB1yo4J00V+
 Kk3NePVrXo++k0dfRfwT4NPytJbaYhI=
X-Proofpoint-GUID: FLsR1-ppBRKt8OEexhclqKjJ6AXTeMRP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070119

Thanks for the review.

On 05/08/26 9:33 pm, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260804141109.542202-1-hidayath@linux.ibm.com?part=1
> ---
> --- Patch [1]: [PATCH net-next] net/smc: abort the connection when the peer overruns the RMB ---
> commit fc7927463c41bac1e3a598538d104b46770ee787
> Author: Hidayath Khan <hidayath@linux.ibm.com>
>
> net/smc: abort the connection when the peer overruns the RMB
>
> The patch factors the connection-abort sequence out of
> smc_cdc_msg_validate() into a new helper smc_cdc_abort_conn(), and calls it
> from smc_cdc_msg_recv_action() when the peer's producer cursor advance would
> push conn->bytes_to_rcv past conn->rmb_desc->len.  The test is placed before
> the atomic_add() and the rest of the message is abandoned.
>
> A few questions about the new helper and its new caller below.
>
> [Severity: Low]
> [Finding: main-1-0]
> [Sources: opus-5, old-prompts]
> The commit message describes a peer-triggerable, user-visible defect
> (SIOCINQ reporting a readable length that does not exist, poll() staying
> readable with nothing for recvmsg() to return), but the patch carries
> neither a Fixes: tag nor Cc: stable.
>
> The accumulation site being repaired:
>
> 	atomic_add(diff_prod, &conn->bytes_to_rcv);
> 	/* guarantee 0 <= bytes_to_rcv <= rmb_desc->len */
>
> is part of the original CDC receive implementation, so every stable release
> carrying net/smc looks affected.  Could a Fixes: tag be added so backporters
> know which releases to pick this up for?
>
> Simon says: In a similar vein, if the above is so then perhaps
>              the patch should be targeted at net rather than net-next?
Sure.  I will resend against net with

   Fixes: 5f08318f617b ("smc: connection data control (CDC)")
   Cc: stable@vger.kernel.org

I had chosen net-next because the patch changes behaviour, but the defect
is peer-triggerable and present in every release carrying net/smc, so net
is the better fit.
>
>> diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
>> index 32d6d03df3214..d8f747bbc6f69 100644
>> --- a/net/smc/smc_cdc.c
>> +++ b/net/smc/smc_cdc.c
>> @@ -305,6 +305,27 @@ static void smc_cdc_handle_urg_data_arrival(struct smc_sock *smc,
>>   	sk_send_sigurg(&smc->sk);
>>   }
>>   
>> +/* Drop a connection whose peer violated the CDC protocol.  @link is the link
>> + * the offending message arrived on, or NULL when it is not known to the caller
>> + * (SMC-D, and the shared receive path).  When @link is NULL conn->lnk is left
>> + * unchanged: for SMC-R it already points to the right QP; for SMC-D there is
>> + * no per-link QP to abort on.
>> + */
>> +static void smc_cdc_abort_conn(struct smc_sock *smc, struct smc_link *link)
>> +{
>> +	struct smc_connection *conn = &smc->conn;
>> +
>> +	conn->out_of_sync = 1;  /* prevent any further receives */
> [Severity: Medium]
> [Finding: main-2-6]
> [Sources: opus-5, old-prompts]
> The kerneldoc above states the link == NULL case covers SMC-D, and this
> comment says the flag prevents any further receives.  Does
> conn->out_of_sync actually stop receives on SMC-D?
No, it does not.  Mine is the first code that sets the flag on an SMC-D
connection, and smcd_cdc_rx_tsklet() gates only on killed.  I will test
out_of_sync there as well in v2.
>
> The only reader of the flag is the SMC-R IB completion path:
>
> net/smc/smc_cdc.c:smc_cdc_rx_handler() {
> 	...
> 	conn = smc_lgr_find_conn(ntohl(cdc->token), lgr);
> 	if (!conn || conn->out_of_sync) {
> 		read_unlock_bh(&lgr->conns_lock);
> 		return;
> 	}
> 	...
> }
>
> The SMC-D entry point gates on a different flag:
>
> net/smc/smc_cdc.c:smcd_cdc_rx_tsklet() {
> 	...
> 	if (!conn || conn->killed)
> 		return;
>
> 	data_cdc = (struct smcd_cdc_msg *)conn->rmb_desc->cpu_addr;
> 	...
> }
>
> and conn->killed is only set later, inside smc_conn_kill(), once abort_work
> actually runs.
>
> For the window in between, can every further ISM DMB interrupt re-enter
> smc_cdc_msg_recv_action() with peer-controlled cursors, keep updating
> conn->local_rx_ctrl via smc_cdc_msg_to_host() and conn->peer_rmbe_space, and
> trip the new test again?  Since queue_work() only fails while the item is
> still pending, would a second abort_work run smc_conn_kill() on an
> already-killed connection once the first one has started?
>
> Would also testing conn->out_of_sync in smcd_cdc_rx_tsklet(), or at the top
> of smc_cdc_msg_recv_action(), address this?
>
> [Severity: Medium]
> [Finding: main-5-17]
> [Sources: opus-5, old-prompts]
> This store now happens on the transport-shared receive path in softirq
> context.  The flags share one storage unit:
>
> net/smc/smc.h:struct smc_connection {
> 	...
> 	u8			killed : 1;	/* abnormal termination */
> 	u8			freed : 1;	/* normal termination */
> 	u8			out_of_sync : 1; /* out of sync with peer */
> };
>
> so conn->out_of_sync = 1 is a read-modify-write of that byte.
> smc_conn_kill(), running from the abort_work queued right below, writes
> conn->killed = 1 into the same byte from process context under lock_sock().
>
> The receive path does not defer to the backlog when the socket is owned:
>
> net/smc/smc_cdc.c:smc_cdc_msg_recv() {
> 	sock_hold(&smc->sk);
> 	bh_lock_sock(&smc->sk);
> 	smc_cdc_msg_recv_action(smc, cdc);
> 	bh_unlock_sock(&smc->sk);
> 	sock_put(&smc->sk); /* no free sk in softirq-context */
> }
>
> Can the two writers interleave and lose the killed update:
Yes, the three flags share a byte.  Nobody appears to be working on it,
and it needs a layout change rather than a fix folded in here.  I will
send it separately.
>
> tasklet:    load the flags byte (killed == 0)
> abort_work: store killed = 1
> tasklet:    store the byte back with out_of_sync = 1 and killed == 0
>
> Since smcd_cdc_rx_tsklet() gates only on conn->killed, would a lost killed
> bit let a newly scheduled tasklet keep dereferencing conn->rmb_desc->cpu_addr
> after smc_conn_kill() has already run smc_ism_unset_conn() and
> smcd_buf_detach()?  And on SMC-R, would a lost out_of_sync bit defeat the
> receive barrier this patch relies on?
>
>> +	spin_lock_bh(&conn->send_lock);
>> +	conn->local_tx_ctrl.conn_state_flags.peer_conn_abort = 1;
>> +	if (link)
>> +		conn->lnk = link;
>> +	spin_unlock_bh(&conn->send_lock);
>> +	sock_hold(&smc->sk); /* sock_put in abort_work */
>> +	if (!queue_work(smc_close_wq, &conn->abort_work))
>> +		sock_put(&smc->sk);
>> +}
> [Severity: High]
> [Finding: main-3-9]
> [Sources: opus-5, old-prompts]
> This queues conn->abort_work with no is_smcd distinction, and the new caller
> in smc_cdc_msg_recv_action() is reachable from smcd_cdc_rx_tsklet().  The
> only other caller, smc_cdc_msg_validate(), runs from smc_cdc_rx_handler(),
> an ib_wc handler, so is this the first path that can queue abort_work for an
> SMC-D connection?
>
> smc_conn_free() only cancels the work in its non-SMC-D branch:
>
> net/smc/smc_core.c:smc_conn_free() {
> 	...
> 	if (lgr->is_smcd) {
> 		if (!list_empty(&lgr->list))
> 			smc_ism_unset_conn(conn);
> 		if (smc_ism_support_dmb_nocopy(lgr->smcd))
> 			smcd_buf_detach(conn);
> 		tasklet_kill(&conn->rx_tsklet);
> 	} else {
> 		smc_cdc_wait_pend_tx_wr(conn);
> 		if (current_work() != &conn->abort_work)
> 			cancel_work_sync(&conn->abort_work);
> 	}
> 	if (!list_empty(&lgr->list)) {
> 		smc_buf_unuse(conn, lgr); /* allow buffer reuse */
> 		smc_lgr_unregister_conn(conn);
> 	}
> 	...
> 	smc_lgr_put(lgr); /* lgr_hold in smc_conn_create() */
> }
>
> So if the peer trips the new test and the application then closes the
> socket, can a still-pending abort_work outlive smc_conn_free() and later
> run smc_conn_kill()?
Yes.  Same root cause: smc_conn_free() cancels abort_work only in its
non-SMC-D branch, which was enough while smc_cdc_msg_validate() was the
only queuer.  I have confirmed both consequences you list, the stale
conn->lgr, and the smcd->conn[] slot of a descriptor already handed to
another connection.  I will run the cancel for both transports in v2.
>
> net/smc/smc_core.c:smc_conn_kill() {
> 	if (conn->lgr->is_smcd && conn->lgr->peer_shutdown)
> 	...
> 	if (conn->lgr->is_smcd) {
> 		smc_ism_unset_conn(conn);
> 	...
> }
>
> Two things look problematic there.  conn->lgr is dereferenced
> unconditionally although smc_conn_free() already dropped the connection's
> reference with smc_lgr_put() and never NULLs conn->lgr.  And
> smc_ism_unset_conn() uses a descriptor that smc_buf_unuse() already returned
> to the reuse pool:
>
> net/smc/smc_ism.c:smc_ism_unset_conn() {
> 	if (!conn->rmb_desc)
> 		return;
>
> 	spin_lock_irqsave(&conn->lgr->smcd->lock, flags);
> 	conn->lgr->smcd->conn[conn->rmb_desc->sba_idx] = NULL;
> 	spin_unlock_irqrestore(&conn->lgr->smcd->lock, flags);
> }
>
> Since smc_buf_get_slot() hands back any descriptor with used == 0 and the
> new owner is registered via smc_ism_set_conn(), can this clear the
> smcd->conn[] slot of a different, live connection and stop its receives?
> The sock_hold() here keeps the smc_sock alive but does not pin the link
> group or the buffer descriptor.
>
> Simon says: I think the issue flagged below is out of scope for this patch.
>
> [Severity: High]
> [Finding: old-prompts-4-16]
> [Sources: old-prompts]
> This isn't a bug introduced by this patch, since smc_cdc_msg_validate() used
> the same hold-and-queue idiom before, but the patch makes it reachable from
> any peer-driven producer-cursor advance rather than only from
> failover-validation messages, so it seems worth raising here.
>
> The reference taken by sock_hold() is documented as released by abort_work,
> and the only sock_put() is there:
>
> net/smc/smc_core.c:smc_conn_abort_work() {
> 	...
> 	sock_put(&smc->sk); /* sock_hold done by schedulers of abort_work */
> }
>
> But smc_conn_free() discards the return value when it cancels a still
> pending item:
>
> 	if (current_work() != &conn->abort_work)
> 		cancel_work_sync(&conn->abort_work);
>
> cancel_work_sync() returns true exactly when the work was removed without
> ever executing.  In that case smc_conn_abort_work() never runs, so does the
> struct smc_sock leak because sk_refcnt never reaches zero and sk_free() is
> never called?
>
> The sibling work item uses the compensating put:
>
> net/smc/smc_close.c:smc_close_cancel_work() {
> 	...
> 	if (cancel_work_sync(&smc->conn.close_work))
> 		sock_put(sk);
> 	...
> }
>
> Should the abort_work cancel path do the same?
Agreed. It is a real leak though, and I have already
sent a patch for it: "net/smc: drop the abort_work reference when the
work is cancelled"  which adds the compensating sock_put() using the same
smc_close_cancel_work() idiom that the finding points to.
>
>> @@ -314,17 +335,8 @@ static void smc_cdc_msg_validate(struct smc_sock *smc, struct smc_cdc_msg *cdc,
> [ ... ]
>
>> @@ -376,6 +388,11 @@ static void smc_cdc_msg_recv_action(struct smc_sock *smc,
>>   	diff_prod = smc_curs_diff(conn->rmb_desc->len, &prod_old,
>>   				  &conn->local_rx_ctrl.prod);
>>   	if (diff_prod) {
>> +		if (diff_prod > conn->rmb_desc->len -
>> +				atomic_read(&conn->bytes_to_rcv)) {
>> +			smc_cdc_abort_conn(smc, NULL);
>> +			return;
>> +		}
> Simon says: Also, seems out of scope for this patch
>
> [Severity: Medium]
> [Finding: main-1-1]
> [Sources: opus-5, old-prompts]
> This is a pre-existing issue, but two sibling accumulators in the same
> function are fed by the same peer-controlled cursor and are still unbounded,
> and both are updated before this new test runs:
>
> 	diff_cons = smc_curs_diff(conn->peer_rmbe_size, &cons_old,
> 				  &conn->local_rx_ctrl.cons);
> 	if (diff_cons) {
> 		...
> 		atomic_add(diff_cons, &conn->peer_rmbe_space);
> 		/* guarantee 0 <= peer_rmbe_space <= peer_rmbe_size */
>
> and, on the SMC-D dmb-nocopy path:
>
> 			atomic_add(diff_tx, &conn->sndbuf_space);
> 			/* guarantee 0 <= sndbuf_space <= sndbuf_desc->len */
>
> Both deltas come from conn->local_rx_ctrl.cons, which is as peer-controlled
> as the prod cursor this patch defends against, and smcd_cdc_msg_to_host()
> copies it verbatim while smc_cdc_cursor_to_host() only rejects a backwards
> move.
>
> The commit message says:
>
>      The test precedes the atomic_add() so the counter is never left inflated
>
> Is that only true for bytes_to_rcv?
Yes, only bytes_to_rcv.  peer_rmbe_space and sndbuf_space are already
moved by the time the abort is queued.  I will narrow the wording in v2.
Bounding the cons-derived accumulators is a separate
change, and "net/smc: bound the send length to the send buffer in
smc_tx_sendmsg()" already clamps the sndbuf_space one where it is consumed.
>    Even the message that trips the new
> check has already inflated peer_rmbe_space (and sndbuf_space on
> loopback-ISM) by the time the abort is queued.  Should the wording be
> narrowed to bytes_to_rcv, or should the same treatment be applied to the
> cons-derived accumulators?
>
>>   		if (conn->local_rx_ctrl.prod_flags.urg_data_present)
>>   			smc_cdc_handle_urg_data_arrival(smc, &diff_prod);
> Simon says: Also, seems out of scope for this patch
>
> [Severity: Critical]
> [Finding: main-6-20]
> [Sources: opus-5, old-prompts]
> This isn't a bug introduced by this patch, but the new test bounds only the
> delta and the commit message explicitly dismisses bounding the cursor
> ("Bounding the cursor does not help"), so it seems worth stating that the
> delta check does not protect the call directly below it.
>
> smc_cdc_handle_urg_data_arrival() uses the absolute peer-supplied count as a
> byte offset into the RMB:
>
> net/smc/smc_cdc.c:smc_cdc_handle_urg_data_arrival() {
> 	...
> 	base = (char *)conn->rmb_desc->cpu_addr + conn->rx_off;
> 	if (conn->urg_curs.count)
> 		conn->urg_rx_byte = *(base + conn->urg_curs.count - 1);
> 	...
> }
>
> Can a peer keep prod.count out of range while still producing a small delta?
> smc_curs_diff() computes the wrap case in unsigned int arithmetic:
>
> net/smc/smc_cdc.h:smc_curs_diff() {
> 	if (old->wrap != new->wrap)
> 		return max_t(int, 0,
> 			     ((size - old->count) + new->count));
>
> 	return max_t(int, 0, (new->count - old->count));
> }
>
> With old = {wrap 0, count 0} and new = {wrap 1, count 0xfffffff0} this wraps
> modulo 2^32 and yields len - 16, which passes
>
> 	diff_prod > conn->rmb_desc->len - atomic_read(&conn->bytes_to_rcv)
>
> for small bytes_to_rcv, while prod.count stays near 4G.  A variant without
> the wrap trick: a first message with count 0x80000000 gives
> max_t(int, 0, negative) == 0 and is stored, then count 0x80000001 gives
> diff_prod == 1.
>
> Nothing clamps the absolute count: smc_cdc_cursor_to_host() only rejects a
> backwards move, and smcd_cdc_msg_to_host() copies peer->prod.wrap and
> peer->prod.count with no validation.  The byte read at that offset is then
> handed to user space:
>
> net/smc/smc_rx.c:smc_rx_recv_urg() {
> 	...
> 	rc = memcpy_to_msg(msg, &conn->urg_rx_byte, 1);
> 	...
> }
>
> so is this an out-of-bounds read at a peer-chosen offset that either leaks
> kernel memory through recvmsg(MSG_OOB) or faults on unmapped memory?  Would
> validating prod.count < conn->rmb_desc->len alongside the new delta test be
> appropriate?
The analysis is right, but "net/smc: bound the wire-controlled producer
cursor to the RMB" already clamps prod.count at the conversion, which
seems the better place for it.  I am happy to reorder behind that series.

Thanks again.

>
>>   		/* bytes_to_rcv is decreased in smc_recvmsg */
