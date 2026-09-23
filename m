Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28141435EFA
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 09:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790155356; cv=none; b=rivWDwi4/Sw+RX4GwFmn1uVwTMDbQKUyRMbOPqSadFalXl7g5TBOR1b4xhqyuo0cGXet8fAmztBgMkV8GCdom7Mbc4OXpR8V/aAP/DvAw83G3nZUQp6f3S+tSfZThHQV5vMNkXaq+3Ur9K9yGSQpCG+YjdGaLgWAEqR6X5Tihjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790155356; c=relaxed/simple;
	bh=OHY0qjxGhi/MgXPk+1mpfi1rGO6xaRvKLgwSbQNnvV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s8K32oMNdiqWlAdDTwPDhrYWHfgl5t4Z/s9yyQZn0bxcQem55miLB9QqtaTnDO71lVjQiCkFUsHKbQX+soFqPn1gk1OkeBh1Knw9iXOP/lra1R/QJifeKmBAMjIMTqpfDTBcyP4pK6jbXEPeKXgNCdzUIe8XA+mUAp3hC1hkfeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k26ZopT9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k26ZopT9"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N8ZjJL1729651
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 09:22:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/N3Zcl
	FSgEcxvfJpiocMQjWlV60phE6rd7gPIH1dtW0=; b=k26ZopT9JaIJEffdiJ/UPn
	a9zbNjwH8P3zoNQWapslpg514O/NHHEme/nsrpBt4Q5Mz68NoH56ZB+IsGV47Gp3
	h1z3+2zKW+O7I7XmFdbdjvzmI1ZvH2QSBavGfQjh3N+9LjDvc9ZaGgAjrHGiKVVD
	3BBXm+qTVU05Qh1EximbC2zDuod3KzUAVPFQfg6oJd6MkK09r/ExykbvVj4dPDVI
	6hRoLg3UD67+Uj86ip7VDJTxAi+oa7ec55rF2KbBiZRQbC8zcDerx48Va63n0n8D
	6Lx+feKR2X4xMEIH4SCZsomAukurumwzVbFwI4wSoEUf/RrTrMMAQG36SyYqZz8Q
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqhsve-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 09:22:33 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68N8LtDR007934
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 09:22:33 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb6qg5yp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 09:22:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68N9MT7t42729878
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 09:22:29 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94D6F2004B;
	Wed, 23 Sep 2026 09:22:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BED820043;
	Wed, 23 Sep 2026 09:22:29 +0000 (GMT)
Received: from [9.224.93.36] (unknown [9.224.93.36])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 23 Sep 2026 09:22:29 +0000 (GMT)
Message-ID: <14c7de90-0aa5-40a5-b004-2e38383d1187@linux.ibm.com>
Date: Wed, 23 Sep 2026 11:22:28 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/cio: Fix NULL dereference in
 ccw_device_get_util_str()
To: Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: hca@linux.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
        linux-s390@vger.kernel.org
References: <20260922204839.965043-1-vneethv@linux.ibm.com>
 <b7d20111-db61-4e47-9e84-5232b179b974@linux.ibm.com>
Content-Language: en-US
From: Vineeth Vijayan <vneethv@linux.ibm.com>
In-Reply-To: <b7d20111-db61-4e47-9e84-5232b179b974@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab39a59 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=ok7cSXKL3cDLMHDyNO4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAzNSBTYWx0ZWRfX50zZm+vyyfti
 GqGerpUD5PjUsTF7y5+03/3PcJW047jgZ9dHdFv8aRzWIoqEDFoWDtIJpSmK89S1mqEnYcjjyj8
 OWYLQW2DOpR/7Gt95snj8dBe89EhwQ5ECdDKUPLp9+DKJHbHi9cmKvZ2CDbEGfnM9XW0shQcQrn
 5hYUl5KSe07oHPm70JqUDfvoOmwWYac277IBJdWb9l8RCDp8L3jHfE3FrFwdIgVVunFHhHktuzT
 IgOIU/nIrObvxKtyWKJBS/q+faLo8rvQYrl1ihLjdrbBCFIPYG4ofIISAIODRg253ProCt/rsml
 xjZCKk9NU57CP+ZwqKLLHjbi3zEP6q+iXZj4VbYJtzPq25My1q3oZgf6F7tecmwcT4YNB6gvXA1
 N1o1ClFBjpfVAAL+3ocveULaDk5uta5JmqMfGT5kaAE/8DIBuBg7Dc7AWLqklHUh/gNNqCo+brX
 xaRJjPqphq/fL3zJHpA==
X-Proofpoint-ORIG-GUID: d4RSPAZa5fc8LlG7buVmDzU4T9EanZMc
X-Proofpoint-GUID: d4RSPAZa5fc8LlG7buVmDzU4T9EanZMc
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAzNSBTYWx0ZWRfX/Cj9L4xeLLHm
 n23KsfoKvUGTOnHTyAG2R1gg8FgV2LK+Okt0aIGYdDmcTri8keX35hAXhS3pvYM+5kmyWtzgXyq
 1jULxYDOBifOzBxQ4h/0q3ykcmsCbEY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230035



On 9/23/26 10:57, Peter Oberparleiter wrote:
> On 22.09.2026 22:48, Vineeth Vijayan wrote:
>> The channel path registry entry associated with a CHPID may be removed
>> while the subchannel's PMCW still references that CHPID. In this case,
>> chpid_to_chp() can return NULL, leading to a NULL pointer dereference.
> 
> Actually as I understand it, it is the other way around: the registry
> (css->chps) still contains the entry, but the PMCW CHPID list contains 0
> due a cleared SCHIB. Therefore the lookup will return NULL, unless by
> chance a CHPID 0 exists.
> 

mm..This is also a possibility. But we are not clearing SCHIB here. We 
still cache the old unpredictable value to sch->schib. And then based on
this, we try to read some index of registry which could be a NULL.

>> Add the missing NULL check before dereferencing the returned pointer.
>>
>> Fixes: 199652309a4d ("s390/cio: add helper to query utility strings per given ccw device")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
> 
> Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
> 
> 

