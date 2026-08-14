Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D8846F4A6;
	Fri, 14 Aug 2026 18:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786731636; cv=none; b=N29nqQPCToZPlxcr4gz0MbXeETn6ivphcm5bMELb4MxFvvWR421ODSStZ33IhGAQg5qpuM+2lqef0ktnLFMVwXM37kuf8ZhXrrHIIXEfNB3jcwOELvSW02fVoeskEqYzdopxcOdUdxW5VelhWOjQ266TOQwgA3hSw2AM0M1stqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786731636; c=relaxed/simple;
	bh=Zqi40RXc8gr82zE1QBRvdP3A2MCFqLXwNTYOQ9x2OWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PwQE9lPAIcH+0ABaK1ZPwaSjlmeOB8j4x6MMd2XBKDrTnMWzXsTTlxhxG5sVA92j472/obGGu2//8BITtin3wM7dSjNpsdYPe3pR/+WbjnFudMAgwKBZVUmUiqErXvxtxyB/NJdolLxeIKrDAJnV4HQXXiC5oPy1Yoi7j295kj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cDWvycTd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cDWvycTd"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EH1VcN1721711;
	Fri, 14 Aug 2026 18:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xZA/MR
	feJzceC6/GoJWm4sCo4UKuD4jqCLRgsBHF8fE=; b=cDWvycTdZxZdY+w+GsQ4Te
	2y+fWzszA9VnXyfFV2eojQDmzUiulgzmNk8rnFQZ5HT+KvZM616KIlkpw+5S7i9G
	JU/029OwzJ5kviY0l04IS6JKzh1/snG60nkG9PwwFocd/PplxYVjGooXNAdxEpYX
	qUQ0bJ2KBpgsRu915IqrV5mfvL8XcZcLYFlMevdM37rniTo0fTPm25sQOlAZ/S+y
	Ae2yWKThKuydnS+y1lcZ+y79fgmiYpVqqwSpRNbaULVF/rhWaM+plJaUf8SyW/d5
	RypHdDxOyBHYMcDaAojCzPiX9JaVbNJOAsD2uS1ZMvRu02Qb4A+PbQgUguPneNBg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvma692k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 18:20:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67EIBYHs014599;
	Fri, 14 Aug 2026 18:20:21 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsk8dku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 18:20:21 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67EIKJ8624969896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 18:20:20 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7B3F5805C;
	Fri, 14 Aug 2026 18:20:19 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1A8B5805A;
	Fri, 14 Aug 2026 18:20:14 +0000 (GMT)
Received: from [9.124.211.136] (unknown [9.124.211.136])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 18:20:14 +0000 (GMT)
Message-ID: <4abcf232-ae7a-4af0-920c-22febc9b88d4@linux.ibm.com>
Date: Fri, 14 Aug 2026 23:50:12 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: fix use-after-free in
 smc_rx_pipe_buf_release()
To: Simon Horman <horms@kernel.org>
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com,
        sidraya@linux.ibm.com, mjambigi@linux.ibm.com, andrew+netdev@lunn.ch,
        tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        pasic@linux.ibm.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
References: <20260810064041.720441-1-hidayath@linux.ibm.com>
 <20260811121913.GD51943@horms.kernel.org>
Content-Language: en-GB
From: Hidayath Khan <hidayath@linux.ibm.com>
In-Reply-To: <20260811121913.GD51943@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDEzOCBTYWx0ZWRfX38jvotbr1Smo
 JNt7s1T5hZhB3YB+fVDph9tPvKCryAbwWQ/3bBf79Zf+WKKR/nV882US7+GMf6ZSI893gtCbf8t
 SiDCmuA1Qbt+Z2PfR9HIdLK1LiWuXJi0/XrDvxcEiJeKxAhO29TpMUEFoF9EkgWu8GqN171A28j
 efGsNCJ98nabY31SizrvowgITdn22OKTimBq3ChTQl7Zf74FZ2FcisF5E2GVXvdJNwk4YLrMnTx
 tzQGbjIaE82DMxMwU6uw7yk8VjKYPCNXSbzSOvLNpn5tidC/qRjWA20GcsYAMilFb+Hjo7qcQ4m
 1q+iUK72e+dpiUImzqNvb+95KaVgNR9sU1xNCpxW1i6gYbMk6yyBo098gJZlLKCoQ1AY4kvk1rr
 TX4FlbPxH5bAOWpXkZNiF60blWUOxXTRImbWIJKZpLZRblVNE1aOAn8EdxQY+HyPZ83KM9jlbmI
 pujvAQGxuFLQAVU1DUg==
X-Proofpoint-ORIG-GUID: WmQFtBgRB4iYl_I6RhNUxnbSzqChZ4L0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDEzOCBTYWx0ZWRfXwZq/5VtrPqkl
 Fi5qW5ryLo7lqJC65AfrpTqm9BJYN0UFwilxB57GLPWfP2ZXaUBgBuVnU3a3XvrQALbUC96A72i
 iuYtIFqsE3gwq9UKrH/IbXYH03GScNI=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7f5c67 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=9R54UkLUAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=dVJtoKHjo9LuLFuDEWkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-GUID: cIyRfu-vF8yTgHvp2bnYRCUMtciVDgJx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140138

Thanks for the review.

Both findings are correct, and both come
from the conn->rmb_desc = NULL store.  v2 drops that store instead of
moving it, and tests conn->freed under the socket lock.

On 11/08/26 5:49 pm, Simon Horman wrote:
> On Mon, Aug 10, 2026 at 08:40:41AM +0200, Hidayath Khan wrote:
>> smc_rx_splice() hands RMB pages to a pipe and takes a socket reference for
>> each entry, so the smc_sock survives until the reader is done.  The
>> connection does not: a close in between runs smc_conn_free(), which
>> releases the link group and returns the receive buffer to the link group's
>> pool.
>>
>> smc_rx_pipe_buf_release() tries to detect that by testing sk_state, but it
>> does so before taking the socket lock, and then dereferences the connection
>> anyway:
>>
>>          if (sk->sk_state == SMC_CLOSED || ...)
>>                  goto out;
>>          conn = &smc->conn;
>>          lock_sock(sk);
>>          smc_rx_update_cons(smc, priv->len);
>>
>> smc_rx_update_cons() reads conn->rmb_desc->len twice and then calls
>> smc_tx_consumer_update(), which walks conn->lgr and conn->lnk.  The state
>> can change between the test and the lock, and on the is_reg_err path
>> smcr_buf_unuse() does not recycle the descriptor but frees it outright, so
>> this is a use-after-free rather than a stale read.
>>
>> sk_state is also the wrong thing to test.  Take the socket lock first so
>> the test and the cursor update cannot be separated, and test the receive
>> buffer itself, which is what the code goes on to dereference.
>>
>> For that test to mean anything, smc_buf_unuse() has to stop leaving a
>> pointer to a descriptor it has just released; clear conn->rmb_desc there.
>> Nothing in smc_conn_free() reads it afterwards, and smc_ism_unset_conn()
>> already returns early on a NULL rmb_desc, so an SMC-D teardown that reaches
>> it twice becomes a no-op instead of indexing smcd->conn[] with a stale
>> sba_idx.
>>
>> Fixes: 9014db202cb7 ("smc: add support for splice()")
>> Cc: stable@vger.kernel.org
>> Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>
>> Signed-off-by: Hidayath Khan <hidayath@linux.ibm.com>
>> ---
>>   net/smc/smc_core.c |  1 +
>>   net/smc/smc_rx.c   | 10 ++++++----
>>   2 files changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
>> index c0027d2fe4e8..def65ebc0b53 100644
>> --- a/net/smc/smc_core.c
>> +++ b/net/smc/smc_core.c
>> @@ -1248,6 +1248,7 @@ static void smc_buf_unuse(struct smc_connection *conn,
>>   			WRITE_ONCE(conn->rmb_desc->used, 0);
>>   		}
>>   		SMC_STAT_RMB_SIZE(smc, is_smcd, true, false, bufsize);
>> +		conn->rmb_desc = NULL;
>>   	}
>>   }
> Hi,
>
> The AI-generated review at [1] flags the following.
> Could you take a look?
>
> [1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260810064041.720441-1-hidayath%40linux.ibm.com
>
> AI-generated review text:
>
>    Before this change conn->rmb_desc stayed non-NULL once it was set, so
>    readers that never take the socket lock could only ever see a stale (still
>    mapped) descriptor.  Can this new store turn those into NULL
>    dereferences?
>
>    Two paths look exposed.  First, the SMC-R CDC receive path.  In
>    smc_conn_free() the buffer is released before the conn leaves the link
>    group:
>
>    net/smc/smc_core.c:smc_conn_free() {
> 	...
> 	if (!list_empty(&lgr->list)) {
> 		smc_buf_unuse(conn, lgr); /* allow buffer reuse */
> 		smc_lgr_unregister_conn(conn);
> 	}
> 	...
>    }
>
>    So there is a window where the conn is still in lgr->conns_all with
>    rmb_desc == NULL.  smc_cdc_rx_handler() finds it there, and
>    smc_cdc_msg_recv() only takes bh_lock_sock():
>
>    net/smc/smc_cdc.c:smc_cdc_msg_recv() {
> 	sock_hold(&smc->sk);
> 	bh_lock_sock(&smc->sk);
> 	smc_cdc_msg_recv_action(smc, cdc);
> 	bh_unlock_sock(&smc->sk);
> 	...
>    }
>
>    bh_lock_sock() takes sk->sk_lock.slock and does not exclude a
>    process-context lock_sock() owner running smc_release() ->
>    __smc_release() -> smc_conn_free(), which is why
>    smc_cdc_msg_recv_action() itself has to check sock_owned_by_user().  That
>    same function then does:
>
>    net/smc/smc_cdc.c:smc_cdc_msg_recv_action() {
> 	...
> 	diff_prod = smc_curs_diff(conn->rmb_desc->len, &prod_old,
> 				  &conn->local_rx_ctrl.prod);
> 	...
>    }
>
>    and on urgent data smc_cdc_handle_urg_data_arrival() does:
>
>    net/smc/smc_cdc.c:smc_cdc_handle_urg_data_arrival() {
> 	base = (char *)conn->rmb_desc->cpu_addr + conn->rx_off;
> 	if (conn->urg_curs.count)
> 		conn->urg_rx_byte = *(base + conn->urg_curs.count - 1);
> 	else
> 		conn->urg_rx_byte = *(base + conn->rmb_desc->len - 1);
> 	...
>    }
>
>    Neither has a NULL check, and this runs in softirq/tasklet context.  Would
>    it be safer to clear rmb_desc after smc_lgr_unregister_conn(), once the
>    conn can no longer be found by the CDC handler?
It would help, but it does not close the window: smc_cdc_rx_handler() drops
conns_lock before calling smc_cdc_msg_recv(), so an in-flight handler still
reaches the dereference.

conn->freed avoids it instead.  smc_conn_free() sets it before releasing
anything and with the socket lock held, every caller holds that lock, and
smc_rx_pipe_buf_release() takes the same lock.  So the two exclude each
other rather than racing.
>
>    Second, the sock_diag dump.  smc_diag_dump_proto() walks the sockets under
>    read_lock(&prot->h.smc_hash->lock) only, never lock_sock(), and
>    __smc_diag_dump() tests the pointer in the condition:
>
>    net/smc/smc_diag.c:__smc_diag_dump() {
> 	...
> 	if (smc_conn_lgr_valid(&smc->conn) && smc->conn.lgr->is_smcd &&
> 	    (req->diag_ext & (1 << (SMC_DIAG_DMBINFO - 1))) &&
> 	    !list_empty(&smc->conn.lgr->list) && smc->conn.rmb_desc) {
> 	...
> 		dinfo.token = conn->rmb_desc->token;
> 	...
>    }
>
>    Can a close on another CPU clear the pointer between that test and the
>    conn->rmb_desc->token dereference?
Yes, and it is not confined to rmb_desc -- conn->sndbuf_desc is already
cleared on teardown and the diag dump tests it the same way, so this is in
the tree already.  READ_ONCE() would stop the compiler reloading after
the test, but it would not stop the descriptor being freed under the walker,
so it needs its own patch.
> 	.rmbe_size = conn->rmb_desc ? conn->rmb_desc->len : 0,
>
>    with no READ_ONCE, which the compiler may reload after the test.
One dependency.  conn->freed shares a byte with killed and out_of_sync, and
out_of_sync is written from the receive tasklet without the socket lock, so
a read-modify-write there can drop a concurrent freed.  v2 therefore comes
as a two patch series, with "net/smc: stop killed, freed and out_of_sync
sharing a byte" as 1/2.
>
