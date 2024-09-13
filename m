Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9009252F62;
	Fri, 13 Sep 2024 16:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726244671; cv=none; b=KYA/Pt28h4pS3hBURnr2TIWHqehv0bi95c01QeLqomM6doQzkr2liNhFopKiFA0xoI2sN7FAlCquK/3r2Vzri/wwkUFAm+182CeNocoFyLyxZYmqYDFaiBYMjah/iX829jyh+FR5RfgThOQwZUDbwYGnBp5kX84a9Pl4NnMKikM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726244671; c=relaxed/simple;
	bh=NdlpI2lfrJdlHUiowIjiCgNjd6opv3x/ygUeGqaQ7nY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ELNdpE03UGWB63sABW8t9b/xP0DU184V1y0tFPXTtyowcV3zgvtgILB7Oc2nSkZQCy3tibbDBPGIXaJlQMI0rhGSrjBjfIs67ZyCBVy8YOUZeIIvfhOkrl5G/dBqNAW0xHuLcXadH/CG43HEZ8Mf5otA0qFkxAvJKXV3RJCC5bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VwJ65O2U; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VwJ65O2U"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DGBZ0j003723;
	Fri, 13 Sep 2024 16:24:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=H
	YF5FpI54H7Ps7tpK+vSjMcqh1QBU19xCspJZIBi5PA=; b=VwJ65O2U6s6IR0ux/
	MiUGIEU/iEMcEAQSig3FCYJ9Ijv/MWqiAu1MvfhpKS5ovvLZhjVv1zhO1eRqy8fu
	xzAZROf8zGrGOdY1H3vKJ9KqJRdjb4j5yrvVm8uTlLUW+fwWXeDxlu5Y0B2zsNyj
	oRqRdgTCVFn2U2VPXZ2fTwD9BlbrNQwYZ8MVv7ySQ++4e4cXtM5k7CgXolupc/cN
	ZxZezeM1kf4rncC8ILeFV8shFQDu97UQQCZ8CcyeeommX4ZNcg0gGYkOZ775odKZ
	YfRTvjMg0XjhicNRyQ7XVrYB4ALJX0fdyul8lzMhEt+2gm8Ahn5LizVaUFMbGfot
	B+s/g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gejb3arp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 16:24:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48DFh8ke013566;
	Fri, 13 Sep 2024 16:24:26 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41h3cmq3vr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 16:24:26 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48DGOQOB19268274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 16:24:26 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 07CA058057;
	Fri, 13 Sep 2024 16:24:26 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6519258059;
	Fri, 13 Sep 2024 16:24:25 +0000 (GMT)
Received: from [9.61.88.111] (unknown [9.61.88.111])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Sep 2024 16:24:25 +0000 (GMT)
Message-ID: <e9a74fbb-4367-4595-9af7-47e3786b2cb1@linux.ibm.com>
Date: Fri, 13 Sep 2024 12:24:24 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] s390/vfio-ap: Driver feature advertisement
To: Heiko Carstens <hca@linux.ibm.com>,
        "Jason J. Herne"
 <jjherne@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        fiuczy@linux.ibm.com, borntraeger@de.ibm.com, agordeev@linux.ibm.com,
        gor@linux.ibm.com
References: <20240910113440.8107-1-jjherne@linux.ibm.com>
 <20240911065707.6563-A-hca@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20240911065707.6563-A-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: trO5wOEovL71kpqrW_duYzdbAlXaaAyJ
X-Proofpoint-GUID: trO5wOEovL71kpqrW_duYzdbAlXaaAyJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_11,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=766 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409130113



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
> I stumbled across this only now: sysfs files are not supposed to have
> several key value pairs. Actually the file(name) itself is supposed to
> be the key and its contents are the value. So I would expect:
>
> cat /sys/bus/matrix/devices/matrix/flags
> guest_matrix dyn ap_config
>
> Which is also easier to parse. Is there a good reason why this does
> not follow the general approach for sysfs files?

I am okay with this, but I would keep the sysfs filename  'features'.

cat /sys/bus/matrix/devices/matrix/features
guest_matrix dyn ap_config




