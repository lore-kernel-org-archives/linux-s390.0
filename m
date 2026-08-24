Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3811346D2D8;
	Mon, 24 Aug 2026 17:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787591082; cv=none; b=Kccy35juVdpwcPiB8NcxJzqU2h6V68q8r8kpvx5HQENZcdxly6rww1ZqrZfrL9ARBOtveLwctiUChwSXfN1jW4zmT1NrjG1TM/pO522cbjoyhCxJQk97B8h/QPGBYu2Tx7T3L6do1vKGmHes/e60XIjHIbW9KsFFVYvKMZCssBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787591082; c=relaxed/simple;
	bh=MYPWi+oUD61xHWC/vxDrUsr4U/aSruy/61AwAJUv3jk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DoScm+yQSto6GTsQbTNdc+2Fu7kMQbOxRxKubJkZB/G8MCTFdS6VhkWOUnFyMkT2dpYzQ0tjVSYWj0c++ZZFNYP4Y+E+aWLh26DeGxNV8s2TFtXsN286S/ntT9IYknZeKnqeVIIq9pMV408o3v4DR8wDg1PO/qhfjwOwixdm2QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QQBiYI5C; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QQBiYI5C"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OG1cET501125;
	Mon, 24 Aug 2026 17:04:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pMgRQ2
	KT3e28lavbEpPM0IUTalZsbJ0WC/4lznlPKQ8=; b=QQBiYI5C8dQ9dBNeemySdg
	EX/kg0SBvNatmsPbD5wk07RL7WNQVvCFnjnbtmWhDZ0M63rYtTUpJqe/273JQORr
	/vAkIsG3IMQZW6nJTctHiFUggpOUjNFJTCbiw956Fb1SfVnnM1pC7yszhLbuXerq
	+V8oIV6r7Gr4M4fYxK+K9stdfxSQrMLVMS7z9TysRTlp7tTBjv1N3pdd3wKl0AFs
	yVbiGMFnnXoiLTXIrgOLq+6bkIqIhphsZ8kQyrjVsZoAD1RL9szrzk+5DU2nltXy
	93ODJSHwuEe2M5tkmxN8rocAagrdLNgx/WuejwDsBOpyR3A6khWEeykpp0+8PR3g
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqjuwy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 17:04:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OGuJ3x008995;
	Mon, 24 Aug 2026 17:04:34 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfvyegp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 17:04:34 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OH4Wri19137270
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 17:04:33 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9070358052;
	Mon, 24 Aug 2026 17:04:32 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D81F58062;
	Mon, 24 Aug 2026 17:04:31 +0000 (GMT)
Received: from [9.61.21.147] (unknown [9.61.21.147])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 17:04:31 +0000 (GMT)
Message-ID: <07bdd3bb-0f9e-4288-9fd0-52ea9edf4b0d@linux.ibm.com>
Date: Mon, 24 Aug 2026 13:04:31 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] s390/vfio-ap: Fix unbounded loop in apq_reset_check()
To: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        stable@vger.kernel.org
References: <20260824135850.503728-1-akrowiak@linux.ibm.com>
 <20260824135850.503728-4-akrowiak@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260824135850.503728-4-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SpqG-v1gVbVvUqkjSi5DOchsbuSqVNvE
X-Proofpoint-ORIG-GUID: SpqG-v1gVbVvUqkjSi5DOchsbuSqVNvE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE0MyBTYWx0ZWRfX3IXTBWnpk/pm
 iSfvLdoQiebpR2qhtozjhqPHSyw7IXp5bIposy4fSf7icoUhPEE99LafLgGitK2VHZLkKGzKMX5
 h0MTKRDPfaNC3ZwaZT1ALK5aVvABDRh20YbO99f7zTVJizupSJHgjfRSXUhigvat/Vtsg30P0al
 IW60zlZ8gmAwzLUa/vNt7rfdE644Lf7BUY2x36KJiciZ4MdiKFcMr0CJ6LQrvuNx/ttm/bQ1SDq
 gMNDP9R+B0C7n8OTFvHArNzYLgBEpzCL82cvU1/OXuKBHem23eJW6Yy1cRUnT/54/QjVoQ5l22c
 lbYIXdIlrY1lFBvekJODxQtFwsSLK+2OaU9/aH6qzPZ5Yvfsbql0znEM9GEJssy1aIqaba3XO9i
 r2Zd8Gq4qEtlmA90XWJUMk0ApWO05zlpMs1LTs9jAoOAnuuwS1XWtUWE5WWZJRHviPMyMOPvFrG
 HUIfFvckRAeP2u5pmSg==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8c79a3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=XNpHhzfJDE1w53E7Ht0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDE0MyBTYWx0ZWRfX9a/6uCxQeIei
 gSv0UcBJSHnklL4rTRp4sXbzNmVH2OYHysuPS+mi2MCjuaFFpwigX+/JnqRseDqjoJ4AkwN2tjk
 1n3Yf3vNSUrtJwHU36/7/mNFgj2k5Rc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_05,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240143

On 8/24/26 9:58 AM, Anthony Krowiak wrote:
> The apq_reset_check() worker polls ap_tapq() in a while(true) loop
> waiting for a queue reset to complete. When ap_tapq() returns
> AP_RESPONSE_BUSY or AP_RESPONSE_RESET_IN_PROGRESS,
> apq_status_check() returns -EBUSY and the loop continues after
> sleeping AP_RESET_INTERVAL (20ms). There is no upper bound on how
> many times the loop iterates, so if the hardware continuously
> returns a busy response the worker runs indefinitely.
> 
> This is particularly harmful because several callers of
> vfio_ap_mdev_reset_queues() and vfio_ap_mdev_reset_qlist() call
> flush_work() on each queue's reset_work while holding one or more
> of the global matrix_dev locks (guests_lock, mdevs_lock) or the
> KVM lock. An indefinitely spinning worker permanently blocks all
> of those locks, hanging mdev removal, KVM guest teardown, and the
> VFIO_DEVICE_RESET ioctl path.
> 
> Fix this by introducing AP_RESET_TIMEOUT (2000ms) and breaking out

s/AP_RESET_TIMEOUT/AP_RESET_MAX_WAIT/ ?

> of the poll loop when elapsed time reaches that threshold. On
> timeout the final busy status is written back to q->reset_status
> so that callers inspecting reset_status.response_code after
> flush_work() see a non-zero value and can return an appropriate
> error. vfio_ap_free_aqic_resources() is called before returning
> to release any KVM ISC registration and pinned NIB page,
> consistent with all other early-exit paths in the function.
> 
> Fixes: dd174833e44e ("s390/vfio-ap: remove upper limit on wait for queue reset to complete")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 6e4569d6b975..c7eebbd0ed40 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -31,6 +31,7 @@
>  #define AP_QUEUE_IN_USE "in use"
>  
>  #define AP_RESET_INTERVAL		20	/* Reset sleep interval (20ms)		*/
> +#define AP_RESET_MAX_WAIT		2000	/* Maximum wait for reset (2000ms)	*/
>  
>  static int vfio_ap_mdev_reset_queues(struct ap_matrix_mdev *matrix_mdev);
>  static int vfio_ap_mdev_reset_qlist(struct list_head *qlist);
> @@ -1973,6 +1974,12 @@ static void apq_reset_check(struct work_struct *reset_work)
>  					      status.response_code,
>  					      status.queue_empty,
>  					      status.irq_enabled);
> +			if (elapsed >= AP_RESET_MAX_WAIT) {
> +				/* Timed out waiting for reset to complete */
> +				memcpy(&q->reset_status, &status, sizeof(status));
> +				vfio_ap_free_aqic_resources(q);
> +				return;

Sashiko points out a concern here and I tend to agree; if this timer
elapses you are effectively freeing resources that could still be in-use.

This seems to go back to dd174833e44e 's390/vfio-ap: remove upper limit
on wait for queue reset to complete' where it was decided to hang
forever vs leak resources -- e.g. the hang seems intentional?

If we don't have a way of forcing firmware to give up the resources I
think we are stuck either waiting indefinitely or quarantining (leaking)
the resources consciously.  And documenting the rationale in a comment
block.

> +			}
>  		} else {
>  			if (q->reset_status.response_code == AP_RESPONSE_RESET_IN_PROGRESS ||
>  			    q->reset_status.response_code == AP_RESPONSE_BUSY ||

