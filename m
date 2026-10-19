Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792432892;
	b=Lmmvg3pF7a2ZePZ46oGZCK8NBYFQBhruQltThMgOVt1TbIirpzU5GhF8dez3mz0fBMAe
	 t6kSdXh2yISeoiBU/1AAY7QlcvVs4Gsme4EtBPZOerJRQxmyJSJRAMheEI7fnn2J+WsOr
	 HtUqWyHA+VM2wEU/28mB67vNM6hGeK8ieO6jhcKXVgEZyEyUVzhfdDaFPKvng8kFKUGih
	 fPUE4pJerNdAl4o/iXl9twpK6GXk6Ss7M0enypkZxbUqLE1hxybSfbvE7NaVA3wuV8tP7
	 R+A+x1UkIYcLL0hsdBdqEegdTBAb3lmRUD5yIqpyGfjtSZ7ekrtW6EhI7O94rS0QWrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792432892;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=R7bjK9k8af+941nWh9vBRC0kl7Fz+IkhrlTF7NWIhds=;
	b=KNNyf7jIlNab+0w4/bSfmt/Zp4ZUxWbXUnvc30n0aIjVJ3EuCb7hAF7aWkNV19GSsUcd
	 K8TCPHn+UNGSkTXCg9BGT70oDilvRv+9xl2Xcj7DWRIfSl2IsDhepN4i0zPYrurIVbM6y
	 5+Uw06C1WeEsgdf8P7Z4twLyCChqbjXJov7hE5PqxxEJLkKRAebm0WASVP/rz807DlD10
	 eE+sjP3hvf6WJ8gg2ePbqUTRNyeiAvfp02rlw+URFbaj+CZfsdNBjFsYSsyXWBQdazWip
	 QF65H8T8iiu/w/9I2sZQ8I+hlX1VFeUe/3+sFi/8UmMB32p/Rk4JA/+z+q4hamctplA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dh0qeGBB;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B592606A31B;
	Mon, 19 Oct 2026 18:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B592606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dh0qeGBB
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69JFiZuW018909;
	Mon, 19 Oct 2026 18:01:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=R7bjK9
	k8af+941nWh9vBRC0kl7Fz+IkhrlTF7NWIhds=; b=dh0qeGBBp2dLFm7HQUNVux
	54OHhKrf9lJnSKjlD5nk4v2F9H4ubjhfpoxEuOcogCVA2fHYkgF4yBT/UKqLUlQ8
	MA3Ot1e3ow7w4A3nElGLbsmFdJ2jroVner4GgQkl+Enj1Z3sw9EVEWqZMEHr50v1
	OMNPa71BDgVPJFGVqXl/rZU7Qs2UINzYb79SXXybOGREN+rbXa1Chpn0EmrIWOIc
	rUElU5P83jMnPinS3z0Las02IvkB497Wj9EVf2R5Tmab+4abfvmdilXrPmM9SDl1
	8P1E+D8nuxupowBv4Mk0f1xLrxCG6fa1VCDuSHQgbEffWl9of5Q9jekDLxBmhaOA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hc0nvuxk0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 18:01:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69JFZ4Ln121747;
	Mon, 19 Oct 2026 18:01:18 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hckbq725y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 18:01:18 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69JI1H9N31850774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Oct 2026 18:01:17 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DD3258043;
	Mon, 19 Oct 2026 18:01:17 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05E6158063;
	Mon, 19 Oct 2026 18:01:12 +0000 (GMT)
Received: from [9.39.16.202] (unknown [9.39.16.202])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Oct 2026 18:01:11 +0000 (GMT)
Message-ID: <51a4a40a-f34b-4d41-b049-69aa53f4dcf5@linux.ibm.com>
Date: Mon, 19 Oct 2026 23:31:09 +0530
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/iucv: serialize HiperSockets receive with
 the socket lock
From: Hidayath Khan <hidayath@linux.ibm.com>
To: hexlabsecurity@proton.me, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Eric Dumazet <edumazet@kernel.org>,
        Alexandra Winter
 <wintera@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Cc: Nagamani PV <nagamani@linux.ibm.com>, netdev@vger.kernel.org,
        Simon Horman <horms@kernel.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261011-b4-disp-410518f4-v1-1-753bf3258292@proton.me>
 <82691101-92d7-4838-b16e-2e41a83f65d0@linux.ibm.com>
 <b3fea2ca-25ff-42c0-812c-f8cc6bb6667e@linux.ibm.com>
Content-Language: en-GB
In-Reply-To: <b3fea2ca-25ff-42c0-812c-f8cc6bb6667e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA3MCBTYWx0ZWRfXwc1efxJwSuKG
 DEmEy2+juRgOc5qHSWVCOdBrniJgEetYb1iKbYr0JaHLWCGLAfSj8z/HCtmPROWQ6rXZBXWWMyI
 8wXBcaAmYVMpbXKSj96do5kweBbJjIA=
X-Proofpoint-ORIG-GUID: R7-Q3bw7Ep_0U1qJ2xH8OvjqAS8J7edc
X-Proofpoint-GUID: R7-Q3bw7Ep_0U1qJ2xH8OvjqAS8J7edc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA3MCBTYWx0ZWRfX93LzB+7G3aQk
 CEG3BxsflIAgN6Ax9eQGJrv5ryGiH6JLuntD+UeiWNK3QYAswwsqM/BN3Ry/9I6hCRTQAia5NWI
 8U5bKWR8HgCP7eb1rBsIrsp8CfSOBgT91zOKqEPnUqaFWg7Y4TaQZT2zDNhdyCD+CJFRvC2eKe7
 /e3YJcb01ksf379hd59+CQJ5H+JflKAA5yPUz74h7fAbWQ3ikMUlxzs32PsPTUsTDxEP4QKZlDO
 d66KrFStR6LzqBXUBH2ddhNaznSOQkjHodKobAyZQ6AJPEQI/sfzuvgV2dKOmB/YdnvHKy2oNvu
 yAH3OWjN21olY98j3iUIJ0mKUUJvB36B1qZ4SWAIz0oVIV0Ms5clWHATjwDxXIrKdWkHQhciVMK
 cK3Etw41kGszvYCMz3O5o+reNf5iefpQz143SmCm8VvBIn/ixT8uXSZUhUyoqFPPoIPy4Pjsnzp
 baEdM9tfnS3VZA5nbeQ==
X-Authority-Analysis: v=2.4 cv=MY35KJ/f c=1 sm=1 tr=0 ts=6ad65aef cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=f2YgsfARznCW2v20OWYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190070


On 18/10/26 12:08 am, Hidayath Khan wrote:
>
> On 14/10/26 4:42 am, Hidayath Khan wrote:
>> Hi Bryam,
>>
>> Below are the test results for this stage 1 patch on z/VM.
>>
>> Setup: one z/VM guest, two HiperSockets hsuids, two CPUs, af_iucv as a
>> module, and an AF_IUCV socket-locking reproducer. Both kernels have 
>> the same
>> config - CONFIG_KASAN=y, CONFIG_PROVE_LOCKING=y and
>> CONFIG_DEBUG_ATOMIC_SLEEP=y - so the only variable is the patch.
>>
>>   scenario     net-next,               patch
>>   sk_shutdown  fail, 271-299 misses    pass, 0 in 9058 cycles
>>   shut_rd      fail, fail, pass        pass, 0 in 29 cycles
>>   recvrecv     fail, 3658-4139 back.   pass, 0 out-of-order in 
>> 4194304 words
>>   backlog      pass                    pass
>>   rxclose      fail, 16-17 of 35-38    fail, 14 of 57
>>   spin         fail, 2020-2190 ms CPU  fail, 2070 ms CPU
>>
>> No KASAN, lockdep or DEBUG_ATOMIC_SLEEP report on either kernel, in 
>> dmesg or
>> the journal - so nothing reports here either way, and the patch 
>> introduces
>> nothing. Since this patch adds local_bh_disable() around the backlog 
>> replay,
>> moves __iucv_sock_close() into recvmsg() under lock_sock() and holds 
>> the socket
>> lock across copy_to_user(), that was the result I was most interested 
>> in.
>>
>> backlog passed on both - it is a guard rather than a reproducer, and 0
>> frames lost over roughly 1.1 million ownership windows on net-next 
>> confirms
>> it has no discriminating power here, so it says nothing either way.
>>
>> shut_rd is too flaky to lean on: on net-next it failed with 2 misses 
>> in 43
>> cycles and 3 in 35, then passed with 0 in 45. So its single pass with 
>> the
>> patch is not evidence. Its window is now narrow enough that 30 s 
>> under KASAN
>> is not enough cycles; I will re-run it much longer.
>>
>> sk_shutdown and recvrecv are the solid ones. recvrecv is what I would 
>> point
>> at: two readers interleaving inside an unlocked iucv_sock_recvmsg() went
>> backwards 3658, 3896 and 4139 times across the three net-next runs 
>> and not
>> once with your patch.
>>
>> rxclose fails on both, on the -ENOTCONN that Sashiko flags as Low: 17 
>> of 37,
>> 17 of 38 and 16 of 35 on net-next against 14 of 57 with your patch. 
>> Lower
>> with the patch, but that is one patched run against three, so I would 
>> not
>> read much into the difference. 0 lost tails in every run - though the
>> lost-tail check only runs on cycles that reached EOF, so the failing 
>> cycles
>> are not data-checked. The test counts any errno other than EINTR and 
>> EAGAIN
>> as a wrong termination, which is why -ENOTCONN shows as a failure.
>>
>> The asymmetry is that recvmsg()'s shortcut gives EOF on IUCV_DISCONN 
>> with
>> the queues empty, while iucv_sock_recv_skb() gives -ENOTCONN on
>> sk_state != IUCV_CONNECTED. Either the loop returns EOF for IUCV_DISCONN
>> with nothing queued, or afiucv_hs_callback_fin() sets RCV_SHUTDOWN as 
>> well -
>> that one is a single line but also changes what callback_rx() drops 
>> and what
>> iucv_sock_poll() reports. I have tried neither. Which behaviour do 
>> you want?
>>
>> spin fails on both, and by the same margin: 2020, 2150 and 2190 ms of 
>> CPU
>> while blocked about 3000 ms on net-next, 2070 ms with your patch.
>> __iucv_sock_wait() still calls prepare_to_wait() once, outside its 
>> loop, so
>> after the first schedule_timeout() the task is TASK_RUNNING. Outside 
>> your
>> diff, and a different bug from the missed wakeup you fix at the same 
>> call
>> site. One-liner; I will send it separately.
>>
>> On KASAN specifically, so an empty result is not read as a gap: there 
>> will
>> be no KASAN report from these scenarios even on a KASAN kernel. The
>> reproducer does scan /dev/kmsg for KASAN and KCSAN reports and fails a
>> scenario on any hit, but stage 1's defects are missing locks - they 
>> surface
>> as lost data, a lost sk_shutdown bit, a wrong errno or a leaked 
>> socket, none
>> of which touch freed or out-of-bounds memory. KASAN is a clean-run 
>> control
>> here. KCSAN is what can witness the accesses still left unlocked; 
>> note that
>> it generally does not flag volatile accesses, so it may not show 
>> sk_state
>> races either. A KCSAN run is next.
>>
>> Sashiko's three budget findings look to me like instances of one 
>> thing, and
>> it says so itself on the SO_MSGLIMIT case: stream data is "lost 
>> without any
>> error". A frame that does not fit is dropped with nothing but
>> sk_drops_inc() and kfree_skb_reason(). Resizing a budget per instance 
>> leaves
>> the next one open.
>>
>> Sashiko's three budget findings look like one thing: a frame that 
>> does not fit
>> is dropped with only sk_drops_inc() and kfree_skb_reason(), so 
>> resizing a
>> budget per instance leaves the next one open. Would you take a patch 
>> on top
>> that makes the loss visible instead - the softirq sets a bit in 
>> iucv_sock, and
>> iucv_sock_release_cb() turns it into sk_err = ECONNRESET plus 
>> IUCV_DISCONN once
>> the owner lets go? Separately: would it be simpler not to defer
>> a pure WIN at all? afiucv_hs_callback_win() is only an atomic_sub() and
>> iucv_sock_wake_msglim().
>>
>> Thanks,
>> Hidayath
>>
>
> Hi Bryam,
>
> Follow-up to the earlier KASAN + PROVE_LOCKING + DEBUG_ATOMIC_SLEEP 
> results.
>
> I ran the same reproducer on the same z/VM guest with a KCSAN build of 
> your
> patch, interrupt watcher on. KCSAN found two af_iucv data races. Both
> appeared during the sk_shutdown scenario. The second also appeared 
> once in
> rxclose scenario. I have the full KCSAN reports from /dev/kmsg now, so
> the fields below are from them rather than from reading the code.
>
> 1) sk->sk_shutdown, 1 byte, same address on both sides.
>
> A marked read in afiucv_hs_callback_rx(), inlined into 
> afiucv_hs_dispatch():
>
>     if (READ_ONCE(sk->sk_shutdown) & RCV_SHUTDOWN)
>
> by interrupt on one CPU, against the plain read-modify-write in
> iucv_sock_shutdown():
>
>     sk->sk_shutdown |= how;
>
> by task on the other CPU. The report gives the contexts as interrupt 
> and task;
> that the writer holds lock_sock() is from the source - 
> iucv_sock_shutdown()
> takes it on entry and that line is on every path to it.
>
> The receive side must have come through the !afiucv_hs_defer() bypass 
> rather
> than the !sock_owned_by_user() arm. The writer holds lock_sock(), so
> sk_lock.owned is set and slock is free; the reader runs inside 
> bh_lock_sock(),
> which is slock. For the two to overlap, the task must have finished
> lock_sock() before the softirq took slock - so sock_owned_by_user() 
> was true
> when the softirq checked it. On the other arm the softirq holds slock 
> while
> nobody owns the socket, and a task entering lock_sock() blocks on 
> slock until
> the callback returns, so it cannot reach the write.
>
> That is the window I asked you about in the previous comment, where a 
> frame
> can also be queued after shutdown(SHUT_RD)'s skb_queue_purge(), and 
> which I
> could not get to fire functionally. It has a KCSAN report behind it now.
>
> Making the write a WRITE_ONCE() would silence KCSAN and fix nothing. The
> frame-after-purge behaviour looks like an ordering problem.
>
> 2) iucv->hs_dev, 8 bytes, same address on both sides.
>
> A plain read in afiucv_hs_rcv()'s socket-lookup loop:
>
>     if (iucv_sk(sk)->hs_dev != dev)
>
> by interrupt, with only read_lock(&iucv_sk_list.lock) held, against 
> the plain
> write in __iucv_sock_close():
>
>     iucv->hs_dev = NULL;
>
> by task, from an ordinary close() - the stack is iucv_sock_release ->
> sock_close -> __fput -> sys_close, so the socket lock is held there.
>
> The read is the ingress check added by Alexandra's 80230a18c164 and the
> write was already there, so neither line is from your patches.
> I do not think it needs locking: the lookup is inherently racy with 
> close,
> since the socket can be closed between the match and the dispatch however
> well hs_dev is synchronised. I think both outcomes are harmless - 
> observing
> NULL early drops a frame that was about to be dropped anyway, and 
> observing a
> stale pointer gets the frame as far as the callbacks, which drop it on
> sk_state. So I think the right treatment is READ_ONCE()/WRITE_ONCE() 
> on the
> two accesses with a comment saying the lookup read is deliberately
> unsynchronised, rather than anything structural. Tell me if you see it
> differently.
>
> One more thing in the same function. __iucv_sock_close() does
>
>     dev_put(iucv->hs_dev);
>     iucv->hs_dev = NULL;
>
> so between those two statements hs_dev names a device this socket no 
> longer
> holds a reference to, and the lookup loop can match on it. Clearing 
> before
> the put removes that window - via a local, since swapping the lines as 
> they
> stand would dev_put(NULL) and leak the reference:
>
>     struct net_device *dev = iucv->hs_dev;
>
>     if (dev) {
>         iucv->hs_dev = NULL;
>         sk->sk_bound_dev_if = 0;
>         dev_put(dev);
>     }
>
> The test run also has 500+ KCSAN reports with skb_copy_bits / 
> __might_fault.
> All of them have
> afiucv_hs_rcv() -> pskb_may_pull() -> __pskb_pull_tail() in the stack.
> The conflict is on current->pagefault_disabled not skb data, so I 
> don't think
> either of your patches is involved.
>
> Functionally the KCSAN kernel showed nothing new - the same rxclose 
> and spin
> failures as previous comment, everything else is clean.
>
> Thanks,
> Hidayath

Hi Bryam,


Two more things since my last note: I ran the KCSAN build on plain net-next
as well, so the two kernels can be compared directly, and I gave every
scenario 120 s instead of 30 s. Same z/VM guest and same config as before.
Only the new results are below, so this is shorter than the last one.

Longer runs, same conclusion as before

     sk_shutdown  net-next 565 misses / 7281 cycles   patch 0 / 12771
     recvrecv     net-next 3917 backwards reads       patch 0 / 4 Mi words
     shut_rd      net-next 32 misses / 212 cycles     patch 0 / 150
     rxclose      net-next 51 of 906                  patch 40 of 1766

shut_rd is the one worth an update, since I said last time its single pass
was not evidence. With more cycles net-next now fails it consistently - 32
misses in 212 cycles - and the patched kernel is still at zero. So I am
happier leaning on it now.

rxclose is still the -ENOTCONN, but with more cycles the two rates separate
a little more clearly: 5.6% of cycles on net-next against 2.3% with your
patch.

The KCSAN picture, now with a baseline

Last time I said "both races predate your patch" was read off the source
rather than measured. The net-next run settles it, and it also shows the
reports changing in kind rather than only in number.

On net-next, 29 reports name af_iucv on both sides of the BUG line:

     19 x iucv_sock_recvmsg / iucv_sock_shutdown
      6 x afiucv_hs_rcv / iucv_send_ctrl
      2 x iucv_send_ctrl / iucv_sock_shutdown
      2 x afiucv_hs_rcv / iucv_sock_shutdown

With your patch applied, none of those four pairs appear at all. What is
left is 2 reports, and they are the two I sent you last time - the
sk_shutdown bypass and iucv->hs_dev. So the recvmsg-without-a-lock races go
away, which is the main thing the patch set out to do.

The hs_dev pair did not come up in the net-next run itself. That run was
dominated by the recvmsg pair, so I would not read anything into its
absence, and the two accesses are the same in both trees.

A blocked reader: the -ENOTCONN question, now with a number

I added a scenario for this, since nothing was covering it directly. A
reader blocks on an empty queue, nothing is ever sent, the peer closes, and
the test measures the wakeup and the return value separately. Half the
cycles have a task holding the socket lock when the FIN arrives, so the
frame goes through the backlog.

The wakeup side looks good: 14151 cycles, mean 0 ms, worst 21 ms with the
socket owned and 29 ms without, against a 200 ms limit, zero late and zero
stuck. So iucv_sock_recv_skb() is doing its job on that count.

The return value is -ENOTCONN in 14151 of 14151 cycles. Never 0. On
net-next it is 13627 of 13627, also never 0, with the wakeup equally
prompt.

So this is the same asymmetry I asked you about last time, but it is not an
edge case - it is every blocked reader, on both kernels. rxclose only sees
it in 2.3% of cycles because its reader goes back into recvmsg and hits the
shortcut at the top; a reader that was already parked when the FIN arrived
gets -ENOTCONN every time.

Nothing new from me on which of the two fixes to take - still your call,
and I am happy to test either. I am only sending the number because it
moves this from a corner case to the ordinary "block until the peer closes"
pattern, so it may deserve a bit more weight than Low.

New: SO_MSGLIMIT in IUCV_BOUND can lose stream data

This one only applies to your patch, since net-next has no budget - the
scenario passes there over 2613 in-window cycles.

The comment above afiucv_hs_backlog_add() describes the assumption:

     a peer that keeps to the window has at most msglimit data frames
     and one SHT waiting

The peer does keep to the window. What changes is the local msglimit, after
the window has already been advertised. iucv_sock_setsockopt() accepts
SO_MSGLIMIT in IUCV_OPEN and IUCV_BOUND, and a HiperSockets socket stays in
IUCV_BOUND from the SYN until the SYN|ACK arrives - iucv_sock_connect()
sends the SYN and then waits, and IUCV_CONNECTED is only set in
afiucv_hs_callback_synack(). The SYN carries

     if (flags == AF_IUCV_FLAG_SYN)
         phs_hdr->window = iucv->msglimit;

and the peer keeps that as msglimit_peer. So a setsockopt() inside that
window leaves the peer with credit for the old msglimit while the budget is
computed as READ_ONCE(iucv->msglimit) + 1 from the new one.

What the test does: raise SO_MSGLIMIT to 64, issue a non-blocking
connect(), lower it to 2, then have the peer send 62 sequenced messages
while a second thread holds the socket lock, so the frames are deferred
instead of taking the bypass. Whether a cycle really landed in the window is
measured rather than assumed, since setsockopt() returns 0 for SO_MSGLIMIT
only in IUCV_OPEN and IUCV_BOUND.

     6297 cycles, 5947 landed in IUCV_BOUND
     1 cycle lost one 256-byte message, which never arrived even after a
       12000 ms grace period
     0 cycles were merely slow

I also enabled the skb:kfree_skb tracepoint filtered to
SKB_DROP_REASON_SOCKET_BACKLOG, and it recorded exactly one event for that
run. One drop, one lost message.

To be fair about the rate: that is about once in 370000 messages, so the
window is narrow. This is the same silent-loss shape as the budget findings
I mentioned last time, just with a path into it from userspace rather than
from the peer.

Two questions, both yours to decide. Is the budget meant to follow the
current msglimit, or the window that was actually advertised? msglimit_peer
already holds the number the peer was granted. And would it make sense to
refuse SO_MSGLIMIT once the SYN has gone out?

One unrelated thing, for information only

While running the device-teardown scenario, KCSAN also reported
afiucv_netdev_event() walking iucv_sk_list without
read_lock(&iucv_sk_list.lock):

     BUG: KCSAN: data-race in afiucv_netdev_event / iucv_sock_alloc
     write (marked) to 0x...3c8 of 8 bytes by task:
      iucv_sock_alloc+0x374 -> hlist_add_head, list.h:1093
                               (inlined by) iucv_sock_link, af_iucv.c:321
     read to 0x...3c8 of 8 bytes by task:
      afiucv_netdev_event+0x5c -> af_iucv.c:2397, sk_for_each()
     value changed: 0x0000000082781068 -> 0x000000008923a868

The list pointer changed value while the walk was in progress. That
function is untouched by your patch and reads the same on net-next, so it
is outside this discussion. Mentioning it only so it does not look
like something your patch left open.

Thanks,
Hidayath
>
