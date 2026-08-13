Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740224746D5;
	Thu, 13 Aug 2026 13:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786626345; cv=none; b=SOAp9LPn28M7OHXwSKwEbQ/sE/nd1TeFpLkxPF6PhoipxiYP0qMwT1wYZWmgzHIl2uJh+4j6RHhyD75Yk4Mm2Td2tp1Akncdfm0n4ETormT7sb7WHiLeVnuCCQoY6YCh9KqHdq/bZJ+Bpv7EdQ/9p9PQhd2GnWLHeOdKFowiXvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786626345; c=relaxed/simple;
	bh=XY1mUBaLv9rvxqR+a9N8Mnr5PdDxW45CtziYPO4PUxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h70xPYOqAAyZtyaWpTjKGs4y0xMNn6+DUOaFSOa2BLAn2V5VOc80wphHZB+6+itxED8epFI8Bllv6iC2rYjrEkmAgOq65UqRw/zd8OOneommeLamF1+H5xAa05eEZ3PWltF3Yk0jOxgPz6pSNQQo3B9mUIn+vz7nsCV1ofaJVGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mEeWf1l9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mEeWf1l9"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DCW4nt2293631;
	Thu, 13 Aug 2026 13:05:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WBQbBS
	sk4dtTbX/6G8uZXElHUA51A8v3Tbx+uh2kXzY=; b=mEeWf1l9N/9zbGL3kCUKwJ
	RtjNu2L4zjQwqTCc8u87W3/oNLv7tZegPW3juPVGPy/tUEYW6tcAMGvshnMfzYRA
	+p3yFtib4zS/i6Si4eoWRYeEtkJ9hvozIwTvctzmqbqVrk4LhWdTd8jqFQ/qEaIz
	Fa4pN7N+AFzlrK+eFlrjhvyBQDD1y/HYuHEh30rqYJhr23jYUbBjvpIxRWr0NVcq
	yR/YpsOvpb/CpXCgTaiWEgEqccN3GcxUmsUjIxhNwp0kMWBIkrftDRWV7Pr8sFGL
	Xoiznk7szPvz2oYTS8x1qaEFNEdLxjd24Wo/w6nCY9sgZPDgcoCTLW30Pa5gnhaw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9qye9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 13:05:37 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67DCuH06016645;
	Thu, 13 Aug 2026 13:05:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfyaw2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 13:05:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67DD5XxA17498594
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2026 13:05:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A6B620040;
	Thu, 13 Aug 2026 13:05:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9966720043;
	Thu, 13 Aug 2026 13:05:32 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Aug 2026 13:05:32 +0000 (GMT)
Message-ID: <3c541591-1275-41a5-ab85-d1fb300625d2@de.ibm.com>
Date: Thu, 13 Aug 2026 15:05:32 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] s390/vfio-ap: Fix bugs in vfio_ap device driver
 callback functions
To: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com
References: <20260812200240.818004-1-akrowiak@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20260812200240.818004-1-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wBWqBkvrVpMVfU-YlZbeVp4pflWpADBd
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7dc121 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=1LJs0ifWi0Os6_OiI_cA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA5MyBTYWx0ZWRfX5te4MW/vtdt7
 X1vO7eJSs7mxv8Zjxdt3ySG0rj2b0QVrco55qT33iMwV3WtYsOukyMZaPpEavRtF+qTv1opzael
 2iMzgbgZDT9mkeq1SMhN+K0h7oRnqrqb9Sp9neMpz9z4N/i2IRLcII7qL8jyOX5qq2vxazroeS1
 Kww846obgJzyN8ez+OhvtHdzXTLtBn00iNdP8VyPuxOzI3/v0rNPuveyqasBnEDXYNI+2I2lXiw
 Sj+op590Y6o39vM7FC+e3XKALlp9Mznpop1XUOS6QxhURyRoGJxa5tiWrwiyJuhMdsJ8OtG72hC
 QO6LDPuBohSa+O8ltIrz8O01eH7jYVrdVyIuX6bi31oNca+8EGq8X+eEkdFaCxRGAPzDqNt2Avn
 UVFaUjQQ3QCSHzdg5VVcsHNk+e9YmXEdpzoFQ+LPlN8r+tpkt6dWhqjaYhP6IdGj2q3SmcMyOXz
 ZSm4uaU3Kgi6X78lfZg==
X-Proofpoint-ORIG-GUID: wBWqBkvrVpMVfU-YlZbeVp4pflWpADBd
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA5MyBTYWx0ZWRfX/xa3RM07NB3a
 VrWDCCnsl+cYWs4Rj4/FLexNVQUAccv4i2wTwy2+AkTG6bUNnnBVs/rkVhts4w/5ypnlqtQATaG
 6MHcDn2YgqHni8ipSWXRSg0mfArLSJc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130093

Am 12.08.26 um 22:02 schrieb Anthony Krowiak:
> During review of patches by the Sashiko AI, several pre-existing bugs were
> discovered. This 9-patch series fixes those bugs.
> 
> Change log v4 => v5:
> ~~~~~~~~~~~~~~~~~~~
> Patch 8/9: Fix NULL deref in status_show() during queue probe
> * Check if q = dev_get_drvdata(&apdev->device) actually returns a pointer
>    to a vfio_ap_queue object. If not, the return AP_QUEUE_UNASSIGNED
> 
> Anthony Krowiak (9):
>    s390/vfio-ap: Fix stale do_remove flag across iterations in
>      vfio_ap_mdev_cfg_remove
>    s390/vfio-ap: Fix dereference matrix_mdev->kvm without checking for
>      NULL
>    s390/vfio-ap: Fix missing lock required to access list of
>      ap_matrix_mdev objects
>    s390/vfio-ap: Fix required lock not held during update of
>      ap_matrix_mdev object
>    s390/vfio-ap: Fix control domain removal in vfio_ap_mdev_cfg_remove
>    s390/vfio-ap: fix potential use of uninitialized apm_filtered bitmap
>    s390/vfio-ap: Fix hot-unplug skipped when last AP adapter or domain
>      removed
>    s390/vfio-ap: Fix NULL deref in status_show() during queue probe
>    s390/vfio-ap: Fix memory leak when queue removed from host AP config
> 
>   drivers/s390/crypto/vfio_ap_ops.c | 163 +++++++++++++++++++++++-------
>   1 file changed, 126 insertions(+), 37 deletions(-)
> 

So I picked 1-8. Lets do 9 later with the other open issues.
