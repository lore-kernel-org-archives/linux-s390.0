Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812BF221540;
	Thu, 18 Jun 2026 13:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781788742; cv=none; b=u47wQerfWW2NCyW6dn0ZMk3P2f8co+wYi88zMh0sF1QKsa+KttW/oBq9it93RGr3EUNsa+MPcQSxY/ndDQNPPrf3bB7GiiCMrZuFf3jATULJiK1/Mb/hkSivsoktnl83AZkS2fMd/AUfA9In9rAmsV4ezmlG6t5qyUqmXG1wIbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781788742; c=relaxed/simple;
	bh=5/dXrMCyL9YkUGpo/csus8MFYhDSupfYFxAo8TsJsH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k7THpITK8eQc2Odo3/eXWCG7Foc9FnABpGTenz6W1N4t+Hq6yQ1mZRJzE2iypNwCN7EKkLU4rhc+tw+3x6G8aANhdmGgdVRLLANO5oK77Ec+aNzj5J4sjklRWmyhd3OGp+qxkD6+S6jizz4NijvYOhdTZrQLu6k1WUPmlyVTRos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iuaeVyGF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iuaeVyGF"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IDImTv3429198;
	Thu, 18 Jun 2026 13:18:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=r/iDAN
	fVNPy+cn4KUTHwZUn0v89cOJr5dhoJXSDwovg=; b=iuaeVyGFJGX/1MEKEpySJ/
	e1PETx18d57olwyEFDJB3a0eS4rxZoayVRQByy7540W5SAI9g5Qid/kKjpTz4B83
	JvWGzDlx4ngkmTLYWxU0qQEPu7dQEyw5g82TnW+4pOv87xp8cNJS1oDinZBg29L7
	15FS6tSO8kM+jRVrXpQl/XvS/awNVPmA6yIRc+Id/ROCYe/mzcCFkj+lzDEKPyTt
	QznDyiXZ8cMsiXK7gGHw/SJr3Cc4ebh7MbX+swu2XIbHV3INLjROelviRbVhNG8Y
	Gx92LXPfB6ZbUd3UCPQLhuIQi0THUZ5lwJRQfq1N8rfyJCZeLRf5m/EeYrtR6fuw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqx86uc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 13:18:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65ICnqY3013364;
	Thu, 18 Jun 2026 13:18:47 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172bvf4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 13:18:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65IDIhJq48759280
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jun 2026 13:18:43 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AEC520043;
	Thu, 18 Jun 2026 13:18:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 199B22004E;
	Thu, 18 Jun 2026 13:18:43 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jun 2026 13:18:43 +0000 (GMT)
Message-ID: <c2898295-8597-4a64-8321-2a5a2ef3d744@linux.ibm.com>
Date: Thu, 18 Jun 2026 15:18:42 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] s390/configs: Enable cpuidle driver on s390
To: Mete Durlu <meted@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260618-idledriver-v3-0-684061eecbcb@linux.ibm.com>
 <20260618-idledriver-v3-5-684061eecbcb@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260618-idledriver-v3-5-684061eecbcb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QWPR-BJNy9Mr6UZnBDcLc_lR47rHWDAV
X-Authority-Analysis: v=2.4 cv=Le0MLDfi c=1 sm=1 tr=0 ts=6a33f038 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=pKUbLZqC3JEykceJ2MQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDEyNCBTYWx0ZWRfX76kBXkfcM2xn
 PBfg8EFczfGAVWmLciSdTJam1qbBkrcoHzmtxseq8tpRkKYu1+XFKLf8TwQYmVzs4Y/AOZo2M99
 vdaJr8MsoANs9oAbsTcfNK/r03IB4S8=
X-Proofpoint-ORIG-GUID: QWPR-BJNy9Mr6UZnBDcLc_lR47rHWDAV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDEyNCBTYWx0ZWRfX4AmbcxC6v3aj
 0cZb68HuLAdNvdmdA3V8Ef+dqkoMs+yv5jgAqoMlonBpJ0Tk/q7izYipp83IkdEwCwHM9fhyeBq
 xRenyQfGkMjPMsitLpbF2bEbTyUwHudnzIXo9lx5sfmtt4uo8PhXFAtS3wMcYo8l0ZcuPJ7zkLN
 7X43LVrugYjMxtamzhjL5pLotb6tTRa8IFIuEgHHnnhzM7rgseZDGbwmg1Mphz9/4fYlu2ZvofS
 71j/8hwpFOEt7IJmhq0FbbwqiyEoiLBLFQrfttV99hUX2MckRLRocdBvbB4NXEkpdURIqy3CRTI
 QTxCWIBiAGgWRYBuyMJ96gU8ziWmVjB/kiDBvSfy5mXa2KkpxszQLbtxRNbsQYJvS0T2gQcCYA9
 TJ8NbH4az/ldCsVTbZAGjF43IYHiv46vp9o5AwizsWqwEJQ8MIOUzGZcfWqQt4odrE7rtnD2S5e
 N3L8ceWsPnsSD7cs5NA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180124

Am 18.06.26 um 14:00 schrieb Mete Durlu:
> Enable cpuidle infrastructure, idle governor and s390 cpuidle driver by
> default. They can be disabled via config options before compile or via
> setting cpuidle.off kernel commandline option. When cpuidle.off=1 set,
> given architecture's specific implementation is used as a fallback without
> any governor or idle state support.
> 
> During runtime individual states of cpuidle driver can also be disabled
> via sysfs attributes.
> 
> Ex:
> echo 1 > /sys/devices/system/cpu<N>/cpuidle/state<M>/disable
> 
> Signed-off-by: Mete Durlu <meted@linux.ibm.com>
> Reviewed-by: Heiko Carstens <hca@linux.ibm.com>

Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>

