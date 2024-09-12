Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8627C1A3AAC;
	Thu, 12 Sep 2024 12:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726143864; cv=none; b=nv8f0DH19yS6+I9hJ+4jped2qLJzztNSHgJgwwl3J9hp3FZQeWeiKYuu5RiE98N8KIKp3GqqP3rVGUMnGxjWY6WZBYzANHMvptwrYGFcIBmD7G6K/ENZO2HZlac5gjQDXn+IoiwNz2un6ynZYp7cDJAM//S0NpBR/ml8qVFy1zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726143864; c=relaxed/simple;
	bh=OMLRZ7YEJfGJbX09wnonE+6AczbiVs8iR0ifsQxzo2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VTn6cqal1qy1/cChMn4VO6fcvCfYVAoDN8vpaRe3Mecijho5F3dooAJjGUiDNzCM7lb0HIn5lsrx4OPGLlI1bsJH8rWBqwkMrA1I1ilMIMkdV6Vcn3IZy61fJhj+aGuropmL6SmdlyuwD42xpdgpKxV91x1hgLI6/ACpT8yhGpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VQkZqGtU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VQkZqGtU"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48C6BqN1023433;
	Thu, 12 Sep 2024 12:24:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=q
	Pn84AyEsKhFwcsz+kjj2QVJY38ioB9PY+1DpfF0zGo=; b=VQkZqGtUnde3wJHQ3
	NsWn35jx/pAAJcAxLktrxolvYsoSnWqDmTTgfr62W32r5M1FFIjx/dNmbkDmvHJY
	5kpxyhSJPvsL9y7WG4goBHsFNjT5+CY+A9d/imKvqCFjAt1glRpKgttuJqU2CfrQ
	qQuAUtQf/tMDD2uCbjEgYw2Wp9IQSvCQCzXsIFRrsYAP+E8sE6Vo3BKw5b3Ze9sP
	OEK6YK0e9TK7h3XoMeeRHZU+lgdh7cbulcGN5K8GISyzO+owqY6e6qYFr+n0AQEE
	W9Bmk3zf2snDoDqPs1vLvwxjCEybY/sIDWGVVtEdZIA/9FCRVCXK1kmHDiowZMa8
	r2j/Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gejauk55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 12:24:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48CCHJr2010787;
	Thu, 12 Sep 2024 12:24:18 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41kmb6ugkt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 12:24:18 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48CCOHc326477200
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Sep 2024 12:24:17 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0407558056;
	Thu, 12 Sep 2024 12:24:17 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16C0658052;
	Thu, 12 Sep 2024 12:24:16 +0000 (GMT)
Received: from [9.61.43.80] (unknown [9.61.43.80])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Sep 2024 12:24:16 +0000 (GMT)
Message-ID: <218686c3-56bd-479f-b805-dd0c77a89cf7@linux.ibm.com>
Date: Thu, 12 Sep 2024 08:24:15 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] s390/vfio-ap: Driver feature advertisement
To: Heiko Carstens <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        fiuczy@linux.ibm.com, akrowiak@linux.ibm.com, borntraeger@de.ibm.com,
        agordeev@linux.ibm.com, gor@linux.ibm.com
References: <20240910113440.8107-1-jjherne@linux.ibm.com>
 <20240911065707.6563-A-hca@linux.ibm.com>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <20240911065707.6563-A-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MKt-66314HlRVKOgQ0-2rKklLQWeSNWq
X-Proofpoint-GUID: MKt-66314HlRVKOgQ0-2rKklLQWeSNWq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-12_02,2024-09-12_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=790 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409120086

On 9/11/24 2:57 AM, Heiko Carstens wrote:
> On Tue, Sep 10, 2024 at 07:34:40AM -0400, Jason J. Herne wrote:
>> Advertise features of the driver for the benefit of automated tooling
>> like Libvirt and mdevctl.
>>
>> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
>> Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>
>> Reviewed-by: Boris Fiuczynski <fiuczy@linux.ibm.com>
>> ---
>>   Documentation/arch/s390/vfio-ap.rst | 34 +++++++++++++++++++++++++++++
>>   drivers/s390/crypto/vfio_ap_drv.c   | 13 +++++++++++
>>   2 files changed, 47 insertions(+)
> 
> ...
> 
>> +Driver Features
>> +===============
>> +The vfio_ap driver exposes a sysfs file containing supported features.
>> +This exists so third party tools (like Libvirt and mdevctl) can query the
>> +availability of specific features.
>> +
>> +The features list can be found here: /sys/bus/matrix/devices/matrix/features
>> +
>> +Entries are \n delimited. Each entry contains a key value pair. The key is made
>> +up of a combination of alphanumeric and underscore characters. The separator
>> +consists of a space, a colon and then another space. The value consists of
>> +alphanumeric, space, and underscore characters.
>> +
>> +Example:
>> +cat /sys/bus/matrix/devices/matrix/features
>> +flags : guest_matrix dyn ap_config
>> +
>> +Presently only a single field named flags is defined. It is meant to advertise a
>> +list of features the driver provides. The flags fields advertises the following
>> +features:
> 
> I stumbled across this only now: sysfs files are not supposed to have
> several key value pairs. Actually the file(name) itself is supposed to
> be the key and its contents are the value. So I would expect:
> 
> cat /sys/bus/matrix/devices/matrix/flags
> guest_matrix dyn ap_config
> 
> Which is also easier to parse. Is there a good reason why this does
> not follow the general approach for sysfs files?


We talked about a few designs for this feature. This patch represents 
where we landed. I'm happy to make the change to the way you suggest but 
I'll give some time for Boris or Tony to speak up if they disagree.
