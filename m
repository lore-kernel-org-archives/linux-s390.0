Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE74274FF7
	for <linux-s390@vger.kernel.org>; Mon, 14 Apr 2025 14:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744641771; cv=none; b=EQiEppa7h/xV2kUMLx6io79Nin4NlsDaBV1sgTCa7TcpcFrbGh66+SZhSoOcnj5yEUgs0lNaO/hHwpLBa7vrUkFSWVSBqb8yFA7/1oGh7Em7tk649jClX2zBl2Fo97lY67kMXyVWPsBiaPNclES9SCiL6fKj7qLgvt16oK9pNpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744641771; c=relaxed/simple;
	bh=wA67Kx+gVeoIgU9drQMQCtnE2gA5mn6pzFyyD4fQqFI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=n49QRG8qoXwCTMjsf9HPV99f6aTIGFOZj7Q9cLM1ehRg9iHnsjH8TMf6LTQ9kNYEg4aUehQVPn14RFXiR+7R/OCv13nruuYZW7M8cHAvipIarXr/X2GEy2c89UG/h1mL2Amg/FDOD/W1LmX4OnMiFLPak9lRMCiP9Bt89CCmojg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iz7k9D/V; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iz7k9D/V"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53EAfBhc013055;
	Mon, 14 Apr 2025 14:42:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=AYX1tVXs6ew8ige1tB4EWbIUSjuF8rhD9GyM8DqJciM=; b=iz7k9D/Vnabs
	EYXZuiww0DKRnERt+DnnFcsJBgUTYsOW4JZ0uvGcn9NxQWCemZBTc9KCngoum3XP
	SUJVgSczeFuFdvmcjWM2wm5QGPkJMpsqjexcCEmZtvpBMKCqWCUtjvgiJoGh4W0p
	Q6nV1/w4XpleDc1tiHA4njKUvvF81iQYdKH3b05+vnIZYXA21wDTeV0MUjwI36SD
	hXkuAlHuB27xXjqc8HhRND5lM1C8XrvulKH5RwyQBtgniPlruBaCNIQ0IbUrMP41
	6F6x7KH3o4KGgXzGNzIoMI97eS8EeCbYpA1+oMZsLp/Gyul5KmWTY6+txgGGJxgx
	Ev0Xn5560A==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4610tp94x8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 14:42:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53EBxumB030910;
	Mon, 14 Apr 2025 14:42:46 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4603gnepjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 14:42:46 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53EEgj3934210382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Apr 2025 14:42:45 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E16858059;
	Mon, 14 Apr 2025 14:42:45 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D3F558043;
	Mon, 14 Apr 2025 14:42:44 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Apr 2025 14:42:44 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 14 Apr 2025 16:42:44 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Holger Dengler <dengler@linux.ibm.com>
Cc: ifranzki@linux.ibm.com, fcallies@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, seiden@linux.ibm.com,
        borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, linux-s390@vger.kernel.org,
        herbert@gondor.apana.org.au
Subject: Re: [PATCH v4 14/24] s390/zcrypt/pkey: Rework ep11 findcard()
 implementation and callers
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <e9b208f4-f399-4ace-be0b-12d840afd0e7@linux.ibm.com>
References: <20250409140305.58900-1-freude@linux.ibm.com>
 <20250409140305.58900-15-freude@linux.ibm.com>
 <e9b208f4-f399-4ace-be0b-12d840afd0e7@linux.ibm.com>
Message-ID: <b73d57574593d968c7a0316df5c51ab3@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Wl2lKRxS5HKQn7tAEnVgvDVZPE1fIoVo
X-Proofpoint-ORIG-GUID: Wl2lKRxS5HKQn7tAEnVgvDVZPE1fIoVo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 clxscore=1015 mlxlogscore=741 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504140105

On 2025-04-11 16:18, Holger Dengler wrote:
> On 09/04/2025 16:02, Harald Freudenberger wrote:
>> Rework the memory usage of the ep11 findcard() implementation:
>> - findcard does not allocate memory for the list of apqns
>>   any more.
>> - the callers are now responsible to provide an array of
>>   apqns to store the matching apqns into.
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> 
> Same as in the previous patch. Please change the component in the
> first line of the commit message to "s390/zcrypt:".

Done

> Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
