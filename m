Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E68C3AEF42
	for <linux-s390@vger.kernel.org>; Wed,  4 Feb 2026 10:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770200298; cv=none; b=szK+NshvTjAx9ndEetx9H27Q3UA316WZAWvjGKf/D92YIJgNeJsI7wCvVvNaremLlFBNvhhhow71CJrIDdRpv+Wk7VOWrIP6Uix2NW7cd5IdZYve9d4JXxc5jrez4Y+i9G3FHd+Jr+UqCaAxZxrEKfhlZffo8ye4IqNw9JIN4pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770200298; c=relaxed/simple;
	bh=PRd1E9lRrFKHT6LQHWPqsvp/a8Lacz9DyXDFX1iy1pk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=UnjCgOYZFguPcFD4JXmChpp0PSYWL0S0wOtapEw++BKuhggQ41GmSEdqnm2LYpArJ0WmJfYF5WYL16LEmgDIrlkNZAzwQn+VgudH6Bpej17UrpvEP3sQ7ZYVejMHxsXaRIarY9QY3xhh90LhnOhv3hKGPCp+06A2tnKrtbEXcdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OetiSwDM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OetiSwDM"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 614205x7017607;
	Wed, 4 Feb 2026 10:18:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=hK68DPLjrlLWWYW07JAso3VgyUxlJwDqbj71sPsFmEI=; b=OetiSwDM2pAh
	qxkIcKNwV7gqZrUMRUp7TwgRRNSP3UvV2Jthzb1cdPGyZ5CJlHPqplceG4SBF/4N
	nF6YnwWcQvG86Q6oHdScrzZ2s1A0kmLVDby/tVy/JVx959FFyAZsdT+09RZvBmHk
	8T4klRUm+FK78GhgVvnPA9lH6U/Rn4vSpZ7d8r4E8Lk0LNshf8VufrGdabYVQw2R
	6Ld8lk2N5ri0JEXReYXWEJHS5g8LgZ2CDjqQOXKkvYTWT4hpNSSDKUbALexnFkL4
	DbdcPTCSZIf+TxDcPjZKW4ZevXOLdtZjFQZDsyzEjuznkll3dMdpXMuGND2DvBrP
	9/ghkWKhUw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19dt9bq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Feb 2026 10:18:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6147j1iJ025743;
	Wed, 4 Feb 2026 10:18:14 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c1w2mvsj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Feb 2026 10:18:14 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 614AIDiT30278282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Feb 2026 10:18:13 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC3B45805C;
	Wed,  4 Feb 2026 10:18:12 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94B4458054;
	Wed,  4 Feb 2026 10:18:12 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Feb 2026 10:18:12 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 04 Feb 2026 11:18:12 +0100
From: Harald Freudenberger <freude@linux.ibm.com>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: linux-s390@vger.kernel.org, dengler@linux.ibm.com
Subject: Re: [bug report] kmemleak observed on zcrypt module after system
 boots up
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <CAHj4cs_GH0O7-nkh=8EhwscjzesawBJ+6b0MxuWZOOsp4B7HsA@mail.gmail.com>
References: <CAHj4cs_GH0O7-nkh=8EhwscjzesawBJ+6b0MxuWZOOsp4B7HsA@mail.gmail.com>
Message-ID: <f08b53ccdfc069f4e8c49511b04171bc@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA3NCBTYWx0ZWRfX2T/daDDuDGXn
 DbPhHVLx9XfMuwZvJXN7nAV0TbQ3oWWksoCnptShJnkeqcaQACCJhvnyt/00AXbgfQTSMAu3Ku4
 hwGNqCAoc83udSO3LLB8cIfkw1c2lgd62uDTpofd9DFmkUDrhyOeWFGc8vOVtOi0V/netkJlnGX
 zBAW5iLx5PDTLypecxFZnTXJoLW737vllFp890lvl82ptvIbC/2vBcsxOV/iZDq+Bp1o/VzfiAR
 VifMmNLIjXMVvx32m4ohL42Uk64T1EN/R6hJ2sQZ8tSOfdNkHaj69EaTIEJEzS+eMP07ez3D2nf
 gRvCXlGP7ha0nqqxPjICX1Kp2KCpqsy3uM3F1uUAd0GvNb2t+0Xo17ze0Iz82VJRf8HG9+u3Yrc
 o4AEggvzI3XUyKkOqWkK7AcorC7X8yFhnstQDy/eTW8mE0WOCk/rn7zCtTjSsIz+JLAeUyQVhP8
 cXuOUtxzMQ58TUFFxOA==
X-Proofpoint-GUID: R-RspK8tIjWgyCu2HTu2w4vC1fsho0Mw
X-Proofpoint-ORIG-GUID: R-RspK8tIjWgyCu2HTu2w4vC1fsho0Mw
X-Authority-Analysis: v=2.4 cv=LesxKzfi c=1 sm=1 tr=0 ts=69831ce7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=F1TlHZAiaXtgL7q9x8oA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_02,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2602040074

On 2026-01-30 09:23, Yi Zhang wrote:
> Hi
> I found this kmemleak issue after the system boots up with
> linux-block/for-next, please help check it and let me know if you need
> any test/info.
> 
> # uname -r
> 6.19.0-rc7+
> # dmesg | grep kmemleak
> [ 1648.765780] kmemleak: 1 new suspected memory leaks (see
> /sys/kernel/debug/kmemleak)
> [ 6148.698090] kmemleak: 2 new suspected memory leaks (see
> /sys/kernel/debug/kmemleak)
> [10419.366662] kmemleak: 3 new suspected memory leaks (see
> /sys/kernel/debug/kmemleak)
> [14843.424498] kmemleak: 2 new suspected memory leaks (see
> /sys/kernel/debug/kmemleak)
> [20987.442195] kmemleak: 2 new suspected memory leaks (see
> /sys/kernel/debug/kmemleak)
> 
> # cat   /sys/kernel/debug/kmemleak
> unreferenced object 0x990d0000 (size 12288):
>   comm "dnf", pid 48539, jiffies 4296356469
>   hex dump (first 32 bytes):
>     00 00 00 00 99 0d 36 30 00 00 bb af 00 f7 1d 60  ......60.......`
>     00 00 00 00 99 0d 00 10 00 00 00 00 99 0d 00 10  ................
>   backtrace (crc 9893fb1d):
>     kmemleak_alloc+0x6c/0xc0
>     ___kmalloc_large_node+0x106/0x160
>     __kmalloc_large_node_noprof+0x32/0x170
>     __kmalloc_noprof+0x6d8/0xa00
>     ap_init_apmsg+0xf6/0x190
>     zcrypt_rsa_modexpo+0x15c/0x1310 [zcrypt]
>     icarsamodexpo_ioctl+0x110/0x270 [zcrypt]
>     zcrypt_unlocked_ioctl+0xc60/0x10e0 [zcrypt]
>     __s390x_sys_ioctl+0x178/0x1e0
>     __do_syscall+0x166/0x460
>     system_call+0x6e/0x90
> unreferenced object 0xae148000 (size 12288):
>   comm "dnf", pid 48539, jiffies 4296356470
>   hex dump (first 32 bytes):
>     00 00 00 00 ae 14 b6 30 00 00 bb af 00 f7 1d 60  .......0.......`
>     00 00 00 00 ae 14 80 10 00 00 00 00 ae 14 80 10  ................
>   backtrace (crc 41938ebb):
>     kmemleak_alloc+0x6c/0xc0
>     ___kmalloc_large_node+0x106/0x160
>     __kmalloc_large_node_noprof+0x32/0x170
>     __kmalloc_noprof+0x6d8/0xa00
>     ap_init_apmsg+0xf6/0x190
>     zcrypt_rsa_modexpo+0x15c/0x1310 [zcrypt]
>     icarsamodexpo_ioctl+0x110/0x270 [zcrypt]
>     zcrypt_unlocked_ioctl+0xc60/0x10e0 [zcrypt]
>     __s390x_sys_ioctl+0x178/0x1e0
>     __do_syscall+0x166/0x460
>     system_call+0x6e/0x90
> unreferenced object 0x87dd4000 (size 12288):
>   comm "dnf", pid 48633, jiffies 4296914470
>   hex dump (first 32 bytes):
>     00 00 00 00 94 c7 20 00 00 00 00 00 00 fe 90 80  ...... .........
>     ff ff ff ff ff ff ff ff 00 10 63 c9 1e a5 48 b8  ..........c...H.
>   backtrace (crc fb3113e3):
>     kmemleak_alloc+0x6c/0xc0
>     ___kmalloc_large_node+0x106/0x160
>     __kmalloc_large_node_noprof+0x32/0x170
>     __kmalloc_noprof+0x6d8/0xa00
>     ap_init_apmsg+0xf6/0x190
>     zcrypt_rsa_modexpo+0x15c/0x1310 [zcrypt]
>     icarsamodexpo_ioctl+0x110/0x270 [zcrypt]
>     zcrypt_unlocked_ioctl+0xc60/0x10e0 [zcrypt]
>     __s390x_sys_ioctl+0x178/0x1e0
>     __do_syscall+0x166/0x460
>     system_call+0x6e/0x90
> unreferenced object 0x8e65c000 (size 12288):
>   comm "dnf", pid 48633, jiffies 4296914470
>   hex dump (first 32 bytes):
>     00 00 00 00 aa 22 2e 00 00 00 00 00 00 fe 90 80  ....."..........
>     ff ff ff ff ff ff ff ff 00 10 63 c9 1e a5 48 b8  ..........c...H.
>   backtrace (crc 1b33772d):
>     kmemleak_alloc+0x6c/0xc0
>     ___kmalloc_large_node+0x106/0x160
>     __kmalloc_large_node_noprof+0x32/0x170
>     __kmalloc_noprof+0x6d8/0xa00
>     ap_init_apmsg+0xf6/0x190
>     zcrypt_rsa_modexpo+0x15c/0x1310 [zcrypt]
>     icarsamodexpo_ioctl+0x110/0x270 [zcrypt]
>     zcrypt_unlocked_ioctl+0xc60/0x10e0 [zcrypt]
>     __s390x_sys_ioctl+0x178/0x1e0
>     __do_syscall+0x166/0x460
>     system_call+0x6e/0x90--
> 
> 
> 
> Best Regards,
>   Yi Zhang

I pulled exactly the repo you mentioned with the "for-linux" branch. But 
again
there is no kmemleak reported regardless on how I play around with that.
Can you please describe the environment you ran for this issue in more 
detail?
I assume you ran a "real" s390 LPAR or zVM and there must have been some
kind of crypto card in your system. Could you please give me the output 
of
"lszcrypt -V" for that system?

Thanks
Harald Freudenberger
to send a request down to the kernel.
