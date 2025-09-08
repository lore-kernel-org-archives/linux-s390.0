Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB59321ABBB;
	Mon,  8 Sep 2025 08:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757320442; cv=none; b=GAs77kugR+Bnbdi3lvYIc3gkfxlj67WgVqIr+Rbhtoku7oQxoCNqdbm12/oLuPtw712kD1SXliown/pagScvBQLjXwxj//6p997DkxRgZMdHE3cOR99x11JlzaG1fYMSEtq7X6IEmKqecDlQLclPAY6b3srm04men9KS4Ss2gJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757320442; c=relaxed/simple;
	bh=vCqqU+yaPD5HIyTtG+hPFyDYgOIhmSc60FVhT9BDgbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eXdrinlMdhGA5N3Kkol3AxGp/MU55HLQ9McNzVx20TXw1hMaPdQMeP9I3wzbnxliE8wP1lUzqxi3r/awg6S5LypQzukS25KrBiMSgDPn4uOUdferT+iDXWzV0C4TMMghk2zPUpGKzNnXmlt9APr4kMI7E3Vb+xbJz9u6Jg/HGgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bVFbxb7T; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bVFbxb7T"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587LIOVl027585;
	Mon, 8 Sep 2025 08:33:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3AgNoS
	T4CnKFruzoM5wTD2dQ313+ckKd764nKXmTeIw=; b=bVFbxb7TxBkszrjrs/DItw
	V1rQwp0xWhouuojR9pFkF/lEe82+/XqS/LKlcSsA9LqUgAGqz0KtWR7WE1aThz9g
	wCxPHn9m661o/cCRc7k6eOAnU48uGKvtli58ZOj5nh7c6JaSM9vZ1K7f8ThTgncd
	i3ghaZaS/Vdh+/OHdsxeuov2CxwEeiiD+B4gffQcCWJwA1fFClfGt8/3yYahgqQl
	rfNnjOEyGXXicfeLrgjavNNIi/rx5cUb7+s6Ez6a1YSgHL7vOHrhqX4nLVLksffq
	A8AoCigOGZ7ZY48J2Cn8+GaAyVtJHQOc4owkEryzb8ZFOSL54AecnGUH8mcyhM5w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490xycn3rf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 08:33:41 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5888XdSA012310;
	Mon, 8 Sep 2025 08:33:39 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490xycn3rc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 08:33:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58867UdA017187;
	Mon, 8 Sep 2025 08:33:38 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4911gm4ygk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 08:33:38 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5888XZl920054420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Sep 2025 08:33:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 485A42004B;
	Mon,  8 Sep 2025 08:33:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E93720040;
	Mon,  8 Sep 2025 08:33:35 +0000 (GMT)
Received: from [9.152.212.43] (unknown [9.152.212.43])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Sep 2025 08:33:34 +0000 (GMT)
Message-ID: <f672519b-d21e-4576-8cb8-989b95c88f97@linux.ibm.com>
Date: Mon, 8 Sep 2025 10:33:34 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] s390: replace use of system_wq with system_percpu_wq
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michal Hocko <mhocko@suse.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20250905090857.108240-1-marco.crivellari@suse.com>
 <20250905090857.108240-3-marco.crivellari@suse.com>
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <20250905090857.108240-3-marco.crivellari@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8DykrpHvg5_jwvbvVVdxtV48KqX8qJ9A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDIzNSBTYWx0ZWRfX5vlICxHRu+hQ
 HHldcSCecfFovHT1Pmv71QZ9Lw7RT5McBdAMxWsluhylQax8T0Drp0nZepjNYg/iczYQkrVfhxr
 N684VH7QZLFEzXwdHiWZPnBGOvfRn2C5AIuLmgTsjXPG6DgfHn9Ppsla0sul0hLD0B/I0/dmcOr
 ZO1akh4GU3zewIjLrxJ3ekHsQU4g5UuwAdGgjbbmuZdvJez6UxyM+XBL0Bv321IwvUVc1d8wmA4
 7c1q1N4yit10Ekm/WpCvF4jfGtrdJuOpjxGNxXgMmO3/HikzHQyczi8BSkuyYbRQjH/bXW2S/EZ
 oy6XrLou37tO9gSbvA3WdrlqNwu//XmJVe4L/4D/+TZfCyN+w1X5w6q2qjhQqEWs0p+DEeSc9hy
 YbnB4t5Q
X-Proofpoint-GUID: v2nzW-TXfSpyWtZXZn0hTQRZHWoMsj5V
X-Authority-Analysis: v=2.4 cv=F59XdrhN c=1 sm=1 tr=0 ts=68be94e5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8
 a=YH03dvRjq84_0dL9y74A:9 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1011
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060235

On 9/5/25 11:08 AM, Marco Crivellari wrote:
> Currently if a user enqueue a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> 
> This lack of consistentcy cannot be addressed without refactoring the API.
> 
> system_wq is a per-CPU worqueue, yet nothing in its name tells about that
> CPU affinity constraint, which is very often not required by users. Make
> it clear by adding a system_percpu_wq.
> 
> queue_work() / queue_delayed_work() mod_delayed_work() will now use the
> new per-cpu wq: whether the user still stick on the old name a warn will
> be printed along a wq redirect to the new one.
> 
> This patch add the new system_percpu_wq except for mm, fs and net
> subsystem, whom are handled in separated patches.
> 
> The old wq will be kept for a few release cylces.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

If I get this correctly system_wq will be obsolete and users will get
system_percpu_wq instead, which means local cpu gets to deal with the
delayed work and its timer and it has an affinity to that cpu via per
cpu workqueue. In that case;


> diff --git a/arch/s390/kernel/hiperdispatch.c b/arch/s390/kernel/hiperdispatch.c
> index e7b66d046e8d..85b5508ab62c 100644
> --- a/arch/s390/kernel/hiperdispatch.c
> +++ b/arch/s390/kernel/hiperdispatch.c
> @@ -191,7 +191,7 @@ int hd_enable_hiperdispatch(void)
>   		return 0;
>   	if (hd_online_cores <= hd_entitled_cores)
>   		return 0;
> -	mod_delayed_work(system_wq, &hd_capacity_work, HD_DELAY_INTERVAL * hd_delay_factor);
> +	mod_delayed_work(system_percpu_wq, &hd_capacity_work, HD_DELAY_INTERVAL * hd_delay_factor);
>   	hd_update_capacities();

Hiperdispatch's delayed work wouldn't get a noticeable benefit from
utilizing a per-cpu workqueue. We probably settled on system_wq to
utilize the global work queue at the time. Would system_unbound_wq
make more sense here?

Thanks.
