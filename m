Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB4337BE98;
	Mon, 13 Jul 2026 11:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783942460; cv=none; b=b0sY4bwzor+kGEAJrh1CBeiP9j1RIEMfbC+GKle9Yjw2MCyMdcJv8Q5EOEPGCWCEr0cfodXI3wwkYXlHIM3/fC4OSSuPqbwEO5O+xLNZRtFXTDixeBmoKjgfFOIN5z+rEJnrMiUnEbgKT1h9q01Ea0MqLLfumeg7/3mkJRY9bq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783942460; c=relaxed/simple;
	bh=ZTI+FUJnqXa/1PHVLYL5lXENJ2r/mSgCcgIo6Bq4EeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o9n5qWzQyUCETQP2qyho44jKGrhvV5qcQbMurfRwiHG22nWhAzaVObCtRbd8YLx2sAdSNRPuJqXzyqXZeAhYk21+57gWWrIDpFu6BjhdxwgoFGVeMzgPoX5q8GxW6MuBleGoChcGoJ0DDfHvA+JJIWu4VNpvjK6jr6twpzoT6ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QBpbCg0b; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QBpbCg0b"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6fhxg1731590;
	Mon, 13 Jul 2026 11:34:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2f5vJk
	hmDzmsl5o2XzuwfIuj3zIftjDXeRlSoiZn7oY=; b=QBpbCg0bDOlPxEzsJYg4kM
	g4ayIc3l5SHDD7zJ1gk0DD3m8sJAMe7egkBHyfDIWd08e6BJ/RSmTRSO7kI7rqcE
	WGk0kaUSy36fenuoURCZ5BWZq73ALZQ7++YZiXe8ndN6fiaEGbTXZJ0/N3VXuF3S
	5wuFGNxYf2e15JdGD7PnqD9LSI4A9OPmP6EBcQXmGeRhOTPTwMjlMxOnE9M8fLeW
	YGeZThKCA5p9Vp+5aEgZ3LPtU5IL+s0AiFRCD2sr/zGMRbWV8UVX6v6DXikrFZzk
	fVgJHRsdv3n+u5/ZmNRMDRWS26rLzpiZwGL746Ogy8xaIpD7nChFYYQjjpwkZvbA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegbg1fa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:34:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DBJbBc012533;
	Mon, 13 Jul 2026 11:34:14 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uxw4b3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:34:14 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DBYBxa50070008
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 11:34:11 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0237920043;
	Mon, 13 Jul 2026 11:34:11 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C00CD20040;
	Mon, 13 Jul 2026 11:34:10 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 11:34:10 +0000 (GMT)
Message-ID: <03826018-1116-47be-8ad5-4a07e6f96e67@de.ibm.com>
Date: Mon, 13 Jul 2026 13:34:10 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL 0/5] KVM: s390: Fixes for 7.2
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
References: <20260713083007.65863-1-borntraeger@de.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20260713083007.65863-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a54cd37 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=XSr5kD3-IMuWHpFdje4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDExNiBTYWx0ZWRfX879VbbKnpVVw
 RKWU6rJm31ckAnwFnLUe3tbfbCaFB2A8rEvSVDIHlHxPzvRVuOLt8MSA4afYG2juZsz0hqU080f
 YyUyp4yJhCPKKawssjzz/uTXy5Ofy5lovIDbDzTETVNqmJEQkDZ1kFfms6MzpHe6EtqXIEu2X9d
 6X+zXiz0IF6YVQcDQQngnjrBAloFNWXT3nmfX8bYX9zy/TOJQ/xnHBfqnSsoDxipwtof2hmAVc0
 YKxBob95Lv2EtoZOzhLvedoaCfG8aq/fy6wBoP+vk9b121r4fKz8unX7Z14wAdr6g1c3tLynzJw
 T9e/Na67EL+GX26U19oke1wIJIyOv6DOefO9uwVABAEcxhAURuzfaFNy/HCk2sSYmz0VddxUw9a
 vKZmJUlvMB3XaaSpFuchJ7yvWbVUMaNKj0q8xq/ZR/ijglaKJ9nahNLicfnN2rcEuMkYYa4BboQ
 oEq/JyFxIoUcRV4mw1w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDExNiBTYWx0ZWRfXxTW4t9jneMKR
 Jc/1/ZD2r20pj10CyUmCev3E0PoIOn89Kdj8aERaUp59smBKUhrs5o+MhSXwjrUNrKiePPutPFS
 Um8vwmloM1449JTe/iDytZb9IIEuKk8=
X-Proofpoint-GUID: UjdZVrtrLvg2Q6huopE7Z0CE96m_U_xw
X-Proofpoint-ORIG-GUID: UjdZVrtrLvg2Q6huopE7Z0CE96m_U_xw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130116

Am 13.07.26 um 10:30 schrieb Christian Borntraeger:
> From: Christian Borntraeger <borntraeger@linux.ibm.com>
> 
> Paolo,
> 
> please pull the following changes since commit 8cdeaa50eae8dad34885515f62559ee83e7e8dda:
> 
>    Linux 7.2-rc2 (2026-07-05 14:44:06 -1000)
> 
> from the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-7.2-1
> 
> for you to fetch changes up to 3e3aa6da87d30a0064a17b836685cd43c90a3572:
> 
>    KVM: s390: pci: Fix handling of AIF enable without AISB (2026-07-09 16:23:10 +0200)
> 
> ----------------------------------------------------------------
> KVM: s390: Fixes for 7.2
> 
> - more gmap KVM memory management fixes
> - PCI passthru fixes
> 
Paolo, FYI the PCI sashiko findings are independent from these patches and Farhan and Matt are
already working on additional fixes.
