Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE8E126BF7;
	Mon, 21 Jul 2025 07:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753083029; cv=none; b=HjbcVV0d8qPQjYxK6nZ5MS+gRIiQ50H1bdaNkys72s5jmvAqClxtF3eUy1qWeIaXEjpSMw7BLMTb612MA3ysmIBcRqfaLsbQzi1CBexcBa9dgkxFSXrhfDVma7ku5aDQONCWaL28cAB1N/DSMxZC4R7HLNSyxo+83lkkeK2GXoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753083029; c=relaxed/simple;
	bh=k77l9xXP68qxhTzw/OxMss+wmcpGLj2vPrIcvEW4Ozo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=piA22bOpk44+twwrXeSLeoF32Ty4XOpLtBp3C9kFW1RW2rOAbfGiJg6kfVu4CybSafRYQU16/c34IvksGaICWOQc2qZ0Mn3nsF3Z2MFmG19hODAgt+D18Ghpxwnvlb8FCVCrPbRQoidp80EY2FRpeHY6ooRC2Y4a1wa1EOlhBEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pi4F+Q+K; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pi4F+Q+K"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56L1rZwj030943;
	Mon, 21 Jul 2025 07:30:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=sXwypK2wofLaLIWqEGEwkCwUqotA0G
	XBM0MSXIpmbS8=; b=pi4F+Q+KWPhCOygJL/5lmPVTeT/ssFf1v41q8xQnx1iBiD
	wfhjlLlk7F7NDYxUw90e+LDLHTNdcWwd2Tg0uRyaN77RRHSogXdSJEOGnxEKBfvn
	EqMFD6DV3N6ZxqGfufk6nIL7r1bVkLzLfDgC+b1TmW/VfvIgmcWCC/IwBjgTRAAW
	uhwRsgMrJIPaz7ucqZf8VfuJbo948LdanXEyPdkSrvyMGiCTMRDqWj5FvI2HPvD2
	2pt77ZQ7mPxz+Z91P1pcv1HEiq35EbWYbBvaM4SUE7AVd+4USZJeR8DeatpKRPZc
	NMXIZ+5dKODk9L8EwhDyWJQDRd8366lhERfsRxYw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48069v7ac3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 07:30:20 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56L7SmNY020127;
	Mon, 21 Jul 2025 07:30:19 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48069v7abx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 07:30:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56L5T2hQ024975;
	Mon, 21 Jul 2025 07:30:18 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 480rd24rsv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 07:30:18 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56L7UBH537618016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Jul 2025 07:30:11 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 354022004E;
	Mon, 21 Jul 2025 07:30:11 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A88E2004B;
	Mon, 21 Jul 2025 07:30:10 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.87.132.117])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 21 Jul 2025 07:30:10 +0000 (GMT)
Date: Mon, 21 Jul 2025 09:30:08 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sebastian Ott <sebott@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aliaksei Makarau <Aliaksei.Makarau@ibm.com>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>
Subject: Re: [PATCH 1/1] s390/ism: fix concurrency management in ism_cmd()
Message-ID: <6b09d374-528a-4a6d-a6c6-2be840e8a52b-agordeev@linux.ibm.com>
References: <20250720211110.1962169-1-pasic@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720211110.1962169-1-pasic@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3GmzfO-BSTdSXuFDegVhwVwXfqB8OFMu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDA2MSBTYWx0ZWRfXyCeMuDv8ZDrU
 uM8OeEmyTQ2bQx6eO8DI9PQQZ4l5f40FazlwojWdlwS8Ow7AA9pQk+mp5quELutL2Qh48pOO0xQ
 vAlBw/rEKIsqAdiSyjwgyN0Npur2OFfgWQFKh0ZzmMVTImJZ7nJnvfoZ1v3Dsf21pPJ9+IT/C0+
 uKyn16eWY19BIOOLIG7NnyiHuEvo/zkNrtd4fEzPspu4xUACa5XO0cWVthuQHnAWY600whUn0Yb
 tXXOkZBlviF0zFKHaji1r+/dLo0j4LgZ37mqgej2A8dk6QY4NVMI6lrTF6ObIbX3jtj9cLSGJXy
 iegUpJI9Cq7Z+i9OMuwwusipk9HBm7+ZNoz4jpOyf67Grm6BLnVhRIcfe4qbI94ww8RLcmRrrVd
 dzVPlKsfVHDrsVdOpfhjaIfkKtaqfTR1rLaTyfJ8t8rvYbrYr7l1pqZ57eFPKggwSs2wWDoR
X-Proofpoint-ORIG-GUID: df7rZEZntQfbLMuEvI2lAZhstJctZs0y
X-Authority-Analysis: v=2.4 cv=JJQ7s9Kb c=1 sm=1 tr=0 ts=687dec8c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GnHWBbGKwIfp_8QMzc4A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_02,2025-07-21_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=720 impostorscore=0 clxscore=1011 mlxscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507210061

On Sun, Jul 20, 2025 at 11:11:09PM +0200, Halil Pasic wrote:

Hi Halil,

...
> @@ -129,7 +129,9 @@ static int ism_cmd(struct ism_dev *ism, void *cmd)
>  {
>  	struct ism_req_hdr *req = cmd;
>  	struct ism_resp_hdr *resp = cmd;
> +	unsigned long flags;
>  
> +	spin_lock_irqsave(&ism->cmd_lock, flags);

I only found smcd_handle_irq() scheduling a tasklet, but no commands issued.
Do we really need disable interrupts?

>  	__ism_write_cmd(ism, req + 1, sizeof(*req), req->len - sizeof(*req));
>  	__ism_write_cmd(ism, req, 0, sizeof(*req));
>  
> @@ -143,6 +145,7 @@ static int ism_cmd(struct ism_dev *ism, void *cmd)
>  	}
>  	__ism_read_cmd(ism, resp + 1, sizeof(*resp), resp->len - sizeof(*resp));
>  out:
> +	spin_unlock_irqrestore(&ism->cmd_lock, flags);
>  	return resp->ret;
>  }
>  
...

Thanks!
