Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1AD43B3E2;
	Tue,  4 Aug 2026 08:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785832394; cv=none; b=OPnIi9P7YD8S1M9RejlhIuB+rLyXhMEhf+9/ehMJQig65oU4/DRLE8rUni4Nw0HlMMrBOYxO2XNoPIm4AP+E47V9sHHmqkPgddnF8KSDizvVJ1SVJ22kXfHVGCGoMpJKWWLsVBhOXuFy1nR7rKBXJ8ASTG05XhIY+q2l/K/2AkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785832394; c=relaxed/simple;
	bh=4H8YaPKvU7z9ldKF02BCWLUqxmOOD3+PPdE1h82yTY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T+Nk+PXpMn7XalllJkX+O9T/bc/doIHkOkDzDt5jALs7UvcGA+MM7hQHfpYWOqtYu3xcFsyPrm5uBreOcfokxvx1+NuEJr3VNIrmS7f6Bv1AJNeK+JmsMFYcpNQdcHrKnqKr9RHTA0gdbESVyFJ3bw+1vhaffFeMNw8mzwK1E/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sW3NjUb4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sW3NjUb4"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6748Hulc236730;
	Tue, 4 Aug 2026 08:33:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SdRKvs
	6kPYlCAUvmapjyp5JQ8+eqk34UJeLzWHXsD2E=; b=sW3NjUb4ADvHQHJaPxVVPj
	pREtOzOBeZuoRhlgq9KMIzkoJ19nKpmfkzTWZeLdHs3MNxtHxiVjKKoIcthCMIhx
	VavK/Q30yG/gy/g3xI8zk13cEQqnF04wvTl6ozwjQwxh0WrbviwET00p0NQ6Nd/m
	IOBBoRWFxd2r1bhAw4QjWdVBsxERElxn/u/AAqfrG7aYSkOjr8gMbf5TukoP7WQL
	BrcAuo6EXdCiwoE2hrra9iQZP/w22NnA8I+UmUoMF/t5zQLhF7xx2jhE6GiPFixK
	llt8gQeljWGAU0mO2YMo/wgV+Byol9FwH/vvbDSVqbCxCcNgsrNdDjMSUNVogtvg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77g4pfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 08:33:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6748BwqR005959;
	Tue, 4 Aug 2026 08:33:06 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugw189w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 08:33:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6748X2L248759272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 08:33:02 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71C572004D;
	Tue,  4 Aug 2026 08:33:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E27C20043;
	Tue,  4 Aug 2026 08:33:02 +0000 (GMT)
Received: from [9.224.94.95] (unknown [9.224.94.95])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 08:33:02 +0000 (GMT)
Message-ID: <9cda0e57-ce4b-428b-9385-743fdef02789@linux.ibm.com>
Date: Tue, 4 Aug 2026 10:33:02 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/iucv: fix UAF in afiucv_netdev_event()
To: Nagamani PV <nagamani@linux.ibm.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: horms@kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        twinkler@linux.ibm.com, heiko.carstens@de.ibm.com,
        hidayath@linux.ibm.com, borntraeger@linux.ibm.com,
        stable@vger.kernel.org
References: <20260803182053.2355882-1-nagamani@linux.ibm.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20260803182053.2355882-1-nagamani@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA2NCBTYWx0ZWRfXxqEkXfUlEy19
 9djxHXMfSZSy07x/WrzMV5GJi2XwNXSNuK7tr90K1+SLcWW53WWbykaxDKgIdi/VykMeZdxwqr3
 xTki/bZdK7aPINn8rOYTfEjRn1HR6tVarTRNlhzrMCuavewU8Cpgu05D6lOgfDGob8igjvwSBvn
 imAdhQMkxphq3nJ5kCTziBFvaJrGOctwyAAvgW/NnN5r/pvjiyeGel7rcDTJaBgMSdWU1ECkWP8
 F/rGuHtRuH1qOuZY1Iqhev2uvlriTkgDG/tnqWyi/j+t3lUd9Nzlk2ubrFoE/C80DmO+SDVBWkk
 E0n3L5RWvYlIfqf5fwNNuKRHZ0OajUiKODY7DZZjxREWhWMrYebUfT6QEVsfGkGtKyg66Gg3QwP
 tu3Ey71izdarDuudbgsQvNf6aQv5KzJtY+Ys0mLeh2op6lyTn8Qfo+vtX1d3jpJf03ndmtRhcHD
 TiaDJJku14mnsgskz8A==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a71a3c3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=uVe4GPN_aIkUaB-KmjYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: QLmbgmNpbF93mjvzHpfemKNJNBLlvUa1
X-Proofpoint-ORIG-GUID: vt8loBXEU42YFhu6Rxxy9_v0KfACujKk
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA2NCBTYWx0ZWRfX9GYJdh023BEj
 WW7NBAIky62NEm9vM0LecVpcQ0mXdnczaNZHV0npL08IOJq1PAL8WIIarQEGjqRVsn+TaP2Eplu
 cPAyF6+e6xMzG7Ke280JRQrf81Nhr0c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040064



On 03.08.26 20:20, Nagamani PV wrote:
> afiucv_netdev_event() traverses iucv_sk_list without holding
> iucv_sk_list.lock.
> 
> A concurrent socket teardown can unlink and free an af_iucv socket via
> iucv_sock_kill() while the netdevice notifier path is still traversing
> the list, resulting in a use-after-free when dereferencing the socket.
> 
> syzbot reported a KASAN slab-use-after-free triggered from the netdevice
> notifier path:
> 
>   BUG: KASAN: slab-use-after-free in afiucv_netdev_event+0x166/0x570
>   Read of size 8 at addr 001a54009dcda368 by task syz.3.24/516
> 
>   Call Trace:
>     afiucv_netdev_event+0x166/0x570 net/iucv/af_iucv.c:2193
>     notifier_call_chain+0x18e/0x510 kernel/notifier.c:85
>     call_netdevice_notifiers net/core/dev.c:2301 [inline]
>     __dev_close_many+0x1c6/0x680 net/core/dev.c:1747
>     unregister_netdevice_many_notify+0x9b6/0x2650 net/core/dev.c:12388
>     unregister_netdevice_queue+0x392/0x3d0 net/core/dev.c:12291
>     __tun_detach+0xa50/0x1990 drivers/net/tun.c:621
> 
>   Allocated by task 521:
>     sk_prot_alloc+0xd2/0x230 net/core/sock.c:2247
>     sk_alloc+0x48/0x680 net/core/sock.c:2303
>     iucv_sock_alloc+0x4e/0x710 net/iucv/af_iucv.c:456
>     iucv_sock_create+0x114/0x180 net/iucv/af_iucv.c:2254
> 
>   Freed by task 519:
>     kfree+0x164/0x500 mm/slub.c:6561
>     iucv_sock_release+0x12e/0x150 net/iucv/af_iucv.c:1482
>     sock_close+0xa4/0x230 net/socket.c:1514
> 
> Protect the list traversal with the existing read-side lock.
> Use read_lock_bh()/read_unlock_bh() to synchronize with
> write_lock_bh()-protected updates to iucv_sk_list.
> 
> Fixes: 9fbd87d41392 ("af_iucv: handle netdev events")
> Cc: stable@vger.kernel.org
> Suggested-by: Hidayath Khan <hidayath@linux.ibm.com>
> Signed-off-by: Nagamani PV <nagamani@linux.ibm.com>
> 
> ---
>  net/iucv/af_iucv.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index ea047bab65e7..034039c50941 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -2213,6 +2213,7 @@ static int afiucv_netdev_event(struct notifier_block *this,
>  	switch (event) {
>  	case NETDEV_REBOOT:
>  	case NETDEV_GOING_DOWN:
> +		read_lock_bh(&iucv_sk_list.lock);
>  		sk_for_each(sk, &iucv_sk_list.head) {
>  			iucv = iucv_sk(sk);
>  			if ((iucv->hs_dev == event_dev) &&
> @@ -2223,6 +2224,7 @@ static int afiucv_netdev_event(struct notifier_block *this,
>  				sk->sk_state_change(sk);
>  			}
>  		}
> +		read_unlock_bh(&iucv_sk_list.lock);
>  		break;
>  	case NETDEV_DOWN:
>  	case NETDEV_UNREGISTER:

Nagmani,
As this is a fix, it should have been prefixed with net and not net-next.


See the discussions with Bryam Vargas [1]:
It is correct that afiucv_netdev_event() is missing lock protection.

However for a complete solution it should call lock_sock()
(because netdev events are called in process context) and handle
owned_by_user and a backlog queue.

So this patch improves the situation, but is not the complete solution.
I'd rather continue to work on a more complete fix than take this one,
but both ways are possible.

Kind regards
Alexandra

[1] https://lore.kernel.org/netdev/20260724222917.134769-1-hexlabsecurity@proton.me/



