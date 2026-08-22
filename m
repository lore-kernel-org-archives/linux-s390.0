Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C94339853;
	Sat, 22 Aug 2026 19:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787425763; cv=none; b=obiZDT4RuTEy0d/cTCMtDKJYPccf4mkrfxJ9LAMfvuMrOSoVLPFIQ1hPY5noEINrONdfcILfArFwvCN2encinfEK38ylimnyHuDt6CuDLC25dTgHihxeDy2B7IYmyx06enKTCRNGyJJRvT+CQiXJQq5fGHoGLi+s44cdXFfvLfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787425763; c=relaxed/simple;
	bh=8tztOfkSZw/va2Hqq8iiZwPtZQQetJK1wlwYI4W9W4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=brJ0V3oqfWJXpuQq07XprMvC20S0uwdBvYA+TEN02cHgUUCRbyWTrwwrJf1r3jVkcTw1tfxM5zC6PqtL8cFUSuvHm6BscNvXnt3QmtU9m+m6YEVqbDzLDFsn8ZVNKrXfTn+Kei+7GMhXNBkBNZ39+VXhFibJzdmrrZv9i/pyRzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Fr3boQP6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Fr3boQP6"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67MHVeuj3242775;
	Sat, 22 Aug 2026 19:09:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ky68my
	wYiQjflnx4pv+vOUDF5b5b1MYb6BAPJKYdjB0=; b=Fr3boQP6b/qYM+a4ScuX4C
	B3soLYnaPh/ES3iOzhLnuPhrdN3CZCYDzyheHu3bTMITi6UropnUgwtHwpE3bJu6
	WOZU722CgMdbgZQtDQSK+qrqtf5rxCpMklM/4TDCfND03OAnokoCWSyIwyrOrMkT
	oHM0Fo851UBP8P9F755danAInP+xcN8gfXFK3sZSyMdaWDVdjtH20aMu6+VWF4I4
	POIBu4pkqNJS5yfgROVfjW070Tt5RDaGVVJ0A/iHi3zCwOErvS+1gkkII2bVNI72
	WEkyqItezeMuV2P1caGOOA+kVnH/kz2JqKqoNa8u1sUpvwm5WqzYs9Bpqd57YDAQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqaan7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Aug 2026 19:09:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67MIuZIH025504;
	Sat, 22 Aug 2026 19:08:59 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g3550231c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Aug 2026 19:08:59 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67MJ8vsT56754478
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Aug 2026 19:08:57 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5BED58055;
	Sat, 22 Aug 2026 19:08:57 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 680335804B;
	Sat, 22 Aug 2026 19:08:52 +0000 (GMT)
Received: from [9.39.19.143] (unknown [9.39.19.143])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 22 Aug 2026 19:08:52 +0000 (GMT)
Message-ID: <5f88daf4-cd8e-4464-b132-ac45be205121@linux.ibm.com>
Date: Sun, 23 Aug 2026 00:38:50 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] net/iucv: af_iucv socket locking - accounting, and a staged
 plan
To: Alexandra Winter <wintera@linux.ibm.com>,
        Bryam Vargas <hexlabsecurity@proton.me>,
        Thorsten Winkler <twinkler@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260724222917.134769-1-hexlabsecurity@proton.me>
 <f74b9587-c09c-4fce-9415-e2d3b49d0247@linux.ibm.com>
Content-Language: en-GB
From: Hidayath Khan <hidayath@linux.ibm.com>
In-Reply-To: <f74b9587-c09c-4fce-9415-e2d3b49d0247@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: CVJLQju0MoigeA9Ez6A3wqUSa27oDQgL
X-Proofpoint-ORIG-GUID: 5KJ3cnWo_yuSk_EOLeZRWg0qmK0i9HNJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIyMDE2MCBTYWx0ZWRfX5iusBkoM44jg
 Ucy3tgQ9YufOStNNSzBte7VusSggtReF++CuCrruK3yQLdukCwLzUgNV28U8sVOQfdsjy8eW4BD
 IOXe6ZIBwtkpTekaHBw0MitcZqpu7GEhN+sV21ksrIoFMzShQbFtMINCNPhDYk/KU8vGN0fF4u3
 zSwed50bqg8O61SVk9OZGybyCu3t58rzHWUvdVDbA4Z/iydHAvZOeQ/ECYCuW4ggdPq/aZzSrO5
 M/73tmE5SKCTyQV1BwNoeZB8+hbVrzMeWB2jo7s8geTSG+3jR+lHuYP/UOsaJpI09cZ9/eZfmdi
 7tblZigxI5SD+2aOnzkrF4GGBEYEw8IYoqNZUTe/pc0IvhoOKRxwg/EowZLqjkdFXDpAN4KydWa
 rforrJVDFGGGci7sAJE0amYTCKyLfHryGq8XA0rq4ecbzkpUBWOCegrubXV7mR5lOAAsDy2wztm
 rItGxBeUAWEM9FdRcCg==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a89f3cc cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=OlRBskonR4vvretX3tcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIyMDE2MCBTYWx0ZWRfX8rKEqOTvyn1+
 ixrV+apuggSt6Mbr0TXFH1wXLXU8XHuoj5rQe5xFvJZzW6RZDrplocpsuXr/U/F1dRt3kizl5Uf
 PuzJeU+rFQumfkpmK0f3CISRaZ4UeOg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-22_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608220160


On 28/07/26 6:22 pm, Alexandra Winter wrote:
>
> On 25.07.26 00:29, Bryam Vargas wrote:
>> Alexandra,
>>
>> Here is the socket-locking RFC I promised. No patches yet, on purpose: the
>> accounting turned up one result that changes which fix is right, and I'd
>> rather agree the direction with you than post a series you have to redirect.
>>
>> All line numbers are against net-next 0c452fbdf413.
>>
> Bryam,
> thank you very much for this structured approach at this pile of work.
>
>> What's there today
>> ------------------
>>
>> sk->sk_state has 20 assignment sites. One (iucv_sock_alloc:504) runs before the
>> socket is published on iucv_sk_list at :506, and two set a child socket under
>> the parent's lock (below). The other 17 are spread across five contexts:
>>
>>    process, under lock_sock():
>>      iucv_sock_bind:633,647   iucv_sock_listen:806   iucv_sock_close:411,417,432
>>      iucv_sock_cleanup_listen:306
>>    process, under no lock:
>>      iucv_sock_recvmsg:1338
>>    iucv tasklet, under bh_lock_sock():
>>      iucv_callback_txdone:1793   iucv_callback_connrej:1810
>>    iucv tasklet, under no lock:
>>      iucv_callback_connack:1708
>>    NET_RX softirq, under bh_lock_sock():
>>      afiucv_hs_callback_synack:1941   afiucv_hs_callback_synfin:1961
>>      afiucv_hs_callback_fin:1983
>>    qeth TX completion, under no lock:
>>      afiucv_hs_callback_txnotify:2190,2197
>>    netdev notifier, under no lock:
>>      afiucv_netdev_event:2222
>>
>> Two counts sum it up: sock_owned_by_user() appears zero times in the file, and
>> there is no socket backlog at all - no .backlog_rcv in iucv_proto, no
>> sk_add_backlog() anywhere. iucv->backlog_skb_q is a private data queue, not the
>> socket layer backlog. So the machinery your option A refers to isn't being
>> mis-used here, it's absent.
>>
> Yes, I was aware of that :-/
>
>> Child sockets get their state set under the parent's lock: connreq:1696 and
>> hs_callback_syn:1917 both set nsk->sk_state while holding bh_lock_sock on the
>> parent, and iucv_sock_alloc:506 already published the child on iucv_sk_list
>> before its state was set.
>>
>>
>> Three gaps, each with a herd7 witness
>> -------------------------------------
>>
>> I modelled the locking discipline in LKMM rather than argue it in prose. Six
>> litmus tests, herd7 7.58. Each RED has a GREEN whose only delta is the lock or
>> the check, plus a CONTROL so the harness is shown to discriminate:
>>
>>    RED     bh_lock_sock vs lock_sock, no owner check     Flag data-race
>>    GREEN   ... same, with sock_owned_by_user() + defer   clean
>>    RED     recvmsg unlocked, softirq HAS the owner check Flag data-race
>>    GREEN   ... same, with recvmsg under lock_sock        clean
>>    RED     a writer holding no lock at all               Flag data-race
>>    CONTROL two bh_lock_sock writers                      clean
>>
>> The first pair is your sentence from f558120cd709 ("bh_lock_sock() is not
>> serializing the tasklet context against process context") as a model verdict.
>> lock_sock() releases sk_lock.slock before its critical section and leaves only
>> sk_lock.owned set; bh_lock_sock() holds slock through its critical section. The
>> two critical sections share no lock, so only an explicit sock_owned_by_user()
>> check can order them.
>>
>> The third row is the one the plan turns on, so it's spelled out below. The rest
>> inline or in a follow-up, whichever you prefer.
>>
>>
>> The result that changes the plan
>> --------------------------------
>>
>> Option A as written in f558120cd709 doesn't reach the receive path.
>>
>> iucv_sock_recvmsg (1237-1362) takes no socket lock - not lock_sock, not
>> bh_lock_sock - and it writes sk->sk_state at :1338. Since it never sets
>> sk_lock.owned, a sock_owned_by_user() check added in the softirq always reads
>> zero and always takes the "process now" branch. The deferral branch is dead
>> code against recvmsg. That's the third litmus above; since it's the one the
>> plan turns on, here it is rather than on request. P1 already has the option-A
>> fix applied:
>>
>>    C iucv-recvmsg-vs-hs-callback
>>    {}
>>
>>    P0(int *sk_state)
>>    {
>>          *sk_state = 5;                  /* recvmsg:1338 -- no socket lock held */
>>    }
>>
>>    P1(spinlock_t *slock, int *owned, int *sk_state, int *backlog)
>>    {
>>          int r0;
>>
>>          spin_lock(slock);               /* bh_lock_sock */
>>          r0 = READ_ONCE(*owned);         /* sock_owned_by_user() */
>>          if (r0 == 0)
>>                  *sk_state = 2;          /* always taken: recvmsg never sets owned */
>>          else
>>                  WRITE_ONCE(*backlog, 1);        /* the branch that never runs */
>>          spin_unlock(slock);
>>    }
>>
>>    exists (sk_state=2)
>>
>>    $ cd tools/memory-model && herd7 -conf linux-kernel.cfg iucv-recvmsg.litmus
>>    Flag data-race
>>
>> Give P0 the lock_sock() handshake (set owned under slock, write sk_state, clear
>> it) and the flag goes away, with nothing else changed.
>>
>> So the owner check plus re-enqueue fixes the state machine against
>> close/bind/listen/shutdown, but not against the reader -- and the reader is the
>> path you asked about.
>
> Yes, as discussed in your initial patch, I am aware that iucv_sock_recvmsg is
> currently not protected.
>
>
>> Putting recvmsg under lock_sock isn't a one-liner either. Two things in the
>> way, both of which I'd rather you ruled on:
>>
>>    a) recvmsg:1313 calls iucv_sock_close(), which takes lock_sock:401. Taking
>>       the lock in recvmsg self-deadlocks there unless the close is split into a
>>       __iucv_sock_close() that assumes the lock.
>
> I understand. Yes, that would be the way to go.
>
>
>>       That exact call already cost a CVE: 3589d20a666c ("net/iucv: fix locking
>>       in .getsockopt", CVE-2026-64004), which you reviewed and tested, fixed a
>>       NULL deref from getsockopt(SO_MSGSIZE) racing the iucv_sock_close() that
>>       recvmsg invokes at :1313. Locking getsockopt closed it because
>>       iucv_sock_close() takes the socket lock itself - which is also exactly why
>>       recvmsg cannot simply take it too.
>>
>>    b) skb_recv_datagram() doesn't release the socket lock while it waits, so a
>>       blocking recv would hold it across the sleep and stall backlog processing
>>       for the duration. __iucv_sock_wait already has the right shape for this
>>       (release_sock / schedule_timeout / lock_sock), but it changes recvmsg's
>>       blocking behaviour.
>
> I understand. I'm not sure I can judge all the implications, but your proposal makes
> sense to me.
>
> I wonder, if there is more required than taking and releasing the socket lock.
> e.g. I think recvmsg needs to check (sk->sk_state == IUCV_CONNECTED) before
> iucv_send_ctrl(sk, AF_IUCV_FLAG_WIN).
> But let's take it one by one.
>
>
>>
>> Staged plan
>> -----------
>>
>> Why split rather than send one rework: your caveat in f558120cd709 about return
>> values and "changes to all users of iucv" applies to the tasklet path, because
>> those handlers run from iucv_tasklet_fn while holding iucv_table_lock and
>> iucv_handler is shared with monreader, vmlogrdr, smsgiucv and hvc_iucv. It
>> doesn't apply to the HiperSockets path: afiucv_hs_rcv is a packet_type handler
>> in NET_RX softirq that owns the skb, so it can defer to the socket backlog with
>> no core change and no other driver touched.
>>
>> Stage 1, HiperSockets receive path. Add iucv_proto.backlog_rcv, hoist
>> bh_lock_sock from the individual afiucv_hs_callback_* into afiucv_hs_rcv, and
>> defer via sk_add_backlog() when the socket is owned. Put recvmsg under
>> lock_sock, with the two items above. Entirely inside af_iucv.c, and it's the
>> part you named.
>
> Sounds good to me
>
>> Stage 2, iucv tasklet path. This is where option A vs option B actually has to> be answered, and where the core and the four other iucv users are affected.
>> Option B subsumes it but needs iucv_tasklet_fn to stop holding iucv_table_lock
>> across handler dispatch, or dispatch moved to the existing iucv_work_fn.
>>
>> Stage 3, the writers holding no lock. No amount of owner-check discipline at
>> the other sites reaches these; they need a lock first. iucv_callback_connack is
>> unambiguous - same tasklet as connrej and shutdown, which already take
>> bh_lock_sock - so it can just do the same. I have that one ready as a
>> standalone patch if you want it independently.
>>
> That would be great, we are also working on several small fixes. Let's get them out of the way.
>
>> Questions
>> ---------
>>
>> Q1. For stage 1, is putting iucv_sock_recvmsg under lock_sock acceptable to
>>      you, given (b) changes its blocking behaviour? The alternative is to
>>      promote message_q.lock to the receive-path lock and move sk_state under it,
>>      which leaves recvmsg's sleep alone but makes message_q.lock cover something
>>      it doesn't cover today.
> No, I don't like that. message_q is a concept for iucv not HS - I see message_q.lock
> is already used in both paths, but I don't want to stretch it further.
> I prefer your proposal above and would like to test it with KASAN etc.
>
>> Q2. For stage 2, option A or option B? B is more invasive in net/iucv/iucv.c
>>      but makes Q1 and stage 3 moot. If you and Hidayath would rather own the
>>      core change, I'll do stage 1 and hand you the analysis for the rest.
>
> I would prefer option A: keep the tasklet and use bh_lock_sock(). You seem to
> think that is doable?
> Less invasive is attractive.
>
>
>> Q3. afiucv_hs_callback_txnotify runs in two contexts, which is why I didn't
>>      just add a lock to it: qeth_tx_poll (NAPI, softirq) and
>>      qeth_drain_output_queue (process, teardown) both reach it through
>>      qeth_notify_skbs. Which one should the locking be written for?
>>
> This is a tough one. Maybe we need to add a context parameter to qeth_notify_skbs() ?
>
>
>
>> Caveats
>> -------
>>
>> I have no IBM Z, so none of this is validated on real HiperSockets. herd7
>> proves the accesses race under LKMM; it says nothing about memory-safety
>> impact, which would need a KASAN run on hardware. Treat the model results as an
>> argument about which lock covers which write, not as a reproduction. I'd rely
>> on you or Hidayath to validate each revision on real HW before anything lands.
>
> Yes, we will validate any revision.
>
>
>> One coordination note: Hidayath's "net/af_iucv: fix use-after-free of listen
>> sock in iucv_callback_connreq()" is still open, and I'm deliberately not
>> touching that function. The staged plan resolves connreq as a consequence of
>> the general direction rather than competing with his patch.
>>
>> Prior discussion, for anyone picking this up cold:
>> https://lore.kernel.org/all/20260705-b4-disp-fc79c0dc-v1-1-d2cdcb57afa9@proton.me/
>> https://lore.kernel.org/all/20260707-b4-disp-783fedbb-v1-1-463b9dbda2ea@proton.me/
>> https://lore.kernel.org/all/20260706084825.6231-1-hidayath@linux.ibm.com/
>>
>> Thanks,
>> Bryam
>>
>>
> Thanks again for working on this. You identified several workitems, are there any
> where you would prefer me or Hidayath to work on?
> Otherwise we will continue with issues that are not on this list and work on
> running and improving our testcases.
Hi Bryam, Alexandra,

On a related note regarding accept_q: iucv_accept_poll() walks the 
parent's accept_q
with no lock at all, while iucv_accept_enqueue() appends from the IUCV 
tasklet and
the HiperSockets softirq under bh_lock_sock(parent). It doesn't show up 
in the sk_state
accounting because both accept_q walkers only read sk_state. I have a 
fix that takes
accept_q_lock for that walk and will send it to netdev as a standalone 
patch.

iucv_accept_dequeue() has the same problem, and I think it can also be 
fixed with
accept_q_lock rather than anything from the socket locking rework - 
though not by
simply wrapping the walk, since the loop body sleeps. It needs a 
preparatory patch
in iucv_callback_connreq() and afiucv_hs_callback_syn(), which are being 
touched by
the locking rework, so I'll hold both and rebase on your rework.

I also have a patch fixing sock/netdevice leaks on the connection 
request error
paths, in those same two functions. Just flagging it, since we will both 
be touching them.

Let me know how you'd like to sequence it.

Thanks,
Hidayath
