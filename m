Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6611FAA;
	Fri, 16 May 2025 05:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747372188; cv=none; b=BeDmQRFioWxZMyccGtTCJvYxyCpKIpOh4pAImr8nUwbZccF3f8UgvJQrYR+y2pOA6rbFFU17Ze2s8v/biny/K2WPoAaeOyXhU9Wq8uHgsZYBInlO0IQM6vAcQXCArcYP9goYxRv4a2004HKOTcVpvi8xaA4zGWC3x/OoY3MC418=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747372188; c=relaxed/simple;
	bh=zkXf08t1kOFSPVt7zYYAWpnNk1dzmcrSRaAqQW/Bc78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c5FnJ/19wIQO0LbbRYHzAq5yaR1koev/WeIGgJGx8wK/ODcGJ/9z0dVh8MmIcnIjEV7VAEsvY3tCisk5oKoFTg+h92QTYRfUUvtXadgvFWhNC89tYYN2HrBbqhzwsSoqwKRK7jAgyhuVMMXqYmRHaZJCjXitqj4sJqpJ6EKCWk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jsB7cFUa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jsB7cFUa"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FMiCZP004723;
	Fri, 16 May 2025 05:09:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RmZYoy
	yHVUW6jfArWFGMz/n6QUl176kVFb/Wptu38dM=; b=jsB7cFUa5wpTx//HNObOUD
	DK/y3eTacMoDtxnwlNr3P/CLmRkMLa/zPdkbZTflsXR+/yJG7Gi4LQ5CalVRLP8U
	Uo6/Srv/sUFV11MgIYLPaIBcrfm4TWwaYNppP8Ztan2En4zO7u0fBXJn7+fLTFcE
	X61V3mAPuHPfTX02XxDHpyWHCD10LDpnb6vuHgOUJLmcSyYF9HYZ8XsLMZvuV6Xo
	D8VM0AV1hGlFi5jO14JFs00GF20Iosw563jstyefuQvDcLL0ymfScPONNzD0xDMN
	HRzGCYlcPkvPzkK0r7qJfmPai65bEZBqx/iF9PWhrA0ZI0LxTqYeiqngMp3LgfhQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46navu5s6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 May 2025 05:09:41 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54G59feA004187;
	Fri, 16 May 2025 05:09:41 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46navu5s6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 May 2025 05:09:40 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54G21KHs026912;
	Fri, 16 May 2025 05:09:40 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfpnw3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 May 2025 05:09:39 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54G59aM651577266
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 05:09:36 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 275B0200CE;
	Fri, 16 May 2025 05:09:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB87B200C9;
	Fri, 16 May 2025 05:09:35 +0000 (GMT)
Received: from [9.111.28.47] (unknown [9.111.28.47])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 16 May 2025 05:09:35 +0000 (GMT)
Message-ID: <c7b9977e-1088-40a5-8f34-26b1705338b8@linux.ibm.com>
Date: Fri, 16 May 2025 07:09:35 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] perf test: Allow tolerance for leader sampling test
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, namhyung@kernel.org,
        agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, irogers@google.com
References: <20250430140611.599078-1-tmricht@linux.ibm.com>
 <aBT0a5lGzUSLpWpX@x1>
 <CAJpZYjWW07J8J40ygx6-5q_rfKEoz2g0VYCC=Go3PM2pBKvDRw@mail.gmail.com>
 <aBUY-zaI6BxRvWWS@x1> <aCYOEwgBLWyK7g3q@x1>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <aCYOEwgBLWyK7g3q@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: u_eN1CZa1-GBxIwcmFFeDLeEdZRr1QkI
X-Authority-Analysis: v=2.4 cv=XK4wSRhE c=1 sm=1 tr=0 ts=6826c895 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=QIhr-27iAAAA:8 a=QwvT5auMhl7adgpLMvwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cgaYBWEFosGJW4rWv5Lf:22
X-Proofpoint-GUID: XxPIFgka_fgjBt9SJ9vHynb9-dqfsM7C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDA0NiBTYWx0ZWRfX0mJlNobBfZ8P YWQwqGOZkJ/kq5V8iVPzuPLJ5N/CnQcm9MrE89XYw16tslPIhSo1aUMw6Y3gBDzA0O39YzhMbFP cKESdiHv8z7/41cpIrIfVqUGOu7V4wvwCPk1mu/bcOs58He4Dw1lN/Iz+b6UgPsfi1c+UBLCMuV
 e6h+pR2XOCj9SbPQMASMq8NdNBU4i9XOFaamid3f+ZjEAlbk+VJPw+VqS7fWJH/p0UwGTte53lB KSg9wlBU/PG1qczvEpcLKyVvSlJdiAOt0dPybXu61q3SCwbW/R6fDf03NqKzGsn6Hegv/mwq9AL WJHobehP+rI7y3Lst3ol40XCjFYLs8nC65fRba+aU4ZEJG/yaYB1+Wse6BiDsXnAzenQtU1axI7
 /u24W42R9Nzj700lU0C3EkY54ct6ZZKZmA8l3CviUfIoIj24P1xW15VRz6mvJbf1FUA1jbQA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_02,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=961 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505160046

On 5/15/25 17:53, Arnaldo Carvalho de Melo wrote:
> On Fri, May 02, 2025 at 04:11:55PM -0300, Arnaldo Carvalho de Melo wrote:
>> On Fri, May 02, 2025 at 11:21:07AM -0700, Chun-Tse Shao wrote:
>>> Hi Arnaldo,
>>>
>>> I submitted the patch v1 and Thomas helped me to modify and submit v2
>>> and v3 while I was OOO. In this case I am not sure which one should be
>>> the author, maybe just keep it as Thomas.
>>
>> >From the tags provided, I think it would be best to list you as the
>> author and Thomas a a Co-developer, like mentioned in:
>>
>> Documentation/process/submitting-patches.rst
>>
>> Co-developed-by: states that the patch was co-created by multiple developers;
>> it is used to give attribution to co-authors (in addition to the author
>> attributed by the From: tag) when several people work on a single patch.  Since
>> Co-developed-by: denotes authorship, every Co-developed-by: must be immediately
>> followed by a Signed-off-by: of the associated co-author.  Standard sign-off
>> procedure applies, i.e. the ordering of Signed-off-by: tags should reflect the
>> chronological history of the patch insofar as possible, regardless of whether
>> the author is attributed via From: or Co-developed-by:.  Notably, the last
>> Signed-off-by: must always be that of the developer submitting the patch.
>>
>> Note, the From: tag is optional when the From: author is also the person (and
>> email) listed in the From: line of the email header.
>>
>> Example of a patch submitted by the From: author::
>>
>>         <changelog>
>>
>>         Co-developed-by: First Co-Author <first@coauthor.example.org>
>>         Signed-off-by: First Co-Author <first@coauthor.example.org>
>>         Co-developed-by: Second Co-Author <second@coauthor.example.org>
>>         Signed-off-by: Second Co-Author <second@coauthor.example.org>
>>         Signed-off-by: From Author <from@author.example.org>
>>
>> Example of a patch submitted by a Co-developed-by: author::
>>
>>         From: From Author <from@author.example.org>
>>
>>         <changelog>
>>
>>         Co-developed-by: Random Co-Author <random@coauthor.example.org>
>>         Signed-off-by: Random Co-Author <random@coauthor.example.org>
>>         Signed-off-by: From Author <from@author.example.org>
>>         Co-developed-by: Submitting Co-Author <sub@coauthor.example.org>
>>         Signed-off-by: Submitting Co-Author <sub@coauthor.example.org>
> 
> I was expecting some reaction from you or Thomas, but since I got a ping
> from Thomas for this not being processed, I'll process it according to
> my assessment of this thread.
> 
> Thanks,
> 
> - Arnaldo
> 
> 

Thanks Arnaldo,

sorry, but I was not aware that you were waiting for feedback from us.
I am fine with your assessment, I actually care more about the patch
being picked...

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
