Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7401F38F658;
	Sat, 17 Oct 2026 18:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792262327; cv=none; b=uAewVec1S0zP+eaJsvcxyw7HvzPHaGXHkXQNSiDQlIDLi7BOEUbf7jcFH3StNmDpy0t6jW9Y/HGGiGCZJKK3wIda58rrMBaSrBmdGE8nZFH2SBsWQrj75B/Qd9PARgnXrH39wgWBsl59BWhbkl1E8R0kklS4OaPrxzgSvYQRW2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792262327; c=relaxed/simple;
	bh=mR3X7Et62rzhOzOuYKvZJSgO3a+/cXS0iv95+BOXGzM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UL4XwxiCB3M6K1Tx4sq6lkr9uYV1eLN2iuwKN0dwU+dEwxF9BRv3fTMmr6UyjSo86BzSn1mx5gOoGI3T3ZfK8++sNdORVW6Zf5E+E35eHvp41QSO7HORZTEDO8OE16dclnp0BZH+V6ks1B04ouc4MdDNh3BVF3Kj8eE1EbBpheY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JY1o1PPW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JY1o1PPW"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69HGELWB1694786;
	Sat, 17 Oct 2026 18:38:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sV8k8u
	KiPwIpoH+iPNDpLTJKd2KZy3uAHtLYkOB7PHM=; b=JY1o1PPW3Dzz3benHmqNal
	4DQ13cCYP26MFyilc/F/IexrKeglSHVxVQJrqSsUmKzJBmWO5rSVSPdt/Od6UiuF
	DTN3CJLmhg/pUy9+WjzFsO/4HnXgKBkC0IQXv8fyypJZrJJvF9g+T7k34hbnNJaO
	eogtSbitzdzEN7qTLU3cAfq/qtxaSmzPywYuc2XOrJPsUv5z4zLO+9zHpvmXZviU
	Gllpj08FlSAoR0266yLPdPD+qILByNWfmF27s9I0tpeAa6oFSW5VGgSM/MR4C2xh
	pmLB6K3by4uMXhumgQ6DAn+xlKHbqGBqEXE7eEYysOx9XutZEfryVPNLNrxoyiAg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hbyepjqmm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 17 Oct 2026 18:38:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69HGJxhj1277496;
	Sat, 17 Oct 2026 18:38:35 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hb2398uf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Oct 2026 18:38:35 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69HIcXRJ18875092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Oct 2026 18:38:33 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5A8D5805A;
	Sat, 17 Oct 2026 18:38:33 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A13A58054;
	Sat, 17 Oct 2026 18:38:23 +0000 (GMT)
Received: from [9.124.218.28] (unknown [9.124.218.28])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 17 Oct 2026 18:38:22 +0000 (GMT)
Message-ID: <b3fea2ca-25ff-42c0-812c-f8cc6bb6667e@linux.ibm.com>
Date: Sun, 18 Oct 2026 00:08:20 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
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
Content-Language: en-GB
In-Reply-To: <82691101-92d7-4838-b16e-2e41a83f65d0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDA3MiBTYWx0ZWRfX9NsYmertedEJ
 m6sic1V/MsT3AoR3tkD5miyyQdu5wV7HmpKMyBUJAeNH/NS4F9qYOT5wC31CvRuUmMBQgM6vFfh
 vT4ohNVSKhp76C5YqsfjzdwB4dTWpPk=
X-Authority-Analysis: v=2.4 cv=Z4R5j3RA c=1 sm=1 tr=0 ts=6ad3c0ab cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=ONCzwkjdCOutVcZFL8EA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: w-wWgCBLo3mk7c_vQh6cgVv1LyXx0Wxd
X-Proofpoint-GUID: w-wWgCBLo3mk7c_vQh6cgVv1LyXx0Wxd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDA3MiBTYWx0ZWRfX2xMRbztcQ6j5
 mQskDc/6XccpjcF8dybz8RP3+7jkSIYrqceo7LWLVegss5nQtlzaCPo4fssbWBBf12Dbcz3AfJ8
 mhRr/ZEV5siKQKV9GLR3Ix5GueBECL2b7t+cNkTCLNMLumjjAJKgqhh6J1kGY68Ep8f5tsXJOdV
 LSHi7X7wpG7qJiAdCMrP/xIMx/GpUw6OOaH9hIHYYb6FbKu8ZTCf0zB7ZdZ4RQmoRmEmw1NxEzl
 Nuh2+5AxiD9uGMA3Vx9Qj8Mytfl9XoeR841Jy/yqNsmzjd0LL8rpEL5YA89U2PFCpsEY+sh31KN
 KnRMWSQ5rCkF8++Q5606WW3TL3zYCEjEh9DP15zKp+bYxexDrW+XG4HN2OMaILDqmNYuunKqfE9
 YQD32BdCoOe4oEeZKrzEjXDcaAb60yV6qgkp5wf3O2YxWZdAlwGjZuwc09Q03Bthrxc7XRYYqau
 mi26+ad+9c6K0tyGrew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610170072


On 14/10/26 4:42 am, Hidayath Khan wrote:
> Hi Bryam,
>
> Below are the test results for this stage 1 patch on z/VM.
>
> Setup: one z/VM guest, two HiperSockets hsuids, two CPUs, af_iucv as a
> module, and an AF_IUCV socket-locking reproducer. Both kernels have 
> the same
> config - CONFIG_KASAN=y, CONFIG_PROVE_LOCKING=y and
> CONFIG_DEBUG_ATOMIC_SLEEP=y - so the only variable is the patch.
>
>   scenario     net-next,               patch
>   sk_shutdown  fail, 271-299 misses    pass, 0 in 9058 cycles
>   shut_rd      fail, fail, pass        pass, 0 in 29 cycles
>   recvrecv     fail, 3658-4139 back.   pass, 0 out-of-order in 4194304 
> words
>   backlog      pass                    pass
>   rxclose      fail, 16-17 of 35-38    fail, 14 of 57
>   spin         fail, 2020-2190 ms CPU  fail, 2070 ms CPU
>
> No KASAN, lockdep or DEBUG_ATOMIC_SLEEP report on either kernel, in 
> dmesg or
> the journal - so nothing reports here either way, and the patch 
> introduces
> nothing. Since this patch adds local_bh_disable() around the backlog 
> replay,
> moves __iucv_sock_close() into recvmsg() under lock_sock() and holds 
> the socket
> lock across copy_to_user(), that was the result I was most interested in.
>
> backlog passed on both - it is a guard rather than a reproducer, and 0
> frames lost over roughly 1.1 million ownership windows on net-next 
> confirms
> it has no discriminating power here, so it says nothing either way.
>
> shut_rd is too flaky to lean on: on net-next it failed with 2 misses 
> in 43
> cycles and 3 in 35, then passed with 0 in 45. So its single pass with the
> patch is not evidence. Its window is now narrow enough that 30 s under 
> KASAN
> is not enough cycles; I will re-run it much longer.
>
> sk_shutdown and recvrecv are the solid ones. recvrecv is what I would 
> point
> at: two readers interleaving inside an unlocked iucv_sock_recvmsg() went
> backwards 3658, 3896 and 4139 times across the three net-next runs and 
> not
> once with your patch.
>
> rxclose fails on both, on the -ENOTCONN that Sashiko flags as Low: 17 
> of 37,
> 17 of 38 and 16 of 35 on net-next against 14 of 57 with your patch. Lower
> with the patch, but that is one patched run against three, so I would not
> read much into the difference. 0 lost tails in every run - though the
> lost-tail check only runs on cycles that reached EOF, so the failing 
> cycles
> are not data-checked. The test counts any errno other than EINTR and 
> EAGAIN
> as a wrong termination, which is why -ENOTCONN shows as a failure.
>
> The asymmetry is that recvmsg()'s shortcut gives EOF on IUCV_DISCONN with
> the queues empty, while iucv_sock_recv_skb() gives -ENOTCONN on
> sk_state != IUCV_CONNECTED. Either the loop returns EOF for IUCV_DISCONN
> with nothing queued, or afiucv_hs_callback_fin() sets RCV_SHUTDOWN as 
> well -
> that one is a single line but also changes what callback_rx() drops 
> and what
> iucv_sock_poll() reports. I have tried neither. Which behaviour do you 
> want?
>
> spin fails on both, and by the same margin: 2020, 2150 and 2190 ms of CPU
> while blocked about 3000 ms on net-next, 2070 ms with your patch.
> __iucv_sock_wait() still calls prepare_to_wait() once, outside its 
> loop, so
> after the first schedule_timeout() the task is TASK_RUNNING. Outside your
> diff, and a different bug from the missed wakeup you fix at the same call
> site. One-liner; I will send it separately.
>
> On KASAN specifically, so an empty result is not read as a gap: there 
> will
> be no KASAN report from these scenarios even on a KASAN kernel. The
> reproducer does scan /dev/kmsg for KASAN and KCSAN reports and fails a
> scenario on any hit, but stage 1's defects are missing locks - they 
> surface
> as lost data, a lost sk_shutdown bit, a wrong errno or a leaked 
> socket, none
> of which touch freed or out-of-bounds memory. KASAN is a clean-run 
> control
> here. KCSAN is what can witness the accesses still left unlocked; note 
> that
> it generally does not flag volatile accesses, so it may not show sk_state
> races either. A KCSAN run is next.
>
> Sashiko's three budget findings look to me like instances of one 
> thing, and
> it says so itself on the SO_MSGLIMIT case: stream data is "lost 
> without any
> error". A frame that does not fit is dropped with nothing but
> sk_drops_inc() and kfree_skb_reason(). Resizing a budget per instance 
> leaves
> the next one open.
>
> Sashiko's three budget findings look like one thing: a frame that does 
> not fit
> is dropped with only sk_drops_inc() and kfree_skb_reason(), so resizing a
> budget per instance leaves the next one open. Would you take a patch 
> on top
> that makes the loss visible instead - the softirq sets a bit in 
> iucv_sock, and
> iucv_sock_release_cb() turns it into sk_err = ECONNRESET plus 
> IUCV_DISCONN once
> the owner lets go? Separately: would it be simpler not to defer
> a pure WIN at all? afiucv_hs_callback_win() is only an atomic_sub() and
> iucv_sock_wake_msglim().
>
> Thanks,
> Hidayath
>

Hi Bryam,

Follow-up to the earlier KASAN + PROVE_LOCKING + DEBUG_ATOMIC_SLEEP results.

I ran the same reproducer on the same z/VM guest with a KCSAN build of your
patch, interrupt watcher on. KCSAN found two af_iucv data races. Both
appeared during the sk_shutdown scenario. The second also appeared once in
rxclose scenario. I have the full KCSAN reports from /dev/kmsg now, so
the fields below are from them rather than from reading the code.

1) sk->sk_shutdown, 1 byte, same address on both sides.

A marked read in afiucv_hs_callback_rx(), inlined into afiucv_hs_dispatch():

     if (READ_ONCE(sk->sk_shutdown) & RCV_SHUTDOWN)

by interrupt on one CPU, against the plain read-modify-write in
iucv_sock_shutdown():

     sk->sk_shutdown |= how;

by task on the other CPU. The report gives the contexts as interrupt and 
task;
that the writer holds lock_sock() is from the source - iucv_sock_shutdown()
takes it on entry and that line is on every path to it.

The receive side must have come through the !afiucv_hs_defer() bypass rather
than the !sock_owned_by_user() arm. The writer holds lock_sock(), so
sk_lock.owned is set and slock is free; the reader runs inside 
bh_lock_sock(),
which is slock. For the two to overlap, the task must have finished
lock_sock() before the softirq took slock - so sock_owned_by_user() was 
true
when the softirq checked it. On the other arm the softirq holds slock while
nobody owns the socket, and a task entering lock_sock() blocks on slock 
until
the callback returns, so it cannot reach the write.

That is the window I asked you about in the previous comment, where a frame
can also be queued after shutdown(SHUT_RD)'s skb_queue_purge(), and which I
could not get to fire functionally. It has a KCSAN report behind it now.

Making the write a WRITE_ONCE() would silence KCSAN and fix nothing. The
frame-after-purge behaviour looks like an ordering problem.

2) iucv->hs_dev, 8 bytes, same address on both sides.

A plain read in afiucv_hs_rcv()'s socket-lookup loop:

     if (iucv_sk(sk)->hs_dev != dev)

by interrupt, with only read_lock(&iucv_sk_list.lock) held, against the 
plain
write in __iucv_sock_close():

     iucv->hs_dev = NULL;

by task, from an ordinary close() - the stack is iucv_sock_release ->
sock_close -> __fput -> sys_close, so the socket lock is held there.

The read is the ingress check added by Alexandra's 80230a18c164 and the
write was already there, so neither line is from your patches.
I do not think it needs locking: the lookup is inherently racy with close,
since the socket can be closed between the match and the dispatch however
well hs_dev is synchronised. I think both outcomes are harmless - observing
NULL early drops a frame that was about to be dropped anyway, and 
observing a
stale pointer gets the frame as far as the callbacks, which drop it on
sk_state. So I think the right treatment is READ_ONCE()/WRITE_ONCE() on the
two accesses with a comment saying the lookup read is deliberately
unsynchronised, rather than anything structural. Tell me if you see it
differently.

One more thing in the same function. __iucv_sock_close() does

     dev_put(iucv->hs_dev);
     iucv->hs_dev = NULL;

so between those two statements hs_dev names a device this socket no longer
holds a reference to, and the lookup loop can match on it. Clearing before
the put removes that window - via a local, since swapping the lines as they
stand would dev_put(NULL) and leak the reference:

     struct net_device *dev = iucv->hs_dev;

     if (dev) {
         iucv->hs_dev = NULL;
         sk->sk_bound_dev_if = 0;
         dev_put(dev);
     }

The test run also has 500+ KCSAN reports with skb_copy_bits / 
__might_fault.
All of them have
afiucv_hs_rcv() -> pskb_may_pull() -> __pskb_pull_tail() in the stack.
The conflict is on current->pagefault_disabled not skb data, so I don't 
think
either of your patches is involved.

Functionally the KCSAN kernel showed nothing new - the same rxclose and spin
failures as previous comment, everything else is clean.

Thanks,
Hidayath
