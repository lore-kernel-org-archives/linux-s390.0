Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5812D306746;
	Tue, 11 Aug 2026 17:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786468477; cv=none; b=lQ6b+zFaqn6Vop0jnpNrLLCNrxGHdqAD4XQlAA8EQtNCdRx7k4G5ldR7MMjCltl1BEdV8OCwq3ejdTP7yH2Z1DfbTbQc2PquINw7sRAspU9w6hN54uS8V5NNWjolBM+gWY4w0q+TF3AdYGNmk3sSL7ix5zM/LwZopXLgGQoteKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786468477; c=relaxed/simple;
	bh=Q/ksM0QMABaKKsiqCITd5f2nB6oFJDJcUWwwm/0oyOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PFHo0z2eI83iGD986PmccPcClolcoEyyJTnZ/JD2WPs3t+kytMpuOxQNGpSgCW0I6nR8RqHhU4WqwKtGQ/x6uoNLNWyGzEEaeZ4JwQR5BsMP+10It+BWJD4jLFNNKbTf3IWnUJxPAUwtRyvWBgS5Gt0FNiKCACLFKA/1HDZ68qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i3ZCcG5t; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i3ZCcG5t"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BGWOf93261984;
	Tue, 11 Aug 2026 17:14:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SljJd0
	YeH3S/eb54DtA2eHJ2bBZHqD69QhepG13BVus=; b=i3ZCcG5t+ZYDWgeKAc3WUe
	Uj2geaUkIhfccXJh0RtlZMu3+vTLQXEMo+TwvnDmBcYj5PR4vw8ed4zdC9uAtKBV
	sjDOeObJ2z0tNoFcvxUOlTmp70XGNFg3/L2mPkJCJ/k1k0UYNgWiS7u6b7kTRdcM
	d9fd0brhy4PYxBlnWR2w4/kqVWDFyDzCb4G4O0/NUZXfKrAc3e2MW9KGu8RyWIvd
	PADyvF/uRhbaGo3sLbGOeqGjgTcpyLQqHIA4+ld0qGdIpAhw8FPn0SXQwEzw9FEy
	YHazVo3+KhxhFHmK8OAVD7UC8xPLJJfmCSE8+MfEoMm/h4CAVDtkjJrLfcoAipOA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvjyx4dw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 17:14:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BHBKBS028296;
	Tue, 11 Aug 2026 17:14:28 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjsxq4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 17:14:28 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BHERFk58196358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 17:14:27 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 964BB58060;
	Tue, 11 Aug 2026 17:14:27 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8536A58056;
	Tue, 11 Aug 2026 17:14:26 +0000 (GMT)
Received: from [9.61.146.44] (unknown [9.61.146.44])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 17:14:26 +0000 (GMT)
Message-ID: <e4528f35-2751-42c4-8a64-656183737157@linux.ibm.com>
Date: Tue, 11 Aug 2026 13:14:26 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] s390/vfio-ap: Fix control domain removal in
 vfio_ap_mdev_cfg_remove
To: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        stable@vger.kernel.org
References: <20260810192257.1208410-1-akrowiak@linux.ibm.com>
 <20260810192257.1208410-6-akrowiak@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260810192257.1208410-6-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE0MiBTYWx0ZWRfX1PSVpEZdsRii
 2JGdDt0JcQBpj7J46XQQtdtCnmhuqMoId2aWppS1qIJkLprjgjMifcD0HTxXRRQ3aEy9B9rk3kw
 bCUCTzCmfY2Q2SvjQycYIaI0tRX2FQBLp0++4ivlVzQ50bIYsHEKvfCpF9U+f+GNy4j7G2s7Nwb
 czJFVHsBaELv+O/hD3oCXHYxpU7Y0XnxYVRMRk89GNIY+jot2gHcNxbdkkeTnH/hrajuywZHgU6
 68huRj1O3gPOD5KCesA0jdnM4lBeAavW+8h+F/Z5BtR/ZB1DaHUM9/I+BMNm7NOZ9WkWmSZOBag
 YHnmNV8RVYo6c08BMn3FQDXxiH8n8sVwuL2izpXASn/nBBKgbtTpPnzefRfKoVZKWLWUGImz96S
 SxfqyFH0OHYOo7flK6MqmO1B4huLihe3R58xR+5CRW8jZZqfbLZniouFSevAOeAeua+wTt2y3yO
 KxZsy+KJr2pWCc5g19w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE0MiBTYWx0ZWRfX3wxhe6S/WerO
 bfDEUzrf6XFkOLksuAen3wzjufizgYkojbKLZJfBGvgtpKPDfBxs4RfFaPkEiHopj9lgIQGDSwM
 r5a/c4qlg3v8INwH0dtdmvPYBH3L8Es=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7b5875 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=w3fCFjnWj7rHUh7R76wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: JvU9W5NSQro56y8TYiYqogMipqog6yPH
X-Proofpoint-ORIG-GUID: JvU9W5NSQro56y8TYiYqogMipqog6yPH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110142

On 8/10/26 3:22 PM, Anthony Krowiak wrote:
> The vfio_ap_config_remove function uses the bitmap_andnot function to clear
> bits from the matrix_mdev->matrix.adm bitmap (specifies the control domains
> assigned to the mdev). This prevents the explicitly unplugged control
> domains from being removed the KVM guest. The bitmap_and function is used
> instead.
> 
> Fixes: eeb386aeb5b7c ("s390/vfio-ap: handle config changed and scan complete notification")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>


