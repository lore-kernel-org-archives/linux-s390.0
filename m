Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06F73BCD0A;
	Tue, 11 Aug 2026 15:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786463926; cv=none; b=Re0qVRHVtrqnU0jHDMKAncVQl+F0GHaFPdwawndzEIVyc89NR8n7AlHMoKaKjQpGwDkjBs4uWkV/flxnTI7rNcmNVAT1/OCjzTSv+jf5pUBq2JhP+fd8mC1Q76HdxWIyGTm0JV4mkCSsjuj575Ft48fSs/EqgcrW3Jtv8n1CEbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786463926; c=relaxed/simple;
	bh=Ttj0jY3Uf58f08XbGnXTCwAv7Mt+giB8XRIvmwK8unw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O/UVFGBAIBJevGs7plVCdjuMc6aRqQeQeUKTH20O5KUoMW60MIX3N97xxmcbR2pp70Lsllo+v2gmqapwyVLMORSMUbeXrF+w8xoAFMLQbwcmkeTDbafMItLRcOrqrBJKyzniIGIdsTPXcPD8Tc1Va5sjq56swoR1IRHzdkcM6Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BR/p4lr0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BR/p4lr0"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDXD8h570053;
	Tue, 11 Aug 2026 15:58:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DyHbJ9
	ozpn4yOzqpvP1pJhuBcLA4f3wvUR463sU3M/A=; b=BR/p4lr0cKB8qu7QYeSTVd
	Gm2iJBYQbxffRRCbVme3vY/vdErpToB172gm8EXMwkuij8TO+3HIUtYKp+it86RO
	bn2+qTHJaHM569DK0atQWKyd7pO65MJpDk5f3rB8iTtzHbJywu0eIvTfF6mYdU90
	O1CtoQwh5P9LsCzgxCKkEvzwf914g2gt/vyVB2P2hzhkYlrUBYuBrNgiDMX1X2Hq
	0QOP2jmS4l2KH5jsHQ+HNd1aXdmtEigQadeS+nb1B/Ci9nyTCgxvIxOiN2bX3ssr
	rc9c4wu7iA/UbozcSnvED61966i1g0ZAbjWkJ+bDzaguFgTVFERqrxtjD3hVRHgg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnw54x6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 15:58:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BFuGPa031754;
	Tue, 11 Aug 2026 15:58:38 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0g9g2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 15:58:38 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BFwboh28967474
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 15:58:37 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DBAF58045;
	Tue, 11 Aug 2026 15:58:37 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6EB8758052;
	Tue, 11 Aug 2026 15:58:35 +0000 (GMT)
Received: from [9.61.146.44] (unknown [9.61.146.44])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 15:58:35 +0000 (GMT)
Message-ID: <4ca672ce-da47-497c-aed1-9500b7e89798@linux.ibm.com>
Date: Tue, 11 Aug 2026 11:58:34 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] s390/vfio-ap: Fix use of wrong lock in mdev probe
 function
To: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        stable@vger.kernel.org
References: <20260810192257.1208410-1-akrowiak@linux.ibm.com>
 <20260810192257.1208410-4-akrowiak@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260810192257.1208410-4-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7b46af cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pLumvq3Dd9B4WcvoUHIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: KS8t8TY8qZ-XkSocCmSNOgptT3GcbYch
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEzMCBTYWx0ZWRfX9tAlKpG5/rCU
 zH9spRr8AWr+A6qpetymBFq+lE5cp30l8W6is3Kl+cod1wwNfqeOcTdafj9kyuxBRdeQYr402Jb
 eiYIRkCZddDZrRCJmGHhrah+TGIruGrOdq736/FjgmV637Eh+xBWum7rH8ecyl/CZm4uZOgyzwZ
 cAaNC+DEo+6bPBGB47c3dnD4aayYsYpupsDXdEL8+oyLJs5j6kLIs0lfJSA+14Clum/vzkc+L+G
 3l5nhYnzLiNVSa9TNb10ZhzKMbY+dq5hZ6ehoB4+/ME64dAM74YbTVjDl1Lm6FRGdbnUWsxkx1B
 xtmxKKqdhgCUGTWRMr/qf6R/k1KULblKxBnTx+tLQR+KV/Hlav+ff1dq/2VrcX2KvUbuiFxiK9A
 W164ZqGMn1R8o7Xy6MSuiNPiuCHVM8Ku0WvqIzPGeAGQMF3HDA/T19GjGtPus0r8zxMBtsaXH5K
 BitsxW73n0m1sOCq1Uw==
X-Proofpoint-ORIG-GUID: KS8t8TY8qZ-XkSocCmSNOgptT3GcbYch
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEzMCBTYWx0ZWRfX4NOljLHZRDkr
 g79bJDsFNvHPlN0ldagnc+BVwk8nRgUKcQM+XegV3vlDBjYp9rxwF2kaxe5kl7jRJqHPvHxpYkA
 inp8yROnVp9GV2Gv+0BJ5ssfQYS56A8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110130

On 8/10/26 3:22 PM, Anthony Krowiak wrote:
> The vfio_ap_mdev_probe function uses the matrix_dev->mdevs_lock
> mutex to guard the add of a newly created ap_matrix_mdev object to the
> matrix_dev->mdev_list. This mutex does not protect against traversal
> of the list; its purpose is to guard against concurrent access to fields
> contained in an ap_matrix_mdev object. This could lead to kernel memory
> corruption or use-after-free if another mdev is created concurrently.
> 
> The adding of an ap_matrix_mdev object to matrix_dev->mdev_list
> is now guarded by the matrix_dev->guests_lock which is the correct
> way to protect against concurrent mdev_list access.
> 
> See the vfio-ap-locking.rst in the linux kernel tree.
> 
> Fixes: 2c1ee8983aa3 ("s390/vfio-ap: prepare for dynamic update of guest's APCB on queue probe/remove")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index e382e5a1cb99..a472de00bc14 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -803,9 +803,9 @@ static int vfio_ap_mdev_probe(struct mdev_device *mdev)
>  	matrix_mdev->req_trigger = NULL;
>  	matrix_mdev->cfg_chg_trigger = NULL;
>  	dev_set_drvdata(&mdev->dev, matrix_mdev);
> -	mutex_lock(&matrix_dev->mdevs_lock);
> +	mutex_lock(&matrix_dev->guests_lock);

Sashiko reports that this patch introduces a regression, which seems valid.

AFAICT you resolve this regression with patch 7 of this series.

For the sake of bisect, can you look at whether squashing these 2
patches together would work so that we don't have an interim regression?


