Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09891C86F2
	for <linux-s390@vger.kernel.org>; Fri,  6 Sep 2024 13:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725630933; cv=none; b=aOxIxNJQcv5pz6jr8KUAoScWkjFKP/dtH43wlMo6jHhGkemF+6UYHUypexClxy59GuUWXKYjSZ/xvZM/1nprAOd+7ZSITVNOM8IeLmFMEZiflU6qGl1WX4uf3cvDL6AhO+JMyT+hFrYNPSZQmKsNJGN7O3hQarQ7Mu21w0Ek2oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725630933; c=relaxed/simple;
	bh=xGHVRWRN/K9cdikuW45Cl0Sm4Nu94fcFmpCiEYgbQrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KAnOPMKxGVcNxdBAQ1V1DEMvaaFA8QwBbJBOXsFu4O/DZ+MBDP+CgkJFC32ZomHi0IFqpZ/8Lds4zzKJz4nLLqqmiPDbkHCJjPvq/STiZeSHBjMz9VROUjKW6a8wDxtEYCucqRJQOmgD8YpWYDKc3zI/33oH/IHaHA5IKOVFRsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XsynNSoy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XsynNSoy"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4867bIQT003790;
	Fri, 6 Sep 2024 13:55:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=D
	0wV23Y5pthjabPH8r2FpvGn47oCl7nKYHxJkYIb/j0=; b=XsynNSoylWeTcDsov
	fiiE1JZNrcsWBpJWaEFRGKFiL2VSV8s/5CkrM92F220VP4FT1vS5muLt4w2wLK9S
	zuAkCPI649U4hvyBsXauKLfqi90MhQ2Te5vBy6nhZSNWudwCU89zm0+eMPUenNHU
	2vIYYtREkvmrH+6CVqqJnsZiLAyr+0ixhciSminWDpt3TdzJAQSKAvtg2Epii0Cz
	DnmsKJlEY3SLortOTwEGwFM23FcSjoPBMZ9Xg+/johhpMqu6sPpT9fZ2Gz2Mf8xk
	ZaIlTM/FjWjKjWpTdw6bD40f0SJTlF3KuT1Yw2OMyfg5OXy+r/JQw+G85XINpT8E
	VT5WA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41fj1mcdrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Sep 2024 13:55:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 486Bonnk019708;
	Fri, 6 Sep 2024 13:55:25 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41fj3tuymg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Sep 2024 13:55:24 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 486DtNxo20906690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Sep 2024 13:55:23 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C308258059;
	Fri,  6 Sep 2024 13:55:23 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1673A58057;
	Fri,  6 Sep 2024 13:55:23 +0000 (GMT)
Received: from [9.179.12.41] (unknown [9.179.12.41])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Sep 2024 13:55:22 +0000 (GMT)
Message-ID: <c0ff8199-59b2-4024-8a97-5481b0daf738@linux.ibm.com>
Date: Fri, 6 Sep 2024 15:55:22 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/dasd: fix redundant /proc/dasd* entries removal
To: Miroslav Franc <mfranc@suse.cz>, linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>
References: <87ttevuxz8.fsf@catherine.suse.cz>
Content-Language: en-US
From: Stefan Haberland <sth@linux.ibm.com>
In-Reply-To: <87ttevuxz8.fsf@catherine.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YiuMYHZS0sWqE0FGWB9Y-2pKOBcbCoyz
X-Proofpoint-GUID: YiuMYHZS0sWqE0FGWB9Y-2pKOBcbCoyz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_03,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=760 bulkscore=0
 clxscore=1011 suspectscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409060099

Am 04.09.24 um 19:31 schrieb Miroslav Franc:
> In case of an early failure in dasd_init, dasd_proc_init is never
> called and /proc/dasd* files are never created.  That can happen, for
> example, if an incompatible or incorrect argument is provided to the
> dasd_mod.dasd= kernel parameter.
>
> However, the attempted removal of /proc/dasd* files causes 8 warnings
> and backtraces in this case.  4 on the error path within dasd_init and
> 4 when the dasd module is unloaded.  Notice the "removing permanent
> /proc entry 'devices'" message that is caused by the dasd_proc_exit
> function trying to remove /proc/devices instead of /proc/dasd/devices
> since dasd_proc_root_entry is NULL and /proc/devices is indeed
> permanent.  Example:
>
> ------------[ cut here ]------------
> removing permanent /proc entry 'devices'
> WARNING: CPU: 6 PID: 557 at fs/proc/generic.c:701 remove_proc_entry+0x22e/0x240
>
> CPU: 6 PID: 557 Comm: modprobe Not tainted 6.10.5-1-default #1
> openSUSE Tumbleweed f6917bfd6e5a5c7a7e900e0e3b517786fb5c6301
> Hardware name: QEMU 8561 QEMU (KVM/Linux)
> Krnl PSW : 0704c00180000000 000003fffed0e9f2 (remove_proc_entry+0x232/0x240)
>             R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
> Krnl GPRS: 000003ff00000027 000003ff00000023 0000000000000028 000002f200000000
>             000002f3f05bec20 0000037ffecfb7d0 000003ffffdabab0 000003ff7ee4ec72
>             000003ff7ee4ec72 0000000000000007 000002f280e22600 000002f280e22688
>             000003ffa252cfa0 0000000000010000 000003fffed0e9ee 0000037ffecfba38
> Krnl Code: 000003fffed0e9e2: c020004e7017        larl    %r2,000003ffff6dca10
>             000003fffed0e9e8: c0e5ffdfad24        brasl   %r14,000003fffe904430
>            #000003fffed0e9ee: af000000            mc      0,0
>            >000003fffed0e9f2: a7f4ff4c            brc     15,000003fffed0e88a
>             000003fffed0e9f6: 0707                bcr     0,%r7
>             000003fffed0e9f8: 0707                bcr     0,%r7
>             000003fffed0e9fa: 0707                bcr     0,%r7
>             000003fffed0e9fc: 0707                bcr     0,%r7
> Call Trace:
>   [<000003fffed0e9f2>] remove_proc_entry+0x232/0x240
> ([<000003fffed0e9ee>] remove_proc_entry+0x22e/0x240)
>   [<000003ff7ef5a084>] dasd_proc_exit+0x34/0x60 [dasd_mod]
>   [<000003ff7ef560c2>] dasd_exit+0x22/0xc0 [dasd_mod]
>   [<000003ff7ee5a26e>] dasd_init+0x26e/0x280 [dasd_mod]
>   [<000003fffe8ac9d0>] do_one_initcall+0x40/0x220
>   [<000003fffe9bc758>] do_init_module+0x78/0x260
>   [<000003fffe9bf3a6>] __do_sys_init_module+0x216/0x250
>   [<000003ffff37ac9e>] __do_syscall+0x24e/0x2d0
>   [<000003ffff38cca8>] system_call+0x70/0x98
> Last Breaking-Event-Address:
>   [<000003fffef7ea20>] __s390_indirect_jump_r14+0x0/0x10
> ---[ end trace 0000000000000000 ]---
> ------------[ cut here ]------------
>
> While the cause is a user failure, the dasd module should handle the
> situation more gracefully.  One of the simplest solutions is to make
> removal of the /proc/dasd* entries idempotent.
>
> Signed-off-by: Miroslav Franc <mfranc@suse.cz>
> ---

Looks good to me and verified on my development system.

applied, thanks

