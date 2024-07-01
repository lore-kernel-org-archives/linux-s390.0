Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B3B14B970;
	Mon,  1 Jul 2024 10:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719831505; cv=none; b=bmRQ8CNcSXLnUwH1aTjZyOGvaNTAE6oqJ8HGVY2tgicOFHa4grQLrCPzpx4Y7wz8CTXDHo1gbttyzOchuwsPtCYfgH/BFSn+ZhWeo80VA/Bs78aTrG4v4TjJKZNX7RTtcCwj2U1ZHqdiAloUImg0WTGUcEuI/3rJmDHR58HTSYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719831505; c=relaxed/simple;
	bh=qfmjcgXwXL9ej5UsHYaaLGC4iEOatC7wQkbgxNZII50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k0ZGDRta0qcWcuAC8SeCo5RghVXIxbaP4lXAXa+RNdrhyB/xogAxWOjUcZHx4wOLukdQYJsmwapuoUBFVkgdQ/D2cR7E3Ht3iYMitEGL9WhSsZV7Nn9VfUypw7+wNoKY7UOoEvQIuof8FmuBMvpgWIOfTShkYLuuu1bDeWvXIh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nFlUdJ5X; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nFlUdJ5X"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461AvZWj023589;
	Mon, 1 Jul 2024 10:58:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=q
	fmjcgXwXL9ej5UsHYaaLGC4iEOatC7wQkbgxNZII50=; b=nFlUdJ5XypgfCuyC1
	EsBU2zf8UfzPGnr2+cotqzU3GdzhFF8jnJY1UIoVvWv+bFRb19Nlz819kVRyU4iq
	QSfzJvSSNZcGAt8KftOWYu+nUXpLYcUNiP4/W/CMljdm3nkpoaUbu9pF1Q72bIWA
	KnLiFGGZKpYif1FHLVMUMNt/dB2mb+9qx4Vk+dSlI5uxjCzMcfUgr9XMzTaxiTVW
	KsT8kT6hmbLo54e/Pi7zA7EFN7oXpKT83M4ymCDUAEOGcqpX+qVkz4IYvMUeP2t3
	YRSzvVohLn/3JygS39LM+IdkDO5BSa+4c7FmHyghHdKsMmdT4Xo2XMmssRRlSuz0
	wUmuQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 403u5m8044-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 10:58:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4619Vf4x024114;
	Mon, 1 Jul 2024 10:58:19 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 402ya36dym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 10:58:19 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 461AwFmL48235226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jul 2024 10:58:17 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A969558055;
	Mon,  1 Jul 2024 10:58:15 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AC8B58067;
	Mon,  1 Jul 2024 10:58:13 +0000 (GMT)
Received: from [9.171.47.124] (unknown [9.171.47.124])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jul 2024 10:58:13 +0000 (GMT)
Message-ID: <c41c53e4-aa6d-47b7-b928-0c1b9e8dcdc3@linux.ibm.com>
Date: Mon, 1 Jul 2024 12:58:12 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/dasd: fix error checks in dasd_copy_pair_store()
To: =?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>, linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>, Heiko Carstens
 <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>,
        open list <linux-kernel@vger.kernel.org>
References: <20240527135044.27427-1-clopez@suse.de>
Content-Language: en-US
From: Stefan Haberland <sth@linux.ibm.com>
In-Reply-To: <20240527135044.27427-1-clopez@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dPZozCrxvg7Nfru8mf_1pc7X9RORArOe
X-Proofpoint-ORIG-GUID: dPZozCrxvg7Nfru8mf_1pc7X9RORArOe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_08,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=842
 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407010080

Am 27.05.24 um 15:50 schrieb Carlos López:
> dasd_add_busid() can return an error via ERR_PTR() if an allocation
> fails. However, two callsites in dasd_copy_pair_store() do not check
> the result, potentially resulting in a NULL pointer dereference. Fix
> this by checking the result with IS_ERR() and returning the error up
> the stack.
>
> Fixes: a91ff09d39f9b ("s390/dasd: add copy pair setup")
> Signed-off-by: Carlos López <clopez@suse.de>
> ---

Applied, thanks.

