Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED57412B166;
	Thu,  7 Mar 2024 09:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805481; cv=none; b=I4KvxEyizlN7tXly6fbQAE6ghJh1XYbwfrjDgABxlZ9qswv3aD7MzZVhRwboB+dYv37O2OjbIo67q9wSUkpRBr8iZgEaOzQQ/kPMDrEsHh8rkoNKg9fXVBGtLbiqgkyLeP+q3FCiTv59O7rALFVGY5a6J8y6lHW1FajqjMIMcJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805481; c=relaxed/simple;
	bh=30t+lE0eDqy1IesYkT90zU7R1FkcFFB9A8lw7Tbwp9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pjuqzzKu1upCY4PWcmlw3xqsAFqKhkjFvQtLdwh5vDvib6/gOhv9ZLOBa+rmuZb3LXQN4dti8OZ3nr01/nR5gKaLp8mdRi4jCBRUp3K0+3IPwtEtbwkg59kVvvtkuO/oE5ArGqDiEEwlPvWqcyN2z8Os8U1Oup14nVzAkapcNRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qeSYLCoP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qeSYLCoP"
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4279UOHh031820;
	Thu, 7 Mar 2024 09:57:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=JpThu3/0XXibQG8w84m928pgTbIJWF564H9ZQ50NLzs=;
 b=qeSYLCoPOqt++Wp295qTONpqGvSI5wNeW7HUa1zwk+4KzRMqwrKkr0eVZykw82uJ6OeB
 Qbi0+CLmOHswFwpZZGWlx2QFZ1w16SR2lq/jm43e09I7MM9CIBEi/tIhy1qA/VNawnW+
 NAcPtpkaPtg8gLkOtGM0IY7E1V6C/XyF6mId0XmiXdDQYkFM0qwHivve4roAPt17RWMX
 +9Ln6QrC6Sa26XkKVZ1fkkF8jJeRwObbGywLuHfUzVgOxl6OyctISbBvCyNA+SkWBAfv
 IZnMWu8xR5Ud8c1CzmE8MV/4isyAqit1ojsOGwcuXcTidT8iN//wcIB3WnTxpFVEqSu9 4Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wqb0t8hmx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 09:57:55 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4279vnlU002778;
	Thu, 7 Mar 2024 09:57:50 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wqb0t8hku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 09:57:49 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42795INS010917;
	Thu, 7 Mar 2024 09:57:46 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmh52mb4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 09:57:46 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4279vfwE38994418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Mar 2024 09:57:43 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 21B6D2004E;
	Thu,  7 Mar 2024 09:57:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB46420049;
	Thu,  7 Mar 2024 09:57:40 +0000 (GMT)
Received: from [9.152.224.118] (unknown [9.152.224.118])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 Mar 2024 09:57:40 +0000 (GMT)
Message-ID: <93077cee-b81a-4690-9aa8-cc954f9be902@linux.ibm.com>
Date: Thu, 7 Mar 2024 10:57:40 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [lvc-project] [PATCH] [RFC] net: smc: fix fasync leak in
 smc_release()
To: Dmitry Antipov <dmantipov@yandex.ru>, Wen Gu <guwen@linux.alibaba.com>,
        "wenjia@linux.ibm.com" <wenjia@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>
Cc: "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20240221051608.43241-1-dmantipov@yandex.ru>
 <819353f3-f5f9-4a15-96a1-4f3a7fd6b33e@linux.alibaba.com>
 <659c7821842fca97513624b713ced72ab970cdfc.camel@softline.com>
 <19d7d71b-c911-45cc-9671-235d98720be6@linux.alibaba.com>
 <380043fa-3208-4856-92b1-be9c87caeeb6@yandex.ru>
 <2c9c9ffe-13c4-44b8-982a-a3b4070b8a11@linux.alibaba.com>
 <35584a9f-f4c2-423a-8bb8-2c729cedb6fe@yandex.ru>
From: Jan Karcher <jaka@linux.ibm.com>
Organization: IBM - Network Linux on Z
In-Reply-To: <35584a9f-f4c2-423a-8bb8-2c729cedb6fe@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NWGaxKYtLJPX7pnmCP7qpPW3o0LapsYO
X-Proofpoint-ORIG-GUID: ijN01u90P7BbOd1hYe04JLdomuYIkIum
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_06,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 clxscore=1015 bulkscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2403070072



On 06/03/2024 19:07, Dmitry Antipov wrote:
> On 3/6/24 17:45, Wen Gu wrote:
> 
>> IIUC, the fallback (or more precisely the private_data change) 
>> essentially
>> always happens when the lock_sock(smc->sk) is held, except in 
>> smc_listen_work()
>> or smc_listen_decline(), but at that moment, userspace program can not 
>> yet
>> acquire this new socket to add fasync entries to the fasync_list.
>>
>> So IMHO, the above patch should work, since it checks the private_data 
>> under
>> the lock_sock(sk). But if I missed something, please correct me.
> 
> Well, the whole picture is somewhat more complicated. Consider the
> following diagram (an underlying kernel socket is in [], e.g. [smc->sk]):
> 
> Thread 0                        Thread 1
> 
> ioctl(sock, FIOASYNC, [1])
> ...
> sock = filp->private_data;
> lock_sock(sock [smc->sk]);
> sock_fasync(sock, ..., 1)       ; new fasync_struct linked to smc->sk
> release_sock(sock [smc->sk]);
>                                  ...
>                                  lock_sock([smc->sk]);
>                                  ...
>                                  smc_switch_to_fallback()
>                                  ...
>                                  smc->clcsock->file->private_data = 
> smc->clcsock;
>                                  ...
>                                  release_sock([smc->sk]);
> ioctl(sock, FIOASYNC, [0])
> ...
> sock = filp->private_data;
> lock_sock(sock [smc->clcsock]);
> sock_fasync(sock, ..., 0)       ; nothing to unlink from smc->clcsock
>                                  ; since fasync entry was linked to smc->sk
> release_sock(sock [smc->clcsock]);
>                                  ...
>                                  close(sock [smc->clcsock]);
>                                  __fput(...);
>                                  file->f_op->fasync(sock, [0])   ; 
> always failed -
>                                                                  ; 
> should use
>                                                                  ; 
> smc->sk instead
>                                  file->f_op->release()
>                                     ...
>                                     smc_restore_fallback_changes()
>                                     ...
>                                     file->private_data = smc->sk.sk_socket;
> 
> That is, smc_restore_fallback_changes() restores filp->private_data to
> smc->sk. If __fput() would have called file->f_op->release() _before_
> file->f_op->fasync(), the fix would be as simple as adding
> 
> smc->sk.sk_socket->wq.fasync_list = smc->clcsock->wq.fasync_list;
> 
> to smc_restore_fallback_changes(). But since file->f_op->fasync() is called
> before file->f_op->release(), the former always makes an attempt to 
> unlink fasync
> entry from smc->clcsock instead of smc->sk, thus introducing the memory 
> leak.
> 
> And an idea with shared wait queue was intended in attempt to eliminate
> this chicken-egg lookalike problem completely.
> 
> Dmitry
> 

Me and Gerd had another look at this.
The infrastructure for what i proposed in the last E-Mail regarding the 
ioctl function handler is already there (af_smc.c#smc_ioctl).
There we already check if we are in a active fallback to send the ioctls 
to the clcsock instead of the sk socket.

```
	lock_sock(&smc->sk);
	if (smc->use_fallback) {
		if (!smc->clcsock) {
			release_sock(&smc->sk);
			return -EBADF;
		}
		answ = smc->clcsock->ops->ioctl(smc->clcsock, cmd, arg);
		release_sock(&smc->sk);
		return answ;
	}
```

We think it might be an option to secure the path in this function with 
the smc->clcsock_release_lock.

```
	lock_sock(&smc->sk);
	if (smc->use_fallback) {
		if (!smc->clcsock) {
			release_sock(&smc->sk);
			return -EBADF;
		}
+		mutex_lock(&smc->clcsock_release_lock);
		answ = smc->clcsock->ops->ioctl(smc->clcsock, cmd, arg);
+		mutex_unlock(&smc->clcsock_release_lock);
		release_sock(&smc->sk);
		return answ;
	}
```

What do yo think about this?
I'm going to test this idea and see if we canget rid of the leak this way.

Thanks
- Jan & Gerd
