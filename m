Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152063E9C11;
	Tue,  6 Oct 2026 14:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791297808; cv=none; b=mlmJzNzIz/nTaUx5H2vYB+tnT+hrqZNNSKmOg1HakiUw+af2wt1v0dvCWRpTzLfWwPNZnNrXstlWjamaM+QBpcrrlLb6AmUREjLnLzWcMaCpVixS22kbfNR3Nlqx6exPB4Ijp2ETShXm68B1oAgu0B8sKPgSi1UxM+Xv2vd5W9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791297808; c=relaxed/simple;
	bh=7oHzIvYeHiizqiogB7omvErIZFIAVs9iBms3sftGfyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MTQ/zyGOkvcybqOfDGojKoAaotaAtvkxRvpN974Fe1eYM9fyY+fyMWZL35EGXycPtDiQgKR0u0vDNLdB4zdw1GUtc7ptH6FAlJz12VIfhHu+rpPrkR60IQ/t4L6GqTYvehDrk8IQUQhRuDLiFrlroH7VZlmGyVD2fhfoLQ8faB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HZCe9Pbl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HZCe9Pbl"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696EZNOE2182177;
	Tue, 6 Oct 2026 14:43:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7oHzIv
	YeHiizqiogB7omvErIZFIAVs9iBms3sftGfyc=; b=HZCe9PblH5jgcro4mEsUz8
	T2VAqej3a9gE+f7K4mLCWMJDvd1suxDdd54o4XtjOYIJstkQQU6Sx5LAUyVzOGpj
	aBFtaZNWC/75CQdHLQGYAwfAJa04athbpVUS2eArRJ1+VZLvYnlI2iyDTkE5+gQ1
	galwrCw9G/vV1eCR9A1IfHLK2jZcco5bpDSNHiAx0cATAGtmZY/LMfjAlt4YEYdA
	Gc7tww7MbgDxnue+L5Sdq/o0FS/jKhTXjv9BLj5QCgCDS1Tb4/0DhJ1tXd/x++rq
	yUTPcF2TxmktGp7GaWRHv2izZx6X0G9cxlkrEZ7O4oZHHmdi9V/SRZWU2E7nOncw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2scrgj07-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 14:43:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 696EHV68411028;
	Tue, 6 Oct 2026 14:43:18 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3c1pth4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 14:43:18 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 696EhHsQ64029172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 14:43:17 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 260B45805F;
	Tue,  6 Oct 2026 14:43:17 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 914DF58060;
	Tue,  6 Oct 2026 14:43:15 +0000 (GMT)
Received: from [9.61.78.19] (unknown [9.61.78.19])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Oct 2026 14:43:15 +0000 (GMT)
Message-ID: <14f2e235-8e6f-45a7-8d66-7bb5a0aebfb8@linux.ibm.com>
Date: Tue, 6 Oct 2026 10:43:15 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/15] s390/vfio-ap: Transition device migration state
 from STOP to RESUMING
To: "Jason J. Herne" <jjherne@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-9-akrowiak@linux.ibm.com>
 <b9f2a8a3-3f0e-440c-a514-638c1ccaff8a@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <b9f2a8a3-3f0e-440c-a514-638c1ccaff8a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA1OCBTYWx0ZWRfXxqWpwFfsgdVB
 aOrcNRJzoRemC8VQc2SogXuw3iHDHtJkjDMyOxQ/VI2/xaJPzEhkmUYEOKeLepav0tM3zJvy4Ww
 1kEgbXox67abbTIgJ/SjWtSNdssA/ms=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA1OCBTYWx0ZWRfX3xVt61akD7V4
 ekYahApu3iocgBgs6nNMD/EVnVRv8dvNDTJEUE7THMM05X1rd+kH/2AhXHLm/sU6H2e0t+cJiTa
 pWeROfpe0fV/iMg8q2YhvlDNs9RzMu02E9pPnnM/YQoZagvV3a53oCh6rPc4YNKqrrJuPq2vlud
 YFZANH5PrITAyQ8tb0g2/NvXW8OMrVUy+PZVbncf93qJ159O+vdg7W8WLqC/d8LR2gGw81jJUzx
 nm88XG4kFsrHMSGTxZtIdUeEmFDyEjH+CxLku97dtJqx5ZL3PWzLpXliTSqvzJ6mrp6A6HTGdIu
 Pw3KUgIRZMGxhdWUi1Hs8/tMV5gPlrHxKeYCuFlIjsVAabUJT02B+581YSaFnd+7XHc8g1pdI3z
 ton8dGlKUMgKRCFlFzm3mxtSZJOWLjCJr31S9RrBX58nBmyzkCrID9Oj4iQU9nReWwgAktovV26
 wTlZGh8j5vGz20RGV1A==
X-Proofpoint-GUID: CtbVovUwJ2GyP_XN_kmQanGFRDbusZZy
X-Proofpoint-ORIG-GUID: CtbVovUwJ2GyP_XN_kmQanGFRDbusZZy
X-Authority-Analysis: v=2.4 cv=B7osQ+tM c=1 sm=1 tr=0 ts=6ac50907 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=dLfSsbSt17uSW5BjoMoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_04,2026-10-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060058



On 8/18/26 10:47 AM, Jason J. Herne wrote:
> Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>

Thanks for your review.

