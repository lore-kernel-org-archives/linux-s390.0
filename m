Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291F4353A8E;
	Tue, 11 Aug 2026 18:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786471410; cv=none; b=mfzcWDm42A6ElQDg00EJGGH/+Lmlf8GwoVpisNfq+07CO0pO/9A/dJcHgiJPQgA1yDn7fXyxJ8kF+foJK5a7VW2sQnG3DQGQu4vNZA34hhTz5o3dSnJG/OFXX9IecLgGgg7e1pujuY78J6ERGXgmZibgutl9ae1R+c6gBKm99ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786471410; c=relaxed/simple;
	bh=2cEiUTK+j2k2LhxcpuJtGy7S7VmJtxedBk3JlkLuCSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NPYxS/4rmHqdXIt2Osdw98sHDR5QE/xJHfP7GGqxlDlrq1F4UL4X/SIiQy1ZawoNnzn219mVVLYTqXNHenmQ5KCGls2mm32hXXLuWaYsMFIDqyutb//cap9X3M9Yxi+Ea0ukC1xGfItUaXC/LGeFsJU6iUeNcab2RtxM5OrzudE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XmwLAlWi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XmwLAlWi"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BGVZeQ964167;
	Tue, 11 Aug 2026 18:03:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oqJ7+f
	c3gaVlPxGKXkrIy2cQGSTplVPXkuayl8B27Vs=; b=XmwLAlWieEJNwN32RHcbas
	hOdrnSiJMrw00O4xUi8e0YX67Gp3l+/X7U9xPDZFYTVrjEw2uDU/Qo8KDWEhctPM
	w8rxbGdtFVw7gdh37qMfi33eCXKc5swsg2QTa9C5AtIdPI5LSJ7cVobS0rMrDP2L
	EwHvlGc7J+vzfGq55AyGhjLScsVRXd4wbQpyTjsWiT/TrBWo+RShuqiI7u6vau3i
	3r7rGiE82HbuNQ4Ppe9Ez5hprjbkNpdKn+TouMSt2/tZuVK6n0nXLq1Y9143fOIP
	2jSfxsCln0nedg85aJWPi2MYgVM4VOqgN7rVxs/quxPsawac9sSEuY4iECPSB6BQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnw5njm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 18:03:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BHuFGw004483;
	Tue, 11 Aug 2026 18:03:21 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy1w92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 18:03:21 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BI3J6K28967674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 18:03:19 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 06AD358056;
	Tue, 11 Aug 2026 18:03:19 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E938C58060;
	Tue, 11 Aug 2026 18:03:17 +0000 (GMT)
Received: from [9.61.146.44] (unknown [9.61.146.44])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 18:03:17 +0000 (GMT)
Message-ID: <5d755e25-be9d-4227-b06c-63563fcce0b5@linux.ibm.com>
Date: Tue, 11 Aug 2026 14:03:17 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] s390/vfio-ap: Fix required lock not held during
 display of sysfs status attribute
To: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        stable@vger.kernel.org
References: <20260810192257.1208410-1-akrowiak@linux.ibm.com>
 <20260810192257.1208410-8-akrowiak@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260810192257.1208410-8-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7b63ea cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=mRNGE5xck6wB88bdPRQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 7TmqHGtq_mZYvfNHfK2pTySmveNgS6bG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1MSBTYWx0ZWRfX7rwtsk62QuUV
 eVmobY+Rq86fhoGSD8vapDrIuj/6FFSPS/jenG5sz7NvVLv2H9x67pNSmg0eLNNNTLxA2uV3EjQ
 dDq9sTylfRA5M0Igqjln6L2bBGHUePJqCT7ifseJHPXHoWeU4GnWJCERqM2GE6V6OzeI7Nt/jou
 JdHf1O3tGMnFiqzCe4L28sYMM3wD0pZ4N5imebFBCHLf0+x6raiyZbf/4YEI3p6GckWatMUzakq
 MBnyHK1gRjwiTD40FimQ/98pCFx1sJYwtpEXY5M/+mqBMm3EMDwy2rWjV8NTqct+3mFWZh99L0Z
 RNnv+NIiz0z+e3a5lWPlO/V0ryWnYL5m51e+MGmkWpfTxCiTgTEiiLBSXZg8yfuu6Ytlvl1iMOt
 Su0uQly9uMu558YmrqtpoTfuP9qnJ9WqxlaqlczRLOEXx5Gk+84UAgh2NDz/lOStEgSovJjIOjH
 bQeMcPiEdQ7Bcm0D25Q==
X-Proofpoint-ORIG-GUID: 7TmqHGtq_mZYvfNHfK2pTySmveNgS6bG
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1MSBTYWx0ZWRfX8rFNdYKdPt5y
 qisJoYClvhTFk7cgh16Vj3siAuMdAH5aO/t6pnQbolz3QdpqccvMJulmFVb2e55hfEejeESpooe
 AmwI6fIrpI/yKlAsPsjoHy4ulIb1+kg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110151

On 8/10/26 3:22 PM, Anthony Krowiak wrote:
> The status_show function that supports display of the status attribute of
> the devices in /sys/bus/ap/devices calls the vfio_ap_mdev_for_queue
> function which iterates the matrix_dev->mdev_list to find the object
> representing the queue device whose status is to be displayed. In order to
> traverse this list, the matrix_dev->guests_lock mutex must be held which is
> not the case.
> 
> To fix this, the guests_lock mutex is taken prior to taking the
> matrix_dev->mdevs_lock mutex in the status_show function. It is taken
> there rather than the vfio_ap_mdev_for_queue function - where it is
> needed - because it must be taken prior to the mdevs_lock mutex in order to
> adhere to the proper locking order and prevent a lockdep splat; also
> because the mdevs_lock is needed there to access fields within
> the matrix_mdev object in that function.
> 
> Fixes: f139862b92cf ("s390/vfio-ap: add status attribute to AP queue device's sysfs dir")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Please see my comment on patch 3.
