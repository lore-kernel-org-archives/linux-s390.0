Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F055486BA7;
	Fri, 21 Aug 2026 15:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787326167; cv=none; b=pv3h4tdiX3C8Oz+0AQcp5sKexjj9fi53/PrgmMJhThBQ+SbygThCxcSObODftcYvjVEYSXnTHk4PqQYWbK2Ic3NN8IVArTjG3MH/jVrKxaGkoq9491T4i5DmODPTu1jxELIEKLjOM4dQMCAREF5WKYUAtT9Y8k87J3hZTNf/iZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787326167; c=relaxed/simple;
	bh=h5esfgAEc5J4QTS6KCzAEYx5h++5NHlC/xljZ5oGuTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EUetVMpRQjpPjCdq0LNx+/xt1tdvG3NDXYr3yoX4KUHn8lCRc5HBAS1dSEgUHzHpBHWEEPVtNbvzmuNeP3P+/wfzPidW8PIy5RhO+W+tXmMrcQsTuE2RxFw2ScaK120rMXp1vCTobk4gFrB/sCZHp1VkwTVyO6EoNWQblV8XJ3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F03zBphx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F03zBphx"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LD20F01473253;
	Fri, 21 Aug 2026 15:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NLO0R2
	/IkG7T2j0qak7CFetsE9P6uKhQWhqFlkgOQWI=; b=F03zBphxUTpOvZPIvL2OYO
	jwCl1ydk4bHz6SUaUieNB+hM7A0yC+tqs+yrrer7Hr81Tp3MdvvPQiyiDyay8Wui
	ZHRXnNUmhVmKXyCMb5mpaqmA2iCx53ZKj5+K79eeACnpAFwheHhCE2EUFqiGylAH
	3dtD7nnlp6O44CyBJPRijV9YX2o97S1iwZAISIljiSsFbccajOcg+ZgnJZTqevij
	bGoC70HV5jnakxiyxeCcB2ARhR9J0BKi2EmeHCk9qQsym976E5pEPofySSBglTGk
	jNIjytuI9xsMhF4gQ3mQeEurt5aHT7QjOs6/UeyamFxXKePiZydoF8EvEni7YUyQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4j9e1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 15:29:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LFQKOO011278;
	Fri, 21 Aug 2026 15:29:07 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32twnft1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 15:29:07 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LFSRRk21365424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 15:28:27 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7446B58055;
	Fri, 21 Aug 2026 15:29:06 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97B1358043;
	Fri, 21 Aug 2026 15:29:01 +0000 (GMT)
Received: from [9.124.213.154] (unknown [9.124.213.154])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 15:29:01 +0000 (GMT)
Message-ID: <da65e0a8-23e6-4c8a-9635-afb263df3b02@linux.ibm.com>
Date: Fri, 21 Aug 2026 20:58:59 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] net/iucv: af_iucv socket locking - accounting, and a staged
 plan
To: Bryam Vargas <hexlabsecurity@proton.me>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260724222917.134769-1-hexlabsecurity@proton.me>
Content-Language: en-GB
From: Hidayath Khan <hidayath@linux.ibm.com>
In-Reply-To: <20260724222917.134769-1-hexlabsecurity@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDExNyBTYWx0ZWRfX4cbDR22k0Rwz
 KxCblV1FGSl5eV0jN/6tjfRafpxNwn6ijfjvdZ1Bxtga3rrA5yBfJclXT985T+My07K+RZBCRsR
 dOM4exocm4DcXjpktywscvLWM1+rd2k=
X-Proofpoint-GUID: bOwGs9k87G-eQJP8c2ssjrk35bAb_fH2
X-Proofpoint-ORIG-GUID: ob2pbv5tjnq_Yd2c2cEHnl5UeDFOCI8x
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a886ec5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=rq-yJanvGYwrDBU3VLYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDExNyBTYWx0ZWRfX0jZoYmj+XKtG
 8631McsKUevviR99j58X/5wT+33irkpKKLhNgP8j7dPGW8hBHHAom4q7bxtxGiA/MVmRobjCCNV
 0dmMiFriTvYDwe1Y06TSQzFrxDjvpmF12ND7nF7Ol1WrJO/oOF60D1u2a5tMU45cV+vFJ4h2/K3
 QOLU9NVAXoMz6UELsa4nhhrC//sK0mTmzxMUR7t3a6ButgoizIgSc+ovMcieW7ZM7b1dF5pBhC9
 wco57YffhHJDsWi6exDmZcuqdEwMl/y5Hjy+ex9q3qF41fy3HM36qXr7TB1bScVDF0fGmCGqwAo
 BHbB+3vEkkggubkAtnefcAejwJenqZylRnHQTB9ii/5QQGdf9sJljq1Av8Pk8HtEETF6DtVKscs
 OZ/0pGzMoCFwsDYoiLHbWXd/1AKC7uMblzagBF/PjPAYS3ctB5UAbY3HS5VxhFVTSotqvY0N0xT
 fSvcCtNngKBVajqE4eQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210117


On 25/07/26 3:59 am, Bryam Vargas wrote:
> Alexandra,
>
> Here is the socket-locking RFC I promised. No patches yet, on purpose: the
> accounting turned up one result that changes which fix is right, and I'd
> rather agree the direction with you than post a series you have to redirect.
>
> All line numbers are against net-next 0c452fbdf413.
>
>
> What's there today
> ------------------
>
> sk->sk_state has 20 assignment sites. One (iucv_sock_alloc:504) runs before the
> socket is published on iucv_sk_list at :506, and two set a child socket under
> the parent's lock (below). The other 17 are spread across five contexts:
>
>    process, under lock_sock():
>      iucv_sock_bind:633,647   iucv_sock_listen:806   iucv_sock_close:411,417,432
>      iucv_sock_cleanup_listen:306
>    process, under no lock:
>      iucv_sock_recvmsg:1338
>    iucv tasklet, under bh_lock_sock():
>      iucv_callback_txdone:1793   iucv_callback_connrej:1810
>    iucv tasklet, under no lock:
>      iucv_callback_connack:1708
>    NET_RX softirq, under bh_lock_sock():
>      afiucv_hs_callback_synack:1941   afiucv_hs_callback_synfin:1961
>      afiucv_hs_callback_fin:1983
>    qeth TX completion, under no lock:
>      afiucv_hs_callback_txnotify:2190,2197
>    netdev notifier, under no lock:
>      afiucv_netdev_event:2222
>
> Two counts sum it up: sock_owned_by_user() appears zero times in the file, and
> there is no socket backlog at all - no .backlog_rcv in iucv_proto, no
> sk_add_backlog() anywhere. iucv->backlog_skb_q is a private data queue, not the
> socket layer backlog. So the machinery your option A refers to isn't being
> mis-used here, it's absent.
>
> Child sockets get their state set under the parent's lock: connreq:1696 and
> hs_callback_syn:1917 both set nsk->sk_state while holding bh_lock_sock on the
> parent, and iucv_sock_alloc:506 already published the child on iucv_sk_list
> before its state was set.
>
>
> Three gaps, each with a herd7 witness
> -------------------------------------
>
> I modelled the locking discipline in LKMM rather than argue it in prose. Six
> litmus tests, herd7 7.58. Each RED has a GREEN whose only delta is the lock or
> the check, plus a CONTROL so the harness is shown to discriminate:
>
>    RED     bh_lock_sock vs lock_sock, no owner check     Flag data-race
>    GREEN   ... same, with sock_owned_by_user() + defer   clean
>    RED     recvmsg unlocked, softirq HAS the owner check Flag data-race
>    GREEN   ... same, with recvmsg under lock_sock        clean
>    RED     a writer holding no lock at all               Flag data-race
>    CONTROL two bh_lock_sock writers                      clean
>
> The first pair is your sentence from f558120cd709 ("bh_lock_sock() is not
> serializing the tasklet context against process context") as a model verdict.
> lock_sock() releases sk_lock.slock before its critical section and leaves only
> sk_lock.owned set; bh_lock_sock() holds slock through its critical section. The
> two critical sections share no lock, so only an explicit sock_owned_by_user()
> check can order them.
>
> The third row is the one the plan turns on, so it's spelled out below. The rest
> inline or in a follow-up, whichever you prefer.
>
>
> The result that changes the plan
> --------------------------------
>
> Option A as written in f558120cd709 doesn't reach the receive path.
>
> iucv_sock_recvmsg (1237-1362) takes no socket lock - not lock_sock, not
> bh_lock_sock - and it writes sk->sk_state at :1338. Since it never sets
> sk_lock.owned, a sock_owned_by_user() check added in the softirq always reads
> zero and always takes the "process now" branch. The deferral branch is dead
> code against recvmsg. That's the third litmus above; since it's the one the
> plan turns on, here it is rather than on request. P1 already has the option-A
> fix applied:
>
>    C iucv-recvmsg-vs-hs-callback
>    {}
>
>    P0(int *sk_state)
>    {
>          *sk_state = 5;                  /* recvmsg:1338 -- no socket lock held */
>    }
>
>    P1(spinlock_t *slock, int *owned, int *sk_state, int *backlog)
>    {
>          int r0;
>
>          spin_lock(slock);               /* bh_lock_sock */
>          r0 = READ_ONCE(*owned);         /* sock_owned_by_user() */
>          if (r0 == 0)
>                  *sk_state = 2;          /* always taken: recvmsg never sets owned */
>          else
>                  WRITE_ONCE(*backlog, 1);        /* the branch that never runs */
>          spin_unlock(slock);
>    }
>
>    exists (sk_state=2)
>
>    $ cd tools/memory-model && herd7 -conf linux-kernel.cfg iucv-recvmsg.litmus
>    Flag data-race
>
> Give P0 the lock_sock() handshake (set owned under slock, write sk_state, clear
> it) and the flag goes away, with nothing else changed.
>
> So the owner check plus re-enqueue fixes the state machine against
> close/bind/listen/shutdown, but not against the reader -- and the reader is the
> path you asked about.
>
> Putting recvmsg under lock_sock isn't a one-liner either. Two things in the
> way, both of which I'd rather you ruled on:
>
>    a) recvmsg:1313 calls iucv_sock_close(), which takes lock_sock:401. Taking
>       the lock in recvmsg self-deadlocks there unless the close is split into a
>       __iucv_sock_close() that assumes the lock.
>
>       That exact call already cost a CVE: 3589d20a666c ("net/iucv: fix locking
>       in .getsockopt", CVE-2026-64004), which you reviewed and tested, fixed a
>       NULL deref from getsockopt(SO_MSGSIZE) racing the iucv_sock_close() that
>       recvmsg invokes at :1313. Locking getsockopt closed it because
>       iucv_sock_close() takes the socket lock itself - which is also exactly why
>       recvmsg cannot simply take it too.
>
>    b) skb_recv_datagram() doesn't release the socket lock while it waits, so a
>       blocking recv would hold it across the sleep and stall backlog processing
>       for the duration. __iucv_sock_wait already has the right shape for this
>       (release_sock / schedule_timeout / lock_sock), but it changes recvmsg's
>       blocking behaviour.
>
>
> Staged plan
> -----------
>
> Why split rather than send one rework: your caveat in f558120cd709 about return
> values and "changes to all users of iucv" applies to the tasklet path, because
> those handlers run from iucv_tasklet_fn while holding iucv_table_lock and
> iucv_handler is shared with monreader, vmlogrdr, smsgiucv and hvc_iucv. It
> doesn't apply to the HiperSockets path: afiucv_hs_rcv is a packet_type handler
> in NET_RX softirq that owns the skb, so it can defer to the socket backlog with
> no core change and no other driver touched.
>
> Stage 1, HiperSockets receive path. Add iucv_proto.backlog_rcv, hoist
> bh_lock_sock from the individual afiucv_hs_callback_* into afiucv_hs_rcv, and
> defer via sk_add_backlog() when the socket is owned. Put recvmsg under
> lock_sock, with the two items above. Entirely inside af_iucv.c, and it's the
> part you named.
>
> Stage 2, iucv tasklet path. This is where option A vs option B actually has to
> be answered, and where the core and the four other iucv users are affected.
> Option B subsumes it but needs iucv_tasklet_fn to stop holding iucv_table_lock
> across handler dispatch, or dispatch moved to the existing iucv_work_fn.
>
> Stage 3, the writers holding no lock. No amount of owner-check discipline at
> the other sites reaches these; they need a lock first. iucv_callback_connack is
> unambiguous - same tasklet as connrej and shutdown, which already take
> bh_lock_sock - so it can just do the same. I have that one ready as a
> standalone patch if you want it independently.
>
>
> Questions
> ---------
>
> Q1. For stage 1, is putting iucv_sock_recvmsg under lock_sock acceptable to
>      you, given (b) changes its blocking behaviour? The alternative is to
>      promote message_q.lock to the receive-path lock and move sk_state under it,
>      which leaves recvmsg's sleep alone but makes message_q.lock cover something
>      it doesn't cover today.
>
> Q2. For stage 2, option A or option B? B is more invasive in net/iucv/iucv.c
>      but makes Q1 and stage 3 moot. If you and Hidayath would rather own the
>      core change, I'll do stage 1 and hand you the analysis for the rest.
>
> Q3. afiucv_hs_callback_txnotify runs in two contexts, which is why I didn't
>      just add a lock to it: qeth_tx_poll (NAPI, softirq) and
>      qeth_drain_output_queue (process, teardown) both reach it through
>      qeth_notify_skbs. Which one should the locking be written for?
>
>
> Caveats
> -------
>
> I have no IBM Z, so none of this is validated on real HiperSockets. herd7
> proves the accesses race under LKMM; it says nothing about memory-safety
> impact, which would need a KASAN run on hardware. Treat the model results as an
> argument about which lock covers which write, not as a reproduction. I'd rely
> on you or Hidayath to validate each revision on real HW before anything lands.
>
> One coordination note: Hidayath's "net/af_iucv: fix use-after-free of listen
> sock in iucv_callback_connreq()" is still open, and I'm deliberately not
> touching that function. The staged plan resolves connreq as a consequence of
> the general direction rather than competing with his patch.
Hi Bryam,

Thanks for coordination note.

Please feel free to cover iucv_callback_connreq() in your locking rework 
as well.

A unified fix as part of your staged plan makes much more sense than 
carrying
a standalone partial fix, so I will drop my patch.

Thanks,
Hidayath
>
> Prior discussion, for anyone picking this up cold:
> https://lore.kernel.org/all/20260705-b4-disp-fc79c0dc-v1-1-d2cdcb57afa9@proton.me/
> https://lore.kernel.org/all/20260707-b4-disp-783fedbb-v1-1-463b9dbda2ea@proton.me/
> https://lore.kernel.org/all/20260706084825.6231-1-hidayath@linux.ibm.com/
>
> Thanks,
> Bryam
>
>
