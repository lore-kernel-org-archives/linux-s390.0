Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4B5480DC0;
	Wed, 19 Aug 2026 17:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787161812; cv=none; b=WcDRyf7A6mKlEFJDldPqhAWkdBA6JR51HVW8J5t9IuwlOQ+eT0m43Rqp6loJVUD9J0Yzw6RA8DAp+Mh0Ua3CS1W2iiKfnyOosHE6fXwthl/z5omLiSh/sz5c1O3H/iLqQQ9CitsWbGOQ/zmeFEqhRFYY+drsOYZP5sunKBgq+Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787161812; c=relaxed/simple;
	bh=1Tv6g9nogzDc21X5QGdGImsg7Sc4DX7Nr4yi0kpvTWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QODPl3OwNQ4hDinS5oVSx9fyZBRE+aVS7i2T3/VlwnmIie/3yVl9Jzmiss1Ej1920fxyq5xp1wiiyveshtOaDFvLL1owGGUy14EAL6RsIJhrmhH1BeU5zC/C7O9VfqDRsFn/gxQSZsYht+NM7VC6Utzq4ziplerUSX1S3FRyC/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mKNqMytB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mKNqMytB"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JF22vb3697148;
	Wed, 19 Aug 2026 17:50:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ppWGPw
	CHANCv2S0BY/0ZRVZ9ZgCIzOheO5sTejzcpQQ=; b=mKNqMytB3hRVz1RVbH80AQ
	woLJmtVguXmc4lBDncz73MufbpA1BZgmW6aLHl+AVa9UwtzwSpWAQSMF5hKxqUk8
	lhLtXfeNw9NSrOrU0/6bqFXPuks4AS7X0S3VtkiE9jHWBuD04pUwBKNVJXSetc2z
	8iG7uRjCRF2mNTpJxgpvjU4/UGSlzeN1TDrzIUNa+W3Mnvo+OhByxk5dl8uu2hgW
	cpeQFTHgTECjW4ueG1CbS3u0QABGplI5EJp3V3SUK7pivI1/icgP2O6NLaOqvRdc
	ptkQxQWTh8qNQHtiIoqwlmVdTUE3nXImS/HETg+ZHMXvY6PYE9wo0EPWye1gpiLg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu458wc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 17:50:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67JHfHWr029207;
	Wed, 19 Aug 2026 17:50:01 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354yhxa8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 17:50:01 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67JHo0AR56164812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 17:50:00 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F382C58051;
	Wed, 19 Aug 2026 17:49:59 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 089F05805C;
	Wed, 19 Aug 2026 17:49:59 +0000 (GMT)
Received: from [9.61.88.99] (unknown [9.61.88.99])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 17:49:58 +0000 (GMT)
Message-ID: <b9f2a8a3-3f0e-440c-a514-638c1ccaff8a@linux.ibm.com>
Date: Tue, 18 Aug 2026 10:47:25 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/15] s390/vfio-ap: Transition device migration state
 from STOP to RESUMING
To: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-9-akrowiak@linux.ibm.com>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <20260807221834.562851-9-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEzNiBTYWx0ZWRfXx2iIh4KbMN7k
 gjqjgHjTtrWcbBBd/F1K+bEfGaQFqCUtDb00ww0T5UCGgEf+tCNjoNamXeDKfwSrn2/slk7kDLs
 198JdPW1vYg6JvP5+NuphrttzFWV7u4=
X-Proofpoint-GUID: FbxmWILMpt8Uc1eBc3Psw9wOkkqIq1yh
X-Proofpoint-ORIG-GUID: FbxmWILMpt8Uc1eBc3Psw9wOkkqIq1yh
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a85ecca cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=7Uee-v3Jn_Um78p1p_UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEzNiBTYWx0ZWRfX/Dyo/ay2r5Hc
 z2Bwqp6kXxLIXh2rMgzzczFBkuF0gw/LCDr+3yah+JI42gN4Gg3ovWp4Sr5J+/clgADpkVwGySF
 6v3Xql8S71KhFm3QUmFPEYlzS8rhRdrTxA4UJcePcZ5O5XibLbrdSWAnSfY7kKsILf2m7CBjXn+
 wAlxbwSptNLhtC9dIRLnEpDe8f9MHnNIQzasPnoGZhivTs4UTSnyYqlkrUUlwY+xZK2xpbR3qxC
 CRz4zlyNMzDwTSb/HHslqE3FzkmcRsGzv6l1/ic//4ihAkFgENOR3bc/gpqTGmuT9RJAFgrGw9r
 0vB5IfygcpT2E9sGcXZJWbmzfdsDy2Dhsmk/WOqhAUc/25lThIV3HLzTd+9ywg29SJYSINMHpZ3
 fckoKaYu12ssgBXFiyoYyXV+Xkz1SUA6QcAYZaePpix+9YR9MmV5HHZS41xcq/dTc3jUOJARVUd
 mC97XATD+6DoW1xcLew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190136



On 8/7/26 6:18 PM, Anthony Krowiak wrote:
> Transitioning from VFIO_DEVICE_STATE_STOP to VFIO_DEVICE_STATE_RESUMING
> starts a process of restoring the device state of the vfio device on the
> target system. To prepare for restoring the device state, open a file

destination system is a better word choice here, target is somewhat 
ambiguous. You can claim to "target" either the source or the destination.

Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>

