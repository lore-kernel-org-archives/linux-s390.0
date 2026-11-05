Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793896891;
	b=OPuHuQ1j04Hg5B9+OUcqkud4n3YshW4F3vjYFLlnTVQwIXQdwUiK0LEcuWxfNYB7rK/2
	 cmrSWtXZpdoyXYXOaamIL1ZvD3dyjxs/3O+WZ7DwVdJ1gVJ3BaMzNPgtmN1UrnfH53jxC
	 LS6Lok264LIrNbeO7PotlKvgW4tBj5uAXxJ/VzzAJ0d7cL2ZF+mamu0bnBQbU5A2Uj6Ot
	 7LsqZ26KB+sA+I1VJlOCJ8dSWVSJxYj86jb8Ny+ztgEpNOEDRr4PZD3ZzDS1U7rpdefYk
	 g66EauB91FDP0EIt0sR2twgAWb2oTTzW8nu3MVbzu4aR73DeJrzeIW68Q3MeHjlW1Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896891;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=mo9/kbJjTwu6T592HSiTjl0ncf1cTmsjgggsVDDpS3M=;
	b=dGQU7O02aQijBLzg0y5GsMUEbTPWD/1edpXykyoJCwvRPBTjxbweRtYRT3gPUAm42UML
	 n0oEBaFlMmW7xgyO7J6uWpbEWGWYGjHQOFesga1DhmZglFEF8B1md3RsfB2bN6VAFx3W1
	 Z/QiWAeNnllLqvGnh2H4q7Q7WxAijY2Hz5f8BDg47uG6G51fQSgSe8S0kM1lXd3TsmU9H
	 7AICdTuWOhG/8YO3tn5aXd1ssgZk5UCYl3B0dZ9HGYe1GYnvYZorVpVH7sW8XQqsFKpgC
	 9FAJLENYkGc8XDmBviFRVFYODXcFGT5rS98tuPf1wKCXQiU1igCr7VWMWqnSLMue1dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=stNHw46o;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A761606A331;
	Thu,  5 Nov 2026 16:41:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A761606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=stNHw46o
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5EiGix3734725;
	Thu, 5 Nov 2026 16:41:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=mo9/kbJjTwu6T592HSiTjl0ncf1cTm
	sjgggsVDDpS3M=; b=stNHw46oT2ch8dMhmih1NDKgGU36zWSjGeArGivz6zOaAX
	QWDvkbyZT2H3ja6IPqF9kzT4idoNYhhZghBFO8RbeyTlySrE4uzTkc0f6T/gSFrk
	7S3rmtoIJJ6gUzL2Evg9j0nX8OE0I15OpzEaXNg6pqY4hG3LPPRqFcni8UrzatAE
	o4oNsnjaSNUwdSt4s1AIxM1rmH6w0uQFTYuc9EoYsNONS0mQQFsxGhtD+t1VTMAx
	Ulu28c16DXtAR5xbphDKL5GGPEQiCWYH83n2xUTbCbIpcpIImGp1GitpGkUOj8iA
	JIrlDIBe2OibV22PhnMF8FdsuQmkOszbQBvhv/Eg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn5rj3jey-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 16:41:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5EZ3oW1796739;
	Thu, 5 Nov 2026 16:41:03 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hrka6u7yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 16:41:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A5Gex6T30867852
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Nov 2026 16:40:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46F722004E;
	Thu,  5 Nov 2026 16:40:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C4832004D;
	Thu,  5 Nov 2026 16:40:59 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.68.17.117])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  5 Nov 2026 16:40:59 +0000 (GMT)
Date: Thu, 5 Nov 2026 17:40:57 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
        "Dmitry V . Levin" <ldv@strace.io>, Renzo Davoli <renzo@cs.unibo.it>,
        Thomas Gleixner <tglx@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/syscall: Set -ENOSYS return value before calling
 syscall_enter_from_user_mode_work()
Message-ID: <890e50e0-77f7-43f3-b1b9-f8e7302aa3db-agordeev@linux.ibm.com>
References: <20261021085643.2442949-1-hca@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021085643.2442949-1-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: e_BmLWN-MUIaJPUAT-5hZOBcii3TOwEz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA2NCBTYWx0ZWRfX44wxq1k7A5E9
 sF7Hp3jzY4WHiMKrP1Jv5KRhHKpr1KBHgvKSAQlM/x1iom0euqsuiReAYcamk36MNfZuDi5XX0w
 UgG2LeBNTOwCQIqkXUNz+Ra7sw66kZo=
X-Authority-Analysis: v=2.4 cv=LokHWXdc c=1 sm=1 tr=0 ts=6aecb19f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=NXJrL_N0o-OufKNRWLEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA2NCBTYWx0ZWRfX/12AJ3TIJjUO
 fMaQRdKgfyMoHaKcVZRjMXmKdZC+oY6uaLaYqGa/YV5ksD8H0p/h1nfVFiw2oSGC5r83jRmtOJe
 gjfmGQh0EuhUytdb2aUnBrhsjjFWkTfm+KejO0nvUfKJYvmOMyB7jofzVcP9YfDAneM+a32gsWi
 2pjdvb4hqzMiFjPnc0dYNd2IiDSmujX/gbyBTp19SCRkcEszhB4x/hhZek35Nh6Rk/agfCO1eJK
 gwlsR04ooMFj05zJ/udKaPSLquYIDpkI0SNjCEVQKOXw3q+t6K/jh2frb9SUyvXDiFaVX4L9iiH
 Af6Plg9hC6c7aH4sPNJbIP8izY7dht6riGUtxkuqu04uhYIU8CnD+NZqrGp/9o4oI6n9lky6lvx
 19ZwZUmoHBGyqU090m4fEP862GHkxjTg60hRj3A3Dn1wlc7/LJzwkrrTYRCuDQLn3uJsKz6dt/k
 OyQITjXSVOoCyEJb/oA==
X-Proofpoint-GUID: e_BmLWN-MUIaJPUAT-5hZOBcii3TOwEz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_04,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050064

On Wed, Oct 21, 2026 at 10:56:43AM +0200, Heiko Carstens wrote:
> On s390 gpr2 contains both the system call return value and the system call
> number. With [1] it is expected to set gpr2 to -ENOSYS before calling
> syscall_enter_from_user_mode_work(), so that a skipped system call has a
> defined default return value, and not the system call number like today.
> 
> To make that work and stay compatible with existing ptrace users, replace
> PIF_SYSCALL_RET_SET with PIF_SYSCALL_ENTRY. PIF_SYSCALL_ENTRY is set before
> syscall_enter_from_user_mode_work() is called and indicates that reads and
> writes to gpr2 via PTRACE_PEEKUSR, PTRACE_POKEUSR, PTRACE_GETREGSET, and
> PTRACE_SETREGSET are redirected to regs->int_code, which contains the
> system call number. gpr2, which contains the system call return value, can
> only be changed via syscall_set_return_value() (e.g. seccomp).
> 
> After syscall_enter_from_user_mode_work() returns, PIF_SYSCALL_ENTRY is
> cleared and the code behaves as before.
> 
> PIF_SYSCALL_RET_SET was introduced with [2]. The flag was set by
> syscall_set_return_value() and allowed seccomp to skip syscalls
> and inject a return value despite the gpr2 aliasing.
> 
> Kernel seccomp and ptrace selftests, as well as strace selftests, show no
> difference with and without this change.
> 
> [1] 05c033db7e9a ("entry, treewide: Make syscall_enter_from_user_mode[_work]() indicate syscall execution")
> [2] 56e62a737028 ("s390: convert to generic entry")
> 
> Fixes: 05c033db7e9a ("entry, treewide: Make syscall_enter_from_user_mode[_work]() indicate syscall execution")
> Cc: stable@vger.kernel.org
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/include/asm/ptrace.h  |  4 ++--
>  arch/s390/include/asm/syscall.h |  1 -
>  arch/s390/kernel/ptrace.c       | 28 +++++++++++++++++++++++-----
>  arch/s390/kernel/syscall.c      | 19 +++++++++----------
>  4 files changed, 34 insertions(+), 18 deletions(-)

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>
