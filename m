Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B31338592;
	Fri, 17 Apr 2026 07:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776412156; cv=none; b=K2eOWICzirZfaJ/8WHZrRUyz+KcDuiiHaE20F6EYLe/Zj5G1dCSkZle9iAZLZGISXMLCVJUEmxCEo0ASPg9esjwcRfs53N8i/oX1FnSJStZ8r08jRZuve7KHzVYMG+mhdc2LpG+Ey6ofJht/zPXzK5OxjPMuY0C/T2HAn0SGDA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776412156; c=relaxed/simple;
	bh=3AJkA/Ut2jjL6oMRz7VSDAI+eIzyTGlmE9O5FcOfroY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r/m2H5g6MFEYTHJks6/Mn8LXVbKzRqSDKNbBfE9vSNpA6JsY8LlLkItWcxqBhq+kCeueswoGMZAMGjq3/n9jRZYi4zvy3Ko4eX+Ke9Ro9d18B0gwx06FyW1JxtbabMETkylxM2AdMLlmm/Lb3y9t70S7KAgeCTiDMrK+JSlaDTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H3ln9FVD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H3ln9FVD"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63GH372x435815;
	Fri, 17 Apr 2026 07:49:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aCLNvU
	N7YOHtOAH9Wo9JqwmL5rdCFPZd9ShBWsbMBPk=; b=H3ln9FVDLOek0r4F9rWyd+
	ZMlEtajhZalLZEk6oyE9oWNeAO3lPtgxV8i7hs5VsvXqX2bwJfWhFFzjFxdAzMX6
	nM3QSEBWg/heXk8S3tI1etSs3QZDuLLNjFacIK/p/+1XPHivVhV/eFM2R2dfl0Ij
	Es3dmOZ6s4FkQQImIGGpeYO7XVTC65+AqluOUr0xcDnDvqZQRP7iT+1v5sZV2wt1
	f8eXHQkk8rXvTQi+HIyXK0biitHJ5jtS7DWH/LqodJH/y+nV0VWDOLrqRItx5Kc8
	BJO9G+CrdKxibAMGAbodbQl3fY5oZ1f2gPLji6k6gmUIIhWsT6gmCJ2YFFbEFqkg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89kgarc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Apr 2026 07:49:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63H3iD1O025837;
	Fri, 17 Apr 2026 07:49:05 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg2ujx4cp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Apr 2026 07:49:04 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63H7n0UX31130168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Apr 2026 07:49:00 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6C682004B;
	Fri, 17 Apr 2026 07:48:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DC9B20040;
	Fri, 17 Apr 2026 07:48:59 +0000 (GMT)
Received: from [9.52.200.39] (unknown [9.52.200.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Apr 2026 07:48:59 +0000 (GMT)
Message-ID: <e381b39f-0075-43c2-be8c-131c553702f1@linux.ibm.com>
Date: Fri, 17 Apr 2026 09:48:59 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: s390: pci: fix GAIT table indexing due to
 double-scaling pointer arithmetic
To: Junrui Luo <moonafterrain@outlook.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
        Niklas Schnelle
 <schnelle@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>,
        stable@vger.kernel.org
References: <SYBPR01MB7881AB7449FEB6B58E4BA6F2AF222@SYBPR01MB7881.ausprd01.prod.outlook.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <SYBPR01MB7881AB7449FEB6B58E4BA6F2AF222@SYBPR01MB7881.ausprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 0Uu0q6F68Skj7wCiv1vhRP61mLUOsAVD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDA3NyBTYWx0ZWRfX7CqUl1ABynpB
 cVkbYamIHX9vx5qmMdzRSD4RadfFbwGRz6bdHkbO+FjhkzjoYb2ENQm+ygWhWLrweKKbY8nNbvo
 VIeoUE5uJS9ATRCYSX6jfME4uNakDnGeSed0Zbur0DgfYwlYA3ZMf5jF31oIkH+SEqB2Y6oYibh
 pxMwxOMhr3O+2E4gOgmSEXGE5XOH/NZBpZ+He/g5fZrJo//qekXYbm+RyPdPu+hW4/e6+14cO9N
 7r/bQVbuRtHn2EDUp+wiymauZ7oEGpsrrOq6QA3LkK1527HRZqauNOAQUiW//rKrXMuBqNZSbfn
 Da63cZTqNVWRdWTioXKvZotPB2+7P6xgpmN+GBKk48Xmyed3Q9/WWRVMcWSyuNOHVvcgiE9J+xW
 Ipl86xBJDCcZx8FXNY5fVOnBiwk7VH9pY2WP9UYfU47/Eia2ydfvvfxrtQTqFY1U6Yav0NIkcrH
 Yz78aNLfPw1BBlVO9Tg==
X-Proofpoint-ORIG-GUID: wwMh_tvetK0H5EyOgFYip3_UKFa_Peku
X-Authority-Analysis: v=2.4 cv=W60IkxWk c=1 sm=1 tr=0 ts=69e1e5f2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=UqCG9HQmAAAA:8 a=I2cwCrv0WPfETOthkQIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_04,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170077

Am 15.04.26 um 11:26 schrieb Junrui Luo:
> kvm_s390_pci_aif_enable(), kvm_s390_pci_aif_disable(), and
> aen_host_forward() index the GAIT by manually multiplying the index
> with sizeof(struct zpci_gaite).
> 
> Since aift->gait is already a struct zpci_gaite pointer, this
> double-scales the offset, accessing element aisb*16 instead of aisb.
> 
> This causes out-of-bounds accesses when aisb >= 32 (with
> ZPCI_NR_DEVICES=512)
> 
> Fix by removing the erroneous sizeof multiplication.
> 
> Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
> Fixes: 73f91b004321 ("KVM: s390: pci: enable host forwarding of Adapter Event Notifications")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>

thanks, applied.
