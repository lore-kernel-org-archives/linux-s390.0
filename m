Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C5F15442C
	for <linux-s390@vger.kernel.org>; Mon, 14 Apr 2025 14:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744641706; cv=none; b=e1I3h8sKMZG9DDUiRWcDRQkbQUdouyaARuCwWnoo5KG32mtO4VC0r0bvybAiiYQ6HCuap90ErwKq+WWLaLrWWhgwvGOT9r8uCCqeWhAYw1+SElgGCWW4KnLcMLi2VEFVIhVY7E93mWWQaGnawSQPn35kg6YOX0ngUQFSLiCLpo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744641706; c=relaxed/simple;
	bh=syBiYEFR8MEtgclBlQeHKLXwoFBmr3h+quqOH6sZdko=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=RFOasz7Ep1pVKKKGcVnDFZ5ciXbu/R6I9QbJdqYRwKFk7bdRhhh8hd6/HhfJtBa2W5jENhpJvf392e6AznSLO+U1cZZcRMjdOnr9M2viFOo2jfT47w1wtiNKfTKbow07/PTA4FJUipGMs/bjuXmJlF2A81hGJhl+oCnT2de2OzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=esuOeVL3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="esuOeVL3"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53EAPtbt030046;
	Mon, 14 Apr 2025 14:41:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=WRRW4ngyNhnoWdHiPlKjZjKqjQ4X9tWPqTBTLhW8qxA=; b=esuOeVL3As8H
	l51xOhVOCn/5DrmxmZ2K2tOvsA8BDTLo+N5vd+SEJSIxK7SamP/OVa49w9eNRBCZ
	inzRAGYR12SpYaThgWJeJy8OKASwu/+upnfeazlU048cPI9KN+vvbK6SsGBRj0X6
	ukzYSuU5MKPKdTlYEztAyX9avAxo5SF744DadNFdrO82mX0j/86/LWJMCzmZq1Az
	yCAVrAmuFWyCQLTXH+VF4slzEiO05Kzr/Yr5Bpl9WQWk8wvAQ/yLD29Qyjgud1Dp
	Pqpd+w8jwSxrN/fa/5dcPh8A+DklrVFExW82PdJIu46pCJnV3txJzeAxInqLZUE6
	6DtPcsJPNA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 460nc4bw30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 14:41:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53EAxaFO024914;
	Mon, 14 Apr 2025 14:41:42 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4602gt6y82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 14:41:42 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53EEfcab29295348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Apr 2025 14:41:38 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 823B158059;
	Mon, 14 Apr 2025 14:41:40 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DACC58058;
	Mon, 14 Apr 2025 14:41:40 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Apr 2025 14:41:39 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 14 Apr 2025 16:41:39 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Holger Dengler <dengler@linux.ibm.com>
Cc: ifranzki@linux.ibm.com, fcallies@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, seiden@linux.ibm.com,
        borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, linux-s390@vger.kernel.org,
        herbert@gondor.apana.org.au
Subject: Re: [PATCH v4 13/24] s390/zcrypt/pkey: Rework cca findcard()
 implementation and callers
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <dda9a747-2d94-4506-8577-b63d74f4be09@linux.ibm.com>
References: <20250409140305.58900-1-freude@linux.ibm.com>
 <20250409140305.58900-14-freude@linux.ibm.com>
 <dda9a747-2d94-4506-8577-b63d74f4be09@linux.ibm.com>
Message-ID: <f2424e534d149ed7a7f01c8d80fea31f@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xy5Zjf2viEYxO8azLPsS7w3UfgYwAbbu
X-Proofpoint-ORIG-GUID: xy5Zjf2viEYxO8azLPsS7w3UfgYwAbbu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0 mlxlogscore=800
 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504140105

On 2025-04-11 16:16, Holger Dengler wrote:
> On 09/04/2025 16:02, Harald Freudenberger wrote:
>> Rework the memory usage of the cca findcard() implementation:
>> - findcard does not allocate memory for the list of apqns
>>   any more.
>> - the callers are now responsible to provide an array of
>>   apqns to store the matching apqns into.
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> 
> Just a nit: Please change the component in the first line of the
> commit message to "s390/zcrypt:", as this is the component, where you
> change the API. The changes in pkey component is just an adoption of
> the API use.

Done

> 
> Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
