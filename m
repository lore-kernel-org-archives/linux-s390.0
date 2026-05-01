Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A1A3A5441;
	Fri,  1 May 2026 13:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777641495; cv=none; b=LOdWN7E8sBUPMSXk4kozVXim28cEkbMRi7kVFnsZmDKgXaEWBUty44ng5kH7YsAPFpRKrEo7Jh3H/c3ex4CU2w8PeRZA0fM3+cN5WOp/OHy5naPBjrJGkaaYvBsMdQ/9L99O7XxH7JBB3xsvR8n96ZpCXCF3xhdlHgoM0YkJ5M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777641495; c=relaxed/simple;
	bh=rU70OeYeA/hJvlbHpTEkn1hhg/loxhmXJnoWS7UVKDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AmXMwqXIKZcVq5VdkbNpuAHlXe947B8WLZfdD7VXz8i1xdFMfEEw38MsgeYL0tuynr5fBHmqHGx1boc5d8kTSp7IzDYEYisMhhnzjCyQOr5sizkCRxyyd5JLZyVqOyr3A8kh3XgfmqhtA11L4sLOfG1V3yF91Zi7DbmtVVLXn3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HrweVTTf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HrweVTTf"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6411uIYH3289646;
	Fri, 1 May 2026 13:18:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1N4eJ8
	PcyiSH/lLvlU9APWRKyhgrT8lzrOzV/lM7NgU=; b=HrweVTTfxUllofDEZsGuKP
	Q++GK/hxfaFlDqhLTFlrvJYzWlkYQKtdX46i1VrKs4OyRslXs8mZFI+VoVMhapKP
	ehrha1TCvbNfhSpGuTmul6JdvIEomQODO5iM6f4s3njMLBe3lBaFt3IE6hAsIMKx
	3co7V8AlO7MIPl3ew/3d+0bsQM/IhiVDoIroAHpYJtzHbwGo0lkwGKuZnOIb3voy
	q21vTLYHQ4cF6DKLRArNlrjLC6ydM5OERghj9KeyttFfzUNyujoypXByJKOBtHwq
	87C80e4hbOWVDt/uUtQjkp6yUrFV5XB3Bl2vfC7MqG2LH9TdOUg4znzhZE+V95XA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn454uxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 May 2026 13:18:06 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 641D8sXC025442;
	Fri, 1 May 2026 13:18:05 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds9ehqeyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 May 2026 13:18:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 641DI16Z41615690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 May 2026 13:18:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D0C72004B;
	Fri,  1 May 2026 13:18:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B910320040;
	Fri,  1 May 2026 13:17:56 +0000 (GMT)
Received: from [9.39.19.46] (unknown [9.39.19.46])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 May 2026 13:17:56 +0000 (GMT)
Message-ID: <981f0de4-fd65-475e-a626-ed7cd3594d3f@linux.ibm.com>
Date: Fri, 1 May 2026 18:47:55 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG: workqueue lockup - SRCU schedules work on not-online CPUs
 during size transition
To: paulmck@kernel.org
Cc: Tejun Heo <tj@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
        Srikar Dronamraju <srikar@linux.ibm.com>,
        Boqun Feng <boqun@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
        Joel Fernandes <joelagnelf@nvidia.com>,
        Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>, samir@linux.ibm.com
References: <adfkdRCxmhpRverB@tardis.local> <adfmHZfABu64Kv4D@slm.duckdns.org>
 <adfrfJGrglg0bGw_@tardis.local> <adlHKowvhn8AGXCc@slm.duckdns.org>
 <afIdFgDD9w2U6hZy@linux.ibm.com> <tte9m9z@ub.hpns>
 <3b1563df-b1aa-40b9-b83e-650d967df09c@paulmck-laptop>
 <3f6d1123-6e1a-4566-8be7-ce95efe0609c@linux.ibm.com>
 <7b5665b4-ddd0-404a-8314-fd0a170db458@paulmck-laptop>
 <868cbc25-45a9-4476-b77e-7f878f1cd42c@linux.ibm.com>
 <c62502b6-642d-487d-a8a2-4ed7f9c7d858@paulmck-laptop>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <c62502b6-642d-487d-a8a2-4ed7f9c7d858@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 8xkNfvDvtaLR-WWXLnqM3j3pBmlv5P-Y
X-Authority-Analysis: v=2.4 cv=Ft81OWrq c=1 sm=1 tr=0 ts=69f4a80f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=jLASW6H_I18I9yEmJaQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: iggukehFD3FKcTqS-9rPZyJPG9u14oWv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDEyOSBTYWx0ZWRfX7uplRDJR5xPk
 Xg9++0o7i5jCnOPw/KT1G+AITxYczlQ7qUgPwtgEnNpvgBCn0CXyHNBQBcNPjSAEdq1wq+FwD3T
 QQkYPRSO4Teuj4oxu+qfVh2E/m83EQSUmA0RerLkb23A9iWM3p/fmpHKc7jsaaIvIZX+L8icRKQ
 2mCSSmucJ1pADGQDGnOSZqOBS9+eC92PgioMndNT17Y4hgAKJ9MbKBYpeMr6cFCmIltur1VI4X6
 eZgvNxx9MMgEziE+mRtfxmitBq8jjdAJQTaBhKconfpwHsjd3nK1h2Y3HxNVeJOUHI18EcWwJbf
 iUZHXB5GJ2/5gjxuDq/OSIRvHzu+mD6CfQcXD7xNopCLOQx2adme3D/l9nqLdMl/4aFgzRTrbMR
 /1tzPnozpslKlaMlb6qBY/dhaMRyfWDQj9fwEtqEmiLjfC2iBJrzTNNpNWk9Vaj/bqkF2fMEPEx
 fbmiroOyWewyl/hPQgA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-01_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605010129

Hi Paul.

On 4/30/26 9:40 PM, Paul E. McKenney wrote:
> On Thu, Apr 30, 2026 at 12:38:16PM +0530, Shrikanth Hegde wrote:
>> Hi Paul.
>>
>> On 4/29/26 11:31 PM, Paul E. McKenney wrote:
> 
> [ . . . ]
> 
> Sorry, missed one...
> 
>>> ------------------------------------------------------------------------
>>>
>>> commit f8d5aaaf90f8294890802ce8dccbafd9850ac5f9
>>> Author: Paul E. McKenney <paulmck@kernel.org>
>>> Date:   Thu Apr 9 11:16:02 2026 -0700
>>>
>>>       srcu: Don't queue workqueue handlers to never-online CPUs
>>>       While an srcu_struct structure is in the midst of switching from CPU-0
>>>       to all-CPUs state, it can attempt to invoke callbacks for CPUs that
>>>       have never been online.  Worse yet, it can attempt in invoke callbacks
>>>       for CPUs that never will be online due to not being present in the
>>
>> for CPUs that never will be online due to being present in the cpu_possible_mask?
> 
> Exactly.
> 
> Just because a CPU is in cpu_possible_mask doesn't mean that it will
> ever actually come online.  For example, for single-threaded performance
> reasons, a given system might choose to bring online only one CPU from
> each hypertheaded core.  In that case, the other CPU in each hyperthreaded
> core could be in the cpu_possible_mask, but would never come online.
> 
> 							Thanx, Paul
> 

Nit: I was suggesting *not* is probably not needed in that changelog.
I agree with explanation.

>>>       cpu_possible_mask.  This can cause hangs on s390, which is not set up to
>>>       deal with workqueue handlers being scheduled on such CPUs.  This commit
>>>       therefore causes Tree SRCU to refrain from queueing workqueue handlers
>>>       on CPUs that have not yet (and might never) come online.
>>>       Because callbacks are not invoked on CPUs that have not been
>>>       online, it is an error to invoke call_srcu(), synchronize_srcu(), or
>>>       synchronize_srcu_expedited() on a CPU that is not yet fully online.
>>>       However, it turns out to be less code to redirect the callbacks
>>>       from too-early invocations of call_srcu() than to warn about such
>>>       invocations.  This commit therefore also redirects callbacks queued on
>>>       not-yet-fully-online CPUs to the boot CPU.
>>>       Reported-by: Vasily Gorbik <gor@linux.ibm.com>
>>>       Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>>>       Tested-by: Vasily Gorbik <gor@linux.ibm.com>
>>>       Cc: Tejun Heo <tj@kernel.org>


Alright. With those two explanations, this LGTM.

Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
