Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38419757EE
	for <linux-s390@vger.kernel.org>; Mon, 10 Jun 2024 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718033307; cv=none; b=iGZbXAneYeCi0YNQDHxnxe2aLM5K7mg4zClTKKMk2qLyIqcNEEElxAfSOGeTqzKstwVyukCpV/lVK3FpwTNYGkKKQEeQTiQAzoOwMkGyyjQ4oX27Xa1amEzC4tdXVSdl2p7ZxRVyhyynUNV1p8Sx82bJAJJMSpZWMyjH7Bfv5YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718033307; c=relaxed/simple;
	bh=REavA+9qwQCksGNRC4cky+85H2qlYJLMCFR36VDKq6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNXZ2dPADaHVE1wZNwMWwonvZgg+dviSFYV0OrvY+4OxLvewBYfIinOwaAQxG3ejoIGNRW4C71yc23SDW3aewmdeNINbZlO5wCSJHSA/j3WsmET2nPuzHQftl7mifwcEPBIm1ivuRN3o52G/QPZzzeUs5oqvtl9/b+nxO9kjL38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=r7/VpHBT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r7/VpHBT"
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ADRAk4007811
	for <linux-s390@vger.kernel.org>; Mon, 10 Jun 2024 15:28:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=l/CXmdQGnauQ0sAUq5GDPmNOXQg
	XTo1rzOjyOmjJwVc=; b=r7/VpHBTx2Nrer84gwJOtJVALj7XWK3vRku+ejkJpNW
	psTU0rNmNJSu2iTlbMU6osbmm5czhA9gl0w41hRJPiWDRxDGByquFOqGthLKEthT
	WUu/v7lMCwpKrTWVyS8Y6W4qQNhO0OPY7Ixn93RbhBFJ0k+Akbob8YdQr/Ewu9+h
	b9M/ssRO16F8M/koQ5rCCW1L3j0Kxaj/qO8ltQapOn9HziiaTSl6oJzW/AEQ0X+N
	N0bNcJJQ/714NQEy7YAJy1z2x7gBkC6R4G7T2rXZJo5uKPhPYO7bbb/hM9oZxPDW
	Ptco/MBcGwaqjOV34jLWbdNiFd3Q9VfMj7V2W/Ir9zg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yp1y50fh9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 10 Jun 2024 15:28:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45ADb6rk027209
	for <linux-s390@vger.kernel.org>; Mon, 10 Jun 2024 15:28:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yn210gda1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 10 Jun 2024 15:28:24 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45AFSIM022872520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Jun 2024 15:28:20 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 588C42004F;
	Mon, 10 Jun 2024 15:28:18 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0699220043;
	Mon, 10 Jun 2024 15:28:18 +0000 (GMT)
Received: from osiris (unknown [9.179.30.137])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 10 Jun 2024 15:28:17 +0000 (GMT)
Date: Mon, 10 Jun 2024 17:28:16 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/sclp: define commands for storage (un)assignment
Message-ID: <20240610152816.20549-C-hca@linux.ibm.com>
References: <20240610151048.2548428-1-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610151048.2548428-1-agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jLbl30xGj4df4JAPhg8feht2VOUF5uwr
X-Proofpoint-GUID: jLbl30xGj4df4JAPhg8feht2VOUF5uwr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_02,2024-06-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxlogscore=635 impostorscore=0 adultscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406100117

On Mon, Jun 10, 2024 at 05:10:48PM +0200, Alexander Gordeev wrote:
> Replace immediate values with SCLP_CMDW_UN|ASSIGN_STORAGE defines.
> 
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  drivers/s390/char/sclp_cmd.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Acked-by: Heiko Carstens <hca@linux.ibm.com>
