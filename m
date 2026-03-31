Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06153D811E;
	Tue, 31 Mar 2026 08:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774944370; cv=none; b=OGRPY62sQMmFWZIafxdez/T0QLHFNfaSl9hYeBvbXD9ai3FCZ5AhVJVYoQToKce6fG49/XpCySGuLCyRme9wKfYMOO+eE56Tn3faMDJ2AnvxY4NHeYDlVUsYIn+Dse6ndrs8GpDN9ni793j/o42ztHee6NIwUSkjZNb69hi/nsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774944370; c=relaxed/simple;
	bh=d3erhTWRmJLfkA5owOJ2YvDBGerFiNVzr9R5PdtJpOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MWVVd6c/cfoZ1JOjRvMOSSSJ6mrOtvZkQjVkPZOUm7bOTUOTB2nQI1Dfj1Z85jVMviK4LvMtwbzjTyI2uoIDETgSMqdpLOrDcWgrjLSU+8Ugga/JvBxHm3CGdaqIvHwuY0H41BTR/ad3vld/rIz715UKQgkbPhFs5mRtQTcCVP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eaNfKyIj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eaNfKyIj"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V7k0rJ505649;
	Tue, 31 Mar 2026 08:04:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HLXfFb
	8U8Zgq1sbn5+Sf1i+7GC+yyn45UCcNC9RaZio=; b=eaNfKyIjjmlVVCAWOwd/A+
	cA+U8IBsJpyFJ9yvkFJ6UJEUtEEJ3d0/tuCg7ht9ZC9+k5MOn1IwUqlX0ov0c8L5
	kmudaJxRNehQw9r28ybncfpuEd6Ro5n0e8uwaHkpgJzW8SbTxo4XKIrd8HzLbOa6
	m5ypiEOPMOza2DYmAj8XPe4WB3V/rDFSA6rbVe2yObfJXrxqH8CI3PMiScomXrZn
	jn9i01oJ58khCd9WPss7jm2X08Q1VM03wm+sLyb3upn/LNvQ/O0NA2pdGI/N5icV
	6BobtWnn/1yibe7bPh7nWgiDG5aJmpCgxI96tAzZ/XpumHElFl6Qi2OLDlambgnw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66g1t99e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 08:04:56 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62V63Zdv021659;
	Tue, 31 Mar 2026 08:04:55 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6sasg9s7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 08:04:55 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62V84s5D4850178
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Mar 2026 08:04:54 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80BBD581BB;
	Tue, 31 Mar 2026 08:04:54 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F39C1581BA;
	Tue, 31 Mar 2026 08:04:51 +0000 (GMT)
Received: from [9.52.221.31] (unknown [9.52.221.31])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 31 Mar 2026 08:04:51 +0000 (GMT)
Message-ID: <65d33e3f-37f2-434c-9d39-38cac66aa7a5@linux.ibm.com>
Date: Tue, 31 Mar 2026 10:04:49 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] mm: switch deferred split shrinker to list_lru -
 [s390] panic in __memcg_list_lru_alloc
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Yosry Ahmed <yosry.ahmed@linux.dev>, Zi Yan <ziy@nvidia.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Roman Gushchin
 <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Alexander Egorenkov <egorenar@linux.ibm.com>
References: <20260318200352.1039011-1-hannes@cmpxchg.org>
 <20260318200352.1039011-8-hannes@cmpxchg.org>
 <4d3f8d79-3593-47df-9de8-f94f7f09a403@linux.ibm.com>
 <acrf5_rS7hO5Ec0Q@cmpxchg.org> <acrjmBx_hX-Aa_SH@cmpxchg.org>
Content-Language: en-US
From: Mikhail Zaslonko <zaslonko@linux.ibm.com>
In-Reply-To: <acrjmBx_hX-Aa_SH@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Fdo6BZ+6 c=1 sm=1 tr=0 ts=69cb8028 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=bDKavUFbIZVm-0GZW4UA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 4GdaSQlSImMa_KzvLy3rjzfO77vK-sHP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA3MyBTYWx0ZWRfX1twzc2BG99CB
 TMuWES9DvXucC66Yhoje0lleePR7zGvBHW+Gzq+yLxE7s80widTi/buSvb7zXyLwFFXPQuGPvQR
 sQ/kovp9E4t+FvZ8G2feMbgyCEsN9Kl4WQvO8vmXHOCABfn3Nz+horWftwhWMsVuhL8seR0w835
 EPEMD1atamxKZSVNr5/G+Jh/u17J5UqKeGmInHeXOHBUYJYsflsBGxC/M3RjjM+DN8VrNJmbfSC
 DHJojbTtmJ9IB+wf2qJz5xSQaPpq9PYCK4W2KmIOR/IxMYUsxfWDa+MUeFWR41DhTxCUpG21rDz
 D/4zeoLNBkipiZ3+mx88eCmeLsGE78XJ+GeI+3AwslvJqSWlREgZ9r19TOD1hcAw7Ajd0ygW+0G
 a/Vk0P7ytYPTEuuCDz6+YzOhgfmtZcwSmmiFRCw5MKPZkuauxfZxk0g4d/+MY/+dj61BgqtIrwb
 KoyQe85Dox9/PyzfxHA==
X-Proofpoint-GUID: 4GdaSQlSImMa_KzvLy3rjzfO77vK-sHP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310073



On 30-Mar-26 22:56, Johannes Weiner wrote:
> On Mon, Mar 30, 2026 at 04:41:16PM -0400, Johannes Weiner wrote:
>> Hello Mikhail,
>>

> 
> Can you verify whether the kdump kernel boots with
> cgroup_disable=memory?

It was not a kdump, but s390 specific dump tool. Yes, here is the cmdline (forgot to include):
kernel parmline...: 'reset_devices cgroup_disable=memory nokaslr numa=off irqpoll nr_cpus=1'
> 
> I think there is an issue with how we call __list_lru_init(). The
> existing callsites had their own memcg_kmem_online() guards. But the
> THP one does not, so we're creating a memcg-aware list_lru, but the
> do-while hierarchy walk in __memcg_list_lru_alloc() runs into a NULL
> memcg.
> 
> Can you try the below on top of that -next checkout?
> 
> diff --git a/mm/list_lru.c b/mm/list_lru.c
> index 1ccdd45b1d14..7c7024e33653 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -637,7 +637,7 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware, struct shrinker *shr
>  	else
>  		lru->shrinker_id = -1;
>  
> -	if (mem_cgroup_kmem_disabled())
> +	if (mem_cgroup_disabled() || mem_cgroup_kmem_disabled())
>  		memcg_aware = false;
>  #endif
> 

I confirm, this resolves the issue.

Thanks.



