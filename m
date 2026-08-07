Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7017842D77E
	for <linux-s390@vger.kernel.org>; Fri,  7 Aug 2026 10:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786100136; cv=none; b=DFC9Y/XlAqOA2dTzh/xLs8Jqr5jZW5QA9MDgE+mF03fsxqAKXRiyz1SfqysH03Dh8vk9+NyjloRi8GWb7vBQL7FqAWfrrNEOw2lWNlJgLNKHA4Jwfl7VHM5gaXzXp3jmOrYAY+JLoEIY8SFzt9WeHah2QRzSdrxH3/z2moUPPHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786100136; c=relaxed/simple;
	bh=jGvaZRIw1vneQ5c5TmC4FKCPyNyO6W0kz26ZJnWHWno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PAz4tVaxjuty2ybboQMmNGHA3rlNqNSkTtZ427Z9KjJdRvpcLv5y8BNY+6nnA/e/Y+TI2iSQYAxr8hXYx5qOJwJwymxcCeFEKIvwnNpX3R/468HhI675dP849WP5A1hXpE5ZbJoOkWFBE9YhScgbPPRXDQq4QWWzBQAGjbrEn6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T4ZgKs2d; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T4ZgKs2d"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770Hdmu4133707
	for <linux-s390@vger.kernel.org>; Fri, 7 Aug 2026 10:55:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RS1nAP
	i5MOXIGu0ZmOLsDkjxKc7PQfjaAHAaquljOKw=; b=T4ZgKs2d8Fv4R9mb6FQn17
	HLSpjzZqeypLjNjCWVcZh9aFPxhQkZASAzPWkRxHgOM79UuKdDwFaB9ax+z9fgl4
	vRwaOs71XsZmgje+/8bnya8WhBEK18cXSt5+ZsOA3DMJF/umhcrsCt9L7mQW+yPy
	D1GXItlSTniMgnOn3KvLHrn2AgyP7FONwvWsFQAAXqN6Vay9LqtWS8W+j/rBVmbD
	xq4nIfArSuo3XBy5lttjKbRVuTVNY+qqLugne1mSVzFQL/RzLz90ruzWPfbgQ7BY
	ayC3WEky9N6i3wotwDcIqAKYlJTWeJVp9ip1iW0tLZZE8L9gwImX//yZDqnz18jw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy043gmt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 07 Aug 2026 10:55:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677AfGfL015385
	for <linux-s390@vger.kernel.org>; Fri, 7 Aug 2026 10:55:33 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugwff50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 07 Aug 2026 10:55:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677AtTd020513302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 10:55:29 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22A072004B;
	Fri,  7 Aug 2026 10:55:29 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9D8920040;
	Fri,  7 Aug 2026 10:55:28 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 10:55:28 +0000 (GMT)
Message-ID: <ff87bfee-148f-418f-897c-6fa9b96aff5f@linux.ibm.com>
Date: Fri, 7 Aug 2026 12:55:28 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] s390/vfio_ccw: Add __must_hold() attribute to
 vfio_ccw_sch_quiesce()
To: Heiko Carstens <hca@linux.ibm.com>, Janosch Frank
 <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
References: <20260806153849.2622576-1-hca@linux.ibm.com>
 <20260806153849.2622576-2-hca@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260806153849.2622576-2-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA4MyBTYWx0ZWRfX/d2rXAnCCwqF
 e9MsjKtBetD9Cv/9XG3jRrLurJa2Bxw79weWiUfMff/mUphQ0tGl8j37gnMVhdALdPXAz+UH3xD
 iRg/TLaQalRRsJTr+gE72euvR2wBsjLHwzv6XO8XF25OJhdE/hK6+/nxZp/h4HjIeiHLQDYGLQY
 hBBcbtvM5B+fLjLfRaPsz+fE2l405XVubagz1NjgPlrSaAGyr2uvFZdoZtFqnQ0DEsEY/KaYPw3
 OdQSgLjy7km72qtwFTlJ5c+4Uyaazrdy8i7SFljBDzvol1wWe3rCv40UmsRxE9CgJEMkojsXgkB
 VnzV3I7W+GozvMU0h1UW/T9vi/QYAAfI3codXzT4TljhaVkM4aP8+EywMsMjPDiydcpXP8JOUSs
 edQYxXq9Gfq5Qee5hzgw52cbCVQX4NGRK4mxi7zC2vKQ2/OEf0fqdxnh+aYuzW/zD3YczgbfAHs
 oz2ijVbs+aSA2oMD1nQ==
X-Proofpoint-ORIG-GUID: baXUjqYzoJBgsi99Mq6n48chYiBsuNHc
X-Proofpoint-GUID: baXUjqYzoJBgsi99Mq6n48chYiBsuNHc
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA4MyBTYWx0ZWRfX0TJGJOet8gZn
 7+DNpmRMUOU5tBDyZPpOM4zTu/J+IzXAQe9k6jwngbOTR7NI4oJzJZWczvnc9UswLKUVO/xivC6
 W0/qPCJPzX4UfSFsVGrE15rVoZ8obMc=
X-Authority-Analysis: v=2.4 cv=WLpPmHsR c=1 sm=1 tr=0 ts=6a75b9a6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=JluCVat7wJMzAMw6YL4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070083



Am 06.08.26 um 17:38 schrieb Heiko Carstens:
> Add __must_hold() attribute to vfio_ccw_sch_quiesce() in order to let
> clang's context analysis know that sch->lock must be held on function
> entry. This can also be easily verified when inspecting the function.
> 
> Without this annotation this leads to a valid warning when context
> analysis is enabled:
> 
> drivers/s390/cio/vfio_ccw_drv.c:55:9: warning:
>    expecting spinlock 'sch->lock' to be held at start of each loop [-Wthread-safety-analysis]
>     55 |                 ret = cio_cancel_halt_clear(sch, &iretry);
>        |                       ^
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>

I assume this series should go via the s390 tree with the others?

> ---
>   drivers/s390/cio/vfio_ccw_drv.c     | 1 +
>   drivers/s390/cio/vfio_ccw_private.h | 3 ++-
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
> index 1a095085bc72..ed9ca77c5b23 100644
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> @@ -35,6 +35,7 @@ debug_info_t *vfio_ccw_debug_trace_id;
>    * Helpers
>    */
>   int vfio_ccw_sch_quiesce(struct subchannel *sch)
> +	__must_hold(&sch->lock);
>   {
>   	struct vfio_ccw_parent *parent = dev_get_drvdata(&sch->dev);
>   	struct vfio_ccw_private *private = dev_get_drvdata(&parent->dev);
> diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
> index 0501d4bbcdbd..8db29519dbfd 100644
> --- a/drivers/s390/cio/vfio_ccw_private.h
> +++ b/drivers/s390/cio/vfio_ccw_private.h
> @@ -127,7 +127,8 @@ struct vfio_ccw_private {
>   	struct work_struct	crw_work;
>   } __aligned(8);
>   
> -int vfio_ccw_sch_quiesce(struct subchannel *sch);
> +int vfio_ccw_sch_quiesce(struct subchannel *sch)
> +	__must_hold(&sch->lock);
>   void vfio_ccw_sch_io_todo(struct work_struct *work);
>   void vfio_ccw_crw_todo(struct work_struct *work);
>   

