Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935E2477E21;
	Wed,  2 Sep 2026 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788361782; cv=none; b=SNcQcioFy1bEa1lhmJbZ/NQE91nXk7+VbvanGApgi9BS2FjbeexHRlUR9DM6GJ9jgks+H7AnX9Pnu7jRhrS5OZVG+Re2b8uY8Dt5AwMG0L8a9M9vYAxBBr1BP/J7WdqLZ6x34VC4BUBX89qDfFTiwYt7f7YLjTy63Bzw5587TCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788361782; c=relaxed/simple;
	bh=JuV28WwxcDoXGHduDHYVfbfrUcgJULiA3c7TcAGvQgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N77XftSTGdQNxn2K0gPfEChPfqpdkkozLrpLcKAm5UhPwVzS69W8pLplSx67dcFqxTqHpmEg2l4kHlYz8cVevsAKnNq8GLCv1fldouG08McGPEPWEtcFRduZto42Jgk1ZTJyiPiPI40eU6h1zrjFcGBOWG/wBiR4oeoCZsZZ6vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l4uOGH6r; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l4uOGH6r"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682CVlEW2312123;
	Wed, 2 Sep 2026 15:09:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Q2lyEz
	zfxpE/Kfc0h7DnnH5fFclZtRaFMdNW0/nbMgQ=; b=l4uOGH6rxCiTgJQgCJs0Ss
	+1pMWTLl1VkwfWC5h9WE4fg+KCt2TMsctbn0A44HOz8oWPP8leLLUdUDaVmEkXOa
	8oypSQ1K74NJso2dTKR8OnSv5Hkb42ogQnyiUelDSvnJovyB2QNZNVRaPnZypt/Z
	AGOGDgKWzwtwzJMhV+OYZwh64hDwuGnO2wXNgdUSbcLvy4bEhH72twhy03q1PGIv
	HSodyEP7L1b/+XRefdwsikG4QFi9tFtRcODzvcb0CQAvv9Jud0jqKfAdVd49uZWL
	Lar994aqBd/hDwoQhL61iqd76DlMAWtCLYDyyNpPdCEmECu/8nBRg9NiiuamjOPw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3rffd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 15:09:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 682EfJq2031615;
	Wed, 2 Sep 2026 15:09:28 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcceyabne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 15:09:28 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 682F9Qoq000868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Sep 2026 15:09:27 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4DD158068;
	Wed,  2 Sep 2026 15:09:26 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48F0D58052;
	Wed,  2 Sep 2026 15:09:21 +0000 (GMT)
Received: from [9.124.221.145] (unknown [9.124.221.145])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Sep 2026 15:09:20 +0000 (GMT)
Message-ID: <12b16822-bb3b-4730-8d54-9a50eb50cdda@linux.ibm.com>
Date: Wed, 2 Sep 2026 20:39:18 +0530
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
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260724222917.134769-1-hexlabsecurity@proton.me>
 <f74b9587-c09c-4fce-9415-e2d3b49d0247@linux.ibm.com>
 <5f88daf4-cd8e-4464-b132-ac45be205121@linux.ibm.com>
 <20260828183431.21830-1-hexlabsecurity@proton.me>
Content-Language: en-GB
From: Hidayath Khan <hidayath@linux.ibm.com>
In-Reply-To: <20260828183431.21830-1-hexlabsecurity@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a983c2a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=QeFMIo-8F5EhuVDcP38A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEzMyBTYWx0ZWRfX7GaN+lOGCLbY
 IxjkyHc4edzZlSBqgTFjve04XjloJQO+ZdA2HxFhr1ajyIdYcWisFWfFHakdwt2BHRF1dwg+itZ
 qZjzZKmNpIwCsAuZGcI/5kCqy8hedSzmuCxN6dmTCQial/Q+WoM7Z1pSpdXYgnnqfZQoE9H8Fb9
 r1oWwqMRO6Ny2T6IpBnzVVu/u+y5u2YqZaaue2g+laLM2VlMFK69ymPiy/mpYIss9h1BN2l9Z7A
 6A5S6hksnwt38VU7aXdBr2revhiUJ4eksal8mdD5mRLd8JQMembfmscK+1kl3SQj+p+i8T9sFS3
 DsEB7Nhl6nZyMHrE0cUL99T4mtj6foEKVejG+JY++b0e8CZls/52yaS9/z4DvJDb2Q6jAxvMLaw
 R2spcO9j23XjYblvmXiwzrnFG1sSzI1b5W9HMv6XhS70jRJVoAUwfrJzAm2i8JPM/Gf7/Ywdjje
 eiKYoaq0usknyg9a0gA==
X-Proofpoint-GUID: hgFAY4yMqKf795n49mmuCsYWGZQ80Ank
X-Proofpoint-ORIG-GUID: Wb3Np2RRX4Zy78rVRurFvyH5UR22lU2R
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEzMyBTYWx0ZWRfXx+1ftF6BgmO3
 TxSUbe7TzG3edvULJnsQ+jke0SDImjzT6zqsD8veeggSEN1dsue9cmAjG0ZYqKhRNoqJgI8sRJ1
 vxh+g3VvJ2Q2gk2jWHN5aOg7itJmVc8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020133


On 29/08/26 12:04 am, Bryam Vargas wrote:
> Hidayath,
>
>> Let me know how you'd like to sequence it.
> Don't sequence them behind me. Send the accept_q_lock patch now, and take
> iucv_callback_connreq() back. I asked for it on the 21st assuming the rework
> would move, and it won't for a while: I'm in the middle of a larger project and
> have only a few hours a week for this at the moment. Holding two patches and a
> leak fix for that is a bad trade for you.
I appreciate the advice, but I am going to hold onto these patches for 
the time being.
The consensus is that we land your core socket locking rework first before
tackling the remaining gaps. We want to avoid sending partial fixes that 
merely
narrow race windows, as that will make the underlying bugs harder to 
reproduce and
add confusion.

It also gives me time to properly rework the patch:
[PATCH net] net/af_iucv: fix use-after-free of listen sock in 
iucv_callback_connreq()
and confirm all reproducers.

>
> One thing worth having before the walk fix goes out. The lock on the walk is
> necessary and it isn't sufficient. Both producers link the child and set its
> state afterwards: iucv_accept_enqueue() at af_iucv.c:1916, then
> nsk->sk_state = IUCV_CONNECTED at :1917, and the same order at :1693 and :1696.
> So the state store sits outside accept_q_lock, and a walker holding that lock
> still reads sk_state at :1372 with nothing ordering the two. iucv_accept_poll()
> tests exactly that field to decide EPOLLIN, so a poll landing between :1916 and
> :1917 sees a child that is on the queue and not yet CONNECTED. Moving the state
> store ahead of the enqueue in both producers closes it. The lock alone narrows
> the window.
Agreed. The planned accept_q series incorporates your feedback
to ensure the state ordering and walk serialization close the race 
completely.

- Patch 1: Takes accept_q_lock inside iucv_accept_poll().
- Patch 2: Explicitly reorders the producers (iucv_callback_connreq and
   afiucv_hs_callback_syn) to set nsk->sk_state = IUCV_CONNECTED before
   calling iucv_accept_enqueue(), ensuring a locked walker never reads
   an un-updated state.
- Patch 3: Extends proper accept_q_lock serialization to the sleeping
   walk inside iucv_accept_dequeue().

>
>> while iucv_accept_enqueue() appends from the IUCV tasklet and the
>> HiperSockets softirq under bh_lock_sock(parent)
> Small correction that doesn't change your conclusion: the append's own lock is
> spin_lock_irqsave(&par->accept_q_lock) at :516-518, not bh_lock_sock. The walk
> takes neither, so the finding stands either way -- it matters only for where
> the fix goes.
Thanks for pointing out the distinction on accept_q_lock vs bh_lock_sock 
- noted.
>
> You're right about iucv_accept_dequeue() too. Its walk at :542 is equally
> unlocked and can't be wrapped the same way, because the loop body sleeps in
> lock_sock() at :544.
>
> All of that is source plus a model, not a run. I have no Z.
I will rebase these patches on top of Stage 1 once it lands.

Thanks,
Hidayath
>
> Thanks,
> Bryam
