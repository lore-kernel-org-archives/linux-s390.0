Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B721E30171C;
	Mon,  3 Nov 2025 11:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762168768; cv=none; b=bb3vDnnBfIKMaHPOyvDW56ooqMuHzyzCyBqRNVpWRPs/KN5OMXdFI3U1QfVAPsi2b9IU4VrlZ2RORpZwk8RxC8LtpeiHk1wLR9JkCQjYgaTRFAETLFfQ2gC73rfsSVYmi+SDwbTPpuVKlUKoKQdcJ4sIX5aJZM3P/3Med3LO2+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762168768; c=relaxed/simple;
	bh=yukxgMAsSBJ5Nf0ZrBGRjjTWREkkghe10V+XHbWxlL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfLUsBc/RIUFjP7WroR9xOKmUF95O90uhepcS1EzXaTK20zO7ye9sefD5XRc0zrigvlek0QuCI53a27ldxfcmK/0NvyhQ7F+SXg61hB9wUmJF3AiVTNNBbQVb+HO5SpkqYF4nfWidkWZMJzk9JNiV9f3Cudu85MMhsGDCj0Erb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gWmjxYjN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gWmjxYjN"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A2LRFH5020916;
	Mon, 3 Nov 2025 11:19:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=lwPkE0AArYlkJRtiXQlbKSo3l6vWp3
	//7R6WjErqhLM=; b=gWmjxYjNrELCHnyDBdHl8ooyl2gsuAk0lKqQP7abBkO9fs
	snMmM3+gcMQwRy3AdrTNGnXjWfOjofULupQM7hoHDEtMGPfsCbjJTC3bqUPACokD
	wyU+g2D+sfdkxMce+tLU7Ay7cxNKSmkw5VImEGIx9jteh3wp4Pd892WcVC0esV/o
	Ll3AR+mwy4qT0xhkz3TSj8E0yrvDnQGIHCfBigJXVWRX6AvhYYPHeXVgwyqQ3csE
	q4EW727EwZBA8WOLWukhleXZLoWp599rs7m0v3WPKUmMkKBE5DKVl5Paak4bieK2
	goYT0fT89jfzowAOFAogB3ZxJkR6vE2ymTxhQV8g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59q8p9b8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 11:19:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3AGPiY025556;
	Mon, 3 Nov 2025 11:19:21 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a5vhsdfxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 11:19:21 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A3BJHnM11600152
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Nov 2025 11:19:17 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B6742004B;
	Mon,  3 Nov 2025 11:19:17 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0CBB20049;
	Mon,  3 Nov 2025 11:19:16 +0000 (GMT)
Received: from osiris (unknown [9.111.61.175])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  3 Nov 2025 11:19:16 +0000 (GMT)
Date: Mon, 3 Nov 2025 12:19:15 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Duoming Zhou <duoming@zju.edu.cn>, Jan Hoeppner <hoeppner@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, mingo@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH] s390/tape: fix use-after-free bugs caused by tape_dnr
 delayed work
Message-ID: <20251103111915.18191A14-hca@linux.ibm.com>
References: <20251103060544.22720-1-duoming@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103060544.22720-1-duoming@zju.edu.cn>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=StmdKfO0 c=1 sm=1 tr=0 ts=69088fba cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pBTJcwekMGGDtO02zGIA:9 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 3byK_aW4tFw9iyp-MNLo4HpiuD2-nlTX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAxOCBTYWx0ZWRfX0Nqianh8vm6P
 JvxIhmJeOVTzihQvYUcF56bO5l29G2qtZ31gzHExTor5jpDzgois9J11zAgW7FasMhxMAOe589A
 v3cOdX+ULeDkKWfoJVPCfghtgRvEnaUeY6rjVc97kndVsYWaQAo1WpxOazMjFNIAq9A4+q5znoY
 T1eOsGhADtzPgKED/wrO3Z9A6cOTEw4AaaU4lJGZo9j41ywYUTuEdKML2LVTkz+EowB/SZFdsp7
 hDe99SS4k+9okuYCzZmrg5kQuw1Jg2L6DuH9it35w9vatTpg14xtfXD+Uzmt3aj6gK0+MFlKDtE
 7wcgkNaMpqJfrZbDyiGVt0qeDnZv7xT72rUvKc0p+aweaxJKhvVkJ6QNiz3MyGOEDilP02JPNyT
 LMmskc6q60tewCJ1iylwKgEuZ4cCEg==
X-Proofpoint-GUID: 3byK_aW4tFw9iyp-MNLo4HpiuD2-nlTX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 clxscore=1011 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010018

[full quote below - adding Jan]

On Mon, Nov 03, 2025 at 02:05:44PM +0800, Duoming Zhou wrote:
> The delayed work tape_dnr is initialized in tape_alloc_device(), which
> is called from tape_generic_probe(), and is scheduled in the following
> scenarios:
> 
> 1. Starting an I/O operation fails with -EBUSY in __tape_start_io().
> 2. Canceling an I/O operation fails with -EBUSY in __tape_cancel_io().
> 3. A deferred error condition is detected in __tape_do_irq().
> 
> When the tape device is detached via tape_generic_remove(), the
> tape_device structure might be deallocated after the final call to
> tape_put_device(). However, if the delayed work tape_dnr is still
> pending or executing at the time of detachment, it could lead to
> use-after-free bugs when the work function tape_delayed_next_request()
> accesses the already freed tape_device memory.
> 
> The race condition can occur as follows:
> 
> CPU 0(detach thread)      | CPU 1 (delayed work)
> tape_generic_remove()     |
>   tape_put_device(device) | tape_delayed_next_request
>                           |   device = container_of(...) // USE
>                           |   device-> // USE
> 
> Add disable_delayed_work_sync() in tape_generic_remove() to guarantee
> proper cancellation of the delayed work item before tape_device is
> deallocated.
> 
> This bug is identified by static analysis.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> ---
>  drivers/s390/char/tape_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/s390/char/tape_core.c b/drivers/s390/char/tape_core.c
> index 6ec812280221..722dc4737a87 100644
> --- a/drivers/s390/char/tape_core.c
> +++ b/drivers/s390/char/tape_core.c
> @@ -625,6 +625,7 @@ tape_generic_remove(struct ccw_device *cdev)
>  	}
>  	DBF_LH(3, "(%08x): tape_generic_remove(%p)\n", device->cdev_id, cdev);
>  
> +	disable_delayed_work_sync(&device->tape_dnr);
>  	spin_lock_irq(get_ccwdev_lock(device->cdev));
>  	switch (device->tape_state) {
>  		case TS_INIT:

Jan, could you please have a look at this?
