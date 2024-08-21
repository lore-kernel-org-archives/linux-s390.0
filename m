Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AB71CC144;
	Wed, 21 Aug 2024 09:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724231594; cv=none; b=j32JMaQ+t0oP72lXBOskCp89ue8WW+b3kKp4V6AyKHTlCKet4s7EMS9ya3gQXWamCsBeVQ5bqEb8CRzIihKVX86Gmn0NHyfVlOsW0jqdmtxCU1bzUzgWi0DW3vf2qM4+N2hSBX7jw83fRT7yMVIUI9bBxiOZUOfmpkhYhzkMA6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724231594; c=relaxed/simple;
	bh=pf8Og0SoBfFPyXgKmaXCMd0VN85JJoVJguEUbRuQGQo=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O+xU6AOiHnKlAFNv/x7A1JpNiPYjqFtpQLV+MrweVBimYz/do46fPt9Wzi239H0w2pXAnVv9VQPk/5/pA8J8aw4x2XLCq/fDoR2iiM7NnWE7YQ0u5wIOZxwNhpe1md+vyKC4Fj0pFO+cT6DRhjrKjXytOsxoRpjIpdLdn+R3DPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fF3ShFS9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fF3ShFS9"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47L3NJ1u001697;
	Wed, 21 Aug 2024 09:13:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:from:to:cc:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	pf8Og0SoBfFPyXgKmaXCMd0VN85JJoVJguEUbRuQGQo=; b=fF3ShFS9Cy0CTrUC
	oRx942KTcRJh8udEKM2+DzNbKHm1Na4aHUXFJ1hlyTeEGzzXVoV7BO+z6DKkYhZG
	aE0HTQ7qyFOt6T9TvoUtBxVDRRHC+0tf12pzRBCYZolFNgQEK1MJTcxOy3OVKeWP
	lJfkZmhRpeTijocV79GDBLiVBQngBLvg+ps+Y7HgS7vQv1gEYzeRcCpVtJILvP7h
	MkzPUXqHOtISVX8jL2SONb9BsqN055aO3VlgWpALtaNcyAQlOBPuVkjOFD4O/jDa
	38mAcKBNjWVvuqfVVTe/87uaqck4s1dcnU/s4lRdyK+F6BmjHg6H2IaZS6D2c5Gq
	7mv2IA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mbg17ew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 09:13:03 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47L9D3X8027913;
	Wed, 21 Aug 2024 09:13:03 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mbg17ep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 09:13:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47L8fTaK002207;
	Wed, 21 Aug 2024 09:13:02 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4136k0q4q4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 09:13:02 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47L9Cu0w54526386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 09:12:58 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 460CE2004D;
	Wed, 21 Aug 2024 09:12:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8F202004B;
	Wed, 21 Aug 2024 09:12:55 +0000 (GMT)
Received: from [9.152.224.208] (unknown [9.152.224.208])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 Aug 2024 09:12:55 +0000 (GMT)
Message-ID: <2516fbda-3f6b-4b9c-b499-701f4f922cc5@linux.ibm.com>
Date: Wed, 21 Aug 2024 11:12:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] s390/iucv: Fix vargs handling in
 iucv_alloc_device()
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        kernel test robot <lkp@intel.com>
References: <20240820152911.3701814-1-wintera@linux.ibm.com>
In-Reply-To: <20240820152911.3701814-1-wintera@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4HEkUCMmYNSp8brqdJRqN_3nOytY_41o
X-Proofpoint-ORIG-GUID: GqJ6N0QcCzlhrlzilZTtVpYXBaktJEBT
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_07,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 bulkscore=0 mlxlogscore=785 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408210065



On 20.08.24 17:29, Alexandra Winter wrote:
> Reference-ID: https://bugzilla.linux.ibm.com/show_bug.cgi?id=208008


Argh, I forgot to remove our internal Reference-ID from the commit message.
Will send a v4
