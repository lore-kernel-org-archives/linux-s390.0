Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CA937B41F
	for <linux-s390@vger.kernel.org>; Mon,  2 Feb 2026 16:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770050694; cv=none; b=Eawe8TNTZ0Fp3E+qJ5y2v23h40NoIP18PE4vxYmlDHToxKZjHgWPugrt5YgSiEBwm/Eun0m6dCedbqfqWpvdMilO1Sn9UDNSrQ9AnT84+4gc8ylWMBeQkpSska4AmdgMFJNP7gxzTXpjkxvPetA2NM1MoSiWBg2KLpkforTJrKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770050694; c=relaxed/simple;
	bh=mmi510cJ9sIaIJCGSnl7ok36WQcKem4ZgD4m7F6yHNI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=CBs82WeWvx2q4xeo/fBWomUmazZulq+v/Gx5iWkcf657I5Wv5uIk32+05csNX2s5Qz4mkgTFeeHE8hA6QBDC3N+UbLfcAQi70rvGpzxydVcK1sCNb95B7bOaoei7+W4/eY+RD5C9J/ChUY4E1Z1kjoyD4K0daAKva8EoFTi3kKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iQJmlIjS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iQJmlIjS"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 612FsaAF003717;
	Mon, 2 Feb 2026 16:44:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=vBIjbj4R5zPdZlDaxXnqWPS8t5F4YFvXKxVZXNJHevs=; b=iQJmlIjS3cpA
	bii2CY4cChcrPOtioFnse/J56EtMyaotHwqispqviO1qT0VX3ZMiIZNwRPNreNCx
	dgoi9NRxkdr1VdUNuEPGCpMkJTio28iTiYnDYb0l6O034xan1VUseatlKCvWWUS4
	VmXnuBJo/pdGM/O/4BjCmbOkP+WW9rNThdpvJaubfTSwNMyRMG6ykGcaP2hG5CTX
	kBPacv58mxQn89/C9rEZk99YJ39675A0xN8u4U+IijErAST8iqTCjQHZycy0bTv0
	JkT2VuRc4VfDMhEUT0Uc5h1I/7qCZ0XaKaHZ4djR/GPZbyzkxksp3aLEdB7tg8Of
	jY+R5IxvmQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19f69duk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Feb 2026 16:44:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 612EEkrq004437;
	Mon, 2 Feb 2026 16:44:47 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c1wjjnrh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Feb 2026 16:44:47 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 612GijPv23003898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Feb 2026 16:44:46 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C83A85805D;
	Mon,  2 Feb 2026 16:44:45 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9583158052;
	Mon,  2 Feb 2026 16:44:45 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Feb 2026 16:44:45 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 02 Feb 2026 17:44:45 +0100
From: Harald Freudenberger <freude@linux.ibm.com>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: linux-s390@vger.kernel.org, dengler@linux.ibm.com
Subject: Re: [bug report] kmemleak observed on zcrypt module after system
 boots up
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <CAHj4cs_GH0O7-nkh=8EhwscjzesawBJ+6b0MxuWZOOsp4B7HsA@mail.gmail.com>
References: <CAHj4cs_GH0O7-nkh=8EhwscjzesawBJ+6b0MxuWZOOsp4B7HsA@mail.gmail.com>
Message-ID: <c48e86de56db100cad87bb32f077bcae@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iWGaUOTOTH87RyRgk3QR8cle-Oqt4xp_
X-Authority-Analysis: v=2.4 cv=drTWylg4 c=1 sm=1 tr=0 ts=6980d480 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=slKFpjYzI1dzeMtVvtQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: iWGaUOTOTH87RyRgk3QR8cle-Oqt4xp_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDEyOSBTYWx0ZWRfX5NPuQryldsQb
 98t1hPwO0QSsRMdaX2nDHoVA8UX4p0siWriWaYiLm9NaRd1Ev/FMiIlKuxAWmaI1KPpILCzjxZA
 vUM/zwQf2VzoyCBdOW8Tasj1mj9YW3kbyZgVU9sLaARrZGCu5phxey+tFj4rk8AJF7ZhXLsiJnZ
 dfdFMzdbgLHF4VwSM7DEjcTzirSE2/dTwGDaJPwla1gjJ3yjmedM5ee+sNdt95qlT6GsSHhBdQQ
 lp7m7F1jS7SC1EcqBUy64aF7zRA7amHQZFXZIDyTU1w/17TQEKtcKo9/qaEZF6MrvDgPv+clwXa
 2ufStGvT6Uc3w44UB5x6ONRcPaqc+bP8tw2T4mWNecnf8axKy3RoQM6o+qYJViR5ynBl/sRSt1c
 mf0dRJEKtV/zac9QF0VFIBM1TyLcFVBe5AG1V79WWJ1nBiLGkvGGmo2ppOHour/WRzK7YqltYWI
 2NDR0eD0JE0bWcrJPWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_04,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602020129

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

Hello Yi Zhang
I tried to reproduce this on the linux-next kernel as of today and on
the (IBM internal current development kernel). In both cases I could
not reproduce this. You mention linux-block, did you see this on
linux-next also ?

Thanks
Harald Freudenberger
