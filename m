Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C03452D2C5;
	Tue,  8 Sep 2026 17:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788886853; cv=none; b=oNOq7p+Kt7wHWXPqWCPd7NyJAtYgb18kCfqTnjDapycTSRl2hUElelrhS2lTpmxy9PV7XkSSJm78k2UdvgFcPpyg/GfK++4DsYvFYP61XYZmBWYGVoN1LE4f/WYgPfW0umorWziIfeW8sNI8Wm2xnOCjK//jC+IECTm/jiuaeyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788886853; c=relaxed/simple;
	bh=SYDbhDxD9+QmUgmJvTw2oQAv3h1h5ohUDE4/BKv7YsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YftS3b3PpDmKsf5gloG0In1Gh/39OnZ16fZZd7iMvJIcpvjy85Ge8R6IrhWU7vDMxh8VTSX7Clk0Y7++WIGt1jQmQ44PdtvcVxKlun9vy0uiJGcNM8oVXUVpolzBAFopZ5Y583CCLp4Z1F8UuhYli6HKDGQmrsiJHE2It4Dsvgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DyTmhpKO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DyTmhpKO"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688F1r1t080873;
	Tue, 8 Sep 2026 17:00:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oVKDX1
	95Ywf+Gj0Yat/qZZsr6npcwhcPLqiAuSW2w4c=; b=DyTmhpKOnRJUH+RB4EWJIl
	5UxAOlYHwBDFthEDlEi7Vxt7EVMz8XCyGPZHC3+Yww/2QqhgAuOtA/WWHOfzYhRN
	4bXH3Ax4bvgRtfCwnaa0cJM5lVTWDw0IAvne/LMfcI/QlU5lwovVw/xq6Ud5h17u
	EQvH1vbFC6cLbDfiSeSVcqY7N9unNb0sWaNy+Mshgajr6q75SCzo2BrOFVK+ubR0
	RGa2QUbwhrMiCqAYLU4o5epW47unMSJLRqhS3o1N5DAluONoWSjAon9mkNcMZG0f
	5LwVHEjlb2dUuDaeZhtXzo/I2oT6HfmbUOii44tUzjaFZ7tWiaWjWgILYsYzrIfA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbjrrawy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 17:00:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 688GuHWM023096;
	Tue, 8 Sep 2026 17:00:49 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ggymgd25j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 17:00:49 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 688H0mNq24707640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Sep 2026 17:00:49 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F86B5805B;
	Tue,  8 Sep 2026 17:00:48 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57C7F58059;
	Tue,  8 Sep 2026 17:00:47 +0000 (GMT)
Received: from [9.111.168.68] (unknown [9.111.168.68])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  8 Sep 2026 17:00:47 +0000 (GMT)
Message-ID: <b36cfca5-bb81-4506-9c41-ff36376ebe6d@linux.ibm.com>
Date: Tue, 8 Sep 2026 19:00:43 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] s390/debug: Fix race between debug area resize and
 event logging
To: sashiko-reviews@lists.linux.dev
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>
References: <20260903130733.709001-1-zaslonko@linux.ibm.com>
 <20260903130733.709001-4-zaslonko@linux.ibm.com>
 <20260903132123.12F271F00A3F@smtp.kernel.org>
Content-Language: en-US
From: Mikhail Zaslonko <zaslonko@linux.ibm.com>
In-Reply-To: <20260903132123.12F271F00A3F@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E7T9Y6dl c=1 sm=1 tr=0 ts=6aa03f42 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=zpDF0JaS7d85di1fyEoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE3OCBTYWx0ZWRfX0dCXsiBlIJm6
 ePPhI/wamAO8KXN/cDBod3Wy371exR7TaU+42jOe4TvUlP4en7yv6wihYUg9J0OMC6IrFCA7QJw
 glG8hZkzvgPUfZ1n1wiU9ZBuoggVD6I=
X-Proofpoint-ORIG-GUID: 5yMz0iwnI-vLyK_6cmrx8mUo0ccohOUH
X-Proofpoint-GUID: 5yMz0iwnI-vLyK_6cmrx8mUo0ccohOUH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE3OCBTYWx0ZWRfXyEWOZWhCIfzn
 Ablp7PtwG24AMIJrASgD8Zqpv3Htrm3kyazzAx+pH6ejKLuQtmdMLW7RUDIw/ly/v9BM/yTrkmE
 HOuLPj9VpJtqPjnielb3+gdvB9kznXDaK6Nr22hagIqKa5SEjo6pGYsUTPnJw9CNyIjdU7iomlO
 WDYGl9VgvJKhE4apFqLQKhIw4gBbp7xtC33mVKH3QkgEmIFp8y6PE6MQqqOWOmTw7KyR5WX9bCU
 fi3szz03A8BYCn/6MqMBmvNcHCOnviwOpvyoAEHBkA8aMXQlMwK9qy1NHHqbqLuR0SWdUmY6D8O
 AB2O2DgINcn6RA8CD+ZLimK6UGOfvnHhUfyINr5HIIiucdMA/IVxpS9ayFKDYhmbwtLm8nXosEu
 Owd4BGzVZJkoGq8E/oogyhZ1vnwf/vOu6Rv9NQ1GEuh7UMJBRzIKC2D5lCdYIoQ5svuO90cVPT6
 zfQrTl5PNvH/C3EdZrA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080178



On 03-Sep-26 15:21, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Preexisting NULL pointer dereference in debug_info_copy() if debug_register_static() fails to allocate memory.
> --
> 

> 
> [Severity: High]
> This isn't a bug introduced by this patch, but I noticed a potential NULL
> pointer dereference in debug_info_copy() if debug_register_static() fails
> to allocate memory.
> 
> In arch/s390/kernel/debug.c:debug_register_static(), if the allocation fails:
> 
> 	if (!copy) {
> 		pr_err("Registering debug feature %s failed\n", id->name);
> 
> 		/* Clear pointers to prevent tracing into released initdata. */
> 		raw_spin_lock_irqsave(&id->lock, flags);
> 		id->areas = NULL;
> 		id->active_pages = NULL;
> 		id->active_entries = NULL;
> 		raw_spin_unlock_irqrestore(&id->lock, flags);
> 
> 		return;
> 	}
> 
> This sets id->areas to NULL but leaves id->pages_per_area and id->nr_areas
> with their original EARLY_PAGES and EARLY_AREAS values.
> 
> Later, if debug_info_copy() is called when a user accesses the exposed
> debugfs file:
> 
> 	for (i = 0; i < in->nr_areas; i++) {
> 		for (j = 0; j < in->pages_per_area; j++)
> 			memcpy(rc->areas[i][j], in->areas[i][j], PAGE_SIZE);
> 
> Will this cause a NULL pointer dereference when accessing in->areas[i][j]
> since in->areas is NULL but the loop still executes based on in->nr_areas?
> Should we reset id->pages_per_area and id->nr_areas to 0 on the error path
> in debug_register_static(), or add a NULL check in debug_info_copy()?
> 

The scenario above is unrealistic since upon debug_register_static() failure,
the _debug_register(id) is not called. So no debugfs entry exists for this id
on the failure path and a user can't access it and initiate debug_info_copy().
Thus, severity is arguably High.

Nevertheless, it's a fair finding. Everywhere in the debug feature code a NULL
areas pointer implies zero bounds: debug_info_alloc() sets areas to NULL when
pages_per_area is 0, and debug_areas_swap() swaps areas, nr_areas and
pages_per_area together. The error path of debug_register_static() is the only
exception. That's worth fixing even though nothing can currently observe it.

I will send a separate small patch.




